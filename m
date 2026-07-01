Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012022.outbound.protection.outlook.com [40.107.75.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB42368D62;
	Wed,  1 Jul 2026 03:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782877426; cv=fail; b=tBNezuRBGOOpAcW7pKmE/SXVFuw5X7sb26ZoxF9mh1OsrhsHWXnHkF8L/knYNrexhP067zyI+b35dZc29Ddn7f5GSHVo/3Ga96S+YMHPfXtg5oodHr/25ll3Yz/SR4SqzNjQRs3/H9xQOobZIsQxg+FKTIQOC8jaqKzRDfzgqwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782877426; c=relaxed/simple;
	bh=m3ATS/x9Z5vMo6XBuX8dFwAYYQs8GzLZd6UJNlIkz+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oU3Eo1k3PLzuAM4UGO+TYwFLLxihTiWbf0f9BxPC6o/3eILerW8CP67YLZevM61pyAZy7z73Z1XQb3ypyzXZnsQV8MtnEnGdbP1ouFOlweO/6HY7iDTVynkiJRk9/+WMvuYoQo9y5J3+cAFMz/xhWHSq25YMUsesECNGfw8dydY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com; spf=pass smtp.mailfrom=moxa.com; dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b=hnsM2gTC; arc=fail smtp.client-ip=40.107.75.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=moxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moxa.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=moxa.com header.i=@moxa.com header.b="hnsM2gTC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGSqT2T9CcorIilpVVhn8+coEASPexZiuTam//UEd7rs77J2sfxB7yWQJmiQEGwx2P6LKYnOeFnWlpnOr4x0V9As8k0WcN2uES64tqk6jv6UuCCayGC9DvTwAIu0YBxn3969jRKb6GK00CF3ioWvm5kE+Y4FsZwEz16RmbKAcoQBTgi2zYIim/np7G0UOLTjXwY3/wK4qz8JEVoRP8dOn0vgsH2hykWPU1s43zvqvy779lHM1lJ7u9CbpZJsI6tUE2j3hauhxgogQ7f8umb81ZFmTnm/+zxLUs2T7sIRB674YXABlkP2Ist+Cz78Guh9QzYBVZhVW+/U02yReGhU4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IU/sBmrlscrGTopEH13k7qrfGgDFgoNJaHPqWeoZxk0=;
 b=WRr2k9d/FEfdVh6BzNv4vRH++wj6z8lCvZ2+BAidhCOZETHhCh6XljBekEtB5evqW0CwlJbGMprDvkiAt2JAdFVB0m9JsnIfA+AA73SHi+Dvae6wtL9mtBG0rCC8pd84fCF8rwZwkYvjcrViJR22OOXiSYXjTx2emM36Ec8uDGy4bx+S2CzK+PA0LFAbRt0r8KWW3VVoJlx3GCwLxQVyRu3NjqbA8tld9cxrxk4xUOZlg5voTAxu7lMc4lzRn8DuAlFx0wINM7XLUBRW6DmBZxHffw3NK7pVbbjfZpW9rmVFncLFXKbuIY1d5z0UXUBq0nCUzEa0PBZ2hhMOCzTtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IU/sBmrlscrGTopEH13k7qrfGgDFgoNJaHPqWeoZxk0=;
 b=hnsM2gTCNcdO0pNy1kNZltC8/Xy5iyCJpjz+Tlpw/FmlLMzbF7w5ACSnRErZh5ozJqGrW5TAOVT09s1juXOkyiERmSW0bv9jYvl4MyDOlnBoHsLsBcKKH2Kizuu/GcgfC2svyPiiemcFaecRev9pV9EvAx35IClvOaMEHwKgzJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KUXPR01MB8048.apcprd01.prod.exchangelabs.com
 (2603:1096:d10:7f::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 03:43:42 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::ae38:e821:cf7d:3717%4]) with mapi id 15.21.0181.008; Wed, 1 Jul 2026
 03:43:42 +0000
