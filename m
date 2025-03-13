Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012060.outbound.protection.outlook.com [52.101.71.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE971F4639;
	Thu, 13 Mar 2025 20:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741899543; cv=fail; b=I0Vw5RiW2F7lixBzTZKWv0vV98z0P9mTKJ1/B9YDht26CeAE35VVY4KrW33UZag6w+/IuALWseyFgRKS6LdUz02nen18eUeH50lWE0wT9zcCmIQm2Y5RUk5x5lU9CDqtMDrs52hx7MzmHWOMZmectQTckNgk0T25zxZ2ac0nagQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741899543; c=relaxed/simple;
	bh=htTbc61jBG0/DkwmQ6Gtzuqur817CnpwoKMH5+fFDhA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mCVfdmADm1zaLOAmKJA7SRdxUhHl+ZNff5VUy+wXEjOMBhuNFIUVjSNoc6zmFB4VgLA8Lqh0gPxKQmCArsOLo4JXM62+7RbuwARP9ddXHskIg+xiA1HI+epFnsWsZSqr8rXAPwmWwlaL0SDmxL5EcQVvx0+sQJbfM/dzS3/9T+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=aW0jar62; arc=fail smtp.client-ip=52.101.71.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="aW0jar62"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5JxcDAGPsJtAPEiP54ZXPUKWivr8pLS9U/ji4StBUdA4KAgKA9Ak+HX5BGxagykLGQ7Pfi32X9HluPQcY0zdXt4xcMxTW/hvLmjgNRSDnZNzfbw5QFWjfXpmeapTSI7EWa1YgV3XZEgAea5t2FXgdHD5P/8etOhZ60WLfY8Kr3wWBP6ptlLXYu6qVhEIlnZ+7cKVxDK2HmpLm2elpS2ydjzd4u5ZpxtBeVuJjG+fi2UnYK7eX+NYp5Elj8Q4b8pA3R9IJ8+oD/VK0hLUkEZCcYd/VG1cVuKJoRaPCr3jjp98OUhieFHKY+gbTQzQQL3icgjq5xlpvgY458QDydHWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pkc/whulUbIYxuaxJpMLhCiCEO5qY796WNXUCjLbU0k=;
 b=OlsUqGv29BJjynA41I7MBD/fve75VMpxmAocdCbaS9udb4vyOl9c9AdOlGLO51jg1jCHhbQscGvG9OqXBjsZOu9nK0G8TTFHC1ha2jLOadfpN5U/KZ9DbYDPYLQm+X9CtWI67/maZcFA2yIKBqwlpd2JGIzjGPPrNkY6OLmMUROKKh29jCAHJWgx5u9GDl3aMADzax2QmcaukIV5Hxd8VtVWsoUVRXg2e/KsYDXtZ0lTWyU1rxt9EXwmg+D4jIZdMSUGN8uJhqhYLtDrZlVzC9YwDu+Snppk2Vrg5mCcSqUo98YnRgbFMKixSop2FJq1ChTx/+7Jf2vx4fxduxcJ9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pkc/whulUbIYxuaxJpMLhCiCEO5qY796WNXUCjLbU0k=;
 b=aW0jar62oIAsWqtQq+YSkVN4tBOTwuyc/YKyShxUi/jN2h+RSEGE02/vz6/889+kdh4nYZcFQP2oCk2nzWeesUZHxgPYB8RUCw477xuSetfnwi6tkXL1ijVik8KgsGycpeiCULDaeQEHODTzmapAk7ETYkfd6SE/VGV6w5lAWVACBlPIxsjNeINvKQUnfY/6BgvKuJWgdl/pERQB/+r6LzqmAQEPcb3KKRBWn44kzxU6U7/0MPKdFjRvzT3kOCBazAyYv5EA48GDqXOwSv7GCIJ9ee3h5xFga7+ou0x02kRc3AtoZo/jSHgK/u6jwTOfZAK0Ya0AjC3uiNNSdcibjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17)
 by PA4PR07MB7101.eurprd07.prod.outlook.com (2603:10a6:102:d3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.27; Thu, 13 Mar
 2025 20:58:59 +0000
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415]) by GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 20:58:58 +0000
From: Elodie Decerle <elodie.decerle@nokia.com>
To: jacmet@sunsite.dk,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: elodie.decerle@nokia.com,
	jakub.lewalski@nokia.com,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tty: serial: uartlite: ensure uart driver is registered
