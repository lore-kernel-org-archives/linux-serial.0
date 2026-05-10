Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADAD388E60
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420485; cv=fail; b=h1SjLtXrCNuuie/8QFsJP/UcLswDGMhdPalBPHcdA8lWcMPVxdvSoIEcu5mqPsLFZXBhYl2qwTUTpF8qLjihOklA2NX4UbxeLNEHaxq+7gtOSKBoQfMq3r4buX5PO2IpCNeCgkYhFkd+YS4zJDVBy4qZr9w59oPvgjQTksYKfM8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420485; c=relaxed/simple;
	bh=vGHFv16yzs/b2OahKJfEUxaENB3lBxsBxh7KHOeegWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwDD2TcRg/8lfomPSGThGTJWwd0BkdKI3x3EiwD+5E3PmmpnlJgBhDeCCj3JuhHPcT7oYPJkVT/fFPtdY40eJqLTBOg8wHM6Vfm6LUPe3eAPfSOz6QxE+Or2Z9uLOvHu7G9TU0m6fPlF/pqtcJghMbdiCdHDtI7dihHgD4Jw0GI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=RIa4Prfa; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="RIa4Prfa"
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ADQeTx3119151;
	Sun, 10 May 2026 06:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=/w2kMkS+n2bNLvdamZSGiSJNEqESRH0IC2rMV00JI78=; b=
	RIa4PrfaX+lVrJ7aQfDXiL/mTPSFsInc1+GDZqqRLhA5zxnD6zeVX7s4vv5A0YuB
	xkoK4sR4YXSzEJ/OOXFxKPMgnYPIcS2ZeOxdiCJVEYMxrDTkSdnEi5l/y9kKvoev
	z1mfpUv+CX9c3Rr6C8Xj8/IrtwvicCSlQoq5Ijn9o7ikNmKBzU3rwmlkgj8RFhyA
	JIOBro4XVdnchduCpYHw/EeWpAYjynJiHGalManra12pSyfryOUuxtG8AIw6D+l9
	sh60J+mzOsKQeNrHEH3E173qZrzVqcVfohfdpRUaj8dpFXhZGgBsV7Y7/y7qrYAJ
	6OvCJCKVrehakVIQgjxe/w==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e206xrvtn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 06:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9nKZGy5IS9ZRLle6CYVe//zCzu46CzsspUdniZN6M+hiPCO+pghAkx5oqiQZTpbBoipTMf3kCWlkWHaUTmDAectguJcXaknSaN9plSZfkcNUpMdqbGemcyn4OzgtuXtN4Ue+jHEyeatjjv8Silpg6Fa4wR7/wS7hMSl0dE0Sv27ifIlscHnuYdqbPdc/yfhUcOqn+45DLztXUXZl0mzbTQmvbQDC0Fxs1rZbD41NUE9eaig68IPdv+ZIBvUBUYdCdqym6cpqUbPMxGpmBWMBRbwZ85F3WwwlHTeKdw+sphKvmF0m82OijkK34DC1+RMUowj9t4fc1XXHjDJCe3MnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w2kMkS+n2bNLvdamZSGiSJNEqESRH0IC2rMV00JI78=;
 b=WLYDlznf8SBW73M//bvOs6kCp2uxl8UkiRBRqFvLaV5abkJfg1fzk6drt2R811G6VvxRmhIRsq3BK3iJCoXhXoa7cC4kq7tCiOfb72VD1Xqwv7a090Oy0ezlLszrwVBVu6ygrmxBcuVltjSqkqlOGii9e/vecU5e3FZiRPjcCHwczVR6606RXLq5nCyDyGWlWrKTn6lXkW3ortUmYqzphpTZoCpE/Ogw/O/Ql2hj0QEzYvXBRy2LLcAz+iUcFT5l6Rn6Wt5S2e3x4htHqsPHTY6LXjCzx5nP4ofmRWcRsrC1f+jk2p3i08M5wBnfeNAMjRCmxsFxppDqixKsJFgm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by CH3PR11MB7674.namprd11.prod.outlook.com (2603:10b6:610:12b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Sun, 10 May
 2026 13:41:18 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:41:18 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        stable <stable@kernel.org>,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 7/8] serial: 8250_dw: Rework IIR_NO_INT handling to stop interrupt storm
