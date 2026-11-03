Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793743200;
	b=RFPKgobcE7vZiqMLBsold2hM1+k+7MAMPVvgF5xDzqHcIPOOzt9FmS/I9eS1TRBz7ieS
	 SNEexA/Mooyh69ICcmIkrcxG/JWYeenyGBM4z87TtDQZgUkL7UMMiUbciMpCiMZ7gld5o
	 hXGilHD2xkpVcTtOTLxo+qKKz/whsGdtvpjD4fBaryoNw3ocEVp9vBaXRCPuX7h/ZQr/0
	 3coCQiIAU4L5M1I0LmP0Rhqv8dt2GA843O3GYBBCiqnoPAoGunAne6/7MAbuJI745gogR
	 mOiMKMTS2N7IDL9f0NHS4e1G7AU1rtQsNXCASK4FbxbqtWuBegrZ9FCr5bwR9Jr5IKw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793743200;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=E8WPgOF+LJ9nc5xBGWLFyCDUpVWPeS2Sz4TwRQlF9WM=;
	b=udNyXoLqi7CY0SsLeLBkxNamy/xeQzOlwJcSe9DKdn0ZqJphFilGkqcC+/+fUG18ZRb+
	 ODWQg/5gENJlrUbhMEZ73FHjsKM0gL7qPdBgNNst5nwJwtBiHKRMY630rOV3tRkmo3AVb
	 ZEdE55+PwxoMODqk5NqabEAj76HFeF6qhPP4gDdhf3oAjc0r63Tgn1GBqlTCuY8PNXdUY
	 AmIpLGRhvEanTKVF1hkIS4u04ohXurb6JcGv/DLbkXLYqy7WOZSZu22r0XXp3zQMU6SGi
	 GG68DJc7KG5M9HEneF2f77XBc5fg5J4eHkLjrqNUVrr5NwU3QU7h4rMs0ECgjKcaVMQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oCcAxL90;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.11
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7598A606A32D;
	Tue,  3 Nov 2026 21:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7598A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=oCcAxL90
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJak7ydOgNi1H7zfKtNjSZ/X6MbPTDZsXt7/mvxTV68Qmr5HR70idRaR/d6CHErZ3eOTF7ZfrDPA2wLAS3/jOa2eVRbzhTqNcUQ/4qwMv8LC5GXIekHCL/hSEUo3yYHat0nEEuqnmVYCixfEVPE2bCfvBmzM3mklqvnqJAd0TrAk6E68X52CuhC0SrgLXmrCl1rwtvW3dYpw5rvT7HL5Pit89PkWZ+bTSRCeNEI+UcfxgetiPxNRt24URjcB0gC5XI8OckEkk4QzqkPVHdOz/vEc04S4mGwf+R2AxGM1YxYpIDrSdQez0lc6QxmEUckdfhNektjzP8JJY79zQCfgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8WPgOF+LJ9nc5xBGWLFyCDUpVWPeS2Sz4TwRQlF9WM=;
 b=VK8YboGnthI6fLr9mDe8Lz+Jx7szADtqexKQgUerg4Zg1GMog0kC8nSX1j9IOmnqCakVsTUkXJUIn+2ZlMXZpuU+r39BiDmzBaWVg6G+0yzplmh0we09ySeW++m7nCTigSzDURrdQxSMwhbq6Tg/L+j280r/qPxKlxAmZvCTXVmKKtQbIlbsUD6Z4HgmZ2uYownFOXwjRDTdCsCu9j/KdOtgOrzaoqoqJvWIPQfaEIcIrH8m4zvvQZ0+ip9AlzTwiSMU+QuDYxbyOhg7GJ2mlB3/IOEPpHo8ScW1FLc8ioSMrEAKOT34CldNfdO9O8cz6dJ0leGihqzRIJxXguOPuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8WPgOF+LJ9nc5xBGWLFyCDUpVWPeS2Sz4TwRQlF9WM=;
 b=oCcAxL90mLyQ98aeiaDFc4fIsu4oDBp4+4Eak3KkebMfHA47lX5JsPH1kTVt2+7zhydCMi21NI36AY7T0atlDq26Z8FJ6f6rWRyfyHOAvNFm7S2EhdI6j69rduuTO1W49CqJBkqd2lpZ2sDfgR4Bk+s6R4YVlAFRYoTFsNcGnK2rMVUJrGkeScmfZv2S7rokVuYgiTdnoHHKBGHTXw4jXHSvrBcgBmMgPXtMMH5n98OVL31RUOfPz+6oYw/jmG2fGEQLgkdS33EV55j+DCKiLO969HBYzNal0/cvxnndpJdkAASVG3sT/BTZjz5CQ4uyutKf5BLA+4LfogkDyRmoUQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by DU4PR04MB10600.eurprd04.prod.outlook.com (2603:10a6:10:588::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 21:59:57 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 21:59:56 +0000
From: Frank.Li@oss.nxp.com
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Haoxiang Li <haoxiang_li2024@163.com>,
	Zhaoyang Yu <2426767509@qq.com>,
	John Ogness <john.ogness@linutronix.de>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS),
	linux-serial@vger.kernel.org (open list:TTY LAYER AND SERIAL DRIVERS)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] tty: replace chan->device->dev with dmaengine_get_provider_device()
