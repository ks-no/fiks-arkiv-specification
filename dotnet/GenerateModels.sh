#!/bin/bash

GENERATOR_PATH=KS.Fiks.Arkiv.XsdModelGenerator
GENERATOR_SCHEMA_PATH=$GENERATOR_PATH/Schema
MODELS_PATH=KS.Fiks.Arkiv.Models/Schema
SCHEMA_PATH=../Schema/V1

#Copy to output
cp -r $SCHEMA_PATH $MODELS_PATH
cp -r $SCHEMA_PATH $GENERATOR_SCHEMA_PATH
cd $GENERATOR_PATH

#Generate models
dotnet run