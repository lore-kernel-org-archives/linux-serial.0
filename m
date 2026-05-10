Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32C2388E63
	for <linux-serial@vger.kernel.org>; Sun, 10 May 2026 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778420486; cv=fail; b=q9mzcp5TeORm/ENMaQRBv+4FwKyVAxT0/IdMYu4tkwRRpj1XMryOoT0sIrcsxyAJ3xzFGSUWqms5fhu14OufrAd4oAjZ7IC7tlcaHFHQHsygY7RxMdQnmdZ8rHSQoVS41L5UmEtTUNq6QnpyjyH9SyEG6dXj1dqdiObrgt+xkkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778420486; c=relaxed/simple;
	bh=y8ZW2C56nF/yGjVmQ3y5EWEmfvAcKxVmca7eifjv8n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TPW0yH7Zxuj6evbE27Wl4Nea4uH1YYX8rOLyBAw+jbP3epKFJXnkeLyg6mgo7USzS8rUqvZPQjRmQDJ6kkhZ//VF/vMlqYmp5e3/vP+Xh7cmMdajDLJRrp7L4nz3LjpFm2BwIg0UOUnlJQReoPCG5IJ/OOY85HE+pHo2ClrZM+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Le+dADvI; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Le+dADvI"
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64AD9W9H1394010;
	Sun, 10 May 2026 13:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YVK/O9vSO+ydruKdA3xkWB1Q0O4F6yjHhNpdSvmrvZc=; b=
	Le+dADvI+ZZco59E97wtXfsAgGyK8byFeNRE7c5k+EaTt40mMcNIu08Y9mhWWGj+
	LVSJpYKPkmP674sOeDcNtuNrydawP9aw53TZ8bEQ2vr7jiB3mB0K87bNqFzz2F0O
	pGCpJDzyZwlXebvl/hc1aqy/cnlBAclsHSCT9veG6/iTOVrrkPv8TkOwWTXpySt6
	wIvfOMLk9m6/gxUF7FOrKc2dEhmLwYwxL0h2OTM57NlR2cHRZ6elN+kGAoRmE0Bu
	ZehztHiC5VpO2UaBzPCLbOXjXayZbyf9KnwUu211Tw5OclQj6rqKR31k6os7FRs9
	U3mBxayTI/snpgvD4IInfQ==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4e1uw6h2w6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 13:41:06 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cC5vTl5Zrx4kicINZAuq5UK6GQNJ0MLUsGU96LPyFXXTmhJChyZFCbl3UBtyyIsH+xtD/nD8ptL5c6KJH2v4k6x3haZqhbuU5QU2JWZuz8wzEwHFaA2kcpKghmfOWoD4r/hptLuhz7z4YlFC3Md7EUBhPa7x1+ff3Hne+feFNY239j8Iuv4TNJH6KjLyp90QVw+iyIsJ3577t2pklC4JyKeT+pUWQPLlm+3krINC7dBV6X3ApbOJfc6GcBb3V4YDOb1vDwVGbkBBgXy+nSAM3LwV+W1Fq83Nz6B5gVAyopl9KR/YZTgoGTsb8LI49UrkIm9wxB2r26dfnlGr2UMJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVK/O9vSO+ydruKdA3xkWB1Q0O4F6yjHhNpdSvmrvZc=;
 b=LWdF9UWahRmfTcsTdTzTsHM8M1o6WJ41O2ddOidWEuTkAij6ZFQHDFJaqRwmW3rYV7OSn6Y750wVWqzqq/TzxEYYaUu8lXs+7AsWbqe7i/Wn3I5WJKZYITmESRNqHsPSKByF5mRX5PRazY52ydginWrvpQh3H2WjjlUxgnp413+Ry1sdz7U/YRnSyjR0UFjVgw2RCWoszgLU/iPgEmuG7YhcfIJKXvgFlOp929/yxOStkLU5fzryFx3wloQsY8wSf1ZjYK/YO8CUSwA80hTYI55dEKEpM5CsyViSRMigwUiscJqPt+JGoKxcSTbVRlTipsdzL3aOPQgI9lUVfIXcuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by SJ2PR11MB7454.namprd11.prod.outlook.com (2603:10b6:a03:4cc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Sun, 10 May
 2026 13:41:03 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9891.021; Sun, 10 May 2026
 13:41:03 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: ilpo.jarvinen@linux.intel.com, gregkh@linuxfoundation.org
Cc: andriy.shevchenko@linux.intel.com, linux-serial@vger.kernel.org,
        "Bandal, Shankar" <shankar.bandal@intel.com>,
        "Murthy, Shanth" <shanth.murthy@intel.com>, stable <stable@kernel.org>,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH 6.12.y 4/8] serial: 8250_dw: Avoid unnecessary LCR writes
