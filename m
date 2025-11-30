Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022074.outbound.protection.outlook.com [40.107.75.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F23281531;
	Sun, 30 Nov 2025 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764499535; cv=fail; b=CX+5gQkp+LlxagkGlBMW7Ueb6IBXhScuwcrWhuhsHJVmh1vVi7QrzA+l8PxNFU8mkMLOqV/7s6i3zW0D3DKgWUDcDhiE8TQSx9YdeJOUrDRBaNK6MEPyfwjKZKPDn/2W9U9yt7iJWMYdIE1wFgSw5hcQhxLtkRHxLBQzPt7maP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764499535; c=relaxed/simple;
	bh=hieK/xKtI0sx/8wsa+HuzruERgLxpGDcjyk36RosXlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QOOhBVOd2uryxRCbXtys5R+tLEk4xx3j2+DqbGQznzdMlE3GEstKqZJXv2euO6z9gkMnIhlu1NJ5ezAWoJ/uO/dP9/Dbjpaa5DJvoHG4h2bD1cAN+aqH9DNbwXDHF+QbLc6x+E5JiD5CVGFMrRCu826AV2G0SV0L0yCH3UpyebE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=I9raVLGK; arc=fail smtp.client-ip=40.107.75.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="I9raVLGK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQav4YZC0voG7oLTKayx8rR21kF2+XQUQt3wK7TvrdzhIxdE4aw3DDERQKbXXZCy+gXWeo0UYypKH53w1qzuXT7UENajry25d6D5r7KV7/mj8YTpbG008Ay3XLGvdPmDM3qX14PMeL+szmYSK/inWtW8GAzpXtWWjpqCqfrjcRuu+11Fb88HHtzRdx8nO8YBLGa9Q3fdsfDTIi0QHac8lbYjTylmyDT29OTju8YlIrjzl0HrJzlBZd9/D+bsPrLj8CjgnmZ8vmFpQ8o/+DjIX8WNA+g70dEwCHKqZCbF/eEY1Yz5s0LNwkyuS1wBOGIDZsgvrWDt4OjJ746TGBdreg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTIDw5uRbQBxJ3d9i0MrDI5jji7HyC4SISMsS3aj/Yw=;
 b=euv2uyJxHsMs/prkNG/XSh0ny9N1b7o0qaCe2nVvZvzm9hxLF4Own1ioLuUcyOOfogV1D/NdT1+TCbQtHFSfHWYiZGgFKnHoUhlvBmisoWX4/0S3u1i+4RB4K+P4Nk6fn8zWsAV/d4VNfYIkLOKw4Ig0UP/2SOp+DzBPuiiD+1Bn1jkQyUsecfR29Nokp5zeB3l3D08XK77hMftyeX41uu+IpNEzGb/R2x3m+1GY7jCLT+4i3kiKrGM2Ap2i6vWY6BpQVoyjhcx0k+EK1wwVL76wzSgICD6G98N6BhYVs5Xfq0MXr3+ly67h4PRHBTaEzpmWNmt6Z8+AhiLNaL8nVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTIDw5uRbQBxJ3d9i0MrDI5jji7HyC4SISMsS3aj/Yw=;
 b=I9raVLGKyzLxUuW+uYNXQX+/KjtJHeX75vXRDOit2ooNCYIj68UEpSTjta4uFkVxfHE36Foc4szY0Rj/wfsvA+zzCO3SL2iLeiucszOUNByx0indVZZWyDPUEZbU/tnR3INPr3Egnb6UIPfP/LKOwnlcP/WqhNXM6rCbSCLD6h4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB6080.apcprd01.prod.exchangelabs.com
 (2603:1096:101:221::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 10:45:29 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::60ab:8615:ab67:8817%6]) with mapi id 15.20.9320.013; Sun, 30 Nov 2025
 10:45:29 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andy.shevchenko@gmail.com
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	crescentcy.hsieh@moxa.com
Subject: [PATCH v1 24/31] serial: 8250_mxupci: defer uart_write_wakeup to workqueue
Date: Sun, 30 Nov 2025 18:42:15 +0800
Message-ID: <20251130104222.63077-25-crescentcy.hsieh@moxa.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2acc3762-c77f-4642-32b1-08de2ffd9429
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mYqjUWBv9UB+61MBRtM3YPONBMDhGwErGGdkXXVSy9vtikwvy+3FBIFkw4Zk?=
 =?us-ascii?Q?ufhxb5Om3ljoH+PEAOPKnds/Ic3BbiWGLZW70itZof8vvcn3MLbRj09AQ6VE?=
 =?us-ascii?Q?O2LzI/mTYAD20NrPsZEVwWynpII8Qc7K94cImaeHw7MX7fHocLjsoXBBSYO1?=
 =?us-ascii?Q?f8yJwt2kNFDYKxeZkf9pOn3WDXlzugmvCzP+xh2KCdKqqmpH9c3OTDZNziIp?=
 =?us-ascii?Q?SPh0VdDjUlaLoyVUv1t3fazlbxJBDp8IYV6rOXADWIvkP1uGrsQuszHRSqJz?=
 =?us-ascii?Q?pOLrq0N1rS/gPHJn4VsBnhJtn9qrhFl0OSv2hd05IuSSpWF4WmJckRyk8dCW?=
 =?us-ascii?Q?GWo3DeF1LHGIbUA47RE0512TtrC844sZ16qwOarP1QmIf/nY00XKDaIOQFoN?=
 =?us-ascii?Q?OEx8I1TW5NvNLr8P69ANYSKx/d3PYP2abdoFUVRvsGis8r3xxbohvlMzix6l?=
 =?us-ascii?Q?EBiMIU2Z/kqVoYLfSu0gFVDdV9vd0kAf6ByvsQLq6SzcW4K5Oc3hA1JEQ1Hi?=
 =?us-ascii?Q?7D94oBfwN6Wdw8nD9lEPd1OFprxN7LcSpma3WJ4HwR5qzmSGlpuiRy25aRCn?=
 =?us-ascii?Q?IU7ctUKzqaZkZbnVF6a/ym0J8ByQBO3RQhb3CR0xUzrMytF0+iGPHZw+tnot?=
 =?us-ascii?Q?k7Q608fr4QGyicWI4pj1zVkkfLQzsu8f4mEpeeV7LLXoiCQpt1OP7kFvPs9C?=
 =?us-ascii?Q?tzwmHpv680BWxPiVAxLSgT8p1qNNJAT2F9+vvbmaHTxvQFxa4kOQJz4kmk92?=
 =?us-ascii?Q?VPAKxaU3CQPTg64elVMa+m1BRaFYTN9dIkqwDyzm9ytKkC0Tr+ya0mNtGpob?=
 =?us-ascii?Q?g7XaR6BGqUInljYbYcCzHt52V+JS1wJ0GU1fsfBHYylmsFoJezjvQobXQHmD?=
 =?us-ascii?Q?EiZtlYgISgt1IhjID5Id8HJvimsRzOC6Jot2wGxlDdjodosV/cDsCdgWqlx6?=
 =?us-ascii?Q?0lU6tX3Xq5JXIuj4zU3ByhFtwIK8TpLLoZA9DJVfkTkWzisn5v4VuG8//gOw?=
 =?us-ascii?Q?W2u7GBPqCQwV/q2ooH+zOJ3IksZjw22h1CzFqKIWeq3McFvzm0UDBG/ledd+?=
 =?us-ascii?Q?NCA3nfjp5flBBQ6oAUAfVBVI21RMoNs3hiHxAsuDURmLGKcklrjOBZx5LCh7?=
 =?us-ascii?Q?lPzIJDCQAB8jdW7EDubew0YolZjtcm7VclfEwdReliNipZfnX7e1Q2ftk03Z?=
 =?us-ascii?Q?60ETgx+3hlGTZISPJPqFnsFe5hXIJ+SI7fk6gLDlzBXRucFpevVlXs3YS3k+?=
 =?us-ascii?Q?ndruyEEB3bw447d0oaK4C8TKvw0JpRBCMMJHvvhukX7LA06Ia3jZ5o9F05Fd?=
 =?us-ascii?Q?4UH9PpHiQE1MKsJUCKnk1cqj6jrAKEMq8qdwXGRO1rToV9mB3YzWTCivvqz6?=
 =?us-ascii?Q?sfueGOAaClUepfdwkPAbkB734HALqbxz06G2BsSY/ZjyP+FDjaMPLh3s12R7?=
 =?us-ascii?Q?ui2Gx0T1f73c3e3ALrwcPW98M1GP52YjcUr+HmIc/mMUmf2KCyGDiDix47oN?=
 =?us-ascii?Q?gKfuQBDEMUYfPZEZJUXrWAJPH0SaOMQkEemY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?loaWrLx7LKA9UIPdgmK5cuKEBBNB1y2+ZKF0NqEGzap8uUaseeNi6H6RStXc?=
 =?us-ascii?Q?VCWD8x7Tr757jlNMzxsO4UeqPEH5g1eKTwZfKg4YpC98I4oQGweHmf83Mwoz?=
 =?us-ascii?Q?MecPFuwnBhW9mI8d+vPUOPyfvJiTfLqR0ghrKRYUXZP+U86RQW61pUbvq0yv?=
 =?us-ascii?Q?k2aIpvmC8ZoDyEjJpxyiq8tRYrVlqtrd+EY8mqj6I6K7tv7WNjRhCd4SOQtl?=
 =?us-ascii?Q?MJsLQsgOkmXO+r6sqlC6eZFG2+NnDnUIPHyDBYx7dJHcQAZ04nLRzBMs/sud?=
 =?us-ascii?Q?NwUlOaoAgDMnyTf+d2etJhxVD50ioCG91A+zptVVk0LD0/T6TB92T0oEDkil?=
 =?us-ascii?Q?Rnj8GwUnZPE353SLsso8J7SEkeFthsN0ZTX9onNXD44dSfiogTkYb6ZpyBPe?=
 =?us-ascii?Q?QMu9bFgWBnB499ATEpL4hYmnvVBuJNRGjg//CNbWcCpzPKmfB2nymgDWbDxA?=
 =?us-ascii?Q?y7VRclp2Z6gXVF02Ef3vmE2W7N7aULbX76e7ssWjZ5NoYabiJ6/RcHg/5zBA?=
 =?us-ascii?Q?0h9tRC0DOflC2XGyYLIdooqWUI3GsqL6Uq0V9vjsIVKPT06dfrRhGoohgZX5?=
 =?us-ascii?Q?GbsE/lwMZXTezmx7EJthVKiWnXTCVNqx0uaWIfeRTPly9CrGHuoffjH3redj?=
 =?us-ascii?Q?9B4wZl+by+pEgwI2XcpQ4qfmU+SgbFFVu+qU17Rf6jra3VPW2ILhpBX5EWWz?=
 =?us-ascii?Q?52HINndS5AdMDbRhicdP1QSzDzpDHNYBFA6duS7PGv4H73KxMji4W/ucJvJX?=
 =?us-ascii?Q?kZBGxIvgbhW1Ud16aZCLGd/GiLLdvwnqH4553TxBHe2XeYGp9RMd5X64zjJz?=
 =?us-ascii?Q?Xg3/R5y7PTifIB6dybk1SsPKMCFv/kaceHZFyeUIbuFlA7WrjB2d3yLBctMX?=
 =?us-ascii?Q?V4dnkLAxbRGLEIwIx3Z+q/K2Bx/OmzLaNkyy/OCLplEhXeCFA/INDL2Lyusi?=
 =?us-ascii?Q?dpTVBnFL1z4jN7DmLOJo7A2uqqtW3wh88RYDg9UZeqhvMXvnv2QS0YcqsiFx?=
 =?us-ascii?Q?qiX6nCcgVLNJT9AO8DfvDNdyVO+sTgo+y4eKhJCtqeC2jm3/xjDHGbnemCEO?=
 =?us-ascii?Q?YakpPCFXQ42TwmVeXNQZoa36TPo1Vb6e6y7uWMzAupxDhqn6fNo/9xq91Esy?=
 =?us-ascii?Q?w9XLy+EJcz7bqkqe1HeftJgkMm2CUUm7hPD9yvwg99ObxHFmYtqsJsx7AT23?=
 =?us-ascii?Q?NlGrxJymx67yZt7ErO5f6VXqIDh603tRS0lT63LeoSifasQ3kkrnKlfDesDi?=
 =?us-ascii?Q?NRT69pa90pSkD1is47fjVAONCzAc4FJB0eXMgsMymICJVqUVb8+0hSagepOR?=
 =?us-ascii?Q?+TILCmBsCDNS4+r+r29oq7VKxzayc/FQ5cVFX+Gtqj0Lz5+jr+gzysNLdlPF?=
 =?us-ascii?Q?KI4inOy4ugWZ4e0yjVaf2CX1eIT+VRc7UJzBg1w0DFMyG+v1lfOyOBUVg1LL?=
 =?us-ascii?Q?QdP5q3iJ9geCNE5ciXFEgA7L+OINK2y55Gg5GIq5BfvmywB600xcOXoUNFHr?=
 =?us-ascii?Q?HxOh//DrvfyNk2kDAWPSUVV/NyLPTCXxyox4zH5cRpdsRoTZK+CJfFVzN7RK?=
 =?us-ascii?Q?+lksrofmXw4hRq000Cvco/9qEHTm1fBIgrdPvQVg2mWVLdGgBrg5mpYmW4VQ?=
 =?us-ascii?Q?Bg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc3762-c77f-4642-32b1-08de2ffd9429
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 10:45:29.2914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KukzxK6zfGEFptP8J/erWPI48CIGV8jiYLxTmtPpA+Nns8s/8XH3PUpxVkITcEsC31CbftQd7NqKDFY+crlgNrPs4sBn/db42nUPotUYemw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB6080

