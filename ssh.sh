#!/usr/bin/env bash
vagrant ssh-config > cfgssh
ssh -F cfgssh $@
