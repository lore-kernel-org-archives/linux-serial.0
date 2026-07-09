Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013064.outbound.protection.outlook.com [52.101.127.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF763B3BE9;
	Thu,  9 Jul 2026 05:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575250; cv=fail; b=lL4ILXBqoipsIJBPv79H8NRHL7UjYc0IXzgR1aNB31LXdnJec8snL/9UPf/dlnIZ2c/pJrH8n4bhSiCCoU1zdysAjFGUycIDRHTrLksBIdqT+mwuCGcXs/MsuziELsr9JqHS7ObKQMglI7zVjx8gZH7nNRMwZxkFAF69lW0mWF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575250; c=relaxed/simple;
	bh=mC28292vgvkf7eo7aibnbuJxtPvPzuvJGgItBxuh/Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iHaAzK2bZUsh6QJBtT6DyJSVOb2PJgPPZDYpjkykxeuy9ybBbx3VVtvUhi/bmU3a76h7/HUxWwynlaycq4aAVf/TuLvopD1ryttcAbPU/mXzxHCDDU49YPLyjizkoHqHskXqGg6/6POeLcKkOhSfgr6QBMZrA33+7yx9/7j8wiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=VJmknK0W; arc=fail smtp.client-ip=52.101.127.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="VJmknK0W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPsmWqYon0B/G3cb/sHOJyHy/XLjF7An+ZS0mPKI224yEIOg1rrQu16dFo9Co0RsP7yunIhlVHtoAaRmQXNqEwMzmvH6VsA1d5Kfr3/jKnhStoKQg10zBQ284WmZNktH/+VGWxeLxJof0COYCUMni6/2qZXDgOleRlKVmosUHgJHe2TOnzsZofTGZl+Uq+ZEF+RQ7751Ucw71BH5PzinT+cVxLaoz9BJhBF61zGlqiQk63gFk1HdJ5axSaWcFjonfEKdpV9D4PcM/Hj8nkSFutVugJj94QFCxVqqzDkHxRajujdcUGWMdFwjqXBbtdFwTmRjvgwpP7eSlk+q9Zy6rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I/zfMslzS59dqLJvPNHncZ+5Lwj8Eq25bnU6T2kQ0ZM=;
 b=qN+xYKRa337StTeNRyqzIn5XgXvfV+lU4frIA5dM6h5NIEeAD/THmX1ZHzWNmhiXeErsUtYcp8R7Lo3TWlW7Z7ZEeiTtqkTFgnAAtZwswfz4md8QvI5KuCa3h5OnFnx23maxe1I+m07Q3VBpqN4WmSJ+ki38uo8ZVZyLtY2mM0WnDKtWVmzR5JiDtXYmM3PFg6j0RUTjU3rDgqGs6l51xPMgofUgvnttWN2MA8fUd0n7mYJOe0Rv7Yd+bIbSCqJ4zroV9JRfSTczGjrbLsyGKNnbEKf5Jtsv/639Q1gExBxMbdcDPTg0sqc9SEn3RFa67irY+LF75+ttHiMSKUULxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I/zfMslzS59dqLJvPNHncZ+5Lwj8Eq25bnU6T2kQ0ZM=;
 b=VJmknK0Wdp48QjsYwIZjH5judbXQWpLuDlrJOLwyt6Yu+5EwTfr5RoF0ScBNuEOwBnI1YJ8ferITnT+MpfNKtT5O8gEoFVxeZeBBN+OLV6mzGjDyHz/3rmIwmZkNdK2j5ikrSc8Kl38JTln70UNEoKwEwLviLTxjIGACGwzq8Xo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 (2603:1096:101:d8::6) by TYZPR01MB4610.apcprd01.prod.exchangelabs.com
 (2603:1096:400:260::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 05:34:00 +0000
Received: from SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec]) by SEYPR01MB5387.apcprd01.prod.exchangelabs.com
 ([fe80::8387:921a:71de:7aec%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 05:33:59 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3 13/15] serial: 8250_mxpcie: add break support for RS485 using MUEx50 features
Date: Thu,  9 Jul 2026 13:33:12 +0800
Message-ID: <20260709053314.435629-14-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
References: <20260709053314.435629-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0056.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::7)
 To SEYPR01MB5387.apcprd01.prod.exchangelabs.com (2603:1096:101:d8::6)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR01MB5387:EE_|TYZPR01MB4610:EE_
