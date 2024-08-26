Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2060.outbound.protection.outlook.com [40.107.255.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801E11514E1;
	Mon, 26 Aug 2024 11:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672034; cv=fail; b=YhqUhgo2z/uKA3+jkafu677YA37TIr82BnSGGiNGcrLNoNw4ytgKjk/oaXYM7PZa7uH4I1pcXwN4gQM6qHL5MsYEJLGFSXwWXvJAZOhoybdUV156q6L7IyeVGBGQFfAMsPBtnsmU9P4BzTWeqtifn0pyty6WRGK7FBPkscmVwH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672034; c=relaxed/simple;
	bh=vNbZKf4U4e+PHAd6+9JrpGKM2iwVFiH+LR5x9gKbluU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oAon+LI1ybhil6kheL3U01CYS4B+DC44KFMeZHv5yt+T95zWBcNhuF6u3S2yrttCrH15HbCZrlkuyfkBZGTpNPZCiiCKrEd+zVPLlxFPaH9JfgS8x0TTv1NDWCFeREvdqKUnTN6pNLfTRXoi+tVERBv9eFWYfv4twwk6f06s4mU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=ljuFRkeF; arc=fail smtp.client-ip=40.107.255.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="ljuFRkeF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZLaZ00cg0mjTe2t0xrnqih9N/3pmYpgB9CeCk+oWDuQcaz0zmhV9cnhF2mC2q7pBPIlDE+HRk7ClybV2qFk+MYFtOxMwvDGVCBm7PKAlvQA8rDG1jHpFIjMQIcaXOCK6CIpCUL0AfsnBSOp/KzFQatDAqvmY1tzB40kIYSgfqR5XFP/3KMmIUYtVHbKP0TDXvvhwPDaa7DL9gXmCDdo4REHv28e0nHe9DYqSFMsHf2TL+asWklhzQIkSjRcmqQGow7djC35toBul5yww44V4+77ikiYo7+BSuzV4Kyn8GJa9CBAfIlCpEY5hFWkHPqRcAHcqt0WJ1oNBh3/7Yyub+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QsMgzjnnY3ZsB+QmPl0tL0sbVOWt8kUn6YkHnoiFUEQ=;
 b=sSRfQGFVrDpriAtxo/4eabebHMGGx7tuVarnd9kaB531WtkQ198/y9aNceJ3SOEF5Funghj8e43ShLlrduzvVU5hbuEiOJDTEtbyTfyLbjDTfzy+MdXkYxhIB7Df1qIyV/FjUVrEgg74qNVxOIjr0x1TgAXfNaX5KKrakxoBaOHvgqlVVEB02h8xlWW0df1bus7B0f9UQi/EwKAlaioUueYtjMYPDePptnhGuIFlycXHGhsw/lyTgtJDzXbR//qLqJhqZWENvvTtZvvw4oZUhUoFHiOv7qDJHJL0AWACOgmseJeWOAuowkEBSOWcGkMx9TwQFIIfYf8xEFYlrTER9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QsMgzjnnY3ZsB+QmPl0tL0sbVOWt8kUn6YkHnoiFUEQ=;
 b=ljuFRkeFsUGXW1PTkbh4+qRFFDUvgtSItxX5z4c6CIr92H9T8i9txzgYYRRknE+KpxYB73xI46pKXlYQSoZrE2+41Sl9xOqjEaBcN9szs9AhCMXlfLGfwjVF+ZZcIB+vCcg2slVBiDO3bE3GHfF9hZhQzPQBFtrBlBHXDtIWoP/goZEh/J6F/3PvppNCHqWQYhcH4hvJqrKuzgk/hLB4J30062tJQMPou5lHoWni3kiJ5BIRM10MFI/4+8ob0Ojvlk95JeMDIqNY+Uvnlhi32vcAAwE9x3Qe5WVf6bIJpGPfDubcJ9yz0faqtvI0PHft15WTXHK6xctymadglMncfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB6466.apcprd06.prod.outlook.com (2603:1096:400:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:33:49 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:33:49 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Valentin Caron <valentin.caron@foss.st.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lino Sanfilippo <l.sanfilippo@kunbus.com>,
	Erwan Le Ray <erwan.leray@foss.st.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 5/5] tty: stm32-usart: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 19:33:34 +0800
Message-Id: <20240826113337.7364-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826112933.7249-1-liulei.rjpt@vivo.com>
References: <20240826112933.7249-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:3:17::32) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: aa68c48c-b378-451b-cc58-08dcc5c2f455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sDZBrCzfXv03pOXKz5JiKAjlFUHAxq62yofPj1Yvjfub9QAKe4xVZfgLyWiN?=
 =?us-ascii?Q?N1yj3fkXaIxZHN0Mfn8YVBxQMieyq0zk3fqvEPvFLsFzegcAAKzOyGET7juX?=
 =?us-ascii?Q?89lISwj9u3sEQIc1GHywCm8uIms1OHPbBPhbI6qT5rEFcTxJ71bbTmTt3rXO?=
 =?us-ascii?Q?gR4YKB2hb2DR1yQuRtvcVEF+u/49hOouBXpBiAlE5KKS74Ew4PZ6zcqfKKUT?=
 =?us-ascii?Q?S/qaww+PnEYRuT2m9c3zK/0TWSc0s6YfrcLZT95oFosr1wlu4RvbWoTw7hiq?=
 =?us-ascii?Q?pgCk3yPDu0BfXwxsdMiIm4TPfklF3pI6nBbrM4zzT/dKj0cdStNx/3+FnYJl?=
 =?us-ascii?Q?n4kfBweijWRPXDQlLazmSZbq0qp51CWq22RMuRC90dmrNQ3pmwc1ptpBJ0i4?=
 =?us-ascii?Q?n71vrwfdhMcBscoZIdEeQ8Oo34+nH2031fwctk38sPKhmPtRH+yo/jLrHHL5?=
 =?us-ascii?Q?Nz3Kb5tsfpSU0btWYj/sj5BK3uP4/KUvhjKwQ/KOkGBLDJ2fcitfJ3cImUvW?=
 =?us-ascii?Q?a6SBYR7YFMEpQexRqttiQat8HHuPSJH73l3zx+qMgZf9shA8Ip1gbLNHTBiz?=
 =?us-ascii?Q?aTGNqJ7oYZHV7tZ5qKYrs4u0QPoHzFPrSxBkiV3tyd3O4CXOdmLBvz94sCrT?=
 =?us-ascii?Q?I8RYidNHISv+WkLubRW4B6xelQWrN7UcItg+oniIrDJq87eAS+tQtlv2TZVP?=
 =?us-ascii?Q?6oo0HceQD11pUjB1isn9VFVjl6vbtbTFvp0CX+lniGa2EqCt/SJtoGATZ16X?=
 =?us-ascii?Q?Swoq6bRkUNg6EhMPjOAvdfUUMFNcFiPZVchvSyfE00fe2wMiix8sfW0BcdU/?=
 =?us-ascii?Q?gmir340TiAKhYs895b3F6HlK6HYM3F2rR4JMrvpggr60QR48s5GdCpJs+mT7?=
 =?us-ascii?Q?aJGQJMncZZCVDG95JOT5O/yQEAfjzmG1M6VUlOMzH94ufudCnBhMNHJYYb/o?=
 =?us-ascii?Q?TELFEfaWY5Sy7ruWh+KkiojgtnEE020CIfNBhq2/Cu9Faalb/DS3Ti5It2ok?=
 =?us-ascii?Q?YVAG3nYdEt6QYSQFavZf+4FGPj/3RPrl9IWedPSp3JFH69+PJid4k32Bv/9k?=
 =?us-ascii?Q?3ApDnsv1i71uteVUCvw6o7Fp0riv002yKOdLhbtVECEr0we3f+8LiHtTLv8Y?=
 =?us-ascii?Q?nI1Z96QQayflrvrjZo2CrOvXbM5VQ1yr0SVL0hUpyD2lPMgmMaAF0lvFdEcl?=
 =?us-ascii?Q?ZAyO59lQj0iThUQDgPmzdTSEg8CEbhiicWgduFuOOuyfkS0YSP+A7pflIXdO?=
 =?us-ascii?Q?/2SUzmvkMDUgvPKAat+KzjwpA/MKQhr0WuBaRBqBOxsxK8Wi6Qd+RvUINaxk?=
 =?us-ascii?Q?rKBrCQdgZwxRSUgnYdRS0tfErx7lUcH9dxZdhtHZGTpVwKVfn6yxsDbhfvSC?=
 =?us-ascii?Q?CMmVyTNBMP9mX7OE7YJZLRwfEiNEKkghjivHU1qg2AJRUzsLpAbXuHiiaA3g?=
 =?us-ascii?Q?G2deTghmijg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a2/fVkP6LrUQyVu8DpbmXWoEbVX9NR7xldfER5m2W7EdaCfpqXSoNXvEaD/R?=
 =?us-ascii?Q?ASq7eqWLnCphVIVy6p40F069kKMjVcl/dwIOGTjlbHoDg3XTgUDIs22OxZfH?=
 =?us-ascii?Q?hiIb8CSUZasH0bizM+YD/MvaTXWP7YB/sYkM+pTDaIrFlJX6B613DIJsLp1h?=
 =?us-ascii?Q?vbek2ZQeVfs7el18XGk4RlabKk2tVB9auoDQvOb53UXkHzNqXJ6z4bNRZStc?=
 =?us-ascii?Q?MPpLr6NVCukFJfoSMmwAkJ29rKT1vME98tToQ3GtrE7YWIAOvEMyR8bk/SBn?=
 =?us-ascii?Q?iVcH7sydTKEVGH5ZOQ0Exnn35qbwHdkEAjQLjykQhwcJGvXAq+3+PlB4d1te?=
 =?us-ascii?Q?Or3JzBHRK4iKXa5h03rB9WJ41uITEepj8MNr3+0d8kNWk0tCKojL0FlWG37R?=
 =?us-ascii?Q?dkjel/WrEdn6breNHH4w8ZYlxfJOyfOOHU/cIRnleILJ8WiKoYhPJaFoAyZq?=
 =?us-ascii?Q?OBYMwHR6HWRrXCsab4leRQxfDdPBYhQCeH4rjC91sgldNPcEzcZz1EjceQaZ?=
 =?us-ascii?Q?ulClFdhW0+y0nrxSxa34A/BjUXtIc5ZhTLjsgn9c/d+fSE/SN624NWceJMZp?=
 =?us-ascii?Q?iX7NZgULzSWO3hU3oo2LTU2gosCu7Lefv127zBW5AyNOT//cRsntTeL4Pdzr?=
 =?us-ascii?Q?8BpiFfFL2dXIbEzO4GjWWp/Z0DO1T5vY5gkgdKQMPQ7IvCXM0JurnDCCLxVe?=
 =?us-ascii?Q?ZwlDUgNtbJRm2LtreE8tl8axaG806Q6GorUG0natgX8M4hP5xu6TdjjdO/Se?=
 =?us-ascii?Q?ByY6lR+n0Rk64KkWJaw6d4RwrWKe4QnNqM7D3ZmGNuC3PjoYCON/UptxwOR3?=
 =?us-ascii?Q?rfi9wo+gSQR4kKmnujhj86JlOIQkFuunpLfv/hqNS3Ms1MntkegZMsNzowjR?=
 =?us-ascii?Q?B9fSEekcmncg/4nsuYpc3egfvr705rVtg0hX7+tystKgeHmRd5gexJhCi3qk?=
 =?us-ascii?Q?HuTlSNmnLHNfJT+iCYHSzV1gABE9bXJ4Lfm4KYTDiZXpPgtwASJVHCuKjFMb?=
 =?us-ascii?Q?XarwoJvYFcxd1wR8SbUSX6MzrFlS9ou8ZmMywja+p7BKmc4T+jswSobO9I0X?=
 =?us-ascii?Q?lvO4IY3xfYVJIFq3aIZTsdu0OvC54wEVGS2J5nEFWQbUqRES/3X/TwCpVtON?=
 =?us-ascii?Q?ZdZU5fp9g5HlFl/4ANpadQGnROBw3Fc0ydvyyPyf4eINfKRcBRsQ/qM6+YTw?=
 =?us-ascii?Q?3IKCg4cWxHUzo893hRoe/nvIusjo7f24KiVoeyPmUimCAJAMQsQAwB6Euey3?=
 =?us-ascii?Q?f81XRvU/NW6CVbzmKYcgW6wZOe5cs403VYHiBG/cf7TRMU7IKkAZ+DmNYQWl?=
 =?us-ascii?Q?gnFW+shEh9sokeJxCfZDtLk0ri2mqehgLuCmY1FIrOl+4OSTuOpyGBF5Lbtu?=
 =?us-ascii?Q?jHfxS24UUcDgLNJAB2TLY7DgvqpaAq4iTAux45KFR6Y2s/f8hUPtUJ5qB1p0?=
 =?us-ascii?Q?cDaD01RUOj4bkNqfWpqNSPXDcKyW7TzDPvmdLxnGEtl00SlKmfF+1i7gHnOU?=
 =?us-ascii?Q?x17xsHtbt+fwKqkBt5mHvnE4O/ZAIGoC7MRzUjo4AfGqpvqiqZLYJF7TSWH0?=
 =?us-ascii?Q?Y/njCg2oo35dy7ZcV7LA8Jec1v5Lz2f7x50iPbNj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa68c48c-b378-451b-cc58-08dcc5c2f455
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:33:49.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLWwhxL73+glbqItvUKoNNxFDmZfiSRXv5Om8unZxjkLThnDAHxEArmDUP9VLCDhbPqvWAhLEe/oO1wR5O8toQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6466

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v1->V2 changes
1.stm32-usart modifies the return method and removes unused labels

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/tty/serial/stm32-usart.c | 30 ++++--------------------------
 1 file changed, 4 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index e1e7bc04c579..559fcc2659eb 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -1550,11 +1550,6 @@ static int stm32_usart_get_ftcfg(struct platform_device *pdev, struct stm32_port
 	return fifo_size;
 }
 