From: Crescent Hsieh <crescentcy.hsieh@moxa.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	FangpingFP.Cheng@moxa.com,
	Epson.Chiang@moxa.com,
	Crescent Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2 03/15] serial: 8250_mxpcie: enable enhanced mode and program FIFO trigger levels
Date: Wed,  1 Jul 2026 11:41:16 +0800
Message-ID: <20260701034128.218569-4-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
References: <20260701034128.218569-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:8::14) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KUXPR01MB8048:EE_
X-MS-Office365-Filtering-Correlation-Id: 72e0bfbd-06b9-447d-7f5d-08ded722f214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|3023799007|6133799003|56012099006|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FY0teFpjZCV5P/HOREAzvUjPQClesK/k7oVYayWtbl/acWVuU45D44NMVYgufn77jBH6RVZHYr3jrH2ZaTy37mxZmEgscjbqJKw5FL7Ezsq0gLDvLcrrvDsTUg3/UHsuCVX279ivheMbTomhmflQDH2r1kOV0SZizCPx9tBorTlkDZtsdz2AGQ81d7BxDsCPKCUs5XOMomY6zyglttahiSi0Rd+TiepKwbpJN2fanH/eiWTe5TGAik0L3THoAorPCGdYe6c/y0Uux9+jWn28fRsfe9kWssLc9ZU+qyfopCXmoMIyljP3/2KwWir4O/+1V/0CJiEuOfYIfea8bVVox5aSV7O4YzqembdHm950tOzmmPU5zG/ATD7kWB/WdVwT8VKohiHiOE2oWkWFuSAw5sjFrpmRTDQzZnvGgVq7hZXgLSGs1nXWmialtrrCvkdddrzE1DRQPo13g6OX6WwnDHdCPUcRiQ2vhmbncKq/kNq8QUIQIW20IM1JR7KpIqEO1XJV9H/V2AVLG+jqJJVH4zzZya5K6cKQdKEa5oqTiGrSOf6ipU+FZAEXBiu9aF4Z4kpg4Us+UVZV79WzVS5zZuvFQAhX3jLM2ARA150KNOKccFQ+0oY9shh2X8jqxezfh+kr/5BVq5WGWeh+Ehb//aE4TR5R+KB09YvPVyZirbzrARrrqYvOpV88XCXqTwKpEU1mFJVu6yjZiIPkwmNdLtdoJOtCVEbpnBe6yAoj2UA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(3023799007)(6133799003)(56012099006)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mp5fS5S5KRRE8JJSOppPSEtp7oGt7kfLeybFoRIFuqI4dYxRIk8rLCtyeIXj?=
 =?us-ascii?Q?hcexlCwl9sCAdSpTPM1ntI3fXms7o6/J9/MVO6N805Ew+1TU1KF0LVvr8S2c?=
 =?us-ascii?Q?J0PrvbdABexirmz0mR1OX/prXCnlKCGNfEDvmiz/bL9Q/qgm9odUdLCaar8d?=
 =?us-ascii?Q?GVqG6LOKrMQdRX/vF2znWvhte3LahS5mYHsmLog2MaUB5BVDYSMiI0u5ICtM?=
 =?us-ascii?Q?7iJWBKtpMlnljxVtHMYfP45Pps2hO3QMu5oE2Q+mRWWNYpfvENoUmMWg0fa1?=
 =?us-ascii?Q?yVi2TMLoBya5efNOJGVgzW+WaArCwXvaAV6lruwcsMnNfZgunq1Yw7QToUw4?=
 =?us-ascii?Q?BBXgPbm4M09l8KY0sU+faePixQcdyzWKtFYAQHjZ80PX/hfh1x1tTIx8rku0?=
 =?us-ascii?Q?fy7BlXEeZ4LV0FZHEat1somDZxi8pw7lIa7SJtUOgDH1iXRhM3v94RqhRZze?=
 =?us-ascii?Q?sVDoqa/2VhhJXF7+ElysfYAaZCA2oS1EcWjx+lg/KfIkMBYgeBKOlAQjO8Ni?=
 =?us-ascii?Q?5aP2/BJuLlx1049VIdOQszJ0FFwtkwakU4nB/x/HV6Krcx4gFyJQEJKX63d3?=
 =?us-ascii?Q?aaCtOGwSb4EFSNYz0o5hp8zUcCfGVpnAseowAT47ml6S+zaqD0+OtV2IcIz0?=
 =?us-ascii?Q?qetlDs0PuDTN+1kHMs3MOdR6hpoiTdydsbh9B0a6idPdsb3ch9+rl+KShcJq?=
 =?us-ascii?Q?YND9+nudl+qXj0JxASNqIwzrDN/hwVzSfhslk7L/22sw9kj5QktS/01wfiz+?=
 =?us-ascii?Q?9XliN09W2KUJgoAYef/xgL/D+IImSxYGOmFNf4hYY0wHCEQUn+KLvEHcb5u6?=
 =?us-ascii?Q?7lft8Xf/Mp4CI+8cacGr11humatII8KVlyK9EtcIi8Bnt2L1zTsF3KA825Uh?=
 =?us-ascii?Q?qUfFi5i4xaQCSmgJy5LW9xdX164TTjYYQPrKhFxpBftezrsxpOYvuCaBsnWD?=
 =?us-ascii?Q?C1ZEeRd0oWviTtLvHcDfOxleJVwOmJlAA79FmdNdLz6AFFlNc7XzMG1Bc0H/?=
 =?us-ascii?Q?+zWcBoENHb5uHjcP6tXI1/joyaw6bg+AajGzazlfQ9Ebz0EQdP+T6ik/Nios?=
 =?us-ascii?Q?ORF4Z5s1gXttlR/4rpncQffSBf4tPuSuRRsbSrkjvlbBtLsVQMQqRhnz1iOj?=
 =?us-ascii?Q?bmzOQcfTmFnY4shrB+Xae5EjPVH/WpOufZ4ieaKVeclen/J4p16qyX3YR8Xu?=
 =?us-ascii?Q?ckdZdLYVwcxkBMbcLx20jM5tS9gMjRDQ/dLA+Wz8B3moQAkrCYIAP+8+JDJW?=
 =?us-ascii?Q?9Lrh+F0qjRG/aZydOaiibs/jyyc/2IqPygxK1NBUxJUrCuojH+u8eH1k1CGo?=
 =?us-ascii?Q?H9CaGbh8W64sei0SXNHf0/+0ofW/JWLA8KMjjeXJf5ari9P66II8DZStUyA0?=
 =?us-ascii?Q?wby1E7q9DzCPRf7ZQdM2kT/ES1t/SW2XtKo81NZURqLn9lkjLfnbpkDgeZNI?=
 =?us-ascii?Q?74s1LFWOwtr2AInS+I9YTvYmZT+NMPngAd72XoPnjCoKWpVPx2lRWxpVZ6/9?=
 =?us-ascii?Q?hXdg6B6NKdvK7piyzas8FJZfNrwnaPbY6d/64kw2ie9/w2LpF78svZX+MLET?=
 =?us-ascii?Q?bmNwXstq1aSKpULRsxZDU9zglkj9osu1ETGKgVfAKpKzJHk4M059sTF3LPfK?=
 =?us-ascii?Q?1ebdOfFa0h2wDSAFg/BN2t3qhKR+z7MQ9BBH8rZQWAuNFRQsZh+IBAO/tYQ3?=
 =?us-ascii?Q?0adBlnubkBg7pdufkv5nOsM6By5Sc3sojIxaKemorOn8/ySnszgyNjCClSH0?=
 =?us-ascii?Q?BbyoNXpODLbTtUHK4ousnc9Ytba1WcI=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72e0bfbd-06b9-447d-7f5d-08ded722f214
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 03:43:42.5320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0jfl7bEg/bhLKFmaUHP5xO5eQj24r7SmZNUAk0CpAGcHxryXMCLwYDn0oUD/8d3RGotx7khlsR6omOnF4NdEkfjVMB7eYQq1Jg3M6sPo8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUXPR01MB8048

