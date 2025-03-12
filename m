Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAE514A095;
	Wed, 12 Mar 2025 02:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741746321; cv=fail; b=hroBy9f+z0fU/vA1Yr8EERiEoqXP/CuhSHqhkgmhT6IxXQBCwDzd/f/iOvAfwrvT6cIlSSWP+6UxGAMuww4ihk1tQiYZrIlmUiCC8slQ9MS/c4gcARpfol0iKJplUJONwt/8Q997eyTWNpdUMbIOU5+G50swhTwAT5wT6gE8sgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741746321; c=relaxed/simple;
	bh=FM4WQEH1WFoyR9Difl++iNNjsk9Ak6E0+b6D2tLraGc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=guCq+1IPIp+HrI6V+s6Bo436Z88OxiSGwN7VmT66Ijc2C4feCBh6BwbjMGqinvVJZJLvoXEo0aLAPxXQGjYCMDc20k2cZ3dbuvRe9JDF5iJrIYG37Q+murgd9LynlMLBQm2HvOaU1H9JIzs8i9KnL4RFX426Cj8LbapWKoZ1C5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=FINZiZV2; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="FINZiZV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rJCh5q1lCxfT4fANvtKKSVGVrR+f641dm+YvZQm4XFMbtH2UyesUhFtvrvSBfDqeQN+omo783hzuk/ekzi3yVNc3y+wkedPlf74K5QKIiRq9yJMcdgZ/E6Gp4MWq3oo3Wp3VNGs0XecgU/Ikfd1FbvyBJppPsH7BQnQdKzESF0MJB2iSM/wTtB8UvCZ4zX8AwB6uuKGLrBWzto6nO7GxVXCeNe+MZWpRDn2PFM55f2UXjp+5t9BSCmdsVk1orB/0KDICDviE7oCPDICiw8My3cQn3G1ftGdYlgUB6crTNEvp/gpbqlO3n82BgLc+exQ7JRT+9k2Un6DJjLKBPRcVkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDVRFI4GKp50U/wpHsGp0sRm+uQVDVDQuhj6hqPrLmU=;
 b=tgkfwGqz9c1kTTu2174qUmejFH+J5mjDk2mluE21HfI6foS8maNUl01qleCsa51g1WYns67FVp1rz+paygIZxtxPRbzd69Y1efIrfNNXIvqrPsVGF0KiKsRZvVS/6VbUxQHJErGt3DAljnQG68EIPmdZ+ADmOzXLXQinmio/rFTVFLezb+dMCZEkavGL1sdJN1EwxxSU7WsEPaCY4yABPdqJlzZbBaGXn9SECrbMMevcMsNZOT/QY7qqjmGTQUHZkRFwGN8V/4MSDYWw3uVXZB5j7/agkhP1RS5N5Sa0DioWl5EhTUCz0nRFNi1TrGVnk575r7L1cJ8OVgcOAjuSNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDVRFI4GKp50U/wpHsGp0sRm+uQVDVDQuhj6hqPrLmU=;
 b=FINZiZV2lSGGfZRYsSOR6IKgb8qf7pBIWkShoqyCuN0hITNQPZsxourm/QPXA6MX93R9aRfvqJn/Adl1cSvi6ms/VDI3mqduNF04aaC8YCeIq3gxH+IbMr0hROGJM02F2uYHHC1+iEVkFx+rIZCRzKh8YSsOlxEaoszmYNhB5Sd82NwzvpQNO4vCxP+i21EFKX39/RMaatDhrglrGqz7ab7UVbWH4DCLrPWU8qP/5eBY+JtPovlf+DLyRwmCBRzq3BN+GaojlrtrR9mAnzH/57ZtMLCtQ3JbIFxSTaN/MM2n4u6y6EWctuUYq9pJFTKIfj3FEr41IgnLUJNMiFN/Lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DB9PR04MB8106.eurprd04.prod.outlook.com (2603:10a6:10:24b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 02:25:15 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 02:25:15 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com,
	frank.li@nxp.com
Subject: [PATCH V3] tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
Date: Wed, 12 Mar 2025 10:25:03 +0800
Message-Id: <20250312022503.1342990-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DB9PR04MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: dc33e708-9ada-4eb2-4cfc-08dd610d1fc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86oaSb4sztz2px7vnrEsvj2Cvaji9dkRQQBnuSt3DHYFJlikP07lE/2nwXd3?=
 =?us-ascii?Q?9/dWhjTMxy5UOXYSPyQNwfUwuQaDavE2RZcIsDEWBI2QEGYipf6flxPhCANk?=
 =?us-ascii?Q?wxwH2g6BDYNPlX5BLxiuicfhhhqzQHEPFMEU4rqg+RUnTNOViNZBuaqLiIPq?=
 =?us-ascii?Q?z/swMFYnnxkVsr5q5m/gbERFtCMEkIR8t66psVHLtWZDTvtjyplczBHoeKuD?=
 =?us-ascii?Q?jRziCYKod7T5ctZRL2WO6qiGw64IoXHaZUmrF1Nx9ENhywzEUpJ4zw+2rXsD?=
 =?us-ascii?Q?ox1RPMaJniIwbho0ls6HNxy684yleKYoj6Dn5dn2Ym1zo08BU2eZ6aZyBS8Y?=
 =?us-ascii?Q?e5fgwxFpyCPc5wBDHgwvbdvMP5XfQqalHlg6F+H8AyYlgT5PI5AVADSGl25j?=
 =?us-ascii?Q?uaZHv7YSPyLanR1XTTpsteZd3v24kSg15FVpLeOEH5WSyAPGWccVMGq77c+I?=
 =?us-ascii?Q?frVC4w0AqiDFClzytYF+2tPOYaFMzqBEzkx8MXI6DTbwUZF6inYmQ5vu2DDw?=
 =?us-ascii?Q?5RuCRcFlQuTxK+GkHSqCTaJSzHmYCqFhu26XETo/zQY1JTEbCA0np7/uM0IP?=
 =?us-ascii?Q?iCIbI5isV+MH5GjJa5TLr75zd3+PNdHryVG9yxA7KelKgVejs9Ne55ytLF6z?=
 =?us-ascii?Q?Eq2qcz/9lXNT24+ePZeoyWO73ga4DIJ+1nj3rch5LCF10mMXa9oxw+OHeajm?=
 =?us-ascii?Q?f4GxAhsaKDv1niB14nZPU6GHCXZoqpahMnpoz76iXSabVTx3GETK5opYlvAw?=
 =?us-ascii?Q?nE8C76OHmg3E7YwyXUrn26J7ULRuT0wVciDszwDWSQiCSxWX7sXFjQcuv7hy?=
 =?us-ascii?Q?l1L+6Tho/mFLaeSXYV36D6rfDP7ZozCJpYpPSFbxedB1mud2XH8wCODjq8/N?=
 =?us-ascii?Q?FZ85jQjzjTX52E0x/kCDIz5QsPch9ZXggbEZOd4+Z75ojonF0BXboxXk4lsq?=
 =?us-ascii?Q?5cmjH2HliSSIAqbmvtbXnHDPXhFHpaDy6f+nKroQwN+YdAxfUSE6Qzrph5eP?=
 =?us-ascii?Q?X6LdnvC6s2uAKXfonUbvBwU2rr3g5pFOvQyxZIi6PqqbChIkfe/5+Mfm4Jp1?=
 =?us-ascii?Q?2xGmFVDV3Ebqm7frHOPTjDTh99EvgJDhRzGFmOelD6kgZAJbqp1HT8xLc3OK?=
 =?us-ascii?Q?oA9ukYMXzDBhnkNqkw9e+z1JuwSzqU9s03aQPp2sxgGTZwR5xI/JWwbvWdcH?=
 =?us-ascii?Q?99H9LuLMSv4+9a+BeBnt9PyR3gq+yoyegSI+Y1TLSCbhdkMX3V9quA9K1GYx?=
 =?us-ascii?Q?yFcjF9UpPpTjMViozs1Ak2oj43Kcnd/6zk7hVjyqF/u1pAtOCxpmYRqtRd5Q?=
 =?us-ascii?Q?h4ejXxcEc5T8DxH/zzaVkUUcg3ajLS/SE32nkYkG7GAHT5xHCzGKrlzeEGkx?=
 =?us-ascii?Q?gOzMsJ1zNNgwYiXsl/ZtSalbPPcthGN4lL67P+APHEFhtJYFl65h/3gCteY5?=
 =?us-ascii?Q?6z3ORybgRzRYyykmPQyezfOUGBGJWqlM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?otAur4clccOB+AHPk+XB4CwEqUHBVxLvzjH8LQC0ctfECCNvI9KlmwLNRR75?=
 =?us-ascii?Q?YDqhnKaZ2Ijpt1oEsTjzy6SA3MNCM0JRcv+gExxfQ98TF9qHao0GCpyCPLkJ?=
 =?us-ascii?Q?AfCTHrqK/hiSlxleTlw6TPAzATPK2J+N5ffPzBtEOnKsmDI+L6QIFuyF8vpD?=
 =?us-ascii?Q?AjJuMpjjly4RfFlYKI72vpiuoA/OSn71Z9crssJimypAvgwlXaplNIyvBj+I?=
 =?us-ascii?Q?IfCQl64+l+QLHPkVU4T16aIGHFIYbOtuHn26MeZd9pGfL+r1FztSmIEC4TrP?=
 =?us-ascii?Q?E/X4McJ0AmBqgvcbq9VhxzgO9wVDtN4ohmAHO4nqVjM5JcxQtuVhulMUqQye?=
 =?us-ascii?Q?OHGhFxge2cXPwSNKIUEaOOgQ++n14j9UAbHSgLIhnVtApNxMt5aB8eAifcZ+?=
 =?us-ascii?Q?rU2V1+FakWGJFouaEYIE04jwAD+HVb96OzwE6FNWi+QOdBURulCopwv8Eo4C?=
 =?us-ascii?Q?W6hwCB/rKEIbzaTL1/kVAQY5d9zZ/jkkccw8RQ3zFz4Ut8d3hj0BbWrCKSAy?=
 =?us-ascii?Q?ZFihdixKJA3XKOxPmqsZo38N0j6/sCwkmmkZcWAt+uTgmH1Z8TsmWe9h2NOt?=
 =?us-ascii?Q?bbeEe9wPZfWLz72GU03xIsnZagFwJR/z7w/0FET9HnGMMa6la0DsQvh4Veku?=
 =?us-ascii?Q?MFdggYaHTgI+tw5EmwXM5P8ye51wp+otCQRTNsfUg7b5yEieZU+nwVm3UhNH?=
 =?us-ascii?Q?M1nrMsfB2X+bZRTVgYDOqv3VDR+ZhSNBKwWhNJ6aNIfB85xzP1XItprYewy9?=
 =?us-ascii?Q?g+JTT1uBJEoCqmUKGKtMUFXxYYZ5oeLsSgHdKZu7c12ETx+ff4z61xmGneCU?=
 =?us-ascii?Q?NiNCeXIl/hMbk9gDfnjbq84svr6h4kf7SqVn1LhN0F+c0Trz0HWzz1491GSC?=
 =?us-ascii?Q?plRQvGngAx9EeJtZfvewPKyPE1d7og/1dYLuptmtl+zc628oUYWVufh898dW?=
 =?us-ascii?Q?JieG8I7wBRRWN34wF0si3zeHowsV1TO7N6xPXEeRybZumdnktr+c3kg42Z88?=
 =?us-ascii?Q?LMJyVMVWzn8cCy5FgfE1O95/8GDWzY+fULiAlaPlTCWzkhEipIFqrEcl38uE?=
 =?us-ascii?Q?132CDiXHlLTur1f96fkY7B9pWKcdwAib5crq8FFLgPaoDAqaDD4UZ1zDkLcY?=
 =?us-ascii?Q?rq2/EncxrW58gtuNX9f2njMvbSqc9BN5sgIvbQk7V33pmZRG2U10DhIt07Qm?=
 =?us-ascii?Q?kzmM8Ofmel2bq3eXAvbH0InrC7Ofh3aGS7IhKSkebRwu1wuYxA5SU5C6R7Du?=
 =?us-ascii?Q?b0lwsYAViUqHbikghXnxkrvjGawvaP8y/n/MTloen5Ss24I6nmSXjqZ/8joR?=
 =?us-ascii?Q?84rzbIqaa45P4njUGUsVjMgG+VTzSpfa7TbIfczrWHKesXBng4yl+1NZsmoM?=
 =?us-ascii?Q?FW5eDsVG8KTChKeYAJN+txVgc47UjmBuakfoFh9EC2wTd8DOWVofliwkS1DN?=
 =?us-ascii?Q?0MqiLAdm913ZD29prFS6Y8ebdfBze6Zt/1DS55cjdq6xhZvSZMcgCir4Hnpv?=
 =?us-ascii?Q?Ds1NLG3XK9PfQHXUFfifEGTttB0Xsqw2fNIA0X5Bk8nLYyg27I1+By/LnLH2?=
 =?us-ascii?Q?xE/RkS6NtPHejLf6QIkFxRlIBQdIGve6OCZqr9oz?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc33e708-9ada-4eb2-4cfc-08dd610d1fc3
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 02:25:15.4353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nj8kCVBDWpOQx5oc91O69TTROvLeI9JzLnkpE4v51OKBvdvE+8F4BvurOL4xmRfjyW5XCfpKkRtRXzy5vb0oUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8106

According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
register only can be changed when the transmitter is disabled.
So disable the transmitter before changing RS485 related registers and
re-enable it after the change is done.

Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
Changes in V3:
1. Improve the code comment line as Jiri suggested.

Changes in V2:
1. Add TE bit polling read to ensure TE is really become 0 before proceeding.
2. Add Reviewed-by tag.
---
 drivers/tty/serial/fsl_lpuart.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 91d02c55c470..203ec3b46304 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1484,6 +1484,19 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait for the transmit engine to complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+
+		while (lpuart32_read(&sport->port, UARTCTRL) & UARTCTRL_TE)
+			cpu_relax();
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
@@ -1503,6 +1516,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 	}
 
 	lpuart32_write(&sport->port, modem, UARTMODIR);
+
+	if (ctrl & UARTCTRL_TE)
+		lpuart32_write(&sport->port, ctrl, UARTCTRL);
+
 	return 0;
 }
 
-- 
2.34.1

