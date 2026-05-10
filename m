Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D79038837B
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420499; cv=fail; b=AzSYfXekgdCwdEA/gqGiG9vZrgjSpVeBcWTijEwQDp5tVdls5V/g6F7aLgkiW4xxQZlDeH/oaHq6hWBjYA7aVhtU0lyM4PwpbLPak2o25A4D0oQ07broZ8G/Ytz/Hcm8UOvp3WppOV1e8u59kQTUEsSTlrQ21n8AwdDcc1wakEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420499; c=relaxed/simple;
	bh=V0LEyGBvVQ3TZ7h0mLbKHl6j3l3uQ4pKeTp9KQgewLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YJG29W0dKmII64zWCxGgfRvYhOBi/7VxVF5N5ZV70axkGaScqQ5iTEL7x1yrJ9F9DhgFZRXDb+XpxmCuHdLBItqsOoYXIjcVgG4DMrV+l7ZFIzgt7F+Qm10bevmOQFkZeepbFNhYBAuLMuUnY8v7rmd0qHOF6lwg7BZomBwX11k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=K+uhAbht; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="K+uhAbht"
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADbkdT3718317;
	Sun, 10 May 2026 06:41:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=L1JW+ejZAfbRbYW9N6IOjlsXTG+Aep98p/1A7Ca0OOc=; b=
	K+uhAbhtvp+1asa17hjsMEi+k+NsyWYKt1oX1OLFGCuAGQOQMAOV7ZLdQw/BgA1G
	GH6AYXjQzDCL7WDzG+JMNiDXqrtL3DzJ8X9L5r3UcNL1+WZExpqbY+hmYGwEEluH
	N/STTxSUHVA3In/UvERv8bf7Ygff0OkuvYXpI+/f++A2UZgyAs2U4oL4VeovThtz
	ZZK2Lzb4k1dqN4xMDsliZqGEpqjJIUgJJyxcQ7RxGCjLN/sTh8Ro8SNDddBZyb8b
	K1uUQkOjjFIfdXlLVxyyQromQ+miEKTvFWrccBUU0gl8eHf5MUoxoPGOhPCHXyeR
	iq3jIirR/NcyHMHc9wBuDA==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012060.outbound.protection.outlook.com [52.101.43.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e24ee8qfb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kwsRhBflOpLn1Yh4qFCnkMFlpkMYlU7EPVKU/JsINsvm3t3IvINsKtolgIBGKbbP0lHpVYlVFmFNpVjc5RYVNr3jahXlSPV5ehsn/StM2Dg12Dzw2hDfNTId2yp9Nvb8v69AXDTro6YcnL0fKNFZagIakVtcmoBTVuGYurVQ0Oja/gHB0N0INPbHjblYqK2sZe+nLjRh8ODWU+576oAskvPMZ7B5JSK7UZIXmBshTuD/lo8IKM+rktrG+CDNbrWafgT1pO0UqsD1TOeZTejHqJPtALMKr4HqObG2sMB1vABRa71aivKDgLomt0oKSvDa0tDP1sgQWuSbXGTDty2Zeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L1JW+ejZAfbRbYW9N6IOjlsXTG+Aep98p/1A7Ca0OOc=;
 b=bvlXd460Lp5YHXyr/BFZOjCtwC4W4XJOZwVIFT0WJTTq2XRbvSBVi3AYULBdZldgPt0OJEVzik62fvoaeB/8qdlFtAW7+/Tqiw8azLdN6ScGWJAKZirT5jKgpMGblcAqbSPBxo17QdBaZZem1gaYuNUpYKL+q9LI4ahATXkuDdGs7UkI3n5lGgZAcFsHXBrRd3+FD0/99SRwXE5fyh/iBPM0pZ3EX+xAqWkmsMZ42tDAzkJoS81Fim/cAAEDi+JIsCy+cW48/0v2Y7+yiW8g0Njjj2iVw5lf6losKUCCDD22JKQP5REHPFkc3U6BenujEx4f3V/LNi18ymebfDFwTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 13:41:23 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:41:23 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        stable <stable@kernel.org>, qianfan Zhao <qianfanguijin@163.com>,
        Adriana Nicolae <adriana@arista.com>,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 8/8] serial: 8250_dw: Ensure BUSY is deasserted