Date: Sun, 10 May 2026 16:40:10 +0300
Message-ID: <20260510134011.618215-8-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 787cecfb-34d5-4da7-539b-08deae99d076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|52116014|376014|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	2nYXws3PmGr72GrrLI9ELuXLyv+NrvUPhd9gWR0Tg0fXOHnllkzMrlO5v0fOB9JJCAjGT1acau29MI0sTEt9tAHK7+TOFME7QhOP3VxPQAjfWSGcqWDCUUaviQdfB37hPoY1iJY7QqRYv7R9gj74gMzJS6eApVSNUWCil3jVmpDY2okFlIzfFGBHWbZ37vwSRh5aqdp2CZUXxWW9zvGv4ZW6dCZCeD+9y+kL14G/fKoPAo+iT5ASBP6OFk5kxMV39h0GgxTCd1E/CHv7sFRCGja2YRq/o38mx3elV/U9A5PAXbuHHttBzyvyl6qUdgMq7Czh77ga+DFgC9HiO7wWaAE5A/7d2M7QFPTGIeE0AiXTbbqbc2cUVd6YULJVHglJqH+eo6ODu5tfxDslCTDVkHFus/Cq8fgeZzB+HdGC71IOjiCoSsooZFzMZW0FWjw5N6aOUW84qro2kh8V5N/EgmB+enobIKj9udSWw1s0jb2yiU0bnHWL6tZxGAn7eEbGJlTS8Xm6Ut7oAsdSnBB1ZlsaFk5NIyoQmHy4i8QgaX59VYeiXvVJvVu78Fn5s5jksfmJ1GfO9xfncf9bI/2jdMUIb9V5Gqm7FNcdllltHsFLrEQit8GEO9Abj9m05OJAeh+u1xjf3sy1H1vYfdSlqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(52116014)(376014)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXFNQ1N2L3pQS2lEUkViaVowZlN0aE1WZHBVcEJabkxnZXNDbllzOGxQTnRB?=
 =?utf-8?B?VElucEJKQXkrbFdKNlY3RmtWeVo4QmRyTUJiN1BFY2psSjBPNDgyNDQvUnBv?=
 =?utf-8?B?L3lMNTRCZkxNOHNlWmcwZlNGZUwwMmxhOGIvSElIRm5pUEJBejc0N1NtYlU1?=
 =?utf-8?B?UkVUQlQzdFhDRDE5YjI3RTIvbXF4ckJSV2lxTlNpWkhQQjVDbkpzZ1dZR01i?=
 =?utf-8?B?aEtZa1krbHBwZFQ3cXdYb1Y1QjVha1NpMmEyVFFPNWxGYnZQL25wOHRxd3lv?=
 =?utf-8?B?UG5nUDloVVdXUEtDekIyNEFMN2xtQk0xbDU4ZUtsK2ZYc0tnYjFxSHY4Wk83?=
 =?utf-8?B?aTVGYVlVNGdaemR1S0MxYTZRak5UYVlDMzF0eXFzMCsrRmh1Mm9kakd1N2Q2?=
 =?utf-8?B?a0pFNGNDa1R0WFZrbm93QlhMcFFHdENnOHIxdCtaZEg0TG5LQjAyV2NPQnh5?=
 =?utf-8?B?Q0ZwcmZZVGNGZ1JFaXlHQXZQdENleGFlNTNteEQ3SVRaYUJudVZpanhER3BM?=
 =?utf-8?B?MDVac2FxaU1CSUJHMW43OHpDRTJYaGpYNGJqV1h1MDVkQ3pSb0EwTk5MTGNS?=
 =?utf-8?B?NnJjNytmbjlnQXJTUUhlamZJRTZlSWpqMDJ6ZDlUTjByU0NkcEJxVU5pYUVC?=
 =?utf-8?B?czZFTjZVTFlMT3RsaDhKSStYcEJYcE9LWkxsa3NwOEJDVlVSYjlWRUxYMEJQ?=
 =?utf-8?B?WlpHOGdsR0Z6bmNzTVRRcDNZcGVvby9GUmtnRkhQZTlIU0Jaa3Z0cnhvRTBH?=
 =?utf-8?B?bjM0dEZBeDFQb2dGUjlMQlBQYS9pdkRaVWFMVnUzQUxlTXdJRG04d2pJOEx1?=
 =?utf-8?B?MkM2NE9jNlFrTEc4bDZ6N1FEanlVcC9PVUk2ME5RcXZHQm5wVXFnRVhIQStB?=
 =?utf-8?B?MGtnSnRQczZDQTVQenU3cEltUXI3VlV0aGRpRTYvRzBFUjhZazNyT3JnQ2Z5?=
 =?utf-8?B?dnY5K3YxdVBWdXNjNjhjZ09odDRxM0YwbTNnUmY5OTNtUUpCdDFWLzJIVmVi?=
 =?utf-8?B?MldWblRKVXZ0SitjYm16MVdWY0VhdlluSjE5dGlpOXpEQk51OTlwMm9va0tU?=
 =?utf-8?B?M1d1NDUwajFmM3FNZlRtUndxMlc5YlVWdFNpU3VUQ2J2VjI4dm1QdHhmSDJ4?=
 =?utf-8?B?M2pVTENXM0EyckQ3ZmVYTGNaZUN3MWpqZDBOOFFJNWdYMnBsQjgxSmIyb3ZT?=
 =?utf-8?B?Rm5YVUMzbXlQWGY3emYzR1BYZkdDVEJLK3kxc1Q4NG5Cd09DdC9EUjEyMmRo?=
 =?utf-8?B?QS90dmNsRmNGMlkvQkZLTTFid2R3N0x5Y2htZkVjcFR0a2tJNm5DN1JjK21T?=
 =?utf-8?B?QWRabUFMZVdVaUlTZFhHbVRIa3NkamhqSUM5L0t2cEF4YkVoNHl6clBaSFVS?=
 =?utf-8?B?djRpSk5hL3FkWWtweUlpN3ErNk4rc3pHRktaSVN0ditTNCtGWCtuS2NRYjV6?=
 =?utf-8?B?TUk3cjlBNExJSHppRmJBY09BNmpvSUU5U0dtbUt6MHkwVjlkRmplbHFSMHFu?=
 =?utf-8?B?dEF2SDNiL2w3WExIa3JHcWJzUmRwSDgyRitCNFVHeVVvck5xeFdrWHNQczdn?=
 =?utf-8?B?RnpFNVRzNmJsYWpOeTQvczFYeEh1c2E1R2JwMnJYdmo2cUxWcVRhbU0rUXEw?=
 =?utf-8?B?dWFLY3NuMWg4alFiTHp3Ri9iM1g4enJBQ3FlaUFIL2g5V3FDcyt5U1cxd3Y1?=
 =?utf-8?B?ekdwOHlJU1d2QU9RU0ZOU3NkbXFzQXA5MHJiYXhySmFrc0hIRnlQbDZzc04v?=
 =?utf-8?B?Ty9MNzgxTndEOXNXMlV6aGFDeXAxNUJrOUE1M3I2U3RGSGNrdFZoSmJZS25Y?=
 =?utf-8?B?N1BNMmtGcWtIYTI2TGhOWld1VGE1T2Z5c2dENHdNZmZCZ1BEcmE3M2FYZFU0?=
 =?utf-8?B?QkYwOWhBYk5ieDBTalFJc3VQd0hTaWFOMitKZ2dKbm5VK0hKUGRNTWxQYWlr?=
 =?utf-8?B?NnE5SS9sdURrQzZzRmdLNUhrMVd0d2NKUnhnWVFYbjRET0ZwNzczMER3eW5I?=
 =?utf-8?B?bXlJSkNSd25xUVNaZlhZMWN3VC9USktOeHlrQXBYN0I3VjBVUmVYalV5UmJR?=
 =?utf-8?B?SHQ4WCs1Y2l3R0hCVTk3RloyNVZEdWIxdkZaZGJ2M294aGRINzdYZndMdUR5?=
 =?utf-8?B?YlJQOFZoNHY0dW45MzYwaDIrczRQZXJqLzRFOU9td0xlRU0zV1VxdHhCTUJp?=
 =?utf-8?B?bW84R2U0K1luUUhFYzA0ZkdZUENoT2VqeHFZVnRNSnNUbE1UVk1UY1NjVlpB?=
 =?utf-8?B?NUQ5R1c3ZHcrK1N0NEVPUTk2Q1lDeVpVNDF5WTBqT0JUcHZvTk05bjg5TUJC?=
 =?utf-8?B?MDhaQ2lUNWJ0dEJIbU9qOTg4K1V0TmV5VmhqL0wxVmsvTUMwWkdsd0ZqMEtL?=
 =?utf-8?Q?YKJXDrZl5sEC2yuBVvVph2RfqS590FUuP7/wJ68qDOow/?=