The MUEx50 UART provides an enhanced register set and programmable FIFO
trigger levels for RX, TX, and flow control.

Enable enhanced mode during port startup and program the MUEx50 FIFO
trigger registers according to the configured port settings. Clear the
programmed state again during shutdown to restore the default UART
configuration.

The TX FIFO write pointer and read pointer are driven by different
clocks. Clear the FIFOs repeatedly during startup so both pointers are
reset before programming the trigger levels.

Signed-off-by: Crescent Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/8250/8250_mxpcie.c | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_mxpcie.c b/drivers/tty/serial/8250/8250_mxpcie.c
index c82d3149a03d..c1fc5eba0c58 100644
--- a/drivers/tty/serial/8250/8250_mxpcie.c
+++ b/drivers/tty/serial/8250/8250_mxpcie.c
@@ -48,6 +48,19 @@
 #define MOXA_PUART_BASE_BAUD	921600
 #define MOXA_PUART_OFFSET	0x200
 
+/* Special Function Register (SFR) */
+#define MOXA_PUART_SFR		0x07
+#define MOXA_PUART_SFR_950	BIT(5)
+
+/* Enhanced Function Register (EFR) */
+#define MOXA_PUART_EFR			0x0A
+#define MOXA_PUART_EFR_ENHANCED		BIT(4)
+
+#define MOXA_PUART_TTL		0x10	/* Tx Interrupt Trigger Level */
+#define MOXA_PUART_RTL		0x11	/* Rx Interrupt Trigger Level */
+#define MOXA_PUART_FCL		0x12	/* Flow Control Low Trigger Level */
+#define MOXA_PUART_FCH		0x13	/* Flow Control High Trigger Level */
+
 #define MOXA_GPIO_DIRECTION	0x09
 #define MOXA_GPIO_OUTPUT	0x0A
 
