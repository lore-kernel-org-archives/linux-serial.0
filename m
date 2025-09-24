Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013057.outbound.protection.outlook.com [40.107.162.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460704317D;
	Wed, 24 Sep 2025 02:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758682650; cv=fail; b=rTQZlhCAxAvLG5Qy5wZHLtZpiWkLHROAA22SpNSZspmxMvfz/qKiLvSYOpTS9hn+JkeMGxlWKB4AWYhu+rZobmB6M6aMEY7/oPjf6niWAexNpvAaMOhJoaeHsVH7K4MWW4TiQNEP+PKV9Kq/Ne3G/3quzLpjjt6X7GEsFmx/7QA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758682650; c=relaxed/simple;
	bh=o7Rc/n9BeTZ7ozrreu+ioPSaSN6I4nWKIB+rcf8L8as=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=sUqrm0d6BbtGaJo3m8Mofxc9THv2Eltxo3gC07fQjDKGCJujXy9w/3Shp1GeA8ji7EeZ2YO1G20Tl1+kcc6FR0E61ISrHPCbEWvCMZe7D514PbGamnEgYFgsaiv7WD7kPM97vf/ctbp3cxm5vTwqBUmEAqMFukr/EVxzXPCHFrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PAZL+Whh; arc=fail smtp.client-ip=40.107.162.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PAZL+Whh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eE7q8Uu/H1lWAvm+CW4V0E14gMsRdEswBFUu8KwOZUCJ4Se8ltphBpfkePf8aoByCw7tZ0LNGiC5S9QFOJA6h8yw9wd+iA0uo89cMxlcok9TNl0+XNa8QPCazYHWP69NnvizAa9wAH5wa9cYGRngZsluvcCm9ErYgzEdmp4eQskgRSKChsJvnTUkV4EKgUs7IdwjxEKlVoX0rcRFSfUa6MhKauaF3OgcgC0qh9+dgBtNfrEd+iD8Sdg2agjcMIue2ez38Q1/FJC/TCbWs1i+j0GwfHGaiX4w/QTwwsrDkTaFC6AMombUJJ/uSVWrhOoGM19d7cKlGxv2FjJ4Mn9hFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYE8hAwinndOIZ9waEdQTrsRxJfQYhvtCtDOTS8MhP4=;
 b=bcLWY3H3kaGMP8vNsGs1SacYI9I1PvHTBsIpDyJQrt1gjwq6I9X38rHl7nYH7oW3xam4LXHN0iTZR7x4gUxSXorE62jbx8/AAxWuEX4EyghwHoEGnjCMVNFIkAv0jXzA6BGIKW/w/OYb368hZbhYqalSICvZMf3mw45npdYv2j00MgUWnA3Tx+tsLTkcS0BrfIn7kGIiz1CFP18cIz3+QtdGjEGtJs+/EqEOiUNwfhZx6/QQR3U+q+uXXRZc+gsTk+OYgj51qIAU/2cqSMi50m7oOwv2BvuOqB4bEvfmuzilLDl7aVs/gJj/fivhJWbS3qnMihxIKwoQzjz3L65Fpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYE8hAwinndOIZ9waEdQTrsRxJfQYhvtCtDOTS8MhP4=;
 b=PAZL+Whh8JuGaBw/l58N+ZfSwK1AM3cbf0x/Si6e3vib9uwT6FrW+hUjajHV/axUKho6lIM/3SGIiVeiEHDepe+0NKTU2J4v+roIJ9pj9ADs0o7f2YpxWQ2qbohKpYzhXPktKPihuv5nKYGhYfr5Mk7EzmDlf8OVCVy/x2c2UDouj4+FBxgZsWWoSRycxmnvbqTryVCQnnEZczTaxsL2rhP63/JL9evkMPyzBPiYAPRYmpvFw2AnyOAf1qxXLYG9uxAqGnlgow5gMu1yeSzbELdXKt+cDrr68sFVwOunyWQGrK90K2Y71XDr0ytpkqPRe+SGJh7PD7ODHGBKIz0aSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com (2603:10a6:20b:3fa::15)
 by AM9PR04MB7505.eurprd04.prod.outlook.com (2603:10a6:20b:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.8; Wed, 24 Sep
 2025 02:57:24 +0000
Received: from AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f]) by AS8PR04MB8418.eurprd04.prod.outlook.com
 ([fe80::99c9:99a6:e6f3:7a9f%3]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:57:24 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	shenwei.wang@nxp.com,
	peng.fan@nxp.com,
	frank.li@nxp.com
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH V2] tty: serial: fsl_lpuart: Add missing wakeup event reporting
Date: Wed, 24 Sep 2025 10:56:07 +0800
Message-Id: <20250924025607.2515833-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::7) To AS8PR04MB8418.eurprd04.prod.outlook.com
 (2603:10a6:20b:3fa::15)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8418:EE_|AM9PR04MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: 56267e05-a63f-439e-478f-08ddfb161691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+SqVz74+2SI+D+n9LHSn4R13pGZnh3K25+1fBTuPwzQCT/NCQwcxC/PagSPU?=
 =?us-ascii?Q?cNvIu/Rv4fV3Th6PuwtPExyVsBHU1TjcaOeNkcB1zP/s+kJuenQyUDRmEXTm?=
 =?us-ascii?Q?fq/aLaQwQpYAfZxLi36kZzz8z9+oF9c1+aXdnrQPKikjaYKBYvVOrUbYwoXV?=
 =?us-ascii?Q?7aymTq8SsGUJcfQYOxjhXiXBPfzEnLUbZOTbEfoLXH3DSch41eXB8fnB2x/W?=
 =?us-ascii?Q?LgUNzaltnwapWNlIFM4rzeKWf0TOjVHhfdWgFUfLVGRJI3oMttylGMp4ej2c?=
 =?us-ascii?Q?u9+orL6f3OxHDNzbk5nRtIttjftaBafBVBi78kn1p/SIHgE7tIoqdq3B9IAk?=
 =?us-ascii?Q?rDKW3I/zDywBdHzUYAAnvgiOmuIi6Xr5oupNzV8jNAt/51/JCl756nSktJYM?=
 =?us-ascii?Q?nY1MSeJVXNe5wkSTlHRUAbofWV9lfomBW1XxweNk9WFJ3FC1gfiEMjLM+Khc?=
 =?us-ascii?Q?+Vp8D0UiukwddfzrKm0avxqHJ7cGM3D/ltcbFZ9tTfs5vi3kuT0DN0CxORvJ?=
 =?us-ascii?Q?kSBBh7okJ+MUOkQivxan8RNxOLlHJhm1bA9T2FMXk5XamyPEaO9HbmXUW+H1?=
 =?us-ascii?Q?2lJ7L3uMpf8EOJnZKfCxNE0tz/FswSE6v8b5Ycrma9cHpEYhsoO4Y9BltlKv?=
 =?us-ascii?Q?U2XSYap86xUijgAhhP4QIcG1nTa9BGUsAa6TuCcIz4KByZSsKAn45RHdI9Cq?=
 =?us-ascii?Q?b7fMLe3ZF8zqGeJ/x5e8U5OBgFj+fCLqdSWzKy1RIu7DLF6WgSSY/01HHFpF?=
 =?us-ascii?Q?wpxwrpTDl668z1QBnZANNXwhB3JZ3rTIMmCz21v+HR23WpOST2gsuA6lXjav?=
 =?us-ascii?Q?krwi70XWsSJ7at7U62LsevU4tQkBcLM4Cyk6NBRSecj+PCCd75Ol842Qf34q?=
 =?us-ascii?Q?T4ZMjC2Ut6Ul5WYu/rU3ucDsXV5PUWIoCU4nZSwa7UmpVelm273ZMYBLS2Iz?=
 =?us-ascii?Q?viIdbyspBIImggnnbUXKq9PP5D0mscgzX5eQlpUU68TFXll0PEVlU+nQ+aZW?=
 =?us-ascii?Q?9hEQF+hozfhCzYEZo8OsQU0688zXWwwcZIG/l8zyE0dYk86QRWxEccvERqqI?=
 =?us-ascii?Q?XIAQAHIbaqwJOWLYoxC/OL4hFFoX2kSIss1lhbnorTqsk/TcshHG7DpHXPAu?=
 =?us-ascii?Q?9N6VKQtS1yrw8Ji5/E4qie5vf31lQVoN8XNazGNmFiuCNjmkxotGW2vd9O6/?=
 =?us-ascii?Q?EoPpIkzJ3gFknN2X0iY2020SElFMhjFL971RAZ3XYz3gRN+xbuxoAy8AvTQd?=
 =?us-ascii?Q?4xWZcSzeiIovgCR7PXASGXOzCQ87y2pwm4s8rSH3Mol3llfh5T0Ib2+KkhVN?=
 =?us-ascii?Q?A2YW17u/4cxdzOi5nk1j3JIxa61f0Kc7JZv4DquEa6WMPVLmTVN7iit7Daee?=
 =?us-ascii?Q?AY8VMz7uFgJ+f7B8VET3QYWg6nLZUcgBnbQVRDWiIfoptJ7Ra5BwLuTGFFAz?=
 =?us-ascii?Q?sadacVR3XC4vMSs6MJd7RDPRRcLLJvi5VSbOHeb72W+xq8CfI7rPZqI6MZBq?=
 =?us-ascii?Q?qlvRzzwUVvh2q5g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8418.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IsIl97yM/xs77hIkPHRA7hDJY33eieZ5zFYV7nKDAUPRUdKMfllSfX151VhF?=
 =?us-ascii?Q?rVUm8AuUcIHMKX/iLRGK3QTF8c9rzyfaWHzbXAv7+COVm1+VH62FO/Yg6r+a?=
 =?us-ascii?Q?Hp6h9Bb5YYwIv7Y71PdxDJWpimUXQedIwZfmBEvkXESjUOiAT8a7iV7Jbfbw?=
 =?us-ascii?Q?tgrEKObRwJBhu6hDMgLvxEhMzKrTMQlGlkoRWTXefSQYYTe24bfnS8bfmKwf?=
 =?us-ascii?Q?Zdu2cZP1BKSBDH6mKj3SD/V/445DSf7eOPICDcrgWVPtHcxkpuBILC41trfv?=
 =?us-ascii?Q?nN274YuCUCgXI7CZ5pJuuAyhBD3BVHXObEzW/gZMWDr9q5+9jbXQrRp4ckRm?=
 =?us-ascii?Q?gUY8lt7bBxsIZr0NpOspt1RUneg2OnHtxjhtFz4tcC86om9+sinwSEjlqMAi?=
 =?us-ascii?Q?jk+1ZpVq2SBwQ5QtJ4tUPtGOmdwXhwyDLD7ha9JuW1slvciN+T4ucI+qKROX?=
 =?us-ascii?Q?lSTuUIlS7WcDk/AtxBDbsSS0Y8NPMtF+UFqXeVP7zajlomJO4vC+OFCXe++A?=
 =?us-ascii?Q?sw8i4Aw496VdHGl91+svTXvAoTCFSj6+GKF1Jb4+guz4ZfufWlx5GcGWbctJ?=
 =?us-ascii?Q?Kj5gzZgeVCM75GVCpKy0q0Eu5zWn9swxAp/g5Fa9IZxB2dXt9J6EYaB2+DMF?=
 =?us-ascii?Q?YMCCYBFcBFnbC0HvYwKqpb3igkHFjDJjs1Xgv6xYcqqIok6Nv2gbFEBzL7cN?=
 =?us-ascii?Q?Gw7wRr8H3bOLhxqf6q6R7Fy1oyjsoPMRxqQm4B4+KPz6Nx9mpzkGRNaweIJw?=
 =?us-ascii?Q?lJZljLtVmF58+ECjWk7AEJKuZEeD5DqYDPndI9aENvckJxyUzosWZ5wr9ABs?=
 =?us-ascii?Q?HhCEhSobUlU0/mrOvmjoJXveiuraqPAW7bxqxVwIJISBkhAOfdDyKI15OAn8?=
 =?us-ascii?Q?a+NID+EGh3cSBAKV8V9bMDzTCLVWLTybyqa6NeMVIgIYGVBxji7GR8sH2tUl?=
 =?us-ascii?Q?OFlZ3rc7tQzHJQwAuo1n6XFB4Vku9QsRjeafNaltMtOo2gvvRJDEjruFxlhl?=
 =?us-ascii?Q?lggod+bTqQCkqAFV0HodPIT2uyU3afc2BcvKahDYa4/FbUtUyy7MpNGV3DoR?=
 =?us-ascii?Q?FHrCdZtR88f82A+zzfgLxldyfcBbyaa8s6Fp2aA8PCId6cXQq6lxtxSrarYO?=
 =?us-ascii?Q?POG3qIhuWCrP3Sr3e63IiDEHIZqiJdcpakYDEV/g/HeAPYMM9rVCKJ6BGVoq?=
 =?us-ascii?Q?vi/kXWKFkh9oEV1TK7A+bnvLH4VGp2XjoSYvfDRHNPKoDq9TU/5gWOUMzuWD?=
 =?us-ascii?Q?kfv1HU225HLs0GI4XZkCDsHcqIEWbKFDc0433qJDbMjHAewQmGx8/92MxP//?=
 =?us-ascii?Q?ZLKjJBCnVGbTlsAn+ZrBop258vvIY7FywXPKD6HJeovEA3Et6ypyOrZa5X+W?=
 =?us-ascii?Q?qg0Fm54KkgpWZl6CwBqTvlxziJ0q76auVp4FE0MHYCrv/Zt4kqsfXNVbs+Bu?=
 =?us-ascii?Q?zYpI0ctoVxuezKyj56kWttbfH0lzFuDd27gSjLIAeSpycwDWobS+T8R5j1BM?=
 =?us-ascii?Q?/0KnWyY239ATecsaIna6UiwATjEsHa60tLYsU9/LzJhoVkXS4i0hFwWvag/e?=
 =?us-ascii?Q?qIjJxk9dJMTpSba+yOs64KCrpbm8jdOIqx6aRFbX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56267e05-a63f-439e-478f-08ddfb161691
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8418.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:57:24.5411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mhHUpQByCr/LrodldkDaeeb4cdiGescaiw5ZmhXAXQJrZdHLbIE9Jm2v11Y57Of9ahmc4jQkCj0YAgXsbtNoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7505

