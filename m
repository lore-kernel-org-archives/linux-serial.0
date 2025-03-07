Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2082.outbound.protection.outlook.com [40.107.103.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5019322A;
	Fri,  7 Mar 2025 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741314002; cv=fail; b=CWI5hM425ho/AlgyTUlx21osQ1xTTYLDmjyE5X9CQbuzOeN6n4SRRTy1WzFccO7js9CTBVP/goHPjr4yeMofrzg1wKJQju3Qi4yl+eLDhFQ+/EAEwbmtMCN8tHGvT+8JAVkItPIXK+ZBuEf29rMS0D9N3T3zpAvmvbwqVokWZJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741314002; c=relaxed/simple;
	bh=VVBoAOSUjZIqgIgWlLTUPBS6rdWcfyZguOsr1BJBMOY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WRFmmFk2JAcm2bbSJzhN5C5gSmYt4hJGHMujIx7emkv/IaLsNl7YyJPTJVGTubWIHLWfFuubgM/Aiulqsfd1OjaRreXm0iw7GnJaS6K+iZWaKDU88mwVcJ+9S604Rd3YmE0bJSeVjXijpVSU+bAKUcxc09BBZXGYTUZPHwQmsaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OGjmlmGt; arc=fail smtp.client-ip=40.107.103.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OGjmlmGt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+QwkGs4TwSqI8KPhWfNJ2mYBFkMWXE6+YHr5ZoBtJpcTMf+S6kmk5JlrbTNn3t4gtIhNGULuqF0BXlgIosDP1hSHgPdgoO+i8u3lwNPxa9a2FLMb69O/fdNCL9dMOVZR7nP0aMMONjIhIacum18wqQge42y6B5snFHfRg20pS96em/Kd3djQTAadBETKnIozM9BFdrIWxNrg667vRD3b3k5cBCD7L26Hlm+GtmTSfKnJ+AOP8ncjLOV8wzbIiB91F9hup7VSTVZKZCX1M0k5gr0oMgsUAjnbR6y1WOIiAHtc21S4i2e4y1NWezYHVF7iKic1tR33fLJb4/YA07//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5YXBTakjW/2AO+m3/0Y3QYWANEVcwtLdmxNNwxvNWg=;
 b=PGNxGz2LiX5r+JtEfUZQ1h8PG4PwPeQdqIue7AZDqb25gK3glCxbhqXpI3BhKyGb42PJrdS/ln7U0nP6AfGHGxn/vfZwSL24VxFn0HIXX6+cHs6J56URjg1LCjQ/AIA6rnTd3JpVDgqV8lIQu1/FKIz12RTWku5CfGOBu0NfwXAN4yapkbJZc13+bRfKH3/2IXFi4cCVAT1J/dBRWNfnU/p4IBAzkvk5AHUOMEKbCxAsK2Q/bO+E5c+UvNNg1ewajVHPqWyEuZi/qQT5rnLc1T9v4UsbDhAbDBqHAKCdGTkJTyOF/Hs7Vcb2AdahPJN2prhEe9YL/XkJzOkJmh/igQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G5YXBTakjW/2AO+m3/0Y3QYWANEVcwtLdmxNNwxvNWg=;
 b=OGjmlmGtHaExV1wL2V1Vefcq4TeG5BYEeRIkVtDIM97eWct/OdGqxSpKk2slG7eyDze7uUEeJB3WkMbmaBX79hfBnr8EojyiRRb+EVInXc29Wha2/K707f7DoEPbiYd6EjnPUaSmpCJjnPEXMnsrERp51LPv98VXpHt0wCB6PDjyBJq0G9ED0K5UbBfNRAdBgrBt08/kgZCMalk3VfG2juhgucHidHTkpzuvzaVol36oqmNt7O6O5rS09A6utyDLu7ENnW5AJR5DgO9B19AGiFLCIYxEGwt0eYtWP4r8t28vzBCDC7z7uX9x0NOrVgM1x4AJs2HsQLwOO6ejz+5GCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by PA1PR04MB10628.eurprd04.prod.outlook.com (2603:10a6:102:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 02:19:56 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 02:19:56 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: disable transmitter before changing RS485 related registers
Date: Fri,  7 Mar 2025 10:19:50 +0800
Message-Id: <20250307021950.1000221-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0094.apcprd02.prod.outlook.com
 (2603:1096:4:90::34) To DB9PR04MB8429.eurprd04.prod.outlook.com
 (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|PA1PR04MB10628:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f99fa96-aee2-43c1-48bd-08dd5d1e8d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0tej79iWLCH1o2/TO0UassbwboYmEoGPTOGQ8AueuXzYiK8lDdglSKdigWpf?=
 =?us-ascii?Q?UMkwfw31bR3jzRNfe7O5d8rJ2t6CmnPX5rvWAkpa8G5u0/BsZlvpXdOR3UHX?=
 =?us-ascii?Q?hEq+C48ZMIepuygf+pHDgUtipva2Pz8L4k1A58LBDZDuGAx3soDH2LlMUVRB?=
 =?us-ascii?Q?vBG6j3mEI1SUCbD2U3oHIT2/hix/W8Rk0aTC4VdweqjWk++nOOR45cvLUBHp?=
 =?us-ascii?Q?AjwT3ci9TWKbWqVoxQeZ7qQebz0C5X5v4Bs/ivlQWgbkfUXjGm3udrdGpDI6?=
 =?us-ascii?Q?GiWxzATwz/a7uToGcPsB3/Le0XCO3LG4H9+OVG6cNyXxax9ILW1RRGza0ogt?=
 =?us-ascii?Q?WRuVKDb1AdYLiKyN8s7hSq9L8ru8ZmZ2KHA2VcXSeuZfFj5wWVCorLeuShXk?=
 =?us-ascii?Q?23Ak7xQ1QdvW2w7AE2FKJrHdF5lsZPobEvVnnD0QehX9pAI0qmdFOKH/sJfc?=
 =?us-ascii?Q?fE1rPs2690+iyZyvctiI1RyL5/BV2fBfGQW8onzwWbS6J6ExDlF2c4TmdGZO?=
 =?us-ascii?Q?ypdHBHUUsuIr0NfrN4XKhsKKIcb4lmqX7VtZqELkNauCKxpzzeVXKJiTo+9u?=
 =?us-ascii?Q?kcFO0s0vNKn0RqR7zLGzvsFogrP97f6ESEwekcRbDyszOUOqyfDbPgCby+y1?=
 =?us-ascii?Q?Zy1CLWY8N6QfeeCURMlEygUoU3ST/oCwslsY3Bv7WGmV6i1/E13xNPeJU07L?=
 =?us-ascii?Q?n8jq9a/HhHF1K5h+H/nVqSldM8JpggyeUOUjUSG4o/EWQ3k9bmXpova6Un8d?=
 =?us-ascii?Q?9Ik5udc3JccJ6gxMHuixyNgFKWGofNP9h8obdZKqyjdbcDO5dGw/fMvqw9QV?=
 =?us-ascii?Q?NBtyzjhtFUuOpirItK1hIqBYSEXaPxMI0oNLxpgoRyhtYQFPnGLRoIMfs5z9?=
 =?us-ascii?Q?ODlCHm0IgTxaMlCceIy1PcklteKN/7A7C9EiV3lJ6U8t0HttuNpxnl+kglC/?=
 =?us-ascii?Q?2fzxIdc2MSpRNMts29DM1Lrksrd1c5GTGq+zkY1djpRjTrIAB5JMFO1QcGL4?=
 =?us-ascii?Q?k1JXnQxxbvAfgaTcaH+7cD9Hn/qLqMBokr418VcDG7ozlWUyRrsS05NH5OAI?=
 =?us-ascii?Q?yXJFBf5Jr6l078bILqte5O+iboLImnBQWwdeLARvwut/TwwLNddGqQ9ScfW+?=
 =?us-ascii?Q?YBk4ek4y8YVrnjREPgm40LxeV34RoQZpfF3IwZnQUvodmc3SmHOW4pI3N9zC?=
 =?us-ascii?Q?OWvw4IXUs3z7+lYSpStLE2UW2peqz8aqfbQSsaKzDrvCq5+oIFIF8GoX1qq7?=
 =?us-ascii?Q?ghrNdGXfpV14UWT9BmiSuvl3t1OcQK+0b2RrNSi4qEbYRSCVUS+3FIu/gp5I?=
 =?us-ascii?Q?mzmNXMQpv7G6iIg1eFO3lwC0CTPmvwy8ICXd0BMCxhOK4/fPbk08l9jJiwOa?=
 =?us-ascii?Q?36FMGDYECeCSRhnlxci52tLpvDJtyUKz9QJCHmL6nl0LxakuHjZF0u/54MhC?=
 =?us-ascii?Q?rS9jp/1i+CTHihK8wh5hrWNar2DLqNd5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZXj9zW6u4tAWLkese/Xa3Bq98IN9gw+3trwkn0uFqPnn61WwhPhe8i2M1+al?=
 =?us-ascii?Q?47HyD5fWImqS5c47uAw/2XxNT3uYwDdpjybklNCTdb5jd1muhQ6iOmFEPFYZ?=
 =?us-ascii?Q?tPOYhQTiD8ynAChluPqU9asjSFk+iMYzwNp4iVXc7ghw6XYTWtZPECVC5Il0?=
 =?us-ascii?Q?c/i+36CCAkm+iA1DkeC9hX2AvllUV+wUur6A6x9fl6o/Svs6HQaasKSubj0K?=
 =?us-ascii?Q?xzBxzgY1/ciNFjQUVSxRddpKOtB4xtOyrKOW3sp4ODiu5dAz0SohRPWsNNra?=
 =?us-ascii?Q?HgxTKI6VvUmJgMi4iZCebkQgl4qRiD+OcQUJ7av3Ds5KBryasz+N8VmUf96w?=
 =?us-ascii?Q?+Y+9c9TAy5ibEyPUXv6L4ONrsPA7vqqx3c/zUxEAK/ubBYiWYBdJODO07GBL?=
 =?us-ascii?Q?olOSscBeVLJVe42itQgW5TdADsQ5qISCapCAec12VOtg5de+3fRwK78hm5vB?=
 =?us-ascii?Q?P/SyWZffVfqH1vZFRX2+hzjZ/QgFXG1rOMarJM9jFofDKy/m1OkU6WuFQ//h?=
 =?us-ascii?Q?8iP+3PIPWregqYVWqQL4akAcC4dj9Y2ht0bBS6XDVAvEG7bAHxZGFiFdKBrH?=
 =?us-ascii?Q?xoajPDwAFmUYyAg/5r7b0hXbzpby5e/Wz6d5jo4V+ihcTpKHmFgkugfIy54s?=
 =?us-ascii?Q?SEHNUgCHre2OyMFoHeLX5vsvtnJhGLUmG8CATm7ndgHgRMCit3hBzHxpmOhR?=
 =?us-ascii?Q?aWgOucZ5myFOcl5tV2SMhfFjCVb6Q6i2rcYwUjq3+fjfaQL3usMLT82JYaWw?=
 =?us-ascii?Q?33NIZ2U7d7XmavA+X4khRKGBTnJbpakcDgX+Xyng9sQzcpqFElajhpZcKm8D?=
 =?us-ascii?Q?MbEofuueOSVMUeXaWC/N3tVbk2iqhxTr2MTk2KcMZacOqvX1BwfGbfDVjj/0?=
 =?us-ascii?Q?XPW/ZIjsCvgVUJDPOz1UIPm9J2yKFyHYpWHAP+FQtX/UVTBnqx6oFPmJ8t+a?=
 =?us-ascii?Q?//sQH1jrTScfKQXX/4SUY+sRUBYrIhFE09rRhvePAUMb9wliYZQ5aeFQh6nw?=
 =?us-ascii?Q?6/bxjusIVPuXePHfKu2/9O5qBj3Ru54yJwiVEZQjrxoVeSurl0wGu0gfQevr?=
 =?us-ascii?Q?aJx8IIHAdfUURIoYTm3Y0Sc0K1jU0fTxiFZG+bSNXwcrjTZwxxn5THqkdCzZ?=
 =?us-ascii?Q?TUYG3KdL1lhXHapGqb1/5/x5On1RnJtTR3BHGl5EwNCh5RU4hs7D7+Go5zOp?=
 =?us-ascii?Q?JS0PuBptMaY6wncda95MQDNa3FMBWBd+12iZsyfnTVp1j4KRW77qJcYRN3D/?=
 =?us-ascii?Q?c5/YarbxOyro/PJVWbaKq+rctXn1nvgFiM2J+nLujBRohtyqJMtjbw7rdstD?=
 =?us-ascii?Q?An+D9vrinnWAo73g1TfLPCxWg2ZO37lM/yKybXYQTqbLzUYw7Q8xFj0sYpgl?=
 =?us-ascii?Q?gb4aNhbUsNYkpkOPVpLimdYbxN3gJAZPenYeKJ1GTBCClWJ6ietrKdqCrt1Z?=
 =?us-ascii?Q?/miFg2atd+0K2NutTxh99/HkU5dUuL7bfXaUEVeLqOn4xn4fKgu3ZglmecE6?=
 =?us-ascii?Q?f0IIsDEfMUDe9fapP+vCHRQVf5SJ0nkOpPBKCyeXoliZhtA4gu4PLJLsd0CY?=
 =?us-ascii?Q?nn815oou7KDkN303eaF5Lv+wPRJtXlBilMeriM8h?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f99fa96-aee2-43c1-48bd-08dd5d1e8d3f
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 02:19:55.9555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkYEdyb+2IHB+pQVVKXZj4LCrB0VA2FjQOm5nQeOAHwJZUXcPca4QBNc5CYw+i+5xgHt9jaPygUIaMgQBOf8OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10628

According to the LPUART reference manual, TXRTSE and TXRTSPOL of MODIR
register only can be changed when the transmitter is disabled.
So disable the transmitter before changing RS485 related registers and
re-enable it after the change is done.

Fixes: 67b01837861c ("tty: serial: lpuart: Add RS485 support for 32-bit uart flavour")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 91d02c55c470..4dc2f3e2b8e0 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1484,6 +1484,16 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
 
 	unsigned long modem = lpuart32_read(&sport->port, UARTMODIR)
 				& ~(UARTMODIR_TXRTSPOL | UARTMODIR_TXRTSE);
+	u32 ctrl;
+
+	/* TXRTSE and TXRTSPOL only can be changed when transmitter is disabled. */
+	ctrl = lpuart32_read(&sport->port, UARTCTRL);
+	if (ctrl & UARTCTRL_TE) {
+		/* wait transmit engin complete */
+		lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
+		lpuart32_write(&sport->port, ctrl & ~UARTCTRL_TE, UARTCTRL);
+	}
+
 	lpuart32_write(&sport->port, modem, UARTMODIR);
 
 	if (rs485->flags & SER_RS485_ENABLED) {
@@ -1503,6 +1513,10 @@ static int lpuart32_config_rs485(struct uart_port *port, struct ktermios *termio
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