X-MS-Exchange-AntiSpam-MessageData-1: hrSganUANM47ajTu2jT1e1YADR7ZefaglyE=
X-Exchange-RoutingPolicyChecked:
	soJ9zmTtU+dRSCEW8+Llv41tKJkdVdNvH8cD8iTlu7utyuuSlI1QE5RxCXRpxJ+NlgsOvriLLMW4DejH3R8y9uZBDCtOuDSEMK89lWo6D1JPR84hwm8JMooaxTxkik1oUiGr7IuT7TT/XzWP4jDs7SwtnovwXL7llarBrviz1eBoxKk2j9pDQuJ52R+arzd+Ze1lck9V/VFhr15ner4d3mqTlEYd3gkmBMILZ8H235Bq9r9WkfRKufBVscrEazqay8NcMWrdI6Tm09wU/r863QCOfgZhYUFoR8l5eDS2LPwml5pxsTRU5yRr06jaANeAMm3AyXk1/+WSFcjJqKBzQw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787cecfb-34d5-4da7-539b-08deae99d076
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:41:18.4705
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TXJTN6xB3LTRQB1fT0B8Wh+9vtstPVJ+i5odycQZljgI8MSScbRoK4HcGsoo+VGI2F3rVx5wtu70DMcXRPmZWHmnCRVKOcpRP+kiRTsalzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7674
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfX7Z3oV8ewNqob
 VeYTmwFPhiq9CL3zQ+QufsZuh6vjBIYUs2VJJ7vSwNWdeGRTykoUjcaE9X4iegQ7umu1XqWVMNI
 a/cMTutNYhSvFs14Co8lQu14wrnlQ5CsPHyEYMAaEfqIbqYfg6uN2lgJYbdC49P38tgNs+Gf97l
 o6WLaTX5S/ELehqca02lq5clGG6MIg7WVOJpybxVZFAzZcxWfQwGESIH70oVhOyJ3bqAPBuRbyT
 1lqu4CBfMgHKgutpFBkzJM8m5MwXJLiosh8q5WtSt+wZwViPI07ZVwrX4Q5hTQtGH+UcymbBjcO
 /FgNkq1SmrARFL4qEcjqDF+umbXWomq1z7/L6/dWhKQ6q0P8wJnLFIiAOaUuSTjX2xhw+HwZdrB
 U1CgAtNIQ3sjo7kMaj5Qjwx5tUWswSYnpES1FumTEUvrPjsLYLO1HaCnD/pkBFyGn0raXgsE+XW
 Vl84StTkJMip0wmoKyw==
