Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013010.outbound.protection.outlook.com [52.101.127.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F46B3BCD27;
	Fri, 31 Jul 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484157; cv=fail; b=cVzIozJTo2vgEU8+frTMPeX4mBaiHioxEw2S/OybGqsGp6CHND7enJizJ80KK26HgWX6YaWcBV/lO2qZrc/gXXP6bjoosYsftpynG4PA/1tY84yty1HBoCUBNCno+B0YvbmLFUwg642wEeDNPO476vjD0FodbxY1uqlqySkvdFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484157; c=relaxed/simple;
	bh=s52Tk+MMjNTiqRC6VD2OpNDbpwFo3iQb7SjDQ91GYW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z1Z96awubmg0RXO2iPvNoHoLEcNUJ5aGduLG4XJ1xky64Ee2YlXAzFgmIJQMPC1x4OK/vVJwXBw+aJYYpbOVUxlfQzav2s71/9Nuee8ZqvRJqnMU693mOPsSVUNC3AKhbLrPFmpRVhXwpKDcw75xefJMuMo2TwwiAZXRhP0lIgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=PbJAeXqj; arc=fail smtp.client-ip=52.101.127.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="PbJAeXqj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0SaThdsavlSjf3LJSfQ5o+HbnN5dbrZPmQOtNlmYhG9vCWOdJ2fbfC9ZnOf3Yb0X1cpXCa8nLUGw/0FeHeLbFIJnCUrHTyfdJrxyLI3aTpUN8wlmi+scEbvdyG0NpzlEPhv049fD7H9hjszuXZPyIOKOodCxFlUDihhYwFRwOb0z24yzTixt9p2zHO7tL1LdZVn0IeQZH5o2vzGs23dEYt+KBtLR2CFul0ha2pnt9TArhbJYjl0pv94qjLAOeGhJDcNAq3GvSOhyVgcJg5DFxn5RBdKH33FOnHekLNZ23vU26Vgcow3HS9Ql+ZxBUzFsNYkUkrcvZwVoxCTZ7ONHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLv+t+PtJd9KunbNyB9VIkOBI15xkiNtwFeLfGUKUno=;
 b=TFsObaRiUsLvzCSBOpAB3rWL/Bvxbf+9Y+NyzZe7M4e03B+Lcxj4uF2kyNWQ6+BAvP1g0qhX6B4zzc77rihtlC0BKZYfeV/w65FeFSq0qHpmgsndV0nHL31E3l3uebw9550mflwHMMmIfno00irXIOCtsMUR7vNW6V4+bc1n/YaOXPmASP5HSwr7tz5W4o9+pe3/aUGB2VAsHMc+Hmm+U75oSg4pohEJ6gShgNEkZ3AD7aQBJRqUnM7u4nhHiqrqeZjjvtJ7u2XhR52+6eoQto9cNR+oYh1UJW91IT5C2qSGtZm+ddVtQ0yHq4w+QVt+qhyFj9ISrNhMSKGhR0RLZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLv+t+PtJd9KunbNyB9VIkOBI15xkiNtwFeLfGUKUno=;
 b=PbJAeXqjoyRUxcmKWxt7nBNJoviFM/IuyGONKNEo1NCxpX9RNOQ2rHAwcieB05vAGanIiu6v2O3ySwVENf3uNO9Iwt8ncNr6aKLKq3hEp0aWbJk/XDRCyaSemk/EvG/35A0Hjzr6UqJ5xubyDas0cOi9mxUmpKh4QPdYdwg/bHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:04 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:04 +0000
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
Subject: [PATCH v5 06/14] serial: 8250_mxpcie: add custom handle_irq callback
Date: Fri, 31 Jul 2026 15:48:12 +0800
Message-ID: <20260731074820.735619-7-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEYPR01MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b81dcc-a8d9-45b3-3693-08deeed8314c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	yhq9FlGgzqZ9fivxMoW0FZQdVW+JyeB1X0CSpG1dCqbN6Abr5YURscmC1G4OgXxjIKDRP+i0Xzpk7HybiwIMhl7Nvq57xKQ0TjLbuytaz5b/k8J/jco86DsSkUI37qClqwR9vpHGIYF4dNCs1Zp5cF2zHxBddpT8K0qgPVkVMNrLeruRrktg4ot079UuZFdIT8fsdag83Rmx/k90ktrZMbnhz5uaOgoDha3ar5LIvpkyYjGTnAhP4dF5WBFIYBE8WvzuGwQeGWwMshloWak7BXHk7fdrrdHp+5yFyRNonpth7XqLrpGT2JMIIAZUGx0SiL0rfq1MZgaz07pf6kDa0rKyGySu8fvenaO4ummzgJiT7o05AviJCMvAXZ0aiM3RY4bs6+mQ33axoeC7C4tDt4UTNlrJbeEqqUHPHPm7xC1IfbZ7aILYeHwpqZ11zV4VZyn4p+Tq2AxgkNaDmVz/lzUUkVwkemFbspVRMvIgicUbXjQsUioefjZc26FwLSN5hRunUhgqD7OM5xj3WBNgJKtcNtfH4OzPy364eIh0vDFpGhMQun9jcx9z5y3uD3XIlLnxl/p1EVMizIJAjNdBpaIE+22F17omOXq4feMGBveK8pe7YifDp/29gL/o+6NzBeBsjq1v+EP0V6FKXUS/h7mUTo979AuiBTZVKrJxL0yLzurDoaLj+K5jKI6YIiH8ZFOxY8S6vgkFxvH9ktJMmzZJEjKjmnDLPCZRmVujXJM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bv8WYbw2qohXLYpyLjkL3vvNyWR9LERrvbt0Psqq1Gnk/ZHEf2bbitXbjCCG?=
 =?us-ascii?Q?exG3QHRhBRVj8Hr2jFxvJKjr6B3budMeMDWvSdie4YA/JJQRs2NJRW8QU8zg?=
 =?us-ascii?Q?BWUfE19RngOi3Qs6JDVQxQjd7r0W2eUIC+iKlOVSPDU9ijCpb7jlxtle+WyL?=
 =?us-ascii?Q?ETYwaI6IpFMOZpmKr0GbTQKxaaQaOGAxmjAVpN1F2PMnXlELgJ/O8VxVwYxL?=
 =?us-ascii?Q?oNGDLLGeWk09QCIJfAbmlZiU2WDLXrk+LO3l5UCfb2Nl/jl7pyFJwltD4e8z?=
 =?us-ascii?Q?FmP/nG9Qufpl5/9laS6iRKWv3v5KXHYJ2zfWewMXyHTCEN2dncG8dlLis3rX?=
 =?us-ascii?Q?5Oc8dcCxqG3B8ebyjr7LuHoWucZSJqYgYVbtUmvbbvh97tQyNvKvFJ+tCUG8?=
 =?us-ascii?Q?rjBtMzby53b+LOceuDiUVsvTYDngCFR/g08150HLPTKbtMZvtuFCabZBgbNF?=
 =?us-ascii?Q?Vavi9H+zEXJ6StTRySNLS9iDWrIlcFTbVfXbJoPJQlHoigF9UBxjo7m9Kd0L?=
 =?us-ascii?Q?A7bUqYk7cYMWA/fSVlkvyc8ICF5SBSMm7ULnenWsfazIYusYGfzqXaziqk0n?=
 =?us-ascii?Q?52ZtN83fAv5IJ15+tsSAKpSRuHCK9lTcHDvBpnZLDSfil/KOMk0TePru/esI?=
 =?us-ascii?Q?9U2MY/PuwQzdi8kGFtqFpQMR0Evv58BonAi/d91TBhWKAwV1ZxQSYky83ds1?=
 =?us-ascii?Q?w/J11Y8I7fdNg/58xCILJNDGhMSLFi0ChFUYdXphgK4QMiyLPo0Xc8fuwRcK?=
 =?us-ascii?Q?tg2SGiLTSRpOME6X7MMS2pmiRwnvQ4EkF4IzjwQ4JPo3v980spwjiWEEbebT?=
 =?us-ascii?Q?oCSmpjwDah6pQ47AHEZ5Q9bqiEH0a7A64SeISVtmtsWt41CIqwPs1wYyzmSi?=
 =?us-ascii?Q?PNCaovTkjRQ2BpAQafF8SsoBB4yzoqtN4TqmDsO5Gd4xw8uJQxKEGUwpJPt2?=
 =?us-ascii?Q?+bF9K7ToTcM/AMDg5//NUGrIC4ybkZt4JoVBEor5rRXJsQUzy/5Cc4WlhLAH?=
 =?us-ascii?Q?dYhhzWy1t5A16/KyByss/l1xV1pACmkGzMNqfa8I5RefkhzCJzz7ZzkedXEf?=
 =?us-ascii?Q?OW7OxfNr3H8+h6BGlc9EkI9xxuzpJVypZUty0R7LoGoqDIKFm977XXDrsExy?=
 =?us-ascii?Q?kOrp7IJLfRXgUrG+YT7cuMutImshh+vYYoBiRVUlFvC/OglDxb+eWmEyAXg6?=
 =?us-ascii?Q?ZD81hXujAqe/qnA/LWbnCLF4qGHH9hFcdZKdJRRwRvLewu7h6KWbIXO1u6MW?=
 =?us-ascii?Q?UIVKG0wgDVRvcnZS4o5BVQVVnTrqTY3DwlRIuPIuQEmRwzSm40SLxnUpiJUk?=
 =?us-ascii?Q?Yrh3SPIdqiM9pU0Y6v1TJ3cnwgDBlZ/Qu4dAkoY0wAR3bFMRah9zFqxSuGYm?=
 =?us-ascii?Q?U/y0FS+2DvoZFJow+ql26eBs6mkHZG/6WFAvIK8n1VWt+rKiLigvTStw2Yfi?=
 =?us-ascii?Q?bUdYsP3TqsWcmdM9JN0x+gRJ2ZIHbV/HCQiZfsaMUI6BMvPg7T3qe+02fTdZ?=
 =?us-ascii?Q?q4Gkg5dX9lepiZdvVjs62rCvhBGuBpdxrfoe6+TacsuMe2JqEeYEubLZQFmj?=
 =?us-ascii?Q?b/eT6WnFMakg1GxU+R8zdATgmUAdvIUlT/n/4PTgJTEEAq+HiylBOQIdrHqQ?=
 =?us-ascii?Q?UGKWp+x9wXLclHrCjmhs4OPaRy+4V3/rCzi3jP0sIGHVvPcINYqJKaQMfjyf?=
 =?us-ascii?Q?9VKR7rChMxKf37liF1WqsoYMeriHGSB/+ftjS2RlUKHDG4nx/mUAfnf5j9SI?=
 =?us-ascii?Q?MyCLd2qPnVqYoobeAaw2U3oB9cKV04A=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b81dcc-a8d9-45b3-3693-08deeed8314c
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:04.2461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yZ8B12y0guEBqNYY4/o8ad+cSacPAFvsUWlKqy4c5++nYo3JGmlAuco1kBnl6vXIoGK0fCETi83+chwfVCkeInWFtoUWlxcCvD1g+BKxL6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

Add a mxpcie-specific handle_irq() implementation for Moxa PCIe serial
ports.

This keeps the interrupt handling self-contained in the driver and
provides a hook point for MUEx50-specific RX/TX paths added in subsequent
patches. The handler processes RX, updates modem status, and handles TX
when THRE is asserted.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 42 +++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 39eee8a9b82d..9190825ff3d3 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -263,6 +263,47 @@ static void mxpcie8250_unthrottle(struct uart_port *port)
 	serial_out(up, UART_IER, up->ier);
 }
 
