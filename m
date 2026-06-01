Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023109.outbound.protection.outlook.com [40.107.159.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E9233D6FC;
	Mon,  1 Jun 2026 05:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780291865; cv=fail; b=ToJkvTCqD03uNvaiPp9kmaOV+ROEUC8nah3EC0HfazWTV1Ofkh+iEbhsV4jBcbj+bYRJJLn7q82QpS1vASlKKkc125O7ncIjK40HQ9xRpH6WGyt5NB2oOK9if8qrV431bFKKW5HmmopsJoM6aA5nE2O+QmnSe/dwBDtDLnO8NAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780291865; c=relaxed/simple;
	bh=tBxL/nsF3D0ekdNPr48/2G2tMAZ079l3EvEULj9yXGA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PB/rzzSffO3IqQfXEI0xq1Sf1DrIytsy8mVH+D6T1K2+86qn9e/SKuBnHSq51FYmNphQhHHBz9H/uBitp32X9AkupUqiwWNrIx33NKkm5Q/xcdX7gepEVJmHmUZU185syassHPGqfeCOCXRXp1SKCAmHR13J6fKndqAw6JdOvyk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=FwqPRYQs; arc=fail smtp.client-ip=40.107.159.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="FwqPRYQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFW6ggp5Im2fevAGi/w+tUBPXFrWST5Ye45j0RLr9+OPIao0yMc1/C882M5XcUZDIq6kGpBTkxHqwBeKvJVa/UN173KWlUmphUOFebDwZxr7zlnL0hnNT9GZzGWgwTWO0BftckOaLo9ghfYg8E3vPfduXXBfxgi3BwCZr2DC6LPprpaX8HZcmhuq41VOMrYE7W7ujj7/FWrE9eKaLVa2tXYyHcaKpkaNZhN092j836ZnxhoJPKsmCgyFxCgG6HEEoohRTUfT/X2r5Dmw6XdGslPahF+2Wvft2IJJ07ZGSrZfnMD35Oqdcy7oVnHGKUJXqDHAqV8ZnzNfVangBK/Kkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJXPfHo0QXaefRosSrPser6fiYh9CmSsAi1hfAghps0=;
 b=AqoZg3vQCsK9MKJqpFJn65K1l5tbRq8SVub8RmiC3XskN+2t14Db+/NV3CUvpX/szRgqrPaDnytP9Bdl1SlJszVxycyeWcNmZRDu50b8rICTw/7JBziXOhAeH30F5adE27ae4WPBk6/oHhLcZ1HD8jlXFp/bU4xFsc6U59cSk5XbSiRTC+Erkx/NBrnDBUswa4kK21/sTB/Hl2gjZKWsULrFqN44/GT3W8VgTx408iqT+z5aOAW7npNpWt16GHAezE05QC6AkC9G9GpjQu0FpGq9qpCePgfziXw8T8yKqGrRiN/Qe9hXJAJysj8WJ9tEOvTyCcpgU3RRemoQCXaUZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJXPfHo0QXaefRosSrPser6fiYh9CmSsAi1hfAghps0=;
 b=FwqPRYQsILvqdRC+a7T3e1a/lSG1W6Hsjf1TAty9ZYMulzhsrkgRzSKto57YxrW3QwJXQZpGUUst3KStgRti+TtV6YQ8queiwEfZ7ZNU8ChIzEqj6niDO7iu/Lc6oi3VyEPPyV6th9iH7lK4kvCL5if/EugQZHd1hO1JAk1jo8ycBp7oF5kTRAvc73jI69P05k3lYSU8FLYjBPw/7ZXBwPn2Q0Arm5PxTwX1I5SQiwdMuZ5yU/YWhwiPCYvfRTqPwwqExYWUTBhhOAUCdcrXG5tyvaC1VdrbJUH+zhrTeCOS/xIZ1RcZFnALkFeApCXAu8PyWifJ6mQwxOD+wRKh2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com (2603:10a6:20b:676::22)
 by PAXPR06MB7518.eurprd06.prod.outlook.com (2603:10a6:102:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 05:30:54 +0000
Received: from AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69]) by AS5PR06MB9040.eurprd06.prod.outlook.com
 ([fe80::923e:d30b:98c0:c69%7]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 05:30:54 +0000
Message-ID: <a03a93a7-9d56-417d-b6c6-2640f913f948@vaisala.com>
Date: Mon, 1 Jun 2026 08:30:52 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: serial: maxim,max310x: allow per-port
 subnodes for rs485
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260525-b4-max310x-rs485-dt-v1-0-e6c19b4d5592@vaisala.com>
 <20260525-b4-max310x-rs485-dt-v1-2-e6c19b4d5592@vaisala.com>
 <20260530-witty-snail-of-correction-a0a6f3@quoll>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20260530-witty-snail-of-correction-a0a6f3@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVX0EPF0005F71A.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::391) To AS5PR06MB9040.eurprd06.prod.outlook.com
 (2603:10a6:20b:676::22)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR06MB9040:EE_|PAXPR06MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 2307aa75-a761-44cd-d065-08debf9ef35f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	4AKzYstfynoB15UCrJCvplWZOn/fDiNNZ5seXAKXUfTICeYLbIGS1tXzLuoU6mZzskW7xVcvgMoyue/UWSGdMz5Rd8SarxCoF9UmbiszdOc0C/91tTYRjYe/PhzJ9hAU5yYOqPFB+VX42VFndjsPGzzkSFnHtMpIinLuxNrNy3vNuzlFWdUahGDtC3ejLnrQRX/C/xz9Gy28eMWFCoXzKRSYd1I7HRjBXBv4TuY58bIqVN3a4Xw9iMJKexBzg9mRECpjlA/6nehTJdf3LA7oLFZJHvdkPmPD6JLPlynGil0KVCQ+PBDtkG1cvhAJLivLsWSlWAlu6qGeumVLIRNle3ethuZ+KCvCm76njkT3x+VV16SFAtVAKXbeyg9cvddZMAr2AhPCGCVP3/eg+ejkCQy25HO0JLYBgFjVhoCzPggXdP5kz29tUCwuYpvn+DBzDqHllihhSOFLZS79XBsmEKCwbqBzoq5zMoacN8G8GCG4rDBwUf0a6fcCgyPuGY6DDQ5aQ41vO8yT5GwZV6vnIpa2ZiBseME4y+fw7YxZQqo+B5uf4+hOgH45u2KkIZjB0xNqnM3CRu5v2iB4so34QB2Rspfr2aG0BFtrmyd5GkwyDP7KNvljanYFer6IcquQ49qgmnQ7H95m6wW6NZ+AfPkHkWqDTk6PZWhhcUGL2z9FFBcyoA4/XhlH7j2D3MeJFWWEKre43CMPvA5dRUFHpQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR06MB9040.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1dqTWRPR3BoTVNoSks3MWZyUVFPQ215TEptRkluWDlDRTJPYnVLaVk1eDkx?=
 =?utf-8?B?TGRpd2VuRzh3TDN4UmJvYzU2K1I5OWE5bnRoMXg5QjA2UzFtZ0hydTV1T2dw?=
 =?utf-8?B?TlMrK3FTazVPZlUwT05CWkdsYmxNVi9aUE5iY3ZMT0g5djZSVC9JczNENWMx?=
 =?utf-8?B?bTFhS0JyNC9IZXhyQ1JDdWljT0U5cnNZNDZxMHJ4ZC9uQ3gzTitPY3pIRVlW?=
 =?utf-8?B?UFBoYUw5a3hENnJYdGIybTF1cHlsaGs3ZlZzVDFsWEs5ckFYaEhOemp1Rjg3?=
 =?utf-8?B?N0FxN2tHMDNtM2twcURtZ2Y3TzFlV1l6Z2ptRjJhakV6dHozanJsZlRWWjBQ?=
 =?utf-8?B?QzJSUDd3d0tITjIyODhwRzI3ZWdETTlObHoyQlBDb2FQZ21TQUxSbEIycEl5?=
 =?utf-8?B?bnFJNnBEeFBXRTZzZEppQzJ3UzBQSFM3dVpRWWx3RWZmSTVDbnYwdUdqWmpa?=
 =?utf-8?B?RHZnMC91MitpOEpSOFFSQzNxUXBoU25seE5EYzRmYURDS3ZTcHpKODkzUExD?=
 =?utf-8?B?SnZzSXZtU1I0VlJ4M0VLWVVHZjBMUnpTMW5OZnpkTzdkVE4wTEpLUWFiK2xJ?=
 =?utf-8?B?OWRpQTVwZDhWZnhJY0JzZTQ0UzV6THJucGs5Mk1RUnBXTnNrWDlIL0dESjVo?=
 =?utf-8?B?RC9vekN0NW1sYXhsZllzbDluNnFORDV4c1JOSTQycnZlQnpZV2JodGZKNUhI?=
 =?utf-8?B?dUY5Nk42a2pobDJvcjVrcnErMEU0cmxiRWMvYkl1Mk0ySlByK3g5b3J2MjI5?=
 =?utf-8?B?OVFxSkw0MVFEUWhoeUREdU1JdXMwbGRxb2hEclp1blA0cDZWMnVZV01pSEtT?=
 =?utf-8?B?Rk8zR29SUGJlTXpsY29HVkJnRVR6N0ZCY1I2aEFqc08wa1owTS9LYW5kdDk3?=
 =?utf-8?B?ZzdTSzJlSEZtdHczTmRMVmY1ZWNMQ2tDSlcvWk1EclU3ZGZsdHhmeW13K3Vk?=
 =?utf-8?B?UlZJV3AwR05RcHhvVVZrRmFVVGVpRkdSRWpXbEY3UitjTTcvQk9Lb2lDanVx?=
 =?utf-8?B?QW9JYmdZN0JzVHErQkFjU3JZSDNwR2xSWkxUSXlrSUltS1BIbU1uVHBaTGgx?=
 =?utf-8?B?UWR6WVZST2RnUi9GRlRYNFU3ZlNDbkFoREtzWlNuREhCZVdrcmgrSXlnMi9q?=
 =?utf-8?B?Z2M1N0xWeEhEdENmb1JnYm9NTDRqSkNqNHd6R05zWWtNSVA5TmVuYS80aE9m?=
 =?utf-8?B?a3BaS3Y0UjhkRStjQThGbnUyMFdIM3UvWmRkY1FRTXBiRVhwRHVVL2lCa1F3?=
 =?utf-8?B?cjMxY0ZPYWhDcng0S0o0NGZxK2kyVUdGeVZvRi8wYmJhZXBvNGNmT0FodEpV?=
 =?utf-8?B?Y2xCQTB4S0JOTDZIWFMzSzgxblRMenFDYWd0dnZ4bktiaEtGemRmY2FZRkhS?=
 =?utf-8?B?andvakszSUVYZUxDaWoxSkl4c3ZZQUd1U2NEODBhZmRMVkpkMWZDQ0g5R1Bw?=
 =?utf-8?B?YzNXZlM1Y2l6RUg1WjNvTXYxSzhSM3lzdnFGUTNKM3Y2MVVOUGVadmhWVnhx?=
 =?utf-8?B?MTd4MFRSWDNoTTJ5ZkxVajQ2cHM2V1hsQTZ2b1JDQ1VFM1F4cWtQb0o0TTBQ?=
 =?utf-8?B?VGRsaFl1cTlkekJNcVp5SEc2UlpGT1Z3bGorditpWlZubWhRdlhXQTRQLzFW?=
 =?utf-8?B?WDRybzNuc0k2dW1wRCtOdDE4bWo0VWorM2UvWnBoKzJZS01VMzBIUkMxelps?=
 =?utf-8?B?WTVhdU10TGJZVnlIOXBUaHUyWjNqN0xqSGgzdHVRc09JOUlwOTFJSG4zMnlD?=
 =?utf-8?B?Z0ptcmNQYXJqeXZzenNDZFMva2J1YVpFajZXUFRzQXJMVTNONGJ2aFZpZno5?=
 =?utf-8?B?WkdzZnpXZHV0THAzZ1FMTHgxWlF3VUZzTkZlQTBYTUI4N2cvSDJ5aTBkSWlt?=
 =?utf-8?B?dlJVRGcvYTJDUFBvazA2S0tTUXkvYzVSTElNQThONnJvZVdva2xvcWNqMzZi?=
 =?utf-8?B?eHZMbEJlbndjVnBaZE9ndHdnaDBXUlE2dDJNM1VlQkM2Um9DUDN3YzZqTmJ2?=
 =?utf-8?B?Qy9hYk1RbENWaHJUdktsbDhUTm92eWRKTFkvS3JIUXROVFJBNkRBcmVVMjU4?=
 =?utf-8?B?Y0ZvT1JVYTVZTmEzY3g5SnFUNjcydFNmbGVRVC9MV2xzenQ4d0IwemdsTTNW?=
 =?utf-8?B?b3UvNUk1YkpXQW56R0F6VW1lNmVBVUI1K3ZaV1ljV1U1KzJaVVYwb2RrZ0tU?=
 =?utf-8?B?eWNEWWsrTExsdEhZOWx2RXBYNEF2aEw4UkhINUZqUkZDZTc5MXNobEVNU2tn?=
 =?utf-8?B?ZVAraGw3ZURCMTRVaWY3OU9Pc0U5eVJWa3JNOVRSUjJ0K2ZRRjExU0lnOEov?=
 =?utf-8?B?TWU1RklRTDFkVG5STEgybUwvMXhTVVpJSTlxUmhkL0FsejJjNWlmMW9zR3ZE?=
 =?utf-8?Q?T4yv054ZHmw27ZyI=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2307aa75-a761-44cd-d065-08debf9ef35f