X-Proofpoint-ORIG-GUID: S4wRVuHiLDKVg8hAMyaLOQoUh7Ha3tBf
X-Authority-Analysis: v=2.4 cv=CJMamxrD c=1 sm=1 tr=0 ts=6a008b00 cx=c_pps
 a=Upp9xsdEppYJlq5B+Xcl6Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=VkLnJ9PegRZGO-DjF3MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: S4wRVuHiLDKVg8hAMyaLOQoUh7Ha3tBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605100145

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 73a4ed8f9efaaaf8207614ccc1c9d5ca1888f23a upstream.

INTC10EE UART can end up into an interrupt storm where it reports
IIR_NO_INT (0x1). If the storm happens during active UART operation, it
is promptly stopped by IIR value change due to Rx or Tx events.
However, when there is no activity, either due to idle serial line or
due to specific circumstances such as during shutdown that writes
IER=0, there is nothing to stop the storm.

During shutdown the storm is particularly problematic because
serial8250_do_shutdown() calls synchronize_irq() that will hang in
waiting for the storm to finish which never happens.

This problem can also result in triggering a warning:

  irq 45: nobody cared (try booting with the "irqpoll" option)
  [...snip...]
  handlers:
    serial8250_interrupt
  Disabling IRQ #45

Normal means to reset interrupt status by reading LSR, MSR, USR, or RX
register do not result in the UART deasserting the IRQ.