Current lpuart wakeup event would not report itself as wakeup source
through sysfs. Add pm_wakeup_event() to support it.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V2:
1. Improve the commit message as Frank suggested.
2. Move wake_active above u32 stat.
3. Use (stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF)) instead of (stat &
   UARTSTAT_RDRF || stat & UARTSTAT_RXEDGIF).
---
 drivers/tty/serial/fsl_lpuart.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index c9519e649e82..1bd7ec9c81ea 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -3087,6 +3087,8 @@ static int lpuart_suspend_noirq(struct device *dev)
 static int lpuart_resume_noirq(struct device *dev)
 {
 	struct lpuart_port *sport = dev_get_drvdata(dev);
+	struct tty_port *port = &sport->port.state->port;
+	bool wake_active;
 	u32 stat;
 
 	pinctrl_pm_select_default_state(dev);
@@ -3098,6 +3100,12 @@ static int lpuart_resume_noirq(struct device *dev)
 		if (lpuart_is_32(sport)) {
 			stat = lpuart32_read(&sport->port, UARTSTAT);
 			lpuart32_write(&sport->port, stat, UARTSTAT);
+
+			/* check whether lpuart wakeup was triggered */
+			wake_active = stat & (UARTSTAT_RDRF | UARTSTAT_RXEDGIF);
+
+			if (wake_active && irqd_is_wakeup_set(irq_get_irq_data(sport->port.irq)))
+				pm_wakeup_event(tty_port_tty_get(port)->dev, 0);
 		}
 	}
 
-- 
2.34.1

