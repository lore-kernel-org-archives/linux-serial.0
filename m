Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2079.outbound.protection.outlook.com [40.107.117.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F91547C0;
	Mon, 26 Aug 2024 11:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724672014; cv=fail; b=GEQd8/oiLDxlcdfK7uEUZc8WNo/F/y4Y4gJGvHzUkBI1vRh15hm7DvRE0W0JfdWtSZfi0YIPI9/8fIjh1YatVykrEOmIalWuFDVzMbLsUgyk1MhFGtzxzByDBfAKmO4Hh686kCuhAulFxTzCoC47d+8S/jq8BoFD8X3V4FXqcEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724672014; c=relaxed/simple;
	bh=rBsKszEdz8YWkjvcYDrwI6cUFR8vqo8+oYNDhUWaRI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwn+ujdVgrinyO8Z89SLHWezDfPbUaRicWvHYNg4VkQS7OQPz/oB0WGdVmy81j/gJ7IflFapJfraqsY8RF3alRlpDS8IODxTMSKn8J+TgrJrORzmhr1X0WPBTCTTYLWvbgO3VVGg2jtBkX0kOjYkbliFBc1uA6Uw4CxrclMwhrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=j+Oim4jc; arc=fail smtp.client-ip=40.107.117.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="j+Oim4jc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EIu11gDjliBrNvtbQGZ/SbIVa+PEK46joxgrj+aCvMIbHyJBGuGTgWXCIIPDxRUaKPdDn3LYybNS+yglIGAffXrpyJxmxmqDf4i8t7FcWlI+oJjUXCT8W0im3eaqPnx+1E6BVnBt8i2SAF/OshgbAYOUeSLXuu1LhhokLQoIxw/sfYcp070RROzFzVED7sjIL+u0HWxEiR6OlUPmrAvAKobsJm0dz/JVRU/C4rcbeqCrQtTClN2vtoHK2SSG0CXVF3uT0lfNckY4moEIMXtQlGvNXfSLt2Cfj7a1SVgrS/8eZSSCFPQXcg7zwEdoRIIbNjo2QZ1ze0hqCuMW7EiHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5F4Z5JDNEo2PMJrYJBGtWIRDfs1Ke+lcfNrt8WbmNc=;
 b=vRdzopIBRKh8DCu/iciQtj9Cb8NDeBOQsMEZYf6xmlWk5IOrHEkycWqWqXUuTPOiUwm6KvxhgZzHst9OjBgALpcpr1UAzgjy9BLN7TNc2s6P1a7ZX+HaXDOdL7eUxlCu7zJ0WvGt5jn8NlyLffV/vbN3PejlD8zr2c7gz6T1MVmRVpFBRo25R91mc8wkyCacgQwTWs5SOnb75gLHCKuur5XzY4Dx0Ag3BxQV8x7KrEl+BqJTZrOUnPdTDNFNzoPysng9rBZmbAnm9Pk1ZaBQWoIRIAz2R4hD0emKHZy5ReElRTPp3dsn2kO5gXbXLXAq4+O6oxJIvur3pts32KO4/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5F4Z5JDNEo2PMJrYJBGtWIRDfs1Ke+lcfNrt8WbmNc=;
 b=j+Oim4jcWvvFu1JPuIKj1DKAN9OECfchXhzeAF7z0YnDgm4yIX37H6Mz2GprHPoDykvNkEWnBERGgZ3CD5gzRYD25o/C21yYX9HqWePcL9xmc54tmaKa7Pl9VPuB9n9vnMSSDnG7HbVec0ysVzRvKsCTuRN24GzPqUTEAv7+SMnvW3t5cnVWyujzhFT4e3TZ9t4SXfLnVF3QuGIc+HkVgF0A8mTlvHPvqvkBRCDwDzcVGoI8MaycTac0504vz1Ym/VpBQ3j1JnHfbrnQ+EdnRIbttLIBrMFsSHjut0iVhAEp+fZ83LQpvmW8LkG8/gMs92qF4rLgYbtvZvpfYbrKhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by TYZPR06MB6466.apcprd06.prod.outlook.com (2603:1096:400:45d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 11:33:29 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:33:29 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Lei Liu <liulei.rjpt@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-actions@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v2 4/5] tty: owl-uart: Use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 19:33:14 +0800
Message-Id: <20240826113317.7342-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826112933.7249-1-liulei.rjpt@vivo.com>
References: <20240826112933.7249-1-liulei.rjpt@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|TYZPR06MB6466:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bd6da83-8b19-46da-3715-08dcc5c2e8a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Kp/lhTrH5e8Kq5+ieV3brmzfZXlxx9aVf4Z/4h8ZrbkhfiLXiHxMK+Msc8nS?=
 =?us-ascii?Q?V7G5BEemAwkef/NfrnniA4s2HLizE7K7b0Oy2qSvgh97W0gJdoAJTWKyXvNq?=
 =?us-ascii?Q?YQCX04rX77+aeKO8/6w7zJcAjAfMkZbc0+GFkFdPR3jgVZepAB27rozmRbHr?=
 =?us-ascii?Q?eZk+Mlhjfy7YAOGcAu+PlIZpqGOeY2cb8T+Lu0SecEXETs4/hFJzRg5fVfq3?=
 =?us-ascii?Q?NTlitRPLS4nuReEvz1VSIIPYcoUY2Xw9PxbDH6ysuBPzVDnux97Ok1IH9jZB?=
 =?us-ascii?Q?e2FqO2J1w0zWlSDUJ8Ss3MIjxtSJ6nairoKy2RCk8xDtRFgGiiPtXTEseoOD?=
 =?us-ascii?Q?fe5GQ9egzwVAWq3vuX/DLmussO55QJGHKYR7UX3Qfxoq9//iXCv5IbEnUpAe?=
 =?us-ascii?Q?HKYVbRle5UC+WuoDX6+RKWvw3E320tX9G2OMms69TTgNIcImJ+EFtwhM+BMv?=
 =?us-ascii?Q?XSz8P10qHrD27XlGMopmzw8sQ1Mv6FXuyGDnsxiCgVfoLzq9XtCI4udpntMR?=
 =?us-ascii?Q?6zEiPtwIVBRzKzydh4NcAr4QI6+zjeXFse7BnZ/5bth+NP60cjC7mk96PQTq?=
 =?us-ascii?Q?OeXzEB6jLkmjrFBoYr4VlesKfSFGFGHgpuC7SMFGrbvQExGel0OhoZdxcgvh?=
 =?us-ascii?Q?ApAzxQmbbXKMmJ5JD485bs1n6J/YZR3s2iKKhDgWxeDhMYr0V4YlIwOl3sEO?=
 =?us-ascii?Q?3h7AfY9rcqu8JUcpg7O4T81i50hpRAqqJfUzV6le1KzHA0FlHlGhOIEJ35ED?=
 =?us-ascii?Q?plTbJ0cSJwwB/2WC+/N1I1BOBYFllDyU1mkqFIKOjPrvLQQpjQQb4O8hJ9Vg?=
 =?us-ascii?Q?x9mUunEO44zx3B/PUyll2ARPotja5DvJTtLI7wWqq/ke4LU4WUqjccrjjsPA?=
 =?us-ascii?Q?qTBm0CpNP4jsN96AWAKcdCUBFH97qzPLrLU4VIe5Tf5pZgbOuaJmSUgiI5F1?=
 =?us-ascii?Q?LcspG0MXCL87cbYHihEGhs+kz84ioUpsGDkqImZlfEq3ZND9mVEl7/9OPnCV?=
 =?us-ascii?Q?jEcXbvcSVMzLBmZJW9ZkcqwuMYIDRbgaaJfpwETOswETKKCLEeS9iTvvT81A?=
 =?us-ascii?Q?b/9FNd40SGoY54iMDUBiMibgklacJ9j3F8P1B6ZgV1nOTjbkD6ogTOXXjRuU?=
 =?us-ascii?Q?nMJVGRhI/tkh5SxqpbP8p3lHEpv6gSbujZB7q5xiUQ4Lm1eVBQdf+kUhQhrd?=
 =?us-ascii?Q?d3wLebZCOLMBi2jHMgNFR+K1+L/bXgh1p33z1D4OLn0RMlpllWOSfAZSv04I?=
 =?us-ascii?Q?TrbXGONVXibY2TAhRc7mud9BOmHDsCV7pTbkPyijua0GS39wz/0vtJ4f8kLj?=
 =?us-ascii?Q?66P9wtLepfd6fbwXPSQhiY2YTfSvgh4g1aJIZIZDDUcjMef9aTYCdlcC0434?=
 =?us-ascii?Q?2v/0zgNf38grshUBEB4qH36JyqooskXBRJH9Xid0h4OiCzueajQCr0bsdnlM?=
 =?us-ascii?Q?LFQ7ce4GA3U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ou++PQQU7cZhsMi5wZwTm+g5umsn3izeMGoQevrZhkm+BsfD4axP3mjJuZDt?=
 =?us-ascii?Q?3cO36+MPSXH+O9EQd9rITdXejiN3fbWkp/P55nqFotQZzaa0jbR+oGfP/zRP?=
 =?us-ascii?Q?Wxyb3rWXGTR3rutWSy2TLjQz+7pMTwUU0wgrEF7gYaUOcDbVflwz0fannvel?=
 =?us-ascii?Q?4sa6OUBy5U634QuHBtyg0Lag8+RmbxnH/pdiEROK5GWfVftvFy9htNsVF879?=
 =?us-ascii?Q?ODWotgFSm+FBuzqWqxcZmnjna93O1fsEN5ulqXTqqVKrzbS7Z+ZvyTQtRYna?=
 =?us-ascii?Q?MK2yCn/cGLkrdZTgi3l5u2LtYFZND5OUWbvUIMpbN6Ui3F8jPpw7OPAzJCUW?=
 =?us-ascii?Q?H9zaTzLmyOcPx3xM1ZPgXWRmnxK+guT7PxppKwYGYHYF5pDug4ffNec6mIwt?=
 =?us-ascii?Q?QnogGnl5DNYrXQ4y8tKLCtzzUzyGezgShGl4GLl0yf96Wrs6VsFmSI4RlfqA?=
 =?us-ascii?Q?Jc7DmVsS4l9EfLDAEsTLD6b8p5a9aipx3A3HZZCuKxunb90eJH+KcwYtAmO1?=
 =?us-ascii?Q?8B5sQp8FRbYzLKYEl8XgSD/BLuIBDdxpsMZ/A+25rlJAIqX67kjrtS6Bix6f?=
 =?us-ascii?Q?cspQF2dm4pVQB5/HosIg6AVqvQyoXdfe9lvLV7dv+1H4YtN+Dg91tCyZ6y5e?=
 =?us-ascii?Q?nE2g3w4P7hfoiEy8SkPtIz0dvBUmAWEpPvTjh8txMypOJuTRUnd0lHWGwpLi?=
 =?us-ascii?Q?MEq89evGHfeaFS81L2iYiQ94UYyQjOcQ1dOJ3y8Wv9fj0VZxurjotCxOHUqi?=
 =?us-ascii?Q?nhEFHItI8YAhfkseIw7iRLg9BihDKywqoDFUMliSL88skDnyfLZJOoQ8fCbj?=
 =?us-ascii?Q?XgTQFkUHcg1BtkZCXvcMSs7lhTwPDXCW8DIR0i9LDs22LZqa8aZqmwOXK8S9?=
 =?us-ascii?Q?QdzP45s1SwBA4JvecrZlgla1PED8kTIW7co1DwoISY/+pnkjUhDtDFncbp5A?=
 =?us-ascii?Q?V3k69WaI++KlvW6Yomq5hBpYK8+goshfFyYWxvAmAr205B99lblnDqxOGyxQ?=
 =?us-ascii?Q?zQUt1Nm1A+qldswdNJW3OmAo9F52eOC20Vh9ZZlor6c3cWIQa2GcX4tvMNOL?=
 =?us-ascii?Q?tMKDcc7H5S1XR6G/pw/QIdt82omWNbkzQjdjwE9HtWFWuJqFDATOW2jHL/T7?=
 =?us-ascii?Q?CgkpoesprmFC3fQXRZXotrX3TroOU337qhrKzw+DPmezh9OjQP5v8c0UcIBf?=
 =?us-ascii?Q?kDUTqxslaue5tuczDgDHP3UXfC15vmdqiJxiEqUTg9yyC6TelwbQ+3huG4kV?=
 =?us-ascii?Q?anqH5yJSdZaOuPUaIf7Ir4I2yY0XCWS2LjLHxxxO+r/K8ukOmFgcek18TnLx?=
 =?us-ascii?Q?bB38m1Z4XRm6Ra36u19/5bh63q6flJZb1/lynV8SEkgqYRrKBL97pnhe0rip?=
 =?us-ascii?Q?8Nak3X1aiC5djgZmg2r7Rs4K+nLwVjkRb85d4GXgnY+ek0V1wjmjhRv8NAfM?=
 =?us-ascii?Q?rHLO1zulqKKJSkJPJLREFxaxyiCL+Tn6pkm188RebXTT3ZohsfjLkoz5QpzF?=
 =?us-ascii?Q?T5ZTBzyTSZKELh+0z9mMDpqT9E8OeziUaePm3ffIEtyJ2J3GAplHmZHoUI80?=
 =?us-ascii?Q?Y423u4/bhnG6hVsRLoJfo2h68NOkpTO3Tda640oS?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd6da83-8b19-46da-3715-08dcc5c2e8a6
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 11:33:29.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IRa74sd6vrSWIpkCXS/lEh1OMoSnIYDaaJDv/S+zM/2W7rfUaxCfuBIYIhP2N67pcTmuOxCkSVSFHLteDCU1kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6466

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
v1->V2 no changes

Signed-off-by: Lei Liu <liulei.rjpt@vivo.com>
---
 drivers/tty/serial/owl-uart.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index ecec483d4d59..28c33cea6b41 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -680,18 +680,12 @@ static int owl_uart_probe(struct platform_device *pdev)
 	if (!owl_port)
 		return -ENOMEM;
 
-	owl_port->clk = devm_clk_get(&pdev->dev, NULL);
+	owl_port->clk = devm_clk_get_enabled(&pdev->dev, NULL);
 	if (IS_ERR(owl_port->clk)) {
 		dev_err(&pdev->dev, "could not get clk\n");
 		return PTR_ERR(owl_port->clk);
 	}
 
-	ret = clk_prepare_enable(owl_port->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "could not enable clk\n");
-		return ret;
-	}
-
 	owl_port->port.dev = &pdev->dev;
 	owl_port->port.line = pdev->id;
 	owl_port->port.type = PORT_OWL;
@@ -701,7 +695,6 @@ static int owl_uart_probe(struct platform_device *pdev)
 	owl_port->port.uartclk = clk_get_rate(owl_port->clk);
 	if (owl_port->port.uartclk == 0) {
 		dev_err(&pdev->dev, "clock rate is zero\n");
-		clk_disable_unprepare(owl_port->clk);
 		return -EINVAL;
 	}
 	owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
@@ -725,7 +718,6 @@ static void owl_uart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&owl_uart_driver, &owl_port->port);
 	owl_uart_ports[pdev->id] = NULL;
-	clk_disable_unprepare(owl_port->clk);
 }
 
 static struct platform_driver owl_uart_platform_driver = {
-- 
2.34.1

