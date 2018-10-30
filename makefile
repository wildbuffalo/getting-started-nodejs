sonar:
	docker run merrillcorp-dealworks.jfrog.io/tools/sonar_scanner:latest sonar-scanner -X -Dsonar.sources=. -Dsonar.projectKey=dealworks_tryout -Dsonar.host.url=https://sonarqube.devtools.merrillcorp.com -Dsonar.typescript.lcov.reportPaths=coverage/lcov.info \
	-Dsonar.sourceEncoding=UTF-8 \
	-Dsonar.exclusions='node_modules/**, **/*.js,**/*.js.map, **/shared/mocks.**, **/*.spec.ts, apps/**/*.ts' \
	-Dsonar.login=e03e12ee1d512bad5b1a5893d24e2827dcbfeaa4 