X-MS-Office365-Filtering-Correlation-Id: 31f632b0-4800-42b9-437a-08dedd7bada1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|52116014|56012099006|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	hDxkCxEb/6tJQ4ZRThxQ1kz8fxdy4gzbdskda8lLoD9UF3X7WMNVD2VxxoTQFyZ9j0gq/uy8eAeqO5DV8+oFNv9NElAO2ERTW4RdAD1sRXVF1GlzyOtifkUZq+RbnK9CZPv46lMrA1XQ2e7TUlvo1adw52sIhZzKc5ubx4WETaDtD7z89wiCjMhK9JCk+nHWEztBZjduoGhKs5oKOEKVK/M2mLQeaqRzmGY+64znZl4ZQGUthHWUa66d5nATSobb+CQyGGD2nVE/uk1lWLEO+QnA06KIa9FCQUITfSkE4fJboyWJTMjnK/GXVZ9nEeM+MJNuhAQNlDAPaIaNYY8EwAoxEff2F8NeVJuQOA6nynFm5SoAw2yQxMKIvrScttQsZem6LIYcOgoiWGz5bGEY/6iIgnv5mEMsN0j8zr4zkp+pyLKfhxthTJ/6/2Q+TIAcQStUihNIhM/hav3GsfkRFNadWjdjcbmwYvDhd6SCwLJBxp8dB+28ai9dklHUw4+Xy5p/OK7KmUrNQM4TMxlY7xmapAsvV7+JjPJX/9aPiCV/z4lyxbSq3KMhhjTcRLbUFRPSyLxrCTFJcRUPUhm012K+MVa2zRsEK+66PHPsUfNzc1RSwIpU0eE4WKwkKVPR9npishZZ3kfhrDAoHn80LfiguICUy2Pr0N0t3Ncv97N+6O2PmX3Q3o0NCsi02gfX/1QXGRRp29IK2t4+fsqwp7hSSQ/6ko3vatfC8l2/hv4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR01MB5387.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(52116014)(56012099006)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NLbTiItc5u3lDuN+edo2XLlJuWlShNeTsRgG4oRxlag9iPux0wtJF6hblHCx?=
 =?us-ascii?Q?pSXdTyJD5xihU2WEWCbEru0NLbN6cfWuMx1qb+K4+scCuB3ogTLJ/Ue5boZ3?=
 =?us-ascii?Q?/hOzgOnd52n76XhAvmgKf7cHCy4XziZ78y6tuD04KECNxjvOkvs77I0s/bhT?=
 =?us-ascii?Q?lJFL3JkpAdJE+nrRtQxbe1uJWvzI2PCT7lWC53vNP1WoZhJYezAdAyfOECFC?=
 =?us-ascii?Q?YwOYdLJYYJfbv9d8TKnRrUa/2tfjPi3bped3m45KBkGxHhDB6CGR4y8HVwm6?=
 =?us-ascii?Q?qhFiGVe11frIBicqc6DtcYCKWLCpKM/MtvJdXHB5IREy9ebbvPwO27CH7dqI?=
 =?us-ascii?Q?o0mGKicAO6i61gYPfg9QTsD55YwTBeMOvrXM9xcofMaoCbPc70PWovNtDMWt?=
 =?us-ascii?Q?pMg5/G24UTuncE+Ya4SZnB5gQdR9Yc0MDssZYtM/eTEVYT2X3fk1KP+bG2t4?=
 =?us-ascii?Q?BekgG0MD7W9F6g2RH1+nW9eVYVs8KOtSZETqtvKOZxQSlzerIboniMT8+pcq?=
 =?us-ascii?Q?PkrhdLAUwifiv3j89dg+SXEh6RNcHArJQxRPipe+6Ap85g4LU5hqt54hkDpG?=
 =?us-ascii?Q?oH4QP6LZu7TyAAylGtIaWV31pxTMwboW/cljev+Kppc0Z/Y9ktnhWVdXj4B+?=
 =?us-ascii?Q?EBHnmA/hrffv3WpWsZyTU24OrmXgi0l6E+C+77SbMyuC/SbLjbI3hiA9EjNB?=
 =?us-ascii?Q?YhBwNcTss0Px/UnXo9ds2vAw4+O21+I2u+cHttU+uCVf4NQn3FfaUNZPaAcd?=
 =?us-ascii?Q?yNGR4C8VtwFKRbhV8B+2PAGAbUWzRgNI5s4lKRrM7GNsAGI6nWDqxkiAsE5h?=
 =?us-ascii?Q?+2tyyGMz5uSgWmxTLZcvW1lTjGF/dsQZZDeIRR5s6/wHGmS9aypHW7083l4A?=
 =?us-ascii?Q?qODrFq48BVvB/Ev4aZ7PqQ6FBFodnwtSQtIZfWs8opSzRYxCM3+bs0IrkG0h?=
 =?us-ascii?Q?Vfz73F2eTTMiV/HYZ2o0ADdwKPcIaihCef9QAh4DIt7ZrKfzki0TiW9//8F8?=
 =?us-ascii?Q?xX7RyGehsLxtbG07x57BaVBTAqoW6lOp1xKlvmHpuOcENU+3pkgxv5TmwTqQ?=
 =?us-ascii?Q?Vras3/E8poU98+zW9mKgEqzqiP1b4l9FW2KXIIWD73TJtWZz7ka0d23NkRtP?=
 =?us-ascii?Q?/Xtpp3f7o8NP3Phh18DZhdZWeBHp91u7962a4gG0Vrsh5msnrYz7v4oSUy+z?=
 =?us-ascii?Q?40Jj+Wp0t+ZwlvHh1uuqXH/8Xgqlf8yQfonDXOdEY48Rf/zlM17oNY8zSNpj?=
 =?us-ascii?Q?BnUNZas4fV9IeDbJLTy5Af8keHhAEP32h1q0wQOfpvwz9kRcWCTk8fn1vz/4?=
 =?us-ascii?Q?Fqc2mbM9imIQXehiVhuyYWS4q/5zrvuh5/dnbeLaDrlZPkw/45AUo4WSo9/J?=
 =?us-ascii?Q?jwVFYtOJgWVhn5l95Nr2uHzZhIrEBlma8GicvEK/8g3C6D2kDw2LhD3FWpy1?=
 =?us-ascii?Q?FWn+V665iFO6lJpaQHvERo6sd+7QgeajwHgZOSYN9LSkBmJQmlSm3HS2ffWe?=
 =?us-ascii?Q?9jJ2oK8shhCxwf2pq2nkoEMSpdFnXtcJAbGvI1jkf/igXw5K/c9H4Tcx/5T6?=
 =?us-ascii?Q?9hj7icjCWKwKGDfzo0QcKQLqUy/OFtDMOlXgxQJ07j0uZ8zCxbeCM3TM9UV5?=
 =?us-ascii?Q?YL+cQ0wPsCECYbGC9rcLePBFZ2OAOkvIxpQxfK3iD/1q/nkxQjio6rLukNd/?=
 =?us-ascii?Q?8SWgO97uVzZgWCD65fY4rQLpKSlDBWc2bNACscm3rHaxvVUDUwi4APsDdpBr?=
 =?us-ascii?Q?PDLOcNmzB0kzRlOTWJHczBREFtqaCTg=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31f632b0-4800-42b9-437a-08dedd7bada1
