Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013061.outbound.protection.outlook.com [52.101.127.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F3B347FD7;
	Mon,  4 May 2026 08:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884675; cv=fail; b=rGiqbpAkZq1hAHyOJolLegOTKgD8Qi6g0XtLnq5qZonZNwwXVOq59BBv/FzwWmzUN34WZWfb9EitQ5TADWCCX4GlDFrg/NGlIQZewgFjMcSStyHS/TzPRqiql02lC4wCJipF6jb62yMnQrcJUDc6LBR3j3vW5fPqQw3KYSi/WVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884675; c=relaxed/simple;
	bh=42RoFVsnDttgVf/A0/X5fKwKztD3f4fhqT+E4Fe/z+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tO14tq4Zlce1Dwc0aSykqqc7IJ1fXKPIviwio8NxSoY+vNF0CAeCCPDHaxO52LwYUCPBsxNcAmq56iQBzynW8BqDIqsizTmJgcPSmVd5mcPmyX5jCK8O3hXV5Rocgxm6mx004UcptCk7phlUT6ZElxBzCvNbCKdI2Irel8qiocM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=OFKKGYIi; arc=fail smtp.client-ip=52.101.127.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="OFKKGYIi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p5QjYZkL+Y0g1HujYRNjslkLl6mdrrKDGaQ6YX+K7XHHOI28tBx+enZfDlJPciIlIcXu1C6nkqjoEm3DvTKQZZHZUnuSnYXxg3vzJGpqZm+poxTksNG8z8yeJRD6lBKkQC2/VVQWqV/gZASVGeLda+8sNIu0eZEaNHz9yV6OfWf3BVePw6JdPub05Ei1z8XNFADVFpDri34mtnt1ewAvsoeojWPDb0A6UNXTHzUiUI7w9zkrpiVioAwvvZNTE4Dfug9EL1xm04tb+Hat1Dx80buLhqv0AuxWY5xq4tcKMrXEEs6hnDB8TqY35xC0l6c8sBVc1eTIy1V7jFOFKH8xrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R85jyQjRNxgp6RNhj1uj9en5fRweVeTVwGMg7E7DlvQ=;
 b=Lzwe/4QYv5fHSyvNlBHkOoXZxVugqhhL0WWxkmiVjwAZ4bxSQjehNFRwPsPCL/vmSQj9xKrfh3RhUpofbimuO8UhJ2ycyFwQ8mEwt8vSerLtIg8YCg43BDFbHzKrIF0ukP/dDBounesJJF00MNEW8Hgg52Riwzq6pTjJEDzmXKxU2WdXCCKEWHpQW6+K1FPrrqGsLfULWApRCClE8GRthDGdMHssepjdui4iQWigfKCvcRUn+ay8wZTCqIkf0pW4W+TPfsb7KfZyhDRyJJPE4oP3WK4eT2anoJ5Re2pZ3PPwtym+KeHtD3t/DDEr8FkTK1c1L8bhXN2zpyyWYFjvTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R85jyQjRNxgp6RNhj1uj9en5fRweVeTVwGMg7E7DlvQ=;
 b=OFKKGYIiA0ddlEPnlwl8LgTJuwt3Z23ajdmG0H51f3TVfg1J+o93Uw5YlqYRV2yYwTRAsmyc3zsNvvUH2flv0oJwLsygLMMiemzKCLatPVbMHO3EiOg7Lmqx/CKlfwsjKVzHqx1oGwqAcMgtROA645iwvNIcrn89cvQ2zyaiUgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by OSQPR01MB7823.apcprd01.prod.exchangelabs.com
 (2603:1096:604:425::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:51:12 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:51:12 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 15/15] serial: 8250_mxpcie: implement rx_trig_bytes callbacks via MUEx50 RTL
Date: Mon,  4 May 2026 16:49:00 +0800
Message-ID: <20260504084900.22380-16-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
References: <20260504084900.22380-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0040.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::13) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|OSQPR01MB7823:EE_
X-MS-Office365-Filtering-Correlation-Id: 213db57f-9198-47e4-13d3-08dea9ba4b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	HRSETyUgwLV/JxxvrKaFjngfaEKSRwF7UhgSAzWWgA1iT4is6de4h0sbysL2ToPh0gWd/Xs/K+fgaWs9HYgclPNN2wqqk/TxLcawTe2xbhs+xRi/PJdFqxmOfVYh9XNY779FVzcAyzEEnJhZONhlpWiLV4t4TN8JV08NMRQHUNL6BaVAcBjVCugUmTpSPOs+mL17CnPibxKVuz2kycM2X+q/AHFehre0drk1ub2wmSAG8EKrMt0B/PZL1c7Vp266Sv+TtnrVg4iaIjTIB7Lcp0Qb8qbDwhjbLbmt3QZN8DFI8WlPMtW8sJY55HKpTh//RKi6nwDxG1SWgSMv6LDfxBoZd0TQgn8eh/w4DqFhF+fGX+jshYIH/qjGoQBmbRIPqbQDJZZN9d+k0jQuoaGvSikTWTLGHw+sLReic+RAxyYsjNsEIAFCExlum1yjG5KP3YIMuoNFk2zEY0fboIXKO4kxzjNtb0I+IN5l3LJH3pzQ2+31c4aCL0UuHbIF8BDbxgKBCQZsY53Nk8MOPbylm5iRst35d2y0k7y0hKd3x4gfPv2bVHYqq5mIPEPWALnTySbFjYiqIDgWDA7CH/GaBHWlzbq3jiDSUUn5JrYbnjYVeacvQdDHFCoGdTT7ZufwQ6inUdvYwNgXYldFlrRLT7scqYE2Nlxf6RR6JKB/GMPTrxog0BYLpbGG45TOcsGYK1gyq8nDehXm4dmEy6bB+v0m7qUcERYMBw6FeJ4eKO0hNXy64GLhgGyIp38WHdo4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AC6jpOUdlWS13GqradB3c0qnU9+dONfArYN+jshn9M3exC/N76uzA5OrseSa?=
 =?us-ascii?Q?kRUry8McPj/2P+EqMWa1WwZhStnRWufT3HOsfprnZdqLR9BaXXfk24uc/2DT?=
 =?us-ascii?Q?UUqV7UHx3X2iyzFdirCIWPB76MKBeVTis4h5VPMwHKglcRvG0R8S3pzvPMbT?=
 =?us-ascii?Q?keTh9d0ykpkn33NOsG972pz1ugIrBfX2RHyjC0f8jBtjWzS4F/y39iMQoT5o?=
 =?us-ascii?Q?7JxcqzUo/bF7GlLFWlKVeSS05O0H9HmeSnVf1A00kMa0VBmxbjM1tuXGXIYA?=
 =?us-ascii?Q?LvtCfdiR/lQFFG4RTlZ0aARyAC4AibWVVnBVooPjlsbRcAEB/hFygv/3BDHm?=
 =?us-ascii?Q?OcaqC8xC5T7J7qURerK2h+4wK/2sDEdbiWXbCMYRsPOPh2D5yyf0Z6XjKjnf?=
 =?us-ascii?Q?KQaskHTrc/4LZCESkvAiif5gbulpsMB3KxoiJ05CDQw2cVWVfiGsb1IoxfKf?=
 =?us-ascii?Q?+kmVeBt2oUfiputg4u6HbQ5IHF07IPUpL8HdwJUfVCRUz6HlN5mLvh3qI9jj?=
 =?us-ascii?Q?Xpd61M7euas0zgAjLWfMB5zHZHen+6NBwr5yJtD5yrhyK5VyUoDx47xHbv2g?=
 =?us-ascii?Q?Rq4jdFSW7yf3zj65MuqeKbZHzIGiyi3QWDwah1A+7vyk2mGGn3Bi59aNcE3g?=
 =?us-ascii?Q?s8vDOnHUt42Zgherh8dtN2s/nwMxzRJjtGemGXMHqTWanL+OulxgkeV0C0Uh?=
 =?us-ascii?Q?C1jtkYGB9JZZirVKEhcpJxY/E+bfHx8rF1eH9z1sglTrWYoiEZbFEseHSApK?=
 =?us-ascii?Q?ke31Hjcjk7TZ01fk0+KjU+/t95DxMd2O9LbP/W5+PzhDdGAsZggue1+j2qky?=
 =?us-ascii?Q?bu0UoZLuCKiQulgJZXIRS2pueerM2SdfDs/ubB49bEBlrzUsRDA5jwPrbefQ?=
 =?us-ascii?Q?dfda0h2ia2cMsiTYIbZSslkzTYpm8Mg1QeW7OZdkfoNmyP7u6XvMKLCF16nr?=
 =?us-ascii?Q?S6NBH2IlbjntXEMF5Gzz6M1v/4ZDfuoez48B9+ZRmsJ95/XpN5tjUSCqMwP9?=
 =?us-ascii?Q?FxOryB6vNQ78URqgVEz0+O2Zty3yHhTRu0l37zlojJa7aRwPTJ61i6goDyPx?=
 =?us-ascii?Q?j2y+NTc85uxRj8Jhis2HQJ8d3pq6gAIFEs8rNGYF6pnpNvpDPmSAFfLz9w59?=
 =?us-ascii?Q?TvevUQkx7fbsnHlBq3r+WulfiK9gTXlOq4c6M1PzuV2JeJ7VYajuOli1L8uY?=
 =?us-ascii?Q?zQexYK8mIdEmKAspeo5EOlGl7EHU+IpK6CD84r502CJvuLZAPT2R3BcfEC1j?=
 =?us-ascii?Q?YOZ8oATVkIr7NfgSINege9hUZGXuNABuZ+RSuhkEUDg5ayD7I13IO94ovILA?=
 =?us-ascii?Q?xmS/1QCWoYVEW8ipKobIv3RSLi1C05n5aFxtOQQk7m2Rx8vfYzELMfhVz6sP?=
 =?us-ascii?Q?vRyewTFBxYMywUu99bqxOwzteyUr17fIG4q5Z/h8Ee/GteU2N1xOm3S/9Slh?=
 =?us-ascii?Q?z4O4Lhi+D7KhVYxPGgTjShQ5qHKMU7WzKA9Y31I4W/MwM6OLoZNpwas9WwZI?=
 =?us-ascii?Q?mRT6fLtR6tL7w5WKw6VQZ6z6bB7PZNyPu8if7Amq/lg+SN1OZ3zY/j7hq/y8?=
 =?us-ascii?Q?28NVU9CBHh0QOQe/n+asceyBK7AAV3hXz0GAUqFLdVsgYb5HTj/tU6FBK6oI?=
 =?us-ascii?Q?jG973vZUYhJLD8BnC6/dDInsY/1sX42SlJ01HRbpK7QCToQrPFoSdJuCIBnI?=
 =?us-ascii?Q?fdqZs4CIVdRrkhVoNpwhf2S+ew4fQXNhF1GuYdfcIBE8JrNNR9FDSCpy540o?=
 =?us-ascii?Q?pAQIXOuTyhlSkX+kgtk0oEUWUOVlucU=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 213db57f-9198-47e4-13d3-08dea9ba4b09
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:51:12.2877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1++Dyp9JSvj2NRbR8EGNL661x7ZEJJGwF8P4oB/l3NetuxSps/OsWbwZtfUuRGg1aRTBlawNF+CVrxdZ/vQfewrm8H2jHPDwy9bFG7aCzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR01MB7823

