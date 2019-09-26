# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools"
HOMEPAGE="https://pypi.org/project/azure-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="+acr +acs +advisor +ams +appservice +backup +batch +billing \
	+bot +cdn +cloud +cognitiveservices +consumption +container +cosmosdb \
	+dla +dls +dms +eventgrid +eventhubs extension +feedback find +hdinsight \
	interactive +iot +iotcentral +keyvault +kusto +lab +maps +monitor \
	+network +policyinsights +rdbms +redis +relay +reservations +resource \
	+role +search +security +servicebus +sf +signalr +sql +sqlvm +storage +vm"

OBSOLETE="!dev-python/azure-cli-batchai
	!!dev-python/azure-cli-acr
	!!dev-python/azure-cli-acs
	!!dev-python/azure-cli-advisor
	!!dev-python/azure-cli-ams
	!!dev-python/azure-cli-appservice
	!!dev-python/azure-cli-backup
	!!dev-python/azure-cli-batch
	!!dev-python/azure-cli-billing
	!!dev-python/azure-cli-botservice
	!!dev-python/azure-cli-cdn
	!!dev-python/azure-cli-cloud
	!!dev-python/azure-cli-configure
	!!dev-python/azure-cli-container
	!!dev-python/azure-cli-cognitiveservices
	!!dev-python/azure-cli-consumption
	!!dev-python/azure-cli-cosmosdb
	!!dev-python/azure-cli-dla
	!!dev-python/azure-cli-dls
	!!dev-python/azure-cli-dms
	!!dev-python/azure-cli-eventgrid
	!!dev-python/azure-cli-eventhubs
	!!dev-python/azure-cli-extension
	!!dev-python/azure-cli-feedback
	!!dev-python/azure-cli-find
	!!dev-python/azure-cli-hdinsight
	!!dev-python/azure-cli-interactive
	!!dev-python/azure-cli-iot
	!!dev-python/azure-cli-iotcentral
	!!dev-python/azure-cli-keyvault
	!!dev-python/azure-cli-kusto
	!!dev-python/azure-cli-lab
	!!dev-python/azure-cli-maps
	!!dev-python/azure-cli-monitor
	!!dev-python/azure-cli-network
	!!dev-python/azure-cli-nspkg
	!!dev-python/azure-cli-policyinsights
	!!dev-python/azure-cli-profile
	!!dev-python/azure-cli-rdbms
	!!dev-python/azure-cli-redis
	!!dev-python/azure-cli-relay
	!!dev-python/azure-cli-reservations
	!!dev-python/azure-cli-resource
	!!dev-python/azure-cli-role
	!!dev-python/azure-cli-search
	!!dev-python/azure-cli-security
	!!dev-python/azure-cli-servicebus
	!!dev-python/azure-cli-servicefabric
	!!dev-python/azure-cli-signalr
	!!dev-python/azure-cli-sql
	!!dev-python/azure-cli-sqlvm
	!!dev-python/azure-cli-storage
	!!dev-python/azure-cli-vm"

