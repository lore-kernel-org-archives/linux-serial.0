Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B351C3038;
	Fri,  3 Jan 2025 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888505; cv=fail; b=Ond7DB07SjO3VqY9EM5ZQ7Q4dCp3eb7x3dN0l6gMQymG5KRShiC9ne3kGQxy8drViwCLZ5sVTOCYYakTm7miCH19/blwQqB95eFVfy+gySpUOf2lV4VijSilkjI2x8kaQKPOl43PD9joIWWF6T807twh2lGJUf7w2HaLgUAq4JE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888505; c=relaxed/simple;
	bh=AmJxdtL34Po92X70PUOIilLCt06u9PqJen9Vh9SWfh8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BlX0f+fWPJA7Q/YmvS+Q1/ragrD5423LVCQLoVWprN6vJU19MVhx5HtKA/WCgJWpub3irK41O5Si08VppxxgC0/ACowpDKURy+TFXpN55zpQaqCIclYVgMmRSSG5I1jREeVHzATk5lqXLd491hHChWqlX1ovVDfgPEuyVEzOCMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OzsOuB1j; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OzsOuB1j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPvG/jss5slfLzSQ34ANaIFdq7UUc0ujyx0bPxRD4s/EvdaMnduiHtl3klRX3jAPyIgNVhafp0zHHwMi+1rOnpoYOyUbwH5i4JnsQF8uVq82VnxNxi3UKG70qj5mk2vs5pO+T10wLbkiiW0hchDTwfuNKpz5j85jPwbNhtsgba/Y7ay9OHykTiiUwRItQJGn57zxaqSJMAU6Iwjc9GneQO2l0kHsihBhxJnw6dZhyJcCN6iaTNN3E9gaizvY3VgxhG4itVYpNw21PrIvemU1JBHltEM/egsNe3rda+EElGpAqtuUOJYHh3pVrZTVpdwwoYpgyi/TtRjH+ORLQNbG/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/Mk/X14imjPlW+ZQOtSTHpUxgAs+Fuh/BJZ0/AuM80=;
 b=zI/J5CwLn5euQ/29TaryUszNl7I40OhNtaGGc04RVTrTuOPZ6Cik4MVLsH69JZyO8lKW+hFDjyBW1b96g22w37BqIyxjLTESn1qfblKOf4HJm/U2AC1BXk9MdmGLwWpfppQVCqKFgLN0yV3vjpxWtatutvKNvHeN0v6ynxD8ODVEYKFgbrYVv2WmeOjxzHyNKAtc6otzFH7X8VvomXGBB17nOJ00bHx7UH63zo7/471vnd6HtWvvCbTweKbD4l8Dnk3fqxyDAX/LTX3JOzDRKXQUAAAszIuleGVM8LwLfhu1TBTwHzHhO6DPNcW6XATDbqhDz+gOAvEZ+Id0Vpw9cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/Mk/X14imjPlW+ZQOtSTHpUxgAs+Fuh/BJZ0/AuM80=;
 b=OzsOuB1jI9/kboT/OcnBCR/KztX0MUDMhUSUJqiub7QgfvwAlTULtCYYeKvP5+cqJpzU3keK6lHALGAM09n79bcvswUbSt658s/EYPOwy4KG+tTg3nk39QEmEzk2qKPwcq86gp9pwU7gsz1fRslGc4KaRNTyg2VTdpuQ3g7UKrXV1rCBfnmTtaYpJGH80kkCVTWofFC3l9zLIOY7g++RhcVpXnoyfBAqO+VvFnZbzUCYsWihcVkbDkrSeFG2jhj7i42N1mW9bG4HQlA8gBnHgELu6MwEk1/cehnHguZ3yvgTN1qXw3usUV783s0VLxZY75euHsrX5fIAwrZKmSAs9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AM9PR04MB7668.eurprd04.prod.outlook.com (2603:10a6:20b:2dd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:14:56 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%5]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:14:56 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH] tty: serial: fsl_lpuart: increase maximum uart_nr to 12
