#!/usr/bin/env rdmd
// Programmed in the D language
// Fredrik Boulund 2015-09-09

import std.stdio;
import std.array;
import std.conv;
import std.algorithm;
import std.typecons;
import std.datetime; 


struct Hit 
{
    string target;
    float pid;
    int matches, mismatches, gaps, qstart, qstop, tstart, tstop;
    double evalue, bitscore;
}


void custom_parse(string filename)
{
    float min_identity = 90.0;
    int min_matches = 10;
    Hit[][string] hitlists;

    foreach (record; filename
                     .File
                     .byLine
                     .map!split
                     .filter!(l => l[2].to!float >= min_identity && 
                                   l[3].to!int >= min_matches))
    {
        hitlists[record[0].to!string] ~= Hit(record[1].to!string,
                                             record[2].to!float,
                                             record[3].to!int,
                                             record[4].to!int,
                                             record[5].to!int,
                                             record[6].to!int,
                                             record[7].to!int,
                                             record[8].to!int,
                                             record[9].to!int,
                                             record[10].to!double,
                                             record[11].to!double);
    }

    foreach (query, hitlist; hitlists)
    {
        float max_pid = reduce!((a,b) => max(a, b.pid))(-double.max, hitlist);
        float max_pid_diff = 5.00;
        hitlists[query] = hitlist.filter!(h => h.pid >= (max_pid - max_pid_diff)).array();
        writeln(query, ": ", hitlists[query].length);
    }
}



void main(string[] args)
{
    auto filename = "blat.blast8";
    custom_parse(filename);
}

