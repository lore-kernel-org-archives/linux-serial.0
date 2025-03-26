Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2073.outbound.protection.outlook.com [40.107.105.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FCE8C1F;
	Wed, 26 Mar 2025 10:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742983577; cv=fail; b=ZSsJzYumZllX2N5SqfjEHspYRH300PcOCnx4sXcZ+rryndm9AzZZt8mUXrw4XAezNwAUlP8z8FgNZd46SKAsa+Rq6e+SBR1XcPcLcfqRDD5WpXCSfRBJJBDGLAMrJy1f4RkT718/MiMkBGFwkfmexryAeqWqCSDmKJfVb+c7Yaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742983577; c=relaxed/simple;
	bh=UnZByTWjgis0OxNdA7EHW09DE5OhDcz6o4ugIc1peH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RGUtIZuKNVFupt3OmOZrsZGGJPxshk33oItwRsdMjKOHcjmIKMhlftrNWm+RXx5Ja6u+iBCuw9h3P0qYxZl4cK90BH0FyhISlsMpBlyEH37orQnLBc5nV8BWQyuAWsxrXNdo3zD49Yfja5NRU9xr0X9X1loSVzWVmbAoaB1mYRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=BQ6YdrPE; arc=fail smtp.client-ip=40.107.105.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="BQ6YdrPE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N0iywftITlhfyVWQG1Zx8IR3e408RlOtuMtBEcY1yn23RVjwckHUWLvBldjuvC1GnFiGuXlEudo5TYNJk7b/hTadh1AQ4cI0xr4coeLnIiiC7bS61JvXZPaugl/ICHgucB4C0mco+u7JriYAzHK0CW0p7blpBv67vEeE3/vtTRDakfVP6Iez4ofUFdge21CqcacSgeszwrtFheJjBTd4IUk/+x3P8DyUBscXgqmhlS0XfT77/vrGufsOPSYeFAA85xGgUbSafnqdRe5To3xB5p41PzqlOCz6Q5rCB/msv5RsI2t+oBuNx/gZCBE0PCdka2GA+jQc8Ji/uRcZu315YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MpTqr+de0QR6b0ihc0lZo+0FaQO/L0ydNP8pl/IdvE4=;
 b=I+No6uPALol94ZyA0bnDB9cwQSKceQEwyqj3KakCClHQmZJX26Hc9JTdhiW+eJCjtbF4Q8JtGv2yfpLjLnjsVL8WN0YSkQ9NE+LKu4xDaUDd7eqDR0AjomMPqKEyFQMt5S6KicrLPbEI+2vm6vOXjYvSyHKXzSUiHzmEXKSx/l88aQFEG2sTGIZfmvnxgPx1CTvnusj46rZK7Hrbzgw09rlqZExA9kKJyKT3gga2KPnjvpuV57CLB6z+Z8rqDEnLwehhw3AlPAXohBGmlInLxrdhD/zEZIxWcVkJDipKiC7O8elKwStphKCN6t0xOwvY7GdKP9kr5eBLybL/+hbCNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MpTqr+de0QR6b0ihc0lZo+0FaQO/L0ydNP8pl/IdvE4=;
 b=BQ6YdrPEV4QUzQ5s9VKFCgnpa80Bh8B/3+aigJzOdEgZzMBmoIPiZnGILprrhq94PhT++3sBb+Aedz+S3T+xUBmmR+/26sXXn+nkDYRo8A/MqLEwx57lGK/J9/Vc8aR38ZtCYIBuDN7TgOyFutSiFivcbWIY7oM/z06zRbXk5iMGzGL1dhiC5m9hbvnbOE7pyEePP1qPMEbDX5JT3rd63T6kNMYacGDGtOlrD5vIo6rc9zar7sFQQzVWDgFVCXwJy2yMJ30Tp8evFM5Oahn+PkXbc8UiuUQpMMJ6S3Od13AuounIn1SgAfFPQ7zKdHDXwS6uvg4YuPliaX3RghJhow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17)
 by DB9PR07MB8451.eurprd07.prod.outlook.com (2603:10a6:10:36d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Wed, 26 Mar
 2025 10:06:12 +0000
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415]) by GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415%4]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 10:06:12 +0000
From: Elodie Decerle <elodie.decerle@nokia.com>
To: jacmet@sunsite.dk,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jakub.lewalski@nokia.com,
	elodie.decerle@nokia.com