Date: Thu, 13 Mar 2025 21:58:50 +0100
Message-ID: <20250313205852.2870-1-elodie.decerle@nokia.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0136.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:30::28) To GV1PR07MB9047.eurprd07.prod.outlook.com
 (2603:10a6:150:a5::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9047:EE_|PA4PR07MB7101:EE_
X-MS-Office365-Filtering-Correlation-Id: f7657ed4-15a9-4758-ff64-08dd6271dfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lT7xBO0+R63j0hJmOdk44EhJ1IzGcTbF7G2mi0fWHKGCJ2Pu9HL7q0k5Gf9L?=
 =?us-ascii?Q?stCqJbsCThwerEE78ILCudkHBlKHRiUBha6La+W7MQmXTT10zJcNicf0AQuV?=
 =?us-ascii?Q?4hxTdWJvtPetEdZhHnMAtLCmAwnKVVny9yNx9vpbFzvB/ANVnooEOHIm6yaX?=
 =?us-ascii?Q?o0BgaHEOMKfLTUyI+pA5RTV244j9eafOLMW5/Wf3AUlLJZy6Q2OXarzk6tPE?=
 =?us-ascii?Q?tRMSmmfrfpik3+mBw0aiJoGbO21dhl8EGCemLB9PjCxf4YoXlp2Ew0KCJ8OB?=
 =?us-ascii?Q?nzCCFeu28uENLCJLn/7BW8nUBXZ2go6IOjPt/dvIzFb7C+6v1EEEveuAfiH0?=
 =?us-ascii?Q?8OKmx5vNsE1u+hM7lG4JqiBU25VP3pgED3Q0IaAedL7MxIr30nZ2rJEtPdH2?=
 =?us-ascii?Q?dGq4rEfb+sN+nSKuqgRKf0++xMcr2c5dYK0rxSgRSFwx/fmKyDY5XHb7RWrW?=
 =?us-ascii?Q?iDGYXpzOv/vTdiyYK8gAzD3vVchpP4aBgwPicQXfr04LxC/UfTlQaYVGanS1?=
 =?us-ascii?Q?VhpH9S63VV1Wx57MQFRxCNIbKgMAOVvEfdBuBuQdPyzBhbHrEOq+Dn+pAY3U?=
 =?us-ascii?Q?cvcJ9WezuamNYoLENlcm/w3JvRCxYMJRBuDJg7YqOuQfwclonFmNLKCZjB9q?=
 =?us-ascii?Q?POr4yql07C52e1BiR+FaFRAkoDKYiHavytqgh8g7FF6VOsUd9H/7n0xu0VlS?=
 =?us-ascii?Q?Du3rWLfVxAbbDI4jXVxI0/uXvUuGMcZITJtAEYqWzbVgGtI028WWQ+XDFFL2?=
 =?us-ascii?Q?bnG6WcgMMlglY616Id2vTDGW0pmTsd83i/Mg5VvtX8uhyjf3eqizmM3VdqyU?=
 =?us-ascii?Q?o0WyVEQDcW1XamDIsHp7uh5VsWE3Edc/4kg9a3ALp2EvNC8z4a/QnJZsDTJI?=
 =?us-ascii?Q?UX5i99WylRObsqc4GYcRFiDIiEvRyaRDRpl4A8nnv51nzWG9R3OSw5T3rwtS?=
 =?us-ascii?Q?C8Yi6XeFJ66SEH2GJ0jrhH+vE/KSr/+XIywZDlYS7kUtUQ05ItdTFD0VtM7l?=
 =?us-ascii?Q?8AF7DcwDmJgEn4XK4MzeQaeKS1xjcaUbBPf23jvz42Ux0Fc2OgDdK3d3EQj4?=
 =?us-ascii?Q?KD9CgyG6izDg+9Nvbo+sdE3OiYxL15771IPpwYka+mSJu3dzSaCoT5S0mVg9?=
 =?us-ascii?Q?H/ZTNWY0ORzjWQ70aORSD0bxw/I04Qe8lkjLbOCW/+Jfoc20MStjzhL7W9/K?=
 =?us-ascii?Q?IRl8REw41l+kemQstVhOJ8lFi2JtQchaTqDvxyNj140vJc1iwKvlpxXYEhx1?=
 =?us-ascii?Q?MRHOIPPAfoVyDf1LhtI1uNuITA5fH3P4d1mG/KGkpqIGY1EQBBnosFtVuyDG?=
 =?us-ascii?Q?hJIkzdrHfMx+VE8d1Mi5JHtWmyXm33Xc4ze9xEOm2DhzYVfbgxXWLtpWT1pl?=
 =?us-ascii?Q?ugSNECxQONoqE2andbzpMF0OrO2q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR07MB9047.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+hvJFSk6ecwfaDIdCaSObRH1lP3iAeG+u/gx7IE9RYiISmmckB2PMI77/T4?=
 =?us-ascii?Q?TMAwIoRd+6LldYSugrGgM6RG/BDkKWD1f5SZ7lflrhQZahJSYPHEw3Kr6MJM?=
 =?us-ascii?Q?8NEKcEOITp2STEmMD3cNtjWbVSr7uqsC0FPydYCIPY4km+PJqBoTgUO/RYbZ?=
 =?us-ascii?Q?HPYSz2egYE956CxNxCPVTFIqPB1DHDjyiW1tQper1odMZO3JcmJQNcKW+8X8?=
 =?us-ascii?Q?ImduOVJ/3XqxpZ0WvBgE6YUPtCWe8XaAeL2GN883Sx4qq4oD65n3tfc3xwAN?=
 =?us-ascii?Q?qfx+h1THi8EwkAyrktUxeA4pRJe4T5JfNRaIKyOvgRG2RyQr+G/B9HH9rUG3?=
 =?us-ascii?Q?TQkboA5kZmcal6UFoQBb0b8vJoOuCfmIBFbaUL1Cz6QlorG3RXPGYOdOUJor?=
 =?us-ascii?Q?1yFh5go0Axn2WajAvEhfHacHjzRj/q16pf+vG6liQ5LFjhw0RWMccJ/RSp2d?=
 =?us-ascii?Q?2DJ66MxtPyEb1FFa3aUDTMr/ye/Bn+9ccnQ4XoXr0oxTBJHxYagM4Am7aGwp?=
 =?us-ascii?Q?XU5s4VaAT6T1w0Rkp4WfSDqXATT9dSJRW+rQOgvVqwwUX6LpC+mcO5KuQX5l?=
 =?us-ascii?Q?YQbD9oy2k0AbFhNhSEY2IaC7Pk6k7oWhku171IwDlegDqskCW0Gzz7inEsmd?=
 =?us-ascii?Q?Kg9de4JZTvdEtGh2Hqt/RQgxcxx/kIhSpeH54tNqPBWIVrlg9jpUMEYh1eSl?=
 =?us-ascii?Q?uaxQfTIIfGGYTGrPXOmROG6jm+Hrxx12NqjZxopfLHoWqF4npwzNwIlG0HDS?=
 =?us-ascii?Q?P573e7RuHvqKA7UQC/PoPVy6iULUxGXXMZZNPi4k1sekNdzzMA00vgADHxpY?=
 =?us-ascii?Q?CM/JsLhxhRUi6nTzfbDKde0cEj789HtvIsdSvL/GHVQRMLFjMYPggJH+BB2q?=
 =?us-ascii?Q?Wn+/fsByNIGikh9rFrgZx6JAyBMEDk+vNxeDt5HaoggP9GrciPRH16KLpplH?=
 =?us-ascii?Q?ThN3C9X5umwbb6oVTeee04cycnIUzP2x92VMeC/JuBQhQKdtyGVFCpManEK5?=
 =?us-ascii?Q?YkJhZrSErBMggXhW5M5IS8Y4l5ZD290EsoNcEnnHw+p5yEg/KjP4aTmjGW4k?=
 =?us-ascii?Q?tWhxu2uW30Kbak6CwjHX4U/o4UtDFfE1Xhsd+uqg2AsKTs5aKfaqkdnqDPzo?=
 =?us-ascii?Q?rhMXqBLpJ0TlNaJBPdTEaeHMWqp6f3LdoaTtZhOS1WUr0kOCMlUsIzpK7RqN?=
 =?us-ascii?Q?waWfTUOx9/a03hZeFZuobx/cPJFEbhBkwxBecdEDDFbg3WZFoN0eOzWtxlnF?=
 =?us-ascii?Q?5dGhW7+QbQHqI5z4PMipLG6wqJwIh1rfjZ2QqKzEf805nEghBx1TEEtOwqIH?=
 =?us-ascii?Q?r4ybNbnriyMDZOYloiadcICtM5pMXmtXGsDtZY04eV3DAk5rUVRVoSLLDmnD?=
 =?us-ascii?Q?wkSRbR+4lLXzw3xWaDfzTSTJ8TP2VNKhlHYZ/y8pYck5b6/j4CHqi8SVjpQK?=
 =?us-ascii?Q?WtJQapKtEZSSOdz5QQ6YVbb4e7wlwFNRSRlYG/cUhxolqMZMf0MzU34hTMg7?=
 =?us-ascii?Q?kGiWxh+LJSn7tZ/DW/6Bmh9GAQWTiqJygheNdTJpEJUe+ri4nHNTSrKgZQ9d?=
 =?us-ascii?Q?4piakE/6hLsdMOTsDlyjwRSVjhe4hM2f1frqIu2YTYfnLT0453PL07PCfGPm?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7657ed4-15a9-4758-ff64-08dd6271dfab
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9047.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 20:58:58.1554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK9rMMngFqufdN5fK7mLJYffoFozraJyIh5kklG30z3l/wVwAQXFxe62HOqMLY0iSsSnID65xVL7BKUvBSC9w5lTPeu54vBQ5pAPkXLqa7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7101

When two instances of uart devices are probing, a concurrency race can
occur. If one thread calls uart_register_driver function, which first
allocates and assigns memory to 'uart_state' member of uart_driver
structure, the other instance can bypass uart driver registration and
call ulite_assign. This calls uart_add_one_port, which expects the uart
driver to be fully initialized. This leads to a kernel panic due to a
null pointer dereference:

[    8.143581] BUG: kernel NULL pointer dereference, address: 00000000000002b8
[    8.156982] #PF: supervisor write access in kernel mode
[    8.156984] #PF: error_code(0x0002) - not-present page
[    8.156986] PGD 0 P4D 0
...
[    8.180668] RIP: 0010:mutex_lock+0x19/0x30
[    8.188624] Call Trace:
[    8.188629]  ? __die_body.cold+0x1a/0x1f
[    8.195260]  ? page_fault_oops+0x15c/0x290
[    8.209183]  ? __irq_resolve_mapping+0x47/0x80
[    8.209187]  ? exc_page_fault+0x64/0x140
[    8.209190]  ? asm_exc_page_fault+0x22/0x30
[    8.209196]  ? mutex_lock+0x19/0x30
[    8.223116]  uart_add_one_port+0x60/0x440
[    8.223122]  ? proc_tty_register_driver+0x43/0x50
[    8.223126]  ? tty_register_driver+0x1ca/0x1e0
[    8.246250]  ulite_probe+0x357/0x4b0 [uartlite]

Adding a mutex lock around the uart_register_driver call in the probe
function prevents this race condition and ensures that the uart driver
structure is fully initialized and registered before it is used.

Signed-off-by: Elodie Decerle <elodie.decerle@nokia.com>
Reviewed-by: Jakub Lewalski <jakub.lewalski@nokia.com>
---
 drivers/tty/serial/uartlite.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index a41e7fc373b7..460eb2032efa 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -23,6 +23,8 @@
 #include <linux/clk.h>
 #include <linux/pm_runtime.h>
 
+static DEFINE_MUTEX(uart_driver_register_lock);
+
 #define ULITE_NAME		"ttyUL"
 #if CONFIG_SERIAL_UARTLITE_NR_UARTS > 4
 #define ULITE_MAJOR             0       /* use dynamic node allocation */
@@ -880,6 +882,8 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
+	mutex_lock(&uart_driver_register_lock);
+
 	if (!ulite_uart_driver.state) {
 		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
 		ret = uart_register_driver(&ulite_uart_driver);
@@ -890,6 +894,8 @@ static int ulite_probe(struct platform_device *pdev)
 		}
 	}
 
+	mutex_unlock(&uart_driver_register_lock);
+
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-- 
2.43.0

