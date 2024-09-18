Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023141.outbound.protection.outlook.com [52.101.67.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609361BC062
	for <linux-serial@vger.kernel.org>; Wed, 18 Sep 2024 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.141
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676956; cv=fail; b=sVhIKtOosO3D5dfcjE+PQScA5eigPNYpNOxwwtmOHsmVY7r1CZbkHLboTlW95XEqMwcR+Dkh4ay8yi6YP90YQKzm4i4QRxDlmbB/w92AHTG44g0Sd5UK4PFxGQGHPpPBSxN6UcQ1NucC6CFTearAWpH4B25h8Nq+zjvepfPVE5s=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676956; c=relaxed/simple;
	bh=fjn7r1OY+gqcNmO/+zC3jepT5T8WREgsaTnBTE7eC18=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qgoeBOq/V06+Gn19nR9Hf4uF1ub1PfPvP2M7+5rOXA9Sh9sd0cCF8WbDaecAm9tQqKXgOSKkPgNYnhY2lW4a+yUcN/zeh7kCSM0iv+jBPciu2pCdyZO1Cqyw/4b4PjilzF0xCCKxKE5cLp8pAzNsdhIMucKAjWzZXoxpILn8OG8=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=B7CO2xdV; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=B7CO2xdV; arc=fail smtp.client-ip=52.101.67.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="B7CO2xdV";
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="B7CO2xdV"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BbkQpS3cDsjLLCxFm9WvTprMpp8qmBUd2m8EdDTfyxJQnPFFQqIl++pLo7IQSMof/y2iAKZhAi2T6oVSmtMn0G4sW25efzMDNOVbGYXP4xqPgDwyM8bA08i2ZN+3xTQQwcgMNBVxWUic9s9Mxp1DGjClZ5rLnBowcdRM8Omt0GGhFdVvwLNAs73+6aEyoJ+5Tm9Vfb58eD4EwsvXkC3TpTH/s3orl8cbl8hwL1maxz1niH2oEyOsuLrIJgXxVOaPEAT0ondlqSpqe6cx1EC2mXY+NQ2uTnG7N+/QCAmRQrWk1/UHUDd9amX7V2hArrnht+wP0XsnFgZR4Sx3mrhs7w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjn7r1OY+gqcNmO/+zC3jepT5T8WREgsaTnBTE7eC18=;
 b=ZM/bcXwxwI/hs/E9rwy4J75RNl8YeNeFpk1RlR4UVmJAWoQlgHibuJSHbaj4eLmeEEYoybRprRUFUvW9T3gkzRMb2AkcAQBEVTVjPiv2vsKy52rga4DSdUmrlwmCqMBB/zsqHGQKR2gWXcE+DJEYLMqioaJ9YptlLnG0sas8vmKBM6Dr7bWzIXtdBy3Dhg41jS/WRWiPKxmCL7Hs4jDxajFhQDk0/Hg0Lm0gm12kpEkH7I3l8zLfFK6LXGQ5vF4A4EMT8bUESOq4RDMbBNmFQynTsHiOAvX9lIZcHS3jyH8j5IloDYV1953Vvj6Sqybaz3UrknobkTRnEHdiP+QyFQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=pass (signature was verified) header.d=sttls.nl; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=sttls.nl] dkim=[1,1,header.d=sttls.nl]
 dmarc=[1,1,header.from=sttls.nl])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjn7r1OY+gqcNmO/+zC3jepT5T8WREgsaTnBTE7eC18=;
 b=B7CO2xdVxnJP8Wki2WAWMt6qpurBnrObeFMqtph4XrO7nzFNwnj2ECuoiVLxPf7foLA3ZdxqJK7TnD3RtpJwJhKcxwuHSx+86WcdnByb3x8lRGVDbOG5jS0Cw3dWQG+jRfJLIaq9hbH4YkPBLKwW+IJTdNP6i6Q+SmciaeYYZ8VdTktYf43vdaTKiIePDfmFNSkj+OG8cyUxQyXbE75yt56yMKxxnCkDBGA1AkfsG9IztbWprqn6fS360qh0T7+tDxz40Y23tDrx/UZeyvd565KiZJdbwyN6wOIwo0QMbuAqHueFJZjr5B5Xbz2vsAQSUj7A+7MY84H9nfPb18eRLA==