X-MS-Exchange-CrossTenant-AuthSource: SEYPR01MB5387.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 05:33:59.9108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/5cP13Li2WYmWNUr8c4fmn+Fbp47sL6nN/WlLKkiUYdBo2BMxRoIkGc/bfi18TvhxVyV9Jbg5dhA42jK3CqOB2gXiP/b4+0hRxUb7z27Ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4610

On MUEx50, break signaling under RS485 requires a driver-specific
sequence and cannot be handled correctly by the generic 8250 break
implementation alone.

Implement a mxpcie break_ctl callback that performs MUEx50-specific
break handling when RS485 is enabled and fall back to the default 8250
break handling for other modes.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index 695a896adf19..549973758542 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -53,6 +53,7 @@
 
 /* Special Function Register (SFR) */
 #define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_FORCE_TX	BIT(0)
 #define MOXA_PUART_SFR_950	BIT(5)
 
 /* Enhanced Function Register (EFR) */
@@ -422,6 +423,53 @@ static int mxpcie8250_handle_irq(struct uart_port *port)
 	return 1;
 }
 
+static void mxpcie8250_software_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	struct tty_struct *tty = port->state->port.tty;
+	unsigned char tx_byte = 0x01;
+	unsigned int baud, quot;
+	u8 sfr;
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
 static void mxpcie8250_work_handler(struct work_struct *work)
 {
 	struct mxpcie8250_port *priv_port = container_of(work, struct mxpcie8250_port, work);
@@ -535,6 +583,7 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.throttle = mxpcie8250_throttle;
 	up.port.unthrottle = mxpcie8250_unthrottle;
 	up.port.handle_irq = mxpcie8250_handle_irq;
+	up.port.break_ctl = mxpcie8250_break_ctl;
 
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
-- 
2.45.2

