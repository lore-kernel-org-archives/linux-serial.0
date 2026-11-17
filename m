Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.19
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794955206;
	b=LuSsVvLjk/ZNmxFsdMSqcWUoz9/7wdTR/bl5udRV8nn5j7v37Cbtw1qMnLCCWKQji5ko
	 uY3AfYNMDHkCFRyVDLMRUTotjHyWNJs2h3lkx+wKbrXblfKZcvlyRsVH1IuVKnIK34IhZ
	 XiilnYfKkhZwaWxoKr3Mf5Kdr0hj8jI32ckRv8xRUmWMlWGVlCqAM2tRT6AYTaxDrmcOg
	 Z60d1x5bjeUkwtuyzIdArs/9Wh4aZ4Cy/il5YFjOKqqa/+CPZhWt8P0LMOn6Jo3uNTfij
	 HFr5gzEqhaUJRNKiHvhEUkuz/5plVuHVqTUlcq4Oc+STEr7fUCvWTIEnfLYCmNy/nHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794955206;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
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
	bh=K5vIf11aScj1GgvoegJFN0gETWm0ooFfqlmTHOSWSZw=;
	b=0iZnneJrGmenvzv2Y+wle3BZFDf1ddyUYXDHvblmkOJIdYzrkPXbSOsE/8KLv87oAphE
	 CZrdWwNTiQVqzGQnaQMnbLmWnHYrCe8TuDswZvAoosodA1Ay2tshJBNKDsUPswy3kpqne
	 qvaPUS7I726b6KVYQR8cV7ZUNUkhztJi+Vufhht/s8AM1+yQZMB5VmKifIFkjSSIRlgBK
	 /+d/CAmNFju2AYFrhzrgYKnamjHFu//exD2+RopTolLwcWNb1bMmabiw8cu4ErTtdvn1H
	 sntr8Aa5UBj6PzM0SckP0scJIdozp6wgbOgSjW/0zL6uUesyEMDgYX+YT+NXSLhL1sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=renesas.com;
	spf=pass smtp.mailfrom=renesas.com;
	dkim=pass header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b="V/a9ToTd";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.74.19
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011019.outbound.protection.outlook.com [40.107.74.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4590606A31C
	for <linux-serial@vger.kernel.org>; Tue, 17 Nov 2026 22:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4590606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=renesas.com header.i=@renesas.com header.a=rsa-sha256 header.s=selector1 header.b=V/a9ToTd
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA6aS9yqsdElflc2NTCbPewmCxx4TKK2Q86sK0/1mPxj5Iw+SULGvVOAcwvj725PQ/W2dQ1Q1t9fTK943lDDmUjrH5iECm9BdMcujlkoqSvQN5IVSn71QElQcfKOWXUCnRu6VY2KK4HZBo06pufyp+4/Mxq88LL5Nk4aO1t9GfNR4eU6VUC/euXpznl3ceOCtRgLrN9ZMGqq/OueOFfn3edEyw/rDXxazOr4hQiTtGVkg7SNPebn90s1B3JbC0B+bqqbetP9hsQBE2kYQo6BB2wb1EbczYu9WQ0lIkCfUu0ku1PBBmVgK6Zg0z/1qYAeT56tUR6tkWA1u8HkAHAw0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5vIf11aScj1GgvoegJFN0gETWm0ooFfqlmTHOSWSZw=;
 b=KKgmIY1nw7ySUIyIwJGom0KEYB7u3MZ/E1mMmS+MsnAEpCaJGwJ/8gDldWSViHqPfufyYF08cXHV9ghiqX0l0GGrrTCt1O00BMws7OucY6IcAQqIpESc0i3xiPoiK6IJsKncUf7XwK+mCl1DHT5KLpzJLt0onhjZEfdtYCDgQwkAUnMqx3wYBj7f/BTcfcZiZmE9MddrcYeODWzyFvRMoRIWYGJy7DCF5okugQcMHTy0/NjJqbcNcsBhFPBNVX7/6dhMe7vd3bvuLaSzYdBgnxPFNoSbnzuiC/zzNAQ5rx7hbCwAu31oHgNX7ZfUChuHxZkZwX+r1Ze2/4ZwglRuGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5vIf11aScj1GgvoegJFN0gETWm0ooFfqlmTHOSWSZw=;
 b=V/a9ToTdDPJipxvZBvooWoe8ITQkNDy0pJgX8Lz/bdT5dkXFWlm7FT+DveXsIoAXrlY0EYeDPo07qVLXpq/ofYoAlFQUGe1Ags1N9GmvbjparbVpbG0WlzTjzAq42BtTZ/EL/4dQGcyD432D4fGa5ywVEvtmEevafhtouXOiU1c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11) by TY4PR01MB13444.jpnprd01.prod.outlook.com
 (2603:1096:405:1e0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 22:40:01 +0000
Received: from TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4]) by TYYPR01MB15118.jpnprd01.prod.outlook.com
 ([fe80::1116:d56:8164:63b4%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 22:40:01 +0000
Message-ID: <a7ecaa97-b2e3-4f99-adb6-a329df00da84@renesas.com>
Date: Tue, 17 Nov 2026 22:39:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] serial: rsci: Enable transmit end interrupt in
 rsci_stop_tx()
To: sashiko-reviews@lists.linux.dev
Cc: linux-serial@vger.kernel.org, wsa+renesas@sang-engineering.com
References: <20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com>
 <20261113-g2ul_sci-v4-3-6815e41d90c5@renesas.com>
 <sashiko-outbox-213556@kernel.org>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo.sx@renesas.com>
In-Reply-To: <sashiko-outbox-213556@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To TYYPR01MB15118.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::11)
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
X-MS-TrafficTypeDiagnostic: TYYPR01MB15118:EE_|TY4PR01MB13444:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d237616-a29e-4abd-7a21-08df44fbb6e4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|261009223027099003|11063799006|260925021311599003|56012099006|260925022911599003|260925021911599003|4143699003|261028144727099003|10067099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	d1rw12EdTU+X/Vyhmym8lHBtP2MCDcG3cHe/DdMG9q6i7sXtNBs6Y9257SjeTtHC0uWZ3IfXQRA8PVTn/z8gSgv6yymwTUAAJJrWZ1riGaE9D21laRFKY0vB9uJVkZFL6vxlvnRULnrgOfgMXC+SIpwmUv8bPxqWw8YqxJWAZ/JVS0qVCDOgEQ2z5n9PooolcMUdUVk/T2o9D1Z8+nfYMzo2AbFnR5M/KB2c+4oWfOWSJUzH0YvNMKmNf4FQpnlryizOS2COQ6AYVF44B9SgeMl+Ba3BfN1P25/D5GtWKVmHpT8uAXAiuixnWWh5DDFNP0XYf1aFHYGHDr5WsHvpHYqFv4zA9Dh12nBVSBNFauEeePvHEHP8N5seDHZQ8YN6l3J/A4JKNuzJev2vwptA+SOARAM0tUAaIGLZRK8P3ambwCCq7vTiGH2EuEtOAVEH6axUG9EkOZUHyNsgYls3KnAtMXHkSSe/7cWy7msjRmwhTuooSZtHn9pg67dXpcP+DU0e1NCOmNuPAYPljouLiuFtKvg9J6abUJ4WSDqQm2dU6vjcxsmMoGXYAw6qonJnz7jc1mSf7j3RXCtcbh0vdzCM3aDondC0MkhLHASxa3M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15118.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(261009223027099003)(11063799006)(260925021311599003)(56012099006)(260925022911599003)(260925021911599003)(4143699003)(261028144727099003)(10067099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1YreU9XQzJlUnlXR2hjWXhQYjNqUk9pN3ppM1BjNWlHKzJTK2RiZmg0QmRm?=
 =?utf-8?B?aUtzNGxyNHQ5eVNydzJvV0ZDL1Urb3MybWI4b1hmdWVKMTdBaURxRG1qODFX?=
 =?utf-8?B?ZHlsQk4zS3lwalorZnZOUVFBOW82ZUFJaHVjRmh5OGR1MytXb3pLcm1ab2dN?=
 =?utf-8?B?RVR1OGYrYTIvR3RBTjBSZ0FUcE5LWnlNSXRzazRrOEV4MlhtY2pPbFh3UThs?=
 =?utf-8?B?Wjc3TTFWSHZJNFVuSXpBclJQVkdtOWhGUDAvUFZJdlFQSnRJY2xUOVprTjVI?=
 =?utf-8?B?a0JwczkvY01ZTWUwWDF2cS9ESUtnRWZHY29RSlFrSWdlSEIyNGJQQk1McHk4?=
 =?utf-8?B?WXFoL2orbWZCUXhZZTRmSnJ4YjJrdzRIUDh6bVRuTWo2SnZRakwyT05yNCtE?=
 =?utf-8?B?VHVENm1OVGNKaTI5RVJUVGdaV2d6WFBhOGQ2KzdsdmpUT2tsVDY2SXg2TWY3?=
 =?utf-8?B?bVVjTWJUUnM4OWgxcS8vN2g2YmlmMHJ3YmlQL3RsUGRTTmt2RHFjWER2b2JB?=
 =?utf-8?B?aXBKMUg5TnNwVURXcnprenMzb3BockZSZmFkQ01CS1hVWmNucHo2U0hmWkt2?=
 =?utf-8?B?U0RaaUhVd3Fkd1V5V3VCTUQ5d2dueGZ3REh6aEJPSVVwbCtMUm10dHRyOUJH?=
 =?utf-8?B?WWtHZ3M2TFhXNzV0RnZVYnRjMkQrWVVkd1VrSXEzZkxWZWJXOTZQRWtlN2VF?=
 =?utf-8?B?TUVuYlVSY3RURjRycXNpeUZwRjZoSFlFMGRkVGY2UnRQRU5QTFkxZkFyOWh2?=
 =?utf-8?B?SllBTVlscDMwSVI2NXp5aDZCUGwvb0dLSkhCaXczMVozcVdqcEUxWEJlSmtV?=
 =?utf-8?B?MVFHSzE4VzNaZFcrZzBZa0lka2FvcTNhRGlyQkE2TnRxYS9idW4xSW9qYzdH?=
 =?utf-8?B?YzVlajBwYm1XOEQyL29lRWZGTzRPYk00blEzdVBxdHFOSjcwRmc1SklFSE9G?=
 =?utf-8?B?a2NaZis4VTB0dzQxUlZTSDRFMm15Q3p3SEMxaFNhaXduUTF3OUwwRlVvQnhV?=
 =?utf-8?B?b0w1bkdDa2tYeDdCbUU3Z3NzZXFUb0YyWWFrVlpIMlF4TC9nalBwa1Y0cTFz?=
 =?utf-8?B?T0Mvb0RZTFBXWTEySmcyaWpVeFhlV1VqdUZsVWhwMDhMaUQ5V3AwRm5XTG1q?=
 =?utf-8?B?THdzWFBqYkxWdTJkcVlJVFdiNGJLYzdWQnpBVFJnSWJmajdZdk1iMXdsUTdw?=
 =?utf-8?B?Y0RsVFZIU0F3bXlpWkIyWFZLMlJ5cG44MWQ1azZUNWRsdm9SZTJGOFdFWklo?=
 =?utf-8?B?djdqT0h6UHV2T0M0L2g5Zm1JdysyUkYvS0hRRENoc2s2V0ZaamVOZG1xYWVC?=
 =?utf-8?B?MndEVkpnWjJ2cmZxa0dyMTVKL05OT3diS2RoVkJvWVFhWWJiY01kYm1rVWZ2?=
 =?utf-8?B?KzQ5Z1V3RDRQQ2RYTjRna1ptNCtnZlhhdkk1SGcxeVNNcmdqakxRL1FwSlNy?=
 =?utf-8?B?LzVlVFdSWmtoaHNyUWVmL01nNUFWbEpCY0tyakFxbktES0llRFFOYVlrYmpV?=
 =?utf-8?B?cmxXOVZjNzJBWjlDN05LYU0vQ2xMcEJYNzNwRm5lb3F4RTh2dmZJTmpZZjM3?=
 =?utf-8?B?azFNQXV2dDBGK2xmQjVUaS9FWWNvclh0R2ZSS2RsMFVDRmJ0ZXpTak9HNldh?=
 =?utf-8?B?Nnl3Mlpjbkd6dGFwUkR4T2sxdWlua25NM3U2aWREcU83V0F2K1RybFR2UlFn?=
 =?utf-8?B?a1pmZDREdEViMWQxb1k3UjVsTlhTcFc5VlA5WXV3dzVVT2RpY2t0ZWM2TGFr?=
 =?utf-8?B?c3dFUEswMjJLcUxtQzVvRUJLWllsSk01ekdlaDNqQmhrVFVISHV2MEE3YWsy?=
 =?utf-8?B?alRqUGp5S0RuTEJUQlVrWEdrc2xTZkpGRW9abjBTa05kcmF5cktrNXZucXp0?=
 =?utf-8?B?eXYwNDhQSm1SY3E3clFnZkdtKzJFMUR6eWdDd29YSTVTNVNySU4wWmcxMWdO?=
 =?utf-8?B?Y0psSWtKOFMvVGdSSldvMmhEMHRpVnVNazA3U2xMbi8yaXhqRlFUcTVjM1dp?=
 =?utf-8?B?R2kyZlhMZGJrTnM1Y2FCbkZybkM4VStBUW9CczZpRlhwYVNRSjlyQ25zeFF4?=
 =?utf-8?B?ekczMGlqc0ZGZ2RiNnhXaVIyL2hCSDAzM2t4ZEhsd2U4dm1zZ1NtVWlOM3dz?=
 =?utf-8?B?YkVGUGFaNlZCLzY2UDE4M0JSQ3lwMUtaazRmQXI0M0w4b3MzREViU3JTVkdi?=
 =?utf-8?B?eDZudnB5Zkhabi82NlVvS0orSGs1ZmU5UTZJMVJsWXcxdU5vaDQ4RUFIOGlz?=
 =?utf-8?B?N1MyalBoVDdtZ0JoZU9FaVFzS0Y1K3NBd3l1aThGSVgrdmEzcDRLdTAvbVl2?=
 =?utf-8?B?dnRWZDRZaFpMYXdGdFUzTDY5MWRNSTM4NE5zc1NGb1A4ZXNKTjNIeWhpZjZ3?=
 =?utf-8?Q?a127HJG/sm0V+jUE=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d237616-a29e-4abd-7a21-08df44fbb6e4
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15118.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 22:40:00.9801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmtdtrOnEmWpyxlbmL/cL6lh8NpSjlOy/u09iVp3wSSKhtw8/b3Z2vDzRTnaI0httJ9en5P9FLmOufU4Cher+IK7mdaPUGUiVpitJbSrV70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13444

On 11/13/2026 7:35 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Medium] serial: rsci: TX restart on suspend in sci_tx_end_interrupt()
> --
> 
> commit 071c63519ac773139fb715b1e8e4f93c225b5ba8
> Author: Diogo Ivo <diogo.ivo.sx@renesas.com>
> 
> serial: rsci: Enable transmit end interrupt in rsci_stop_tx()
> 
> This commit enables the transmit end interrupt (CCR0_TEIE) in
> rsci_stop_tx() when transmission is active (CCR0_TE is set) so that
> sci_tx_end_interrupt() clears CCR0_TE once in-flight data finishes
> shifting out.
> 
>> diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
>> index 0391111db8ae8..05703bb31afde 100644
>> --- a/drivers/tty/serial/rsci.c
>> +++ b/drivers/tty/serial/rsci.c
>> @@ -409,6 +409,8 @@ static void rsci_stop_tx(struct uart_port *port)
>>
>>        ctrl = rsci_serial_in(port, CCR0);
>>        ctrl &= ~CCR0_TIE;
>> +     if (ctrl & CCR0_TE)
>> +             ctrl |= CCR0_TEIE;
>>        rsci_serial_out(port, CCR0, ctrl);
>>   }
> 
> [Severity: Medium]
> Can enabling CCR0_TEIE here cause sci_tx_end_interrupt() to restart
> transmission during system suspend?
> 
> uart_suspend_port() sets uport->suspended = 1 and calls ops->stop_tx()
> and ops->set_mctrl(uport, 0) without setting tty->flow.stopped or
> uport->hw_stopped, then drops uport->lock to wait up to 30ms for the
> hardware transmitter to empty.  When the in-flight bytes finish shifting
> out, the resulting TEI interrupt sees !uart_tx_stopped(port) as true and
> resumes transmission if tport->xmit_fifo still has queued data:
> 
> drivers/tty/serial/sh-sci.c:sci_tx_end_interrupt() {
>      ...
>          if (port->x_char || (!kfifo_is_empty(&tport->xmit_fifo) &&
>                               !uart_tx_stopped(port))) {
>                  ctrl &= ~(s->params->param_bits->teie);
>                  ctrl |= s->params->param_bits->tie;
>                  s->ops->write_reg(port, regs->control, ctrl);
>                  s->ops->transmit_chars(port);
>      ...
> }
> 
> This keeps transmitting after stop_tx() and modem control deassertion,
> and if xmit_fifo does not empty within 30ms, uart_suspend_port() times
> out with "Unable to drain transmitter" and calls ops->shutdown()
> mid-transmission.

Yes, this is a correct finding. I have tested the current form of the 
patch series with:

[root@alarm ~]# stty -F /dev/ttySC0 4800 raw -echo
[root@alarm ~]# yes "0123456789abcdef" > /dev/ttySC0 &
[1] 288
[root@alarm ~]# echo freeze > /sys/power/state

and I get

  - [   73.035060] sh-sci 100f2000.serial: ttySC0: Unable to drain
transmitter

Adding a !port_suspended guard to the conditions in patch 2 to restart 
TX solves this, so I will add it there for v5 and keep this patch unchanged.

> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20261113-g2ul_sci-v4-0-6815e41d90c5@renesas.com?part=3