Date: Sun, 10 May 2026 16:40:07 +0300
Message-ID: <20260510134011.618215-5-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|SJ2PR11MB7454:EE_
X-MS-Office365-Filtering-Correlation-Id: 24fbd4f6-3d44-4d60-d4b7-08deae99c785
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|10070799003|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	UAXaR0xYhRnXwVXmIj7AjlwuKxg81S5fdRtzp0t+mZ5yrbTXYqov7tVidOJe8Ptt6geZvATkjJZWs2PFt7WJzcBKGapf0B1sFc9k/pLbuFqBk+LQg9wWlc+01J/M2xFC6P/2qdWzGWJF4Crm87HrmMF6NLfN4Ygfhd3BiMzCekmCnYaTQtkZn+OhJmf4cP2jdibRUxXB5WplttgiTFH7P+BWann53S1vAnRAbNJLMtO/d1qeNA+ujrAx2I7W1m95dIT1w+GrWS2tbhrctPnpjFv1SUQKS2RVXvSVOcZ2uhoH1Fc20G7R8aTt2a4Jtr6lgQvYyRcTZmmzw2Aig6iIng2prB3KQw5N6yIwoD1mvqQo0c2aLSzO5Yl9nTnuAC33KSZqjVWCVaSxXiGkUjHn8ivzcK3Dd7NVEMTJ6NHbQ+IxyWqbXLs4GWVFjvHYH1vmVZVuQx+lxuvRo5T2UM9XMA3i2b/JJjcP5kla8hgUKAvvwPLLDSDJe/mwCN5RGB6veGk8bW7Q3RpmaIJMuhYK24iVhVGY9jjY/EENIiDEzpAS5KeYT+6j/2UoivYE8UAJ+OS1DLHyS/g6kBlXlDiByIdhcEjx/G6Zk7bSX6HMQFByzfrXjnUYX6cZd6FpwqJo2vgBcx4NNVxret19yzUPWQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(10070799003)(1800799024)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MThUTEkvaHZWWEFiRGRYYTNCR3JMZ1pGNmMzc3c5V3E4Y05kcDJXRFRyeFZI?=
 =?utf-8?B?LzBpdGRPWEdXc09QbnBjUDNEZk8xV3A3ZlJ2ZzNiRzFMdm1DSWRVS1Q1cnlB?=
 =?utf-8?B?MEx6TzZiMnpEU2NpL3ljZkZyZFllNWtBMWVGR0JuWnhqbS9IenVVVVlVTTc1?=
 =?utf-8?B?cStwRW9Hbm9lc3YrNjJZL1IwLzJESUY0K29EcFVTMVplNGp1anpXSHhzazBU?=
 =?utf-8?B?cDdUbldYT2lDZFl0OTlsNk9uM3U1YXhLdDdFYTFjWVBaRkMxM3Y5d0tLNmdR?=
 =?utf-8?B?N280YmU0akFsR3VqSksyRVBXWVo4TGt3Z0NXNjdnelNQQXA1V0FlYzRGRWxu?=
 =?utf-8?B?NUpzV1JWR1pBaEhUNEI2QVExNXdhMjB1NXVQbWFpNmVYT1JacFlLWkxmSk5V?=
 =?utf-8?B?MXllbFcxVHN4MW56QXpyMDl0YXhVQXJiR3JQU2NsM2tuSHhzMy90a0dCdXdS?=
 =?utf-8?B?UHp1WUpJZzRxSTZSQ0pJN2ppRUh0RFNheExlTUNvdm8yMWlDa1I5a1ZUTVdU?=
 =?utf-8?B?d3VYeldiNmxmcVJXN1EvTmpqUzRqZmxVQUczRzNXL2RGRFUrKzcyUG1lZEY1?=
 =?utf-8?B?UVlQOFgycHp3T1BXL3FDaXJyR0RRa3pHZlZLNEwyYnBnNGt3TnNvdm9HQzJt?=
 =?utf-8?B?bVZ0b2ppZ2dwNEVLMHM0T3UrZHM1TmlOaS9UUGxBaGhmbGxyVm1vczN1LzlS?=
 =?utf-8?B?N3daSjlJUm9JelNGaFBhNlovRFczSGxkaEdoazI4dXMxcWIyblNjN1FBbGNo?=
 =?utf-8?B?Q3I4WWQwQS9KZUo5dEdGenBwT2Rucm9acVowUEVCVGlmanNTRlc2bFcrcTdi?=
 =?utf-8?B?RUxEWTZCR2lnU2hCRWUrYlJJdGpwck13dWpqc0RodU0ybUZyTWg2RHBUcGY2?=
 =?utf-8?B?V292TlNDTVBpNk41YnNQQ2lJTDRYbFNwcC9HWFFxaldpL2t1dUdXQ0pPRHNI?=
 =?utf-8?B?alJ6R0xyNEIvQkpyV1ppK3REWU1CeEhnd1RrMHVPK01OOWFYSlcyV0UxaTFX?=
 =?utf-8?B?ZVNWVDBlWVU2alNDUVcwclFZYXdVdGpwY2RwM2J1ZWRhMmxYQlRSMFVyM2h6?=
 =?utf-8?B?RVdkaFFZeFczVnRpNW1jNlFuNG5qZTVQSmE2SlFRQ0pLK3R2QVJROG5QaVJX?=
 =?utf-8?B?cENxSGprZVd2QzlZWHhlVDM0cHd2Y1l4N3NjcStnY1pROTZpMjdUOEhsWVds?=
 =?utf-8?B?YkdjaU5lZU5iTUs5WFpkSloxY2puT3piQjBsYVp1MDFldW9MUGNXa2czelUv?=
 =?utf-8?B?UHlMM2VCQVcwTUlseEh4L1JDSlVVWkp1cGtETFFZdk5YSXZCcFJGeU1hRjZD?=
 =?utf-8?B?bENieURnQnRVOG9ydUcxc2JGSVdlYmlTNEh3QXJqS2tUVVBtQkx5eTFoVDc1?=
 =?utf-8?B?NWZkUWpyYzljancwVmc1NU9SNlZQOWk5YmswM0RYV1VXb25PZHY4VkdYSm9F?=
 =?utf-8?B?bUMvcjRIWnZyd0VTMHlzL1EyM1BxNjF3QXpTSlZsQ0o0ZnN1ejNLd3VMY2t2?=
 =?utf-8?B?SlBEcEFOSWM2V3E0amdKam9vN3JjWU82UStMMkRYWDdVdEdDRGFxSzB0Q2Fi?=
 =?utf-8?B?QWZrdkE4aHhPQTM0YWpSQ1Vpa3grVXk0Y3FXOXZheFRYSThWS3BPcmk4VDNh?=
 =?utf-8?B?WDdXYzJGVUVEQzJVbW5QWkxKczczTTBxK3hTeEZFYkV5ZFpXbkErSCtGRUtK?=
 =?utf-8?B?ZXl4RGplQ1FpS3BlVVRhbTY3bVh1TXQyUjJMTDR6TmlRMEx1QzNjeWoyaU83?=
 =?utf-8?B?aVVyWFpQMU94NUUya3A2aDBUdEFDS05mMzVqcDFKbzVNOEhsTGlTVk5GSDNF?=
 =?utf-8?B?U2hISTdnTjIrSE5sVWJPTytCVUhMbEF3OFdLQk9RMUFjWWFEZjNoYmNmU2Zu?=
 =?utf-8?B?QW5wNU4yZERsc0EyWTFVMTArUXF4UEIyRGg3ZFFCellXSklwaWxiRkZWdVRQ?=
 =?utf-8?B?Y2RRSWg5UXpobzc2TUJjcjhzY2NReVd0UmdnQmJuYmI3TkFuVlk5YXNhWFUv?=
 =?utf-8?B?T1B1TGNHaG9Ya3lXWUVzdmQzQVp4NUxSMWptTWlUeVZYbllEUU5BNkhhNzc1?=
 =?utf-8?B?STVkekV5WGkxTHJvMk5yUXFjSVJnbk1qWkxCbTBoaWJRb3VIajNTODUxaEpN?=
 =?utf-8?B?R2EvbXk0NWVMb0pVaml6Qm4yZHd0c0JPV3NEbGorT0VPcUltbmkyMlpJcFJj?=
 =?utf-8?B?UlNkcGtsVmx4SUhNbU9LU1BXTXBCRnFwS0tSZXRTOHRNcDUrTXU5TmFVdEpt?=
 =?utf-8?B?L2hwd0Vaa1F3MEFnd010dXAwUlhMWG1SdUs3bVZNcDZnNlc4U20wekFmMnI1?=
 =?utf-8?B?QlU4S2xtcmxPZE0vZlpMeXRDdXJtVTBGSTJmRGk3T1Z2Q015Rm1PQ0ZRTVA0?=
 =?utf-8?Q?OZdVS2TLYFjCEz2BnWDIOnSDSNdY8X2cALojJ1qkz1scL?=
