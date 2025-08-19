Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11013041.outbound.protection.outlook.com [52.101.127.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192FE31E0E0;
	Tue, 19 Aug 2025 09:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755595491; cv=fail; b=Bb2xMGBNhNCcmTccnShCjNEioMWnCyN0mtMDELAhp/UrGMcnytEFMid0ADZ1dI2vHFl60+ITN1kmOq3MjTS6KucIj0nPf5ZGHGX4jzZusAvcUYDW5jag7a7UQEHorNirkqmGjWkxLnqwasDLZNFUrdiPZ26TuNnAwABJjnX7EhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755595491; c=relaxed/simple;
	bh=04Qp+6D3yPZDhYvDA3X6sMduMFv1g5fSqKcLK2Rhdts=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=eTdrWw7TVkrPKA++WF2B+xyOaFDwYDSmZqczYdV+GZ9y2/mjPWMKSim3we/iyGwrQZRVQqZG4V3vUmt9Q0Sye+Zi3f9ylRltxEzJEoiuWpLJgRu5EwDfOD+v8X+erjmEnmhoohYvSzjp/PBjNSGCSJB8EthVNzw245/tAqXs5Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=Q9LB+ZyF; arc=fail smtp.client-ip=52.101.127.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="Q9LB+ZyF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R6/wgZ4WlMLK2FvljbzjeBxSnPPWRN7ssW512ocFADTxDAHd40PLqkega+zB/R0de7Z+giSQk7FaXK5FGNmWDjcbDIc6zaFLKkU6sNxcHgxCKMEb8gB4WAQRFdnhG7OMH9NyvoARISFRjBDa7P7tPbpGGrpFpaIAfL85N9OPn3x+awHTQXf0UAtdUqOM6E3BjhQdZEDy6npD4wW8VygieFG6NdNVgPfoBqda2FrLYwMKQgjx2CMZuDil201HaBMhgYVinhgv1hN2jIIzWhkn51ALswmAoZ25kSvAnI4ZKndY13llqoWx8I2l7b3IblQbrpbqFRV6et8yVOdJFn8q4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09iIs+II7AGwKqNjgnFTyD6ET4nEF7mJ9aHS1EmQ1cg=;
 b=Ts2857c7H23tPC47bsLs8KVxeOpZ0UoOro1lpMFUPxtc+Kx6JRbCSxTMXWYbnTQtUwQ1+4OFJzNgY3PmtOh83HrHICAg4nW45x5UDCVkYpLFDjexSB3kBJxBwwDehVmSnWCrywCJ8RUGTMJ2YokjSlvHmPN+qXq5RoAIyKRDHNBcOj6/lj72R9niqyY50ZD5LfjHX+uK18HrBu1xn8x4/CKx25ZxLJFB3baop9ODImxkjESf1kt/iFlR5Fb8naf3vnlx8zzlHDwUpsnI3SzMhjChjlKNiMlEoXJ+/Vxq79A0M62kOZ7ZjMIp/oYVEYyIR79Q3CGcQEYvQNB0I7Yw6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09iIs+II7AGwKqNjgnFTyD6ET4nEF7mJ9aHS1EmQ1cg=;
 b=Q9LB+ZyF4mJdsIyCr4ZmtUYslNKSILBymNZggNq6D5BBLY27zOpnBjAg1/Hjr8s+sGh4hRurcNmxVMVtw3uQzjPz4IgD9/npMgCgva4l7Hrh1Yp+eq0Xea7cbSaMrhBdoWE8nRR+j5xoXpDR0QTi6SBxvnDdntc+Anmd7LRsK/373EQIv8s8VT1iF0OotfnwXmPwdxNtGTzxV9T+SLbOuTbbg3iMF9k9pvu2iZTfgNADM8axeWb40Jw3qSB1BSCWe10LmHkQUUMF+OYEavmBWjBBJa5MSAQDxgnGjzqraroPy1ey26PKEI+nzZFqesTKG2wqKTN4Lb330OKj5DyjXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com (2603:1096:820:d8::5)
 by TYZPR06MB6657.apcprd06.prod.outlook.com (2603:1096:400:451::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 09:24:47 +0000
Received: from KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb]) by KL1PR06MB6020.apcprd06.prod.outlook.com
 ([fe80::4ec9:a94d:c986:2ceb%5]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 09:24:47 +0000
From: Xichao Zhao <zhao.xichao@vivo.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Xichao Zhao <zhao.xichao@vivo.com>
Subject: [PATCH] tty: serial: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 17:24:37 +0800
Message-Id: <20250819092437.550759-1-zhao.xichao@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0013.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::18) To KL1PR06MB6020.apcprd06.prod.outlook.com
 (2603:1096:820:d8::5)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR06MB6020:EE_|TYZPR06MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 25d4962e-950f-4eda-bd38-08dddf023d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KT0enLvODGJNPiGHBWTZ4BiE8hGax2ct5spSos7IrEcMRXxjJhe0cMh7Wq9F?=
 =?us-ascii?Q?ae7BN5vLTfFR/W1nKSdFRQev1Mjm0bcsj1Y3jr/PTNcnHgCUJpPHCTI6FYp+?=
 =?us-ascii?Q?CgbSrpaeVOJ/K5YYQqmjZJ4aeNA2ixuFEUj3eTDmeWsM1UlKMnJ2MlP3sDx0?=
 =?us-ascii?Q?AyIGY8V+aJcz1aAXcPgR79rEkBw7CwHbqwBVGDvr0zvUBSH+3WdKkXC8IXZA?=
 =?us-ascii?Q?yANFzQkbcsb1WMn9xRew/iQB1fgiO33advaHotBa+5HtwDTEVvykAeAamT6t?=
 =?us-ascii?Q?FWrspX4n8iymN0ks2CpU6D2KVEwA1S1OMZ2LlkZV2Y5mD7FtpzMnAV5+RuKA?=
 =?us-ascii?Q?8ghAWoC3jozlaLACKU0LJeUJucXSugStpPM8ucsQgQd/UMDrllmqu7GsEVMW?=
 =?us-ascii?Q?lx7C+nHmrluIz0vlOQX3XdsYVmBMT3lXtKvvyO4y3KQ/NtcbhkB/hCvxEosn?=
 =?us-ascii?Q?veY+e4mdjRhd3i3eqK+rvtZMcyJCI7hhB0WpNY9IV/H/tfeZqvQP3AkZEYd0?=
 =?us-ascii?Q?oIovJeDfZYvkm0PCLyz6EqRGcICFyhuCMHAiWlVAI2grV/JtUzb3i5htET6a?=
 =?us-ascii?Q?3Ph9Tbzbvm0EEo53ewAmTjlXugPqPf0uwL273s1o6ayOB+4KKn3Bfrie6yGB?=
 =?us-ascii?Q?6UHE+9pxUR4T8GQ18xxlyEr1u/DDWFSkoDKaJGB8+iCPEFXI1+Pr0SBtnUAa?=
 =?us-ascii?Q?2GuTAzOAADEEkuuHoficcBoscbjNpXgBngOFh2MIaaykoxkxgtLxrOGpNSj4?=
 =?us-ascii?Q?iyt5THSECP51T81EnXkUQ16C8qsnO3WYcJT9s2NufBHLe5FSBzJKLfMHwilB?=
 =?us-ascii?Q?aCqx0gpvjM4T0NsqqlEXcI0Dsz9fG0cA3SpCvP7HtvAPw3CAY4sgvgqVoxRq?=
 =?us-ascii?Q?hDDcIaTF/PVxpI//i7IQNn5d6i20SdCSKAYxlJyUrM6/xZKiKUvTC4r/H81a?=
 =?us-ascii?Q?Nhxzgq1gN3TcLEFjAm/JUvEJno9ICpgMYdyrug16uioPontf214ZOUUaeCYl?=
 =?us-ascii?Q?ZbaO1t3RLzcTVzjlQ/Aze9anP0PdDPEFK1PMk9zlXjcMPuIwfWK8wdc4WOIl?=
 =?us-ascii?Q?FMN3U3qnh/JunocWxD5KtrgP0JBrQIcn837n3LrbVAVnkZEf0O7K5qgZBDUQ?=
 =?us-ascii?Q?NnUr5d84l367FH8kdcV7GoFdH0azs9dUWdj8PXLUpC7TlMlosrQL2L4VG/hY?=
 =?us-ascii?Q?GUGtjZ6/QKKu6LyfgYTehoFrfB2FTYja88HozOVOVBpdT+YmqD05179f7PO5?=
 =?us-ascii?Q?m7h+mMFh1D1+6/g9kiuxwBHlsONEyTWSmGKz5YUNhhe5DLmnW9Wflwkv6lil?=
 =?us-ascii?Q?eMtst8lnnIFwTvK4eJ8i7xZmdy+mK/yW23EI4BODIHztJvROcaLMTzRo/x9L?=
 =?us-ascii?Q?liYJ1mRRd9ubEbb68pMTek2CAtFoYQ2VkUDOwwVpHRXwOLMyV0K9EFKLaV0L?=
 =?us-ascii?Q?l6Yf53DhLYEEMONegKyRhzFyse/LbW9Nq4mfghv78DrBEQaVsBCK4A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR06MB6020.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YMCq1jGnVeVcSSQrgjpkEtVFsAgMYIr97PkDwwsRdxwWFhxdau+DwgENmlgv?=
 =?us-ascii?Q?pInUGFBUVf3ZKShGeAqVjwQ64f10UCneDYwx0wJV35ppl4BDalhF9F+F0gqg?=
 =?us-ascii?Q?3F+3lPg8/TcJz1JCqnhaAezwlHgsbedzetZ54fjCgyqsNp/e64trAlbv9xY5?=
 =?us-ascii?Q?oGGW5Ix410Vv5ZIehJTDWi0FgkALeLlnXzvZVH2anfeAecwaEedz3t4dNBZB?=
 =?us-ascii?Q?eDJ2NPiSQtH7+sMJTIDbMPCxXt2nCraqjaQhjVuHyupw9NwpzQfAdRmEyixY?=
 =?us-ascii?Q?PnvoIKSOyotFPDFFYOlpb5XITtkgRB+K/rDe5XgX7ia5Y/T4OKyhO61wN1SQ?=
 =?us-ascii?Q?Qxv49rrzgB9+GLIV4iY0IY0IJeXg1ZI+0J/UJhSl5FuchxiUy0drTM2U4dSR?=
 =?us-ascii?Q?I21SUtPuiVbmkwaANXpzaN5yZ6jZTljtRQ6RTj211UFB8vzPr1AGsZevLPJ9?=
 =?us-ascii?Q?qu7xonHAoVu9Gg/uS1P8fFBxx1PHDbIR3GVzpow0qTlJit4WJXQpkF1rCC5T?=
 =?us-ascii?Q?HckuY71RPxbWdlHwy4DX/m6js6mT6jDhtzwv4BHGLj7pCY/FNgf90SCtRk6f?=
 =?us-ascii?Q?b3xXx87eKAWEQjBYqfLiKFasvNr9BFoopqWZGe030UWTrLMs4FOvOO6DAZiq?=
 =?us-ascii?Q?nWpsZQ9dBJ0cmThE7e5hfvSL7LXw2lTzaawmV9dcAQ+k/Ek1F7/zWMlkYq2H?=
 =?us-ascii?Q?NRGWlRg3Dhth4y4tn1MUu2NP4EYNeObGOYNvYhFIBSK2RHodsTcWFiMazIXB?=
 =?us-ascii?Q?UexNmVpGlrnAh8RCTdSr4CyttsaRCcs0kJxhC0iy+BEnS5M5/wBuOUdCcUFX?=
 =?us-ascii?Q?DGFDzKvZNj+siJL/MauDN8tF1ootE9FH2DDwp0PdFKdLEINj+Z/7lBSwiBQk?=
 =?us-ascii?Q?ot2AniSTRXwMP3siUhSL/gaOdJTRUUm8ZcHWAzAlpqKXmyt27LZitAZE1Z+i?=
 =?us-ascii?Q?frRJJHK9Deck1bK/lKNB7VHXkg0+AyQG3MMYLWCSk6QyPmfwfrqezlipm2e7?=
 =?us-ascii?Q?8n/hB/roBdaAPm3BmV4wmR+0lOUD/feFd3hmXgcMgKpaKnZ6bFVF/POapu2P?=
 =?us-ascii?Q?C/VfiMbknVhlr5UpkO37809LKt1w36BWLqeN9xdWqaeWHN+aOWZLl5qU8FzO?=
 =?us-ascii?Q?4kLDyyDhEu14CdDrKcgoIMVLaKBmnzwWLATk31iXqBN40R4OVrjWy5IJi2xK?=
 =?us-ascii?Q?cR2ovlgWlW7Jy2MXWcrQ5e/T7s+7bC/tmdmNC9jVW0JTgc355DtjbrVMrhuD?=
 =?us-ascii?Q?ijK24nLuEGt+Wk7kIeogBuA0XDo5AMr823I9oeAr2iXwDpBB4f+gKaACYUVg?=
 =?us-ascii?Q?WFSbr8mSPDN9Hll153OmBvG/PMfOImnHVOgnyet9jPQYdsbw0DQAHFGuZZZ+?=
 =?us-ascii?Q?jB9s5D5ovNFRPzS3shvJxz8861B44G4zWJ7XESRGwGp6OZ8K56Y/f8XhZsx+?=
 =?us-ascii?Q?m6ExxW4UfeZJlmvt5yzFqKod1tg26Auhy+jGZNyVdxhwgwuCnGank0BTEx/j?=
 =?us-ascii?Q?Arn0O4Nxz3r2walkh2hhH/CIF3goI2gGYJhi4ioO0v40fi+OZwrv4n8/7S2N?=
 =?us-ascii?Q?Z+wdrfy+9aMBHSMTCc4xaKlrS3iICNZRFnoxWI+E?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d4962e-950f-4eda-bd38-08dddf023d9e
