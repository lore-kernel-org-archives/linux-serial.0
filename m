Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012058.outbound.protection.outlook.com [40.107.75.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262DE326D66;
	Tue, 19 Aug 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755602139; cv=fail; b=A57LXfI+qBkp/XmkbRADaLUQhaqophSloe20naCZjBZw/6PtEflqz1UHZH89f69SXHXAoG5AB/tx6HV8vfHe/JGFWNWAs1ydIe3S6Lb+madGpHaLjwKRnnGR8/gP9Ut724pr6A/BmCkDFA5knv5+XP3RiJs9r1P0puWy0aCmwNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755602139; c=relaxed/simple;
	bh=EKGh3Rk9tVpLe4GrVrkOHBNZyk5NDg+rCVz9trXeq2U=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=FqsjDPE1Kdn65x4HuSCDNulrmIXHWWeuerbfWJvfpRUedeu+ulolPKL3sBFVxsRwRsukLIgrWl4I99dY6bJBZtGyrv/tRnRju+zqxTsmSXLYK1Wu8AnG/twXNUTXjj+43g6FqBRZuDrx2UsrrNl8rJQAifNlhKlt3tiyCFs8h+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=UAJ7vVJK; arc=fail smtp.client-ip=40.107.75.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="UAJ7vVJK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e2ZutF0olcv/MdD3wTCgqj1IzCtByQqg3aQPRrgrg2Sj/1L/MTKoNvOXrLzkkoX2nyMkiddvYHBbjAp3HNlNMcCd8auBcn8RsQ+Jy2LLIlj9iD+gBiB4mz8tVU9kS1hERR4+SJ4dYfWYdfQ1UqfMdwmerE7gSv5R4uJPkomahNbwJD23NN8+IBzLWLOfjz95tpW0WVCfJw72WdHT22JAYdQmcHUcVVVBbKED9Ssmm1mLVcgpwGp0tQUkaBWNhaZ65JvZscq9n/LnD6u9vYLQR5UHkxnjZ7/jwlh6fncj7j2zA+8G2QNvCWOv+8IZA4SHbnzpVNu8zxWMXXbqObY1kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+atDhYNIyqllRcluX8yKBiKnwNuqWE06nYTWoUkBfU=;
 b=U0bwuMBaic5Eg2MZVx+GiOCxXJmXGQFVOxZIODyoAFV8psxbPCrWD+h48vGRvI3mAlUvhVMiPrH/xODHhvSd9ucLmRQqIyChEk1sSrla9sR07Ejq5K5Mm2MVLUAP7R0Y+rt4m00CNsvuTk6yYgZtrgdIx+jG4tYLHOayktPHink6cYhypKl7q1d5WBWQ00CkXJvPGUGqKgoVVyU6ubzo7scxWKK3uVmvYzao+N9psFRJwol8zBGB9Ic++HLHzKsPIH9GNnbzVhB7fLT2g41R39+gVNfHMrfdP+cf1VsKGyBh9OTYjWgyJiXXbLfMNwVlZUtp+wLfjGuDV0S0v4qj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+atDhYNIyqllRcluX8yKBiKnwNuqWE06nYTWoUkBfU=;
 b=UAJ7vVJKAvbSRBUTvPe2XgQiAwahQxp9WyvnhQmjgf0E5UDnDnH5JNfff6Qw4ulCG9WvGcJcJfQQigE3T8OLZpn25G9/WBspR5kEKFT9lYANHyKFTYgx1BmYBlqyqPCgphwF7XDCNEp/gt6+SDB5eb4AnwFWayegsocmbkGKuziKG6/fsGpZOSJhtlhYS1WWlcojybZeAJzXlNc03mQ9Hh1uEuV2bqQvykhf7HjHFSeYKjrO0afJNKkLqeI7H4R8tJq96UsP1qo5mtMnSi1yc1rYtcH3+u5B+W2V3N79SDFPrzUWz10JKcAqrgaWLUw6K78iF06KGJ7BD2RURViIvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6021.apcprd06.prod.outlook.com (2603:1096:400:336::8)
 by TYSPR06MB6527.apcprd06.prod.outlook.com (2603:1096:400:474::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 11:15:33 +0000
Received: from TYZPR06MB6021.apcprd06.prod.outlook.com
 ([fe80::a774:9376:52a6:8783]) by TYZPR06MB6021.apcprd06.prod.outlook.com
 ([fe80::a774:9376:52a6:8783%7]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 11:15:33 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH v2] tty: serial: Replace -ENOMEM with -ENOSPC
Date: Tue, 19 Aug 2025 19:15:24 +0800
Message-Id: <20250819111524.584405-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::26) To TYZPR06MB6021.apcprd06.prod.outlook.com
 (2603:1096:400:336::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6021:EE_|TYSPR06MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: ee5fe0e5-44a7-48da-a8b0-08dddf11b6a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QYeMFX1mTfuajC2w1xjg5h6/tuDUfs7cCKrEX4cMSyuzDvDDx4Tg5RdeIsOa?=
 =?us-ascii?Q?9MP1KJ0IEd3mnnJxOxeIVwVgjC/6i4y0yfrlBhamw4zPLbvOzrBBmTb76N1p?=
 =?us-ascii?Q?ipUkC9/z57+0xYhqe6qSh3Idk4EesCYteaNT4kaEz1hiT6CpRmATjK1/PhJn?=
 =?us-ascii?Q?lPhyYQB6z/r777ZFLmpT32tJF1sBOFOKo39hr7CkpXB4El6sQHuVJ3RNIsFg?=
 =?us-ascii?Q?amuQsQz6xP1wOdR2YQc53CcG4MwLVQ1Ej0QZIWaPsZnGkvQ8aSp8kAQJliL1?=
 =?us-ascii?Q?S/00i2Vh0eulfxZ8K53dGaIxumlX2zN1y24vLzhq82PJocd7xBjjsYMC2XX/?=
 =?us-ascii?Q?4qH1cst6xX8maLHtW3LB1JmVn95q5GZr+vZMOYQyNFpwIuZ+lx9bEJDOEEo7?=
 =?us-ascii?Q?2F3HDxlai7Re3K9UqytdcFaq7OZQ7JU3H+9OibjSga0xjW1a/ned1cIg5EL1?=
 =?us-ascii?Q?fLhfiTOV+7RVFBGbThUR1eo5dBgIROQI+9MLzp+RKcHSinLENbatz4ynI+i+?=
 =?us-ascii?Q?2nk9oe5WBF3tH4dP1uVPpI96CxE6DwDwsw8YvVG9tsax0nitIut7SQr/jYEc?=
 =?us-ascii?Q?WcE0osWcLssa2SQ6m4WMLM25FMDhrbddC1kd32QByNuAW0P0hZ76dhxzM/b4?=
 =?us-ascii?Q?iujvFiyOtzCZGllYRctLXgwVqp1D0g0fQopV1acsrFHEa868/+6uvQbaX61q?=
 =?us-ascii?Q?53gv7qEmZrKYFywylb2QidGt/o0cGer45mZJuDix6KwaNRLCTfpjR4LlMaA5?=
 =?us-ascii?Q?Cx80bbCSKd2aeXXcF+913bWXNK4brCt6hBmHSniRLg55yTefJgCtHv1aB9oN?=
 =?us-ascii?Q?gk6LuU72032kohSmI/hV++eYUxw+/V9NvR64Hh0gPAlnF7+u5BKszpOvR8jN?=
 =?us-ascii?Q?Rdhwv/13DVVBE5iNOcJB6iCU4Oc/s2Mb6tq4vRN0fQ2W5EAvuVLKZL2hqDh9?=
 =?us-ascii?Q?XN8icyFbTf1E1wsHCmyGwJtMSabgRh0B4xkrVDBsWU2TDw4IYZLIbP3s4kYQ?=
 =?us-ascii?Q?p5H/c4xIOxM7qP4mDEzX8SxbDsaxNW2EcqJqqgPgxfi8vj5B8qAu6YlMz5iY?=
 =?us-ascii?Q?bn2+NlZ13z5zqL/JC7uHWWhDbuXixr8MdztTu4vabsUzGlXla/6/PlAwALmZ?=
 =?us-ascii?Q?AUkmRbrPIuANgNxNzdCd/fRtz/bVC4bk4CYDinp23VLCsdPs8rbjiKEm8rao?=
 =?us-ascii?Q?HCYCMW0gKi+3pc0xyUSQobKGcOidZWYnbNPRyJEWIK6tmQ2pB1kIJyGK2tGU?=
 =?us-ascii?Q?ULgRby99ZAFPt80yzTE+KgaIteumaKKRCOIH5xF8CO0pkTfUxXZ1ZMTfe/4v?=
 =?us-ascii?Q?VN+D9GKF3vXnZwXtmA/1Rbu1WYpn9Gtf3anNC985rsith66lNkeKuHl0+9If?=
 =?us-ascii?Q?/xa91UmMrJ/fnpUagGY7eFYbLzI9bEi3HLGHtfH4okY9nyj3jromZDVjs+1Q?=
 =?us-ascii?Q?hPAvjNORmSCJ1lLjEEdENDrrU2kiXz49YjrzoLkNHshMvkcEBPGTJwON0Fnt?=
 =?us-ascii?Q?eJg/oe1WFribZMk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xEK68oZTVulYGMOAi46GZn756Xh4J1/Gel83Y/PvjL6pEg227pyD2Bym3J5Z?=
 =?us-ascii?Q?z8w1zomuEu7e9FWXoIfdev//Aeq6JG1aLF0Q0aagNz2UhUfXGCrShBOFTR7G?=
 =?us-ascii?Q?Yn51tG2BjPNByKcy34xX5wO6J7AV7rMJXVl8HOrr3iNsY37B8qjRGyMUzW+m?=
 =?us-ascii?Q?XkEz5rtugsbudT+vQRPckHiQX5mW1oaRpj3uJS4nNecpjLJPDSWwRZm1Wtcw?=
 =?us-ascii?Q?1d2NszA9CmxELRDeWtADSKhc8t7FazNaEmEv7MFXlVcVnrwR4GH4PFH9f2c8?=
 =?us-ascii?Q?DRqcxQz2Ia62Jz/75prUotIu4n6+au7Mtw/DHOMrreBz2zLT1fdItVxU+HFa?=
 =?us-ascii?Q?tNdmY96jR2LsEX/DFaOIokpJ5hc3CZyUhoAMfE3OQvfm2CX24lBHJEywOipZ?=
 =?us-ascii?Q?FPKAIgYkXh6wvY47OFD97p78kjYGmfa9GSl7tjMhlWOWPpdFcEmMy5Eq2lua?=
 =?us-ascii?Q?8xILJmw7VvuEk8irRE9jrviPL73mkBHJrDoyHieyDfIwbq6WBeMqRMmnmU3S?=
 =?us-ascii?Q?9gf05+wUdL1TJyd66VeQxgmcFETc419Rkb1bIEYfZKVSj5zMFpAloWeBXmdD?=
 =?us-ascii?Q?TF4G+PrN78WtRtmDxdTdZM1LQIQ123BB4Wmj36rVpFyQJBQ2sWrZzdZyAWrp?=
 =?us-ascii?Q?PBnDQZS2Me5rgo4J/YLKyRAsfGNGni6thGQXP0swQ7ozXUoFf24qtvDOBgDy?=
 =?us-ascii?Q?gJ7rKFLSM0th99lUV2ddmxri0yki1xA6juJSrcg7Lik9gEj0BYQtavd/65uj?=
 =?us-ascii?Q?SfrT6dx0LIqAlCCP7/mwz/LO7S8OWDVRmvtNG1rl7yIyCqFSsvpYs00tCWKn?=
 =?us-ascii?Q?R+c1KpHn6uOvxJ6n9fo8g9wCBHdMi73ezlXXIeOQbg6odKg2tMSvMzWyRrkP?=
 =?us-ascii?Q?Fz9p8u1KHM0e3QgYNUMYKrpqvnXQV4kuDcc27Y8rc21ky1Y9L5Ou2sJAynGb?=
 =?us-ascii?Q?UFylSNBdtODyqzt6jzZl25mPO0KzBJjblmoiH3qFdzCVdFdDeUzRD5SxfLqM?=
 =?us-ascii?Q?sDmHZ1w9R6bFAur5e2ZW3MnqlPdgUMPX2Q/I11MyuirITpq/GXpugrd3v7CT?=
 =?us-ascii?Q?jbgKzJ5KMDlSCSnmirFmd/Zu3fihb/9kWt70dGbugRdJFWIddRX41TfqSzlp?=
 =?us-ascii?Q?F9kmkWUJsRHT9PBdAv2EB0BoG1rQ7CUpPYWlb8GGrS5SNFeZZnHgCYtlNRNg?=
 =?us-ascii?Q?MBGDgo5fTcX+tx/XZFRlH73kNYE4Hz50OEQF0aEa/stTiQ2U8Br+XLGSspio?=
 =?us-ascii?Q?PGYb/rZpebllM/j7SvavD89UilbI8veuhqKqEB41YO6D9VW55ZeY7/E01kKb?=
 =?us-ascii?Q?h1/+IcErNFutyaK27Wwcbpuzb81XCKf0YYNti2EN7R8t8xZHMVZ7GJteW8Uo?=
 =?us-ascii?Q?o26zAIlIbbdCCB12ai7kwhrTlwA2jxvbxltfDIRSubj4dD7kwDf7OOGMyVSy?=
 =?us-ascii?Q?MOhIHKsrPUkXsQN78jt/hhdpUYD2430p/Qk/RrxghtZytAaaECMm7EB+ijIR?=
 =?us-ascii?Q?0maYV/78MxRn1kqWbn/VDLn1u6jPaFbsUIYG8401T6W7/D+NmRnY37sN8N4/?=
 =?us-ascii?Q?7gAlbCbBQ3Tl9UMD/G/SXg40hYPZEl/kJ84JSWh/?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee5fe0e5-44a7-48da-a8b0-08dddf11b6a3
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 11:15:33.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bUxuzRduq8hLJDwYynKiwBq9xLbTspCmyqCviI+YpFGT8+odqdUHUBt5RRVm4sVR+y19gN8TY+j6pT1QTXgZGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6527

The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
And using -ENOSPC here is more appropriate. So replace -ENOMEM
with -ENOSPC.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/tty/serial/max3100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 67d80f8f801e..3faa1b6aa3ee 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -705,7 +705,7 @@ static int max3100_probe(struct spi_device *spi)
 			break;
 	if (i == MAX_MAX3100) {
 		mutex_unlock(&max3100s_lock);
-		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
+		return dev_err_probe(dev, -ENOSPC, "too many MAX3100 chips\n");
 	}
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
-- 
2.34.1