Date: Sun, 10 May 2026 16:40:11 +0300
Message-ID: <20260510134011.618215-9-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510134011.618215-1-ionut.nechita@windriver.com>
References: <20260510134011.618215-1-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0012.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::15) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|CH3PR11MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa75052-7369-4484-1ed8-08deae99d38c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	0OHC2tnoO4aGra/A7GFRXjM5yIzNWpNupyUikByB7r21floDHNXYAR2ulUd0Lkc5TOORATQA87Qqokkjv92PP583QPsDiCv4B7i4D0N4Dz8+IBSy4UJegH2Xs8Pad6eWXPy5EqBRBSA0PSIP1j+TwUPw9K+QaO3lWM2jhEewsJeCZkrVdZGfn9yCPbLKxuMb0Ho2M+PHJ1iQmu4Ri3kfJL9f6xCC3nLS3gWSMPTAp8RNyolQfeV6dgV23G9lwvO66vR5ByYzTwy6TQIUteWwpvqtHI4rZna6kMpVccwM4obl8Sl6k1cRu3zWSJ3pbFDOF429CtuB0NBp3b84rSllOjSDeqEbS6aDdMjjUJqTBgRfrh6cfQrDyMdrxs4+IJPm7iLnEZsS19aEeFbiPeZN/UfQ84WVkfosSOmW9Mnl5Edr05P6of/8ypDJ8VyK7FBaPxvx+MXvoq2bengAMhEdBGewYSaqx5dysAE8yis/31TyaLaGFhoW7H7qUNWQI9A+Rz5IoHLRCthYVcPLKMP/MV8gDU9FO2mQWcQLFy2SpwH8kdAul9sYrl5QchV11XF2cdWmHCVy+9iWff/QnZW3Vk6qMHOGObeUcQXDQM1eMxw2vNHuLnVTkfgBzrzLGXKEN7mEeVbT3rjdzbOWtvpNlA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c0sydXY5RFkvSXloYnU4NmI0eE9HWTVaUnFGTFBwL3BkSXJpU0Z3MnMyLzNo?=
 =?utf-8?B?UlA3dGlxdnNIaHpGT0EwSUNnNm45Q0hIbjNKUXZuY3lzaVgwaTRXRWZkZksv?=
 =?utf-8?B?UGxINkV4S21mUm84TjRPY01jRHFTT1hyeU1qelFzM1huc3pJTUQ5UGFvQytD?=
 =?utf-8?B?LzVPLzJYaVFiSDFwWnNSZ0M4NDJsak41dWE3djZEM0JreFlFb1VzLzB2bFNR?=
 =?utf-8?B?aWsrL2xRVzdjazZ3ZXhnWHBoUnR5SWFlckcwUzd3b01aUHlJa3A3Q01YUXcv?=
 =?utf-8?B?TzkxSmpVWW5DbVgrcXkrY1hGUWV2T2NKS3ViVnJtMTFZSWg2OGlHZHhwTjFn?=
 =?utf-8?B?UWtIVjBRQkZRS1ZnV2x1V0RTWS9EY1Z6SjFqUkkveUp2eXA0SVNVYjlWL1A4?=
 =?utf-8?B?T0plWEZiMlNnS1EvZzUrbHBoeEt1WVNzd1NaZ3J6V0JmRnp0a29SRi9EWUlS?=
 =?utf-8?B?UEh3MmNXbzdpNnY4MDBEM1JQUy9hdHdVbHp1YkVqeS80SFRtRjU2QmEzaHJ5?=
 =?utf-8?B?SkFxU1FHaDhHODNPcXhQMWhxV084WXlRRk90MXEydUpBZStCUjR1Z2tFbk1M?=
 =?utf-8?B?MXBOYy94YVlZclozb010K24xNUtGZVZmeUJjYW5lV1BaTXBKcm41eVAvYmI2?=
 =?utf-8?B?UzU0WWNESXFXdnljK0dHTFRHUnB5NDM5VWMzWm5qU1lzK2pGSlY2a1VFUUE1?=
 =?utf-8?B?TjZVekhteW1oTVUrU0hCTW1TVm54Nkp2WWIxUlFGaVgxekJxZjlLSTFiQ1pu?=
 =?utf-8?B?VzhXWUltZ0wzSTA4NjkzdUNZVlYzY3EydmNBb3VSUXRLQ3ZtQmZydzZOOVV1?=
 =?utf-8?B?ZnpoSjkzWHNEVFROamdkaWFjK0NRNDZSSUR6RFBxbndxaU84MjVROFF5M1Mr?=
 =?utf-8?B?TE1CanJoVnpxWHZ6RWJKbkVURmZkUGFGWGlJcTRaTk50V2R1ODg5WmpQdlFn?=
 =?utf-8?B?TnZmTElXdFo2RzYxZWRIUm1CQ1daemZNQ0R3YmVId2x1cDBTdHZpT2haWkh2?=
 =?utf-8?B?MXhXek8rZVJPbnRRYkcvU0pzYjhOT3EyNE5Tc1E3WlR2OUVoT1VzTW9kaUtl?=
 =?utf-8?B?dlRaK1B4SlMxRWwrK3lLV1RUTzh5ZHFBb045L0c1czFqY0kybnI1WTA3eFA2?=
 =?utf-8?B?SURKZkhXWEgrbXBoNlNickxqR3JSZXlBQmtKMjlEdXFpRUM0bWhWV2Y5NEx1?=
 =?utf-8?B?a0xud21pS3pvc1Y0aW5qNFJyRGVNZk1WRk85dXVCVnBEczBzWllyVDJ3QXc2?=
 =?utf-8?B?cGswTTZQa2hGbDdxVWF2RGxlN3ZqckVtbGZjQVpOeVBwb2U4MjBrZFRxZDlT?=
 =?utf-8?B?VW5MaEM1MFN4UXFLVHUwZmgyQUlPc2ZPMUllSGg4L3pvTWtKSlREWm9KbVZl?=
 =?utf-8?B?TGd1VW5Cd0Y3Vi9mU0oydDlwOUpWZzFoVlZqd1dpOEc0bFVHU3RlZjFZMGdU?=
 =?utf-8?B?MmZWeWI2YkhqTy9LNU9mb3lUaDlJTWZGWnNZZ29VMDJqekptWjV6MWJnV0J0?=
 =?utf-8?B?NUdScXh3VFhoNkJrOEZNMnJ0emFEeWdmN3ZOTzVMaEtpRjhIQ3pKVHpjUjBZ?=
 =?utf-8?B?Y3dLcFNLSGtxTmEyMEdrdHY3QVMvbkVvaEJlN3FHNUU3NndGRGpMR25ad0lp?=
 =?utf-8?B?QU5QbUdDeHNRWXJZekVjOGpnSzNMWk9BSG5mTmVvZWc2Q3dCSjVnRDBLdTFx?=
 =?utf-8?B?a2s1YS9tem9ocGZ5T0VtWmw1dExCMEErVktWMDBDOEx2VlhPZUVnK216QWdu?=
 =?utf-8?B?eDRLMzVZWnhMOVorNk1UeUZTM2ZYN3E2OXgrT2l1bzFwY1EydlZRNWljU1M3?=
 =?utf-8?B?U2dMcUJrUmVZWlVmSDNpY3o5TUJIaVd6UUUwUDNkemNaMHMwMTkrRW53Sjkw?=
 =?utf-8?B?NDBvbUQvS05NYUdjWS91WDRQRU5aZUM5bFV6M3lBWSt6Uy9IbW9yZVZXYXY5?=
 =?utf-8?B?emVja0IwRlR6bHVpZjhUS3Z0Q00zcHlTeDgrMnBCc3BjbmZIVmM0bG9MMzRx?=
 =?utf-8?B?RkpZT1RxWE9VKzA1Q0ZnSVgvZTBPUEJjZTBhVkY2MDB3SUtmT1dobms0WDdZ?=
 =?utf-8?B?SE1nR1V1SmNGOGlqOEE2VGcwK3RWZkFjQ2xJT2ZYbHFXN2l4NkdrU2ZFYytK?=
 =?utf-8?B?SWxVenlQMHVweTl1L0FCcDdkTGJsUE5MUVdqWTNHVDdVSW5UaTh3SnJ1am0r?=
 =?utf-8?B?WGgyZGVFeERxWmVlWEx2ZnRhaDBuQ2p0Q0lBQTFEdWVybVZZbnVyQXpTYlE2?=
 =?utf-8?B?MFNRQldCZmdrQzk4QTRNdTQzTjRQVFkwTnN1ZURKZlFENjNyQzRZVkJwSFFW?=
 =?utf-8?B?Y3JnWU0za1JrRlVVWVc4RVYwQzJldHQvbWFUcHpmckcxeHBhdWZEUnJMUThY?=
 =?utf-8?Q?vkxmr4n7HgAkHqn4IoPOhHkj8fdDxSx6Pxlcmqls2cytH?=
