Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013014.outbound.protection.outlook.com [40.107.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B80C3C1411;
	Fri, 31 Jul 2026 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484167; cv=fail; b=EiLs/GTlvn2RZYJq36aAha2FIAPvrqeu4rdZ5Onn8b4XISd+VlMRvWRE7RDYlbOjzcIk7GF+S/1ikgfKm7TeS3s+qj/qoM3dbOJ3XLjPU/f6PdPAOtu++cIz6jMIVkEtZ6Dec4M+NN628g3sEycJL7Z6aIteL20lGyDji5/l4As=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484167; c=relaxed/simple;
	bh=SwaEAom35z6JWDdMwYAW4RjbU5RUnHlge6EFWcEe8Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IEMMciR+0ppvEPFcp6SwJqD5vHUrIXN6F3IcCUPETT/SafqLBC6Cgexia+h4dFtZsbHE641Dna4zS6jwSNm50dTwLcZy0aG7e2WKTfKtOwNBO4fEUPIfTU0cHe9uVUeNEHU/bMftynEE+i5MfggHlovsSuiuBcLAuY4ZQgGsTmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=XM1vUZoA; arc=fail smtp.client-ip=40.107.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="XM1vUZoA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNvavD9WaRd4HHB56St8YnkTTPgZT1ZCf9HDu1X6EUM2Z6WvbtCtak85e9FYpz8Sk3OHAhRt5/Kd3v0ijHkQfvjDbSqhftBMyCdJk0u/XIFCBClSOORSY1JiTfh4E14abGEQpfIpoSXzUxxGJBpgxw0CIzfelzfEuOyFdQGNpu2BDOARZEmfz/6GMgPWwkRpTK+nm4gEVMVoQ/Ii348svXusctZ+rxGYMNAJwhZ+3Z/KaH44W3JJEq6z8OJjYtsV4hzAj0teS4qGCzfdoC1BMU7CoUfzYYmj9OBFOOU2L7tFdaPNO7le5P6d1gwz4a0F36HzXvlC+gXiklmVbInytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHZidiLZ5mOT2HEQQXNCrX3Q9BVDfpxNhnVlTG9Jbqs=;
 b=yluXnyQfRDWx75wXgMW8nE70a0TP6i82w17p8G3HLOyh+sWYyAuaButFmbVZ5U9XcwjYk4VaaFW50f88NNX2I5nn3fQ69RaIJHfp6zL/d1HJwFuHmJH1BYlof0BSN1luoydcvsnAFcT7eBXuVHD5uKXsQqo4VS8bJpE/HO3y+67YS7iQbSGVy9/4fYerM+EhRdK9bGUChKFUuc12XXkWysr7XvbpNZyqPKSfFLm3lYvkw/8yZilTbWNoQ3Z2HYZU7NpYZ9qvtoz7ITvmZtCrjLEUoU+35tJZ/sxBfhzEKw+jxWpFEHwHLjz4RSJC0zE3JgIa1H9I0t1XjyqFzdw53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHZidiLZ5mOT2HEQQXNCrX3Q9BVDfpxNhnVlTG9Jbqs=;
 b=XM1vUZoA+QeWCmR1DiODa94W6f1Akw4aFCIYW5LheqPj7ceGV8gPUji5D847x9sUFxSvzy4k8OOr+lRHJFANfkYC5+54IEW+31aaZHnU7pxPujAKxnytDNmOq7Olnz0UDUNnAhj1ZO+C/6UH+OD3uXENHIUBMQjsRBapIrP5i3I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEYPR01MB4488.apcprd01.prod.exchangelabs.com
 (2603:1096:101:89::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 07:49:09 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 07:49:09 +0000
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
Subject: [PATCH v5 11/14] serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
Date: Fri, 31 Jul 2026 15:48:17 +0800
Message-ID: <20260731074820.735619-12-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: ab732b6f-179d-4343-06c0-08deeed83456
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|23010399003|1800799024|38350700014|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M6Ub5mTJp2IJC6Gjz90G9I1/slp4IgzGoSR2ZyOTlnbIYMJNuU2LZLpQhC2PIkCB845hRGdAAQSdYwrAbkQCZ/hniBPkP2E5cLIzVAjRHD2r2BhcC9k6lCS1QW+8wULnJzSGUkVewIIbOJXGs8jiRJzmFpMwC8PlQ0pk6bG0N8nwQgAQuiqrE+VzTAQJyyvB/OSNnnuj274FttDjggBjOIuwFS22ylUjEUBM01sNu1UHbkfMw+RpN4YzhXy2Z6iw4ngqnHWGmnNu9SH2ZmAUu1Y6OxavKxVi2yKTtb7dcGw4qRjHLWcYQaC9o7J501ceoM9u8EwA/c9wbsf7SohL7qtqfO6YhzWr69HdGPFzydpKUAn8JMvcR88aPwSLYQKCNoTYpmLB4tu8IPqNKgJJPlHfSPO1kbNp9GHGTpFArl7hDNIHi4CTI7hk9XODLlgBt/yNfeVYHtWWwYou/MlwZsnhmDOOeqL3LSF6MFAH9q00ZrSG5QLoovzzX8VZt/KQ4LvdguI6fT/txLeg8xjdtY2bRUcb9M4G5BZzEI7kNO8IO+BQqkiOgNdIrWntLfeVvxCe4zvSDe6TvDMNWocc+qJjiI2CSD8kGLxuNWv2NL39EBWGcTV5x6JjcGRtgKP6ZWVCAZyrgkuV+116SWbWEKx/abtW13fESVLMjZ7vcgs/FnJB6FAxO2FDYl0QJGGCtJzesI6b+Ik6sXv3+xMwO9+guwM5NgOyanqThgP0vIM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(23010399003)(1800799024)(38350700014)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eTcOKdhx32Komw06fmemL2W9I8AXStvmSeqVSVwFGubTuY0y8v5v8/A9lA7c?=
 =?us-ascii?Q?RAetQkcrkbbXbKHJ+j4GNRz0MIzqbkc3OmOQ+htD5HqrGdHbNnuDCI+WykuT?=
 =?us-ascii?Q?UpOiFkB6iB2pkXCorFl9kETjMnffvVY0N1dIR6dAefFosjkrvI5fITjFSbLo?=
 =?us-ascii?Q?VHtmboU3Kdp+y9ZjDMHy2CNLGMFZxyQ3tOeHlJcZAZLxeoSyXiOQJBbcSuBJ?=
 =?us-ascii?Q?Bnlfa788JDGipQMalP0GB+XMLF1xhumoqjkcLs2IHbZOE4vPGC9b8NgVfRz2?=
 =?us-ascii?Q?qjd5NrfsVjqJbLzOyZPcN9INbbnAQkjR7SGmd1xAqJH58SFviGjrCp/QyAhK?=
 =?us-ascii?Q?3qmIRGTY9apYpVdUNPH3nUBPcnPkLXko7R2R9jltqXRACn6A9W0dDxtaTgrO?=
 =?us-ascii?Q?aOqmlgTiIPa6p53pPi+IaDi9zqO9rCGaBpY48cyOog/ZOSHJLtvv0wTUOYAd?=
 =?us-ascii?Q?wZmWQseWA92Q46PsmOA9rZk46KsJaQ6O86Xc266leLNwEIydkbRJ9aUlf4/f?=
 =?us-ascii?Q?yf3L1m7m45G8+h1duwo5me2Yio31EWfh3t/soDN/Rbvgsq9MDfKhIWPSP0xe?=
 =?us-ascii?Q?Voc/qAeaSuQbNcFNv7XJP+5do4V8mKOT7d/5+XzwHsA3/iyHaxWefSZx9EAR?=
 =?us-ascii?Q?m4WTYpnjaGJSa2jd4is1O5w5lck/srj5/1pZ0EqHXUG9xw/azJl/j1xzh9/E?=
 =?us-ascii?Q?XSAVvjlA4P3C4KkE24892eGDsJwTJ7ycXdJq2rzFMyQq8p0h4Z+wxLS2/TAX?=
 =?us-ascii?Q?Afvpd2ScCuAKE3ffhAaJnoVzqsbO+UtaqvwKIxG8GhEK2HEfDqMVv9eZTYtm?=
 =?us-ascii?Q?lvznhfdEx9qO2ibtFpZxTx+eNgTb3tfPDiWzPybb/WgDNCJ0AFcg2zk87UI/?=
 =?us-ascii?Q?U27WxNwcpD+hkgqXjdTFYI2Hqql/lBN8QbhroAr5gpQqBs08Twp5DJowsfc5?=
 =?us-ascii?Q?mfOwn72qpVZiBfhvA5uqC6QSvRblpTLES0CfYBuJwC3lrVwqr5EYibFJLSHK?=
 =?us-ascii?Q?pfrJGWZkwSz2Iu9EuGacIpzSury9knjKLJ9EO+xgRNbmu18boTKanG5sGw8S?=
 =?us-ascii?Q?Onn0Vzq1Xr+sPztpTQAM5DxeOb7Abca1ZnWplKlT1RpaNyWO+8SYY4zx0rWc?=
 =?us-ascii?Q?fbZWIPgZV4CRBBrocqkiYhTUBQA+Giih7imaenQa0kWL4ARo0Pi5PWoBElLp?=
 =?us-ascii?Q?FB8iAiF/XVk8kr6OU0zAVoN+hrtt8YsT6WOjGnvSDBbF5CvTPqKsGHuOaXQu?=
 =?us-ascii?Q?wboUtD36so1BawzR8limp8hQBFpuyRw3QOxG9fCu4EvvUqAA0mGn1/eZiEWA?=
 =?us-ascii?Q?/CU6AzqdnczyySs2mc/Ym2tcD2UfzwKhFziNiGsuaNHsduiFuOKxCSrXkaYT?=
 =?us-ascii?Q?xoNtlpkmVa885XUs02FTBA8UYt1mHrev8aIylShooZIsJoVuMZwRBO4Na2OK?=
 =?us-ascii?Q?T8m7We8R8nxRLV4306yeN+A5nm/vLV+03Xi6rd4dyrXDaqViJJA93XYNddX6?=
 =?us-ascii?Q?9E5ssXLHol67SnwoOagUytZGeSwHy5STWtIlxSVi4umAnS4QJt/WrGfc1gcw?=
 =?us-ascii?Q?AFzhYNVqqsoP8bV388VM8gzQy6OfrBG8i6wT15Q5U9orzvl9LKx4hP3L2SuG?=
 =?us-ascii?Q?9tQZqYilF82SdOOVBEE7+tI+lQtGhaZCFZuwizxZw3B8meTlMlToo8axEnbT?=
 =?us-ascii?Q?BumzLuKnk6Oh7EOniIOsVbBksmN9hEUuv9LDsdbsUIGTXfm2ZAQmbVPeEMFE?=
 =?us-ascii?Q?RCHqg83n+g4bXE1ins569Fm7G0y21Zw=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab732b6f-179d-4343-06c0-08deeed83456
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 07:49:09.3804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rvmo2fMXN83FwWl0XEB8ARMnvP8QYIQdSOb4LPTqzYgX6qH3vrD7EvCy8b1VlArvHIPJpHzIPvGBtC7N4j+qwbXtZp/uZhbw7oUUp92DOlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR01MB4488

On MUEx50, break signaling under RS485 requires a driver-specific
sequence and cannot be handled correctly by the generic 8250 break
implementation alone.

Implement a mxpcie break_ctl callback that performs MUEx50-specific
break handling when RS485 is enabled and fall back to the default 8250
break handling for other modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 48 +++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 93f0af958d11..6f44a557a6d6 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -54,6 +54,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -382,6 +383,52 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned int baud, quot;
+	u8 sfr, tx_byte = 0x01;
+
+	guard(uart_port_lock_irqsave)(port);
+
+	if (break_state == -1) {
+		serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
+		serial_dl_write(up, 0);
+		serial_out(up, UART_LCR, up->lcr);
+
+		serial_out(up, MOXA_PUART_TX_FIFO_MEM, tx_byte);
+
+		sfr = serial_in(up, MOXA_PUART_SFR);
+		serial_out(up, MOXA_PUART_SFR, sfr | MOXA_PUART_SFR_FORCE_TX);
+
+		up->lcr |= UART_LCR_SBC;
+		serial_out(up, UART_LCR, up->lcr);
+	} else {
+		up->lcr &= ~UART_LCR_SBC;
+		serial_out(up, UART_LCR, up->lcr);
+
+		sfr = serial_in(up, MOXA_PUART_SFR);
+		serial_out(up, MOXA_PUART_SFR, sfr & ~MOXA_PUART_SFR_FORCE_TX);
+
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
+
+		baud = tty_get_baud_rate(tty);
+		quot = uart_get_divisor(port, baud);
+		serial8250_do_set_divisor(port, baud, quot);
+		serial_out(up, UART_LCR, up->lcr);
+	}
+}
+
+static void mxpcie8250_break_ctl(struct uart_port *port, int break_state)
+{
+	if (port->rs485.flags & SER_RS485_ENABLED &&
+	    !(port->rs485.flags & SER_RS485_MODE_RS422))
+		mxpcie8250_software_break_ctl(port, break_state);
+	else
+		serial8250_do_break_ctl(port, break_state);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -487,6 +534,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