X-MS-Exchange-AntiSpam-MessageData-1: CUQlSWMSIzndZmHPs0iTAwDOFBVknOQzXZY=
X-Exchange-RoutingPolicyChecked:
	tQl8zAkTlGVYNHhArfxyWib9vfGnYyXkRjhtCdd3/ahBDgS0Z/sjNjFnvvQx9Dj1r+F6UHo+7Ka6N3qH1bY2vZngRn9C6UFmkMrmfP5ppq2dtjY1LeHl6OFsP9XKlkDcUD3JwsZAfkDq8Yjk/7Rqxf+BJDwBBrjZw8arI5D5ai3K4NNs+r3rX83OJLmOyOGfvYEzcnSjK5BT0nczhB7SNPK5erBkGhKPcgWi1JEVE/MWy0vxrCKfnWNWlHsmlShK5Dm4A2pq8w7sZ2FBk9q1qvq1QW+N3cVegLHa8BvRM+LD3gw36iDaOk/MNe7b8YMgCCwt9xt7JbSJSf2/4eZGgg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fbd4f6-3d44-4d60-d4b7-08deae99c785
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2026 13:41:03.5330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ASWCUHJuLkGKvwVAf6etC5NqGbRkXOmB15TQoLdsxEBAnvOSUedlo5BO3U2mi8wXkwqCjgz7FPsTnjSbdMPfnVvt7ktdwzuS/kW088xqPB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7454
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEwMDE0NSBTYWx0ZWRfXzuPIEJmM6wWs
 Uf0WpoLGHf1cvA4QhEfrynWy+7bTp0wHagyGh87rJsryzfMKQ26rA9r7dUNiGNsBU2ACBSfltOq
 GfQ3vjtw24dNfss61zjZnABz4MGBRA3WXtUJY4yExXJwtTWQmSUvKLPYlUwbgRL/t9ks8b7ixz7
 AedQIqgS/fyGYJv2sUUt2NMWcnx0Bf2Y9BSx8qhazPHSTam2BCf6/KbHK5BvzVOy5TKAYsw7XB/
 8OLPG/IMBXY63U37wo2mnA+jM4tVZv5YkY8BLyW2l3dpN6gzepYjO5TOE0khzFYapw8IQcV/3n1
 mGAlvmzH5f4Z0Z+mcfeB2nhD+QFBQpE7cOB6ABCXpuqqjHYnBB2ZYfGkcDlRF+72yb9h245wX6b
 eBMYFPg3XhHpfK4Q23+4qRAj6SqbyQBzXxSTDA4340qD6/dPzGB7qiPessTmvdJ9Pz0mkPKf73M
 fvuNTpgJxPSr5BJd02Q==
