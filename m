Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023084.outbound.protection.outlook.com [52.101.127.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2B3288C81;
	Sun, 30 Nov 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499510; cv=fail; b=IwFJg5gtMJxoh/MIDgC/Daw5bU+yj5k+E2OLax2uJ1GAW6eKYCtUUPg0uGXp9gAHzt2Y7D2TeUL90r/4ENJf5HjPPlNJAY49wFMg8c3kO97xJPEvUcyoj1mKHRDfYyXI7XDl4XiICXhjKMl1gcR/Xb09hkYuxcJ34sviHjVAO24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499510; c=relaxed/simple;
	bh=EIqt1OdsmnnHAzs1p5St5ovJkPHV5r1WK1bbdiG/1NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OKfYRVTL4vAnhvwXy8iNLOrAhpTIz0Jte57m+HfQDupVsUYKUMdpk/en9HSua1pm+UY+Cf5PzZF8DHCjNr7ZPSraoZWh1bnf+QBq1rFg1ApCHHiE4UWWzfq27TU909cZKPKP5j4Uxs14Fnh0Cbgc4SFkf59FIYrAqMkj5KZhbnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=I2cFR1qF; arc=fail smtp.client-ip=52.101.127.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="I2cFR1qF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e4ueHDWdikVZNE8mncSfQKRtwNr3ABK3J8qalFru128Mhj0r/q/vO9ZjLrGYNQ2GbH/GI/Yy0lpZVirc/qyOR8LhIgOkkthk/qk31J148vrbep9UEnQkTQUO/NuhyUIV0Ho18Cgn3buKNHCspQh9bVnrYW28lyfI6QFDnd9jc3yNl9qKgemEU920rG7U2IKePnd9IzIQkD8T5D5TAkD3sVHw1GeK+vuwsrbJS5Jkavz5KvIBLRpLRr5t1dvs9SOCVUqF5PMp78AX8pFcNV2akErJBPpHY6QEfGM90ttqBOxjmhu0fjCIErEGcEjzLsyyVV+MhKGb6ImMwx4/GulIYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tRLjzL7E/KFjE9zvRrWx/9NMf0yh4xqN0r4HJ37+NNw=;
 b=DuWHT4GRYDn52fuM6EUiHa5PAb+3rexzJqzk94r7yPUiK6LnVgPNNTn0cCT7dPKT6PzZ3m0uuJ/ov+gG+B85qwUb8XOlHwsvBm8e0MuuPzo7HToKlj2gbc3t1XFGOrRNakOSubokNb16u3I9R2mkqNzFwI6k72Dn8UuNcDu9Ox2CydVsAmXhEszVbIKQ8SwkKAI+/N8c5pLja7yr19UXSWU1sfss+JuFYeXeB2zkKAWuqAG3C75cnH+MkfQFOfogSZdiHFOmGz/nGQI5gyb/FeJnkuD679fTyPqx3qRjQ58qykIbu7bnNoVcn6u4++/cE8MH7GyxAp3Rf9m8k9ubYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tRLjzL7E/KFjE9zvRrWx/9NMf0yh4xqN0r4HJ37+NNw=;
 b=I2cFR1qFEm7Jv/+7JTVjEda2Gg+Uv6JHKFufo0J5kCzW7EoP0UpwreOQlSeyyfWWp1W35Sq/MAwSPy8BE7NpfSCtKFvRz/w5RwFbX715XO7T4QA/5UZdw5pV/n9L9mmynk1fUJQpeQFQXvEqQK+D/6NLbYVqlWBbdd6pqAwCJ7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:03 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:03 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 19/31] serial: 8250_mxpcie: add break signal support under RS485
