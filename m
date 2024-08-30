Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010030.outbound.protection.outlook.com [52.101.128.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2936B0D;
	Fri, 30 Aug 2024 03:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724988794; cv=fail; b=dSu3jv1KBKBSpQ9ELrpuWc+PC6eQ8HW1lgKBLASq/EtwsYGxDBaLkdnSRXitC0LExjq+Pj/B6M7QZUNbdquweJUC/NP+BjAIkA/B/u021zu5aNXyW+RBW+6H3a14XFoX1DDu5q0uSJWrM/wNd+SLW5orM/3xSg5/OJkMByePqLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724988794; c=relaxed/simple;
	bh=Eg5ytTFO9LvBN5qrpQdvOC7JMR411ROqL2Kk68J4B+8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=LCS26KRHPMBIXm/p2eTdW88YUs96uNHUfnpG318ahyzDHeTINIvKbCs14d55cZHn0/ASCN7k9DkqQoM3rLdFWQwjivNPVm4/xoOf1CZ0k1JP4rlM4JR9/TAOl6CykqG3qA3aI5eMpxOgcGN3WFdwKXG5MISUrCpYpcVA0TAV2no=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GJgi6kzD; arc=fail smtp.client-ip=52.101.128.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="GJgi6kzD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIVxwCyDBEcy2tFhDwLMUQ2DJAdKsPxzc2dT3zJ64bqw3EobhP63YJUyOxFUcA7IxiQAfhj6M4gwXWw/mdjfM+h3Gy4eWxibBJhuspBOGhpmMqNYrCQcqDA/jJsAofSllbGQpupfZufE1pV89Xqa0TbLBSBsIFi80q/3dMEerqu6dgIo24IMvk6g2MuDTfmgcP+I0eMRZkvZ4U9GmrS6jlbzCYMPJkvyC6IV8niwvyhfu6wjIT1muEDDDaOC4EzjAceS8QqZUhlC8yze4zmdAb7lvgc8gvlt32uj4ZPS8TwEI8bqC/wWnpG2shSyy5X/8yYTVuTHTs7fzJGyMIxjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxz/vXMwvfN4W1Ibsu2obm1pNefuvFmB69JVawhuWUw=;
 b=wyzwaTJInfbkzXacE7adeiM6NnxgRjMQDFqc65eiv5N22Rnlj+RC+ZlcSSgy38S65gD5nFMm33438POVZNqmlBO+FGzSWbBySzUdOd46iphg7PSzajI9L5nlpJ8KdMt2UFgkBqejqzHXfGzqvVzXbCfeK/QpN1dFr1oFxAVeTeoGbkeqmHU4EMe71KMuEK920MFfDQzxpFg2JYHowK9lgN2Bw+rrmFh2UP6h81XKzvkRlO+qIigsa/hFkRlF6a5uhvbxQ7hJzqLwVte55eMpSqOc4k+QOr5YFvGcnrhX5KZSp8yUWokE14DZeQ1zo+9TBI3vvvoD6Iu+spOxXL+8tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxz/vXMwvfN4W1Ibsu2obm1pNefuvFmB69JVawhuWUw=;
 b=GJgi6kzDsgVWon0lkfTVoUvkNiyKUYn62PZ4tmfo7KNH0mddDKl25btgNYemUyPFyPPQ7DlbIJLTWyCGlmoaIhDKFJeWb5Bc+n7F/c9mCwUxICVwjE/NtmQRb25dDSAqpDpm3TDiwhKtyqDl5DGXcM44jGSbOhaMAMmz8zqNqpPfSGorI2wdstXXaE14P7DTNMz38Ax8Z2EO1VJV8qYyP5Wj1KJkPO4sHcnpHPz5Z0L3AufAX9RwLQTFDB4XzSNUI5qxtTMEhGIrSL0Qg1ZmjPOeFm7Jm0GoE8daknxT/MY8YD5XqedZuRK4CP3HBnoe+fJ3dv3VfpFwtBXLFdiAjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
 by JH0PR06MB7178.apcprd06.prod.outlook.com (2603:1096:990:9d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 03:33:08 +0000
Received: from TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70]) by TYZPR06MB4461.apcprd06.prod.outlook.com
 ([fe80::9c62:d1f5:ede3:1b70%5]) with mapi id 15.20.7897.027; Fri, 30 Aug 2024
 03:33:08 +0000
