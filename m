Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2089.outbound.protection.outlook.com [40.107.21.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D58819FA93;
	Fri,  7 Mar 2025 06:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741330503; cv=fail; b=e8Wx0Uh5NT28YOCVI8DF//mfY8Vzw0iU/xjt2OQJaUVoV49xtwObNGvHy1vr7SMvTAhQbBzw+F9dzx9N2VwmcJIjPnXGj1bETfOqjQIiQrHVLrpfhLYNoeKcltc9VAxKIOZ+SkrAUmQvvoYhr3NvtcybUgbP8vXErSqyajffbIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741330503; c=relaxed/simple;
	bh=4Qu1AaZs2wjMyIr4R4L+5t9BtwzV/5qj5uPK97+76qc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Td7nKd6pTDGDaKyjy5yuOPKRAeru6PyggCkelHpRspR921jcEw2r29Mg9Yobrnd09KuYX3bgQtevZesqdHiMWveWAecCUt1ewlrV4PwToLC0jkamXzooVcKYL4dAzV+Gc1FXx14LRjnWS+YbL8RZSesRKW9pLuMz7KiWPERhr4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NKmhOQNu; arc=fail smtp.client-ip=40.107.21.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NKmhOQNu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ACwKtZwbZYDYaT9r6O1NdJtSt/VDASJ3nLE0Cqh26nehpW6NBa65zUR5YIZnL3g9+0GMysiGA6bUVLTXlfDjwtUJKUZv42Qm5bCj5Y2MeTb9yTmuOEopykKcOd5fQVxmgUiZ6IpHZ8Qa2n4gCqUrcsqKVaJVdm8b0sB8/YXo2ES+xqXFMyE05Q4qRHZlrs3Lw33sk4TB22RLC97zkqJ/ei4N2bJQj0o0Du5LIQKKyWiIDeZ6Z/HVruu0pCle8o6owULn9XSWSQq30on61tPIst74woCWtKdA1Tdguzo9dVzUw9/H+9bo+9hdDsxoPH5Kp+23LXvqiOnwEOHjDeWYVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A87xR3OEQpTzu1lt2q15kmGHC/p0CS6ENusJne07wlU=;
 b=R0VGIW7/RxQEDqBaze3m0FsD5mTDkFCllG0jp8UJIARSDli4vLMP9ReeZlO3nvUCpXHQB1JJGH6BHvyxIjmFuGc2gPr4pV1z+ATfiJheN8biShq0pVs38SkLCSSsBA1mKB4XTCnezGtj2FsPIEUNiBYT6QLlaqUmsDdS0FcrH+zOQjKFHs6M3vLTNqRd3Z2cBdgRJ6SdPMJwhYdxLjNsKgQJ2p9aVC89F+gKzLs7IFGiR+EAlHLn02Z2WTLaCJYgSr0FrzUrII0DQKflmKxGhkwMS2fYrznBzOSBgA4W25MQfwyeU4vth9spuacPPNqOIOHv1IKHeKexQxHwX9+Vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A87xR3OEQpTzu1lt2q15kmGHC/p0CS6ENusJne07wlU=;
 b=NKmhOQNumMjs3G6PyuvxRfdSZTidPngJytw43OlIIRwfPz1PX6GT6og+/0EN/i4Rvv3hwyk2vnXlIocdVclA8PmELeH5hSrw0+0x0M4Jwzm8gm7xONhR3kyrqyH96w1biGAtJJ7HMihz+IciVIMy9mmuZHeUy4Ox2AFZcD9qBRdksOZHkDCuDnZnq72H7IwRx2SQBVezsLJFsOpt3uYmdUIOskTKLDg1QgacYjU0k2nKDbnkEomi5G06KZs5SYqpmMKJRFWRYYpbtpWRRdxX0n2VO82NyghltjE6bpNehFI4ubqNtj5TQ8Pdk7V5Vhrl2ac1l4Dvg9+Wvr0tnMLfsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
 by AS8PR04MB8707.eurprd04.prod.outlook.com (2603:10a6:20b:42a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 06:54:57 +0000
Received: from DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37]) by DB9PR04MB8429.eurprd04.prod.outlook.com
 ([fe80::2edf:edc4:794f:4e37%6]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 06:54:57 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	shenwei.wang@nxp.com
Subject: [PATCH] tty: serial: lpuart: only disable CTS instead of overwriting the whole UARTMODIR register
Date: Fri,  7 Mar 2025 14:54:46 +0800
Message-Id: <20250307065446.1122482-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGAP274CA0011.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::23)
 To DB9PR04MB8429.eurprd04.prod.outlook.com (2603:10a6:10:242::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8429:EE_|AS8PR04MB8707:EE_
X-MS-Office365-Filtering-Correlation-Id: fed87c61-8c49-44f3-a8d4-08dd5d44f901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2NmlnNgRg8xk0FZfyq+sd0WzFuT4N5Ik3c+8eT1nIfsvHqftKVT9MrK3Ira5?=
 =?us-ascii?Q?tSKEp86qJZm00Fn0Ue1/gEyJkKc29299t82Onb/NzKQuEZH44oRJKZu+ptMk?=
 =?us-ascii?Q?CsNtH3I1ne2N9gH/YNbrLKRFCW7iLEFpvBpfF6qz1J2kYkaoGOlz8spI3dVT?=
 =?us-ascii?Q?7VL/fgC1l2C/jn2gDsg7QjjkAPLc6BbBUnfljIjUhqs3x4/LSymNelTNLrra?=
 =?us-ascii?Q?7SCii9NBJsEUHOVUFbMkE/whoOIMfw9KN7CY3M1JGPmVY3fxHjty2J5wx922?=
 =?us-ascii?Q?dbavo89euwT1jW/y32iqSoKdu3x36/AUt8o2UM1iSlw2i8rmH589zeHeoF41?=
 =?us-ascii?Q?Sd3/uXX7eaBXlBIUHXs6JtusLwgTdQw5U1dxBrMR7EBiThsjATeSJgxVbawO?=
 =?us-ascii?Q?iaw6kpxCn8pCdmhrY/ll39GcYKtj19rDkeEUOdOn+7FpU0Quh5HZxl8WNcui?=
 =?us-ascii?Q?Z2F9OSaC11APwrDPILrssTJGBl1HTem3mQkawd/lOYNrGQT8F85U2/C8WKwY?=
 =?us-ascii?Q?xYMmqrZlfuKvQvLZD8w/urzocLrCKk6WMSYJ86LtsFgxC0h3OtPCWLP0BMbr?=
 =?us-ascii?Q?wqAT5RRyMfm9zCLw60HUcihByZ9wUGLENuoCn5C92ljMHY0eg9uxupMYZF+F?=
 =?us-ascii?Q?n+P+hAltcca5Q9rHbGvkbrRArR4GzNpV/BsSsgmaFnhLwl8bEKLCEOm3WtpV?=
 =?us-ascii?Q?6MKPBrgdz0CudTAo+HKHCmnehifM/4EQz7AMTTKcZUTtMTN4x7Ql+yWPTEUh?=
 =?us-ascii?Q?KGU8rDkWpuzyKydqqUWnrjDdl9RPjVDP1yW07KBI3LYDyxDiYmBb59za6dZm?=
 =?us-ascii?Q?MeBf5hG5KRFUc7wBWtT9MNbwvbcKD7X8lVRLdsuPrzHV/7yBPP+PCRMneHZZ?=
 =?us-ascii?Q?lL2SB/lAS6MbEVNG00kD4f2FOlfLAaSLwzcH3RyA7PCbWoose9yVxTlaYKRp?=
 =?us-ascii?Q?tpI1hMYhzo9Pjl4orODu4JtwWyG3mlDEadL4+tY5EO8Sa7Q9qnYdAkH9CfnE?=
 =?us-ascii?Q?gEcXuyHzZGovSWgX3hgnFAJsxQYlpkSlyykQ5GOjsAgala845C/nPEA951VM?=
 =?us-ascii?Q?jSfpS3iyIfEinOuavjWl8YKFTJnxdQyAuoKl7ERI22OgXcb3pzl8iRL5mxkY?=
 =?us-ascii?Q?pRdcXpBQq1t4F4djl0O7MJIj+tpRY2Y9enF6OBsnv8SvTnaQuAQpXmy3iHPi?=
 =?us-ascii?Q?2sFWfvFcJcKAFJSNXn5rEiCvtjMFg4hI5FKGXxrYiNja2CMMD6kNR8tT+yfE?=
 =?us-ascii?Q?+pO7KfYXf0YTymoTDwRyMQ/aYjiXWtxid5OE9W0UknjzcalUXzsbhF7Q2Pe1?=
 =?us-ascii?Q?PTxAdNMbkA/cE9G3n9cKeWH8NL5UTFjpFbwWmaLsabL0P6F9Zm680kee5ThZ?=
 =?us-ascii?Q?/1WNWV4wSttQmUIFqKsmUhDaIJkibQVguJ6yelOGiWKlRbE6GTeiVWgNlyHy?=
 =?us-ascii?Q?XtitQjy5lF5GYy61/D8ivcZiZL3ZAaRb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8429.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yRTgZKoArcnp/EqW8dUkndc3ArnO0OypLuskVQPYgUqO5g89ACHrfqEcHhuN?=
 =?us-ascii?Q?nWcsLai2/i7rUjePZe5Li2j39JPO0orH8aNTW9uW/hfZMouPUHLlqrCQJ4p4?=
 =?us-ascii?Q?EtqTFf0zMMGdPUq+CIQRCBGc0w84Wsdicu92qyEfDtFk7let+cTCSXPJLYjm?=
 =?us-ascii?Q?CYOWWzF7ruOGktyJVz6YkvKOZzjqT0n2bY/D+J67jd0KVhO5d3pv2rRGa0YR?=
 =?us-ascii?Q?QWeCx3s8VlKhwA2d5YAISyJI9/zlZFpIMV0/0rjNPsZO0H6HTSKyGb/vMl5v?=
 =?us-ascii?Q?srJghzAt+A1o+FawQNSsW0Z560+ZumYUG3ghEA2q0MbCRPAVJUq0AqPfrUbV?=
 =?us-ascii?Q?vVz8XGrwFUc3KW7o8XeZwcdgnsuNKXeSOjyiPQnJtXBBCK9Q9efkDpmbeOrr?=
 =?us-ascii?Q?I95Qu48u3v1c7pJ3CtZLJ+A0vaITcGIwZ4hNaVqKB42LzT/GEtIE7zy589Xk?=
 =?us-ascii?Q?FmZuhBWgI9kQHENOUP40OuQgkJQTfgwLniSxwFEcvm1RGnvlGwckimbmETDU?=
 =?us-ascii?Q?yC4KJi0Hq9DWehRx/WSyxN1ohUDpmaH5/fhMiq5/69nOWf/k0tZdJFQKRj+1?=
 =?us-ascii?Q?M0xszHw3kkgD9V3OUUn0LetV6MtOvUJa+bm/f5/QHECXTeJql5E/Nx6EDnUk?=
 =?us-ascii?Q?XhANKCNAi9IKv/vNhmCabYvmwXJbeSE4GTRJoMrialTR6MfRZadrsDYnH0lO?=
 =?us-ascii?Q?HTomdqmEejaev74mf2IgNYJNzakoDgTYQxFZ/Y8gUB+pL1W2e0Y2gS69D0wu?=
 =?us-ascii?Q?i/3ZPiCDZvfOzsEQC/RER9wrgKuN080R/fOI3Yd4d/e+Z9JDsN4DdALjwsgU?=
 =?us-ascii?Q?U3Bsg6rM5W71pNpxylJZ3fj49e4Ytdg1RR45GZ4tG8xwnxY6sHhJCfnjCM7T?=
 =?us-ascii?Q?EbTUcTZHKaml012Sjnwp2qHIOfUNXJdeN58ADVcA+OuryW/+34uhV6Qg3MwQ?=
 =?us-ascii?Q?TlXJzyHtFA7Efr/2iq1LUgpiMMOwvZ4gVqx1/QgfSVhGKdWNPO0gFjixnOB8?=
 =?us-ascii?Q?ajgLq1xJWHCGMG9otQfarb11k0VZBprRtJg1r7bfmJnClaZfHgK0mv7HtERC?=
 =?us-ascii?Q?6XCZ96Ekr10GSmYyb3pqVZB3pbjv4KV7/VXQZwvt00eyeUpeORVQxaY8WcY6?=
 =?us-ascii?Q?7cbWeQGPcgzen4vCj2XllxS4UgMjrkZhHFq7J35NMHQSjkOS2ILkAOBklPGZ?=
 =?us-ascii?Q?lRhCLDLhADWmZ+RMonugOtoeDmMiL8YG0dzBp9p/9wuDEKJeGtVb13LkL3Iy?=
 =?us-ascii?Q?q9l4cizx7VHlZAPJE3x+aGFCulYzJxFxAwuCIeHPZmMlZtJob+hFcI8PKXFB?=
 =?us-ascii?Q?CBSy+J4XDH1avfkKZbkJgb98sKsRVX6JZAPkivuAg/8CZWLXhKWtUoFsVCgf?=
 =?us-ascii?Q?dOpivU6y1oCXRQy31c2++STpmIp9f1t8nztYWJ2ClMs0js/5qUBxBWi51gOb?=
 =?us-ascii?Q?w27Dd41EhYCWRHsk2yTOMW70EKbrx3vZCWouRfJQBzXiN3AG87iWtgXYEEmX?=
 =?us-ascii?Q?ryop1pTuHaM1TmvifOD0XQhVe0paEYoqh7ofLpjECTjZoU+kMJwDf7SQRGZ1?=
 =?us-ascii?Q?fec3xhpWHbDesuchcseCMFFLL+cChS+Y5uFObn0J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed87c61-8c49-44f3-a8d4-08dd5d44f901
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8429.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 06:54:57.6329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4y+TR7Buc4v75ba/xhkQvi/g4ka/VndZFw4in8sdyvGt+TfcF0MA/T/7SuPYUxdOAchcji9VFa0t98LxlMHNsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8707

No need to overwrite the whole UARTMODIR register before waiting the
transmit engine complete, actually our target here is only to disable
CTS flow control to avoid the dirty data in TX FIFO may block the
transmit engine complete.
Also delete the following duplicate CTS disable configuration.

Fixes: d5a2e0834364 ("tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 740de74e9f0a..e1350dac2f18 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2347,15 +2347,19 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
+	/*
+	 * disable CTS to ensure the transmit engine is not blocked by the flow
+	 * control when there is dirty data in TX FIFO
+	 */
+	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
+
 	/*
 	 * LPUART Transmission Complete Flag may never be set while queuing a break
 	 * character, so skip waiting for transmission complete when UARTCTRL_SBK is
 	 * asserted.
 	 */
-	if (!(old_ctrl & UARTCTRL_SBK)) {
-		lpuart32_write(port, 0, UARTMODIR);
+	if (!(old_ctrl & UARTCTRL_SBK))
 		lpuart32_wait_bit_set(port, UARTSTAT, UARTSTAT_TC);
-	}
 
 	/* disable transmit and receive */
 	lpuart32_write(port, old_ctrl & ~(UARTCTRL_TE | UARTCTRL_RE),
@@ -2363,8 +2367,6 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	lpuart32_write(port, bd, UARTBAUD);
 	lpuart32_serial_setbrg(sport, baud);
-	/* disable CTS before enabling UARTCTRL_TE to avoid pending idle preamble */
-	lpuart32_write(port, modem & ~UARTMODIR_TXCTSE, UARTMODIR);
 	/* restore control register */
 	lpuart32_write(port, ctrl, UARTCTRL);
 	/* re-enable the CTS if needed */
-- 
2.34.1

