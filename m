Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.56
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793116316;
	b=KozNoxUsFrl/POTEU+eURCozDthOZcjsU7xmwvy1c+bfRcr+4slq7WRGjFnCLzqNt4rv
	 30VzHH28e+qnhpDt4Wmazr7o7AyPs9h+Zxi0usjCrxi7ypIeErHURTA5kc0ZOOeIJK2WX
	 t36tXAV1ocqk9tMjvyDt+O5kculEk3+ENGvBM6xnAP8K3/7wiyAKtHPDUjx/7JcrgmhA3
	 sAukWenbNfU2XPho8JavX2ZgeX8udyrObF07AdE+DF0gNpqfMULTrM1bxjDte0mfj/QVu
	 yvuGP910cLCmup1H2s47T0lgbc3HqUgmq0tDCN9Ptpu5X94Ayoqk/41nlDlLSTKf1ww==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116316;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=lVBnn/kwF1N44jQKpuK1cugn5AVXBs178J6gGYiQ9XI=;
	b=Vc7r7Db0UBZ5XjWotoGxNeIJWkO2zN4xgSM0lJ3nQO9vPRlLi46lzs6HBLcsBz1wmp5z
	 w9jwfvHvzoJtB5JpXxYXllcc1dFPZQAczYRPnkazoErMr1n+SP9ZDGN4jMqHpNpE0b4a+
	 3Ob1HQRUJBYvIDNeZetVAutegW8T4koCwJCyiLz9VsBZsDnmN7tyW0qExuZlb+EvYi9nW
	 BoYhs9VJDce7RZD+uuwcDe1jgcKcC/3QT9KmCBlnIaNWjLITuefqGxX9HAa1nfSGPIEmF
	 sCh308N1SJqWd2KZndtYTClMRWONHI76XmK2iaB8jUcEfCfV9AuokWr7Ts1JJEYSjkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=El8Ub3SQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.201.56
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE25606FC9E;
	Tue, 27 Oct 2026 15:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EDE25606FC9E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=El8Ub3SQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZWwAwoSx+P4FxPQNIQslkbyZpSP9gG3yV2ZBwgWJl2QErHd7docAr6iqNwp8aE8fQyKAAlT2d2OS6Gv4mR1cNVW4Qiory68wps5nFJIP4eNa6SQCYRRaS6wgMu0tF9EB5U33oO8oBoUMdFFajDrFDhfB5yz/f7fPJ66zlzyldNLHUXp5Ne/LhmR6cQ3uQ5MbJMgsDa51BxvgTL1agAUgnUmu7M4T3BhHc/mJbamJMiSFeyV2xtRj23tKuF3gjUh+/lJ5nb/S+95PhwVKtA7YUFXsSeTpNpRN/dUsfkmnrKRk6I6+RCX9cjbLF43FfZuj/gLiPva7j1/4AdXqBhYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lVBnn/kwF1N44jQKpuK1cugn5AVXBs178J6gGYiQ9XI=;
 b=e1zWJIRlec3+w4R/F1XQtfXRM9q8CDg4pqSW5Ag4vj7P82tQQRltF7W03jXL2/98SqpDOgySx42FrRRKJh0y7ajah0YEs/Dwv5JU4DddLVhHaTpop4jl4o7cEJG93XCwd7CKSOWzRnkXI6YeJe7qukXlzetRuxxVT2W6r/MkTtihoNkgKeC0sUH9xyxwhkfGptw+aGze2aswFzgbDNSewdZAc7nOgJT0bzoepDc1RBWkvHpw7nW9NwlZYNGTBuzR9n86BLubBM5Fd488d09JI6kvgSrcGDEiL0w4zqAb7w9LlYDKAQeKLpr0uAsaYie9QaOVrH6Ar+xLGmZwA3gMdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lVBnn/kwF1N44jQKpuK1cugn5AVXBs178J6gGYiQ9XI=;
 b=El8Ub3SQkAhZcV+zpyAe0zN8vPTbpl4nBK4/iXCUisHvmDVms55nfIJxJBFVF/0zhIExpODe1tl5Ba3X7hOjKRObKuvPZuqT/On8pTdzNKrn+RLZ7iPAHDBjl1LMjo6w6yhbT4jASfEXg+8wJ+prmaCf7MpaViLfgiBxPx8zko0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by MW6PR12MB8866.namprd12.prod.outlook.com (2603:10b6:303:24c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 15:51:50 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%5]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 15:51:49 +0000