X-MS-Exchange-CrossTenant-AuthSource: AS5PR06MB9040.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:30:54.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nw/krONvs6eLkWcOeFLKkxaY6JcWTQFjtb97cJ+Mpxu1gavoxuILzK9luU7dGFGAJwQ4GQQqmxSKSPLgn3W5W/sJ/E9idFKoVYyEFg80bzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB7518


Hi,
On 5/30/26 14:26, Krzysztof Kozlowski wrote:
> On Mon, May 25, 2026 at 09:43:38AM +0000, Tapio Reijonen wrote:
>> The MAX310x is a multi-port UART (up to four ports). The existing
>> binding pulls in /schemas/serial/rs485.yaml at the top level, which
>> only describes a single port - sufficient for max3107 but ambiguous
>> for max14830 where each port can have its own RS485 wiring.
>>
>> Add a "port@N" pattern (N = 0..3) carrying rs485 properties on a
>> per-port basis. When port@N subnodes are present, the chip node also
>> needs #address-cells = <1> and #size-cells = <0>; allow both. Top-
>> level rs485 properties remain accepted for compatibility.
>>
>> Signed-off-by: Tapio Reijonen <tapio.reijonen@vaisala.com>
>> ---
>>   .../devicetree/bindings/serial/maxim,max310x.yaml  | 60 ++++++++++++++++++++++
>>   1 file changed, 60 insertions(+)
> 
> That's a total mess now in the binding.
> 1. maxim,max3107 does not have ports, but you add there. You need to
> constrain (see writing bindings) or split.