X-Authority-Analysis: v=2.4 cv=d6nFDxjE c=1 sm=1 tr=0 ts=6a008af2 cx=c_pps
 a=liM/1wbVBp7o1MBwTafONw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22
 a=bC-a23v3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
 a=t7CeM3EgAAAA:8 a=FexixdgSPsgHR1urB5AA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: eQ4ruzHx7JdtMdcsEIaYsqbGrZ6UHLIj
X-Proofpoint-ORIG-GUID: eQ4ruzHx7JdtMdcsEIaYsqbGrZ6UHLIj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-10_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 adultscore=0 clxscore=1011 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605100145

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

commit 8002d6d6d0d8a36a7d6ca523b17a51cb0fa7c3c3 upstream.

When DW UART is configured with BUSY flag, LCR writes may not always
succeed which can make any LCR write complex and very expensive.
Performing write directly can trigger IRQ and the driver has to perform
complex and distruptive sequence while retrying the write.

Therefore, it's better to avoid doing LCR write that would not change
the value of the LCR register. Add LCR write avoidance code into the
8250_dw driver's .serial_out() functions.

Reported-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Bandal, Shankar <shankar.bandal@intel.com>
Tested-by: Murthy, Shanth <shanth.murthy@intel.com>
Cc: stable <stable@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Link: https://patch.msgid.link/20260203171049.4353-3-ilpo.jarvinen@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/tty/serial/8250/8250_dw.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 88c55336d50f..05e45b63e5f5 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -181,6 +181,22 @@ static void dw8250_check_lcr(struct uart_port *p, int offset, int value)
 	 */
 }
 