Received: from DUZPR01CA0081.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::6) by AS2PR05MB9887.eurprd05.prod.outlook.com
 (2603:10a6:20b:5f3::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:29:04 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::bc) by DUZPR01CA0081.outlook.office365.com
 (2603:10a6:10:46a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.30 via Frontend
 Transport; Wed, 18 Sep 2024 16:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=sttls.nl; dkim=pass (signature was verified)
 header.d=sttls.nl;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 18 Sep 2024 16:29:03 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (104.47.17.104) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Wed, 18 Sep 2024 16:29:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GYNXSnL0UAZ7j2CpgWZSgyZiyKZA37BOsp/wDLzOOPivxOLctyFGYBOc9xs8Zj7IDmV2+5b8FHfzNL5ixgBXrBvWq+N+trX56uPQMxBZFBnTeKVL829337Xber9D1flSnOAwUo4bK9YNcQ4YaGPp2zOcKK7f1Y0wucAhXNS2nzPzJEaI70LElXiAbxRUqOxIlzR7KGoSS2+85V3Ct+GmFGP//FRTSAbiojMg/8KTe+V/+BATX9kfdEzH379lAoAIzpXcjqaiyM7PsSqUgBTNAWg2iXD14qNriPTU2xW0HdlzdP/wf+bMXH9/rV+w9dyUC1w9R9XWxXouWx/XKRSU8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjn7r1OY+gqcNmO/+zC3jepT5T8WREgsaTnBTE7eC18=;
 b=c/qrR30JfFhEsKnoK62DyGCVKJwM8gl7Is0Ti0s7CXfslWZgw+ZLETj0FHoJjXqAJfvvmdnJcQvoiT6xkO4F+YmmFbwy11z/H+zWyLi1T8Wx52swcFnJonEz65rkv1KQ8CS4+TxCpD5b9KXXqYclpO/obHWzT8j/H3Q7e3gPwqZLoqBuX1W2wJ43/EWs/6/XWNIkUoxHGUnPWSc26MqpTyK4Gk+6LJUJyXgSAgfcP5RpAeIGJ19XCDIQoaw71Gm5YGgOS04FlE1hW9KjSBzhcRxcFbIS68vq7sPuGssv6OLc6QW5kfiYtz1KIlptrJAY8FBCdTd9V+1X4NbrBkLomQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sttls.nl; dmarc=pass action=none header.from=sttls.nl;
 dkim=pass header.d=sttls.nl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjn7r1OY+gqcNmO/+zC3jepT5T8WREgsaTnBTE7eC18=;
 b=B7CO2xdVxnJP8Wki2WAWMt6qpurBnrObeFMqtph4XrO7nzFNwnj2ECuoiVLxPf7foLA3ZdxqJK7TnD3RtpJwJhKcxwuHSx+86WcdnByb3x8lRGVDbOG5jS0Cw3dWQG+jRfJLIaq9hbH4YkPBLKwW+IJTdNP6i6Q+SmciaeYYZ8VdTktYf43vdaTKiIePDfmFNSkj+OG8cyUxQyXbE75yt56yMKxxnCkDBGA1AkfsG9IztbWprqn6fS360qh0T7+tDxz40Y23tDrx/UZeyvd565KiZJdbwyN6wOIwo0QMbuAqHueFJZjr5B5Xbz2vsAQSUj7A+7MY84H9nfPb18eRLA==
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com (2603:10a6:20b:5c2::16)
 by GV2PR05MB9784.eurprd05.prod.outlook.com (2603:10a6:150:b5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 16:28:59 +0000
Received: from AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734]) by AS8PR05MB9810.eurprd05.prod.outlook.com
 ([fe80::841e:3b57:8c60:5734%7]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 16:28:59 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Linux Serial <linux-serial@vger.kernel.org>
Subject: [Resend] Poor documentation of SER_RS485_RTS_ON_SEND and
 SER_RS485_RTS_AFTER_SEND
Thread-Topic: [Resend] Poor documentation of SER_RS485_RTS_ON_SEND and
 SER_RS485_RTS_AFTER_SEND
Thread-Index: AdsJ59yoy5GO+iEFT3a7zJ9d7x+P7w==
Date: Wed, 18 Sep 2024 16:28:59 +0000
Message-ID: <AS8PR05MB981015FDD73CA4562D3EE05383622@AS8PR05MB9810.eurprd05.prod.outlook.com>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	AS8PR05MB9810:EE_|GV2PR05MB9784:EE_|DB5PEPF00014B97:EE_|AS2PR05MB9887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d913300-367a-461d-af97-08dcd7ff0276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?utf-8?B?VG1mdlBZeHA1ZzVac2NrR0JsMUJpYWxqb25PWjhKWmxvS2NCRUNCVjVrNFhM?=
 =?utf-8?B?ajYzWXJnQXpOVW9WcFhFMlVTSlhBYm9XS3NwTmRUQnkzeEx1a2xDeHZxc0pV?=
 =?utf-8?B?bWRmeDFvVjFmUjhGRFg4MnR2R0tCdzE5Wi9VSCt1eG5QTjc5d2FlVFpVSXMy?=
 =?utf-8?B?dXdBY2ZmSFN5RTA4Y2s2M0dSSTNIYXVRT1JPeFBKbVl4Ky9tOHJrUTlaQ0o3?=
 =?utf-8?B?SzU5K0NsVkJWN2RUbVZxSHpvd2NVL0pJZ1JXVE8rM0NZOGhYL3RoREZUYzFC?=
 =?utf-8?B?R3JweFpEN0ZwUnBuZGpTNXFwdE51MjZDN0ZjS3VXazM1Z2FnSklCMU5WR3ph?=
 =?utf-8?B?YXZ5RU14WHhMczRyZEI2eHhxcE9zM1ZDYTFRYWZyeGZsdXo3cFdnRHp5NDZR?=
 =?utf-8?B?NFBGZE8xMXU1L3U3MzBDZ0R6UDN3WkJNdGVyOUlyeUhCaktIQmdyUHBXV0ww?=
 =?utf-8?B?Q09FSHhwYnVpa25PWUZaZzArUEV3LzR6ZXRtZW5nTmswQXMrTWlmeU05NDFW?=
 =?utf-8?B?d21tUGlBSkl3VUlib0RTRXJzWklUMWc5bGFseHVIRzE1bWdMNHdxVGZ6aUND?=
 =?utf-8?B?dHRoVS9KY0F3NXR3bXlzWDhlc1plYm1GdU9jaEI0aWoxMFJWZ0tMQWk3VmE3?=
 =?utf-8?B?YlJmNUR1ZmxqYi81ZnZyYWtROU5zbmhsL3ZhbytxbGxVSVg0R1d3dUFPbU12?=
 =?utf-8?B?alJhZzdNdXp5LzdkNTZSeFFuTVlGM29jaHQ4S2V3MlVzUCt0UUhqSDN4OFI3?=
 =?utf-8?B?NGl6Y0U1MnBMRVcrVG1vbldoMEpwQk1HcGt6aHRIMGxza0wzQWRGRmJ0OFdq?=
 =?utf-8?B?Zk1aRmI1cHZuMVNBMmxnSmJWK0JJZW9KWFNHU05UbTdFcUxHbjl2UnBwQTBa?=
 =?utf-8?B?azE1NXE0eHdDSStBSGE4MmpycE9xZ2YyZVkyMW82aGx4a21URk9qVW9qaTZ2?=
 =?utf-8?B?WmVzak16K0JHV0hNZ1c2cXVBazMxYlNJVlRFWkYxYWJCMWQxWXBkbmxDQ0Vz?=
 =?utf-8?B?allPQnRXVUYrM1IxcGR3T1Y3ZGpzZGdDNmk0cVFUZkJTTWRWY3BCb296YVhp?=
 =?utf-8?B?MitUOWhCdVYzL0pGOEdRZ1BzLzJNMHd0R0hWeERnOTB4WXk2dEhRQkxHdFJC?=
 =?utf-8?B?NFNHN2w4SUJwbTZObko5dWdsZ21OSFo4d0p2VDF2Q1U0WHE1ZEFEZXNaYW1K?=
 =?utf-8?B?UExleUJJZXZ4R01ENDlXaVhaYmN6azVTNVV4MU1QRlVtNnh0NUJGSURUVXk5?=
 =?utf-8?B?QmtlK01oYlRKSWtPYlhuZnVtcWVyMjdLSWNBdE9TSVh0d1VUMUN5TGNVRGRH?=
 =?utf-8?B?Yyt1bGpmVitLbWdWU2FKR0g3SHF4dEduUTRGWnF3YWd2Nnh6aWt0K2RVZ0hl?=
 =?utf-8?B?UE1DRG5DMUJpVFZNa0QxMWtVV3MyNDFOOGQyUWh4WDE4MmVGS01ELzBrZWd3?=
 =?utf-8?B?Vm1xYVpSV1ZiVjYyaEgrZytldkxRZC9xdGVUdHlnWE83bjd3UlVKZVhIVXh3?=
 =?utf-8?B?V0d2UWNWSlNQU2QxV3QwU3pIVGM4WGlKUjMwb2VkaFlrQmwweXhJRFJxdlZT?=
 =?utf-8?B?Vkl5ZzZFNXc5SVd5NXJFLytFeVhFYktBMnM2ZHpCcHFXMC92UzJ3TXdFRVZH?=
 =?utf-8?B?SWRxSy9BV1BtWWJTR1RueS9OWTdTeGhiWllPVFJtVk14NGJMRXZQRFdkcHRv?=
 =?utf-8?B?OHIxNTFYOUpkWWlyUWR0NDlKcDBMMHV4VFhsOEFTOUsvQTdHQ1AzemVzcS8w?=
 =?utf-8?B?YXZyMW1EWXpFZlRnZjQ0d2dRSWttMGx6cnB6V2VwbElYVGpha0ZSYzlWZysz?=
 =?utf-8?B?bENuTy9YK0U4OGJSZzVpTVBmZXNiYkRJWmh0L0FtbmFrTkgyamVPUUk0Vm5w?=
 =?utf-8?B?NzkvNThKUW9WSkRDS1JOTzY2V3NjQ0MvUEYvc1Ura2xQb0E9PQ==?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR05MB9810.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR05MB9784
X-CodeTwo-MessageID: 4ad8a748-f139-4591-8249-b21e78f5ac75.20240918162903@westeu12-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	21894b0d-81ad-4813-428f-08dcd7feffaf
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|35042699022|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ejAzMmhIaS9qRnJKM3gwRFdwNkVQTC83cDcybFh4TklSQXM4Y2ZHN000ME9S?=
 =?utf-8?B?UTdyVjZTdm42N2xkcHVRZ2xtY1RrejN4VmMrcjg4K1hyaEI5cTNDUnZ4cWJB?=
 =?utf-8?B?UzNCbGZqMXlPVC9acEhJa29wZUFBSDdqblZNSDhScXdtME4ydzlES2VKa2l0?=
 =?utf-8?B?VUwyclh2SjFvYTlxQzk3RjJNNGlxTmxpUGtLZGRTeU53bVI1V2hmRDAzcG1u?=
 =?utf-8?B?c1V6cXkvV29jMkt0S1dXSVVPWW0xUnMvYkVKQTJLKytxUXFiVnk4MlYxT0ZC?=
 =?utf-8?B?S0d6dnN6YWx6TUxmWHhpTWQrZk12RjJIakJOM1R4MWhReHVDSW9GQ3laNEdo?=
 =?utf-8?B?L3R3NVhkVitRYm1ibkk2czErdWRsQ3NCNTBYS1M5c0hFUThjZ3I3TWpZU2Zh?=
 =?utf-8?B?UFpoSG93L2NWTTFkenhWc1VyaWU1S3pWcmxMT1VnbWF0NUJXVzUwODBnWUJ5?=
 =?utf-8?B?amRucldrdW1QV0syVGE1d0dBQzAzTTBWYnhXNmxYa1lqZ0pSSmlkZ3BFOG81?=
 =?utf-8?B?NTRXMm1MdlZ6V1NsREQzb09QREJac3ZXSmtDdlNwUklLaXZEU3VpTHFQTkdB?=
 =?utf-8?B?SzUvdkRnaXpNRUtlSXhINTZWeXNvcXY3ZVBlTndEdWpVKzY3T3NwTFhtTWJH?=
 =?utf-8?B?NUFhOUxwUW05ejRWSmhrUk5WeTJ3MWxJU0owbmtoZ3drZ25vUVJrajJhOExm?=
 =?utf-8?B?Z2MybFVLbXBDSXN4bnlEa0o4b2wzQzhxeWllL05nbFBkY3JzTG1iRFRaQWF4?=
 =?utf-8?B?eGVERERadU9lRHJ5NTBKaXJYb015d3VESUMvbWxacGJsL0Y3VHA5LzhENFV0?=
 =?utf-8?B?UUYrbjU1eU9QTFBiMjRqczhPMjF0UThkUDFIODYzeGpGVkVCakU2bnMzKzNw?=
 =?utf-8?B?RmlsZjFPbXp0Rld4RTFidklpdlZYamtmbERSYmlFQVd5bStSaDQwQ1AwZkxH?=
 =?utf-8?B?Q25IZFF5UUdSQjN6VFZTUHp3TEpRR2d2c2FaTmNud3pnUjBZVVFSRW1hZXQw?=
 =?utf-8?B?enNmenRDUUJxTzJmTVF3L1VWTGhjUnZaeFRiVkwwRzlFYzE0a1R6bWFwMU1P?=
 =?utf-8?B?dEpsVWxyVFIxVkZaSUtpdXc0U2NIMkJ1NTZkSFpxWUl6Y3A2YUh2bUVTQlov?=
 =?utf-8?B?NzVaLzRvakoxNU9keHpjWk9WaWVQaEpYSjdkWEd5MW1BZWFoNlUxSzM1R0d5?=
 =?utf-8?B?ZW1XSXlMUTg5bVd1SUo5L2V2K2U3dnYrSWFZT3FmdGtYUHRFNjlrTDFKUXk2?=
 =?utf-8?B?ZytJSXF3aE43ZkVZT0FzY3pua3QvdzhPT3VuUE5JaG1OQTZIclcyRjdsQWE3?=
 =?utf-8?B?SjdHYW1UMWVCZ3dlaGhVYnVFM0owWWo0bi9UK1oxbDBPQkgySmYrT0tESWg2?=
 =?utf-8?B?a0t1ck90NklCbzlEbGJ5cEFNRmRqZmJyTVhQNTJSY1lMYkkzdHRYcC9VUm0w?=
 =?utf-8?B?VC9mNkJFczNxL21iTnB3Z1hCUWxyOEl6UG5CSUJnSDFZZkpseTI3M1hEMndr?=
 =?utf-8?B?SndyTzFrYmJhbjQ2R1BVcVViVmxndFQ2Y0VnWTlMckJJbllmZDVTdngwSTB6?=
 =?utf-8?B?TmM2MnBlR1RRcCt4NVRnaWpkeGlPZ0wyMGxaMi80RWp5QlJpRmRPQmtxLzYx?=
 =?utf-8?B?SityYzFHYXlLK1QrZkJucU5OUXBVU2pqYWFkNXV6azczbENVTTJLc0hLdkZL?=
 =?utf-8?B?TlpmRnRTYjBYbExNcjI1VHhmOTJTVFpIQVd6WGF5anlpbmxJdVFsMjAycThv?=
 =?utf-8?B?WTZyZnpjbytpYXkyT3JtUTh2T2xIQS81UDM5NENCM0ErQjdoT3hVQnE3TGZp?=
 =?utf-8?B?dURvUmZ2TGpUU1gzSCtTR3hWSWE0Z1FEanZ3NE9qTzRTckZRSytNck9RYlFO?=
 =?utf-8?B?QVNMK3pZNGlOZGdHa3F3cU1KWGdQM0o2S28zWDQ2bWdsYzNwSmY0Z1VOMlVW?=
 =?utf-8?Q?7JayjsiP97LTUpbXjWsaMDTI0eDgoDLw?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(35042699022)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:29:03.7420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d913300-367a-461d-af97-08dcd7ff0276
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR05MB9887

SGkgYWxsLA0KDQpJIGhhdmUgc29tZSB0cm91YmxlIGZpbmRpbmcgb3V0IHRoZSBtZWFuaW5nIG9m
IFNFUl9SUzQ4NV9SVFNfT05fU0VORCBhbmQNClNFUl9SUzQ4NV9SVFNfQUZURVJfU0VORC4gVGhl
IGRvY3VtZW50YXRpb24gc2F5czoNCg0KbGludXgvc2VyaWFsLmgNCj09PT09PT09PT09PT09DQo+
ICogKiAlU0VSX1JTNDg1X1JUU19PTl9TRU5ECS0gTG9naWNhbCBsZXZlbCBmb3IgUlRTIHBpbiB3
aGVuIHNlbmRpbmcuDQo+ICogKiAlU0VSX1JTNDg1X1JUU19BRlRFUl9TRU5ECS0gTG9naWNhbCBs
ZXZlbCBmb3IgUlRTIHBpbiBhZnRlciBzZW50Lg0KDQpQcmFjdGljYWxseSBhbGwgVUFSVCBjaGlw
cyBoYXZlIGEgLVJUUywgL1JUUyBwaW4gb3IgUlRTbiBwaW4gYW5kIG5vIFJUUyBwaW4uDQpBbmQg
d2hhdCBpcyB0aGUgbWVhbmluZyBvZiAiTG9naWNhbCBsZXZlbCIgaGVyZT8gSXMgaXQgdGhlIHNh
bWUgYXMgTG9naWMgTGV2ZWw/DQoNClNob3VsZCBJIGNvbmNsdWRlIHRoYXQgc2V0dGluZyB0aGUg
U0VSX1JTNDg1X1JUU19PTl9TRU5EIGZsYWcgc2hvdWxkDQpyZXN1bHQgaW4gdGhlIGxvZ2ljIGxl
dmVsIG9uIHRoZSAvUlRTIHBpbiBiZWluZyBoaWdoICg+IDBWKSBkdXJpbmcgdHJhbnNtaXNzaW9u
Pw0KQW5kIHNpbWlsYXJseSB0aGF0IHNldHRpbmcgdGhlIFNFUl9SUzQ4NV9SVFNfQUZURVJfU0VO
RCBmbGFnIHNob3VsZA0KcmVzdWx0IGluIHRoZSBsb2dpYyBsZXZlbCBvbiB0aGUgL1JUUyBwaW4g
YmVpbmcgaGlnaCBhZnRlciB0cmFuc21pc3Npb24/DQoNCnJzNDg1LnlhbWwNCj09PT09PT09PT0N
Cj4gICByczQ4NS1ydHMtYWN0aXZlLWhpZ2g6DQo+ICAgICBkZXNjcmlwdGlvbjogZHJpdmUgUlRT
IGhpZ2ggd2hlbiBzZW5kaW5nICh0aGlzIGlzIHRoZSBkZWZhdWx0KS4NCj4gICAgICRyZWY6IC9z
Y2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL2ZsYWcNCj4gDQo+ICAgcnM0ODUtcnRzLWFj
dGl2ZS1sb3c6DQo+ICAgICBkZXNjcmlwdGlvbjogZHJpdmUgUlRTIGxvdyB3aGVuIHNlbmRpbmcg
KGRlZmF1bHQgaXMgaGlnaCkuDQo+ICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZp
bml0aW9ucy9mbGFnDQoNCkNhbiBJIGFzc3VtZSB0aGF0IFJUUyB1c3VhbGx5IG1lYW5zIHRoZSAv
UlRTIHBpbiBvbiB0aGUgVUFSVCBjaGlwIGhlcmUuDQoNCkxvb2tpbmcgYXQgdGhlIGltcGxlbWVu
dGVkIGRyaXZlcnMgZG9lcyBub3QgbWFrZSB0aGluZ3MgYmV0dGVyLg0KDQpTb21lIGRyaXZlcnMg
dGhpbmsgdGhhdCB3aGVuIHRoZSBTRVJfUlM0ODVfUlRTX09OX1NFTkQgZmxhZyBpcyBzZXQgdGhl
eQ0Kc2hvdWxkIHNldCB0aGUgUlRTIGJpdCBpbiBFLmcuIHRoZSBNQ1IgcmVnaXN0ZXIgd2hlbiBz
dGFydGluZyBhIHRyYW5zbWlzc2lvbiwNCndoaWNoIHJlc3VsdHMgaW4gdGhlIC9SVFMgcGluIGdv
aW5nIGxvdyBvbiBFLmcuIGEgZ2VudWluZSA4MjUwLg0KDQo4MjUwX3BvcnQuYw0KPT09PT09PT09
PT0NCj4gLyoqDQo+ICAqIHNlcmlhbDgyNTBfZW00ODVfc3RhcnRfdHgoKSAtIGdlbmVyaWMgLT5y
czQ4NV9zdGFydF90eCgpIGNhbGxiYWNrDQo+ICAqIEB1cDogdWFydCA4MjUwIHBvcnQNCj4gICoN
Cj4gICogR2VuZXJpYyBjYWxsYmFjayB1c2FibGUgYnkgODI1MCB1YXJ0IGRyaXZlcnMgdG8gc3Rh
cnQgcnM0ODUgDQo+IHRyYW5zbWlzc2lvbi4NCj4gICogQXNzdW1lcyB0aGF0IHNldHRpbmcgdGhl
IFJUUyBiaXQgaW4gdGhlIE1DUiByZWdpc3RlciBtZWFucyBSVFMgaXMgDQo+IGhpZ2guDQoNCldv
dywgdGhhdCdzIGFuIG9kZCBhc3N1bXB0aW9uIGZvciBhIGdlbmVyaWMgODI1MC8xNng1MCBkcml2
ZXIhDQoNCj4gICogKFNvbWUgY2hpcHMgdXNlIGludmVyc2Ugc2VtYW50aWNzLikgIFsuLi5dDQo+
ICAqLw0KPiB2b2lkIHNlcmlhbDgyNTBfZW00ODVfc3RhcnRfdHgoc3RydWN0IHVhcnRfODI1MF9w
b3J0ICp1cCkNCj4gew0KPiAJdW5zaWduZWQgY2hhciBtY3IgPSBzZXJpYWw4MjUwX2luX01DUih1
cCk7DQo+IA0KPiAJaWYgKCEodXAtPnBvcnQucnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlhfRFVS
SU5HX1RYKSkNCj4gCQlzZXJpYWw4MjUwX3N0b3BfcngoJnVwLT5wb3J0KTsNCj4gDQo+IAlpZiAo
dXAtPnBvcnQucnM0ODUuZmxhZ3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpDQo+IAkJbWNyIHw9
IFVBUlRfTUNSX1JUUzsNCj4gCWVsc2UNCj4gCQltY3IgJj0gflVBUlRfTUNSX1JUUzsNCj4gCXNl
cmlhbDgyNTBfb3V0X01DUih1cCwgbWNyKTsNCj4gfQ0KDQpUaGUgbmV4dCBvbmUgYmVoYXZlcyB0
aGUgc2FtZSwgYnV0IG1ha2VzIGEgZGlmZmVyZW50IGFzc3VtcHRpb246DQoNCjgyNTBfb21hcC5j
DQo9PT09PT09PT09PQ0KPiBzdGF0aWMgaW50IG9tYXA4MjUwX3JzNDg1X2NvbmZpZyhzdHJ1Y3Qg
dWFydF9wb3J0ICpwb3J0LA0KPiAJCQkJIHN0cnVjdCBrdGVybWlvcyAqdGVybWlvcywNCj4gCQkJ
CSBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkNCj4gew0KPiAJWy4uLl0NCj4gCS8qDQo+IAkg
KiBSZXRhaW4gc2FtZSBwb2xhcml0eSBzZW1hbnRpY3MgYXMgUlM0ODUgc29mdHdhcmUgZW11bGF0
aW9uLA0KPiAJICogaS5lLiBTRVJfUlM0ODVfUlRTX09OX1NFTkQgbWVhbnMgZHJpdmluZyBSVFMg
bG93IG9uIHNlbmQuDQoNClNob3VsZG4ndCBTRVJfUlM0ODVfUlRTX09OX1NFTkQgbWVhbiBkcml2
aW5nIFJUUyBoaWdoIG9uIHNlbmQ/DQoNCj4gCSAqLw0KPiAJaWYgKHJzNDg1LT5mbGFncyAmIFNF
Ul9SUzQ4NV9SVFNfT05fU0VORCkNCj4gCQlwcml2LT5tZHIzICY9IH5VQVJUX09NQVBfTURSM19E
SVJfUE9MOw0KPiAJZWxzZQ0KPiAJCXByaXYtPm1kcjMgfD0gVUFSVF9PTUFQX01EUjNfRElSX1BP
TDsNCj4gDQo+IAlzZXJpYWxfb3V0KHVwLCBVQVJUX09NQVBfTURSMywgcHJpdi0+bWRyMyk7DQoN
Ck90aGVycyBiZWxpZXZlIHRoYXQgdGhleSBzaG91bGQgY2xlYXIgdGhlIFJUUyBiaXQgaW4gTUNS
IGZvcg0KU0VSX1JTNDg1X1JUU19PTl9TRU5EIHdoZW4gc3RhcnRpbmcgYSB0cmFuc21pc3Npb24s
IHJlc3VsdGluZyBpbiB0aGUNCi9SVFMgcGluIGdvaW5nIGhpZ2guDQoNCjgyNTBfYmNtMjgzNWF1
eC5jDQo9PT09PT09PT09PT09PT09PQ0KPiBzdGF0aWMgdm9pZCBiY20yODM1YXV4X3JzNDg1X3N0
YXJ0X3R4KHN0cnVjdCB1YXJ0XzgyNTBfcG9ydCAqdXApDQo+IHsNCj4gCVsuLi5dDQo+IAkvKg0K
PiAJICogT24gdGhlIGJjbTI4MzVhdXgsIHRoZSBNQ1IgcmVnaXN0ZXIgY29udGFpbnMgbm8gb3Ro
ZXINCj4gCSAqIGZsYWdzIGJlc2lkZXMgUlRTLiAgU28gbm8gbmVlZCBmb3IgYSByZWFkLW1vZGlm
eS13cml0ZS4NCj4gCSAqLw0KPiAJaWYgKHVwLT5wb3J0LnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1
X1JUU19PTl9TRU5EKQ0KPiAJCXNlcmlhbDgyNTBfb3V0X01DUih1cCwgMCk7DQo+IAllbHNlDQo+
IAkJc2VyaWFsODI1MF9vdXRfTUNSKHVwLCBVQVJUX01DUl9SVFMpOw0KPiB9DQoNClNhbWUgaGVy
ZToNCg0KODI1MF9wY2kuYw0KPT09PT09PT09PQ0KPiBzdGF0aWMgaW50IHBjaV9maW50ZWtfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsIHN0cnVjdCANCj4ga3Rlcm1pb3MgKnRl
cm1pb3MsDQo+IAkJCSAgICAgICBzdHJ1Y3Qgc2VyaWFsX3JzNDg1ICpyczQ4NSkNCj4gew0KPiAJ
CVsuLi5dDQo+IAkJaWYgKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9SVFNfT05fU0VORCkgew0K
PiAJCQkvKiBSVFMgZHJpdmluZyBoaWdoIG9uIFRYICovDQo+IAkJCXNldHRpbmcgJj0gfkZJTlRF
S19SVFNfSU5WRVJUOw0KPiAJCX0gZWxzZSB7DQo+IAkJCS8qIFJUUyBkcml2aW5nIGxvdyBvbiBU
WCAqLw0KPiAJCQlzZXR0aW5nIHw9IEZJTlRFS19SVFNfSU5WRVJUOw0KPiAJCX0NCg0KQ2FuIHRo
ZSBsaXN0IHNoZWQgc29tZSBsaWdodCBvbiB0aGlzIGFuZCByZWFjaCBhIGNvbnNlbnN1cyBoZXJl
Pw0KDQpLaW5kIFJlZ2FyZHMsDQpNYWFydGVuDQoNCg==