When the TX FIFO drops below WAKEUP_CHARS, mxpcie used to call
uart_write_wakeup() directly from the interrupt path. Move this into a
per-port work item so we avoid doing TTY wakeups in interrupt context and
reduce IRQ-side work.

Changes:
- Add per-port state (event_flags, work, cached uport pointer).
- In tx_chars(), set a TXLOW event and schedule the per-port work instead
  of calling uart_write_wakeup() directly.
- The work handler test-and-clear the TXLOW bit and calls
  uart_write_wakeup().

This keeps IRQ handlers lightweight and avoids potential locking or RT
latency issues while preserving existing behavior.

Note: removal path must cancel pending works before unregistering ports.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxupci.c | 33 +++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mxupci.c b/drivers/tty/serial/8250/8250_mxupci.c
index 15565729b7e4..a19880b99236 100644
--- a/drivers/tty/serial/8250/8250_mxupci.c
+++ b/drivers/tty/serial/8250/8250_mxupci.c
@@ -86,9 +86,14 @@
 #define MOXA_UART_RBRTI	0x06	/* Rx Interrupt Trigger Level */
 #define MOXA_UART_THRTL	0x07	/* Tx Interrupt Trigger Level */
 
+#define MOXA_EVENT_TXLOW BIT(0)
+
 struct mxupci8250_port {
 	int line;
+	unsigned long event_flags;
 	u8 rx_trig_level;
+	struct uart_port *uport;
+	struct work_struct work;
 };
 
 struct mxupci8250 {
@@ -251,6 +256,8 @@ static void mxupci8250_tx_chars(struct uart_8250_port *up)
 {
 	struct uart_port *port = &up->port;
 	struct tty_port *tport = &port->state->port;
+	struct pci_dev *pdev = to_pci_dev(port->dev);
+	struct mxupci8250 *priv = pci_get_drvdata(pdev);
 	unsigned int count, i;
 	unsigned char c;
 
@@ -271,9 +278,10 @@ static void mxupci8250_tx_chars(struct uart_8250_port *up)
 
 		serial_out(up, UART_TX, c);
 	}
-	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
+	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS) {
+		if (!test_and_set_bit(MOXA_EVENT_TXLOW, &priv->port[port->port_id].event_flags))
+			schedule_work(&priv->port[port->port_id].work);
+	}
 	if (kfifo_is_empty(&tport->xmit_fifo) && !(up->capabilities & UART_CAP_RPM))
 		port->ops->stop_tx(port);
 }
