Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012063.outbound.protection.outlook.com [52.101.126.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76843AFB19;
	Wed, 29 Jul 2026 06:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785305208; cv=fail; b=H2rRE1mny/xpdUa5VW7q5WAoeIg7QJoRf0a9KztaYjDSBj3g9kL5X8Qs66mXF/HxaRQ/GQcBZ8rJBB5cpHDnbMEkwlpTRI2cMqj373kNTV/JyU3BsarV9KK2Q0WOjuLKHgbkvdmVbnog3S8QKI5sm+AAYv4lKfTxZwyr5UFds+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785305208; c=relaxed/simple;
	bh=phHW4qELTq8K2ELwTrfQnZ7pq5ch8E/VgEiZSvYHCV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aVe/EnjF/kJHci2KUCuGOCNACUPQSrIZQMQIrLjJmyaFYwhC54j8dfJauaGMLXKMJq5yyHg8vFZkwZO1+5s+x3abPHVxsqmineV+cJwDQ3eOxjZCXvcWfr7xpZuLN2OP1ETj9kGd5oTocT4fcD8Zx6NdcaGtv9l3wkzqFxju2wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=BaRoQZ9d; arc=fail smtp.client-ip=52.101.126.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="BaRoQZ9d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XXkEbQNI5V62yE8//ap/XHfLwk4yOCYZ4wXORFrg045Ari/NcqOsxp9IwA3kwnqeMbkLG57ie/p1uDShMNCrRDf/odWXkxhJ8dGUXSf48mTUizVpPtuahx4nDAhyI9YYP7ZxaikuWbwo4yfvQzDDmf0gvts/FQ9bdqU4LC/SFoxn15fx6liEkxbt2pASQTYaYydWA76hdZM/yk6tIN0cf80tECRZTMZjxoO7YQm5VkilDCoiN/yFR0cdS5BJhQg8yDkYfDJ2YAnNPbrVSW6XwVGx1nuOpkHRpKxeReOaa8+CyYIChWdYPiwbJckG563jHVufNX1XtKOPHKUMG9LfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcXSgF/BtuUHg11cxSwJ6wXH+JSqs5OIhM5Dpk0VqAQ=;
 b=KZSPHCghKrWJOOK0QGbL6aX57Dp8Sz2bkXmjvIqongch9dG/x4f54Unviiy5zTxDoUNoa4lgwRPWAiPoDNncuRNZZOH2hHeauu7x8TWCxgAUZxuDE9jEiiRY9+NVt8lNiwOgv4BkFR07jDIjORS9kNoRWshnji4L5DiLabix4SSQ/ohuzk3OitHqIwenI8IL6GgiZ7z9Jkg/WMDltFaPqoFGNWmV3nHrc1l3II6H21X3+L0z7NtqsgfbJaYChPAByLeOdYtT/8y1SteJ5aJORwzf/vYVOPa66nH5sqVUCybqT4yatfKso6rb5UqT8cmH21h1nZYVb5HVVCjlMKkq+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcXSgF/BtuUHg11cxSwJ6wXH+JSqs5OIhM5Dpk0VqAQ=;
 b=BaRoQZ9d3ftbB0byVJvTT5r5E1sI3BsdziGD6XXMxY+wR5TLUBkujdcikqK7m8fT1eigip4EwZfsXxP/sEjKdlxleVBzfr8ikrATLJK9AUPADtRosUSXiiYI1hugVpC6QDND5Qy0rvDxUMBlWMLkmDO1tic50Iv/+DXVVAbH3Cw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEL0PF4D55A38B9.apcprd01.prod.exchangelabs.com
 (2603:1096:108:1::59b) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:06:33 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0245.012; Wed, 29 Jul 2026
 06:06:33 +0000
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
Subject: [PATCH v4 12/14] serial: 8250: allow UART drivers to override rx_trig_bytes handling
Date: Wed, 29 Jul 2026 14:06:00 +0800
Message-ID: <20260729060602.492430-13-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
References: <20260729060602.492430-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::10) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEL0PF4D55A38B9:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0f8c1e-581f-4423-ff10-08deed378a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|23010399003|38350700014|18002099003|22082099003|6133799003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	2BGvI9pk7UH/KkW01oSijxJ5H0Z2Hyj9sAjKrW+OZ/29Ek/q0d2/+Jdxtb6ADoOkmxhooMeF8QKFKhsdoAYuGGV4coJPHB/u/UTvLIk/qT8TcA0oNRU4v2mYG8oIhuDzjuGp96O5QJ5BZWlySxB3EzDqTlIGR5ICS8sGM8mRhtUdAoEsBOoe/TTI5hCnEyy4i8/tuPldLOe4IKYbYEmsgA7Jl1U+3FlHeU+lI9Xgyg6bpDVogYuhaRDiZEL56/B52pLoQtcqgLIxSPe4VXclvAePSVIaRlGC3MgHYXFktpmJ3tFGpY557fkUsINdUJtxttWBB3Hzp6r0qPp9EqlVSZA6TTcXs5Es7OTuHl52X9fCsApyOjvVuU4p5RyalfXoaNBAq1rjwBd+ZdMmF54kavLJg+ucWeOhtCYYu8MW8nenqn2qtIFwMp7AUZFj2d7DlmOM/F39GVuuxI5IjULLwBblVJXZpS30kUzP/aKy3vnz73f/aaim9FC8GpAIBrUPn0Uv2Y3E0HjMDZPwjJAxp/sIXuCSOodOczqaHMYHWE0E6Q0J+ZTEiBmi/vQwhTrnB552+vydIkGDSCQHWJnJbToZe0ql0o8e/duh/ZyreKXccm0krzkjMOxMPM5LwizZoNzttpNIK+lXRmQ3zhTt2OyfIthtVM+OMMVs/RIDVNVoNQU5oBen0Ydq60KLpmCWmzsxdgMEwF/Tvdln1+hk2g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(23010399003)(38350700014)(18002099003)(22082099003)(6133799003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1u7Oehzl1Vd66HdDRrhUVFQv3UtxOnndyflZUsG7zcF6nrcJcGg5HcdtP7yO?=
 =?us-ascii?Q?TsIqYSbi9U4ROenbF8obZGbmYodjdpVu7ncoh41w7jDX+5tuESxDxHct7w3a?=
 =?us-ascii?Q?Qkd+ZLTevSiEMySjmQPlNnVPTgJ+bwt6krRQ1b0dNq/IkCMWYsTGqbQsXTWy?=
 =?us-ascii?Q?/FNmPDH6RCAxuJdoULlr5vrhx1LFHKpSWENPxWd5m5NRhXpkKXeuChHQ7Sp6?=
 =?us-ascii?Q?RnPIVTxCf72O2KGEaT0KgV8Y3QasIstePMEQXar0ZTEtaj5WJs3xADFUNi04?=
 =?us-ascii?Q?dGeUHtqWohV4KHutpE2+NoANqYaoWgdaD6zbLTAT/hlomnUVZpNUlTFUupMi?=
 =?us-ascii?Q?eHrxmL84lqDuAx7QpfezpYIeVNrr81czmHqjU+HtmQOYwSLWLuxLNwaBFo1m?=
 =?us-ascii?Q?HLt7LPCie/E2oyTFR2d36FDehZxt+upURmrervGYTILyzHl+abFh98VVdFdJ?=
 =?us-ascii?Q?0ZE6pKy3BysN0EXAztLwoNflj6cEDKg3QIZoKaVxWk1IYjZFJEvKX654Sa0/?=
 =?us-ascii?Q?oWZ+Qu9ikG1TtibX8Pzz6uW6PBhRSd1I0M4tD9OMJNpHX1zY+wYvbCf4Ty0h?=
 =?us-ascii?Q?8COqISzy9oxuM/vJeb9souR+D4JAnY5nstdcxa36jSzPLOukWFJ5sjPJsHg6?=
 =?us-ascii?Q?CDL2qOx5Uk3s0ABuoiSx+TfEnTtSe+8o9tlxM6Giy8A3+6vOZ2XfiIhMGVSk?=
 =?us-ascii?Q?WtNpQJNYrZPHSQKpXEjTwc/QamhofPCMbVZh0qgD9GlMP0gJo3s51qFq5Sm7?=
 =?us-ascii?Q?KDse5g22pmkiCs4nCOsAsGVTEpxf+QU0GL9TM5G9mdPASYVc6jON7kBEefoG?=
 =?us-ascii?Q?m9RaMLwCZZwcJWnnfXr/gxP9Jv+PsrDA/jQ2kYaZS/b6hgHu/WdUw8kJxE9T?=
 =?us-ascii?Q?6ZuIfA7oNcXyDPoW5IlNdl5fYvutbNFXlpwBTHLpJM9rHQQu4oGiYRgTDiA8?=
 =?us-ascii?Q?yN+oDuy+frnsQuh7y7FhbZwJ3XT1LW2845/ZE2tMbJ2gERCffC+1FRyT+yGt?=
 =?us-ascii?Q?aoIyLe/cjqI+E8Z67RW1jS8d7wyiYr2bmULdX01+R1AHUpjD0NjaZU6mIP3s?=
 =?us-ascii?Q?VPC+dJxXmF62By+Gec9rTiT83AmAWynK4MNRe0veIECKBkHBBMZByT85f/85?=
 =?us-ascii?Q?9ls20fsJAcwz2E+HkeTi6ffDy2cBqhTYeRpz69f6PpesUa7iOLBPXR4Xfx11?=
 =?us-ascii?Q?mZ+NCrE9QBkgOdLhQqQteOyn6Vk4m3Na7N7b9MKrGV0cXdTA4VqOXjwUEaMj?=
 =?us-ascii?Q?vbKNmN7CtGKUucmcRMtejWp7DgfKayJEWlh/JXieuxKlSXpZGtMHcnV3TMYq?=
 =?us-ascii?Q?QIzn0lGomR39qi4IIHYbJMwrmBQ2G94NiDbdv/aSCgj1+SCtPRzNeFyi/oQY?=
 =?us-ascii?Q?FoQt9zZLlbAiA667s45g/AQYgStPy/3F18km74FS0UuYD9EQT+S2fBFKPvJi?=
 =?us-ascii?Q?xhkc0Kh6OGzhFF474qHb15SNa7b8vo1SNbZX1Ktg913lFJXBstU6XIKZ9EYM?=
 =?us-ascii?Q?uZQj0AHL9ftFWtzamRHYlLfqutYmiVpOr/0uiu6UJWzkLF0G1q57WyIPVLHZ?=
 =?us-ascii?Q?llMLxaBCMtKRhYgMrEeyLT6q2K6tczrc/BKZG8WeTs+PY9ca20xzjMxHAp9j?=
 =?us-ascii?Q?4zb11GkWVUn1CzYRdJskuZweUEjVyUWJ7oxG7SniZrte83rKWBPTw51AF4Cp?=
 =?us-ascii?Q?rsJPYSv4dPXj4sRVxObUJEzi0fs62UbfeG4A1mHKuVFV3uZegv7JMvYUeq1S?=
 =?us-ascii?Q?oVxpsrrqGoGzXLBivDJzrsUB5y/49A4=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0f8c1e-581f-4423-ff10-08deed378a3c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:06:33.3553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLP4Kx4BFcfMPGV0pRBK5uNB07TcMH6AuWa1OxW5+cAFgHRcCDrCg6AO2NtV9wV4KBFAc+tJZdvH4llQd5nAp4mLUsCz+zra804jTS5VBFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEL0PF4D55A38B9

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

