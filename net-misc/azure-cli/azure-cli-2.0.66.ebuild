# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{5,6} )

inherit distutils-r1

DESCRIPTION="Microsoft Azure Command-Line Tools"
HOMEPAGE="https://pypi.org/project/azure-cli"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

KEYWORDS="~amd64 ~arm ~x86"
LICENSE="MIT"
SLOT="0"

IUSE="+acr +acs +advisor +ams +appservice +backup +batch +batchai +billing \
	+bot +cdn +cloud +cognitiveservices +consumption +container +cosmosdb \
	+dla +dls +dms +eventgrid +eventhubs extension feedback find +hdinsight \
	interactive +iot +iotcentral +keyvault +kusto +lab +maps +monitor \
	+network +policyinsights +rdbms +redis +relay +reservations +resource \
	+role +search +servicebus +sf +signalr +sql +sqlvm +storage +vm"

RDEPEND="vm? ( >=dev-python/azure-cli-vm-2.2.22[${PYTHON_USEDEP}] )
	sqlvm? ( >=dev-python/azure-cli-sqlvm-0.1.1[${PYTHON_USEDEP}] )
	sql? ( >=dev-python/azure-cli-sql-2.2.4[${PYTHON_USEDEP}] )
	storage? ( >=dev-python/azure-cli-storage-2.4.2[${PYTHON_USEDEP}] )
	signalr? ( >=dev-python/azure-cli-signalr-1.0.0[${PYTHON_USEDEP}] )
	sf? ( >=dev-python/azure-cli-servicefabric-0.1.19[${PYTHON_USEDEP}] )
	servicebus? ( >=dev-python/azure-cli-servicebus-0.3.5[${PYTHON_USEDEP}] )
	search? ( >=dev-python/azure-cli-search-0.1.1[${PYTHON_USEDEP}] )
	role? ( >=dev-python/azure-cli-role-2.6.3[${PYTHON_USEDEP}] )
	resource? ( >=dev-python/azure-cli-resource-2.1.15[${PYTHON_USEDEP}] )
	reservations? ( >=dev-python/azure-cli-reservations-0.4.2[${PYTHON_USEDEP}] )
	relay? ( >=dev-python/azure-cli-relay-0.1.4[${PYTHON_USEDEP}] )
	redis? ( >=dev-python/azure-cli-redis-0.4.3[${PYTHON_USEDEP}] )
	rdbms? ( >=dev-python/azure-cli-rdbms-0.3.9[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-profile-2.1.5[${PYTHON_USEDEP}]
	policyinsights? ( >=dev-python/azure-cli-policyinsights-0.1.3[${PYTHON_USEDEP}] )
	!!dev-python/azure-cli-nspkg[${PYTHON_USEDEP}]
	network? ( >=dev-python/azure-cli-network-2.5.1[${PYTHON_USEDEP}] )
	monitor? ( >=dev-python/azure-cli-monitor-0.2.11[${PYTHON_USEDEP}] )
	maps? ( >=dev-python/azure-cli-maps-0.3.4[${PYTHON_USEDEP}] )
	lab? ( >=dev-python/azure-cli-lab-0.1.7[${PYTHON_USEDEP}] )
	kusto? ( >=dev-python/azure-cli-kusto-0.2.2[${PYTHON_USEDEP}] )
	keyvault? ( >=dev-python/azure-cli-keyvault-2.2.15[${PYTHON_USEDEP}] )
	iotcentral? ( >=dev-python/azure-cli-iotcentral-0.1.6[${PYTHON_USEDEP}] )
	iot? ( >=dev-python/azure-cli-iot-0.3.10[${PYTHON_USEDEP}] )
	interactive? ( >=dev-python/azure-cli-interactive-0.4.4[${PYTHON_USEDEP}] )
	hdinsight? ( >=dev-python/azure-cli-hdinsight-0.3.4[${PYTHON_USEDEP}] )
	find? ( >=dev-python/azure-cli-find-0.3.3[${PYTHON_USEDEP}] )
	feedback? ( >=dev-python/azure-cli-feedback-2.2.1[${PYTHON_USEDEP}] )
	extension? ( >=dev-python/azure-cli-extension-0.2.5[${PYTHON_USEDEP}] )
	eventhubs? ( >=dev-python/azure-cli-eventhubs-0.3.6[${PYTHON_USEDEP}] )
	eventgrid? ( >=dev-python/azure-cli-eventgrid-0.2.3[${PYTHON_USEDEP}] )
	dms? ( >=dev-python/azure-cli-dms-0.1.3[${PYTHON_USEDEP}] )
	dls? ( >=dev-python/azure-cli-dls-0.1.9[${PYTHON_USEDEP}] )
	dla? ( >=dev-python/azure-cli-dla-0.2.5[${PYTHON_USEDEP}] )
	cosmosdb? ( >=dev-python/azure-cli-cosmosdb-0.2.10[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-core-2.0.66[${PYTHON_USEDEP}]
	container? ( >=dev-python/azure-cli-container-0.3.17[${PYTHON_USEDEP}] )
	consumption? ( >=dev-python/azure-cli-consumption-0.4.3[${PYTHON_USEDEP}] )
	>=dev-python/azure-cli-configure-2.0.23[${PYTHON_USEDEP}]
	cognitiveservices? ( >=dev-python/azure-cli-cognitiveservices-0.2.5[${PYTHON_USEDEP}] )
	cloud? ( >=dev-python/azure-cli-cloud-2.1.1[${PYTHON_USEDEP}] )
	cdn? ( >=dev-python/azure-cli-cdn-0.2.3[${PYTHON_USEDEP}] )
	bot? ( >=dev-python/azure-cli-botservice-0.2.1[${PYTHON_USEDEP}] )
	billing? ( >=dev-python/azure-cli-billing-0.2.1[${PYTHON_USEDEP}] )
	batchai? ( >=dev-python/azure-cli-batchai-0.4.9[${PYTHON_USEDEP}] )
	batch? ( >=dev-python/azure-cli-batch-4.0.2[${PYTHON_USEDEP}] )
	backup? ( >=dev-python/azure-cli-backup-1.2.4[${PYTHON_USEDEP}] )
	appservice? ( >=dev-python/azure-cli-appservice-0.2.20[${PYTHON_USEDEP}] )
	ams? ( >=dev-python/azure-cli-ams-0.4.6[${PYTHON_USEDEP}] )
	advisor? ( >=dev-python/azure-cli-advisor-2.0.0[${PYTHON_USEDEP}] )
	acs? ( >=dev-python/azure-cli-acs-2.4.3[${PYTHON_USEDEP}] )
	acr? ( >=dev-python/azure-cli-acr-2.2.8[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

src_prepare() {
	distutils-r1_src_prepare
	rm az.bat || die
	sed -i -e '/az.bat/ d' setup.py || die
}

pkg_postinst() {
	einfo ""
	einfo "This release of azure-cli NO LONGER contains the"
	einfo "Azure Service Managementi legacy client library."
	einfo "For ASM functionalities, please"
	einfo "emerge dev-python/azure-servicemanagement-legacy"
	einfo ""
}