X-MS-Exchange-AntiSpam-MessageData-1: 3UzIYhrlzBV95pax8/xpgQFLFYepzm1+5Cs=
X-Exchange-RoutingPolicyChecked:
	S1ZolxI2ADNyfW+ti4aZv1D8a4e5cWFof33aOCp8RdIqrCOFTTdsM6geTTrrAis3O9jGlxs295ZI5uEX+TBh+c+wn5uvhV5itQ0kdmDIFWCA6EOk19rqTNtTg2FAt1vmW505KFOP1vUlm5KKed5/dBe38r9NA4FHs2ffBFdu+wnyqZLi2QPnZ5uJjTcCizeKEfn37wMx8jYjbebQymHLy2OWAQHzKULNvw+gg/Sfv3SlkKyK2LIkxwBS3Et1U/o5tuJqmgzpvp9m1bN5mlTa1tbE6aEaV+NXU0KMduG7bvtyajnwkTYnbc3z69AwxIQKCrlJo61MjvXKiSdvB6WL/Q==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa75052-7369-4484-1ed8-08deae99d38c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:41:23.7073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FCFO12CU/R3xrL5vTq7ON/muZxihWJHYwVz082+hDIYonnIunoBb62ryyIoqArxTtJP5jUB7Qr5ARn2Q0U0bAkcEhBuudmEfv3Vy1aORv2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NiBTYWx0ZWRfXxURrJwMevuEa
 gb+VHbJsiY2NAOh4qcKa5rNClKHkx5oJkF30cmfKhg4oVenEVRT1w2dS/F+24VovjAf/JhgRaDj
 xg8yjgos8T2QWYsOaZVIYxr/DFJEwo2cfqKihJ4ghwyCRrXrkRcZomjkE5VwH0aH/oxNbBJbn6O
 AD8b91RMBTMiCmv94eU0az0mBmCuW8HD56oE8c4hQcNfZ36jq8CTGypKy8h3iiwbWHcdDNwx+du
 RVIdhXvx4jIX6KC7nroA+Xm1ywoYUClleqGBecs/3sEJZgZE+ceJpJt0O4u/EHejuOqHxs/37nU
 0LNBv/jXUgNbc/1DmeoGR9SlKBAk8TSL0om8HPOTnVK2rtcH26wxTkwTesYDh/agrBp2HlkDDay
 Q10DelRUQDSKw0/3SqROnt8Y/qGgQtapp3h1Yj7shZpizRi2bp8iFYxQuGruTFaQQpOVZtev7U+
 zDSRj8dNOpmwrf1j7ew==