+/*
+ * With BUSY, LCR writes can be very expensive (IRQ + complex retry logic).
+ * If the write does not change the value of the LCR register, skip it entirely.
+ */
+static bool dw8250_can_skip_reg_write(struct uart_port *p, unsigned int offset, u32 value)
+{
+	struct dw8250_data *d = to_dw8250_data(p->private_data);
+	u32 lcr;
+
+	if (offset != UART_LCR || d->uart_16550_compatible)
+		return false;
+
+	lcr = serial_port_in(p, offset);
+	return lcr == value;
+}
+
 /* Returns once the transmitter is empty or we run out of retries */
 static void dw8250_tx_wait_empty(struct uart_port *p)
 {
@@ -207,12 +223,18 @@ static void dw8250_tx_wait_empty(struct uart_port *p)
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writeb(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
 
 static void dw8250_serial_out38x(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	/* Allow the TX to drain before we reconfigure */
 	if (offset == UART_LCR)
 		dw8250_tx_wait_empty(p);
@@ -237,6 +259,9 @@ static unsigned int dw8250_serial_inq(struct uart_port *p, int offset)
 
 static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	value &= 0xff;
 	__raw_writeq(value, p->membase + (offset << p->regshift));
 	/* Read back to ensure register write ordering. */
@@ -248,6 +273,9 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 
 static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	writel(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
@@ -261,6 +289,9 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 
 static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
 {
+	if (dw8250_can_skip_reg_write(p, offset, value))
+		return;
+
 	iowrite32be(value, p->membase + (offset << p->regshift));
 	dw8250_check_lcr(p, offset, value);
 }
-- 
2.54.0

