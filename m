Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B47283FD6;
	Thu,  2 Oct 2025 04:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759380893; cv=fail; b=RCkKbcksk7YdaS8yM/FWn9SF/QBis6wfaHzKI5KT3znwlh85kYgslpOpluuB8k/48TwMufU87B+MM02N5L/mit0knqHT8/QhrI2/xgQkfZBxEwPQ6wKrPaqhz7Clz6mDiWkTHM55m2276aIZs3jigRo+aryZnJPCqFIoehsD3wQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759380893; c=relaxed/simple;
	bh=1ED/YUgzzHqnuuzl0Lnj1FHrE4qtJKBvxfADDImxx1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DfguhWH87ysx51Jev44uKv+yJ9jBwUIMjP9qn/odArhzNTVw/wtBFp4AODgRKA+U4jkQNnkPbu0l64S2SGc5lx88QIewm3Fhdbp+RM6NYmKQ7rHlp1uZOgGixCvTaGU6oASIF2KmCyTssplKlp6zOHJgiIGcu9qY7i0VoV6fIJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=N3HCvuPL; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="N3HCvuPL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G+rcDlm+L+K3fFVdPtEZfzfZLrMi7lkjdWzdG9Mwsx+ng92P6nGBprxH4oAXB9i41H1RMIrSfQJ5VmNX+eT3cMvb7jkim8fD3w5Mkj1Y9u0C+2vrktWQ10qsoNVqUBQUgpP5D0L0swi5jV2iWhj+JHo6nmet+sAE5dmFq+ujj3p7W+a8hhPCFHR0htZhG69tFWpXMuMX8hSEHHh08Jm+ExzM0vaNrEBj11DftWf1JycE1Tu9WuS8upyFAUYsILZg5VFK/lOiTr5BQBRPyJVs9hePEQLLJQJ2l94Ki1SaLY/QrHxwfKIeJeY0QtHdzXyMUTFfn+gSW3AN81TQD3g5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mhS/7SulLDudBA5opKwGjVhZLg+Xct8nITN6IA+1ZI=;
 b=NbnAOZuchPEB8JWLpG2U16q8w+x3kFkWPkpp4vGu+Wdpxt5Ud6ZfhX37sG36JkptWK7zMhA/DeOU1nmCc6KOeiQhx/uhZfFKjOjMTbeXuD5ObfUVOR9k98FgQroyohCwmCv3gE/JC1pt7k1EBOBktev9PjLoMySjJ5KEQd2LQdxwODCLGrZ5UB0jurA1zp9+/+EnyWzrwzkBq17JNe6IL2HYU3HbI5qYzfhWhl9YdYZrTiAT1wu8TY4DtjG4CxTOhzn1AdHHYTU6q/0BpGHut0OX/+wab9Yyim9VGEhuQwF3jTYa315N3yQhvopd8V2OQh6IUxD9IAB/iPZNo+OXuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mhS/7SulLDudBA5opKwGjVhZLg+Xct8nITN6IA+1ZI=;
 b=N3HCvuPLTrukGzxB/PdqjN4Ig81KbG9wXAye8LK4bp+JrjDZEdQ0qgpCUTkel8tQlm7bccGwqdOdkN4uTRd+thEdmXeOAtg5h4D2CBNKkZe6R1H/jTlHNL25etWp6H2eYcIb9rtx1JGlGBffiyRg5JBFTMnXZzSwm22uq0Ns6CbVXpGXJqNthFTLYKryjgLW9RHecKAN/UHv3XRLw0FVxocQANqtnAzHyUmEGODiltqFabTwpGIc4dRk/1db5mXubdwYuOOyKQPIIoeJJpd9juoyL+gzuAaCIhvJl72luPzlQMTOHf+jpmF9Hex1k6HLcrnff0qiaZglgpJi82gNow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8818.eurprd04.prod.outlook.com (2603:10a6:20b:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Thu, 2 Oct
 2025 04:54:47 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9182.015; Thu, 2 Oct 2025
 04:54:47 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	shenwei.wang@nxp.com,
	peng.fan@nxp.com,
	frank.li@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V4 1/2] tty: serial: imx: Only configure the wake register when device is set as wakeup source