Message-ID: <3d38c4a5-1a12-4af1-ac2e-413a457ce4c5@amd.com>
Date: Tue, 27 Oct 2026 16:51:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/18] firmware: arm_scmi: Allow SCMI transports on
 RISC-V
To: gaohan@iscas.ac.cn, Sudeep Holla <sudeep.holla@kernel.org>,
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Zhiguo Zhu <zhiguo.zhu@linux.alibaba.com>,
 Jassi Brar <jassisinghbrar@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Philipp Zabel
 <p.zabel@pengutronix.de>, Thomas Gleixner <tglx@kernel.org>,
 Radu Rendec <radu@rendec.net>, Samuel Holland <samuel.holland@sifive.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Anup Patel
 <anup@brainfault.org>, Stephen Boyd <sboyd@kernel.org>,
 Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Drew Fustini <fustini@kernel.org>,
 Icenowy Zheng <uwu@icenowy.me>, Inochi Amaoto <inochiama@gmail.com>,
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <me@ziyao.cc>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-gpio@vger.kernel.org,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-clk@vger.kernel.org,
 linux-serial@vger.kernel.org
References: <20261027-a210-scmi-v1-0-74d58ce85bd8@iscas.ac.cn>
 <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20261027-a210-scmi-v1-1-74d58ce85bd8@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0218.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::13) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
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
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|MW6PR12MB8866:EE_
X-MS-Office365-Filtering-Correlation-Id: 09d77921-3e9f-4e1e-6156-08df34423699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|366016|921020|261026121527099003|11063799006|4143699003|56012099006|261021123027099003|261009223027099003|261022105027099003|10067099003|261021121427099003|18002099003|22082099003|6133799003|261026140227099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XPvcZYuTVwRWh4B85Nxge+uI2SlrJ0ohRyqF3CBbQr+vjPjojnPPgxQCa/j702C6HBk74sQpOtAR1wCL2u8fAiDZ597srmBcNIeIdPzHvy/UxORsKPdBGCZbMRo6fa0hGSG35C807h1exze3ICiJzEoVBOon6aS5hrC5vBmzTng05jV5N8bG6yKxvu6rIJytfJf/oWjj1a9OcZfQdQRER9PCh+MWWse8JEoNZr2mT/yxTqQZvrm+Yjs40Fs2AfQEINZCwfzQdlPii0/xB7CPkEiSh/TiAwYiW0JX1UaVlBLQs40IyS8/MS2sK6K2DDfm2qA+4KiFwfBty7RFbm4L3rpxBZ/3W6p9LB/qs+W26erWQvILwNhvfnR8MzugcdRR2oDqnhIADp3H9Tt/6lFeT0aPXe+fYlxJloxGKTPw/zlGeML2xD3O/1VMgXB8rh3rTSWlLqDiYA1rJIesgcrak4JYh0GDat7y/LEpiVJnDbHcQGw/LXkPS47aMWDDBsKO1txcTKWcjLb9arpe06/Or4yU7WyHawZ82KqsmvM7mnf+e+4WQmRQcDOVC3j44vOLcfAURfQG0Sj0sqE8BzPTqzpNvla1+7wP4I1eMmSWFa/npSnM1eBP2c3gEKJAJVvSytxAqCrrstgIrTCyMbq2y59WD/cMaunTM4Jy/jf6BlMqnNmLKKK6agxOxv16z470f9ZhVjxzjm+U/LAreYtwkw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV5PR12MB9779.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(366016)(921020)(261026121527099003)(11063799006)(4143699003)(56012099006)(261021123027099003)(261009223027099003)(261022105027099003)(10067099003)(261021121427099003)(18002099003)(22082099003)(6133799003)(261026140227099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFJLaURObE9keUpMS0tKdFZsRGJSRzlCcEkzRVcrdDBJTUtBbGdYNlBrTW0x?=
 =?utf-8?B?NDlGMWRlZ3l5L2ptSHl4eHVlSWpqVHpnN2ZVMlRZaFcyNGJKSk5QMDdsOUZU?=
 =?utf-8?B?Yk1YeGxjaEdSSlFCTDRHaE5UbHVveTZKN0RYMjU3d1dYUE9DNEs4enBXQkRQ?=
 =?utf-8?B?Wkx2cU5Vd21kNExzUDNvQzRmZ3BPRTdHUWJkdU1pOVpsblpaZnoxMThYU3dN?=
 =?utf-8?B?ekdJb0pvaWtYMDJuNmdyRFA3NWtYZWlHQ0Eyb2FLS3NudWR2ZEl3R3F6MDdN?=
 =?utf-8?B?QTNkQXV3QUpJaFVrQVkwbFFKUW90MWpkZVUxelNPYStzbUJ3L3ExWnViRHBD?=
 =?utf-8?B?WWE1R0ZuLzQxeVhXL08yRXZ4dlA0Y3JLc0RrNjlJOU1hL3hIL1lMU3ZrVmlh?=
 =?utf-8?B?R3JXRjFOU284WXF1WU1hemF1djRvZmdqU2xKQ2dxLzE3amkvZjhsK1Zwd3Fq?=
 =?utf-8?B?MmFDbzVEeU0yYnNWQUtrZCtLTnJZUmEyU1REM1E4YkQrYWI2VUxpVXNndWVS?=
 =?utf-8?B?QnJLZ0FzOHQ0enRoSnFwbFdKQlErT3FQZXNISVJ5S2ZBY0RvR244azNQU051?=
 =?utf-8?B?cmU1YnpEWlVZbkIreFN4aG1rRUlqMkZqVklqeVN3NFJ4T2E5NEZMWUVQQm9n?=
 =?utf-8?B?U0NrQURxTVMvNTliY2gvQVJ1UnRxSmpXTUFyZDFiejhSVGluOHQzZGU0dEFV?=
 =?utf-8?B?UWtqOGpqWkNBYUhEVGlRREpaWlFYbzUvTVk1bW5QRjB0dENwOHJSTWUvbUhx?=
 =?utf-8?B?M25pSXRMVFlac0tIU0lSRitYUXFMaUJLOUpPY3NKQ2QyU2lLclFBUXFtUnZM?=
 =?utf-8?B?UUtjdXNaaWpXbHdFbDBYZVZoSXlwL1RVWjNYZm1GNjRWcEdjaVkrclRsUVdq?=
 =?utf-8?B?MWxUU0JGU1NPWHhveDVhTklDZmJBa2hnZ29VcU9TMUNhbHhZcTRBUUo0ZGt5?=
 =?utf-8?B?cVk2V2dVenpNTGNva0xqQXNmZ3drRnhIanN1UWhkM2hmRmJ1MUZhcGtZQ3Js?=
 =?utf-8?B?VEhRY1BaYy9hN05iQUlheEEzTVlGV2lyNzhiaEFocTU2V285NzBLbUFRa1NT?=
 =?utf-8?B?LzVRZ1RQWEZ4QmRRaWV4TmY5dXF4Nmx6amViUEZaVlAwdFJ0SllZSHlOVUZQ?=
 =?utf-8?B?QzBTNmprc0FKQ0tOWk00bWZ0b2p2SFhLZDZjRGhSWHV6b1FzUGt0ZVVqY0pj?=
 =?utf-8?B?SU56L2N5QXVoVExENFdOQWpyRlRZeU82Smw1WElSdC9GbUpjMzZEakNZQzlW?=
 =?utf-8?B?MjNDaitZUVFvaXloeWRHV3JKV1IzUzFSNm5qWExseHBUU0NpaS9EbkcrZnlK?=
 =?utf-8?B?L1U3dGVsbnNSSHNEcHJDRlVsUVZ4Y2hacmdqWFJ6WDhJeUhqT01BbWk2S0Zl?=
 =?utf-8?B?bnBVcWR2WjdNOHRtem9hUUVCTnM2M0NYMkFDb2laSHdLbm02Nlc1end3ZzJz?=
 =?utf-8?B?eHdpdGdJeVJheEVkNjM5V2hzM0N0VXRzUFA2ZTJxUkhENkVoTlJLSW9KQmJ5?=
 =?utf-8?B?ZHVIRnNmbjBmK1M1WU12bmNXalJDOGZxWFlDdk1Rd1R5c29zVmpMN1lVdmxo?=
 =?utf-8?B?YldDSmpEVVQ0NW9OM01DSkVseXNOUWI3TWI0bndmY3RPdm9DMTJ2M2lDT28y?=
 =?utf-8?B?OGRLZmRzc3k3dDZZZVJVRzY4ZmN5N2h6YzduL1Z5KzN3c2h4bFBsWHJnbEww?=
 =?utf-8?B?UnRiUHlRTytqcTg3c2ZKL3ZpUngzTS84WHBZa2VhSWplUERTbmQ4a0J5cmNp?=
 =?utf-8?B?ZU00Zmc4VFlhNWV2U1k5d2V4VDVyOGxpaTM4U0xCZDVaSTRidVUvemxoOFNT?=
 =?utf-8?B?dmZ3R29GZ29veiszYW5WV3dEN1VkaVlMR3lCVUQvU3RGQ0lyZW1NdVJFU3hm?=
 =?utf-8?B?YlZpeEVweWFheGZaNFlRRGF4d3E1am42Z09SMXFUZ3drbEh0M2tsajhKY1Q5?=
 =?utf-8?B?bmpOS1BlM2pZNDltMTNKVGhHbHFxUCt0QUpMNTRCSmJ5ZUVKb2VYSGlGWUxN?=
 =?utf-8?B?S3B1RElDNzdsa3pUejMxa1JieHZhK0srTXozR2dsdUJhSytiRHFBN08xVjlW?=
 =?utf-8?B?UHArdzNkZjdIaUVqT2tZOHE4U1A1K3pZTmdhd0JCbDJYZS9qWWoyNDdQM09G?=
 =?utf-8?B?N0VGQWVPa09LN2NPQ2pwQVBOS0xDVUV4d0hvSzZGT0RWb0VxbDgvWEFCbGNV?=
 =?utf-8?B?dTYxNVE3RG5mYTRxZXl5VWZzbCsydWQ5NnUwL0ZidUFjUzZIc0RhVHdiYVRC?=
 =?utf-8?B?bG5zNWZsOHhkTFM4a2VpcnE5RzZsZnBiSE50b2s0eWNmcEpJd2g0YSs1R1po?=
 =?utf-8?B?NkJZNWs2QkpOaXg1K2ROL0lSOGhHeHU1dm5FRGJpbklSLzZDeVZ0dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09d77921-3e9f-4e1e-6156-08df34423699
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 15:51:49.9540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQA+Kwhf3qPfUuwcCqaLNMSF3cWNLTbtbYHw+bCcBcNcz1mShnJysM+JSH/pCSc3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8866



On 10/27/26 16:36, Han Gao via B4 Relay wrote:
> From: Han Gao <gaohan@iscas.ac.cn>
> 
> Mailbox and shared-memory SCMI transports do not require ARM execution.
> Allow RISC-V platforms to use the existing SCMI core and protocol drivers;
> architecture-specific transports retain their own dependencies.
> 
> Signed-off-by: Han Gao <gaohan@iscas.ac.cn>
> ---
>   drivers/firmware/arm_scmi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index 783c24a20e29..1cfe2b572d18 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -3,7 +3,7 @@ menu "ARM System Control and Management Interface Protocol"
>   
>   config ARM_SCMI_PROTOCOL
>   	tristate "ARM System Control and Management Interface (SCMI) Message Protocol"
> -	depends on ARM || ARM64 || COMPILE_TEST
> +	depends on ARM || ARM64 || RISCV || COMPILE_TEST


I would prefer to remove ARM || ARM64 dependencies completely that you don't 
need to add RISCV there.

Thanks,
Michal
