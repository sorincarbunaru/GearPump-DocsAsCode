cp -rf scripts/validate-check-completeness/scriptinglicensekey.txt  bin/oxygen/scriptinglicensekey.txt

rm -rf bin/tmp-vcc/
mkdir -p bin/tmp-vcc/

echo "Validate and check for completeness"

dir=$(pwd)
echo "The current working directory is: $dir."

sh bin/oxygen/scripts/validateCheckDITA.sh \
    -i $dir/dita_sources/gear-pump.ditamap \
    -s $dir/scripts/validate-check-completeness/validate-check-completeness-options.xml \
    -r $dir/bin/tmp-vcc/vcc-result.xml

echo "-- VALIDATION RESULTS --"
cat bin/tmp-vcc/vcc-result.xml

echo "Convert to JSON"
java -cp bin/saxon9.jar net.sf.saxon.Transform -s:bin/tmp-vcc/vcc-result.xml -xsl:scripts/validate-check-completeness/validatation-results-to-sonar.xsl > bin/tmp-vcc/vcc-result-sonar.json

echo "-- VALIDATION RESULTS AS JSON --"
cat bin/tmp-vcc/vcc-result-sonar.json
