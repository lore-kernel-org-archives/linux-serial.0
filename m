Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011040.outbound.protection.outlook.com [52.101.65.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A821171F;
	Mon, 31 Mar 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743437279; cv=fail; b=m7yzSKffCV4fu1UFxK8ya3EEeLe1fFT0KesQWL+lotCq4vYywpcVXfZxgWe9mzx6WA4Djx78/yPUQJCJ297snotLAo7kIsP9GLswJt2w6YzyJmqn9lZZ2cJ4usdnu0o+iJzwH+m5af8k0LQ7MYuj8ockdcI9S3e2M4aATpiqC8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743437279; c=relaxed/simple;
	bh=hznQfM3BEgslSsgwUw55Wp9l59stwRlQvMKjmxWjg0k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ElTgJmtRq/jnh5zRwvu8WokMTLs40eVzFRD/Rucn5JZOkC27WN/IHK4MdlSWslaNPjvsL1LutZ1T0hsfNEfUqO2DaegeZDvxIJFeFbQcMiwYasUjtgGkhhOGlV85YMOCTrhHGwUx2K2bodJdkpRXguXSCdVTYmKxXLa0XbMLbX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=nbiCcKR7; arc=fail smtp.client-ip=52.101.65.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="nbiCcKR7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xaek0jGzoMPDsK8WLz8C18yK9i7IUUiZD+XltAXhjXU4LTK6u0TwyZsz8sHwqVnJ1OrA7nGqyNnwNzFwZdM4kxMB0wYHqgVEJR5X9YoNrv+HCF03VEFaZmA1iUIXeTFcRSlPykOJMwFCjhOXbVpZWJ1SMeaJGlvdlghV9M57Op8b2GAYBKu8/f0eRTUoijvoT+OvmuEtLHzzHUj/azJlrrl60JJ5Zq00YCNEa0Tzh84Lo/sXgT6YsUrR/TDQsQhVqp9dRmX9HLjWwQGaBitmUlaVNsMDlou2o/RKEYZLz1vb3ukmrsrxh9BkyLR7KQAq+wskGlS1t7HF7mm8GyJitg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQos9vfnuEa/46CO4f+hzZkPm6qmVrdvWrEmYYgXrPM=;
 b=MsO/9OZL4Gan0g765yrlC//AM0XSZFA22BlsVSgCYvSsp/1WEIsOvebA+DKE5iLb0Z4Y4CkxU/g7Hus9x/g05MuiZfQOEGuF7rshE9CZvudTuIR1OURuQuzIGvIxQj+4JTGdbNA0nRk5ozGb8QrakAG76qE8vBlioMU/kFgdMj1EjL9ksimwL68znq8uD8H2wolpziXDd8qeU6DYkchNo+vlp3GUMJhAR/+T2wXrHT33fKR6SoZAmBf33WWQHsQgbh3/TKN2IH5A53Fr1h8bYVLOK6PltrhNHpWoznyuuuL7XC2ePEx2EE4qUWP2zGdvjM1ZWaLRX+xB8cIhcqRr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQos9vfnuEa/46CO4f+hzZkPm6qmVrdvWrEmYYgXrPM=;
 b=nbiCcKR7PxiIIzjweVcGIs1dqfudZ9psrFJXUclsLsoGwNb0DWVT6iXhujjgQEaNDjkRYvnkQpq4H+2yvYXCLpTR1a1rtn3qHa90RLhIo+iQG+Kh4qXs1aln6yVgUkSqHrmQMK6A31DEKr2vQFvUNr9wd4aR3gVRq9QKoBuRTU+e4sNaEAgQmlpxkReNuV3Lubpt4TjBZDhjjQFSjfPj5QgAC/evfMXkFsWhbYHClPdtuvP7dgcMbLwH0dI8VrUEFLWewhi0/ldnGZuFz+1TBZpcVhA09gCwByBqSVeFc4a5Wmf14vkShFr/Om0m4Df45NIpiRvAcIHkl8Jf/wk7HQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17)
 by AS8PR07MB7349.eurprd07.prod.outlook.com (2603:10a6:20b:2ab::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.38; Mon, 31 Mar
 2025 16:07:53 +0000
Received: from GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415]) by GV1PR07MB9047.eurprd07.prod.outlook.com
 ([fe80::9d20:3826:e457:8415%4]) with mapi id 15.20.8583.030; Mon, 31 Mar 2025
 16:07:52 +0000
