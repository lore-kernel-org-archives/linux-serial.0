Received: from IND01-MAX-obe.outbound.protection.outlook.com (mail-maxind01olkn2060.outbound.protection.outlook.com [40.92.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B99E7489;
	Fri, 11 Oct 2024 00:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.102.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728607767; cv=fail; b=BGeIoAdTHhBZHl5NccV8BLvlzTOtboR+RMsO8FCIxH0B9Wn1XdTKx3zDWU740cWE900gla7lpQntb4Ts1r8whAwvPBt11UdLw3NDh/hhhCxDlgkOXQYmpLRdrut1jqqXwvf12kXKrzL/kPhWjrMSO77qoFC2SsZnhM6DzyyCoIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728607767; c=relaxed/simple;
	bh=XK8la+MOzFMPP9Sy/I+Zq1gk20be05Mi7iEUjezS3P4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jx0yUFyim0u/DxxTAe58ezOiAFFNRb6GPQnkxtTsYJ5pD/V754ZVJttIVplIe45ONSbhuQrIDgOMdS2ZneyNATJCMw6SvAFoSL4QNL9cLeYrwQBo1ymmRBeEGh5Gqf53sM7Qb/pebwEwHCyu5DCB678elQyFrb8BvsKLmQFPYaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kQ6bY4Xg; arc=fail smtp.client-ip=40.92.102.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kQ6bY4Xg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxZEqR/SN350ETW9aX6DrDVRzJF3XYqAUo/jnT+HRUtdUIcYHssu96QTF0COGMQO/MG0Mjni9Lz7Xsr4FynRUdESPfTBqTj7aweOdzffpBEnsA7zQq46F6QKrDsITiYiknYtfNBOabcxJO3SerIy9CgQEMBaxS1POCcE6nzi5gvpfusXhZW1KXyk98zHn31Xy5heVtqxPuKPSk3jlfjIKDGkErRKd+FzWFK2ahT7MCbSJ9arFoHxLEjwXKC1arU6t6267ioxGMFASm65QacaoIF1Es2Fk5Dh8FmUsEE/WmtWLhLJRJs66LsTCoOuAOF4HA5zil4aIjvlz6XTMqYcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/8tBvyEOxaLnq1iP/J9gYGRuQqkfq1J5CcvUnfd/+4=;
 b=maaIj65pDDKzeosqc2iCa7v3Na4BPl3Pds+UOueHpL/OOUivhK75TA8/RLjKhZJxmH/G9mBd+aGs3W7fZXPpZa9uHDWfMR9nnG/rSBLAyNmTbie+DMkseqS8WDrdto1ATZTstY01wB84vIeox3O6Qz11UkN6Anolon7Fn/MOQzqIBxOK9wSpqd0dR4rUQSxNCEo6g4T5LMV5mamTRke38FoSuKTbtGYo39RwMuyDLDfbkz5z9hJieCQUkOT+PCjPih8s+eVbHNcHGc1CxvGIhuAIE6FArfncxtFi4U3VSUnE61CMBgtEx7sUadRZxN5Yjjhc2dLAjX25Pvvbta6CFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/8tBvyEOxaLnq1iP/J9gYGRuQqkfq1J5CcvUnfd/+4=;
 b=kQ6bY4Xg5p1fQIM2KaunadmhDJjowO11P1Buen1kl8+7oqT8Ja6NwL59gR8Us1tTHcQESxK4mmm3BSQV9KIU6zqFvEJzv091jrwqT0T9/wNtJtIyX9Qzame7dH1+GyFyFCCgzb/nvV18LIqD7AjiX1rmKl8D43d8nLHnpnGuVqbCSwY2CN2AffvG12FP4MMRNwNq73eZPzDR0lJnSwm+3eepXrLIdgS3wjGDMgKwA6b2rTvEjwxYHlkG155x0+s9CkfwlzxcA5crMBJvM4wMm/fOwFZpBp55eA58AHGJfQsfAzueKxQXEhB+i6MJ1slX5r4KVQXqhXRWRByUVx7S/g==
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:138::5)
 by PN2P287MB0723.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Fri, 11 Oct
 2024 00:49:19 +0000
Received: from MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c]) by MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 ([fe80::a94:ad0a:9071:806c%3]) with mapi id 15.20.8048.017; Fri, 11 Oct 2024
 00:49:19 +0000
Message-ID:
 <MA0P287MB2822F555493DBD084DBFCD54FE792@MA0P287MB2822.INDP287.PROD.OUTLOOK.COM>
