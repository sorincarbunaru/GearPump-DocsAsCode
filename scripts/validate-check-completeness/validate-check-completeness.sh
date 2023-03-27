cp -rf scripts/validate-check-completeness/scriptinglicensekey.txt  bin/oxygen/scriptinglicensekey.txt

rm -rf bin/tmp-vcc/
mkdir -p bin/tmp-vcc/

echo "Validate and check for completeness"

dir=$(pwd)
echo "The current working directory is: $dir."

# sh validateCheckDITA.sh -i inputFile [-c contextId] [ [-s settingsFile] | [-r reportFile]] | [--help | -help | --h | -h]
#
# -i inputFile    = The main input DITA map or DITA-OT project file.
#
# -c contextId    = The id of the context from the DITA-OT project being checked.
#                   If not specified, the operation validates all contexts from the DITA-OT project input file.
#                   This argument is ignored if the input file is a DITA map.
#
# -s settingsFile = The configuration file.
#                   It contains the settings exported from the 'DITA Map Completeness Check' dialog box.
#                   If not specified, the operation runs with the default settings.
#
# -r reportFile   = The location of the output validation and check for completeness report.
#                   If not specified, the report is displayed in the console.
sh bin/oxygen/scripts/validateCheckDITA.sh \
    -i $dir/dita_sources/gear-pump.ditamap \
    -s $dir/scripts/validate-check-completeness/validate-check-completeness-options.xml \
    #-r $dir/bin/tmp-vcc/vcc-result.xml

echo "-- VALIDATION RESULTS --"
cat bin/tmp-vcc/vcc-result.xml

echo "Convert to JSON"
java -cp bin/saxon9.jar net.sf.saxon.Transform -s:bin/tmp-vcc/vcc-result.xml -xsl:scripts/validate-check-completeness/validatation-results-to-sonar.xsl > bin/tmp-vcc/vcc-result-sonar.json

echo "-- VALIDATION RESULTS AS JSON --"
cat bin/tmp-vcc/vcc-result-sonar.json