Date: Tue,  3 Nov 2026 16:59:45 -0500
Message-ID: <20261103215949.1827937-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7P220CA0068.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:224::23) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|DU4PR04MB10600:EE_
X-MS-Office365-Filtering-Correlation-Id: 336b9a3d-43df-4f22-dea9-08df39f5cc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|366016|19092799006|921020|11063799006|56012099006|261009223027099003|261022105027099003|261021121427099003|261102123227099003|261021123027099003|261026140227099003|261028144727099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	EOhUK9rHpFcQmtiT7PSzPW6H9WJXrrAPDZFlTzVgnXUSddeSHrsF/UfYGqzpsfGCJpq422o7Y9bI2vWXp03VX3nkWwj7g/pWhJGIC1k1ZbL3GzWWEfAGkYEfF3ba+uGcBIbW+YdczSwTvTMJNs9SOaseBFYw3740snui6am8FT/l+D/R3zy2pqdkrffkUWQ+9psiD2VfTzgBiXhKIbNYwxSxFrCuW8Rk7oX0aY0+FBAGyZJsJdSoRk5XDpdYVY8mBTXNTHCcGpW+iRULVZwgQCJEmXedHiSe7QCGFN0ko79sGAj0ArAcMoPTtodOdxmFRZhpgWk1Arf5Jcg3fJguCdPOkorTOdvOFJtZ8g2Cxc4qbiITCVB3J2JZ75PZ5+dQngQD0oeTnOXT55Vfqupw7alNY1bSRPh8xjA5VdG8zz2xv6oWJ0PkG+w6HptDXLOdBcaabyard3Sghw1Nm5gfkunohXSmlZ8xSihIhZ92NRLSlb0J/Jtj1p+fwbtQM5oXkzfW7b0t9z2vN1k0RWgaBClQq+9k6ZeaF/r4Qc3ukgqJQc2nkWKCC7bBIqjH6oNAuBvQ75Rq9EXQFWvngn4I6FqtpP10q4APg/oXtRFofr1wp/Y6SB7z5v6qTlWfVTTvz84nHvJ58UFyn55ojq4y1rb6jL5gaaDHu7eyYeu3OyymW1iVra2PCWhCTYxkhFARRCgHpQeejaaYkSi/+tw9HQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(19092799006)(921020)(11063799006)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261102123227099003)(261021123027099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?555NnrjbdQWLfi6vkQhAachqCkhp3/K2+01/10l/SJv0m1PFd7mZiZpY+RiY?=
 =?us-ascii?Q?RX9xUO93Ae42YsOO/4phJrEXNELd4dMJQin3IViUqrk07P7V0x5fnLCcITAK?=
 =?us-ascii?Q?dbNmUnGTjk7hXwyskFGT+3QVrKJoFC66l59xeNMmga24gPqD67zTF3hHYhA8?=
 =?us-ascii?Q?QjcVzYdF1akA2Dn8A3hJU9iVXZY+Vsq02Y8LjGdUAQ0BJ57zCo1CLj1PG6WX?=
 =?us-ascii?Q?IlZpB0qRrYfHKhU//+3T1XfcPbY6Zv9nF86GVJhtLUWp7I6n5vEQ5TlEXjiD?=
 =?us-ascii?Q?xqNYkqROPhWykc6GbE6gAmVpeunzgBtzlbp+zKEInf4iHq71Ct9zSMkKlYeB?=
 =?us-ascii?Q?xQ8F9LETpX6fFrJGELEoHRvkIUHXx19NAc2fQzrF8v1ed93a3qd2nPiRaRL5?=
 =?us-ascii?Q?dQXjVuJtnSxT2QncLC57dnylQWCGCyLSfGO2FNp4+LSRndCunkw55aFWiv9L?=
 =?us-ascii?Q?YjB6jxQg6ppRhI2Cg/0Erc+GI/ZhB/H9zLO1AIpITSOnpLhgjjguW8fd8f2m?=
 =?us-ascii?Q?hBPXhMh8ifIJ4voXO3FIjNVmQmoKj5aqQ+qDPngAaFOXSTCpZVz7J7Zni6Qa?=
 =?us-ascii?Q?24sRojR7YADEArVwbAwlwVNx+ezdYsdgvSvdraxSEchmA9M9B2r71bLbSefQ?=
 =?us-ascii?Q?hvQfmBBk06LgKz0uIKW0NBVJvnD5xCn6MEtmYqm3B7eqZqxz2jFWd3zYMZ/I?=
 =?us-ascii?Q?k0BkoBnmB6uODFRX65wvANm6391qWDFDbfiSETvN/cEPR7acq76WHNZItOos?=
 =?us-ascii?Q?RoihwaqN2zlI0fT4L2z5QrRxFCWHCr7ve9xMox+KbFfvrJP5hLagzcjedUmW?=
 =?us-ascii?Q?jjw2L3JB7yGXxL3h7f6koaHF/mS61E5lmc7AXTsQt8aFrbyB4DWxUhWin4ZB?=
 =?us-ascii?Q?arknUqoQ7Xsu10EEWXGHrcLwFWCxaTzpdR30WsrOG4ia9Ngpet63+lnaRNsc?=
 =?us-ascii?Q?m2JKOqnGlzvlGhUxDZYaxZIZ9CdSQK7hM/aHmLiDWpC1YI8pzh8FbiAZLqkI?=
 =?us-ascii?Q?U6iNKIzY4vZz9hVUdK3p1i+sjwzL5mkt7aLuci8026yYD2Ke7YQltoccOryo?=
 =?us-ascii?Q?CnPpLnqG4NSuIcmrBGKRd2x+hRsm7Zz6iPjFiowtCuqP9JaqL4ZBwjhRkSXd?=
 =?us-ascii?Q?I1oZHI3HUmJCG7LIH9ZDdpok3z07blZE05P/CVN+WGStowUe33q6qJ5qEJlM?=
 =?us-ascii?Q?t7Jm+Ztx7FuWckzDgy2gp2tid+6ht5oEb7CLntET89M2lxrJbNVf1CIZs6lR?=
 =?us-ascii?Q?y/p/wnFUBBBiRkDWcznHI6DbpwEgwv+EVlUbU1lfhbnXD7+6mZbsNDCSYlyx?=
 =?us-ascii?Q?Z9SbTeL47FRHICWgye6ueO61Ss3APIQQakutkYvPBWZDL/wS2Xj3NBsNm8Oa?=
 =?us-ascii?Q?6stCrf4MBTRn5AjfCXLfzI9Kr3Vd6WOphz5+fmnyvNsknb+N+f5WhTNiJcpn?=
 =?us-ascii?Q?AiyB8Sv6kyuDQx8ZCyXNmue6LEGlgLcekjfnel7MDTVJWjjo4zwLmdRr2Kyt?=
 =?us-ascii?Q?1Cvf4D1Rq++7zUqPz5JmMBmKwQWNXUHgjrLBG+W0iqZ8gKf7hf5DirtMqigR?=
 =?us-ascii?Q?M7qWClJ0GqJ9t6r4KDhehnKb99bxay+V4fY68/s5EDAMQH84QwcvOS5K9Nkq?=
 =?us-ascii?Q?HqFfbsrJD5TJDoHyZ9YX2TEbIdOIp8BvC4DsnKccPb+I+AhLXPLeEI7RKNBy?=
 =?us-ascii?Q?Qt1UdlHL+qVH7M0WB/45J+DjgHJOp4d6NCn24Rn/YYy698h+cYBQD6qBtMeP?=
 =?us-ascii?Q?6lPZauxMFxj8VAhm2MldNKpMw2Ihzbda23t8JTtty70MpoWY4Bex?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 336b9a3d-43df-4f22-dea9-08df39f5cc63
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 21:59:56.9297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HDPcQcEU70OdT7p7cPBWtUjI5UZSE6h7HuOqVRsQtBPMYUkskCVBxG760m71ysvLLsYYcyq5Lx1g4ooxRo7DOYrJQ5OxKZct34HYbPsdZEQ4v2pJsgDooF1pOJH3lCM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10600

From: Frank Li <Frank.Li@nxp.com>

Use the dmaengine_get_provider_device() API instead of directly
accessing chan->device->dev to get the DMA provider device.

No functional change. Prepare make to struct dma_device private to the DMA
engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/8250/8250_dw.c   | 2 +-
 drivers/tty/serial/8250/8250_lpss.c | 2 +-
 drivers/tty/serial/8250/8250_mid.c  | 2 +-
 drivers/tty/serial/pch_uart.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index eca02e8bd6d13..9adaf5b5fbd56 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -530,7 +530,7 @@ static bool dw8250_fallback_dma_filter(struct dma_chan *chan, void *param)
 
 static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 {
-	return param == chan->device->dev;
+	return param == dmaengine_get_provider_device(chan);
 }
 
 static void dw8250_setup_dma_filter(struct uart_port *p, struct dw8250_data *data)
diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 7e88f2b793b5a..eed37e8b3e831 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -269,7 +269,7 @@ static bool lpss8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct dw_dma_slave *dws = param;
 
-	if (dws->dma_dev != chan->device->dev)
+	if (dws->dma_dev != dmaengine_get_provider_device(chan))
 		return false;
 
 	chan->private = dws;
diff --git a/drivers/tty/serial/8250/8250_mid.c b/drivers/tty/serial/8250/8250_mid.c
index 44b43163df511..dfd2460983fab 100644
--- a/drivers/tty/serial/8250/8250_mid.c
+++ b/drivers/tty/serial/8250/8250_mid.c
@@ -252,7 +252,7 @@ static bool mid8250_dma_filter(struct dma_chan *chan, void *param)
 {
 	struct hsu_dma_slave *s = param;
 
-	if (s->dma_dev != chan->device->dev || s->chan_id != chan->chan_id)
+	if (s->dma_dev != dmaengine_get_provider_device(chan) || s->chan_id != chan->chan_id)
 		return false;
 
 	chan->private = s;
diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index 9505d255f09c5..6d9a88149b407 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -656,7 +656,7 @@ static bool filter(struct dma_chan *chan, void *slave)
 	struct pch_dma_slave *param = slave;
 
 	if ((chan->chan_id == param->chan_id) && (param->dma_dev ==
-						  chan->device->dev)) {
+						  dmaengine_get_provider_device(chan))) {
 		chan->private = param;
 		return true;
 	} else {
-- 
2.43.0

