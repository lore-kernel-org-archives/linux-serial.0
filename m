Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2054.outbound.protection.outlook.com [40.107.22.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20701EA90;
	Tue,  7 Jan 2025 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236300; cv=fail; b=XrzgqqbnvuPkW9QBC/rMlgqRTbtMpM/KkuHR8fELdVU+dkKE9eAAm18Sn5oeww16gV6kdzFnS9XBtnjY8EkU7THkjY1AovhgrbLl2JscetC0OHubq/XnN8eXLGImwYpj/IvBQMTL1KPhczl3ts5kRdYDg2fl/f+9N28QIZmefw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236300; c=relaxed/simple;
	bh=4VDiAzj1FP3qw4hghiS87KZ3cD9WrPYtCPxNqJZGwzU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BhN9sTv2mKx8vZYtXADH2HeQEad7liwS4cmPVFx8yQihaF5CNey6407/be7/LlB3+pS0pzb15WGLl3e2e8yrJZS7tmG+zKxmcu7nR9DVDBraGNf1xJMog+EHPJ1SuZuvbjo6Z9JmK2nziHhpviRaCnnn+aGD+WSrL/5DvWsUJFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=SiTgSs1h; arc=fail smtp.client-ip=40.107.22.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="SiTgSs1h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfN81jFAtn9IUB008hmb1FcFBF1a8fC1M0xSZJ4B6Ar8ggteq+BM3d22W42eXS9KKJz5j/KK68GUmCUi4obyP0Ej0Uym82shP//CpUsy7FV4ceHDH5W4QbXsO7KYbYgsbMY62FHA+0qTkbXdc+iY7D9rELLi+qj2m3dOC1IXp0oIa5338N8Gm0fD6mNj5h1ytt/JIVw0dlcAkHx8WbnFJwd4dZ2V28wWi80aHpn0LAYYFf1wB6y9OGajQTRVDK/I9BH+J+PbgM6zlgDbaMjlnzfO2sB9rGlEHRE8Qm1jaTioweT7iTaqBLd2KpIPMaBJeFwwiGKfac1e8o7Rt49G6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8zX7TftsYmzUQll+W4N9YFYyj57a4xsyfdjNRzSUho=;
 b=sXxXh1Qt1rZWmUPBhyn7MgauBVar4mKg0XuPHGCDbAG7efm8wlRQe2LGVO9GP8CJjGODo+R5W0yjg76f+w09uTYYbL4ouMgr0SoKdAVaWt+pUPbm+SgEZQf880aLUOYCacKJK/F0U+V0jecygGyILIf4KZ53HB52lbRwMIDrSv3cGy5ovxqxdMOxTo+JmU/1ShihHFefzQHZJ6YQcM97gCGY2qZwf+GyU28QVuP3/i14Da7/nJHsEKLKC2+odZT+vxnF+kVGK8wYuBQh++KdIMJcgsQgaRiNwFNvKCJtVXggUdqvpZ99tzAIPPX+1uXeC81yxbpBZT5sIC55mI4JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S8zX7TftsYmzUQll+W4N9YFYyj57a4xsyfdjNRzSUho=;
 b=SiTgSs1hXPe4RsZiIBSchXVpsTGPNQb/3OABMIlxD7XMHy0SfabM4QxaDIU/DBK2+mIJTdlVo/9A6FanJjEXXr/bbpwnp2aku+kc3nvDpM83cm0s1HqK0zzHi/3s+LyedGVSChMEIRyU/xS+let/aekYdkFgqErD2RuQFeWh15r+SZLslylNoykvpev3Il9xa41WNZUbIALzoa1Baz6av5A57MUeENlvcL/L6LSYn5uAT23jJf/eu7W9QAmxiXd61eyfoCPvFtHy565ndd8wKm9eBV83DT0fG3DpjHwW+56wVgM8gFLX5ODC64iwlDDjMLJDsKp72Y/j8gLNxLF3Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PAXPR04MB9137.eurprd04.prod.outlook.com (2603:10a6:102:22b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 07:51:30 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 07:51:29 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] tty: serial: fsl_lpuart: flush RX and TX FIFO when lpuart shutdown
Date: Tue,  7 Jan 2025 15:48:34 +0800
Message-Id: <20250107074834.3115230-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:990:77::6) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|PAXPR04MB9137:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d97641a-1753-4305-98f1-08dd2ef0188d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WQ0Z6rOtaJz5SIxQzlDFKv4IqY8wwEy97dFepjZre/qRh4M3zoc2W2IVJk4q?=
 =?us-ascii?Q?0qGElITmPDcQTUrkYNSW07V5jaS+XAs505K2ZbCJp0xeOkWWbfCbac/NesIf?=
 =?us-ascii?Q?+5kgdCdJCW3hk+QMj8FLHAs/mJR0zRwQPP7QEPdFOBdLWYevEolkuvyWOReo?=
 =?us-ascii?Q?7c/4CBOXZ8V23prJomwknH1wmP0Cai7o8gKD7icdHOPG8FTeCFl5szrW12UQ?=
 =?us-ascii?Q?5UreTTJe1JopEb1JJ6zSHvecRGoNW/65oOaNhqZ2iXuwjeDYidh9jeH+rZ40?=
 =?us-ascii?Q?0RpESiobO79wanhwQrTdLf6W0XAWOTS3zwTfI1BJ82wpGqSlsgP37h2S/R1f?=
 =?us-ascii?Q?DdvVp4qw490JGDNQYGlIYncTg41QjGRtGf0mn+RetaFQPs6XSiMOUjV3rwpV?=
 =?us-ascii?Q?Sc105nwa76VgatUru0ziFO/p8+M6mzxyu8CiFd5XGal7SKiR+4Jy5gYUmH2h?=
 =?us-ascii?Q?OTVAErrdLAFl1kUjU5nbgVLOnfKGccwZH/C2dgTsKIEx+0StanQbIZmkBSiP?=
 =?us-ascii?Q?AGFR3N/qfNjV8KDvnTv+fxL7s+goNFROM6lWo+C77iugSzwqRE4glwrI1Eu0?=
 =?us-ascii?Q?vdwppYuKVCFJ0OgyZ8Ghxs5BdJ+gNqiD8jitYtqRpGL281IU9LfYhyYMlgBv?=
 =?us-ascii?Q?FGIJzwpraCml4TWuiWBVKoiMCP6LFPYcQnD8vEM95xIij/3LZM2XZt9EThfx?=
 =?us-ascii?Q?hIkHLWV3BEcx44NsUT9TAdruRdmr5pHVuq5vxsJ/QaHGwxQPYQx35XsouIgI?=
 =?us-ascii?Q?CRiztfuKHPb+rgltf0x8VDRiZtv8OEY9XtvTj6b8o0+/ZJIHjSy+KlyRXkOr?=
 =?us-ascii?Q?NZgoR9ERbZ4BGTqU7shGkrV3w2mFCFcQYjIdXMuNP0NRjhFTFQ41naie6Yxd?=
 =?us-ascii?Q?PFwQQ7rjnb9oA4ukZFbVe6zi6A9R0HUyBHSC9x0TFW+PtDo15/A8M7AVR+Fc?=
 =?us-ascii?Q?k6zbnZD5Q4joYDApfhadxgLkYPIbSL31sWdo/R4Ys//Rf6TTl5U41nAMWAXp?=
 =?us-ascii?Q?qdLGpbPNu7Qjm8dKvwX+rscnhkl8942fFmG6VE3NzRxMs/JzEuDbZnM2qjBT?=
 =?us-ascii?Q?N5EV89ulb3fKtE6W0PMhVPoMdw+jIZqrXjLVKYiFoL3fhEn9meLktzgqyP/E?=
 =?us-ascii?Q?4HyMs0RW4gp6M8P9uamv6nXl5b/ah2imBlmT774rTfov8akwzUabYlUxrIrX?=
 =?us-ascii?Q?3mdI9PJps5asgiua1HPdztUJ4Z4ExQ0s4F5f0aFGlpG1rCzxcRFooff4zaxK?=
 =?us-ascii?Q?ca9ZaISv+xJi6oTG0waBFB/egw9Io4pJXO9Ep2cxhJqIEywN68oVKElEqtOx?=
 =?us-ascii?Q?D7t1NdVa/Lrf0PNBSS9fK0QQqzQ/KTKkpkvzOldCHS1FmcgiI8qfDvjgycHz?=
 =?us-ascii?Q?n9s/1nt4etNKCfT29Ni4uS495RjvCNbRZTvIwuSmfewnCnfn48yge0obzPZc?=
 =?us-ascii?Q?7IteY0oK7Bidaua1lXUs0LR79v9egHYa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JNmAt9fipQOx3tNKuT9PS0evPIvhDn1aXcMOgaPHaWSUWGNBZSD0YpDvYIW+?=
 =?us-ascii?Q?WR6IbI+oqXgszkUbw59yIBSOePMoZGpUbW2VvhfYzG2PS6Zl8l2jeZNj3N8y?=
 =?us-ascii?Q?ieBoIUA617ITExPWYV11Sd+WNEM4v7KYlBLRfNzXpe2Q76SNYYSSKqxM4Uus?=
 =?us-ascii?Q?hMu5KVfjpiFsMlvj3sCfOR+Qw7jzbvYMDECT2G0I6TC5nCNYk4w67aSx9vDb?=
 =?us-ascii?Q?D6XwxLCD6kxi+T2/Gs9PfAPq2wXtV4/F69AVykPuXptTXzpX25o6gi6/bVYt?=
 =?us-ascii?Q?ti7AcTVyTFknggd9/T7kmvCIUQE/9oNK4hqTSJ39MustHrsgMP87YDdyg7FL?=
 =?us-ascii?Q?EDcWxxhwOXZmkEZxq3AzFCfBjp8QA3GbFaLx2FxMEK88LAtFZHcXV9fB0rlF?=
 =?us-ascii?Q?wbGoad0JozchT/ywBaGKSSNFnVSHO3/3BCblIK8FAbBnRZH6PZ+qfDtumKlR?=
 =?us-ascii?Q?CrTr0XG27S7uPg7fMK3RDjul1lwoBDIxiW3NbpalLETZXSMe33RlMb9E0uiT?=
 =?us-ascii?Q?SuUkgtAEOJgCgXOLqiAp8k4G42GaCkOLhSRaqnV6K+tg1ufyrj4rcPFDdekv?=
 =?us-ascii?Q?FPrLVhNl+ht2PNLZk1oNbq5OaHzrCwZg3SLapAYC7eeXzPsbytTRGhmS2l/z?=
 =?us-ascii?Q?RBh8qPPtD0prv9Jg57eMNs0KDlPVPZH18IDY7zmZP0nldKV+TGXkruQ4qTd3?=
 =?us-ascii?Q?FDw6nHj4ax2Xh/r9hLiA4a997036XsGJFv97IS32qRbCdNdOcoWn/qYqXdr2?=
 =?us-ascii?Q?1qmJPQ5K3QHB4EdrsofpVDLFKrWztNbUlBMNDKWAkol7bZLh9AcWG1aJhfhU?=
 =?us-ascii?Q?XJiti5G1HFfkBfy3xu4Ak1Hbfjh9Jcb3KsjE2KQnmmAU3r6HOexygAmGL7nx?=
 =?us-ascii?Q?SuOKsIsODAPwNvSAEWihYr76tpXL7x6x/sEJlTPPkfAMGcpojIpoUdLIWA3x?=
 =?us-ascii?Q?g1Elnd2Erf1KHCov6DGdRdZOHyQcJPkMhzhXYSQRjF0gzaYms3POiR8v1osS?=
 =?us-ascii?Q?PwqWw1xkvpiMbuORPjAZSocGm5fBaXR9zzJHpFHnKeMEd/0+2KLev+iO1Lap?=
 =?us-ascii?Q?ayc3GgGmKdZkjg78U+irw7RoancOLOnJF63AZqBuwW9DvoFUBOLJ5MfS+Rpd?=
 =?us-ascii?Q?o7qJgcekEvdoJxJnpu3Heoo8neFNXT6/Iiraw2FC8T3ROzvZI0C5c6w3jSn7?=
 =?us-ascii?Q?hfUNL9iFzQf3YesQuj3YTgEGagnzXicWezUf4jEZFsatYy1g99Is8P4GCy33?=
 =?us-ascii?Q?kEyuIcUusKImbtTT3BMKv5dLFeT9De1mF0BkMDcXQdgT3mjuTx24X+PA9bwh?=
 =?us-ascii?Q?ELSDFwuycoSmcqyeVJsRLnU9x+cRlhje/5GXpLog3eSiAKJDdv7PeFj5WK1Y?=
 =?us-ascii?Q?+WOZrtW29FbkilZMTQBFZMpbu8tUpPUtV6VXu273vypNzews2FexnTN5NWMN?=
 =?us-ascii?Q?MWHC+dunPPQpKdzng6/oRRE4wGq6YlZBEc3qemYt4ak/FRc8LVweAVrFSviZ?=
 =?us-ascii?Q?rkpJlg0WPMPzJ9F8KARTgKZTeI/g3/FyyDKrhHRU51DfKb1X/lkIYvtnuGUr?=
 =?us-ascii?Q?6fCXsMy84l37nhs+oDKYfZZERthoL+boxb4H/16H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d97641a-1753-4305-98f1-08dd2ef0188d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 07:51:29.9608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hq06h8LQdfKMPLCNRYm9zN5DmUljL3GxLmzjJ8ryFhZxTZzLJwrwbMfc0QOOdYYw7Rc+0FoSWgybvSAHy/v7aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9137

Need to flush UART RX and TX FIFO when lpuart is shutting down to make
sure restore a clean data transfer environment.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 7cb1e36fdaab..c91b9d9818cd 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1965,6 +1965,11 @@ static void lpuart32_shutdown(struct uart_port *port)
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE | UARTCTRL_SBK);
 	lpuart32_write(port, temp, UARTCTRL);
 
+	/* flush Rx/Tx FIFO */
+	temp = lpuart32_read(port, UARTFIFO);
+	temp |= UARTFIFO_TXFLUSH | UARTFIFO_RXFLUSH;
+	lpuart32_write(port, temp, UARTFIFO);
+
 	uart_port_unlock_irqrestore(port, flags);
 
 	lpuart_dma_shutdown(sport);
-- 
2.34.1