Add a quirk to INTC10EE UARTs to enable Tx interrupts if UART's Tx is
currently empty and inactive. Rework IIR_NO_INT to keep track of the
number of consecutive IIR_NO_INT, and on fourth one perform the quirk.
Enabling Tx interrupts should change IIR value from IIR_NO_INT to
IIR_THRI which has been observed to stop the storm.

Fixes: e92fad024929 ("serial: 8250_dw: Add ACPI ID for Granite Rapids-D UART")
Cc: stable <stable@kernel.org>
Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-6-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Ionut: adapt to 6.12.y -
 - move uart_port_lock_irqsave() before the switch (matching the
   upstream guard() placement) and convert the early returns into
   a goto-out pattern with uart_port_unlock_irqrestore;
 - drop the dw8250_setup_dma_filter() call (helper introduced by
   c213375e3283 'serial: 8250_dw: Call dw8250_quirks() conditionally'
   which is not backported);
 - keep only the new p->shutdown = dw8250_shutdown assignment in the
   existing 'else if (data->pdata)' branch; in 6.12.y p->handle_irq
   is unconditionally set earlier in dw8250_probe() so the upstream
   reassignment is unnecessary here.]
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 75 ++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 1076b72c120b..1650107d1cbc 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -61,6 +61,13 @@
 #define DW_UART_QUIRK_IS_DMA_FC		BIT(3)
 #define DW_UART_QUIRK_APMC0D08		BIT(4)
 #define DW_UART_QUIRK_CPR_VALUE		BIT(5)
+#define DW_UART_QUIRK_IER_KICK		BIT(6)
+
+/*
+ * Number of consecutive IIR_NO_INT interrupts required to trigger interrupt
+ * storm prevention code.
+ */
+#define DW_UART_QUIRK_IER_KICK_THRES	4
 
 struct dw8250_platform_data {
 	u8 usr_reg;
@@ -82,6 +89,8 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+
+	u8			no_int_count;
 };
 
 static inline struct dw8250_data *to_dw8250_data(struct dw8250_port_data *data)
@@ -308,6 +317,29 @@ static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
        return dw8250_modify_msr(p, offset, value);
 }
 
