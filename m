Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013042.outbound.protection.outlook.com [52.101.127.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE1F3C109C;
	Fri, 31 Jul 2026 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484159; cv=fail; b=eu1lpVOWP9UhZcbsYDgauZGPAericxquG4ZaP423KkqlhMPpcImAsnwHQFHCtynsyekCKym5FRo/ZMxWY7VkmhSEyjhnqVLFzVud+G/yvsamxUfz6Jtv3UoIjDpginwJ836qI2QzteUPiZw+zw3ABdUoLzw8yhcy65bp5GNCYaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484159; c=relaxed/simple;
	bh=phHW4qELTq8K2ELwTrfQnZ7pq5ch8E/VgEiZSvYHCV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bszyz5UffZ1K71hfQT25OoJqGjYPN1hijffk7ySXnF6DSsIuuFwFa1Z0WkHo7TUgEMnx2TZk057achLMk4ZLlh1afiEsz39FXiUKXRSSWozbsm6TPne7hm7tYbhv4COxMcfGCiMEYo6IQP7zm3YNfNmz/V/nLkySAd7PRnmoXRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Qe2g061Y; arc=fail smtp.client-ip=52.101.127.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Qe2g061Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uy6WEKbLFx068kK4fXSdJDE7YMDZpUJ2n+eX8UzRqCI5nRn6igENNnjKmRobHNQHKyTd2zA0cKiSdorS0FEPr9jqRZfb98o52aA5uNN0CjOA4mPStDUrnRkLKteofPkkT1XPwZf3PiWHIINZj0nO7/N+cLIVxoHzYCFO/d3RaDe9yefGMc0TzDKGgGMSOsBFJ5+BQ3QNsEzGi3O0SLqB00dZ+FVDPEj8VTSbmFZNEZcIkFb7tg8lRCGh9GytxBk3+X83AKoimhpm2Y36h/GEFWiihKl7WT4A2IjxxMI4cHDfNeUBADEWueNKjOzndutQJ9J679va2RdruIUt4+9yZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcXSgF/BtuUHg11cxSwJ6wXH+JSqs5OIhM5Dpk0VqAQ=;
 b=fGDio64VQb3wgSXLyJYNnAw1wnAefHUoqxOeu8TY+LLWkEds3zUCB8ZmTXxrhzhRQ/P6keu9A1dEg73NrW/aB5gTfJTX9Wp42Udr1ABpJqFWaKhTBMYWpde/+/fN6N+3l/NecUQ3tjQ2v7HWJ3da02LZAVCbnkExAyon/FCfPuKZe2aVyHMGiMBfK5PBmbx2SS6JP14vVUBzKI7Wq+Op8jPO53Pm0bqBwkMorFJwbQDDtyWozD+ZmOVPXrBe4lQhjfoxhCIfhbELIIl9lj6UVSkbZppI9IpTjcxc+xmUqWQgdfianXxe6nIsMvXbcVJwg0JfjdvA3liejDeeY/PmCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcXSgF/BtuUHg11cxSwJ6wXH+JSqs5OIhM5Dpk0VqAQ=;
 b=Qe2g061YgkU0wr/dQU7tT2rHnuiFTLB2IUG7JGEIHWbdty+l8dlzriQqEmI67JKh6nub6aDYGnV0pruDCphKuKoDLF3YPVumJA8s0WTB0o1XySetSzrWVl7g+yaL5DRFBGDKBSWlAayLvACsZbTRUgrVhwqVPFh66K7WC3rMxLM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SG2PPF8F9622068.apcprd01.prod.exchangelabs.com
 (2603:1096:f:fff6::439) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:11 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:11 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	EddieSY.Lin@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v5 12/14] serial: 8250: allow UART drivers to override rx_trig_bytes handling