Date: Fri,  3 Jan 2025 15:11:54 +0800
Message-Id: <20250103071154.3070924-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: JH0PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:990:56::8) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AM9PR04MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: d43a4d5c-48ca-455c-2da7-08dd2bc65398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l3tg/omzKDo7kUiflu+YCMvmzPmLmY8A0R/RZYFEV7MZEwyFfA6DLjKuVF7Y?=
 =?us-ascii?Q?d0ZPiOaz0T8qZ9KVSJogeD5mfR82uIebg9wPxH9gTUjuhja0yeN3rMxmYPq8?=
 =?us-ascii?Q?AoRRcIIQRLKRo0w/IqHdxlvz+38jybHC/qRM9AeYnagh41/fNlKzEuVYPFPb?=
 =?us-ascii?Q?NofuWxZGTuRtG8sxhzWM0QOYnCQ+wmJ3jdE2+AeGfU8Ibr0q3kyIXf4hpgY6?=
 =?us-ascii?Q?/XEOUkDfCKefhIYRV5GhnkPDa+JV6sF2a/6DdEAhdfxjP7Vx00/2PdhLjhRW?=
 =?us-ascii?Q?ZHYddWcW5chdmDRfpdxd3S5y6sNgpilQJGTWFdyfoaiEIyTwtl/6GyKBeo82?=
 =?us-ascii?Q?a/LG0tqJlKVkxl4WusNQKinh5o24Yh5dG/OPV64BSVkMIQmj+ojRKx3AU+gt?=
 =?us-ascii?Q?5+pe/BhrUXxzHquY8nFxRnL7uB3K+daQN1H/KEkVxlLsD3xepTlNY3be/ti6?=
 =?us-ascii?Q?FkdZMPDEIQhfa7XxJxUGxExLZMUe5BjvU40qwxl6cyPoOuTBLQjBll0Bst0H?=
 =?us-ascii?Q?FsxoS2Klt3IYi88M+nHDYjiusLMIg99UWUD4NLFApSTpgfvi9emE8qrN55K0?=
 =?us-ascii?Q?o6gUYLJT7SrUhhWCs75KQLLluE2k31am60grYC6terDZ+LoHaFtcZ23Zmq3D?=
 =?us-ascii?Q?C22wbdwdLlofI6TNrmH67f4OCYaNZD2QKtscSxiohDgL3VFTPv7L4F3d2me2?=
 =?us-ascii?Q?E62yOQege35/cu2SJCu1IiLcTqVtEej8h3WeJZodDD57Et+xY247lH3X1yJ6?=
 =?us-ascii?Q?ZoEXQLju4eiuvN0zBg3YAuiNvaCXLTaUPCvY/bFWoPEPRfv65WYIZe5Q4odp?=
 =?us-ascii?Q?+eoON6h1dQ3vbMKcZbUpEQlPKwA97pg43QOe4KkP8frVtWYIcdgX5sm/loaM?=
 =?us-ascii?Q?L2OhHJwoWlYg4d7OGtjSreDW3GyTxIzBp+rOGL/xQj3nvU1rOSL0IqBCHegH?=
 =?us-ascii?Q?WDWoEA92XLmwvjqDwl4fv0pVJaA7kYUTMm+3BtQulq5eTYeauOLpVjQ+6bVv?=
 =?us-ascii?Q?1+4pC5ChFk6zBgNGTYJDWIHS/SHJeyuNuxtgacudh5vOpiJaab0G4N3qvmPD?=
 =?us-ascii?Q?BPNYzZ7gHy1Fa27vzwLPA6yUMwEoIKRj2k3jvg49XaS9bNVMBMudRSvdpA5p?=
 =?us-ascii?Q?oeIxyPnQxsF2GBLsmnKw/H2wRV/9iupObkeoCXnzJtyAoQ/crunz9KuMkvCO?=
 =?us-ascii?Q?C+0Pu+2VZXJScCKmXThQ0zQ6/O5B/uZUP8vKPZB2HI8KXZo7cU96wFegC24g?=
 =?us-ascii?Q?8EFhY1g/tgTbARkFsDkxiNTpon+/gnI9UVy32pa10RQ+66z/+ZdvKLkQDtRQ?=
 =?us-ascii?Q?gBjlibDkjkP+/fZivZGU5XJK8/QOPW5/r6KEwExNUEgZKeB8ltTcDUYmQnvu?=
 =?us-ascii?Q?QbuCBQlD5ctyZo6lsIP74R/zcuLrr1YrEbs9eHs0sb4x1mkiPcx8nPDgN7jg?=
 =?us-ascii?Q?c1vpmFyRHKytz3J1a+3+NwWN7RNJW87a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hQm9sve18nUSdP+s0oj6doNLC+PrSUV39nDTPGXqq//ipjPE2TMESIAX6gDB?=
 =?us-ascii?Q?EvFnpDYBs8PtEe0NeZEyYkX9FrCpge5J0zuQL6im4yDqfjk2Ev9m7xuz2XlB?=
 =?us-ascii?Q?iUQzDlTw+ROo9/0RpLc4mQGIOF9MAYJ2sIuzeGTmRrS0dyQbqct2PHoHONv6?=
 =?us-ascii?Q?eOrc4U8LSfZ9T4f5uSZJCty+a1F8bjGYSM93ZLVyajXZR9RxS5NrbQ5ROQnn?=
 =?us-ascii?Q?uUGQ8VMg7ggVTiPwSM3fbH0bPUFI6JCHEt2CKj9J+GkTWdCTxsorWG55AlbI?=
 =?us-ascii?Q?iNy+Hv/anQIq6p1/9bYZLQnJdJZLiiFMiazxa5lPnyX4Q1eqrCZ9WIKTI7MK?=
 =?us-ascii?Q?qf12HIT4ybYjVZQSugq/Ea9PTnDpWabjZ5gwp7IlsoP94ubLekXr8Dupaf9c?=
 =?us-ascii?Q?o+HrOxrrbKqeg+tC7CeUKbGv1gH6up7fqJKoVWkA3Uqk4irZoAmaux3cpoaw?=
 =?us-ascii?Q?cOTDQ/BB7T6d62oKtAbXW/k9+U7Sk+H9kk81lXofvI9z4Cc3red/qjOvjPBD?=
 =?us-ascii?Q?FOBOCg1RbgSJo5rjXZ6us8QWSbRK2IB9n21QT0WYgKbdfhwrKoR1OOn7foh0?=
 =?us-ascii?Q?kS3VAp26fXISh/IQf3zN8F0zg7nVmSOp9aeQ97Ok6kIGFreHAAO9Oi5LidFV?=
 =?us-ascii?Q?F1pPgm60bH9s8VJ35ywtp3B9XrZaAC+6eNIm4qx9KvwXd8ZAUdEKdGL/CY61?=
 =?us-ascii?Q?f0uLXHK+AkveA81TdfBxd1o1bTyJAh+qDM1Jmau+1NOtENAcfORCX6iJlwm8?=
 =?us-ascii?Q?HHF/yE78vxCYPXKBldPI7fVSQx3IZvxlmicXfNJ3GUr3GY4muvEx7yTFkRgm?=
 =?us-ascii?Q?yvXz2/YEsiKUOTQq4mG6VMpZuqgsgUTLIj/Hn69PwXqLYjYQAOBSinRHZ3Fz?=
 =?us-ascii?Q?E/TVNWg+3MRStzlarxtDWl+4W0+f9yen7jSBA6xWDHj0hEtsJq514rJvigCQ?=
 =?us-ascii?Q?15ftQyzehYf/qr6Aok+qP/jdpB9XWUGXfg4qHKw6pevQgDPOSrwVQ6DhM/Dt?=
 =?us-ascii?Q?CjWS2QqfbufJquVEZLL8GTw5tbwxpbGOy6XDFjvQqEMmZbqgb36bCQmAO6gs?=
 =?us-ascii?Q?35JxLPLVwpy5DkVZxTlU5dObcq8jQbRHBDJsR2Uphp/dpw/BHhNxKz4t4MHm?=
 =?us-ascii?Q?IgdHlQj5rPpL48MjAx9Z2rmMaSKeMpCh1iSFBU3Il3jjGjZKMTJ4mvvcaSIL?=
 =?us-ascii?Q?/EFB3dr+uFIRg6fYAooSnF38110navVyPPSCIMCk0Tf6eW6D7t8aa7efWCTU?=
 =?us-ascii?Q?CJaV9voZDms7mUxfnGiMetUQswbaQkKEwdQw217q43kwRf06+P7dTRhVvzO2?=
 =?us-ascii?Q?WswtSLTvaB3O6fatGVngU/9J5rj+dH5gcBB06HxvLQgGkdNO0j8R/BkPtf7T?=
 =?us-ascii?Q?gxWhKIQ2cK1bFYLq4nHUFeXQK89/zfsnStq+1YqOZFDr22kiZ0A12FhN4pW6?=
 =?us-ascii?Q?O/YuEvpFeehJDgLRmDp0/hJRrg6LAzmlbNkF0Z6mlMvscajsj9K0HgziIiVk?=
 =?us-ascii?Q?HRFqsrUCLk3dWzAdrx6pLQMead8/YjRHFTMR+6qox3qKWTvP8NeZR2HykFkR?=
 =?us-ascii?Q?cI4CaG4s5/aAkrLfaUCg/meSZVM3LcwzYk+gS695?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43a4d5c-48ca-455c-2da7-08dd2bc65398
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:14:56.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9eeDZXyK09bqYyaMNyDgdk6fg52Feyg7VzROt15CbexuWX8e96sv6t37Fi0G52SWSjQGgjhP8IiZNMjgoSezQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7668

Some SoCs like the i.MX943 have aliases for up to 12 UARTs, need to
increase UART_NR from 8 to 12 to support lpuart9-12 to avoid
initialization failures.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 57b0632a3db6..7cb1e36fdaab 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -245,7 +245,7 @@
 
 #define DRIVER_NAME	"fsl-lpuart"
 #define DEV_NAME	"ttyLP"
-#define UART_NR		8
+#define UART_NR		12
 
 /* IMX lpuart has four extra unused regs located at the beginning */
 #define IMX_REG_OFF	0x10
-- 
2.34.1