+/*
+ * INTC10EE UART can IRQ storm while reporting IIR_NO_INT. Inducing IIR value
+ * change has been observed to break the storm.
+ *
+ * If Tx is empty (THRE asserted), we use here IER_THRI to cause IIR_NO_INT ->
+ * IIR_THRI transition.
+ */
+static void dw8250_quirk_ier_kick(struct uart_port *p)
+{
+	struct uart_8250_port *up = up_to_u8250p(p);
+	u32 lsr;
+
+	if (up->ier & UART_IER_THRI)
+		return;
+
+	lsr = serial_lsr_in(up);
+	if (!(lsr & UART_LSR_THRE))
+		return;
+
+	serial_port_out(p, UART_IER, up->ier | UART_IER_THRI);
+	serial_port_in(p, UART_LCR);		/* safe, no side-effects */
+	serial_port_out(p, UART_IER, up->ier);
+}
 
 static int dw8250_handle_irq(struct uart_port *p)
 {
@@ -318,19 +350,35 @@ static int dw8250_handle_irq(struct uart_port *p)
 	unsigned int quirks = d->pdata->quirks;
 	unsigned int status;
 	unsigned long flags;
+	int ret = 1;
+
+	uart_port_lock_irqsave(p, &flags);
 
 	switch (FIELD_GET(DW_UART_IIR_IID, iir)) {
 	case UART_IIR_NO_INT:
-		return 0;
+		if (d->uart_16550_compatible || up->dma) {
+			ret = 0;
+			goto out;
+		}
+
+		if (quirks & DW_UART_QUIRK_IER_KICK &&
+		    d->no_int_count == (DW_UART_QUIRK_IER_KICK_THRES - 1))
+			dw8250_quirk_ier_kick(p);
+		d->no_int_count = (d->no_int_count + 1) % DW_UART_QUIRK_IER_KICK_THRES;
+
+		ret = 0;
+		goto out;
 
 	case UART_IIR_BUSY:
 		/* Clear the USR */
 		serial_port_in(p, d->pdata->usr_reg);
 
-		return 1;
+		d->no_int_count = 0;
+
+		goto out;
 	}
 
-	uart_port_lock_irqsave(p, &flags);
+	d->no_int_count = 0;
 
 	/*
 	 * There are ways to get Designware-based UARTs into a state where
@@ -361,9 +409,9 @@ static int dw8250_handle_irq(struct uart_port *p)
 
 	serial8250_handle_irq_locked(p, iir);
 
+out:
 	uart_port_unlock_irqrestore(p, flags);
-
-	return 1;
+	return ret;
 }
 
 static void dw8250_clk_work_cb(struct work_struct *work)
@@ -561,6 +609,14 @@ static void dw8250_reset_control_assert(void *data)
 	reset_control_assert(data);
 }
 
+static void dw8250_shutdown(struct uart_port *port)
+{
+	struct dw8250_data *d = to_dw8250_data(port->private_data);
+
+	serial8250_do_shutdown(port);
+	d->no_int_count = 0;
+}
+
 static int dw8250_probe(struct platform_device *pdev)
 {
 	struct uart_8250_port uart = {}, *up = &uart;
@@ -688,6 +744,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	/* If the Busy Functionality is not implemented, don't handle it */
 	if (data->uart_16550_compatible)
 		p->handle_irq = NULL;
+	else if (data->pdata)
+		p->shutdown = dw8250_shutdown;
 
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
@@ -819,6 +877,11 @@ static const struct dw8250_platform_data dw8250_skip_set_rate_data = {
 	.quirks = DW_UART_QUIRK_SKIP_SET_RATE,
 };
 
+static const struct dw8250_platform_data dw8250_intc10ee = {
+	.usr_reg = DW_UART_USR,
+	.quirks = DW_UART_QUIRK_IER_KICK,
+};
+
 static const struct of_device_id dw8250_of_match[] = {
 	{ .compatible = "snps,dw-apb-uart", .data = &dw8250_dw_apb },
 	{ .compatible = "cavium,octeon-3860-uart", .data = &dw8250_octeon_3860_data },
@@ -848,7 +911,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "INT33C5", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3434", (kernel_ulong_t)&dw8250_dw_apb },
 	{ "INT3435", (kernel_ulong_t)&dw8250_dw_apb },
-	{ "INTC10EE", (kernel_ulong_t)&dw8250_dw_apb },
+	{ "INTC10EE", (kernel_ulong_t)&dw8250_intc10ee },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.54.0

