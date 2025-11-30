Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023115.outbound.protection.outlook.com [40.107.44.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040B027F75F;
	Sun, 30 Nov 2025 10:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499445; cv=fail; b=bazlCRZX0C4gPIWGR+xYLt4tp1E66p7RjnRA5oQHSlDmA7PrFt6ybdR/gOi9XOWA1u33w5mdEvBdQFMeCKAh34p9IyabEVM7Thsxhbs0NLHD/176CbJ3Ao6Gjb+dN1dPImQ0VxIyokikIje7KpqAXtB9JC0z/M1S+LMK4qIt5Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499445; c=relaxed/simple;
	bh=c0Rp1oB+4r0M4qMBkXqhLHMEv4vXY+RSVieb+ocAucA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Hn04yLcbcPEpHQbdHQnt0/K6peIWSPK/8U+u5qEbP1/yH8JPurROlMjfR8zCyYCfcr0z7eJqyIYOZ+8ImAaYdyloLQH/88tQFywimE8eV/2gEntKsm83abCX81nCUlZzla00bCjbsoxcJ+HVEg1VL58p2Nu7D6YJGNuqJmkc6hQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=ZCqMq5GZ; arc=fail smtp.client-ip=40.107.44.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="ZCqMq5GZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLE/8PWWKN6oqYrYC3bTPva+lBNHiQvvRZQeK1ugRaSKiHQO7lmH+6EI6jWJZq8btjMsd7mZeIR61MeuKbg26A2k/Nvn8ImEDYYYEq2N53FKIe+26/mEURO9II8vWeY6IZEA2f7uIUeT5daTtl4qkEJwacPJ/8KNeujWWIwshBNd4vVokTn/eKQ7X0YZ/bnylO0Xc2USknzVkz1DZkWe869bntPFObc/DvLfBQhCzLvzDTO5M+R9Zv5WAHo8Yvv+Hdla3l4HH4tX80dGp9it/xa1SbRsyx7EtArrp2GkuluvN/D1s2rCHjhgalJb/ZpyhhrHXKFpGhexfaVp9dghog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FP6TpyU3i9JoWmrFzfZ1VWWgupLiSJ1mG1091RguLrI=;
 b=Jy993IAE4ToEziEHEniGQlZJxsxU/U5W+LONaKn0znCtbMbHVTDb1aAMAfderoFWPHm+xoSYc8TyaN5w6BPUFkBffFMi2ObngKpJpj3uEkSdbgRf2RiJx5ePcuBsNeKnIugjfuizl6Xfir2+5q+HL8OVlElletRHubz+7WhwGEF1qqxqeIb5AZLsyE5hDATrmZkPmM1EK+UaOShx2eTQyd8aS0qp7Y5oeoTPr6fEh1euUrSgaXFsyIZt4A9Xo9nMIpPgKKoE2g8QzE6BV2TIQ/1IIWygCZiAc4bxMF3J2FPEzjgEefKGM2ouLhh7yl8mZtXhEiW4FvQu9EwrZVz0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FP6TpyU3i9JoWmrFzfZ1VWWgupLiSJ1mG1091RguLrI=;
 b=ZCqMq5GZOiQsdDUm7W6mdn4He1mhe4LBJ715GNrM4nJQmexYfBc92tgViRPjviApMofRNQPw9JiRXhjKNAQvpss5VKmefe0oZTgpvrT+WjWLrxOK6Pz/SBytItrytNfUNkO7lx+vi0bqNWr6zD3prbCqFnOU1iC/K7kZhw3Y180=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4235.apcprd01.prod.exchangelabs.com
 (2603:1096:400:1c4::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:43:59 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:43:59 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 08/31] serial: 8250_mxupci: add custom Tx routine for 8250_mxupci
Date: Sun, 30 Nov 2025 18:41:59 +0800
Message-ID: <20251130104222.63077-9-crescentcy.hsieh@moxa.com>
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
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4235:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d96de11-f1f0-4a5f-a965-08de2ffd5e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b5KzWqxOlM8FcXUwucVrJC+JEGYQn7OhSZFmHHH/gRh2TEehaCOzMNH9tKJA?=
 =?us-ascii?Q?CKY37PS09HmQdfKqYAavia21uhiZZIdXVP6NgQW/Nt8VmMAV6Ww01Jom7wlE?=
 =?us-ascii?Q?X4b7sWdekGHN8TB+ScUkOMl94tfKHIFlAAu5/4o6Q8bZP4WXzvHKHel4Y6Q5?=
 =?us-ascii?Q?8IMfozNf4EZHXsSDcXJbvJxh6GQoAmJ1Us0CYX37jPO1sPCGNSmSLCfkOivq?=
 =?us-ascii?Q?rjjDAcWMWvDRMU5AOivuZlRJ3B0NOyFf1mW1BH40AA8Vd1UCYbCdE1I2G2MN?=
 =?us-ascii?Q?yNOImUVCDiM9JiKkL3q3zY7kLZm0jqVIRFHhmt6SJwzo9VncACuN5OEVTjDP?=
 =?us-ascii?Q?1xUPzzlarFF7UVINyMK5sNqdEejuIiW+hfkUVqeKPwHwXDL50Xpeyue6Ztud?=
 =?us-ascii?Q?bYklADsHei5crn63+uEimMLox6SMsB2A4uvkhZHfc+urNa9HmKpeASj3D5yN?=
 =?us-ascii?Q?7FxCwZ1RrIDcTsyJvFhqjz1cGhipq32rmqKuG619ybLdr98xr74NCQnqeY+g?=
 =?us-ascii?Q?tiHtLc4sp8xxxbf2RfXQFLP7eR5DGYWioDNcWR88XIGxKzH4lAMyxBqRTnOs?=
 =?us-ascii?Q?6OloJR5iMAdQafYl6/GoTHw9F3eDEzH9D5miLByHWvBkxiDZo1DAmu6+bYQH?=
 =?us-ascii?Q?NoJcpiZCHRLh6XgOpxI/H6fj82YetDgem8z1QtLz8rGPejEtoNhxWDwpi2PH?=
 =?us-ascii?Q?7oLIAqg1/4Yag0uGQSiTRQPdhzmHBkOkYbn9MRpYvYloiY8CiQawhOFTrtyE?=
 =?us-ascii?Q?2/ncZOpozHindcfZylImvbvTakfjkruq97y29/TOJDYDDeO+bzmo+Nw8xf1K?=
 =?us-ascii?Q?8dl77Q3zbyFnSR2lF9a/pYCIeeEa/UeyU/q0ZMAqi6sJEOF57h4dsijdV5Bo?=
 =?us-ascii?Q?D7qz/0kO+iKUrZwYxsvX++7LFyCrn6NGSYv1eA7qvkXjyybKZfbNCf5Y8G7J?=
 =?us-ascii?Q?uJId3I8JcZcJ/DrzgchO6oJY1L+pv0C3jgOFs2O/ok/8Kneld9Ps9ZJLbXBq?=
 =?us-ascii?Q?zePikkhhTjJ+YnRfYBrvjL1rXbfcfg2fVMb6DAbR+aw5nZaBkFmGg/YBI9hC?=
 =?us-ascii?Q?YPM2Nx0t3SHIfRwh01HdQ+CQdZPk1fsXqJkI3PQJO4WCJZgH+R6DSGFlBXix?=
 =?us-ascii?Q?qF5USeWn5qRMDFynZcxKL/CBQCHjisIM88gr3HcTYkS78fTOih2Xs0xVCFHr?=
 =?us-ascii?Q?SrGQjsnRJjT1vKpKe171Z3fpKrA1uxEV87IVRyxPja2egU5rkkVwq96qGUhR?=
 =?us-ascii?Q?9AXtarfe+i0VMruaOLwNq3uft9b4509Zk97Pe4FcQbkY254pOfS4e/FoQ79D?=
 =?us-ascii?Q?FEstbgSAzFKgEazaWTD6KxPhOnMRMFYWs8dfjZTCE42QlFTonwRocy4c8v1Z?=
 =?us-ascii?Q?CKpLR+iQI+HhnLS9qO/6Vrs/p+KFnknq/sJenpr5oCemgmXrvdD2vXb/9EB+?=
 =?us-ascii?Q?4qFMPLt8hEZj87cXef9TejKyNBBgWqWL3+GB2YBwqqoZVG7CQUkFmqbdDfob?=
 =?us-ascii?Q?GThMulk6qSOU0P4PKyot0DHwdoM0HyO6USZf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Ajs23mZswQI4VgOngOQVd42cFA0XD+PEkeB13DuNazWrzb0rFiqFFqMdKa9?=
 =?us-ascii?Q?JqQCi/twDzZcELU2FlbPZqewOjH2spUnl0npj1VRE6hHA1d1it62oEszXcFR?=
 =?us-ascii?Q?syqdJHw6F0rQir6HPpnxiFgIdAHGuwTuojbot2B0O0kWYPsiJP4eJzbliOya?=
 =?us-ascii?Q?rgNAIDEiYLrJ5B6jAWt7L4kJLZavsD3K1pB3ioVB9XjtNcQkCIalJqozeu/T?=
 =?us-ascii?Q?6ezAgt1se1pj04pj017LoVqDxWYlEDR9ruvAlK203z14uMz9S4x2EM3VDvmO?=
 =?us-ascii?Q?T7aGSkW/xLvPzhEcDeRWQvSgjd/KPV/xwpQTOG1t0g3Jtt6ThO/phyLl/qfc?=
 =?us-ascii?Q?hQemUp0wUOdQH02shDMQBzFK+IM8UWl4iPzxdmfoGFCGrls4nIzo3CYdKm8+?=
 =?us-ascii?Q?BLUUg0+MQ/codhOaosLyj88MR7i+iX1AAiI03kizGLcG3ckxnDF8kCWhPe/o?=
 =?us-ascii?Q?RW83ZNTaFHDGh5b0iNVoEWfXs+IXMonBFCF0n6TKaAqwsR7DpLOGNTNhwq8+?=
 =?us-ascii?Q?6qQ+2UR+dGpMJIqtV39xh/GZzBnvutoMzHeJvBknGlZ6cf6CMyroOL2O4vft?=
 =?us-ascii?Q?TN8UsCquUTzfxLuNHEByuNZCGF90YW47YSh6NdPZiLyWyBaSYMrtJLNwpyql?=
 =?us-ascii?Q?daXaBPQm8hPhGVTtZ3k7eCXx60+TcNrAjuSqCZrUM83PE4Bht5bDCp5VGO/3?=
 =?us-ascii?Q?H3l/UZkU14vlmeeg0WtTu+PnPUDxu/d3GCkQT84bNIp3dhnhDsTcq7/gPOVv?=
 =?us-ascii?Q?jM+mRMUD6sLMEXtA7CyyQPbEXWQjpUMF7cuOPlUcEUuM4oswV4uyLVOczoLV?=
 =?us-ascii?Q?NZMdDhCCrawRbMmsKTDenp0aP4uwj+crCq56F70KDH5F3wjOmftE90xrYAve?=
 =?us-ascii?Q?SORzAtdzvFNH/U44cYSEPmeYTFZ0RRLetEYmHUU27OLEw127Gy9+flb+hYDj?=
 =?us-ascii?Q?QXjJG4u67sY2j0H8yzjGDlaHM/SkhyOiRjJ1O92TH89D6AK63kWAXFlRpQEA?=
 =?us-ascii?Q?4t9DhaAgHnzUJcXF4ePQAy+c2JGqqPOKMigbWqoiu1H9I6hKI9hDF17j7c/K?=
 =?us-ascii?Q?pnYwUFtlmLIBVYz8t85jt4XBqFBiP5sX2OBc9z+sJnKVm4b0Fw1GamVXyyzx?=
 =?us-ascii?Q?2NfrMz73631lL6T0a49qqVTCkLPmRNZnT8Z46asSx0zSfnxR/lhodj4DYmVq?=
 =?us-ascii?Q?Igv1C6ag0aUyEiOU45zSryveZwCxYmZDOZyp0OWkt/dbf7AYiEJbdcUeZz/j?=
 =?us-ascii?Q?tnYVl3Q/Gd35GRW3eZRsD0CjJOzIsmfEADuqN3nqWw04JIL5/SSNn6J4pFlk?=
 =?us-ascii?Q?g+sBrEUqst14HmXPzEF/2aoQTvqycIyh/P5TMfui+0Gcj/esX60NPv8YwGmV?=
 =?us-ascii?Q?ah+L+x2PgSGliuFxuTzMrBtv9adTL7IfErIgH3Fi1qmUTtvxJlxorTGSbXRS?=
 =?us-ascii?Q?niP7S8TTu9SW0YdFgVKTQRzdBn6SjC5GxPk9ABser9WHQuMFWsCVqrAc1cdI?=
 =?us-ascii?Q?OUprBQTDbutBXy1ZsCW64K39Rht3TOzXewiVVBOO2uEh/lAuCui54L/VN2T3?=
 =?us-ascii?Q?aB4AaE1NdiHJI6o80uN7p2+Gq9v4TXEuQYGlm40h4wFp/BJbSILbrJtW3rQT?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d96de11-f1f0-4a5f-a965-08de2ffd5e98
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:43:59.4616
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hY/qOCY8CMNaqEUl+ljtdHaZ8OyfY1b3oFR4EJnVow8R0hM6KO7J3vPCuTn6z3gAydHgE3fuEkbBwT+/+RMUV7ATAisOVtPpHt9ZkHmXBPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4235

Implement a custom tx_chars() routine for Moxa MU860 UART to manage Tx
FIFO and xmit buffer handling.

The routine fetches up to fifosize bytes from the transmit FIFO and writes
them to UART_TX using serial_out(). Wakeup and stop_tx conditions are
handled based on FIFO state.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 33 ++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index ab6042f157c6..0eeaf0fa1538 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -240,6 +240,37 @@ static void mxupci8250_rx_chars(struct uart_8250_port *up)
 	}
 }
 
+static void mxupci8250_tx_chars(struct uart_8250_port *up)
+{
+	struct uart_port *port = &up->port;
+	struct tty_port *tport = &port->state->port;
+	unsigned int count, i;
+	unsigned char c;
+
+	if (port->x_char) {
+		uart_xchar_out(port, UART_TX);
+		return;
+	}
+	if (uart_tx_stopped(port) || kfifo_is_empty(&tport->xmit_fifo)) {
+		port->ops->stop_tx(port);
+		return;
+	}
+	count = kfifo_len(&tport->xmit_fifo);
+	count = min(count, port->fifosize);
+
+	for (i = 0; i < count; ++i) {
+		if (!uart_fifo_get(port, &c))
+			break;
+
+		serial_out(up, UART_TX, c);
+	}
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+
+	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
+		port->ops->stop_tx(port);
+}
+
 static int mxupci8250_handle_irq(struct uart_port *port)
 {
 	struct uart_8250_port *up = up_to_u8250p(port);
@@ -271,7 +302,7 @@ static int mxupci8250_handle_irq(struct uart_port *port)
 	serial8250_modem_status(up);
 
 	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
-		serial8250_tx_chars(up);
+		mxupci8250_tx_chars(up);
 
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 
-- 
2.45.2