@@ -132,6 +145,49 @@ static void mxpcie8250_set_interface(struct mxpcie8250 *priv,
 	iowrite8(cval, uir_addr);
 }
 
+static int mxpcie8250_startup(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+	int ret;
+
+	ret = serial8250_do_startup(port);
+	if (ret)
+		return ret;
+
+	/*
+	 * The TX FIFO write pointer (w_ptr) and read pointer (r_ptr)
+	 * are driven by different clocks: w_ptr uses the PCIe clock
+	 * and r_ptr uses the UART clock. When TX FIFO flush is requested,
+	 * w_ptr may be cleared before r_ptr, so the UART can still observe
+	 * pending TX data.
+	 *
+	 * It is recommended to clear the FIFOs at least 5 times to ensure
+	 * both pointers are reset.
+	 */
+	for (unsigned int i = 0; i < 5; ++i)
+		serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
+
+	serial_out(up, MOXA_PUART_EFR, MOXA_PUART_EFR_ENHANCED);
+	serial_out(up, MOXA_PUART_SFR, MOXA_PUART_SFR_950);
+
+	serial_out(up, MOXA_PUART_TTL, 0);
+	serial_out(up, MOXA_PUART_RTL, 96);
+	serial_out(up, MOXA_PUART_FCL, 16);
+	serial_out(up, MOXA_PUART_FCH, 110);
+
+	return 0;
+}
+
+static void mxpcie8250_shutdown(struct uart_port *port)
+{
+	struct uart_8250_port *up = up_to_u8250p(port);
+
+	serial_out(up, MOXA_PUART_EFR, 0);
+	serial_out(up, MOXA_PUART_SFR, 0);
+
+	serial8250_do_shutdown(port);
+}
+
 static void mxpcie8250_init_board(struct pci_dev *pdev, struct mxpcie8250 *priv)
 {
 	void __iomem *bar2_base = priv->bar2_base;
@@ -226,6 +282,9 @@ static int mxpcie8250_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	up.port.iobase = 0;
 	up.port.regshift = 0;
 
+	up.port.startup = mxpcie8250_startup;
+	up.port.shutdown = mxpcie8250_shutdown;
+
 	for (unsigned int i = 0; i < num_ports; i++) {
 		mxpcie8250_setup_port(pdev, priv, &up, i);
 
-- 
2.45.2