X-Authority-Analysis: v=2.4 cv=H/TrBeYi c=1 sm=1 tr=0 ts=6a008b05 cx=c_pps
 a=Ie8oki5xhBv/1/1SVvCQdA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=Byx-y9mGAAAA:8 a=n2GhSfulAAAA:8 a=bC-a23v3AAAA:8
 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=t7CeM3EgAAAA:8 a=FEdSOl-n94fBr2OEgZIA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=9NqWk_7B-uqI6kdQTXIl:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: nd3SP86ZsU0BYqEtM4jb5lyTfzP5q-pH
X-Proofpoint-ORIG-GUID: nd3SP86ZsU0BYqEtM4jb5lyTfzP5q-pH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 spamscore=0 clxscore=1011 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100146

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit a7b9ce39fbe4ae2919fe4f7ac16c293cb6632d30 upstream.

DW UART cannot write to LCR, DLL, and DLH while BUSY is asserted.
Existance of BUSY depends on uart_16550_compatible, if UART HW is
configured with it those registers can always be written.

There currently is dw8250_force_idle() which attempts to achieve
non-BUSY state by disabling FIFO, however, the solution is unreliable
when Rx keeps getting more and more characters.

Create a sequence of operations that ensures UART cannot keep BUSY
asserted indefinitely. The new sequence relies on enabling loopback mode
temporarily to prevent incoming Rx characters keeping UART BUSY.

Ensure no Tx in ongoing while the UART is switches into the loopback
mode (requires exporting serial8250_fifo_wait_for_lsr_thre() and adding
DMA Tx pause/resume functions).

