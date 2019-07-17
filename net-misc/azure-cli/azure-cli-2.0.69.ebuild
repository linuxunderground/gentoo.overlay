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
	+dla +dls +dms +eventgrid +eventhubs extension feedback find +hdinsight \
	interactive +iot +iotcentral +keyvault +kusto +lab +maps +monitor \
	+network +policyinsights +rdbms +redis +relay +reservations +resource \
	+role +search +security +servicebus +sf +signalr +sql +sqlvm +storage +vm"

RDEPEND="vm? ( >=dev-python/azure-cli-vm-2.2.23[${PYTHON_USEDEP}] )
	sqlvm? ( >=dev-python/azure-cli-sqlvm-0.2.0[${PYTHON_USEDEP}] )
	sql? ( >=dev-python/azure-cli-sql-2.2.5[${PYTHON_USEDEP}] )
	storage? ( >=dev-python/azure-cli-storage-2.4.3[${PYTHON_USEDEP}] )
	signalr? ( >=dev-python/azure-cli-signalr-1.0.1[${PYTHON_USEDEP}] )
	sf? ( >=dev-python/azure-cli-servicefabric-0.1.20[${PYTHON_USEDEP}] )
	servicebus? ( >=dev-python/azure-cli-servicebus-0.3.6[${PYTHON_USEDEP}] )
	security? ( >=dev-python/azure-cli-security-0.1.2[${PYTHON_USEDEP}] )
	search? ( >=dev-python/azure-cli-search-0.1.2[${PYTHON_USEDEP}] )
	role? ( >=dev-python/azure-cli-role-2.6.4[${PYTHON_USEDEP}] )
	resource? ( >=dev-python/azure-cli-resource-2.1.16[${PYTHON_USEDEP}] )
	reservations? ( >=dev-python/azure-cli-reservations-0.4.3[${PYTHON_USEDEP}] )
	relay? ( >=dev-python/azure-cli-relay-0.1.5[${PYTHON_USEDEP}] )
	redis? ( >=dev-python/azure-cli-redis-0.4.4[${PYTHON_USEDEP}] )
	rdbms? ( >=dev-python/azure-cli-rdbms-0.3.12[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-profile-2.1.5[${PYTHON_USEDEP}]
	policyinsights? ( >=dev-python/azure-cli-policyinsights-0.1.4[${PYTHON_USEDEP}] )
	!!dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]
	network? ( >=dev-python/azure-cli-network-2.5.2[${PYTHON_USEDEP}] )
	monitor? ( >=dev-python/azure-cli-monitor-0.2.15[${PYTHON_USEDEP}] )
	maps? ( >=dev-python/azure-cli-maps-0.3.5[${PYTHON_USEDEP}] )
	lab? ( >=dev-python/azure-cli-lab-0.1.8[${PYTHON_USEDEP}] )
	kusto? ( >=dev-python/azure-cli-kusto-0.2.3[${PYTHON_USEDEP}] )
	keyvault? ( >=dev-python/azure-cli-keyvault-2.2.16[${PYTHON_USEDEP}] )
	iotcentral? ( >=dev-python/azure-cli-iotcentral-0.1.7[${PYTHON_USEDEP}] )
	iot? ( >=dev-python/azure-cli-iot-0.3.11[${PYTHON_USEDEP}] )
	interactive? ( >=dev-python/azure-cli-interactive-0.4.5[${PYTHON_USEDEP}] )
	hdinsight? ( >=dev-python/azure-cli-hdinsight-0.3.5[${PYTHON_USEDEP}] )
	find? ( >=dev-python/azure-cli-find-0.3.4[${PYTHON_USEDEP}] )
	feedback? ( >=dev-python/azure-cli-feedback-2.2.1[${PYTHON_USEDEP}] )
	extension? ( >=dev-python/azure-cli-extension-0.2.5[${PYTHON_USEDEP}] )
	eventhubs? ( >=dev-python/azure-cli-eventhubs-0.3.7[${PYTHON_USEDEP}] )
	eventgrid? ( >=dev-python/azure-cli-eventgrid-0.2.4[${PYTHON_USEDEP}] )
	dms? ( >=dev-python/azure-cli-dms-0.1.4[${PYTHON_USEDEP}] )
	dls? ( >=dev-python/azure-cli-dls-0.1.10[${PYTHON_USEDEP}] )
	dla? ( >=dev-python/azure-cli-dla-0.2.6[${PYTHON_USEDEP}] )
	cosmosdb? ( >=dev-python/azure-cli-cosmosdb-0.2.11[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-core-2.0.69[${PYTHON_USEDEP}]
	container? ( >=dev-python/azure-cli-container-0.3.18[${PYTHON_USEDEP}] )
	consumption? ( >=dev-python/azure-cli-consumption-0.4.4[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-configure-2.0.24[${PYTHON_USEDEP}]
	cognitiveservices? ( >=dev-python/azure-cli-cognitiveservices-0.2.6[${PYTHON_USEDEP}] )
	cloud? ( >=dev-python/azure-cli-cloud-2.1.1[${PYTHON_USEDEP}] )
	cdn? ( >=dev-python/azure-cli-cdn-0.2.4[${PYTHON_USEDEP}] )
	bot? ( >=dev-python/azure-cli-botservice-0.2.2[${PYTHON_USEDEP}] )
	billing? ( >=dev-python/azure-cli-billing-0.2.2[${PYTHON_USEDEP}] )
	batch? ( >=dev-python/azure-cli-batch-4.0.3[${PYTHON_USEDEP}] )
	backup? ( >=dev-python/azure-cli-backup-1.2.5[${PYTHON_USEDEP}] )
	appservice? ( >=dev-python/azure-cli-appservice-0.2.21[${PYTHON_USEDEP}] )
	ams? ( >=dev-python/azure-cli-ams-0.4.7[${PYTHON_USEDEP}] )
	advisor? ( >=dev-python/azure-cli-advisor-2.0.1[${PYTHON_USEDEP}] )
	acs? ( >=dev-python/azure-cli-acs-2.4.4[${PYTHON_USEDEP}] )
	acr? ( >=dev-python/azure-cli-acr-2.2.9[${PYTHON_USEDEP}] )
	!dev-python/azure-cli-batchai"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	rm az.bat || die
	sed -i -e '/az.bat/ d' setup.py || die
}

python_install() {
	distutils-r1_python_install

	python_export PYTHON_SITEDIR

	# Avoid portage file collisions
	# What a mess !
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/acr" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/acs" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/advisor" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/ams" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/appservice" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/backup" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/batch" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/batchai" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/billing" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/botservice" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cdn" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cloud" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cognitiveservices" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/configure" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/consumption" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/container" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/cosmosdb" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/deploymentmanager" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dla" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dls" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/dms" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/eventgrid" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/eventhubs" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/extension" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/feedback" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/find" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/hdinsight" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/interactive" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/iot" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/iotcentral" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/keyvault" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/kusto" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/lab" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/managedservices" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/maps" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/monitor" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/natgateway" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/network" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/policyinsights" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/privatedns" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/profile" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/rdbms" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/redis" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/relay" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/reservations" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/resource" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/role" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/search" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/security" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/servicebus" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/servicefabric" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/signalr" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/sql" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/sqlvm" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/storage" || die
	rm -r "${ED}${PYTHON_SITEDIR}/azure/cli/command_modules/vm" || die
}

pkg_postinst() {
	einfo ""
	einfo "This release of azure-cli NO LONGER contains the"
	einfo "Azure Service Managementi legacy client library."
	einfo "For ASM functionalities, please"
	einfo "emerge dev-python/azure-servicemanagement-legacy"
	einfo ""
}