@@ -353,9 +361,19 @@ static int mxupci8250_get_rxtrig(struct uart_port *port)
 	return priv->port[port->port_id].rx_trig_level;
 }
 
+static void mxupci8250_work_handler(struct work_struct *work)
+{
+	struct mxupci8250_port *priv_port = container_of(work, struct mxupci8250_port, work);
+
+	if (test_and_clear_bit(MOXA_EVENT_TXLOW, &priv_port->event_flags))
+		uart_write_wakeup(priv_port->uport);
+
+}
+
 static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct uart_8250_port up;
+	struct uart_8250_port *new_port;
 	struct mxupci8250 *priv;
 	unsigned int i, num_ports;
 	int ret;
@@ -409,7 +427,12 @@ static int mxupci8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 				up.port.iotype, priv->port[i].line);
 			break;
 		}
+		new_port = serial8250_get_port(priv->port[i].line);
+
 		priv->port[i].rx_trig_level = 96;
+		priv->port[i].uport = &new_port->port;
+
+		INIT_WORK(&priv->port[i].work, mxupci8250_work_handler);
 	}
 	pci_set_drvdata(pdev, priv);
 
@@ -421,8 +444,10 @@ static void mxupci8250_remove(struct pci_dev *pdev)
 	struct mxupci8250 *priv = pci_get_drvdata(pdev);
 	unsigned int i;
 
-	for (i = 0; i < priv->num_ports; i++)
+	for (i = 0; i < priv->num_ports; i++) {
+		cancel_work_sync(&priv->port[i].work);
 		serial8250_unregister_port(priv->port[i].line);
+	}
 }
 
 static const struct pci_device_id mxupci8250_pci_ids[] = {
-- 
2.45.2

