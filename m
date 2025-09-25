Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011017.outbound.protection.outlook.com [52.101.70.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364C52E9ECC;
	Thu, 25 Sep 2025 09:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758791582; cv=fail; b=tS3TGD69K8K/Cp2/3rFQQHiBmEWdqRrkSJDaM3+84bNrg5tcx8ZM7tWeoBeRofVKSYuAjiE14+DFeZvwyVo2MHokm3p6HbQdnFk1rMIJqSLealiCDUtQ8JVs2as9TCTyFEW2ORM1zemmI8/2u/vCWJVVDMMRqaZlf9lXA3G6Duw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758791582; c=relaxed/simple;
	bh=LC7Ww6m5hinqNTbdMEB22yi/+tGVA++18AqF5d2Is9Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xafv+1jVreoxGFGYjrj2KCAdnCUfAl0ztMXLN8VmeOV2yLxbmA9EkyYiq4GRcT49I+q5PG43h7BdBQ52mahjwDraIFMUstKvXO42ocJ+jHSXmvPZm14Q5KNnkNCij3R1UreqLzj7k4Y0558D3nLnRSebXQuhR/zH8gs7aAdWrt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Wkw93Ptr; arc=fail smtp.client-ip=52.101.70.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Wkw93Ptr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KAqG4K0SXKPavUTvwNZEK8ICW/uxddZ4TlCTqZ2EdTr9YGQ+aB+oKbSBicieM++74kK7SSlzrNneIXnJBtggLLT3LJ8iAVmTc9g3zQyNopOkQpKPwnlMI6CdfTy5B5pH15T6rDmzDnJWn1zMO0JrEOpr7OzIlMRWzbyk0uQffcOAHQV20/Zp90bOaXoLan+/gtX/OSBqZbprPPHNOuGoBJIreqvXXaW7rcJUE2WqLv2MJYkCRD0jgqN/souKgtSjbyLiXxUX4Tb4maLXkeoahCotyRBRYH5xcwx1IedV2C104aLo0gHtKfTGuICObTslDTTCvc7dOkq5SC+0NhZ3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/wH47EqqRyQsYV4fJZ03T0Hgo1ENZDhdMpsE3xcMLg=;
 b=qVaoHRbY2iG1FbZAcUCsXMlrK1AImExiQYVw038hsdmtTjxllAai1HuR0RPF5m4p3sjD5A47pVu35yjMcV6devZjRlX+mf8Fv712d0EdHP9HqzwOz7QXlKbW/0z50tzWyRCNHRPkZKwiN6roeNQP4Zup8srbtsr2DeaMhEx+2r3ff1SSuaWuABBPsWQT3742/Vbwfe0pa3T+Lq+gG8yUv1j/ipvZHax9c9Fua4TLexWvddC/3vOYcqZcL4beuXfeblE4/yeGzt73fmbA5ekM8K/bnkLDNNkcWLGQm1hgAvn9dkQvBD6PRVVv4+e1a2seKHGjI6gnjYL2vTPUt5NVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/wH47EqqRyQsYV4fJZ03T0Hgo1ENZDhdMpsE3xcMLg=;
 b=Wkw93PtrYgEeO3cdh7AYtQA5ksESUthbk73SJUKUTjfhAn0IgfvyUPr6MHfE48UM+SfmCIcfeBgz1C8+/gLUJ2SH0Fi3W/r3toMW08yZUVeW+R61xFsxO3RlWK7ZaPSCtd7LGZIK1ry994/EC9GPuAgQRfEFVAcdAgqMCHmuyWjCVKII4yembulhf8OybZ7XlKTwe7SVN7FqMRLw551HqMTRP63ODIPC3OOj1KyefI/zynnXZHz3Y5OqJdanPGPosOdGpvCgpGc6i/8fBmv/yWIBWoTPouIIsY8XR6PEEouurb7JUjPyhpsqzvHv0PIemLAKAq8AEDI5IBJjRmTU3w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8610.eurprd04.prod.outlook.com (2603:10a6:20b:425::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.10; Thu, 25 Sep
 2025 09:12:57 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 09:12:57 +0000
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
Subject: [PATCH V3 1/2] tty: serial: imx: Only configure the wake register when device is set as wakeup source
Date: Thu, 25 Sep 2025 17:11:31 +0800
Message-Id: <20250925091132.2537430-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250925091132.2537430-1-sherry.sun@nxp.com>
References: <20250925091132.2537430-1-sherry.sun@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 151b08ed-9ee6-4449-be82-08ddfc13b76e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOECsZRU1rKhSPgoEe3qPljRJDiHKlbk1eJOvqMVOTzqUAg/td/dee+/c0S9?=
 =?us-ascii?Q?h5BHnyl2xRdZPXJjQYSGbd1pON4C74eCiqGdZ1cwpO2slapyd+34r7vM7f+1?=
 =?us-ascii?Q?+CtIJJlJS2XhVSTbDlEH9U6NWRY3heKXR+PlMXRCgb+kQxANwi9PTj6bg/sb?=
 =?us-ascii?Q?28HBxEnjmWcSqpqf6vr3H3AI0yUgVEcwXgYnr+o+mtacAGmtRL5YASv9vigl?=
 =?us-ascii?Q?p99K1NMAIM5v7G7joJeftPHJgbw1UJohV3Ly7bX/Fp62MPD9p5Pew/bOmnYj?=
 =?us-ascii?Q?KqnRFkXOl3Erc7rP3S9Kl2seJGdiK9zVxQ0F3hYoYMZM2Icdz6GKlD3rjn8K?=
 =?us-ascii?Q?WABtKfKtOzKdCGs0SZmAKOIBFNIElvLj463uOPPZMgRYiLRn/Pv1dg3HQt1t?=
 =?us-ascii?Q?/hyaAQFBwKy2f+4BGudLFA4QDNXiumdADeoLydRnfd0ZITRsU3ZJPDT33l38?=
 =?us-ascii?Q?o9crUaUlCtbs1Unynm6/8j2m2Ebk7rMhzgWZmY/Cmu7WryNR2OaWglsU1Fyd?=
 =?us-ascii?Q?kJHak3ZZG/vkzXlsAHjI9rj7+zwskKWJunKpVKHO2Lr3P+xKazfbKidsy6uA?=
 =?us-ascii?Q?zhYRl7Lf44OBG0TvyfacI7h5icTBinu/mado5pE3ywfGOQAmimeXAfcnkpTe?=
 =?us-ascii?Q?cKDhMwNQ/DZTETt5YA6hcexJOUVt65UiwHtLC5Z8LUiamBvdcEODypzF9YgM?=
 =?us-ascii?Q?dYRsLanfUgefRik6fPiX9i2tCNBeJuLI0yBJXu2D6hbECnIXdNhXnG1Q4HUe?=
 =?us-ascii?Q?y1jfYxGckseEf8DgObYSYQ/JT5KXOHLYeqSRJatgXts2LOBY/4pk6LEjQ8bd?=
 =?us-ascii?Q?Xno12ZmlMKdeAiHAZGUMUUZ7LmUc1e3ecbstuYUOEHqIUQJ3vIbWturIXzk9?=
 =?us-ascii?Q?jH7dCxNdMiXcgqZtIwL0tfqI02T21/H8IRzZUNXD8mYRZF4eXng2ZTTYFF7o?=
 =?us-ascii?Q?Qz8lFah3z1XYlmu5Ttpfg0QHnqxHeOvhEGL0dZGz6Ceb3WUggrjDgsTlmZxT?=
 =?us-ascii?Q?5hn7NFq93P5ja7lfOdIdr4E66gOU6GumxzEAoNihAIALCIww6EwYzGne61CH?=
 =?us-ascii?Q?xj1knxdGjdzZF4Q82YrJ2Lk7pmk3Gqb0PcMhFje+5wYvRLguVl3xNCaOEGiK?=
 =?us-ascii?Q?eD6kvlPlwC8fI2bsW7gBCG1yiL/QGSEAZLSE8dODUaPaMSccCQuJV3Iuk+UJ?=
 =?us-ascii?Q?zUmX3WqaYk83Lt0eV79RTkTXzIPfft8wjcn3eejuIJwJnr1lsiRPQR3tElqF?=
 =?us-ascii?Q?4xU6Gfk9BveRfvAcq7iCugVNUrSybrRzJknk+Jx/lQwy7SDYQ/vuc1wGJUyR?=
 =?us-ascii?Q?KPWgJnCjO64wiGRp/vxW7hum00brKBkJ8hPAoYgHD0gzvvpBVgIaygZtHRVu?=
 =?us-ascii?Q?p9VYEwxAI42ieB3UWa3DVKwx6knpWkPms5tXjwJTADtGv2hAjho/d/+uIzDc?=
 =?us-ascii?Q?dXEroBaSYG8DEsbsm6X2+s9L9hPOtEIAT5VH6AiGcYGo4I+YAve+fw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FEm9MZG76O/J3tYKFugIShEbiODSQLwk3EfG6l7Q7KLNxgmFIGgxHya2NwOE?=
 =?us-ascii?Q?I0Xy1jWirxrNMYXTm5JkH100YUq+3JGaZIoCaEoy/4JUGrABvKSrCDaoYcwp?=
 =?us-ascii?Q?PX7adXtQifdyx9OrRjggTPk/seMjT0CLOnvdzPVHZeMqv/nsXrbqs8+zPfkg?=
 =?us-ascii?Q?Za7Yl4DS6GHKjJzqBHo7rC7IAZ6eF1I0gxPjOhIA9kutyeEY78w5MZ0Z7fO8?=
 =?us-ascii?Q?7mjwq6X7URjA6Fx5gzrGooaj4QD925yrASUNlE8Ai4DKX+xTI6ht7msmKU8q?=
 =?us-ascii?Q?uMh1zxKYd/XYmw+7E9iID79bdKjXqogSvIUjOGitEu2s8Co7i55Uxbv7eB8w?=
 =?us-ascii?Q?aMSqudo7gY1EkXOguGY1WdlVDo1nMWPnWFEF+qiL/pm51eQKCPAMQf+Pn3Z/?=
 =?us-ascii?Q?z6SIrmoR+4XBfEx3UYqTBweM83IB95GBhpHC4YElWsK0k2jwmnNOs9x4FZ7S?=
 =?us-ascii?Q?qkUL3W2SlhG/kyF643grcmYaBMKSrsfoaCmD5cMhLe7eka6I36bIHgat5xxt?=
 =?us-ascii?Q?rmU4mwYtpSiDrSitPNki4N+T2dfOUU+M16y/jalHXH1tsQXn8iHcUmF/k/KN?=
 =?us-ascii?Q?JjlHgd8mgjFXGHaB5e+6bbOW5ynfPI0em91o8cMVCL4JpBN6/mzw5k8OPQnm?=
 =?us-ascii?Q?iYSXW9XKTeXArFzeWix9zK2s1QB+tlqGzNkAPVd6Ou3e5oLpjCZ0VPUc5JsG?=
 =?us-ascii?Q?s1zzovCJS6uqHAxJrtUR11J1nJsx2kwqKtvu07vlri3otU90fyK81vvpAoVG?=
 =?us-ascii?Q?ZXuhrxFDCL8qdBiR3/+fGv0XNaupvCP4MfxOkfmiX+F2B/dHwcVl+8oYiuEC?=
 =?us-ascii?Q?O4u0U4WB70LN28R2D6klvKgU81iOLPZ5y7LjtTPTOPebJUaNlwyuFD7e61ev?=
 =?us-ascii?Q?8QRMVVZUiJx+ZpOliGx+qT+CzzEr1/qvbIEjPHTCnlEyz6O+0OCTvLPzBbl3?=
 =?us-ascii?Q?gps+jOFqQXB4xAmDfUpDG3fhg/k711F3VvLCeRjigngOpWWD0odqdAFCxKzx?=
 =?us-ascii?Q?EYSwB0oB5H/1zNzYsZye+of46cafywKLEsGEH2AdQ4XwzIP/ISwmGpPyFS3S?=
 =?us-ascii?Q?yC0/0pNbjtbblqes0PkR7Y8pyylIyT/15ANY7HstLaC5P79de2UD+HN8TPWX?=
 =?us-ascii?Q?ooN8RzA2FiK5LCHEikPIl4krNIPYf0oBg+PeDtsZj+aUvjg+Bd8NYTJEZPhF?=
 =?us-ascii?Q?NvOU1/HekC1r8j58J3Qj7wLVZ9sj0uPbEQoZ8Aih5MMNJYjxVOmdalkERyvD?=
 =?us-ascii?Q?AqDpjwBSfZm5Jx60LziAoeNAuVMtYZv1gyKAcN8a35hyPI5k1trhOwztewbn?=
 =?us-ascii?Q?PU+G5xepioiny56gSzouPvvr0Re+tK6pa+mbju1RsKeegdPkf+fA9orQb/dB?=
 =?us-ascii?Q?jJO2NTs86Wu6VxI/YchT5u8QGgkKZ7q6CEGG+KziLbfugd23G1/dg3mfixA6?=
 =?us-ascii?Q?mgG2BQa8u2tel5ZK/PHuJ4+YpWqEGm/CJHeshdQQzB5tsL3tcRHAv1lKsjiP?=
 =?us-ascii?Q?kFRO/+ka2sNGGRQL422AoUhyV6r3ZP7lv0glP0z08LbkNZFKbRkqVWFigxgK?=
 =?us-ascii?Q?EZVeGrMni8OvNBBM7CTkglQEoqmcRmdbqi9EnMzr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 151b08ed-9ee6-4449-be82-08ddfc13b76e
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 09:12:57.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qRqBDfKbydSFFQxYIzSd9u/WrR0SFBxwcFZsXyIGN3SBMzYEjaFRYNM2fi/fgrXm5tQBYYIocAxWyoQKp8aLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8610

Currently, the i.MX UART driver enables wake-related registers for all
UART devices by default. However, this is unnecessary for devices that
are not configured as wakeup sources. To address this, add a
device_may_wakeup() check before configuring the UART wake-related
registers.

Fixes: db1a9b55004c ("tty: serial: imx: Allow UART to be a source for wakeup")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/tty/serial/imx.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 500dfc009d03..87d841c0b22f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2697,8 +2697,23 @@ static void imx_uart_save_context(struct imx_port *sport)
 /* called with irq off */
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
 {
+	struct tty_port *port = &sport->port.state->port;
+	struct tty_struct *tty;
+	struct device *tty_dev;
+	bool may_wake = false;
 	u32 ucr3;
 
+	tty = tty_port_tty_get(port);
+	if (tty) {
+		tty_dev = tty->dev;
+		may_wake = tty_dev && device_may_wakeup(tty_dev);
+		tty_kref_put(tty);
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