X-MS-Exchange-CrossTenant-AuthSource: KL1PR06MB6020.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:24:47.4868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f5KC823d/1m5RXOVz/18tY1RGOFJnSzuKxMy23w/KRMxjIYDeWD/zF/0wne+a3po/DXi5Pki70VpuuBHFWuE+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB6657

The dev_err_probe() doesn't do anything when error is '-ENOMEM'. Therefore,
remove the useless call to dev_err_probe(), and just return the value instead.

Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
---
 drivers/tty/serial/max3100.c | 2 +-
 drivers/tty/serial/max310x.c | 3 +--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index 67d80f8f801e..552b808a1bb2 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -705,7 +705,7 @@ static int max3100_probe(struct spi_device *spi)
 			break;
 	if (i == MAX_MAX3100) {
 		mutex_unlock(&max3100s_lock);
-		return dev_err_probe(dev, -ENOMEM, "too many MAX3100 chips\n");
+		return -ENOMEM;
 	}
 
 	max3100s[i] = kzalloc(sizeof(struct max3100_port), GFP_KERNEL);
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 541c790c0109..79bec9509154 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -1269,8 +1269,7 @@ static int max310x_probe(struct device *dev, const struct max310x_devtype *devty
 	/* Alloc port structure */
 	s = devm_kzalloc(dev, struct_size(s, p, devtype->nr), GFP_KERNEL);
 	if (!s)
-		return dev_err_probe(dev, -ENOMEM,
-				     "Error allocating port structure\n");
+		return -ENOMEM;
 
 	/* Always ask for fixed clock rate from a property. */
 	device_property_read_u32(dev, "clock-frequency", &uartclk);
-- 
2.34.1

