Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794896065;
	b=TmUPXumx5Vni/zVeox2ijQvhO7Yso0SXGM+d95qNkgJ5eYyIk96V53CSjBxR/+oPsnsu
	 TRMnwWh3EDMlCInFc5bm5l8HOhDxatz2DGmzH3Br5p0Kny4S8x1DdHFw7kcEIUzZMD7Wz
	 ZZfY73eiYnEefHFcufjSCCqft3XSLFTE0PCrzy6m9VLV1McJ1zPIB9L1q9UDuxXSHFNc5
	 zEXeqmVKPMGCi3rGGHj+cn6bC3N2fok8oDHq9w/DsXCysGvtze9lL6/47HeaZDBWbKXDs
	 zTBDFgr/dyANF4IeVRH2AhZ4g1CKuyiEbl437Onxg8nef/rVWXo9OQ4XzkiqgGhw6cw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794896065;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:Date:Subject:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=9MZ8nzYv6UAVAU+yV6VFzBpd/adqqbZCQFbZvBaafIk=;
	b=jNsBqKbFFf/EBSkVEPRsCbgrEy3VQSHA7q5gSHJud8ol+2Svw4iFeem/UvGXWS5m35YC
	 ahQfVL76cPjMWK/b9q0LF94GX69OTcIljvb7gk2ssyw549cTrckgCaueDMG70RNupfits
	 tb0/iu07s/Lu6L6esa0oxr5wohIGqRXqQEkCJoEC2KHsKcnaOrsI6XXC1nFCBJl1sFJww
	 5nRiRGjuy8E649hRnvf0gbHslvSwmrOg+wh+kh6Vc8nKUYzfsy4AsAgBF9YtRhLTGk2ax
	 KSqeLqbK4TGty1S8yxI+McGGgMCgt9OwFAMN1yUJICcwxcuQnGqfc46hmBed6GQydvA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=vaisala.com;
	spf=pass smtp.mailfrom=vaisala.com;
	dkim=pass header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=NVrONtRp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.73
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023073.outbound.protection.outlook.com [40.107.162.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784CA606A33F;
	Tue, 17 Nov 2026 06:14:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 784CA606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vaisala.com header.i=@vaisala.com header.a=rsa-sha256 header.s=selector1 header.b=NVrONtRp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdpZCwdFtSx69SsANiFK7bJl4bC42jg/ENRnt6krL/qd5vASk9UzZ65tYZgYQFEpf5ga+H6+eGOmtjmgBo1SW9n/lCbrpMcgP7nEoxXgKzVBo2uD7wAInEY41/NNsAE+gS0f6lsLUSAIX+FQACG43RMpJDWfgWnrVtLZhXQQqNAZ+K6z5d9frcEQaPSHQuGnVyFTVT8pyxJxuCKjzqYVbi73v81tBrlHKw5kqWvFILOWLiNeZBhwl/l5VCOZWhIC3YaaAxA2aN3IaiZDUfbcKqaJbkeBH4DVhFCLnib2QulkWO9GY1CerfxhcpLORplMVwyzqC7MPeaKa6PRQRSXuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MZ8nzYv6UAVAU+yV6VFzBpd/adqqbZCQFbZvBaafIk=;
 b=n2uKOnaEoORUkV+YghBaQ+gIPblElrXaXstI70NzpJo9O3nvbRF+CoIyGAZVCNYvyY+IkXxUsEGYpCrplS6v3CErnlFZ1LVQx7tfxD/euzFLjkRz0SwXZkregz6xEmOKBWUDekQvOBGfJcUNhwuU9aniAJ5pX+aXlsbUcJfC5zjDAdb+xFwky9A+xb86H0940xTWWeiHZ7TIdjPtJOv7fGioDtPh/ALPxP4pMMGDLj1BRLm135sopz+Ax0LqY+aK9mE7uukqXdgm6bGtPgudNzqyHBlt4Mtt1Fg1AqiPLMGJlYLOtUW6lOIIO01Ke4sgJo/wpJJuep2K+Sz85MOBzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9MZ8nzYv6UAVAU+yV6VFzBpd/adqqbZCQFbZvBaafIk=;
 b=NVrONtRpbYsjdRPMSLaw7cIx2eQOcHNwV4tc8lahOSmsIHBWnm9ZypQBkEJyTEYBp9AzJHUFX1ENmhCJm1lX5S4Pbunx0242tVU984CiIVOcTVZbVtjQvDZpLuHH97ihfuUwYbxoZmcYKkC2+9zVmDTb3LjdKN6VAkq1WtrJKCveGNor1YvkEwXyO6pcSh30H3/2SfjL7w9nAmpjGGnVEHYIwgiCvoEcbKdFclzkqnNQhwY2viPEyR2Xt5dnXcWBZgDjIvpZI8Pn5sVaBCyoUUZxsLbO0BMVaIrhvm6JQcuYiJnQKcBVfBv2PuY1/STnV5Aq9W0TjlA3WIX/0MREbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com (2603:10a6:102:407::17)
 by DUZPR06MB8724.eurprd06.prod.outlook.com (2603:10a6:10:4b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 06:14:15 +0000
Received: from PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc]) by PA2PR06MB9176.eurprd06.prod.outlook.com
 ([fe80::b6d:8160:d324:3bfc%7]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 06:14:15 +0000
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
Date: Tue, 17 Nov 2026 06:14:07 +0000
Subject: [PATCH v2 4/4] serial: max310x: end the RTS envelope when a flush
 leaves nothing to send
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-max310x-tx-fixes-v2-4-b395126fd23d@vaisala.com>
References: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
In-Reply-To: <20261117-max310x-tx-fixes-v2-0-b395126fd23d@vaisala.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Tapio Reijonen <tapio.reijonen@vaisala.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794896051; l=2568;
 i=tapio.reijonen@vaisala.com; s=20250903; h=from:subject:message-id;
 bh=FpQ05ie+Fv7x+99zXSXY8YqYf5vbuZr8Iuuq4YzK990=;
 b=xEwSRraY2/t3v120HGUuuVa4K4lVn7UdhI+0eVxdmAnYUJZGOkKOGsq3/HcqiS44PvnGnV/At
 XbAqyHNmi5mBHPwsXBtfPCF8RPXU+CoStZFP0MlTJGdVDRmpb5mvcoR
X-Developer-Key: i=tapio.reijonen@vaisala.com; a=ed25519;
 pk=jWBz3VD84WbWgfEgIqB5iFFiyVIHZr52zVBPOm7qiGo=
X-ClientProxiedBy: GV3P280CA0020.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:b::32) To PA2PR06MB9176.eurprd06.prod.outlook.com
 (2603:10a6:102:407::17)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PR06MB9176:EE_|DUZPR06MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: daa5d308-52e1-415c-ea78-08df44720160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|52116014|1800799024|376014|18002099003|22082099003|5023799004|11063799006|10067099003|261026140227099003|261022075727099003|261022105027099003|261028144727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	gYNP4Kd+2gAIcG3mutXw9i/5J8sDD+URSosXs5Xlrk1DUTgPQbC3O5RcRiQ2ECzTvxGPhSR/jqoI1U2z9zd29zgsccJpYYQ5M4eFUOMs/x3B0TzN/ex3+JZW2lSivgVpTiQoMSbzQ0Bt/x92KwrzgHczDp4sRUpB6J2/Dmm9Vy9YWueJPJXNIDhjarzB4MW6pcU6jL2ekmfruSG55ql1gnt0wLDqU1x9pQD4Qpt5W1D1YqC0kq4pml9Z2gymPTp/LEyNOAglchrFbV7BjtOJJ31E4LRljx1EI8xxnoR6RXDv43jAoTVFPfat/7KDFonkJfrrH9Dj0CfM0kHBB5vGsYl2l+xq3oVEOdXjX3Kh5jKdgj6vYHwhnlnWUrNMyAZqxtAwfkRl9ZnJfbymAdXoo4kxdTv4tju5nQhv2gHAOQ43P0axu78P/VlC3uFmBsfry8OjvvoF4X+Xtxk9sWHn7h7mz2+R3fA5T2wQKfwg0YUpuCwg9uj/eUKnTtHi69n/se4v6ZrheqzorLJlhdtD2j+yw5vlO423g96ypsQJwGLQf0z8jtmJDQv7JUhYNXg7MHs4snXiR2QBa03O5ZVVDgQLvg6kOiMyFbjkM+rnYioWzO+eeSyAhWXvmGS5pQUzid0M4DkLtRwGQe52U1UuLS8ZQCv3yEoOijS8flqK4wU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA2PR06MB9176.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(52116014)(1800799024)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(10067099003)(261026140227099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2pEQmxpbCtSVGxDck9xbUtwMjZub3hJbktxWk9Id2dzbVVUVXBvWm8rNVR2?=
 =?utf-8?B?S0FpckpCMVllVUVZZ2xxMWNaeCtnc1NtSXFYWTV6K1l2eGtyVjVSVmlSbllu?=
 =?utf-8?B?S1ZMRk1VN254eEtvYnJCZXI3ckN2Y3lwaThkVTF2MWZScU5QWlFPNlkveXVu?=
 =?utf-8?B?VWxvT1I2clBSemJQeHhhd25rZGN3TExQT0tVWEpDaGp2dkNLMmRyVTlJRDVC?=
 =?utf-8?B?cXFNZmRkcUpIemJuK1ZLWGRZZ3p0Z2V4ZlZOK1djRG41NWlxTENETzFWU05H?=
 =?utf-8?B?bUY3TU9ZUVN0NFRWY0NuY281dGNwQ2RWeEFWTGFBbmNIT1dzZmw0UlBxenJK?=
 =?utf-8?B?MllkbXhRellrVzB0SXdYZFVmdEZqTlVJU21oVHJDQnF1WnBGdnBPSjk4RHp1?=
 =?utf-8?B?R28zSC81Nkt2N05OSkhoN2o1TndkWkJWVkxlWDF3UTFkcW4ydHhhQlJoMHpn?=
 =?utf-8?B?emU1NHcxNktWcEJxakFkSmRxMGhNRXVjOEpoQUUydEkxMVV2VVNNRFlkMHJP?=
 =?utf-8?B?MnlNMmU3c2ZtaHVoSmM4UER6RmFkTnVJblNsSXN6V3BVdmpuc0pSa2pVK3da?=
 =?utf-8?B?VWZaektIQzRHcGtTbVQrdUI0a3NYcHJOaGdtVGlBWllxRXliVko1UkZzc0NE?=
 =?utf-8?B?TkptZGxabXpqVHY0QXNyUVEwd3ZqR09DMHJsdnRGTkhDMGVQNWJiWmVlTXdE?=
 =?utf-8?B?cUs1dUF4bVBYK0d5Z2h5eEIxRVlXQmwvZng2Qkg3ZzMvaWVlUVgrNzd5bVRO?=
 =?utf-8?B?dHFyV0ZwRXdYelBjS01NaXpoa1JmeklGamJ0alhDRndPZzV1RTFiTlZFdzhk?=
 =?utf-8?B?R1lvc0JZK1ZqUnNpUkxic3Jrd1RXNlFmVXhvVzdMelU4ajFyeVF1R0NEODNS?=
 =?utf-8?B?WjE0NG9nckdCQ1dQMmtGQXJSYVU1a0M2djZZbnkwVFNwR05QLzhJOGhPVnc1?=
 =?utf-8?B?ZWtrUzBNWE9VRnlROEp6MVpuYUZkZUlvZ1lLUHltYTBhSU9vU3BTdGNzMG1S?=
 =?utf-8?B?c1h6cEl2VHVrZytGdDVtYW5VNTlTcE5PZzlCNWM4TDlrVnZzaU9UbmRNNmEy?=
 =?utf-8?B?dWpOMGU4eThTeVloSURzajRVZENacXZkRzNMVzlIMG9kQS9sY29YOGdQSGcz?=
 =?utf-8?B?S2NnT1hXeWtnL09vT3dLRzNxb2hFcFFDUmJ1czllM2hxS1FEYXBYTVFIRU4z?=
 =?utf-8?B?RndSVnpjNWtaanYxUWJTenJPcXVETEF2MVJkQVBPQTFKVmZiREhLQmd1WEdq?=
 =?utf-8?B?RERjeDRMS3Q0SXRFd3ZnZkgwTi9McTdVVTBOeDM0MFpHZmwwYUFPRm1IWVN4?=
 =?utf-8?B?d1p5cE81NVN5VW1ydUlDQ0dZeXZTVjF2VW9HSHY2YkYvWmd2TEtQNHpvM3Ri?=
 =?utf-8?B?MHdnK0taNVBDUkNUMUY3ZWxsSXpHNlBYMFQ2VHIxV0hVTjkyZEVzeW1kVzhG?=
 =?utf-8?B?Y05CTEFMM3RGOSt4Rjk4eDR6L0FRVkxCZFU5MWM0d21EbU03QzdMbVV3dGxp?=
 =?utf-8?B?czJNMytNdnMvOVE4WGZTbzJhaGgyZkQzRHpPMkExa1dGTzNydyticzZSeEdu?=
 =?utf-8?B?MHErd0NuTUNMcDhWWW04a25ta1FGaDRETm5HVTJaYkhQTkl2TE1WZzY3eHdj?=
 =?utf-8?B?a3JsVmlKenl4QlhKM0lFZ3NBcHNYb2VOb2VERmZHRWVVaVlzWEtWZ24zU2NY?=
 =?utf-8?B?WDhVUExWbEJ5Und6c2wwTENBWC92NzJqdno4WTh4bXg2R1k3ZlpSZkF3c0tt?=
 =?utf-8?B?dXVwbEVqQVAyOGxycUNLSGJ6VUx3TVNWSW12U2p6cWtyalROMWFVMVF1Uk8v?=
 =?utf-8?B?YkxCN3ZreEdhckZkeXlmSG55U2JsckdqUlFsNldJd2hNcHV2T0Z2K0MxU0tD?=
 =?utf-8?B?dDdSOHVMWjlIOHMwdTR4M0l5YW9JQVJDc1ZkbW9vYzZzTEQ4bWtRMUVuRW1M?=
 =?utf-8?B?OU1GcmNVYkVVdDNZK0thRDhuWG9kOEZTaWJobUs0eFFycEtMVzl1Sm1OdFVO?=
 =?utf-8?B?U1JweG5EZGRpZDJFL2puTjNHWFNidFpMMEpQTUhxa0cvUEVTMGljL0MxWnFF?=
 =?utf-8?B?RmhIbjUvam5mRDRpZitKNzF2c1R6bU80dHM2RzZYWDU0cGo3aU11emFMNHNG?=
 =?utf-8?B?Ni9uRklpRmtBWS8yMXZhdUphOVUwTVhqM3crM1hTWE5vWWJuSU1VY0hXT0Jn?=
 =?utf-8?B?ekw3R3M1YUUwcXBRbm1uMWZpMy8vRnFIQkp1T0ZnT1dSald5ZTFQTC81STdh?=
 =?utf-8?B?dklLazVKUXhrNTh3aE5HTnFWNklRNzFSUHlsYldkdjMxWC9Fa3ZtQUJ0U2Vj?=
 =?utf-8?B?bjhyemgxazM4ZzVSMlhiZmJDY1pLNWY3QVNQNG9YWTEzUkpLSDExY3pOcjhw?=
 =?utf-8?Q?JcJwqMOZ09Yt8UiA=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daa5d308-52e1-415c-ea78-08df44720160
X-MS-Exchange-CrossTenant-AuthSource: PA2PR06MB9176.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 06:14:15.0730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EyJMyjK9y0bDG9dTBkwkiixtaix1aLGAEpH+5402po77xt8PptpPvolBLEFmysuia2DvP4/h5YbKHPJiUlRzeAGsYaLoS+bcnxA+UvrqDjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR06MB8724

With software-timed RTS, max310x_handle_tx() ends the envelope only at
its entry check, when it finds the transmit fifo empty. If
uart_flush_buffer() empties the fifo after that check, while the
function reads TXFIFOLVL, the loop ends without writing to the chip and
the function returns. Nothing was written, so no TX-empty interrupt
follows. tx_state stays at MAX310X_TX_SEND and RTS stays asserted until
the next write or until the port is closed, and an RS-485 transceiver
blocks the bus for that time.

A tcflush(TCOFLUSH) timed to the end of the delay before send
reproduces it: 68 of 975 flushes left the port in the send state, seen
by a following byte that left without the delay.

Call max310x_delayed_stop_tx() when the loop has pushed nothing. It
returns when data is still queued or the chip FIFO still drains, and
arms the after-send hold otherwise. With the change, 9509 such flushes
left no port in the send state.

Fixes: 33632215e1bb ("serial: max310x: drive RTS in software when hardware delays are too short")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20261116-max310x-tx-fixes-v1-0-61c01f180911%40vaisala.com
Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
---
 drivers/tty/serial/max310x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index d92bf241558862cd83073c1d12ec9f0aaf88f090..4d8b7d79f2c9450a1e8c6d382710cbe526196ae1 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -923,6 +923,7 @@ static void max310x_handle_tx(struct uart_port *port)
 {
 	struct max310x_one *one = to_max310x_port(port);
 	struct tty_port *tport = &port->state->port;
+	bool pushed = false;
 
 	if (unlikely(port->x_char)) {
 		max310x_port_write(port, MAX310X_THR_REG, port->x_char);
@@ -976,6 +977,7 @@ static void max310x_handle_tx(struct uart_port *port)
 			break;
 
 		max310x_batch_write(port, one->tx_buf, to_send);
+		pushed = true;
 
 		/*
 		 * uart_flush_buffer() reset the fifo during the transfer:
@@ -989,6 +991,14 @@ static void max310x_handle_tx(struct uart_port *port)
 		uart_port_unlock_irqrestore(port, flags);
 	}
 
+	/*
+	 * Nothing went to the chip. If a flush has emptied the fifo since
+	 * the check above, no TX-empty interrupt follows to end the
+	 * envelope.
+	 */
+	if (!pushed)
+		max310x_delayed_stop_tx(port);
+
 	if (kfifo_len(&tport->xmit_fifo) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 }

-- 
2.47.3

