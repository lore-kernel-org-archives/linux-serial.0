Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2061.outbound.protection.outlook.com [40.107.241.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B490E481C4;
	Mon, 24 Mar 2025 02:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782241; cv=fail; b=l/PrXdSLktYSqNqhgpbjFp4z6VF2kkQ0NIuc1G4I5THlnvM2ESMyr2JDTHZ2e0FBJgj/6sZaJEnNiYex5xXL2rk8LxfpVkQ08tl0Q8iU/IzSzpsDbguYwPRTX0DGOKNIButdUf9AiCS837R6qgwsPS9kaIqj5OxFrXMOcLtK71U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782241; c=relaxed/simple;
	bh=gPlYSh9Qk64eBKwnkA8qIYyJ5KhC97tyg+sdu+wkuNk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=u2qItu9/nZY7eJMyC1D83Qlk2HhMPe8GVFtaRAySP2jwmp067aztGvcSj91/GFhCcf7Gse4cz2Cvbk4JNDTJOiImhwK47NBYkiL8iV2ywZ/8hGgmRn/+1tqN4APQpk6ySWunQancyMDLSpYuqvrX9IVPil2aatPo6yNcQH8ZKeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5iLyCqo; arc=fail smtp.client-ip=40.107.241.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5iLyCqo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xwdeaxSdua9LhpS91b2QLcZlKE2RavCqn02zjIuiS17XtOw0seswdGKhhiuF4rpq0Hkjdqa9wqySkmSpID2sKZ0WSJjxXTcmM5c0SjY6E+4iZV70WAHaaBMByYHpr52GaVTo5lSKgQWwmeLIryrbUvedSzRjXAUYXZp3ifiNkC/etL4B5Z3917H24ckJF6Dmg9c65glimw2ZfFoKps4TBlDSst9gzulBUCoDjQVV6PoaXTToOOGOXET4/x7HVuDHamSfK5MngRKThumPIsMNsdB4Q8uBXRNP3PJTMCC9y6tvRKX+ODNxt+9wagWYHfx/2gDOto+P67lEReoTJHwBhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9awYSsp1OcS+FqeAy8JBkrIuuSBzMPPvD8ygkce//XU=;
 b=F9E1drvWYcCCxvm0OZMJ8tuoV72ox9NIggzvvI1t/k7ljj7K8eEg3xsi6Onp2zaRJmYtVKVHGPZu6KeNNXZfih7BKpw68EnPOcIif1kgA8ekWR2z/Pzh3hwsUp1zMQVdJ5e3dldw+0qVY7fxxLn6ViddklnrFXue8wLXE1wu/hIao4JLjX4U548g15t0D+1Dn1z+0LQqHcXrqNsFngC7G8rcge+JUXdLZFvg6BcbBW4pCU9An06LmWGTRZF4QrA/SRSgzX10rAzPn+9dL1roLFn1QFE55ZP8pXSuLruc44xAxVwHhmFbbH7aQNPxbdNGHWrzvpHV6conquPoNwbuSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9awYSsp1OcS+FqeAy8JBkrIuuSBzMPPvD8ygkce//XU=;
 b=H5iLyCqovMvdhxKrviyes/9KlKmPMVFeBi+q+j9wW0BdeLOAj0oDiWk0VAZQ5T2Av7hRjAswKnxQ+oylKVB6oauPPIEjLpxPfEZUjHz9abDqqB1pd2rla1aLubRGgmgnYKeKWmL+Po/k3ePiacO//9I4jW2dmTkHpVCOfIeSfdVpR+lINes1Pu03KeNQ0Of3qzDI136jUlFeus1lbLkDS+S7Bc9gJo8Ru7rpRAtQIHEnSbZNj0C30z1fLNdur218+UP3gIYGg6K9+OJj2kSNcRAvFCL3327tACfFytqy7M07rE247UohU6LDyb1vfRq1EOwRY6TdFRkGDs9/+NkMAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by DU4PR04MB10813.eurprd04.prod.outlook.com (2603:10a6:10:586::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 02:10:37 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8534.034; Mon, 24 Mar 2025
 02:10:37 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] tty: serial: fsl_lpuart: Fix unused variable 'sport' build warning
Date: Mon, 24 Mar 2025 10:10:51 +0800
Message-Id: <20250324021051.162676-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::23)
 To DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|DU4PR04MB10813:EE_