Subject: [PATCH v2] tty: serial: uartlite: register uart driver in init
Date: Wed, 26 Mar 2025 11:04:57 +0100
Message-ID: <20250326100504.1246-1-elodie.decerle@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313205852.2870-1-elodie.decerle@nokia.com>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0201.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::15) To GV1PR07MB9047.eurprd07.prod.outlook.com
 (2603:10a6:150:a5::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9047:EE_|DB9PR07MB8451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a7d9e5a-1aa5-4a47-21a5-08dd6c4dd62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8hLyHz8nDGu7Yf5Xt8KCDFBjzqjgX8EARD0L/L+RDiFkDKdXYidPLtZ/gHk2?=
 =?us-ascii?Q?nd+6Z5MpfL1kDZSSpg9i9NZZf5wyrrZcWtfZXYZ8bsDWVmLvL/SWaJCknHF8?=
 =?us-ascii?Q?pwNVSJF4YBCUIbsSYePsQl8/7k0EBAGpVyFKhBKWd6oZ9iKYydM8iy6+2QYr?=
 =?us-ascii?Q?UeABUmWVzW2xVlqXlpdi0U5KCpKOPjCrF1kLGaLIv0O7m24A7cfUBtIMsPqB?=
 =?us-ascii?Q?b/r8g9/IGfs3dzIUScqN7XcFJyF1yiJGBVdRkWVw43iY4+DJx+IhEZWKNikC?=
 =?us-ascii?Q?MSuMLwFjU/ci0jM8mIm5DrFOK5vnMyt6GmaOkg/bwZWaZfdcAgkFwhmgsKMJ?=
 =?us-ascii?Q?cKapyqgtfbqJWlwzJIIRIgRobxQ48V6INq5f+zfYa9j1mBV+7Q8QhGeYG1xr?=
 =?us-ascii?Q?vkRRtiCZDfTJB8uBfwmNki2eb1yk+acMF5fNS8B0rhGmMPXSfBOM1EgjXZkg?=
 =?us-ascii?Q?lNCATZ2wGbD/wyd1KuOM/3+2rrZNhpPKXAFc993u9rL8WY3bPIqJCg4WyEGu?=
 =?us-ascii?Q?lfFXReBsdLQVztu+oNUHRZfmlZkQEZETuRxSuxhM9/5xWp8TTT2GoBuQBsG1?=
 =?us-ascii?Q?We06gsexXsuBw8uoDugJvJJwObFaL9d7GjHH9aw+gMzgbYiw7h7tdd47ktx3?=
 =?us-ascii?Q?mp1ttW4UbDqmqv6j6Bkq3eOjjfiDMEKboGyIQdyn6DnYfoDtKqLEvRHzWIN3?=
 =?us-ascii?Q?ZqwSeM0oWlj2x8yLYilOk1NLBcxjupDc1WZaUGMjMFKcjeF0bqGzNCgZ+0pn?=
 =?us-ascii?Q?66bx876Zl4S+WJl/N/UNb9hQ8+2ZVI9A71HQLPvCyvfZjxAOQFu2LqUGke5q?=
 =?us-ascii?Q?TKxpOdrYHWaHFHUcCVad/N0QUOgJWmp4v09e4k2SIt5WQjV0hhcXUBMuJdjK?=
 =?us-ascii?Q?iuGa8tbGzC49++A++RR0yS4+RbbkGACDEQt+j5gwbK3y1AZwvCJ72o0C71ba?=
 =?us-ascii?Q?+KtZddGorvq7PQHhZ8MkehEbyviD849G/3XHzYS0JlHO9Fi+FO5RXA+aaIv9?=
 =?us-ascii?Q?Z71lE2jZ5eKZWnBKaDr+UVVuw4LZBGo25sh6tXfRlAaHkLkMUiOjlhwHnWqG?=
 =?us-ascii?Q?nOCpC2nirjZ3QBh4oenUZcNUJjglH1LYIhAOZbVVEIs91lqIpIxi9EmKgV0k?=
 =?us-ascii?Q?K8y41TL9jGNOiesQBMPETe5CjjtOoB6eAKyflszMJjdj9tn/d+0YqG/XQ9hx?=
 =?us-ascii?Q?lmyjnGlz/E772655kopBGtsDPttpDoa8bKJVlXnZQkkjvA5EGEjloEztNRlx?=
 =?us-ascii?Q?x+ex3lntc/xvcjyB7I/NKb1lLIgWOz3IdwA5y5j1Ci+j+8BbT0TvPF4nhhLi?=
 =?us-ascii?Q?uNoc4uDRz+UtxOdpSJ3w7xmA4B30YWZsRTey3DHZOQQ5QOHs4gSugV/+w4Pk?=
 =?us-ascii?Q?XXZBgRVLAG/znODIH6H6GxSn7bL1ZYx/rx4K8JlkQMFbHzKlrGl1bv7uYTh9?=
 =?us-ascii?Q?VhqgmtBiy1c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR07MB9047.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2qqmW6RrNblYp1kwqTCv8d1L0EnecmiGQ43CeniibsTdLo+gkfltQjUNXQbk?=
 =?us-ascii?Q?NEyX5na/lTzjwu5+O1AIw9WTPEMnacSu6N21GEIidsVDTtFMM9MH6yKfd/jU?=
 =?us-ascii?Q?Xrg8/Uk/4H3Se1NlUvrFscwpsMXYlkTbdEgEaD0QO2GFCdtVtXABPz47IYBL?=
 =?us-ascii?Q?8x6L1LSbCOiiDWeBP0cvrDIkRecrdJo4A6xqD7BLeh42aLMsqzLszcNRGRFq?=
 =?us-ascii?Q?96Dj/yjEdNlCp1mI5sFR5S4NcgUSDd+8nJqRRBSGEHcIIKTQw/ANfhXOpCUC?=
 =?us-ascii?Q?YHDCCXI+RDyc1/GAapMjBc/HZ7ORqU6IMJTE7/PV4UyRtzK4VKcAhDn02xrW?=
 =?us-ascii?Q?G+Ezd3LwCIRWrh8IeEz4iUFO90o+Hm5lLVwlhRYBXwPb+CtVZqWRbl8h9jr0?=
 =?us-ascii?Q?p3nqLr6tUtnHf1KXyAc82Vnz8Gzs3rH7guBErYLqm+ASVW8hxBNcvWmk/VAI?=
 =?us-ascii?Q?IHIK5Guerqmdyu73djz2eUeNBvZaiO6dg4zcLM0xfqj+oNtr0KCkQncAR18X?=
 =?us-ascii?Q?RdhtRLZQWE7NBSqxWWsv0kJjioKb5AjQmorQwcN2UMyZa2htYIRjaQYPWn0F?=
 =?us-ascii?Q?S8kuPs3WZjpm898lmKlc3SPjQ/93CrYeEJeXB9JpoF3bPj4OsUsMO85nduZ5?=
 =?us-ascii?Q?yBW2cg6RmQ97/2iN5IeIAtQyiDRBjhcSIeKQZK0827GjkLdnzykMURmOuP9V?=
 =?us-ascii?Q?NJ/6Wz+xb/Z7Bw7xzGSFtYp+pEL4coewPBWFcPwM9uejTwMQhB0v8d7qrZ4+?=
 =?us-ascii?Q?Aq1fBviW5CWcd0OyBtPY/1ziMFJiM8G+lm2Ch/ZTqRp+gzrsbEeVqyyx5fVN?=
 =?us-ascii?Q?Vu9OZDI9jCwXKavFDrvkVn3/KiJGVNMSyxNTGDFo9xZ0CgUNO1vfQSL2L90r?=
 =?us-ascii?Q?DrakAFlRRq9cvCdJVWO2LVIeD6Mlz0IUoZ/MyZFa9FtXVQsQfZWfwJUaciFE?=
 =?us-ascii?Q?xzadu4IpLg0cDKH9AaaxZLpqI4kdrYOmyNpKSUFPg4VrprljfmmWq3ZYnM2I?=
 =?us-ascii?Q?FFButjWaiDTnPVdjlbQk2rB7jRkrfEVlL0NYCZrr5ZgF7PdDEX5yLhizPiFS?=
 =?us-ascii?Q?f5egpTZlevoAzdk2vt64UrwJ9QHwGg6vjZlvQJiDMLZ0tgIa4JWL/N+WLQuy?=
 =?us-ascii?Q?dPS4GoPvZhgn0BUgzSJSzEFf/vul1IQfhyCvegwUz0APkLpEPk+gxMq1OCzB?=
 =?us-ascii?Q?9ZmZipVBe+1IQvEqUdxX4uOLVPq0TR8nVanu6rSVFbrm5hHrlPqA4LftXp88?=
 =?us-ascii?Q?B/lwecWBxOUC4llEplWBylEUzapMvjK8OwAX5vUXYBrWcpHvrLlXD8wGoFov?=
 =?us-ascii?Q?tVlJtlPq0Q7z/Uv78HwqXOGVd3JdYb4SwU3lBFTBVSzVp1+GA8BnKYBsM1Mx?=
 =?us-ascii?Q?h5/DgRFUpPH6v5IoWTE1SkHbehMGV80gG6wq18T31oLXKMMV/FNoC+ngKhss?=
 =?us-ascii?Q?tZFIXHzMFH47xSLWog+Im12D0Um1FyoWAUNzKThH1++JTltlGJtnV0iuqiek?=
 =?us-ascii?Q?PXCqe4byEIge3vQGbUIhEQXhrKHxYP0MEyduMrOdRTjXNsw0h8AUPv37oCfU?=
 =?us-ascii?Q?Rs+W5tOTgvBcy5YsGJ8SmZi/nHzLy9XYI1cJH7cu6MZk01fb6n6Pw+lA9jUC?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a7d9e5a-1aa5-4a47-21a5-08dd6c4dd62f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9047.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 10:06:12.0716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRglhCtZO6vpZFR6nI8IrYhFYXrZks1Xe1nxKOWW7oES32N9F9w0LSQuRJwRybvGjPGqDPyLi8WzAXV3nh5gC710Dn4FHJ1i6ux3tFDXLTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8451

From: Jakub Lewalski <jakub.lewalski@nokia.com>

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

To prevent it, move uart driver registration in to init function. This
will ensure that uart_driver is always registered when probe function
is called.

Signed-off-by: Jakub Lewalski <jakub.lewalski@nokia.com>
Tested-by: Elodie Decerle <elodie.decerle@nokia.com>

Changes since v1:
- Remove mutex lock in uart_register_driver
- Move uart driver registration to init function (Greg's feedback)
---
 drivers/tty/serial/uartlite.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index a41e7fc373b7..39c1fd1ff9ce 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -880,16 +880,6 @@ static int ulite_probe(struct platform_device *pdev)
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	if (!ulite_uart_driver.state) {
-		dev_dbg(&pdev->dev, "uartlite: calling uart_register_driver()\n");
-		ret = uart_register_driver(&ulite_uart_driver);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to register driver\n");
-			clk_disable_unprepare(pdata->clk);
-			return ret;
-		}
-	}
-
 	ret = ulite_assign(&pdev->dev, id, res->start, irq, pdata);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
@@ -929,16 +919,25 @@ static struct platform_driver ulite_platform_driver = {
 
 static int __init ulite_init(void)
 {
+	int ret;
+
+	pr_debug("uartlite: calling uart_register_driver()\n");
+	ret = uart_register_driver(&ulite_uart_driver);
+	if (ret)
+		return ret;
 
 	pr_debug("uartlite: calling platform_driver_register()\n");
-	return platform_driver_register(&ulite_platform_driver);
+	ret = platform_driver_register(&ulite_platform_driver);
+	if (ret)
+		uart_unregister_driver(&ulite_uart_driver);
+
+	return ret;
 }
 
 static void __exit ulite_exit(void)
 {
 	platform_driver_unregister(&ulite_platform_driver);
-	if (ulite_uart_driver.state)
-		uart_unregister_driver(&ulite_uart_driver);
+	uart_unregister_driver(&ulite_uart_driver);
 }
 
 module_init(ulite_init);
-- 
2.43.0