From: Elodie Decerle <elodie.decerle@nokia.com>
To: jacmet@sunsite.dk,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Lewalski <jakub.lewalski@nokia.com>
Subject: [PATCH v3] tty: serial: uartlite: register uart driver in init
Date: Mon, 31 Mar 2025 18:06:19 +0200
Message-ID: <20250331160732.2042-1-elodie.decerle@nokia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250313205852.2870-1-elodie.decerle@nokia.com>
References: <20250313205852.2870-1-elodie.decerle@nokia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0026.FRAP264.PROD.OUTLOOK.COM (2603:10a6:500::14)
 To GV1PR07MB9047.eurprd07.prod.outlook.com (2603:10a6:150:a5::17)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR07MB9047:EE_|AS8PR07MB7349:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fb03a3-9dc0-4dc0-f580-08dd706e3080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oJ/dqLEtOiHQIHHPPwJiUkHvKx9FA2KQFQaLDACzULEPzmgS+pSWTD3kCkg5?=
 =?us-ascii?Q?dw3gIqbP3l5tHtEnr8puiGEiAyRL4gNoOz+PqBlEa02KNFms+viXrHa70diO?=
 =?us-ascii?Q?gcSN0CTt1ZAUBT0iQi9PN+mahr2zOwSdhcmC8OdnU+TC2DxpkQtSZf7pK214?=
 =?us-ascii?Q?hVk8UF/boeicTWPN9u2ZFAkSv8GwU5hb6p2UCw8NTYlmINUcee2DShGXCeZt?=
 =?us-ascii?Q?vzFLzBnAbhZ8QXbgPdmaja1yZ9uo/8lYQTVu6BHTB/t0KN2DU9tIJSZAu+s5?=
 =?us-ascii?Q?Yb8G9uxUXNBnI67WE/PhKh84trWx1sWO6eBTcc+fYTTsY7f/E9GbytgJUrfH?=
 =?us-ascii?Q?UuLIkmGi4i4humsdzE3I0yUHOQC0TDmlEcJOnSheTTebqfdPsMHsAuaKHgP6?=
 =?us-ascii?Q?KUnWFCr/xcBUQkmOdZPoJLu6Q+iHQvRP3aQ0OIRW2eN2jdL6d17suJja/TAv?=
 =?us-ascii?Q?yL/b2nqVESr2SCXdNIHrD+wzHcthkotGp3M+7mJ6ssPKZEk1D0xmKXV1sOhB?=
 =?us-ascii?Q?rf1Rfi5Cf2P+KcIVR0/Gc18vxGzJmAFUihk3d0qVnJgt2v2jgZjVjOKQlHgX?=
 =?us-ascii?Q?8kuGuQFKsVQF/xiD9xcnqtaBg+9N1obtOtCwR+1Iprd45a/2DNjqYPxVOC6Q?=
 =?us-ascii?Q?6OCiqYPF1mLlNuM+zKEb/yiVGwiNp9ZszLUNg7Vz/8ywUrKMU+DZO1UfCAg9?=
 =?us-ascii?Q?ty4nMejewAH1EqF7X6JtL869IXYR2K7dp2+1VI118cCILVmRVeP1iNJCG50z?=
 =?us-ascii?Q?QQzQMguW9E/hv1YOC2/6JjzoUxv1aQc18MP+pg+ygFLlCQtgeyhNUQGn6i6y?=
 =?us-ascii?Q?+6hHNJpSG0kYf9Qw8EDva3AdqG2jSxmAAanbmUyO+hVQHADdWVNgyPRuJW4w?=
 =?us-ascii?Q?HD0ZdMQKIMlz56xd+QEhxH0Qgh4gmrneLAY6SPKb7ROQ2V9kZOYoH4/xqHH+?=
 =?us-ascii?Q?Yq7vzv/dGFYI238XtUpzT0ODrBZginG67mOPVDpd9VTS+4GAVTC94rjHFsG6?=
 =?us-ascii?Q?dnoPAL0ZxiNLCQjXbK+SAycAwfNCUpVIThPa2ImbtmO9+UzoKeKIvBKdYkEG?=
 =?us-ascii?Q?5HIoUYqXhRn7Vm9qxL0+FgrdSPhMm4Ny/AtZ+c5Nzmd82NEhmCtQpvkBB1oi?=
 =?us-ascii?Q?TekK7Kf5NCKUWnNTjRtu4Ud+D34cuG+Wb6HkLrMcR28XdsDcirujmGYCXpwv?=
 =?us-ascii?Q?ULT38h1qXhTKkr0wk1A+XnLMNzXCz+r0UaKkxZ+lgbxeenmXkfjrSrIiTQyI?=
 =?us-ascii?Q?LogkSIarFfAkiSIrQtJhEaGR6Uh34LePKs4wOmD/yU6tiXZTlEiuBh4a6x4J?=
 =?us-ascii?Q?7lJx1ZiMSOVEmwOQtA8F3ABa9rAmKVek9HFLSXX8jY0boeFV6CZTkGMxC9sB?=
 =?us-ascii?Q?Mnu6n0LAioBOUhDlfqMzu1NBiix5AVO7el6lbGAt+7rvEFb3JYwCUe1MdRHE?=
 =?us-ascii?Q?CrLcT/6T8OI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR07MB9047.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?q8uSWMWwJAXv5qTWOwRryS4AmgfDc605+AkObMuhyp6YQw8hfVzNiqfZeQav?=
 =?us-ascii?Q?aX7au3+R+YQsYKmJ2aEu3uA6FQUjpl9u/Q0eiQv2+7CpQCYep1omNQmGoRBi?=
 =?us-ascii?Q?S3YmViMOdIe8tDNO8+gW7LhSIoxJHLSrgLFaj3j6XFE+GTn84qyrr8VQ8AVX?=
 =?us-ascii?Q?EsfsURqZdr42GgPo69sR0I22kOzbXB9xWZ9BowdOsMcGeiiCUfIP+eyEwcMg?=
 =?us-ascii?Q?gF3y2qFUVvpdmei58AoLPJFJBAVy0SXkm/kuPwRpHOqVH6Vx9gHQ9YeU6eTG?=
 =?us-ascii?Q?+febpld5x4buQXlIQfVGGpvtok6OrGiptXwGQOTi5r9W+ORtnjiF+ARBF40H?=
 =?us-ascii?Q?s2hoiplISF9+sH0BjryhJX7OdbP9GAyQ1HzzxwIvPdKBYGPRDngCZlvWy3zs?=
 =?us-ascii?Q?ZWCBDRJKdUCv29yJMT9KTyllM/4eeXwJA1EGizofqL8R37+5V1vAANe1hL26?=
 =?us-ascii?Q?Nlf3gI+6DFZhQXvkzxiw960DSsquM2+G5j8avgWct7znJPdZkBcYjg899p/0?=
 =?us-ascii?Q?i4I49VWBfkgsMDEL5IBBjbkDxZOAokyNWtUuHPdExrgqQTaZrcGrA2MZx6+t?=
 =?us-ascii?Q?AA2Z4+CJFMit2q30sgPr0KTqXLKfXWyzyhFOvQj030Z7Qzrvacqy8qLvdNRC?=
 =?us-ascii?Q?aIdAFFhVnFmzD7KaWrZFoAVpVUJdgnqmLIDJHrPR+Dzp3g2d+hevzsBLoiFM?=
 =?us-ascii?Q?xJDvpnG5k/5iLoCJgg3Q6r9RuRHE7rDbL0Ii41VmUT7XnchxZOJWRf+4l5+W?=
 =?us-ascii?Q?e8HDObvi9KZATH9IWcKMQCOd+aUCcwn0UhgUqPkfyBib6B+IMgFIHIyqvrvm?=
 =?us-ascii?Q?KtozJZwcWPCs0qUr+7RPa/bbylXZfvQ/UehXkqKZWwsG++rl/+oWGV2RAxni?=
 =?us-ascii?Q?yX2PQC82LWuLNqKx0rhaDHxLVilhrIv9DyjiiPl7xTJbnzhEfwjPWcLavUF6?=
 =?us-ascii?Q?GhnAbYhsZsqFwJrCD/l+capW/VJJlXDFWgWu1BboRnJwhrcq6vyRe3+o9+xW?=
 =?us-ascii?Q?Tirug3FFwTwd8a/nBCYlgyEk7DOND+MrmBErvpmOpdwOxqyecvv5ph9L/F/r?=
 =?us-ascii?Q?qKRqyfW5E5k/MSGik+XdawLZa9QHtJoaAMezr0Jl2LWX0S9/I2u4rItHB4g8?=
 =?us-ascii?Q?OqMIDyAD0l4YZU4wYwbmuKf/YTmzCes3DpKCSg4/ntnp/lDtk6ouGX3Vp8gY?=
 =?us-ascii?Q?XQYB+DfOgXCCfp6cxicmftvy8a2tXh1NYfnX6JXNhL6UEAPSx7sf5dvI0YMz?=
 =?us-ascii?Q?1c7rp5IzaoUvye3+kLGMtHT1e+X88+cy3F4ldu/ob7Qq+fA7IZNr4i3cK2tC?=
 =?us-ascii?Q?sASGXGd6G4g0jckMxKlH2CY1ijwWmEFqNR7NRDU9qLeXhCnSu68FiEmv6Rbe?=
 =?us-ascii?Q?wBVTABpv3ZxyuZblWmVxdXAFLFvImXDBukqfSfdtWxKT/HmVw572gEhGgUSc?=
 =?us-ascii?Q?akIAjUu7QYKnHt7+gf5X5SyihRyGOo8AFHZ80Y77BcbvvafqaDOuS1kKsbog?=
 =?us-ascii?Q?aslcUD8S8vlmw2oOnNr3xjVczOr/j/XppoeVCyYpholsx2CTTdjgqrFWTmg7?=
 =?us-ascii?Q?DGeyDbqyvhgGJQ9C9dJRJ1YCPoXC7kqarOB5kCE5xRrWcic+IpdDuwX6cueL?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fb03a3-9dc0-4dc0-f580-08dd706e3080
X-MS-Exchange-CrossTenant-AuthSource: GV1PR07MB9047.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 16:07:52.1059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggIwloJic+/uaK9s8pP4wy5VvhZck2UegKCaoBTiJk6wxzAmnwi/nkbqaZMmQEvuhjFVDXjG8OoC8q1XT5CH85OaZXvh61Nuctj6R+s2zIQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7349

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
Signed-off-by: Elodie Decerle <elodie.decerle@nokia.com>
---
V2 -> V3: Cleaned up patch format
V1 -> V2:
- Removed mutex lock in uart_register_driver
- Moved uart driver registration to init function (Greg's feedback)

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

