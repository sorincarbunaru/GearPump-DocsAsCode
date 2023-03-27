cp -rf scripts/validate-check-completeness/scriptinglicensekey.txt  bin/oxygen/scriptinglicensekey.txt

rm -rf bin/tmp-vcc/
mkdir -p bin/tmp-vcc/

echo "Validate and check for completeness"

dir=$(pwd)
echo "The current working directory is: $dir."

sh bin/oxygen/scripts/validateCheckDITA.sh \
    # The input DITA map
    -i $dir/dita_sources/gear-pump.ditamap \
    # Settings file - can be exported from Oxygen's GUI; see https://www.oxygenxml.com/doc/ug-editor/topics/dita-map-validate.html#dita-map-validate__dlentry_byl_dgk_54b
    -s $dir/scripts/validate-check-completeness/validate-check-completeness-options.xml \
    # The report file
    -r $dir/bin/tmp-vcc/vcc-result.xml

echo "-- VALIDATION RESULTS --"
cat bin/tmp-vcc/vcc-result.xml

echo "Convert to JSON"
java -cp bin/saxon9.jar net.sf.saxon.Transform -s:bin/tmp-vcc/vcc-result.xml -xsl:scripts/validate-check-completeness/validatation-results-to-sonar.xsl > bin/tmp-vcc/vcc-result-sonar.json

echo "-- VALIDATION RESULTS AS JSON --"
cat bin/tmp-vcc/vcc-result-sonar.json