-static void stm32_usart_deinit_port(struct stm32_port *stm32port)
-{
-	clk_disable_unprepare(stm32port->clk);
-}
-
 static const struct serial_rs485 stm32_rs485_supported = {
 	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND |
 		 SER_RS485_RX_DURING_TX,
@@ -1599,19 +1594,13 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 
 	spin_lock_init(&port->lock);
 
-	stm32port->clk = devm_clk_get(&pdev->dev, NULL);
+	stm32port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(stm32port->clk))
 		return PTR_ERR(stm32port->clk);
 
-	/* Ensure that clk rate is correct by enabling the clk */
-	ret = clk_prepare_enable(stm32port->clk);
-	if (ret)
-		return ret;
-
 	stm32port->port.uartclk = clk_get_rate(stm32port->clk);
 	if (!stm32port->port.uartclk) {
-		ret = -EINVAL;
-		goto err_clk;
+		return -EINVAL;
 	}
 
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
@@ -1625,8 +1614,7 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 
 	stm32port->gpios = mctrl_gpio_init(&stm32port->port, 0);
 	if (IS_ERR(stm32port->gpios)) {
-		ret = PTR_ERR(stm32port->gpios);
-		goto err_clk;
+		return PTR_ERR(stm32port->gpios);
 	}
 
 	/*
@@ -1637,16 +1625,9 @@ static int stm32_usart_init_port(struct stm32_port *stm32port,
 		if (mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_CTS) ||
 		    mctrl_gpio_to_gpiod(stm32port->gpios, UART_GPIO_RTS)) {
 			dev_err(&pdev->dev, "Conflicting RTS/CTS config\n");
-			ret = -EINVAL;
-			goto err_clk;
+			return -EINVAL;
 		}
 	}
-
-	return ret;
-
-err_clk:
-	clk_disable_unprepare(stm32port->clk);
-
 	return ret;
 }
 
@@ -1853,8 +1834,6 @@ static int stm32_usart_serial_probe(struct platform_device *pdev)
 	if (stm32port->wakeup_src)
 		device_set_wakeup_capable(&pdev->dev, false);
 
-	stm32_usart_deinit_port(stm32port);
-
 err_dma_tx:
 	if (stm32port->tx_ch)
 		dma_release_channel(stm32port->tx_ch);
@@ -1904,7 +1883,6 @@ static void stm32_usart_serial_remove(struct platform_device *pdev)
 		device_init_wakeup(&pdev->dev, false);
 	}
 
-	stm32_usart_deinit_port(stm32_port);
 }
 
 static void __maybe_unused stm32_usart_console_putchar(struct uart_port *port, unsigned char ch)
-- 
2.34.1

