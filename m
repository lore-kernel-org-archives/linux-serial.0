Received: from mx0a-00300601.pphosted.com (mx0a-00300601.pphosted.com [148.163.146.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC1618DF6E;
	Fri, 11 Jul 2025 19:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.146.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262080; cv=fail; b=hmjaXiSTWf4qfPVbl9/QZmr5J11zzzJqS6b1LmAZCu6CuTLgFfDBCCpwzRurcoEiLvovk+ViFBT3NSVs2nKEZ3Yk200fhmk6xu6sT2aQKrNXILgdsv7bcdbzO7AjT7IYoLjLk3j1/TlTwN6Y3BoOYMtsowEhAsEcpCAcdbNHIQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262080; c=relaxed/simple;
	bh=IVUFTEMMV3I5jUOFrG8eIa9YXLedrs/f/ehEYdKQ4Vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KuwgnfEyVbu/fsPcSuSrgwMiSXwiiyXBCKrSaf/xGs/KZhZUCvRUPIEIy6Xs1s79wJUDQnCHemBg6kf4FNzBcx9qH6KtedW21u36J5XdpBw30pJNW6P38OmrG3PoZFvJVyOnvES+6rKmIYPepCOJgpu2hRdDF2Ln69iRcTWSmO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com; spf=pass smtp.mailfrom=emerson.com; dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b=BWR3xYBk; dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b=DmLff3Hu; arc=fail smtp.client-ip=148.163.146.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=emerson.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=emerson.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=emerson.com header.i=@emerson.com header.b="BWR3xYBk";
	dkim=pass (2048-bit key) header.d=Emerson.com header.i=@Emerson.com header.b="DmLff3Hu"
Received: from pps.filterd (m0484889.ppops.net [127.0.0.1])
	by mx0b-00300601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BJFJ6G019901;
	Fri, 11 Jul 2025 19:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emerson.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=email; bh=axAi
	B6VxftMtCcozwkEpBUaj6QONKmUHqHEiGBaqMDs=; b=BWR3xYBkRyxmKjc/PEfO
	E1RW8v3UN7AU4g29laW8POSM4C2m/kna18/sdW2OxqnyR/oIgfguSb4wFBcHL9QC
	9ssiK4r7Kmh5hR727Wx3FJN7QJZY8gJyCFrIeimrbg8dIsgzPhGolnBc0v1FlolH
	OnR7hNAoHuAB2jBUabU1+tU3GNFBlM8HtUIig/oTA6qCPzRG0b9GSnNgRHdD/hO7
	whlbk0fzXTRh5CYgrG2I3XpAx9NLFHCvZ3Xq67qZSpuUgjGrZt1DpVN+BJLFjW98
	bESOUlg5gXFKrEdrV/swH6lGdCHF1MfQj3FPPc11TDVc9bMmMAfLXvGxMMLT0EV+
	NA==
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	by mx0b-00300601.pphosted.com (PPS) with ESMTPS id 47u1drubyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Jul 2025 19:27:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QieHVjm2L/x+eISRUEyVpAH/SnB1XtkclNDVtZv+Db+5iZGfxcDU5iRBHKHUPO10CrJZbPne1HUxG7glrukKew0HrS1Q4lRXOQv/6PAN71i/xCdOxhQqSdxco9lugQn3kWqRKZcRc4XgcdYsPpUZSqLbR14a2O/LTOtyxxjnGF9ZTiZdSb4Re+l8AoDu4hcQIWU7uMDhZUJnZ26aFCGeU9BmqP2wAgLqYF0gbeGVbjYv6e8MDy2szXbAgMg6gyNbhQ6n/ANkPSz1vbZjB5M8LxOGgbpsMpL9GcutLOra9PGiH1o3e3zHwacmMDwx/33gkBb0/ZkJP8kZz1MZ2tCx3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axAiB6VxftMtCcozwkEpBUaj6QONKmUHqHEiGBaqMDs=;
 b=Vi6ZtHsFaNe+ootGKPPcwlNVa5JtTMjp3+K6gXwttfCaEXdn0ntydck9qTjFRzV24nKGncjzcojsNggBU02gEC6HvjXfeFT0oUWlYguzUqhvVxR90DjWdr1baE6qaPKeoZB2uAGmY+Lqcvcd+69wubnFL1LYWS3of9zLJzmJtkGDOmLoVjv4cKnAG8eiCX1glvQGNhQ3ANUB7UOQfZbsXwxpzcdWLpy/pfkfqqFLRC+Y8TMOuYUabhdFLkwa4vJ/2BYvcnjOV33+VtYjgYtgtLnBSi+ciDgdXybQwRNZEzJPf3veY2bzROPg0kET2bV1dTgdAuJGqPrZdxvvVTMPSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=emerson.com; dmarc=pass action=none header.from=emerson.com;
 dkim=pass header.d=emerson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Emerson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axAiB6VxftMtCcozwkEpBUaj6QONKmUHqHEiGBaqMDs=;
 b=DmLff3Hu8TxSCdD4ixQNxfXRXJFN4uggkqxobF0b6HRB7E1lKrfYYmNuEj1NLCoigKSQ/8ZUXpTchPWPyEOgVbGqKOziIYnXUGKZz2xXP9UB42FEy5Iy8NzaH2VJ4KlILT2HYTfnRnunWdiPhT/uvafqx99enOhipKwjCpXH9cjrcyOa6WmuyYL6jhDsK13ntTvcLM/12F9/zm5Is5U8d+WCBbyVe+JLBKl5BYojqxuzL2fhjinBsYJ+7tQYr+vhPFQpf0jTEq7kw6HxeBSzg9mOTZ2rYmM5k61ARtE1IPGhCUUhpuI3JTnfzPElOZN/KudNjnU4rYAQAtJE400tAg==
Received: from MW6PR10MB7640.namprd10.prod.outlook.com (2603:10b6:303:245::13)
 by DM4PR10MB6888.namprd10.prod.outlook.com (2603:10b6:8:100::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 19:27:50 +0000
Received: from MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54]) by MW6PR10MB7640.namprd10.prod.outlook.com
 ([fe80::ba9c:1796:379f:af54%5]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 19:27:50 +0000
Message-ID: <991f5fe9-b810-4aef-825c-d0b532584730@emerson.com>
Date: Fri, 11 Jul 2025 14:27:48 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] serial: 8250_ni: Fix build warning
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Jason Smith <jason.smith@emerson.com>,
        Gratian Crisan <gratian.crisan@emerson.com>
References: <20250710223838.2657261-1-chaitanya.vadrevu@emerson.com>
 <2025071102-zombie-disbelief-4c38@gregkh>
Content-Language: en-US
From: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
In-Reply-To: <2025071102-zombie-disbelief-4c38@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0199.namprd04.prod.outlook.com
 (2603:10b6:806:126::24) To MW6PR10MB7640.namprd10.prod.outlook.com
 (2603:10b6:303:245::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7640:EE_|DM4PR10MB6888:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d66fb88-af22-428e-884f-08ddc0b1061d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VDhNYmkzV0NSNWdSOXBKVHVGeUVrZW1OUk9UODluVThOZUUxMWN1bE50Qy9l?=
 =?utf-8?B?b0w5RmZpS3hSV0NKbmgzN0NkVHA0b1ZRWkFTNWh4VHYrS3ovMGRWNnhNRDFn?=
 =?utf-8?B?OS9HUm12SkNKdVR6MlViNkw0ZlFjZ0svQ3BsTldVMHR5YUZlY0svVXJaRFNW?=
 =?utf-8?B?Y1lxMGhveUt3NHdNdjRETE9QUUNJdCtBUWtlOHl5dkhEUU1WbHFGMVhndGVm?=
 =?utf-8?B?YitGanRVYnFGZ3RDVFovMUo4NkVHMCtDUHVKRDRZVFZ4Z2EydFJuTG5haGNj?=
 =?utf-8?B?WkVGM25OZzBBa0R1ek95bnp5bDYvUFIxNEJXcGZVRW45SVZVeXpySVIrd1Rq?=
 =?utf-8?B?K1gyRGZlcTYyR3djb3pyajhtVklXcVRpL1RtRTBXY0NqMDVOVHZpYUFFYVpr?=
 =?utf-8?B?SFNidmhMcjAvNjR3QlJDRk13a25QZTVXVDhoUlhEZUJWZ0Y1eUVETkc2ZExZ?=
 =?utf-8?B?ODhtTC9lRkZTd3hrbytVSjlsU1Bxdm0xNklkZFBKK0k1eGZ2S0Vvc0RhQlla?=
 =?utf-8?B?clgrOTQ3eEhzY2I4RWdYSENBU0c2R0ZjUzExMWlJQno1WFZnV0VPTThHNWJP?=
 =?utf-8?B?RHk3bFp4QlptSUxtdm1qVWFjSDlUQVJSV3ZTMUo5MUYvSy9XQTE4aldNeWM5?=
 =?utf-8?B?cnNqZHdxTzcxWWVSUHBTaTlYN1hXZ0ova0JwWk9RZVdpYUN1MUJrYlNsSWlo?=
 =?utf-8?B?UU1Bdm9qdlF2Z1ZSNEVwdHBpMERmWkh6UW95bVV0aW5la0U5QUVIK1VOZll2?=
 =?utf-8?B?T2daRHg0UlEvbjk0SDIzSGJMWDdvWk14Q3hkemw3eFVWbzFGRG9xOW5HbG51?=
 =?utf-8?B?VFRyRElTeGp4T3hHaEgxZ29KQmFiUG1wRUpwUVhveTBrQmx3NWw0TFNiYWhq?=
 =?utf-8?B?MVVXUXNxdDFwSGFjeTEyQTBkOXB3SThqc1JxY1dZNEZoaDhtVWczV2dEbjBm?=
 =?utf-8?B?YkJmaFVuclBGNHFwZ0hQakJsVEdzbm9sY2p1MTVVTTdDeElOT1U3QjVMdEZW?=
 =?utf-8?B?REFmSkQvTUJFbFhUNUIvR2QrV0p0OGY3WXh6Qk11SVRLL3BMdk1VRUpmaG85?=
 =?utf-8?B?alZVemtkM1JKbW5WUDJ3QmcwczV3cXNzL00rWTF1MG54ODREdzRmMmZnZTJP?=
 =?utf-8?B?bC8rYkFLT3kva2tqREFwckVtQ1h4RThPVlByQjlUZnZIOEpwRlExZUZkY1Mr?=
 =?utf-8?B?czgwbmtYNUV0NnE2eUJKVmZhN1Bac0R2VmxMM0t2RmQ1T1ZGdSsybW5zUy9k?=
 =?utf-8?B?ayt2ZTRzV2hqY3UvT1hSUlFaRlZ0TjAvVHgwTjY5UXl1VHZVaTE1MWsxWk16?=
 =?utf-8?B?a2Y4NGdOVVh2aEhOb21lMlQwbDROY2RKZFZtWkNvbXd4cDJvQUlxZlRqUjM2?=
 =?utf-8?B?eWtFM1Z5cStTdjlCaWk2SkVQNTdTY0lLbFRucDFmUnc0dEN4aTFKSTNrRXU3?=
 =?utf-8?B?TURrZjloUUQybUdad1I5TG8wYlEwNHpXVi9XS3dtL2Y0Ry9VNi9Oa2dlQlVz?=
 =?utf-8?B?Wkh2MEk2R2dLNkdYQ2tKN0tGMWoxc1QrOFNYZ2dYbGNSTStaNk1CdUxFaFhQ?=
 =?utf-8?B?WTIrWGt5WnFFdXd0am1WbjlEWmY5OWgyRjVkOVN1MGpRVDhsUDBQUEp0NmIv?=
 =?utf-8?B?SFl2L1VjYmh2L0RvK3RmRng0T0d1K1lYOThyaFFLWnB0WFhIZmF1Qm1pRnJm?=
 =?utf-8?B?OWxraVlLV3BMVzJicFpuSXYvdk1ocWNRSDlGZ09qSzdyT056aDdBYnp0MFZG?=
 =?utf-8?B?NTVOa040QzF1cTFRMzErUC96VGVtZnJ2aktuZUtQc1pnekpVQy9WckNpeHp1?=
 =?utf-8?B?QkxicDZqK3RmakZLWGE5M0d4czdKc2F1VEtBdjNnaTA3VVAvU3FaYnlmcFFS?=
 =?utf-8?B?U0Z0OVZKM3hudW00bWZFTHBKVUU1ZFVMMzJvWlpzUnNRL2p0SHRqSHBRQjEr?=
 =?utf-8?Q?WN50ZBIbDV8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7640.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3k3Tktnd0ltc0g1dGVnTC9QQWZYNmplUFdta2Q3TENmRzNpc0hZSjdiM1N3?=
 =?utf-8?B?NVZHbGU0NjFvNUlZRzZ3RTVUaDJPKzRRNkNBM3JFYVNDckFaVEVZUHpiazUy?=
 =?utf-8?B?cnIvanJSMk40OU5YSGxSczhWMHJuV3g4d3V0bk1ZcUFIa0Y2NlR0SnVMemFo?=
 =?utf-8?B?UUdSTFNxcHd3SDRsMy9IbzlaNUZQWlhDd3k1Yk4zdFhVWEtaV2QzWndOMzZJ?=
 =?utf-8?B?NXpza2tHTEQ1SE1KQTQxZnNWUXVhT0dUSzdnWXFwT2lsaUx0Wm9zZFVzODFR?=
 =?utf-8?B?VGtzdS92SDJic3dwU1R6RWg1cFhweXk3K1cwbVlSZkJpMXZmRDhuTklNK2c0?=
 =?utf-8?B?b0oveVZ0NllBRk9KSG1MZzZVT3J5ZnUreFdzM3UzUUtOL3pPOGx5dC9iY2k5?=
 =?utf-8?B?N21nM2VzZGxQNitQTW5BcmEyWThTWDVJTWh2YU0xVEpUSm9JSW1wNE0zcCtp?=
 =?utf-8?B?eUVHQ2ZCV2txL0VWYWMvUWUxNXljWUxLUWxDdXV3L012bFZ0RUdYOUVFeDdl?=
 =?utf-8?B?Mno2Tkpqc0RCZnZGdVFHYWlYeWpGR1JlSEMzaE56RFgwckVFMkJuODc3NEJy?=
 =?utf-8?B?a05QSzNzQ1BFczJUMzA4SXdvaElCWXhLZjEyQm1kQ2xtZFdocTVxRmpCenpa?=
 =?utf-8?B?L0RqTTIvQWFna1piQkFhNVRLVkNadVE3QXY5ak9oMUlSMmZ5MWRzeW9GSFM1?=
 =?utf-8?B?LzRKSXVvSHVvaHhldkdIY2pHUjFwTUpzWTF4WWhHbDdwazMrMGwwQi9IbnA1?=
 =?utf-8?B?WkpFeXl6TktJNmlZKzNRY1ZlMVhJNjJ2aWlTdm9kWkRpVUplV0IvYVE4VUVm?=
 =?utf-8?B?NzIxWGt5eEk1SGIrY2dCUTI3TU5EZE94VTRyRWFGWGd1WUJOWjFGeHc3Rjla?=
 =?utf-8?B?QXBCNG1vOUJybFJERitEMnY4T3RiTnpCRGtKWHZXT1Q5M3Ntc2ZGNmRwZnpR?=
 =?utf-8?B?WjB4Z3ZvNWMzMmlBdmxEczZwWDA4OHJSa0Y5N25MSXF4bDNmc0d5U1J2RVpx?=
 =?utf-8?B?aXVLSjNJSitLTnQwdkM4TEVRNzJvMjlOQmtML0dwOU8wRmhBelg0ZTdTNlc1?=
 =?utf-8?B?YmFaYm5XcEF2TG5yU2l1SFVzMFMrQjJkL3F5dnM2MGZ2cFBWako5Y3k5aXBO?=
 =?utf-8?B?VGh6MjhITzFmaWNGd0t6RndiSkRYWUwvVHk3aC9FQkdocVVDU3ljdGd2bG82?=
 =?utf-8?B?V284OHBqRWpVSlBNR3dhWmJnbjdianN3Sk5KbFJyTFp5Y0xXbWExTURKMHBC?=
 =?utf-8?B?YWJBS3NGR1BwdnVWMXVrOVY3RkU2NkcxWDFDU1dSakZZM3ZCRVRWQWRMNmNw?=
 =?utf-8?B?TXpHTTlVcnIvdnJZTkUwK1NmU1lyRCtkV0lKd0ZHTVJwS2hZbWZ3Q29OUDVP?=
 =?utf-8?B?aFozVnQ4WlVqUXhJTDl4ZWRkUXBibUNqZFRnUDVKc0xqcDRJMnhLdW5Rdkhk?=
 =?utf-8?B?Uk1oc1JaMXVVd3E3eE9HN3FuZi9Gclc3TWhJZnpHZlZSV0hRN1hsMzRrYjRl?=
 =?utf-8?B?dE9TWmRBU082Y3Q2Lzh3a1gySFpTUkxsZ3NLTmVzV3c5cHFZTUNra2J4MWx3?=
 =?utf-8?B?YVRGSEQrbVhhblpNT1FBVHEwMmtPMGU3cVJaZjFLUHZQVTdxckY2S1lOQ0Q0?=
 =?utf-8?B?WUFNbmVrYmNyUHk1UmpQME95dWFRRHBnS1BYcDZjYUtHYitoT2EvM2lKNHAr?=
 =?utf-8?B?Rldla1I3U1hDaFBIenpYQ1JFNXFSbk5yazBISnk5bHIwMWpta0xrcW1oL0x0?=
 =?utf-8?B?aFprazNzZjUvaU9RYkdsL3FxeVVDS1pxMTQrYmwyL0M1d1FRc01uUUpJV0lR?=
 =?utf-8?B?dEdsQ3FVUFNtcHVWa0NxaDMwbzZQc2ovYzlSUFBIVmdFblBTWlUyT1NEUGZN?=
 =?utf-8?B?bGhza3lVWnlyNW4xeUdsaVUvdkErekppUi9mbU1VR2Nvd3dEME1wQ29BMzU2?=
 =?utf-8?B?RG0rc0VJdlgzaWhrNytBWkszVUpFMEdoZUtKV3c2MUMrMXZOSUo1d1RUMEt0?=
 =?utf-8?B?bjJIeTNUa3d3cXgzNkFEMnpaU1VuWFFtK0J3UTBTSnZTc1pIRmJUaWgzNFMr?=
 =?utf-8?B?UitsbXNVSDFRWHRrUU1qUVowSTJzaGVYdG8vRjcxa0xYTU9hQ2VrTjc2c3RP?=
 =?utf-8?B?bk1WTUkzQStaSmQ0U004aDRqcS9TRno1eHA5Q1VBenVoNzY2OElLUlVtY1hz?=
 =?utf-8?B?Unc9PQ==?=
X-OriginatorOrg: Emerson.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d66fb88-af22-428e-884f-08ddc0b1061d
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7640.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 19:27:50.2853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eb06985d-06ca-4a17-81da-629ab99f6505
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZvsZ3EqrQKk3MhwItto4KPY4PmMzbGMFzVIRJHwWkSbIu+L1azLDFlrvWcgm4YS4r0waPj3RGp8rElaK9SoKbcIBuMdPzrDYMKaIOrPkY44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6888
X-Authority-Analysis: v=2.4 cv=SfL3duRu c=1 sm=1 tr=0 ts=687165b9 cx=c_pps a=QIZECQNxG9OrthprMUZrHA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=ZPWZ4rD8_x8A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=geDs06hvAAAA:8 a=Xf0MKMpYdE2wLEPG6wIA:9 a=QEXdDO2ut3YA:10 a=7yvi0DHx91fDKfvzWsLo:22
X-Proofpoint-ORIG-GUID: u62XwAx1pH5cwSwd8uakdzhHXP_cAdQT
X-Proofpoint-GUID: u62XwAx1pH5cwSwd8uakdzhHXP_cAdQT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDE0NCBTYWx0ZWRfX8dInJluMCfx2 1sJJB6OP9/Fw4Hhs1Ks3q58M7dK3dBP2tqVc3TDBQoLq6U2/vGHvmL2HpIqZslhxrnQE/5c2ssA noER+YATcXoeSICuW+xl966BzRi3CJD69wbOkQUVwCDy+5ODT9Wqd7s+zqlzN6OmMCBfjLvYXFz
 VXA1YLqjYJDBvpUouHI5+EJRxUWPMZ7uC6a6lTTYeVfSUnYskW1HMejjIlnoHNugxv600RDoCSf KhPeZKQ2SH/6y7ehLqrONhLhfGl2S2Uv1bKqyFo7LZDpJpNLN4R+BfF64lKr8FDk6nVGxf4g/vP bvfZJxGaPhyk7Z3Ydctmz6u/x7oNCdWJO5GjJwx3uQ8+1kkKdyMMfFbE5edqnKhtvMDeHCezzBG
 B2qaFxexL2zABJfJAWKI0p7HHhHX/JCY5QcyHfG3SxR4PWJNQULtp+GJdg9PFk2LPlLZNpRg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_05,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507110144

> > Allocate memory on heap instead of stack to fix following warning that
> > clang version 20.1.2 produces on W=1 build.
> > 
> > drivers/tty/serial/8250/8250_ni.c:277:12: warning: stack frame size (1072) exceeds limit (1024) in 'ni16550_probe' [-Wframe-larger-than]
> >   277 | static int ni16550_probe(struct platform_device *pdev)
> >       |            ^
> >   1 warning generated.
> > 
> > Also, reorder variable declarations to follow reverse Christmas tree
> > style.
> 
> When you say "also", that's usually a hint this should be a separate
> patch :(

Sure, I'll split this and send a v2.

> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202507030557.vIewJJQO-lkp@intel.com/
> > Cc: Jason Smith <jason.smith@emerson.com>
> > Cc: Gratian Crisan <gratian.crisan@emerson.com>
> > Signed-off-by: Chaitanya Vadrevu <chaitanya.vadrevu@emerson.com>
> > ---
> >  drivers/tty/serial/8250/8250_ni.c | 56 +++++++++++++++++--------------
> >  1 file changed, 30 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
> > index b0e44fb00b3a4..cb5b42b3609c9 100644
> > --- a/drivers/tty/serial/8250/8250_ni.c
> > +++ b/drivers/tty/serial/8250/8250_ni.c
> > @@ -275,76 +275,80 @@ static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
> >  
> >  static int ni16550_probe(struct platform_device *pdev)
> >  {
> > +	struct uart_8250_port *uart __free(kfree) = NULL;
> >  	const struct ni16550_device_info *info;
> >  	struct device *dev = &pdev->dev;
> > -	struct uart_8250_port uart = {};
> >  	unsigned int txfifosz, rxfifosz;
> > -	unsigned int prescaler;
> >  	struct ni16550_data *data;
> > +	unsigned int prescaler;
> >  	const char *portmode;
> >  	bool rs232_property;
> >  	int ret;
> >  
> > +	uart = kzalloc(sizeof(*uart), GFP_KERNEL);
> > +	if (!uart)
> > +		return -ENOMEM;
> > +
> >  	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> >  	if (!data)
> >  		return -ENOMEM;
> >  
> > -	spin_lock_init(&uart.port.lock);
> > +	spin_lock_init(&uart->port.lock);
> >  
> > -	ret = ni16550_get_regs(pdev, &uart.port);
> > +	ret = ni16550_get_regs(pdev, &uart->port);
> >  	if (ret < 0)
> >  		return ret;
> >  
> >  	/* early setup so that serial_in()/serial_out() work */
> > -	serial8250_set_defaults(&uart);
> > +	serial8250_set_defaults(uart);
> >  
> >  	info = device_get_match_data(dev);
> >  
> > -	uart.port.dev		= dev;
> > -	uart.port.flags		= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> > -	uart.port.startup	= ni16550_port_startup;
> > -	uart.port.shutdown	= ni16550_port_shutdown;
> > +	uart->port.dev		= dev;
> > +	uart->port.flags	= UPF_BOOT_AUTOCONF | UPF_FIXED_PORT | UPF_FIXED_TYPE;
> > +	uart->port.startup	= ni16550_port_startup;
> > +	uart->port.shutdown	= ni16550_port_shutdown;
> >  
> >  	/*
> >  	 * Hardware instantiation of FIFO sizes are held in registers.
> >  	 */
> > -	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
> > -	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
> > +	txfifosz = ni16550_read_fifo_size(uart, NI16550_TFS_OFFSET);
> > +	rxfifosz = ni16550_read_fifo_size(uart, NI16550_RFS_OFFSET);
> >  
> >  	dev_dbg(dev, "NI 16550 has TX FIFO size %u, RX FIFO size %u\n",
> >  		txfifosz, rxfifosz);
> >  
> > -	uart.port.type		= PORT_16550A;
> > -	uart.port.fifosize	= txfifosz;
> > -	uart.tx_loadsz		= txfifosz;
> > -	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> > -	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> > +	uart->port.type		= PORT_16550A;
> > +	uart->port.fifosize	= txfifosz;
> > +	uart->tx_loadsz		= txfifosz;
> > +	uart->fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> > +	uart->capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> >  
> >  	/*
> >  	 * Declaration of the base clock frequency can come from one of:
> >  	 * - static declaration in this driver (for older ACPI IDs)
> >  	 * - a "clock-frequency" ACPI
> >  	 */
> > -	uart.port.uartclk = info->uartclk;
> > +	uart->port.uartclk = info->uartclk;
> >  
> > -	ret = uart_read_port_properties(&uart.port);
> > +	ret = uart_read_port_properties(&uart->port);
> >  	if (ret)
> >  		return ret;
> >  
> > -	if (!uart.port.uartclk) {
> > +	if (!uart->port.uartclk) {
> >  		data->clk = devm_clk_get_enabled(dev, NULL);
> >  		if (!IS_ERR(data->clk))
> > -			uart.port.uartclk = clk_get_rate(data->clk);
> > +			uart->port.uartclk = clk_get_rate(data->clk);
> >  	}
> >  
> > -	if (!uart.port.uartclk)
> > +	if (!uart->port.uartclk)
> >  		return dev_err_probe(dev, -ENODEV, "unable to determine clock frequency!\n");
> >  
> >  	prescaler = info->prescaler;
> >  	device_property_read_u32(dev, "clock-prescaler", &prescaler);
> >  	if (prescaler) {
> > -		uart.port.set_mctrl = ni16550_set_mctrl;
> > -		ni16550_config_prescaler(&uart, (u8)prescaler);
> > +		uart->port.set_mctrl = ni16550_set_mctrl;
> > +		ni16550_config_prescaler(uart, (u8)prescaler);
> >  	}
> >  
> >  	/*
> > @@ -362,7 +366,7 @@ static int ni16550_probe(struct platform_device *pdev)
> >  		dev_dbg(dev, "port is in %s mode (via device property)\n",
> >  			rs232_property ? "RS-232" : "RS-485");
> >  	} else if (info->flags & NI_HAS_PMR) {
> > -		rs232_property = is_pmr_rs232_mode(&uart);
> > +		rs232_property = is_pmr_rs232_mode(uart);
> >  
> >  		dev_dbg(dev, "port is in %s mode (via PMR)\n",
> >  			rs232_property ? "RS-232" : "RS-485");
> > @@ -377,10 +381,10 @@ static int ni16550_probe(struct platform_device *pdev)
> >  		 * Neither the 'transceiver' property nor the PMR indicate
> >  		 * that this is an RS-232 port, so it must be an RS-485 one.
> >  		 */
> > -		ni16550_rs485_setup(&uart.port);
> > +		ni16550_rs485_setup(&uart->port);
> >  	}
> >  
> > -	ret = serial8250_register_8250_port(&uart);
> > +	ret = serial8250_register_8250_port(uart);
> 
> So uart is freed after this and that's ok?  Are you sure?

Before this patch, uart was defined on stack where it would also be
freed at the end of the function.
I see similar pattern being used in other 8250 drivers where they also
define uart_8250_port on stack. So, I don't believe this is an issue.

Thanks,
Chaitanya