From: Yu Jiaoliang <yujiaoliang@vivo.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v1] tty: serial: samsung:Simplify with dev_err_probe()
Date: Fri, 30 Aug 2024 11:32:51 +0800
Message-Id: <20240830033251.232992-1-yujiaoliang@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0052.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::21)
 To TYZPR06MB4461.apcprd06.prod.outlook.com (2603:1096:400:82::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB4461:EE_|JH0PR06MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a21e2b-4f22-4bfd-b432-08dcc8a47772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2oP6p4kaG+ZJdGTPmQxqAGSlrvVj+y1Y98D9cZ2YXGlsReiiC72r6lXaMrnS?=
 =?us-ascii?Q?r+Bhfwh8Fk3kuEwJKgzogRtpRYAgWPapUFhjQdEbVp+8NnYk8QA0JbT03CjM?=
 =?us-ascii?Q?+QBnYrYiuCUCOsZffiQ13yDS9X3zinGg6BlZ15U7yX9RwYBJAgVX3B4K62lc?=
 =?us-ascii?Q?FZSoUXXWUnJ4YYN9cHdWGM52as1jFBHR0PuCysphfEAmt7GtV3ARl+Jx9vPJ?=
 =?us-ascii?Q?nJq7mDv5zVoUOxUwOwTQri/n2UsprM1H6RLVPE+Uoz+O5n+1/aD6pnA3Usnn?=
 =?us-ascii?Q?Tbu36MRObJIvz0x4Ku0peteYAkeq0Ls7YMl5aq9oRVW7dtfKEvVScBmUB5Nu?=
 =?us-ascii?Q?5Cqcomc8sGJsqVqmcLYvJlODAH2668wRepCnh0Y1DQrXxehnyiJli43mXcsT?=
 =?us-ascii?Q?TEecJkxbBRBXNVj7ttr449CQBJzniHT8puqyw09K7nk1N4K0pG9W2O+QUVfO?=
 =?us-ascii?Q?1O64kIKegpE3Og6Fkx0d5BD3eqYtf60xi3o1x+ZRcRvx/IMqbEDD409UdEkP?=
 =?us-ascii?Q?eKFube7/4wuSl9i5KOLtl+RUyr27I2vh1zS6OzZn8ofT6dq8H7eFgMWZtiWA?=
 =?us-ascii?Q?aCMOPDZO8Sln/W8SVRYvPKCwfOaXC006RV2HMZ33EHUT+h4IysKs/6VNu7+k?=
 =?us-ascii?Q?7Ykww7k2hboAKyJ2vj79l+Cirmpf+YzwlGYJg3CEL/aa4ckE+/TLHW4fQTkF?=
 =?us-ascii?Q?phWrO4wRU2ANDCRZspB3m8zKE496rY8MUhffDIcXhhWiju9+q5R2VcDQJr1v?=
 =?us-ascii?Q?tztarSFoTdULqlleQUfUcLmDmS0JDQSEnFuv5/WUHux0NeGuCZ5aMaz2S4D8?=
 =?us-ascii?Q?TyJTjq7mKiIFf8MM7g7TFtiRSq1XMNJVJ++HT5RqYHyteqS4lDJnbQ6LkzLC?=
 =?us-ascii?Q?vXiIBfyBb62beLmS7erp3p4mEsB/dhGtdTR1wO0q/oNaXUrO6yhEE1G9mWMc?=
 =?us-ascii?Q?T0FQKKKg3NkvjwPMAnsUi+lXAYtMVAFhj5hgLVIat0C+mvDqEawv5MSTZIiW?=
 =?us-ascii?Q?nyyAM546VQ6294Lm+jXhHBA+QFsNkGaKyhiZKNArwRVbYBAHmJfenHoVNgYY?=
 =?us-ascii?Q?NtXU8SZxvBjmdK5iLcgE8/ecsjrJt+5UhR6DbAvk0WXaS2o+EQoomAra/PEM?=
 =?us-ascii?Q?/jw5AJ9597gOkYVHqLOoZw4ln2SpGiB+pLmMHg9+1HbwdGaE9P+96UnwRzRT?=
 =?us-ascii?Q?FBteZsBJxq5r82Q8qJ5UZJrGAkMOavJ5oYxlfwzKg/hw7NFyfgZFf3b0qa2M?=
 =?us-ascii?Q?PvcwdhwYKW2MgOytVlC/562OJR1csrW6NAOBxX+QxYpQvv6KZWs0KydVveTk?=
 =?us-ascii?Q?A6QyRWHjRnp86x9/3tfBnM3zMX0MrkmSvnHt87Kg09gASst/GgwLjrCJjKTS?=
 =?us-ascii?Q?mA3T8lEdQxknVDcXjXyfpxp0YW4EKlfxfTDgi5E8efv8E/Nxnw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB4461.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vjWpfPddmdHiYqq6gDdhDc2pY7vPrC35sVfLs7K4xK23wc30qukzVd8tGPTp?=
 =?us-ascii?Q?nMM/BQuk5WJfbLn7CCOUmD7Jx2STNywR3ioK4yB2SgqTAbJ0/5rxBPZxYdS8?=
 =?us-ascii?Q?U2f59/awngt9IF2i4HT64lyFsk4AsOTrns4GwVcHVO8LgNAee7qUccCmSPOv?=
 =?us-ascii?Q?5l9R0ksPvpDepVNM64xyttgMtIP2FYZMTTy9pucyQ5yUkvcq5Fr4bwE3tGhB?=
 =?us-ascii?Q?lZIllo2Xwe8gWseFYauXd7JMkZ6wVxKNjkXt7c8BaS3UFYkm0RU4kuuS9uhA?=
 =?us-ascii?Q?yw4OTkXEp3u0Sb+vS54FCUkBAp30NTueTI/5XHTqALGjNimewaTN+peZW1iw?=
 =?us-ascii?Q?3a9Pri0ncUYcTreJUXT8oazv0oBuasfIcNz5R6j8GC4FXe2kI6zomJl40kPg?=
 =?us-ascii?Q?nCcrDjSiMrk4U6vYnQqsNivmqe0B5o3RhcVqxAb+m5whX/Sfh/+K0aUYkUGK?=
 =?us-ascii?Q?BSwibSO2b+7JNV3REjbegja9THZoDirSnUTw1PksQRZ5y6RtmQ3b0LVxiul1?=
 =?us-ascii?Q?1TIUpc8wqsziqRL79BBEF9YtbprtYs8cXulfgfIikeXSdF+VOEzGKcczSweV?=
 =?us-ascii?Q?ekaRbnnv06C1CplnF9n1vl4CwREi4gQe60NIPuYDgAMR7FT1NXOYhZhbOZ5o?=
 =?us-ascii?Q?k0WLPhQr8rwy8/D4mLwb9oROb9TBlniG87Iro5cv/UJIQbzzHJ6yFcgUEGoe?=
 =?us-ascii?Q?PJNYAOqojvEFvl5ybnOOoQfS4RKghEI/cd8VPVQ/vWNA09Hh0nVBwg6jq3vf?=
 =?us-ascii?Q?gAvmF2p8LOD36GnoGWzTIFyX7/FjPjj4J2lGlSE1rzgH/1Jf1x4uu3+AkCyl?=
 =?us-ascii?Q?SaZmvs5RooPuJXh1ueJBlanO0Z/4ou392S3dQj98jqhJSGTDBcZlUzPpZG+1?=
 =?us-ascii?Q?6+S84jzwEOR9SCMneJZvt9iy1WVYun5oNj1BiPmOS2cyQA/U8nNg+95NTvCK?=
 =?us-ascii?Q?djuUHYA+LT3P+Qn95K53KY7tNmmQ5xqPaM+Wz9f0uLD1Wt5q7Ino/VVd1HTc?=
 =?us-ascii?Q?NHZwgQfzyezwRc+Yj+rNuq7KztESnp5+IWBboF9yUfbP8IyrJJvEaRanWFPr?=
 =?us-ascii?Q?oUHb41vGtaiTArmJ74ht7Acp0uaWUTCEwW7UTBTnTnS8r8rVZY5D0phyovpe?=
 =?us-ascii?Q?Jj7p/2mhZ7LlDH5DFBYxlmU3qwIuzCpC3wCxaLYA8lXOFnfl3EPCMJ7rNQL2?=
 =?us-ascii?Q?fL5obkeel1fNNZHY2X7RDSv+9GfYzPjxqM8b1Ef36m3kvs4E52vRPpjZiGyn?=
 =?us-ascii?Q?O+BPTysUNXo3j6peixSn6SwnKggStS1K9Z3SAu4s+cztKDTavAb65r3B73Sh?=
 =?us-ascii?Q?8zOgf7+Qtbv3h3WniTceHbiKetyaxoluGr7eXosT01P5KVRaGqQMGqPBGEoq?=
 =?us-ascii?Q?yiakJkR1ueqjRaFXT5FPq5LPtIv2/oVvGFfU9IVsQo9sZNdLTjA/i4nCRuJ2?=
 =?us-ascii?Q?5PjxktgC6ZMV3hAQHSJDjR0UI4L+HWaK6/CXvhOkAru5BzmQ/zUCJ1HFrmYG?=
 =?us-ascii?Q?oXnoTJ3ntrDty4teGEltw9g0ciKV9XKUmje7CNa39x+ibe1kpXcgWUrSeCpq?=
 =?us-ascii?Q?oZ73C+49h6et1CoSrONiGHeYg3lFD+ygmbSlmXaE?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a21e2b-4f22-4bfd-b432-08dcc8a47772
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB4461.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 03:33:08.6003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0cY6v49yvnvf2SGK46i9gqsdD+NvJ9uE/sYXkCewc9Jy9AttI0YvgmJQGQkLQAkb5UqxJVl6+w5MuYZAt9CnjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7178

Error handling in probe() can be a bit simpler with dev_err_probe().

Signed-off-by: Yu Jiaoliang <yujiaoliang@vivo.com>
---
 drivers/tty/serial/samsung_tty.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsung_tty.c
index c4f2ac9518aa..3550177010ad 100644
--- a/drivers/tty/serial/samsung_tty.c
+++ b/drivers/tty/serial/samsung_tty.c
@@ -1225,10 +1225,8 @@ static int s3c64xx_serial_startup(struct uart_port *port)
 
 	ret = request_irq(port->irq, s3c64xx_serial_handle_irq, IRQF_SHARED,
 			  s3c24xx_serial_portname(port), ourport);
-	if (ret) {
-		dev_err(port->dev, "cannot get irq %d\n", port->irq);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(port->dev, port->irq, "cannot get irq\n");
 
 	/* For compatibility with s3c24xx Soc's */
 	ourport->rx_enabled = 1;
-- 
2.34.1