According to tests performed by Adriana Nicolae <adriana@arista.com>,
simply disabling FIFO or clearing FIFOs only once does not always
ensure BUSY is deasserted but up to two tries may be needed. This could
be related to ongoing Rx of a character (a guess, not known for sure).
Therefore, retry FIFO clearing a few times (retry limit 4 is arbitrary
number but using, e.g., p->fifosize seems overly large). Tests
performed by others did not exhibit similar challenge but it does not
seem harmful to leave the FIFO clearing loop in place for all DW UARTs
with BUSY functionality.

Use the new dw8250_idle_enter/exit() to do divisor writes and LCR
writes. In case of plain LCR writes, opportunistically try to update
LCR first and only invoke dw8250_idle_enter() if the write did not
succeed (it has been observed that in practice most LCR writes do
succeed without complications).

This issue was first reported by qianfan Zhao who put lots of debugging
effort into understanding the solution space.

Fixes: c49436b657d0 ("serial: 8250_dw: Improve unwritable LCR workaround")
Fixes: 7d4008ebb1c9 ("tty: add a DesignWare 8250 driver")
Cc: stable <stable@kernel.org>
Reported-by: qianfan Zhao <qianfanguijin@163.com>
Link: https://lore.kernel.org/linux-serial/289bb78a-7509-1c5c-2923-a04ed3b6487d@163.com/
Reported-by: Adriana Nicolae <adriana@arista.com>
Link: https://lore.kernel.org/linux-serial/20250819182322.3451959-1-adriana@arista.com/
Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-8-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y -
 - trivial conflict in dw8250_check_lcr(): 6.12.y still has the
   (int offset, int value) signature (the 'unsigned int offset,
   u32 value' rework from fc9ceb501e38 is not backported), but
   the conflicting tries/loop body is removed by this patch
   anyway - took the new code as-is;
 - use the bare-identifier form EXPORT_SYMBOL_NS_GPL(...,
   SERIAL_8250) and MODULE_IMPORT_NS(SERIAL_8250) rather than
   the string forms; in 6.12.y both macros stringify the
   namespace argument via __stringify(ns), so it must be an
   unquoted identifier.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250.h      |  25 +++++
 drivers/tty/serial/8250/8250_dw.c   | 165 ++++++++++++++++++++--------
 drivers/tty/serial/8250/8250_port.c |  28 ++---
 3 files changed, 162 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 10a706fe4b24..1fe8222ffacd 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -184,7 +184,9 @@ static unsigned int __maybe_unused serial_icr_read(struct uart_8250_port *up,
 	return value;
 }
 
+void serial8250_clear_fifos(struct uart_8250_port *p);
 void serial8250_clear_and_reinit_fifos(struct uart_8250_port *p);
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count);
 
 static inline u32 serial_dl_read(struct uart_8250_port *up)
 {
@@ -402,6 +404,26 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 
 	return dma && dma->tx_running;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_pause(dma->txchan);
+}
+
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p)
+{
+	struct uart_8250_dma *dma = p->dma;
+
+	if (!dma->tx_running)
+		return;
+
+	dmaengine_resume(dma->txchan);
+}
 #else
 static inline int serial8250_tx_dma(struct uart_8250_port *p)
 {
@@ -423,6 +445,9 @@ static inline bool serial8250_tx_dma_running(struct uart_8250_port *p)
 {
 	return false;
 }
+
+static inline void serial8250_tx_dma_pause(struct uart_8250_port *p) { }
+static inline void serial8250_tx_dma_resume(struct uart_8250_port *p) { }
 #endif
 
 static inline int ns16550a_goto_highspeed(struct uart_8250_port *up)
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1650107d1cbc..630cc7227494 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -16,6 +16,7 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/io.h>
+#include <linux/lockdep.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
@@ -47,6 +48,8 @@
 
 #define DW_UART_MCR_SIRE		BIT(6)
 
+#define DW_UART_USR_BUSY		BIT(0)
+
 /* Renesas specific register fields */
 #define RZN1_UART_xDMACR_DMA_EN		BIT(0)
 #define RZN1_UART_xDMACR_1_WORD_BURST	(0 << 1)
@@ -89,6 +92,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		in_idle:1;
 
 	u8			no_int_count;
 };
@@ -121,78 +125,151 @@ static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
 	return value;
 }
 