Date: Thu,  2 Oct 2025 12:52:58 +0800
Message-Id: <20251002045259.2725461-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251002045259.2725461-1-sherry.sun@nxp.com>
References: <20251002045259.2725461-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0204.apcprd04.prod.outlook.com
 (2603:1096:4:187::16) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: b95b2da4-048f-474e-7e31-08de016fcfcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X5IutgD/y2dr43f4WNKYxUXrLwR/J3daegIYC8hX4GYBcOuESaSzX1WKK15C?=
 =?us-ascii?Q?hplWbOFxVMX3Jy1d9XmJEX9kTA6h8lWRK3P0aM5MZcVRauWsgJGi+et20xex?=
 =?us-ascii?Q?en3SceQM5OrDasfjeBuXUKjut6HrQqwF6CKx5LIgiKawAiq5pjVmDCq6RNf6?=
 =?us-ascii?Q?pxiNmpyrwxOkv9XaW2FkY+qGxPdtnH/9Vv37Wji7ZH3S1ryNXR7VaJig1tJj?=
 =?us-ascii?Q?gJ4Sk6FREX/tLSJ6yWXeHmKLTQq16E7ZWHKjHk2FxluFfezQOqZNrTwi/Ony?=
 =?us-ascii?Q?ErPGFZK0xDQPtB1SN2wpdMt/EGV5eAmSjqBI9pkiwihLcX6iMCgjeQ9WrI0/?=
 =?us-ascii?Q?LfiRtnsW04u/rpUelF6qgyMhVuMcv5A7gKUgZ5IhytsrZd9FezwUGuTfKAZM?=
 =?us-ascii?Q?vvVY90fBSy28l41q79MwUDGt+dVYXJpoWJu/it6PHYaAm49J2Y155T/CEZY+?=
 =?us-ascii?Q?2zO2jyHeO+nkwQ07C4RVCQpBW8GbFOca2TlnIks/CTaTvcBu7RBcoL9sX/sl?=
 =?us-ascii?Q?z0zOTpGZNiIUXhdFuZHrDhPwH/RP5AcLSG80bJSxgdA0hvADfLuZ4NKV4BMq?=
 =?us-ascii?Q?AX/uq74PBd038cVzVl67dRMdue0W8Zoli6vZ6kUwCodFp4EQi/KvaBkuqUeZ?=
 =?us-ascii?Q?wTKn3xayi/5QIJlVBPteY3D2+aBsS3EFSNiQ94+WWJsF8nwPvelZNtoWTtvT?=
 =?us-ascii?Q?0nsUtze3M/V+UCzObhgOaf8KeuUGYSgwfhFTFhhrDQoo19DcXvf3xNc98gg/?=
 =?us-ascii?Q?FND0C7hzEWnqkv/pV4WUZHBQ5qlcPQsqK7YxODY3bEc0KDFPk9Rj3IJELioF?=
 =?us-ascii?Q?QOQc9G9vPzF7xmCv9jVQO3vV6olmb9fGCYEqV3g4ZnpPdMBOwEI33jhi00QK?=
 =?us-ascii?Q?a4Xm2pPniiadcqq1FWrlbQnyVRNH1oq7hb5CuD7Wj0jtkO+cHR0s+Ds+Uesp?=
 =?us-ascii?Q?3m4XvfYlQtap4lhgel+2cVunHp6dSNPh58wi3+L99j2ChmGxeVdIkwfIdzkt?=
 =?us-ascii?Q?QjIwzRONdfBJ5h0OhmpJvK2ATJX1UhOGuTqJ2yCLM+c3ftlVxkGbw95j72LU?=
 =?us-ascii?Q?xC2TnhBAQmaMyuBp9XbxZ+x/uHxWlYOFb/F9fvKnVE4jG3ZJrnVOvv9YDHGo?=
 =?us-ascii?Q?hm3CE7xNrCdZl4fn5g04G8A8q4HEa+zcPg1yOnrYGJJcHiBOsZ59rO5axIDF?=
 =?us-ascii?Q?r+xiN8Cc+O8Yu0BGo77K6mylQqw4haegROlT3xpeyaIjGjKU9JREyg9lsXt2?=
 =?us-ascii?Q?RnMQLfTFI3Qi58tOCM1hjh4UmtAgCj0VoC9ygomiiZs1jd6tNv8EOOBMO590?=
 =?us-ascii?Q?xdYhkMrYx76PZRpitQ7jV/BPtoBTf5+7hVsrYPnJhWkDx958qa2ttO8pKytz?=
 =?us-ascii?Q?25zHnspupPB2NA/X8gZgfdQivqhoTtfG/GiGKdsRxMiX+nSQm6UG8SMK8x2v?=
 =?us-ascii?Q?rL+yaqRJh/oVIg1KYeT2gBrMGlrQYQx3PArg5ihyYR4gNXY74BoJGG3PlV0O?=
 =?us-ascii?Q?siQ2sht8rqSV8GlMHcXEeOjA0RTuxQTPzmyz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Mswl4nVUWu0E7EbVBTlUQ0bjwP2m7ZgtbAk6OCs6bNike1kk1BYOubJ/flH?=
 =?us-ascii?Q?2W/QOUIm4fj2nzt1k6wbbji2tAZGPfEzRXKd/QiBfFhDvssPgOdftYEFcep1?=
 =?us-ascii?Q?QLFLN7Wzvde4C1o3Zkt/0aN5r2XtWsyI1KrzFxv107iRfclusdT3LYReXfM4?=
 =?us-ascii?Q?VvDyoGJiIwwI1OiVfjeUcbZUHXyZ+uSgRSAqvceHKDd/+7LhMXmuWvo+pQo7?=
 =?us-ascii?Q?DZfCHTrOP+Yo1GoJMX7V5Ok3x4bADFQujLQJ8Lk9hhLA3+F4iu99NpTw6N0F?=
 =?us-ascii?Q?DYWGYYIiqfuNWVefr8meQIWPI6hq00YXy2Esp0C4/0FObWZD5jQBw2U8nU0B?=
 =?us-ascii?Q?FUNppHHjadyw00+Cs5rNd0wwsjd4s2HG6EujmHNPnjkL2TqOWnrLXtGtiTAT?=
 =?us-ascii?Q?48FMzX7rDn6TDgfHJMsO0Tk5bsKMbOJkTY22UtBiSEPh7JMTV66IMTUXA9QI?=
 =?us-ascii?Q?1aoEsq933IAVBr5JHMgI7m2LNv3hIoUDRAdqgOQ0iYWBZ5zMCZX/lIualADW?=
 =?us-ascii?Q?G8dBpFYHYjy0qDnFMd3Uzx5oUwKN7fuAcKbjMPt+6e9lrdtUfYoMeRpe9+KP?=
 =?us-ascii?Q?mA/DW8xBPoFUq79406wkxalvw9iQk9IpadCdy+KPT0Gy4pDTQTYvT4mIKCFv?=
 =?us-ascii?Q?LZ7Tp7F3DMzcW/UufaJUiI7tFInMwknV5u5O3xDVW2EiElJ7EWT9JNGcRavq?=
 =?us-ascii?Q?pYeZWJAJlMzukZmNl9K4ApDTP16xMyiO7EFZbCPFCZlZ8pzcb+A4X9fORY1L?=
 =?us-ascii?Q?LdfiZTpge82xhalpDCnp9e4YrSFYfZggB0lcUPXcUGszda+p6bM121Mume1I?=
 =?us-ascii?Q?6OJrIaTJqDSxjYokG0x33UV8sUv01P+SxVQ2ZSZdNszjDn22+XdAWm6xunUO?=
 =?us-ascii?Q?ixXXyR7Cvto1+z8VB0XksG2xV5saHMO5HiBevAwCcnz9e+tdDyk4Pm8Ii0CU?=
 =?us-ascii?Q?RsO2GFrn9Tq0eUsggUNBuyfGEV0Abw5fKa8W69uNKqPVjOgyBxepZdHBcPNh?=
 =?us-ascii?Q?io7OpMTs2wgaSoJYlfNTMCY/14R9hD0Egb31tG+v5r8zckkCKyNucoRqW6KU?=
 =?us-ascii?Q?80cOv2Uup5Q7xI4tIM2007VU4HLRgGzMKDvzs469Tktut8lPlhQwgmqHfZXg?=
 =?us-ascii?Q?8tXuBIsHQXx56OiAoL1KrfCFPFPmmir2UMQbzFceMw32mnqSYWlTNFsYjDxg?=
 =?us-ascii?Q?WS0Txm63TdW68f41kp4/XAADYwsoGyqVeNqn/Ko4jrOjQD5yiejnwlbW9/8U?=
 =?us-ascii?Q?5gwXnpyIsDZ+2vtjUTI9nxOLC0lo5PABG45aS+DBvwdIhzY9FAeWsKK+QNTX?=
 =?us-ascii?Q?7G/EJ7iI+H1ooDwzbRzk/3TOH1MK+ruNJJhXlvrat0unpIdofS60ouaPUaqs?=
 =?us-ascii?Q?szyOEyC73VvORMHjBYO4b6GbnydjdUlLIsn7VB49EZ6PyKWyBu0yf1CE5AkF?=
 =?us-ascii?Q?HjTLwgilki/6ti0IZX9GpLRQ1tIkhCAP4Y3bs+9Tg6V0Ixb3IM/XwX5TEGfN?=
 =?us-ascii?Q?crt7nVDpTe6WAvREe5sh0xgDrT70UWUcYufFF5JkMeGgmxsEW2mRwAwe2LOz?=
 =?us-ascii?Q?rryZA4vxd6t2iGRcUdRRnPfwqtu3XSGkTtbll7jI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b95b2da4-048f-474e-7e31-08de016fcfcb
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 04:54:47.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+rt/fqhqzKGs2ONHIEXdtp0hJy97Tz4nz97O+uVEo8dDFDkICDvPq7GmgcISCYns055YEVfu24GEDUJHd9Eug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8818

Currently, the i.MX UART driver enables wake-related registers for all
UART devices by default. However, this is unnecessary for devices that
are not configured as wakeup sources. To address this, add a
device_may_wakeup() check before configuring the UART wake-related
registers.

Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/imx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03..90e2ea1e8afe 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2697,8 +2697,22 @@ static void imx_uart_save_context(struct imx_port *sport)
 /* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
+	struct tty_port *port = &sport->port.state->port;
+	struct device *tty_dev;
+	bool may_wake = false;
 	u32 ucr3;
 
+	scoped_guard(tty_port_tty, port) {
+		struct tty_struct *tty = scoped_tty();
+
+		tty_dev = tty->dev;
+		may_wake = tty_dev && device_may_wakeup(tty_dev);
+	}
+
+	/* only configure the wake register when device set as wakeup source */
+	if (!may_wake)
+		return;
+
 	uart_port_lock_irq(&sport->port);
 
 	ucr3 = imx_uart_readl(sport, UCR3);
-- 
2.34.1