+static bool mxpcie8250_should_rx(struct uart_8250_port *up, u16 lsr)
+{
+	struct uart_port *port = &up->port;
+
+	if (!(lsr & (UART_LSR_DR | UART_LSR_BI)))
+		return false;
+
+	if (!(port->status & (UPSTAT_AUTOCTS | UPSTAT_AUTORTS)))
+		return true;
+	if (lsr & (UART_LSR_FIFOE | UART_LSR_BRK_ERROR_BITS))
+		return true;
+	if (port->read_status_mask & UART_LSR_DR)
+		return true;
+
+	return false;
+}
+
+static int mxpcie8250_handle_irq(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	u16 lsr;
+	u8 iir;
+
+	iir = serial_in(up, UART_IIR);
+	if (iir & UART_IIR_NO_INT)
+		return 0;
+
+	guard(uart_port_lock_check_sysrq_irqsave)(port);
+
+	lsr = serial_lsr_in(up);
+	if (mxpcie8250_should_rx(up, lsr))
+		lsr = serial8250_rx_chars(up, lsr);
+
+	serial8250_modem_status(up);
+
+	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
+		serial8250_tx_chars(up);
+
+	return 1;
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -362,6 +403,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.shutdown = mxpcie8250_shutdown;
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
+	up.port.handle_irq = mxpcie8250_handle_irq;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