+static void dw8250_idle_exit(struct uart_port *p)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	struct uart_8250_port *up = up_to_u8250p(p);
+
+	if (d->uart_16550_compatible)
+		return;
+
+	if (up->capabilities & UART_CAP_FIFO)
+		serial_port_out(p, UART_FCR, up->fcr);
+	serial_port_out(p, UART_MCR, up->mcr);
+	serial_port_out(p, UART_IER, up->ier);
+
+	/* DMA Rx is restarted by IRQ handler as needed. */
+	if (up->dma)
+		serial8250_tx_dma_resume(up);
+
+	d->in_idle = 0;
+}
+
 /*
- * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * Ensure BUSY is not asserted. If DW UART is configured with
+ * !uart_16550_compatible, the writes to LCR, DLL, and DLH fail while
+ * BUSY is asserted.
+ *
+ * Context: port's lock must be held
  */
-static void dw8250_force_idle(struct uart_port *p)
+static int dw8250_idle_enter(struct uart_port *p)
 {
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	unsigned int usr_reg = d->pdata ? d->pdata->usr_reg : DW_UART_USR;
 	struct uart_8250_port *up = up_to_u8250p(p);
-	unsigned int lsr;
+	int retries;
+	u32 lsr;
 
-	/*
-	 * The following call currently performs serial_out()
-	 * against the FCR register. Because it differs to LCR
-	 * there will be no infinite loop, but if it ever gets
-	 * modified, we might need a new custom version of it
-	 * that avoids infinite recursion.
-	 */
-	serial8250_clear_and_reinit_fifos(up);
+	lockdep_assert_held_once(&p->lock);
+
+	if (d->uart_16550_compatible)
+		return 0;
+
+	d->in_idle = 1;
+
+	/* Prevent triggering interrupt from RBR filling */
+	serial_port_out(p, UART_IER, 0);
+
+	if (up->dma) {
+		serial8250_rx_dma_flush(up);
+		if (serial8250_tx_dma_running(up))
+			serial8250_tx_dma_pause(up);
+	}
 
 	/*
-	 * With PSLVERR_RESP_EN parameter set to 1, the device generates an
-	 * error response when an attempt to read an empty RBR with FIFO
-	 * enabled.
+	 * Wait until Tx becomes empty + one extra frame time to ensure all bits
+	 * have been sent on the wire.
+	 *
+	 * FIXME: frame_time delay is too long with very low baudrates.
 	 */
-	if (up->fcr & UART_FCR_ENABLE_FIFO) {
-		lsr = serial_port_in(p, UART_LSR);
-		if (!(lsr & UART_LSR_DR))
-			return;
+	serial8250_fifo_wait_for_lsr_thre(up, p->fifosize);
+	ndelay(p->frame_time);
+
+	serial_port_out(p, UART_MCR, up->mcr | UART_MCR_LOOP);
+
+	retries = 4;	/* Arbitrary limit, 2 was always enough in tests */
+	do {
+		serial8250_clear_fifos(up);
+		if (!(serial_port_in(p, usr_reg) & DW_UART_USR_BUSY))
+			break;
+		/* FIXME: frame_time delay is too long with very low baudrates. */
+		ndelay(p->frame_time);
+	} while (--retries);
+
+	lsr = serial_lsr_in(up);
+	if (lsr & UART_LSR_DR) {
+		serial_port_in(p, UART_RX);
+		up->lsr_saved_flags = 0;
+	}
+
+	/* Now guaranteed to have BUSY deasserted? Just sanity check */
+	if (serial_port_in(p, usr_reg) & DW_UART_USR_BUSY) {
+		dw8250_idle_exit(p);
+		return -EBUSY;
 	}
 
-	serial_port_in(p, UART_RX);
+	return 0;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	int ret;
+
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		return;
+
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	if (!(serial_port_in(p, UART_LCR) & UART_LCR_DLAB))
+		goto idle_failed;
+
+	serial_dl_write(up, quot);
+	serial_port_out(p, UART_LCR, up->lcr);
+
+idle_failed:
+	dw8250_idle_exit(p);
 }
 
 /*
  * This function is being called as part of the uart_port::serial_out()
- * routine. Hence, it must not call serial_port_out() or serial_out()
- * against the modified registers here, i.e. LCR.
+ * routine. Hence, special care must be taken when serial_port_out() or
+ * serial_out() against the modified registers here, i.e. LCR (d->in_idle is
+ * used to break recursion loop).
  */
 static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 {
 	struct dw8250_data *d = to_dw8250_data(p->private_data);
-	void __iomem *addr = p->membase + (offset << p->regshift);
-	int tries = 1000;
+	u32 lcr;
+	int ret;
 
 	if (offset != UART_LCR || d->uart_16550_compatible)
 		return;
 
+	lcr = serial_port_in(p, UART_LCR);
+
 	/* Make sure LCR write wasn't ignored */
-	while (tries--) {
-		unsigned int lcr = serial_port_in(p, offset);
+	if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
+		return;
 
-		if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
-			return;
+	if (d->in_idle)
+		goto write_err;
 
-		dw8250_force_idle(p);
+	ret = dw8250_idle_enter(p);
+	if (ret < 0)
+		goto write_err;
 
-#ifdef CONFIG_64BIT
-		if (p->type == PORT_OCTEON)
-			__raw_writeq(value & 0xff, addr);
-		else
-#endif
-		if (p->iotype == UPIO_MEM32)
-			writel(value, addr);
-		else if (p->iotype == UPIO_MEM32BE)
-			iowrite32be(value, addr);
-		else
-			writeb(value, addr);
-	}
+	serial_port_out(p, UART_LCR, value);
+	dw8250_idle_exit(p);
+	return;
+
+write_err:
 	/*
 	 * FIXME: this deadlocks if port->lock is already held
 	 * dev_err(p->dev, "Couldn't set LCR to %d\n", value);
 	 */
+	return;		/* Silences "label at the end of compound statement" */
 }
 
 /*
@@ -636,8 +713,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	p->type		= PORT_8250;
 	p->flags	= UPF_FIXED_PORT;
 	p->dev		= dev;
+
 	p->set_ldisc	= dw8250_set_ldisc;
 	p->set_termios	= dw8250_set_termios;
+	p->set_divisor	= dw8250_set_divisor;
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
@@ -929,7 +1008,7 @@ static struct platform_driver dw8250_platform_driver = {
 
 module_platform_driver(dw8250_platform_driver);
 
-MODULE_IMPORT_NS("SERIAL_8250");
+MODULE_IMPORT_NS(SERIAL_8250);
 MODULE_AUTHOR("Jamie Iles");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Synopsys DesignWare 8250 serial port driver");
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 1e6dca739eab..ce26d1649ca5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -478,7 +478,7 @@ serial_port_out_sync(struct uart_port *p, int offset, int value)
 /*
  * FIFO support.
  */
-static void serial8250_clear_fifos(struct uart_8250_port *p)
+void serial8250_clear_fifos(struct uart_8250_port *p)
 {
 	if (p->capabilities & UART_CAP_FIFO) {
 		serial_out(p, UART_FCR, UART_FCR_ENABLE_FIFO);
@@ -487,6 +487,7 @@ static void serial8250_clear_fifos(struct uart_8250_port *p)
 		serial_out(p, UART_FCR, 0);
 	}
 }
+EXPORT_SYMBOL_NS_GPL(serial8250_clear_fifos, SERIAL_8250);
 
 static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t);
 static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t);