You're right, the port count is part of the ABI and I left it
unconstrained. In v2 I'll constrain the subnodes per-compatible with
allOf/if-then in the one file: max3107 and max3108 are single-port and
take only the top-level rs485 properties (no subnodes); max3109 allows
indices 0-1 and max14830 allows 0-3. An out-of-range port will then
fail validation instead of being silently accepted.

> 2. So where do you place serial devices? Did you validate any of this?

Good point, and it made me reconsider the node name. I'll rename the
subnodes from "port@N" to "serial@N" so each channel is a proper serial
node per serial.yaml -- that matches the device class, frees the "port"
name reserved for the graph binding, and gives an attached serial slave
device a place to live under the correct channel, which "port@N" did
not. The driver match in patch 3 changes to of_node_name_eq(np,
"serial") accordingly.

I also looked at whether subnodes are the right shape at all, since the
sibling sc16is7xx (dual-UART, same driver author) does per-port config
with top-level index arrays (irda-mode-ports,
nxp,modem-control-line-ports) rather than child nodes. That idiom works
for simple per-port flags, but it doesn't extend to RS485: rs485.yaml is
a rich standard schema (several flags, the rts delays, rs485-term-gpios)
and flattening it into vendor index-arrays would mean redefining common
properties instead of referencing them. So a per-channel node that
$refs rs485.yaml seems the only clean carrier; I just had the node name
and the per-compatible constraints wrong.

On validation: the schema and the example do pass
   make dt_binding_check DT_SCHEMA_FILES=.../serial/maxim,max310x.yaml
and the series was tested on max14830 hardware with per-port rs485 and
termination GPIOs sourced from the chip's own gpio-controller. But I
take the structural point -- passing the check didn't make the layout
right. I'll respin patch 2 (constraints + serial@N) and the patch 3
match for v2, with an example that exercises a multi-port variant.

> 
> Best regards,
> Krzysztof
> 

Thanks for the review.

Tapio