The MUEx50 UART exposes a programmable RX trigger level via the RTL
register.

Implement uart_port RX trigger set/get callbacks for the mxpcie driver
and wire them up to the generic rx_trig_bytes sysfs interface. Store the
configured trigger level in the per-port private data.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 28 ++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 5bf15ca78228..cc317202b658 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -111,6 +111,7 @@
 
 struct mxpcie8250_port {
 	int line;
+	u8 rx_trig_level;
 	unsigned long event_flags;
 	struct uart_port *port;
 	struct work_struct work;
@@ -262,6 +263,7 @@ static void mxpcie8250_set_termios(struct uart_port *port,
 
 static int mxpcie8250_startup(struct uart_port *port)
 {
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
 	struct uart_8250_port *up = up_to_u8250p(port);
 	unsigned int i;
 	int ret;
@@ -277,7 +279,7 @@ static int mxpcie8250_startup(struct uart_port *port)
 	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
 
 	serial_out(up, MOXA_PUART_TTL, 0);
-	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_RTL, priv->port[port->port_id].rx_trig_level);
 	serial_out(up, MOXA_PUART_FCL, 16);
 	serial_out(up, MOXA_PUART_FCH, 110);
 
@@ -477,6 +479,27 @@ static void mxpcie8250_break_ctl(struct uart_port *port, int break_state)
 		serial8250_do_break_ctl(port, break_state);
 }
 
+static int mxpcie8250_set_rxtrig(struct uart_port *port, unsigned char bytes)
+{
+	struct mxpcie8250 *priv = dev_get_drvdata(port->dev);
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	if (bytes > 128)
+		return -EINVAL;
+
+	serial_out(up, MOXA_PUART_RTL, bytes);
+	priv->port[port->port_id].rx_trig_level = bytes;
+
+	return 0;
+}
+
+static int mxpcie8250_get_rxtrig(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	return serial_in(up, MOXA_PUART_RTL);
+}
+
 static void mxpcie8250_work_handler(struct work_struct *work)
 {
 	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
@@ -591,6 +614,8 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
 	up.port.break_ctl = mxpcie8250_break_ctl;
+	up.port.set_rxtrig = mxpcie8250_set_rxtrig;
+	up.port.get_rxtrig = mxpcie8250_get_rxtrig;
 
 	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
@@ -608,6 +633,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 		}
 		new_port = serial8250_get_port(priv->port[i].line);
 
+		priv->port[i].rx_trig_level = 96;
 		priv->port[i].port = &new_port->port;
 
 		INIT_WORK(&priv->port[i].work, mxpcie8250_work_handler);
-- 
2.43.0

