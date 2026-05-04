Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013054.outbound.protection.outlook.com [40.107.44.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3EC347FD7;
	Mon,  4 May 2026 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884663; cv=fail; b=PWyGI4iOAwus1T4jBHaljTAOI0M1tw+BQy2oEkT2dq2k+MWxB6v+JWLra5b6SVxN2/pWWXqgvxIOdK/J0GGYcvc2xjRSQ0iksQ7fi3h3rm8m0L3+O2kGgcaz+LRgShNZZFdz5lUzFTOG+fzl35qc/cVThKXAbTZGtkpbhRcC+fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884663; c=relaxed/simple;
	bh=OgiJOnrKRXQq9vi937mnexg6Y1nWTRBX9d3/SIkF/jw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F9wbhkLCbUpfl+CephEVPDyRDjcjAPwwS2pCnmUhJnfYRhPur1GIduvnYdtTLKCpwPMk0VQc0C0ychMJauPOJw61ycHqui+CoooPIskNedZDtrhz1H/59NzD1jE9LCzjluc/qh5AmooW+pBXP5eGqnviQsDiPi2l1zvKwwBI/6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=Gt6hckOr; arc=fail smtp.client-ip=40.107.44.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="Gt6hckOr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCDmeWB8C6fSiAkWBV3Hdkw6HVkXKHYCw89os4CeodAdl1JTy2g9kAD5l0da9M+fp1ptzoOgIz6JH05/LKeTyLYMWZreS9vc/vg15ENmMykzczb6VlFeRk9fNQLwrQcQmZaNp3/PY5SFewhPKLkK/xceIjU/hc7b9vklZgTBqFxO6ST+MCUuG7VWUkqV7YPQ2IBrEpQPVf7Z+GijrKnf3aKv7JzuGpPukbE8VdzJU7MKlPsOAio81ISYSIC1yVs2f/fnfPizIc8Tsa2jRiHtyap8hF3QzoMArrDRn06QBkGOjH7t18nxks3X1f2Z7GKL7qXPQ7R/CgoIzHiehbVOuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynUrElF54FaDr8ntvGzpNRyMwEu8h8Y7LKKP6yOBXCo=;
 b=MSiPjMP2+33vaCPKytzTHurypRUFMdoB/SgnyxhQ0q4oAbhQKFXOl9N9cxXAlX8GQMf7JZ2H6lDOFnt94GpVBIu8fIf/vpbJfNEwqHEgwD32Z1gFQpVhzi+//qjaaJ2ewh5CuCjEWHFXNgqM4mLX2wyYA08Hjvcr597rW1A/3+UZSbo6AP9LYH8VcsBv6a89Yx3yuWxyNaRtJq3Q8zpntbIu5MrkM125dkgRyIb3g49j2mB3Kk7Tx4R/uU0sOlCk3baIOa0lb8ow3EUIrp12Xnt+784/WTx/OeWY7Xh4JNz9eq/aygKgbZQ/I0oEm5KD0H1lMpd3SUTpPqx4hriKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynUrElF54FaDr8ntvGzpNRyMwEu8h8Y7LKKP6yOBXCo=;
 b=Gt6hckOrDPRF+xEqt5NnX6hPqWfyND2kPIewc6QcIRtdTvlOvckgZeTyQ/aV0RiYOvB8fLclenVTcOQrdyYyPhFIqfrTdcaIU6+wQIsU7EGzTc5yj4PYtbLGUG+JpakcBbzcK/8Vb5FC22yvzbpE1tvryZtfLDpk3GjbhbX9Nt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5516.apcprd01.prod.exchangelabs.com
 (2603:1096:990:13::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 08:50:59 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 08:50:59 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: crescentcy.hsieh@moxa.com,
	fangpingfp.cheng@moxa.com,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 13/15] serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
Date: Mon,  4 May 2026 16:48:58 +0800
Message-ID: <20260504084900.22380-14-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5516:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b5397a-407e-4e96-f20d-08dea9ba436b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	teRJxgX1Q/NHk829xCK1SyrRgPXqxx4RY/jV2YZ54He61kv8mKTvRNORaMef5tob+25d/9+HgNTzdSOOU5Q15WvvDck5SvRSV7JUMfTFEkpSr+y+vMz2WlgqN6a7PogPwZVKTx91qnhjf1tYaS1yJI3ElaP6ZH/7COvEzvB2ATbaLWyKmR/gA0FsxsNQuP/QCNQqYahQBm4sJE4eez3sOC/JuCaxHi3+pD8ZMbU/XlDDvR0WIibsx6PBzN8deDmmOYIUrgoouWvE8OiPFqVy7x9QxwpWHu10PWw3q0C7qBb+IundTl1C5QJU2dC7TyCtgHmP6lrlkVSV1K6rnBXlnsAi6VQ+eJtU+0fp/hKhMQkG6khY9+STRGmio4zs1vNvcNExF2+zv2//v8XkSuxmTtOcOaiYT2L9XWx0zirNgZbe1F/CkXWNBEM07hr5mM0WiAFql6WpO2XU8ChrF/NGN0kt1z9klVnSWV81HfizfV/MV57Kw7BjwHHzf2lj4bf8nxRMe44d0rFr8onM7Wn0ExWBxVWdQ4yT+4ED6iaowYFZEUhcRPSV2aHIY2n9vpg2oTQIHstL7ZJeGNGfeYbSmppTWXpr0htm5ncBb5k+V/udUqhRvyewcCMVUJI6ml7FpFSJ1lKg6u+iNGErtgRKt7AIvOx9ms43Y6d5PttJ3keVABUyWhMHcm3VlKKbAThosUfI9aMnY3jmgSspa2JHVhSen3eUynoTar4V/8EMousIA1rIPEma/mvLkBaEznIv
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ECdsV8p5vYCHzDlfFKbYQEchlRmPR6wt/PaVN0sE6ytTqCsDUDC4YeP4qZ8y?=
 =?us-ascii?Q?aKflWHTDL5VgixZukw3G2UBhut6/7LQDmoFnoL3lixRs9br+NJCuUuNKlQxa?=
 =?us-ascii?Q?1zIlQ+IrNt+240QvDzuDpGK/I7KR3yymLm6NpH25vmMcK2oujHZOoq8B3kD2?=
 =?us-ascii?Q?X5t9xg3Mtx9WVzRYv+LXWC13ZhP32BkjtP9woMOMdYoVy9DTYjWtqt9WKc9V?=
 =?us-ascii?Q?Gkze1dqBwFOhjF90UKMJpNcU6AGV+VKOYjyh7Ly/bG88SgiTofGy6Y9pj7wM?=
 =?us-ascii?Q?VlogywyyQsHtAzqrxxDzfvTc+wRUYdhhQLSxVvMGjQuKhMmwZXDjStrKuvPf?=
 =?us-ascii?Q?UrZBte5ngjirBZSd+Hv64Saby075F2Kj1jMjONtEstw1TSiTKD0keBNNTrTw?=
 =?us-ascii?Q?xfIZkWkWGIbg/euTDeuKGdj3lsZuPvUKQ8Ha61JtBDrtDDRHaQZTGtXHT9UD?=
 =?us-ascii?Q?Z02mtLfBLqU7FebR0YIy6aoXrl+Y8xjXdpHKqRVeshF3mncp7ElPYtWUmf1d?=
 =?us-ascii?Q?yrjNWn2Kjwg26OyOb/ld/axJTYMG90yOwaUbVmLPteMYOa1faZ+k4DR/Wiqg?=
 =?us-ascii?Q?5PcY4Nire/lQwlgt+2oaRXfAjCFn9otkwmgFkJ2m39R7lEB+CjWPzFKQdCCi?=
 =?us-ascii?Q?iOr2JHYwfIXfyUxAo7397YwS4D6z2w6ELGHhQ1yKsa7CwCNPE8cMSdTHUgML?=
 =?us-ascii?Q?zTKolMTrNPk4g4g8ApZoHgdioiBrVVuKuUQ3OCU1elE4zFemUy/Vm6LeLhgx?=
 =?us-ascii?Q?YFER7GDWKoCngP+zCSTlv8gC9G6RF5QGoXbhvETO1F07wzGufcPpMWoE0vVb?=
 =?us-ascii?Q?1bFWNQoKmJuWc8JWNBe7M31wM5G4obBrdUDvQ+RWPbHUrYK+RusIGrEUdbR/?=
 =?us-ascii?Q?3I1r59fl61R9fC4DJuWzX0BfG5rQcsB+T/IS23SeQzmlH7Lgf4mV9M5K+qnu?=
 =?us-ascii?Q?+9K8gdlR/7XfAnSUnYHXznevIlrkYH7j+o46102U8/cuQpkm5PKYmGf6+9cP?=
 =?us-ascii?Q?ryynjDMY+VxMmXXlQzvrALt2h+g76kgJkfRfjevKPPxorO3sjdktrnYOvaGS?=
 =?us-ascii?Q?4qmw3/v9KFMhBPOyhTyISGQqQkMGHLIvnVkOo1uclbJPpuFVxh24er8zyPK1?=
 =?us-ascii?Q?Pb72DTbmz7aFhdac3Hhi+F5Xf5eQ058sfXzSK2cZ0TkIUVt+P0WWhsOR4oJP?=
 =?us-ascii?Q?Sy93kdYhL/mKOYkBZa3AjV4aNspWyyJ6eV4JHWN9srdGSHqGfQu7EarNuYOW?=
 =?us-ascii?Q?QPeVFlFqX5NKH0Boc/k4uxJ6rp0wVYYCg1SYEi4bmAc829M4DLxmj/mbVsRq?=
 =?us-ascii?Q?6rjCdAr4XvBJ6H12j1+QQQPZ/twdW+GXxC6b4IYip3yf0A3I5pTYu5UV3IzD?=
 =?us-ascii?Q?3NwqruNp0Gg8ljyDiLp0HNeZ3mdTYGbHczFY+SBbslEW5gyRbFvk4Jz82ufj?=
 =?us-ascii?Q?YaXpOMg/H0yUu8YMbOeDitzBy940TvIjPEfBYB+XEWjSqEkf9iB1T0Up071e?=
 =?us-ascii?Q?WpP4TBKFMxL2ZzlSeyI/Zug/VBUI6+RuYwesQyY7Ww8yj1pdjLTbje3XW9su?=
 =?us-ascii?Q?4/4kJS1l6xlcRBiW4kV++GVkC6QVeYWRE7XciRnp9tvNNdBbn7+Mtt+ZzJHd?=
 =?us-ascii?Q?EBWlIoud6rA5Zh2lP1FJmWgTaKcpDYcu4Awt8vb/170L8NvF4p2VTat6KmyL?=
 =?us-ascii?Q?arGiWknXFvLYIHXhlRxL+qIzwVRrNe3V6flzr0ofjvVKA1GarpJCtBpP3QOn?=
 =?us-ascii?Q?3+MmMpmf9Sh2muPKI0eX0T1cNl29ug4=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b5397a-407e-4e96-f20d-08dea9ba436b
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 08:50:59.4743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mx5QL587agm1z5Xc5W4DJFLL8iQGshX7LnujQU2vrQLYXEtOLZSowOlHiMo8AzrxLNUvxoKYDfi5wjqsYHh5RkioBeii0xjvVQS4jaegv/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5516

On MUEx50, break signaling under RS485 requires a driver-specific
sequence and cannot be handled correctly by the generic 8250 break
implementation alone.

Implement a mxpcie break_ctl callback that performs MUEx50-specific
break handling when RS485 is enabled and fall back to the default 8250
break handling for other modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 94c3552b9798..5bf15ca78228 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -54,6 +54,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -426,6 +427,56 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned char tx_byte = 0x01;
+	unsigned int baud, quot;
+	unsigned long flags;
+	u8 sfr;
+
+	uart_port_lock_irqsave(port, &flags);
+
+	if (break_state == -1) {
+		serial_out(up, UART_LCR, up->lcr | UART_LCR_DLAB);
+		serial_out(up, UART_DLL, 0);
+		serial_out(up, UART_DLM, 0);
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
+		serial_out(up, MOXA_PUART_SFR, sfr &= ~MOXA_PUART_SFR_FORCE_TX);
+
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_XMIT);
+
+		baud = tty_get_baud_rate(tty);
+		quot = uart_get_divisor(port, baud);
+		serial8250_do_set_divisor(port, baud, quot);
+		serial_out(up, UART_LCR, up->lcr);
+	}
+	uart_port_unlock_irqrestore(port, flags);
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
 static void mxpcie8250_work_handler(struct work_struct *work)
 {
 	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
@@ -539,6 +590,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.43.0