Date: Fri, 11 Oct 2024 08:49:16 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] serial: 8250_dw: Introduce SG2044 uart support.
To: Inochi Amaoto <inochiama@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Inochi Amaoto <inochiama@outlook.com>
Cc: Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, devicetree@vger.kernel.org
References: <20241009233908.153188-1-inochiama@gmail.com>
From: Chen Wang <unicorn_wang@outlook.com>
In-Reply-To: <20241009233908.153188-1-inochiama@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:138::5)
X-Microsoft-Original-Message-ID:
 <0b53a856-af7b-445f-98cf-2fd4eb206cc0@outlook.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MA0P287MB2822:EE_|PN2P287MB0723:EE_
X-MS-Office365-Filtering-Correlation-Id: e98001f3-13ce-409a-111b-08dce98e8a36
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|6090799003|19110799003|8060799006|461199028|15080799006|7092599003|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	5/sDxgtWwYUx2PVIr4dLPN1K4nZ6gCaI5Ek2GEZ0HTnrmxqOPyM4fziCOmtKXERHYKPaamQcZJjwCiDoG/tD3Q2vFiEc+agk8bTUvytN/G5RsS1BbxrqwJeyh7+DLqWxI3fh3QoEI6KgQIrlTxJPbRNAk2QGp9X4nqfEpu40+wddv5kqRLqney8MVS2d67Op1Z4Ni4jqj9O5mClFQM7anJU/veWNQ18BwTtJBk5z3DSJnZKF9WAl7sVRnhSDZsHYYGFzrTU4UfXBg8OtjIgzMt+KmCiKiWb8r9VuP3WpFkiNGU8xae8xQHW4Vzlb3NQOTsOOJQjH4RqBebjr9QTeZwQPkj6Gzm9yvGG2xEdUWeqRw2+zZ7Bq172FlMvYydwoGz/+AWkrvEU96ehi3VX980elg9SsFiBYEHO5jiM5AeflaJF5xg3jR0sgkg0auetqERedthTPxOyhp6Rpx2kf/SRdAQoNd5jqZ3xef8i8w0pFi5Mixbee9Ylb0Om4NaYWnhqwHnG1h45t2VUTK9ZwPWTJcbMVurAurXS/RP/0KVHZxLLOoPoFfgHG0mMzjN9Fuga524pUSh5V9HBROKF/HTzEvb9yC4UC2HRTBCVJnoHQIZBK3bOO3LbgryZEyH8bhI5k4R1q7/q5MXaeVlvvHbW4/v51O796ARpgJy9wVr9N8q8xsrwolEr7nCiNDyyu+95p0bzyR4d2hN65da1Dfo/Kc6XeHFyR7UuDzae7iMyjv1sI9vBxoYGYVQuRZ3/F
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RrQUVMck1LM3RIb2kwZkJ0MEs4amJuS2VjZHlvdStJK2w3MjF4a2JUaGdv?=
 =?utf-8?B?dHoybHdkcHNHbGp6Nk44SS9va1VDWWNpMkl3S29qSTlaUXc2QlprTk1xRnFa?=
 =?utf-8?B?OFFXQjhndUxMK1JLOVo2WG12MlRaY2VtOHFnRHhyc3dTWXZ6Rm1KMFIxVVZG?=
 =?utf-8?B?OFNRMzVDbVhkeUM4cG5sQ1JYZHJHRXQvTVdNTTYyMDVIMnl3WmF1blZzenhQ?=
 =?utf-8?B?dUdUWG5TdFdmQk9hbXhNNUlEei95cDAxemlCOWwvbW9TSlRkNSsyNitxOXhF?=
 =?utf-8?B?RGR1U3hCNVNWNmhiOHQ3M25WL2gwSVBiMCtUWURheEJNYjZpMjBHcXhrMHhj?=
 =?utf-8?B?SXlyWC9tRVRubjZDbzFsNG1rSW5iUVVmOUI5L1AvMlBGKzJSVlhsMFJCbzV5?=
 =?utf-8?B?M3BNZW9ZNkVUZzlQdTd4SUJnNUtESi9UekQzMlRzandJT2NFVXN5Z0NUZURJ?=
 =?utf-8?B?ZjAwUGhQdEhub2N2eVdoZEtaYWxKRjJhb1A1b0Y4VS9IbU0xOUNVQWpGcThr?=
 =?utf-8?B?cnRZZmJ3cjZ1SGhoR1owYmNxWHI1WTlBVUxYQThKNmNHekZxV0I4eGJsVWRT?=
 =?utf-8?B?U0VadFY3NDA4by9nQkpyKzhFa01mMWxvMFlEU3lHMFg2VkNGOERGNVRQN08w?=
 =?utf-8?B?dGdRYXZxZHIzdlRHdml1ejlKZ1gxOFpPVlFVVjE1TG5XREZKMDhDaDVKODdj?=
 =?utf-8?B?VTErVytnR0N5bS9HODZQYjg3TjhHeWo4VVhYdkRkZXJUbGs0a1F5a1c3K2Rq?=
 =?utf-8?B?MjZ0SGtpTDRtMjJZMHZzR2F5RmJvWkhGQlR1M3dqaFFtN2laY0ZzUGh5SjFG?=
 =?utf-8?B?ZmIvbVNBam55YWE4RUxvUkRPeE53NHZmZVZscWlyWkxnaHlJclMyVWRrZHZN?=
 =?utf-8?B?V2RNRUUzMVkrY2RmRmJ4TVNnU1dkdWlGWTJkU1FzVEh2VU9ScCtua2kyQWxq?=
 =?utf-8?B?VHVYdDJGNzFld2VVTS9McENwaWUyQitvdVFiQ3hFaXVxZDQ0WHhzT0J1TTFn?=
 =?utf-8?B?ek9wZVlCV1hEenJtN1Y4UzRnQVNOajdIYW9yejJJYkJNalhxdFVQeE5SN3lN?=
 =?utf-8?B?VmFFVitGZ09pOXJFRGhyeVd0RDVCb0lZWHZzOExYalZrMjg5NHd2NkpNZDhn?=
 =?utf-8?B?MnlQRHdjb0RBNDBVZGN3dHdlQmRFdkNIMlFFalVzbzZyWUZKK3g1QTRDcjQ2?=
 =?utf-8?B?UlZzZHpoVTJQaGNYUUpFUGNnNzRPOVptMEZqQmtYK2RORFltR3ZwQ2lEMXRN?=
 =?utf-8?B?T052OVpPUU0xcGFGOW1QYzVOYnpCUkt0QUZRVjV6VzdiUEgwdkNDQzZTNFJi?=
 =?utf-8?B?bCtMTnQxRzhVM0FCME9YdGdJY2xWR3JNaGNRK2dHbENxYWUxSXRHTUlJUG9o?=
 =?utf-8?B?Szkways2K1haT3RDQS9WOWdIa2JUdlNPMmpuSzlnRSsvM2ZhMXVVVCtlcjZW?=
 =?utf-8?B?ZmxXMnA4QmhsaWdjRXJORkZiM1p6ck4xMFRaTWNzU3d2bkVxR0pMdS91REFa?=
 =?utf-8?B?d2JuOFprbnNOellKZlhGMXRSMUQvVkVBbktkRVhGTGIvb3AxcXczcndCaHZB?=
 =?utf-8?B?aXIwMEhPRE5iK0hnVGZoRHE2UDEzSnh0amhoeUl3ZGtVWDAvNlA5MVFGbnRF?=
 =?utf-8?B?cU1JdE0zQXVzS3pvN3ZsUzMxS0RoODR0QjB0VDVqZVRKSGRuYndPYVk3TGR5?=
 =?utf-8?Q?Rwkz7Wjoyj9UBF57AnRz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e98001f3-13ce-409a-111b-08dce98e8a36
X-MS-Exchange-CrossTenant-AuthSource: MA0P287MB2822.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2024 00:49:19.4930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN2P287MB0723

Hi, Inochi,

Can you please post this patchset to linux-riscv next time too?

Thanks,

Chen

On 2024/10/10 7:39, Inochi Amaoto wrote:
> SG2044 relys on an internal divisor when calculating bitrate, which
> means a wrong clock for the most common bitrates. So a quirk is needed
> for this uart device to skip the set rate call and only relys on the
> internal UART divisor.
>
> Inochi Amaoto (2):
>    dt-bindings: serial: snps-dw-apb-uart: Add Sophgo SG2044 uarts
>    serial: 8250_dw: Add Sophgo SG2044 quirk
>
>   .../devicetree/bindings/serial/snps-dw-apb-uart.yaml        | 4 ++++
>   drivers/tty/serial/8250/8250_dw.c                           | 6 ++++++
>   2 files changed, 10 insertions(+)
>
> --
> 2.47.0
>