X-MS-Office365-Filtering-Correlation-Id: 98b1a1ee-c47a-426c-c769-08dd6a791105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9yeOF0lB6F+8pwBZdQZi1OCwQIRBGuOTJ9CjI0kBpsHAEXJ2jLxKfKlOJMBF?=
 =?us-ascii?Q?FNEbkYy8jX0Hpw9895ASOGKJG1K79q3X9k/MOpV9v1Yr6bjkIXWDQuMzOH+X?=
 =?us-ascii?Q?qtUDrBR3VNlmY5NMUL9/x638wRYbCrymdX2ADgiXi1/rdevhIVlmnQldCwYc?=
 =?us-ascii?Q?6o2fPohun87i+b0aenYl2c2UXF+dQL7TqohU1mbnMN8ztcGclYwqT2JXwBzL?=
 =?us-ascii?Q?9JgV7NW/IX9S0sFb/b2yG3uaeJNYEgs0Fyrvy8mzJ9YmSzR0H7nicx1xEJ14?=
 =?us-ascii?Q?q3ikfkkaSINltnLRi7hjQF8EvLPeE+B/Mtv9VnfYKX34GMVqIH16nPCKCJx2?=
 =?us-ascii?Q?Pfh2ppaQKUjNGxFsQF2+HXBo8fv//AMMERyS/+mnk4NpmGWhhj+saANUFeZD?=
 =?us-ascii?Q?TSX3uDrYBbTjBe2S2SCB+aHBptcsD423/jIEueSZf8Kj+wmmwg8qkgbAiQCX?=
 =?us-ascii?Q?WyvzzPNAHWZCZnbryN5xzu4XkDcllqy9KwOdfGQN/j59GxdHkSLWB2tDdAOI?=
 =?us-ascii?Q?RhyPv5M1wLbdCbvl+Vy2I/7+WAnFwH4zEh0fAPyV4PVLGNoxAHBncUfNz5Zs?=
 =?us-ascii?Q?AZJHNkpZ/o57k9F3rprsH/Vud9ezsXX7O6/AzbZsVf06tU87bio9FJibrK02?=
 =?us-ascii?Q?YgTZRojuw1w3ueDHLXJZ6q2C9a+pGLKmurcgYfDrywnxZ0JPbnBeMltu1sTK?=
 =?us-ascii?Q?itGfBuuZANPIQNHXhFCVvempQXqZARy39d9zTWhQ9ECuvtTp3e3FVqEr9biT?=
 =?us-ascii?Q?lXm1sEsTdj4OhtdacxHy/k9+Lu3nCaDxPfk+BKS0kLRZdcsBICxWRoBdft3Y?=
 =?us-ascii?Q?9r1RlYz7milk0tkPLmLvz/0MzQedsWJosnnk+/pVLq2VJXHRybU5OGBqRW3k?=
 =?us-ascii?Q?UcuhyqQu3pFDoymKXWa8HAw2SGGY8+BFXpYkt6rLEKyH6lNoC4t0wgvpjjjH?=
 =?us-ascii?Q?eBz2Bur14sTSosgjw9oIZWH/OABcXC7YunUDJHMo/nOo76fuXIwWVZT5q0jD?=
 =?us-ascii?Q?s1tkAQjQbqeL079FviuEvw4AbxOi7n6iEkrl9TP5AL4RMxv4/NSDUptanA6N?=
 =?us-ascii?Q?+Fj7Wt+Gixp5UX3bSmsh/lN44RWlBZ/JK/ZzmlN49soGnG0L3h8CfbUQoxXS?=
 =?us-ascii?Q?VHsKZf5Tj+rFx6n6PS/AsarvlEvDnKxeTC7951nJcFQix0Joo7XXhT5AW3At?=
 =?us-ascii?Q?uTCV9eGHqgewpaDd6KuPdGKCdaRs/sm5645W6Lan+3746kp3kuEXYY5qvibU?=
 =?us-ascii?Q?5KLvR/a9JVQaZaxcO35fxUiHxBYeAcZJBjYSfW+6EuPH8xh1A0YbmVHaEhRh?=
 =?us-ascii?Q?UTJPMJAebX9x0Ndzpfl2WB+np9fKq/2MF/OrprDaAcCv23bDNTz3qKhyewsI?=
 =?us-ascii?Q?58b4opQAS/F3M1KWx0V+s/z7yIOZOayGX/XW+/agVlTB2QhDfc1FcXKjiyaP?=
 =?us-ascii?Q?2t8WGJJIHPIOoYnmYvSt2lGFo1P24nL7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ec9Qjnh6ZZoTPkYr9QcQ7VHu/ULVBgP2x8o3KdUFVXCRP5M4yUV2T+6UyGU3?=
 =?us-ascii?Q?L0Yz0uXvNWaiThtfvc9BiguDkbqIUyCioD4opJsNU1Wvv4nw0xvoHf+gzV8u?=
 =?us-ascii?Q?tbI3Gebab5RxYrPUxfMK5QDut1oG1lHoPf73DkAD4zTv/DU83VQ9M8VeSh5E?=
 =?us-ascii?Q?M90en1V/TX4kgjwQbGQolqr6YK2CJXeiAH/0gAbU9KIIrREr9ukXQkqJ5bdG?=
 =?us-ascii?Q?3KIx1S1Pys2cnhjvmAByku9lQXI5MUWt8VGDOr9//lvjmFiFLF3ZEFX1cXqU?=
 =?us-ascii?Q?aakvRubcGzJIl6JXkUbskP+GQUc7zpC6B/EH6nP0OMwK7Xco/+6QEQqu4RAP?=
 =?us-ascii?Q?LtS6FyAhUfzbh+B1+CyUEYdBciZin8bz4u8pvXeXGmGB7Z+dlmnw3IfXgfEu?=
 =?us-ascii?Q?RAJyAFboMYroSBztAKxjYK/U8cjx+KKFV8T4FkAdmsr/BowefIztYc7mgqnT?=
 =?us-ascii?Q?hEDny5ETdw6LElaQk4yu6O8BrSqorU0pKE4LJU5vhx5G3S6qO1SPwsx49Wtq?=
 =?us-ascii?Q?2w3S+Fn1zS3Ul2ADnssPiAs7DAp37Z3XS4irvQc7BemJt1vDvZDF66h6YFhD?=
 =?us-ascii?Q?9AXTdX0eWxq+tsYgIHcF5Ygjo6GkyH9pgQ9NN85N0hpIkwBw7soD5g7SEKIP?=
 =?us-ascii?Q?bXwxPT3d4M3Px6xQLiF3R81GL8pISDFv1LuB2axqnBJ+TgGrWXVq82ui4Xx+?=
 =?us-ascii?Q?xKIPwdOeyT4EPKGMfQ8A+hP/F8S9PY/23QmY6w005rrlLYUOCCsQOUWCDSp+?=
 =?us-ascii?Q?poTTWtKrCxj6j4R3CczyO5x+fl5751/imFrnBnIERPNnw/lE6wtZVLJGf/0u?=
 =?us-ascii?Q?pyp3mLa2Ei9+vbnUW6UQMN3SvAlQ+J9aIu8+IHti3wQTb28U2/IvrqUkKdgW?=
 =?us-ascii?Q?b3hVzauYu88Iz0uvyDcwLJNwpHMciwRV3Cy6aPs7VXqzDRXJ9BwBFJI84nL2?=
 =?us-ascii?Q?UxV7YirZ0MloftIFWV/Sy8wPQrDr6AIFbcB6nlBm2KD3TcH5Rfg1QccVIUG4?=
 =?us-ascii?Q?MxDbbNt+7l6AVEsiB1oeFGjyRp5uLJCPzHwbcWbnME9fyfKmGvrKjP7wVIrl?=
 =?us-ascii?Q?wnsHNlmjaHt8U2UQvebrLI1hcoh222vYJWE7DJfLFyi6ArRp8Pu6m3/Ctabp?=
 =?us-ascii?Q?wV8HK2M/pYS5rVceeNFmmJ+nNunw+BCaDYWiuDiLMfwXlKcE41BhKt+68CVK?=
 =?us-ascii?Q?usThC2GMlNZpvlyjOC45teOY86eDpkAbM+J1cyC4uXTIqH0YQoArHC1l3oZ6?=
 =?us-ascii?Q?qGPDJZgoylzBSPVAl2G9UWHoY+UXvXbYPKF4CbIn3UdMCG6AuuCAuXyRydFy?=
 =?us-ascii?Q?A5cApQDvBD2KL+NcIUG0QF3sx9LOBQ9fZcZpobmLbbfv41Zbu8Njg3djDxAS?=
 =?us-ascii?Q?WLjk6WA5GnEgGWOI/Xle0huTYQ62EK9q2epmTLvBjoAnpVJ1+le5AyC1+MlT?=
 =?us-ascii?Q?eDLYewc1Mr6xG/R36fTgcp/AKxOQtWpom5dbvtDwOa4LUMwBgOErH4/CEKKz?=
 =?us-ascii?Q?EBIgP3xVa99jp1febufdZ5zz3yA954i1xT3u8qdl2o/FkDSJ3g/K0zkFp8cO?=
 =?us-ascii?Q?KDxhVD6TGuHtE03vSaoqkdw9oTjnpf9jIYScWsQ0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98b1a1ee-c47a-426c-c769-08dd6a791105
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 02:10:36.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j+EHkwTqX7DdhUB8YJVHemZbdJlybf3gLRZ9IlZEEL9BfM5v8Sp4A+fZpATn1n+MylYVx9WSs81R6Ra2WAkHrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10813

Remove the unused variable 'sport' to avoid the kernel build warning.

Fixes: 3cc16ae096f1 ("tty: serial: fsl_lpuart: use port struct directly to simply code")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202503210614.2qGlnbIq-lkp@intel.com/
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 33eeefa6fa8f..4470966b826c 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -639,8 +639,6 @@ static void lpuart32_wait_bit_set(struct uart_port *port, unsigned int offset,
 
 static int lpuart_poll_init(struct uart_port *port)
 {
-	struct lpuart_port *sport = container_of(port,
-					struct lpuart_port, port);
 	unsigned long flags;
 	u8 fifo;
 
@@ -693,7 +691,6 @@ static int lpuart_poll_get_char(struct uart_port *port)
 static int lpuart32_poll_init(struct uart_port *port)
 {
 	unsigned long flags;
-	struct lpuart_port *sport = container_of(port, struct lpuart_port, port);
 	u32 fifo;
 
 	port->fifosize = 0;
-- 
2.34.1

