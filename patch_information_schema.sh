#!/bin/bash

sudo su postgres -c "psql f1db < information_schema_patches.sql"