Date: Fri, 31 Jul 2026 15:48:18 +0800
Message-ID: <20260731074820.735619-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
References: <20260731074820.735619-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0051.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SG2PPF8F9622068:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fcec308-6ac3-4e57-254a-08deeed83546
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|23010399003|1800799024|38350700014|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IexVLsDc2WYFNvkiqDg7ljn3rzIdw1c6082CNWYfz+99CNJOZumBu57OMxkDkEChjdXoURw3zC0zi0P+qZUM3wHvathwOuzNBrjmUVlFNKN3zkfwqGtKZf5Iidmj9c5SpbmADlCoL/CuaTgoJLfPTErA8TKSvRXdDgt9KWOREWVriLIrMOL8YHclyMlWNh0SY20lznDx3gkybFxKHMtro3pZDluDwHW05eBY01qBT5h9TV+9+GsgtngqNQQ0U1U4xrQp/3Z8fd8NeCxXZGZWgecWhKT2Me1mi10xD2SFlwee4Nu9rRfcROv27zIKM2h5SL6rcBQ44dEDbHGoIeV8+Z8WZvX9mm98wGLdxpfxXgzsLwOf256lJyvI7dNspLFaQulRcxh5dW/HIFteigGndtwPXwb2QUAXVnSdSfQ5EPrXLPmqXsKti6nhZktCppxWXi6sbSuIJrKylw61G8mdJB+ZVjXK4zequ7YxQHAO4TCOt+xAfSrBrkC4tahl+qDtHmq1+Kdxsd1mRiTKCHTqwev7ou/VdYj1aOlid0o29TFd7LxxErd48C4lYOU5VrsDZC7HTpFsuisrl8OjIBtu/eQvzsEnuU7jAaCPoURpPj72b9UkH8zu/pwFxdo3vjPewRMkmZx4vtgXPEwwJ1UWK+0N9kBm6dH6Ir0SUQaLzsZFR+61ba9Y4dS8L5+JWeY7fr7lJMpaL7kaiVSqmjngAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(23010399003)(1800799024)(38350700014)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i05sWEbeY4vC/tvhviP63w+fNUmiwrdSvokzfWxzsiKonCPzB4n1avgE7jFA?=
 =?us-ascii?Q?eazOAuQcnWMZeytVcdYkwmGPsG/XAg3fyxDmxDKj9zFFInXOFun03OapHCm8?=
 =?us-ascii?Q?jueJ66tA7VAsJjCp51J9E5EdZbzJRySm88tTye4Wt3OTJdGA4bZCWZ3+vPvo?=
 =?us-ascii?Q?nesNwO0+GrY0lu5PWohtO1L79U0+N0q9iWK5ULhOv4Q4VF6nisLjCBYgDEIr?=
 =?us-ascii?Q?3pY1bghr9Gzme6LgGbN/asqoaj5MoEAvUtbJkby+YioGZex21EcbW/+52Sd3?=
 =?us-ascii?Q?X3IS2/Z8rhMjRGNnDJj5GCRXK22vt0DxwTFYyeUS28UUnxZFcAzQX+TGF2o7?=
 =?us-ascii?Q?x8sq6jbw5XLsSXjBv2NAdwk67Kvc+ONdM7xcYc1iP98jqCGkn7r0LJeVKtTD?=
 =?us-ascii?Q?GQQhS+nqN6k5rQiuWiXg/efaSweWj6Cj9YdgzzGw6AcLU26/mmmKVG2fGB5C?=
 =?us-ascii?Q?ihiYNxnsIQFDBgTVxDzyQ1ACZY4OLBAMT/aExfUCKeMQkuMtkHmT0Ybj/Zil?=
 =?us-ascii?Q?if9aZqpKsbuKNAFDnan1r+gJD1zwxSvjBGebKeasi8BlyHlj1Z9JUxWniZ34?=
 =?us-ascii?Q?aLN9igBWRxtjJzuV0HFxXVlnSbDg0WoH9l4hyymeWNT1BYe+Qphduxu3C49l?=
 =?us-ascii?Q?7XrHEu6Lp1APtBX0uDb1pzLip/NQ4gfopdCmAiwGRo8heAQQ5Y+gC98pXsRl?=
 =?us-ascii?Q?FGBSsdmGMsowMGVUZ+tAwaio1pdpTPQjZGPcNaQ/5CuK204raLZmxpN1MyZf?=
 =?us-ascii?Q?yANjyC12tPvgErASO6tU2RWWP2FEul2K25gaH6ZAP/DiK2QFmsM3Uj/URcE8?=
 =?us-ascii?Q?ugQEJPmzCR/t5dXydxDL3W21IxzgPbeC2txnFiZjiOM79uOXPc/N+Pg/iAoz?=
 =?us-ascii?Q?boBbu6QXFGakmhRo/wkaI5X9sxGPKh3mzZLWNOR1U9hjBPANwlNYa9BRYW0+?=
 =?us-ascii?Q?eTV+vtt7fYjcQt/QAetcQWOmkppQCTIqfYemm/V+3AoKa1fYP3IKlDgtoSMC?=
 =?us-ascii?Q?cLTMOg72mevRnKGcOmB7P+KYlCINdqoJAWviUHKSyBceq416dEJb6yr5+kb/?=
 =?us-ascii?Q?qMtvT5O6ESdb+Uwi+lvpDz5mckGhkhepegmu+kUtNRqMA2ItmFtgAMAjtG2s?=
 =?us-ascii?Q?GtN7Hp61Z1kptbstTVnau5pKSnHT8Baf5KQQrW30/f8M8Mb843SKDUAZbZRo?=
 =?us-ascii?Q?DvV2XVTMmbu6WE+Hj/hewkBjpsiALDgMUlXkq0/F4L+pKcaxxS4BQYG3A3aw?=
 =?us-ascii?Q?cCH7kwsBsW227zjZBGUxfRwzvRiQWaQL7jZ9g88KqTlKvDx/dDLwta4Lj/Q2?=
 =?us-ascii?Q?Z1gitUioYLqeEuL2GQ56YdpLSf/dEMVGh5VV8HNDflNdToBcwuWDjXYxh9Km?=
 =?us-ascii?Q?b9ULE3CumXN1M0zgTctfPNzGyPDbggvW9uJCOCbxjAIGn9QLKP5DuCBkI6Aw?=
 =?us-ascii?Q?mY2TnOWADauTGqZ82G1H/n1duWN088vbF0i9lZQkHFnQHZj5pdOe8dFCTm+3?=
 =?us-ascii?Q?p8rOGEyJUi25owOcAFxxGZPrZVYEXgITu3lDcHfePufYRnT2JEPM7knbXL/M?=
 =?us-ascii?Q?zVmkxBrpVt49exXJDFcVf53C/iMf9jS5LwJKAwp5gWF6q8QYQxLDCJGGvkHN?=
 =?us-ascii?Q?DOhtR+Yo0kMI86p/2SZjpiUbvcSsXVvrAv7wUGZLly4zm1jqQ9bP2BozeZiW?=
 =?us-ascii?Q?8xZPgn7s7isvalIvIkrfUxx/4RiDjiH9SFIWE0z9wskJeFIdVPqMqRAJZ3kc?=
 =?us-ascii?Q?D/mx4MC6OEXPVdJqbZplawGRMi2+ZxI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fcec308-6ac3-4e57-254a-08deeed83546
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:11.0032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WyrMvETEzSIrJ384vHtSFyE+ykd0k3PKF5/3QA+Vb69yPklPteNPb/iR5yKjuhtMt3v3TqZsJqeYmr9Auzj+QURDNvRybsOwUR+oIUbNE+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PPF8F9622068