Date: Sun, 30 Nov 2025 18:42:10 +0800
Message-ID: <20251130104222.63077-20-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
References: <20251130104222.63077-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::18) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de18c95-0c6f-4831-4008-08de2ffd848f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RaoSjbqQ+s3fMZkhVxal7aQ04V3YkJrAyWWsdUDA/7GxT6aGcBquecxDOk2p?=
 =?us-ascii?Q?F+h4xO8YzrZe6fh4/WQO7+WyL1ggo7ptbIHuNbLTjecKX59tYNgCng2ZGpqf?=
 =?us-ascii?Q?GPoVdsREU8lXTF3tX7Q06CPt17eiue6GjN+uAqciyu64mq5jC/va8irsAsnG?=
 =?us-ascii?Q?i7CrlMmUWz6bYbsH90GEkzDJdDU1HjOLm1RCPS61lBclcSYX9U8cZqkKVEpc?=
 =?us-ascii?Q?TzDaGt+Evb8DsxbV5Dl5uq5Tcpq/yNq2Q7QY7jpxWN3Zt8QhTHAHNiD6wtjK?=
 =?us-ascii?Q?8XkK7HFezkjYkb/j82nRpK29OLOLNqA+LPRS2YO8724g23nzwI/YL9DVwwqb?=
 =?us-ascii?Q?EgfgRdCB3ivznuk3ktr8/BJVusB6P04nSrixUsROyNwoWhwjGB/maz8Z5ShD?=
 =?us-ascii?Q?zUB/fMjbQgYBmDQ8T9qhdLQdL6Ep5mko8QkRTnrN5FAFh5Iwpommf3UpCgCf?=
 =?us-ascii?Q?V4pHVMQw50x2kzfyfgrU11TTC8CYaHPVSk3pDEMIlccq24fja6oKtZLkkvIN?=
 =?us-ascii?Q?pgksE5b1zXOudak50ZFyS/mGw6QALvNHKw1PEWrTumvyjbtEdKhYuykuzJii?=
 =?us-ascii?Q?5/T/CYsxa/zFnV0GAelsOfrjI61PlWlvKL1q+zOqvohLkIyahz4r21SSE4Tw?=
 =?us-ascii?Q?LWyqtmr0vngvHbJngIjuvCqhUmcUCiZ9HTl7iUAchLwJDhSc6tbn+NHlmmew?=
 =?us-ascii?Q?YMCsgzBhHAfyJ4w2uxNIQYdh8GO+QwL1HCjoB3Ie0zRmIRgqezFkyjuARq8W?=
 =?us-ascii?Q?dcmPauUrLUVtXjx1LB24QHdAyQw7pZSsvLrLhPH4FGYYr/513xiLYRbv8Q8c?=
 =?us-ascii?Q?q+xc961yJa3ghauL2C8PgYx/MDZE7C09C5yYWRFYoxPna20m9+QLRpjFsLwP?=
 =?us-ascii?Q?DCHJnUK5YfK4JXma4Wsf2SKGXo8myMpcZwr4mNNLjtKm6MpJtyudJ6b8ygDL?=
 =?us-ascii?Q?kisNUqz1MFEnHzrr70nK+wVsKwRiAt9r/p8nJloHdTxjA1ZxKquezJFSzPIg?=
 =?us-ascii?Q?7e0ZMdAuD8NoJxYhzTGQv33waPfRxQA0fQCVVQpImAlrp+Yyze820vDc9wkG?=
 =?us-ascii?Q?Xdd01gWsM26TZSMB6XigiVWrKQob7kP1uibuEceByXFmOWoZMvaBn/Mt5uej?=
 =?us-ascii?Q?qVSk4R1S67GaZz3h6ALCI79SH4xrs7581Mb8vKQvrKu+EZhdY06Xx5eHq9h8?=
 =?us-ascii?Q?sG4dD4wiYm5j8jzbGyMbYJCidzTQ9E4wnKwFAKo/zF1thr62JOO1U0GGj4Us?=
 =?us-ascii?Q?f04jD5wYYVZkBoax7lBQojMiVzWlteRxTTPCiuYuuJPcGng+7wFuv94F4eQ3?=
 =?us-ascii?Q?vUFKtTk5Fnp1HdoVBwoCqPrq5RE6gCFR9kB9E0rNWzMKR2UEu3CLFe8alk0q?=
 =?us-ascii?Q?UXGY37Pd8XCqYluucGiNOV+jnvCqnqjFGUwoGrGBhbFDXo6q/mOED9GMJHcU?=
 =?us-ascii?Q?Y8VfxYlmxnytEJTYfv0HhBulloPgvm3D/yV/RRfAy4GDXESQp1+SszD42ErA?=
 =?us-ascii?Q?d29xAxQKeEYJWGVHPGaGIfkgOQPGQVGbLWcK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KQXmULUxyjlX4Po/xoXLQKiOL8wQh6eER7yQXzRigm/PvTTMjBH1snSM+WHV?=
 =?us-ascii?Q?3DJrwHllY+o7yfcZ7hecqiNVGTQ1WhkrKwovwUynh1ot/V4WtKe+ILbnXF5t?=
 =?us-ascii?Q?9j3u8TERzCVSHvROXRVQgnsM1/GTGBIFQjB8CZ258xWdpx/IorRCnj2oVcZx?=
 =?us-ascii?Q?Y7xvv0VolcZgHtKVuXIrpK7CSyBTU/7B3dFJ8GOSA8ohQ2SmGH3e/Xwc+YkJ?=
 =?us-ascii?Q?pl+TCGCCe35TAQYHS0HQXPYXTTtY0aLbctFd/SxQGSvhd30Cs3Vy2DTWdV5a?=
 =?us-ascii?Q?bMKYfWhr6lcMqoxtgVykbIvy30INEc+uqwz7Ad+qWNOarOawIaTXZN0ZFmCO?=
 =?us-ascii?Q?ysLc7gyLH1PHO1OaHx+N55wuUpFIJN8N6voQOb/X57IgKxkcxO/mONQrBoWf?=
 =?us-ascii?Q?EbPX7fYkuGiDyvJ2CUxUglOTfcOWIDnsFZPvs9LjKAyU0hx0kW8mlYL/hUlR?=
 =?us-ascii?Q?qnU+3LPRXSLWiH4Jwvvh/L2/A1x+VLQ6OjKu0FpmFq9AM5LgDEjHoh9O7i8d?=
 =?us-ascii?Q?4OKaf7AO1tBspX/X11zujuV/UXve7Y+387Xr4H5G8Zhdgiv2r+UYHppHe0EI?=
 =?us-ascii?Q?/oZ+40QB6a89zvDNqNAm0EJYIWhIn0GBn8FtUGJKUPhN2U90iz1SrOZNJIe7?=
 =?us-ascii?Q?gSQaEVX8dcES55S7nmewRez6YAXCpQEjsFyw1Yct8HiSDitYNz37whHBV7ed?=
 =?us-ascii?Q?LSZkmfHMDtD9pcEXkKGDO/CtezIhfC9tk5zNCYHf8BP6CtXIj0qVBSCOkgH4?=
 =?us-ascii?Q?u/t2c1ky1qNx4jReCRkJFl6uJ1eUhwSGTIRU4984G1pSrRj5K0pYbMTQsroa?=
 =?us-ascii?Q?be+UR/Ph2y+pDpKaHvysVi++zQTYLMPYwGDsAessG2rdlqjGFFHgJnXG5ABc?=
 =?us-ascii?Q?VztbfIIZMkMGgZWYRaYEBdOwT3rKcflvB/kteTyfTRa4Q11YvKcV3o5HG0o7?=
 =?us-ascii?Q?lmQry7NeJ5PagIr+5cB8MgMY/4E1ZTVOf77ztcoUeiw08QRVGVfsfPb2nXSw?=
 =?us-ascii?Q?hmRPqel7ddC3pFflW3sgDckz1Irfa0xV0+dZ7FGS71ooqJ0lXTjAn9oV1z0j?=
 =?us-ascii?Q?DdsbroZxlRXPpdju3JHE+B4WRt++245xH3WVyqa/suxcfRYn56CjbBMBYaet?=
 =?us-ascii?Q?0Ql0qfTobaCcg+1rjdjFVcXFsybWOqFLtH8MMGU2T4ZrPc61JIDOZvRT9YcR?=
 =?us-ascii?Q?/70JVgU1L9q6m4Ruwfbr/ISoi2V0q13MxoQDsYuB43CoOSl2qMRbkvuv+cV+?=
 =?us-ascii?Q?cLKt2Db5sGjfXAZciWX8OwbVE99WOMBEXIqWLlTxe1isLBO1O4IsNRm+p0Lp?=
 =?us-ascii?Q?cEI2vYXhIsrzt6gLmNt0TSo1e6/WZ8n34A2wkGDndCdN8+JBLQ3IkMyLCG8n?=
 =?us-ascii?Q?zHxwv9dP7aDApMT2aVlJC81qfXa1LnRjtH9f5D96ifRHMIe69t3GeRvpWTVl?=
 =?us-ascii?Q?SN8Tjh5HNfVKY/jxLxwK141MaWVvbq03XEuofjdPPAzmKBM7YnOy4Ct9gWvd?=
 =?us-ascii?Q?DlkpVetLU6mfr0lFwSougHnSnAS7J8kwKEHTkaywkevzmSV8vrTRuiL9075W?=
 =?us-ascii?Q?l/c9RdyssCINImL1e+45CMt9as+K+AbJ9KlaQNrry1gGlvrarAbYr/8sczXC?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de18c95-0c6f-4831-4008-08de2ffd848f
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:03.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OR3+sinAyLPtckw/4m4g4pzukmEVqhyTzzZi4MHIbNMXYE9OpETM2oxjzGaO28MaCpEk7DIag9p+7GE+JNQHnhntuF5CKg8ZR8xlE2WtwdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

Moxa PCIe boards require a specific sequence to send break signals in
RS485 mode. This patch implements the required behavior, while falling
back to the default break mechanism in RS232 and RS422 modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 52 +++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 5d1097c166e4..9ba171274221 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -40,6 +40,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -390,6 +391,56 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
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
+		memcpy(port->membase + MOXA_PUART_TX_FIFO_MEM, &tx_byte, 1);
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
 static int mxpcie8250_init(struct pci_dev *pdev)
 {
 	resource_size_t iobar_addr = pci_resource_start(pdev, 2);
@@ -487,6 +538,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (i = 0; i < num_ports; i++) {
 		if (mxpcie8250_setup(pdev, priv, &up, i))
-- 
2.45.2