CLI_DEPEND="
	acr? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-storage-blob-2.0.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerregistry-3.0.0_rc5[${PYTHON_USEDEP}]
	)
	acs? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.60.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerservice-7.0.0[${PYTHON_USEDEP}]
		dev-python/scp[${PYTHON_USEDEP}]
		dev-python/sshtunnel[${PYTHON_USEDEP}]
	)
	advisor? (
		>=dev-python/azure-mgmt-advisor-2.0.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-media-1.1.1[${PYTHON_USEDEP}]
	)
	ams? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-media-1.1.1[${PYTHON_USEDEP}]
	)
	appservice? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-functions-devops-build-0.0.22[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-applicationinsights-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerregistry-3.0.0_rc5[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-web-0.42.0[${PYTHON_USEDEP}]
		dev-python/fabric:2[${PYTHON_USEDEP}]
		>=dev-python/urllib3-1.18[${PYTHON_USEDEP}]
		dev-python/vsts-cd-manager[${PYTHON_USEDEP}]
		dev-python/xmltodict[${PYTHON_USEDEP}]
	)
	backup? (
		>=dev-python/azure-mgmt-recoveryservices-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-recoveryservicesbackup-0.4.0[${PYTHON_USEDEP}]
	)
	batch? (
		>=dev-python/azure-batch-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-batch-7.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-2.0.0[${PYTHON_USEDEP}]
	)
	billing? (
		>=dev-python/azure-mgmt-billing-0.2.0[${PYTHON_USEDEP}]
	)
	bot? (
		>=dev-python/azure-mgmt-botservice-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-web-0.42.0[${PYTHON_USEDEP}]
	)
	cdn? (
		>=dev-python/azure-mgmt-cdn-3.1.0[${PYTHON_USEDEP}]
	)
	container? (
		>=dev-python/azure-mgmt-authorization-0.60.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-containerinstance-1.5.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-loganalytics-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-4.0.0[${PYTHON_USEDEP}]
		dev-python/websocket-client[${PYTHON_USEDEP}]
	)
	cognitiveservices? (
		>=dev-python/azure-mgmt-cognitiveservices-5.0.0[${PYTHON_USEDEP}]	
	)
	consumption? (
		>=dev-python/azure-mgmt-consumption-2.0.0[${PYTHON_USEDEP}]	
	)
	cosmosdb? (
		>=dev-python/azure-mgmt-cosmosdb-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/pydocumentdb-2.3.3[${PYTHON_USEDEP}]
	)
	dla? (
		>=dev-python/azure-mgmt-datalake-analytics-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-datalake-store-0.5.0[${PYTHON_USEDEP}]
	)
	dls? (
		>=dev-python/azure-datalake-store-0.0.47[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-datalake-store-0.5.0[${PYTHON_USEDEP}]
	)
	dms? (
		>=dev-python/azure-mgmt-datamigration-2.2.0[${PYTHON_USEDEP}]
	)
	eventgrid? (
		>=dev-python/azure-mgmt-eventgrid-2.2.0[${PYTHON_USEDEP}]
	)
	eventhubs? (
		>=dev-python/azure-mgmt-eventhub-3.0.0[${PYTHON_USEDEP}]
	)
	extension? (
		dev-python/wheel[${PYTHON_USEDEP}]
	)
	hdinsight? (
		>=dev-python/azure-mgmt-hdinsight-1.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
	)
	interactive? (
		dev-python/prompt_toolkit[${PYTHON_USEDEP}]
	)
	iot? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-iothub-0.8.2[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-iothubprovisioningservices-0.2.0[${PYTHON_USEDEP}]
	)
	iotcentral? (
		>=dev-python/azure-mgmt-iotcentral-1.0.0[${PYTHON_USEDEP}]
	)
	keyvault? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-2.0.0[${PYTHON_USEDEP}]
	)
	kusto? (
		>=dev-python/azure-mgmt-kusto-0.3.0[${PYTHON_USEDEP}]
	)
	lab? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-devtestlabs-3.0.0[${PYTHON_USEDEP}]
	)
	maps? (
		>=dev-python/azure-mgmt-maps-0.1.0[${PYTHON_USEDEP}]
	)
	monitor? (
		>=dev-python/azure-mgmt-monitor-0.7.0[${PYTHON_USEDEP}]
	)
	network? (
		>=dev-python/azure-mgmt-dns-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-trafficmanager-0.51.0[${PYTHON_USEDEP}]
	)
	policyinsights? (
		>=dev-python/azure-mgmt-policyinsights-0.3.1[${PYTHON_USEDEP}]
	)
	rdbms? (
		>=dev-python/azure-mgmt-rdbms-1.9.0[${PYTHON_USEDEP}]
	)
	redis? (
		>=dev-python/azure-mgmt-redis-6.0.0[${PYTHON_USEDEP}]
	)
	relay? (
		>=dev-python/azure-mgmt-relay-0.2.0[${PYTHON_USEDEP}]
	)
	reservations? (
		>=dev-python/azure-mgmt-reservations-0.3.2[${PYTHON_USEDEP}]
	)
	resource? (
		>=dev-python/azure-mgmt-authorization-0.60.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-managementgroups-0.2.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-resource-4.0.0[${PYTHON_USEDEP}]
	)
	role? (
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.60.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-monitor-0.7.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-msi-1.0.0[${PYTHON_USEDEP}]
		dev-python/pytz[${PYTHON_USEDEP}]
	)
	search? (
		>=dev-python/azure-mgmt-search-2.1.0[${PYTHON_USEDEP}]
	)
	security? (
		>=dev-python/azure-mgmt-security-0.2.0[${PYTHON_USEDEP}]
	)
	servicebus? (
		>=dev-python/azure-mgmt-servicebus-0.6.0[${PYTHON_USEDEP}]
	)
	sf? (
		virtual/python-cffi[${PYTHON_USEDEP}]
		>=dev-python/azure-graphrbac-0.61.1[${PYTHON_USEDEP}]
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-servicefabric-0.3.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
	)
	signalr? (
		>=dev-python/azure-mgmt-signalr-0.3.0[${PYTHON_USEDEP}]
	)
	sql? (
		>=dev-python/azure-mgmt-sql-0.12.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
	)
	sqlvm? (
		>=dev-python/azure-mgmt-sqlvirtualmachine-0.4.0[${PYTHON_USEDEP}]
	)
	storage? (
		>=dev-python/azure-multiapi-storage-0.2.4[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-storage-4.0.0[${PYTHON_USEDEP}]
	)
	vm? (
		>=dev-python/azure-keyvault-1.1.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-authorization-0.60.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-compute-8.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-keyvault-2.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-marketplaceordering-0.2.1[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-msi-1.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-mgmt-network-4.0.0[${PYTHON_USEDEP}]
		>=dev-python/azure-multiapi-storage-0.2.4[${PYTHON_USEDEP}]
	)"

RDEPEND="${CLI_DEPEND}
	~dev-python/azure-cli-core-2.0.74[${PYTHON_USEDEP}]"

DEPEND="${OBSOLETE}
	${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	rm az.bat || die
	sed -i -e '/az.bat/ d' setup.py || die
}

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	use acr || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/acr" || die
	use acs || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/acs" || die
	use advisor || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/advisor" || die
	use ams || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/ams" || die
	use appservice || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/appservice" || die
	use backup || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/backup" || die
	use batch || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/batch" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/batchai" || die
	use billing || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/billing" || die
	use bot || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/botservice" || die
	use cdn || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cdn" || die
	use cloud || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cloud" || die
	use cognitiveservices || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cognitiveservices" || die
	use consumption || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/consumption" || die
	use container || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/container" || die
	use cosmosdb || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cosmosdb" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/deploymentmanager" || die
	use dla || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dla" || die
	use dls || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dls" || die
	use dms || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dms" || die
	use eventgrid || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/eventgrid" || die
	use eventhubs || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/eventhubs" || die
	use extension || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/extension" || die
	use feedback || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/feedback" || die
	use find || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/find" || die
	use hdinsight || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/hdinsight" || die
	use interactive || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/interactive" || die
	use iot || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/iot" || die
	use iotcentral || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/iotcentral" || die
	use keyvault || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/keyvault" || die
	use kusto || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/kusto" || die
	use lab || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/lab" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/managedservices" || die
	use maps || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/maps" || die
	use monitor || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/monitor" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/natgateway" || die
	use network || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/network" || die
	use policyinsights || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/policyinsights" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/privatedns" || die
	use rdbms || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/rdbms" || die
	use redis || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/redis" || die
	use relay || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/relay" || die
	use reservations || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/reservations" || die
	use resource || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/resource" || die
	use role || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/role" || die
	use search || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/search" || die
	use security || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/security" || die
	use servicebus || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/servicebus" || die
	use sf || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/servicefabric" || die
	use signalr || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/signalr" || die
	use sql || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/sql" || die
	use sqlvm || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/sqlvm" || die
	use storage || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/storage" || die
	use vm || rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/vm" || die
}