The rx_trig_bytes sysfs attribute currently relies on 8250-internal
helper functions and assumes a fixed mapping between trigger levels and
FIFO behavior.

Some UARTs provide hardware-specific RX trigger mechanisms that do not
fit this model. Add optional uart_port callbacks for setting and getting
the RX trigger level, and use them when provided, while preserving the
existing 8250 helpers as the default fallback.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_core.c |  4 ++++
 drivers/tty/serial/8250/8250_port.c | 14 ++++++++++++--
 include/linux/serial_core.h         |  2 ++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0a3355eb4bc3..052c0020a860 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -792,6 +792,10 @@ int serial8250_register_8250_port(const struct uart_8250_port *up)
 		uart->port.get_divisor = up->port.get_divisor;
 	if (up->port.set_divisor)
 		uart->port.set_divisor = up->port.set_divisor;
+	if (up->port.get_rxtrig)
+		uart->port.get_rxtrig = up->port.get_rxtrig;
+	if (up->port.set_rxtrig)
+		uart->port.set_rxtrig = up->port.set_rxtrig;
 	if (up->port.startup)
 		uart->port.startup = up->port.startup;
 	if (up->port.shutdown)
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 6325784e5e73..c2b46ef01d2f 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -2999,9 +2999,14 @@ static ssize_t rx_trig_bytes_show(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	int rxtrig_bytes;
 
-	rxtrig_bytes = do_serial8250_get_rxtrig(port);
+	if (uport->get_rxtrig)
+		rxtrig_bytes = uport->get_rxtrig(uport);
+	else
+		rxtrig_bytes = do_serial8250_get_rxtrig(port);
 	if (rxtrig_bytes < 0)
 		return rxtrig_bytes;
 
@@ -3044,6 +3049,8 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct tty_port *port = dev_get_drvdata(dev);
+	struct uart_state *state = container_of(port, struct uart_state, port);
+	struct uart_port *uport = state->uart_port;
 	unsigned char bytes;
 	int ret;
 
@@ -3054,7 +3061,10 @@ static ssize_t rx_trig_bytes_store(struct device *dev,
 	if (ret < 0)
 		return ret;
 
-	ret = do_serial8250_set_rxtrig(port, bytes);
+	if (uport->set_rxtrig)
+		ret = uport->set_rxtrig(uport, bytes);
+	else
+		ret = do_serial8250_set_rxtrig(port, bytes);
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f6ba3e7b09f1..13b0d4117036 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -459,6 +459,8 @@ struct uart_port {
 					       unsigned int baud,
 					       unsigned int quot,
 					       unsigned int quot_frac);
+	int			(*get_rxtrig)(struct uart_port *port);
+	int			(*set_rxtrig)(struct uart_port *port, unsigned char bytes);
 	int			(*startup)(struct uart_port *port);
 	void			(*shutdown)(struct uart_port *port);
 	void			(*throttle)(struct uart_port *port);
-- 
2.45.2