@@ -3288,6 +3289,17 @@ void serial8250_set_defaults(struct uart_8250_port *up)
 }
 EXPORT_SYMBOL_GPL(serial8250_set_defaults);
 
+void serial8250_fifo_wait_for_lsr_thre(struct uart_8250_port *up, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (wait_for_lsr(up, UART_LSR_THRE))
+			return;
+	}
+}
+EXPORT_SYMBOL_NS_GPL(serial8250_fifo_wait_for_lsr_thre, SERIAL_8250);
+
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
 static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
@@ -3324,16 +3336,6 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
-static void fifo_wait_for_lsr(struct uart_8250_port *up, unsigned int count)
-{
-	unsigned int i;
-
-	for (i = 0; i < count; i++) {
-		if (wait_for_lsr(up, UART_LSR_THRE))
-			return;
-	}
-}
-
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3351,7 +3353,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 
 	while (s != end) {
 		/* Allow timeout for each byte of a possibly full FIFO */
-		fifo_wait_for_lsr(up, fifosize);
+		serial8250_fifo_wait_for_lsr_thre(up, fifosize);
 
 		for (i = 0; i < fifosize && s != end; ++i) {
 			if (*s == '\n' && !cr_sent) {
@@ -3369,7 +3371,7 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
 	 * Allow timeout for each byte written since the caller will only wait
 	 * for UART_LSR_BOTH_EMPTY using the timeout of a single character
 	 */
-	fifo_wait_for_lsr(up, tx_count);
+	serial8250_fifo_wait_for_lsr_thre(up, tx_count);
 }
 
 /*
-- 
2.54.0

