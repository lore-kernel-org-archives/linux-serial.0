Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021082.outbound.protection.outlook.com [52.101.129.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63681DEFDC;
	Mon, 28 Apr 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827077; cv=fail; b=ijJisdd5ym9cxOa45xf+UuEy9cfpXgP2fcJb9DZZcp5i9Y2MovGVedrsRb4lUKW05KAiF1ZRrY6Sa0ZmzEKYncfBHSpRjAZUoZZAl2++V/0Z4mP48nXzEaijzYLhZQ7Zoy5Ap9aEy1+8sLVTslFz0+1bInasENJReOAJLmTSNvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827077; c=relaxed/simple;
	bh=tFuEjRiBuq5F4b3OZQxAqdmEqdxGCOrKxNP+YkfvgJ8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAAJzzdLLe/0hdy1ZNxqxv7yjWIqNLByuUmcdVgnv/TEwovr4OVRNxTsWAeJq0X+8WJ0XiaUKPx7m7kjNyCpwrf48F7SBuvV4/RP4eE4FplPmgN1lRahWgV82ZrQuN3OjNnlE3fUY9UjB2easAioqFuluLMuGMuBeFW6S+MMmxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=WQUe9VIz; arc=fail smtp.client-ip=52.101.129.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="WQUe9VIz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDZqhfw72Idlw5wf4Lz3rOSJsXlNBEry9l45z2MUz0fihbHTvoSkoWbfhke/M0z9C/SfZGUOC7AoVLeXXZiokDr1EEWPTNPvBUMjFOZqsiK0SmLdPoiCHKcATJ2sj1yWNI589AsVlrtC6gpqm0Psd9jfHbAC9XR4sg6N67FH7F0oGzgYJkzPfhoODLK/zH15pvmM66DUdjr7lx9d8igCFcFyNSMy0w0p3bHOQpcwMtE6QfD44C+Elo0hiS/45qfdGo98/X0ao2uZE1DEebAit1vPMt83OSzxMtphYpjFlRVRXbA2svef9+k8qUhcUuhELIV1JcK1MlO1uIvLA+gqbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db4HFvC+5/fBpx94pvGNZj2ebrFcPRcQXVnIVayqJkc=;
 b=BN2P61rqONXB5tG6moyeMdr8vF5cpBW4Fe5Eo2JCG/S/acF/bT67WQp43BvG56As3xSEhoUcGyud1qZj0bxBOtOYZjIDnsZyWjzQPkn8eZIV5wZR4Y7Gzr+AsBXHsdDcHTMVjA/z+SBTLsaNGEIWFZ67OVAsLamU1mgB1aQnWKNT9/aUgUqCrP514roI8Nn/QCjLfzsOqqc7atl5nN2VYUBX9BLxKzEptmKSATfmNXKhhY2r3u3x5WzxBlvea07xysOk1FbYD5ELniCBAMeio3LHBBlhwywa+G/KSZxzSRsVpm05eqKQl+znEy7ddeBo8xS/kP+K0xRJiyZuKSgvQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db4HFvC+5/fBpx94pvGNZj2ebrFcPRcQXVnIVayqJkc=;
 b=WQUe9VIz8FkOhy6wxQtF1WpEbKA7TczElxkQhLkfhCHIPoQhbXhl4N/1yNXNrXiHes1f75tEOgV+sdrWHJkVel8UBTqzfOl8p/W4be55sbOaKRYk8YRhW5hVQ7lsy3ElhgnnShGD1XX6r/a0bmrYi/C68Q4+B8e7hKFC9ZNdYg4+UlSnYNSUu9IVR0qk/D1yWck3DW8WYr20wvzTExv046VU9CeBcxYZTx0EzCOf1GVsL4cpfzawrJUFF3Su9ybB2UVEA5aGGVSfWTIMC2Csbbjcf6dqx4QO9hbh5NxWj7tGCqI3HNLSUki8Tju0WnZv5KFyU+Xx858djnOXeyaMHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
 by SEYPR03MB7889.apcprd03.prod.outlook.com (2603:1096:101:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 07:57:52 +0000
Received: from TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123]) by TYZPR03MB6896.apcprd03.prod.outlook.com
 ([fe80::ac4e:718:3b03:3123%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 07:57:49 +0000
Message-ID: <32473413-b2fb-471b-b2d5-b4fd7914b57f@amlogic.com>
Date: Mon, 28 Apr 2025 15:57:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Baisc devicetree support for Amlogic S6 S7 and S7D
Content-Language: en-US
To: neil.armstrong@linaro.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jerome Brunet <jbrunet@baylibre.com>, Kevin Hilman <khilman@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org
References: <20250317-s6-s7-basic-v1-0-d653384e41f3@amlogic.com>
 <a175ed1d-9e57-4150-af8f-7ca785203108@amlogic.com>
 <e3229c42-b322-447a-ad1e-86c6f20dd54e@linaro.org>
 <be8b7874-1251-4ba8-9243-a615517861ab@amlogic.com>
 <eb1c3442-6b86-42e9-a672-eaba7de8b375@linaro.org>
From: Xianwei Zhao <xianwei.zhao@amlogic.com>
In-Reply-To: <eb1c3442-6b86-42e9-a672-eaba7de8b375@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To TYZPR03MB6896.apcprd03.prod.outlook.com (2603:1096:400:289::14)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR03MB6896:EE_|SEYPR03MB7889:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec6b3e1-00fb-4ee0-d59e-08dd862a5e8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rlc2ODByNHMvdlNEMEV6UFZpWWJScCtKMnVUelV5Nm13NWVqNm5EdFY3b2tw?=
 =?utf-8?B?eSsvWHlEb0pEUnJXZ0VlVzlzR1R4REFaaVU3YmxuTEpNZ1dkbXZtTUhhTnNE?=
 =?utf-8?B?T1lUbG52L3ljSUlPNy9VcUpxN3JJcUpPbmd5UTN6alp5VUZtcy9TZXMzTmdw?=
 =?utf-8?B?OWdMUG5kK2pMQTU0UHgrWGJjekMzbHVMcVNyT29RWFFxK1oyZGwxb2cySnc3?=
 =?utf-8?B?enFNWU1pZnVsWllpelRTZ2VzMmJJSUVPSmE4eDZQTGZ3RG9pMWUydW1mL0FC?=
 =?utf-8?B?YXFtYmJMWi9WQmYxK2Q2TUhDTDFkaEY2L1gvRjBEUDFWZGZhUnlMUTRDeEZE?=
 =?utf-8?B?bmZUV0tPY0hjd1lpQStGTSt3MmZFeTBxTmdxSGNDVDl4VHFyR2VqN0x3cXg0?=
 =?utf-8?B?TUtNNzZtRW1UNUxaaThqcjJ0a00xTXJISlIxSFVhRUp0MTRrYlB6bDJVa1ox?=
 =?utf-8?B?RjVQZTFWTUlnRkFEVjc3UjF5Tk9MZ09BNmprNklTWmZsNUxJQnhyanlsYjRC?=
 =?utf-8?B?VUlqYXpWRzJETGpxTHJNdTU4QU1ZZWJ2TFlCOVFNRWlvRXZqbWZIYnNsWk5I?=
 =?utf-8?B?WmRxd1RCTkpRRkFjbC9uYTNoNGg1UjIrRUxRczYxVVB6NXBZQTFSWlVnYjZK?=
 =?utf-8?B?aHlYTGdPa3NBYzJLYml6U1A3WVFvMnU0UnZZbVF3bTZvaTlVWnN6VXRjV3RL?=
 =?utf-8?B?cThtL3NIaXdrQzNWU09iVkV4SFdXMDNrWUI5VUIxV0tmaHlreU4ybWFtTDQv?=
 =?utf-8?B?NGRqbHhEVEl2dDQ3d3BTVXVIN250M1U5WWliQnZ4VHlnZnpSbXJycjg4T0xj?=
 =?utf-8?B?QU1rSCtXbVIyRXd0bW5VMnJPY1gwdDNmNTBMYVpiWGY4L1BZR3ZtTjM4RUZj?=
 =?utf-8?B?UXFuWDEwZ3Frb21NT1hFRUNLQ2FmdlBZcW1FTGFxY2dnaThvVjQzZ2RzajdL?=
 =?utf-8?B?QU5ZL2NTRVBwWTk4eWpEaDR6MDcySzN1dFdKMzA3dmNVR2xGNzkrMitTMVFi?=
 =?utf-8?B?cXBIRkwvQ1FWbG4vVGdjUnVwbGZYeGZMakRER1NST1REbEpMSlo3d2JnMjln?=
 =?utf-8?B?Y3lQTjErYU5GTGUrdzYrdmhBbHo4cXlkenhkNzdDZ3N0VVlMU2hqeXRHVTQ1?=
 =?utf-8?B?NkRLSUxwazJVUEF3WFJKOGhvc1NyOC9iT2p3cFpWdTZlbnkwaHB1cEpOdFVR?=
 =?utf-8?B?QkRBVjYwdzhSaVVURk1GcG5CZzRKR2JncUJUemxsSFlkdkl0aFF1aDZzejd1?=
 =?utf-8?B?ZStyL3B0dHpxekNIdDFEOE1nUmlJc1lONTFZcWpxTHkvcWNnRXpvMnlXQnhr?=
 =?utf-8?B?dnhnWGZsOUYrM3djUEJ2bmE4bTlpb2dIYndKbDZWV0xldjhobU1EelRhbCtI?=
 =?utf-8?B?eis1SUFFNmNTUTR1bk9wSWc5NlFnYWxuWXFlb0drMnRyZ0ZoQnA4bHVBYVBO?=
 =?utf-8?B?ZXNEdUthMTdyMjljNXJlWWJ0MzZYSWhmdmJXcnN1R05XSWNURzZaRmxkR1RZ?=
 =?utf-8?B?L3AzbElqSDdFQTFlNjVkZmxnQVdBT1c1UjRSTGJXS1pPcit5WXplY3laOWRE?=
 =?utf-8?B?MlNYYWM0MnNyOUhkdWpPUHArWmxPZ0lYTFFPcmg1anlyMGwrelFiT1ZwMVhO?=
 =?utf-8?B?dVBBZDY3cmhVRHh4TmNOUW4xU1kraDJuOXhPOUYwRUJab0tyMjJKUzVjOERh?=
 =?utf-8?B?TStwTzVNRHRRcHBqQ1o0VHFGN0pQdG84VnpFL2NndHBaNVp0WnQxVzJSRUNE?=
 =?utf-8?B?ck81VDJCY3h5QW1EM1NHSWpIdUV6Qk1nKzZhbHlzNWlCdi9ybVFYdExPTzMr?=
 =?utf-8?B?MzhIUDZEeVFnazd6UmtLeU81dzAvSnhYZGZtbjVTRFhVNFBXR0Njc290VU9I?=
 =?utf-8?B?L1FVMDNGdnRxRURQWTJ0dDJhM2Q3M1Y2VG16bUJxTFBNQVFJL1gxQmJ1cXRL?=
 =?utf-8?Q?3K01A55mh6o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB6896.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V0l5N3g1NVMySWJRM2hNM3NDV0dJaCtEZDZMUE52ZEswYkk3OFJsN0lNZTIv?=
 =?utf-8?B?RXh5R0cxSkQzQWswUWtJT3hjTWZOR3V0ZlhoRThGVHNZZFc2WWxCam10VWZC?=
 =?utf-8?B?S0xkNmlicXlSUmd6VExEbTRObHErcFpxSHlqMG5wZFFJVnNrRXlwMUlrTmR2?=
 =?utf-8?B?VFlWMDNDa3UxMGcxeFEvVExsOVRGcEd4VWJxYVpkcmIxL3Rab1RPYnZhbTVi?=
 =?utf-8?B?T1lHV0RuQzJod1lhNFVQZ2JOVUQ3dlpsSHIycjF6aGZEdDdkVnlSZ3BTck5u?=
 =?utf-8?B?Sk55Zkl1b0ptYWl6SVJHM2Naa3FiKzl3cFB2TGlYVGJ1alVlTDZTSHV1Nnhw?=
 =?utf-8?B?cTNjTVplalFyQngzNDRocCtwYWtMWGVjS1czUVIvK0xxdlg5L0xmNGtuZnJn?=
 =?utf-8?B?TjhUY3BWTm5mdlJHS01BeHZ6NWFDZ09QanQ4WXA1Y1Z5S1lQZVF0TTZtbkxR?=
 =?utf-8?B?UHFoWlBmcndxMXd2dFlkYnJrM1Rkc3kzWUdNTThiYXg3SWFUaXRCOHNyN0x4?=
 =?utf-8?B?bXdjazdOTmw2VHVuNEZ5SUhLaVpKY0lZb3BNUlkwZ1MrdTB6S3hWcnhzK2Yw?=
 =?utf-8?B?Mmp1NzV4RUN6ckM5VDVzYmRaUlQ2RThqTWozOTgwbTFNbjVNR2R3eHo4cnJh?=
 =?utf-8?B?V3l5WjNJU1owVFVyL3czKzZnb3kyNzJ5YkhIMmkrdndQQWxkQnFDdnlUNDRn?=
 =?utf-8?B?MFk1YSs4QUo4RFhSWkJSTk95Z2NSajJOOTZuN0xlZzMyWXl1NStWZHNZakor?=
 =?utf-8?B?c0VzQVZkaTIxQmFDdUQ1TWtQNUx3SnJydTJGeCsyT25KMXFRWXFId2FySldC?=
 =?utf-8?B?LzhUd0pZc3Jmd2IwWmhSZXpkMFVMbGxRWmlKOGhYMUhJeWUzcmlJZVpKRUp3?=
 =?utf-8?B?eGxkb3NDQVNtaWd3R2pScFJsem1KNHBsRER0d1ZBbWplQkNySWdJSm84ZnpV?=
 =?utf-8?B?TEt5MnY3cTFVa3JSSGQrdUd3ZTljY3pMY2VoR3ZWU2tuUmpWdTkveVR3alhU?=
 =?utf-8?B?RzIxZUpyd0NlTzc2dm5nS2pnSFhKeWMraTRTWmtJOUhJb25tbGxZRGVpeUQ5?=
 =?utf-8?B?WkVSUHd6Sm5PZklJMElQT0w3RXhFRXJSd0xidWFNemlqK1pGR2xtL09tdExv?=
 =?utf-8?B?dGYzS2syTkpSWlA0YmIzSXVNMk5CT3MwNHNLb2VWRGxrNkNzRUpmUy91LzJR?=
 =?utf-8?B?VE01UjY5a3pqalRiOENrMk0rNytLZjE0dFZJODRwV1E1a2VMcWNuS1BtN2xN?=
 =?utf-8?B?MXBnZmpIVXkrekR0M1l1aDJTd1VROEZaeHV2SUd5L3ErK3VHOXU4Yll2bWVL?=
 =?utf-8?B?L1YvWTVSWmtRWFlkREFmenF3dkUxbE1zN05hODlSV04xNXpXVU5PV3pKQUJj?=
 =?utf-8?B?Q1hmb0pKVzNza2U2WnVnYUFsUFlrUXhwTmpWaHIwMWtlbWd2ellud0NZWXNC?=
 =?utf-8?B?YkZ6OTVoL2VLWVcvVjRhR05QaHZjV3BzRE5YZzJZQ0cybnJnQkF4TExQc0Z3?=
 =?utf-8?B?YkxKNS9wVzJXVXFiQnZibUtncGl3VlU4NTBKRDZQcFp4djBETEg2Und2dGh5?=
 =?utf-8?B?U2dKa3l0b0MzTXR4em5kdHhyZDRkYUlGRHcvSGpWZ2g0ZW9sR1RicFpIODNt?=
 =?utf-8?B?ZUhzMHREVmIrNHBDZk9lRjJsVit6aFJ5a1VlWCtza0p2MHpmRXVHRnBsOVZT?=
 =?utf-8?B?bmlOVlR5aUpJcGQwSG5ZQzRSNFBOeDRGOWNhRUNvZThaWGlKUW1DS0FqV0Vp?=
 =?utf-8?B?MXgyenYwUlFLbnVUTC9oOFdsNkpxdjJPVDZuTFNFR1VRVTBmOEtHVlhrNjJq?=
 =?utf-8?B?ZGloU3l3SmhkUUxFS3dJaDhZVTIyUEZsbTZya3cxdndYL0JzeW9ST2l3Slg2?=
 =?utf-8?B?a3czVzRKRXErZnJZWkdKYWJjdGJBRVlkSUNSS0tpZGlOaHJCUlhTNlVLZ2w1?=
 =?utf-8?B?VWJmUHRtKy9UdVpzRW5kTytjYnM0bldwbml2RGtZSDdSUnMzaEJadDhWclZx?=
 =?utf-8?B?cHBMWjVQL2lGY1pZazNnV3I5VTBzYm84d2pmaEhoV2R2VTU4aWlMMWl0UDRn?=
 =?utf-8?B?NzQvb2hGMEFXaWcyZHFnbkk3UnVEWFZQaFhESGV4Y1U1dzVVYUFaK3JyN2tl?=
 =?utf-8?B?SmFRUVVaaVZzT2dDbEFPdlp1SXZQSTA3UUFtQWwyVENGWTMyUlY4a0tQMlFI?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec6b3e1-00fb-4ee0-d59e-08dd862a5e8f
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB6896.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 07:57:49.1307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: An8t/DnRxm25MjWFWe6w9wwrdtNDKwjd6oluYYlQjZFPNFbAgDTfyDO0PGhebP/IDR0I7XDLJbIOEqLYC8q7A7+EdSsUUfPAZrA4ncLh69Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7889

Hi Neil,
    Thanks for your reply.

On 2025/4/23 15:23, neil.armstrong@linaro.org wrote:
> [ EXTERNAL EMAIL ]
> 
> Hi,
> 
> On 23/04/2025 08:15, Xianwei Zhao wrote:
>> Hi Neil,
>>     Thanks for your reply.
>>
>> On 2025/4/22 21:49, Neil Armstrong wrote:
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> On 22/04/2025 13:45, Xianwei Zhao wrote:
>>>> Hi Neil,
>>>>     A gentle ping, thanks.
>>>
>>> I'll apply them this week except patch 4,
>>>
>>> so can you send patch 4 separately since it goes via the tty tree ?
>>>
>>
>> I will send patch 4 separately.
>> The following patches(5 6 7) can be not included for now. Without the 
>> patch 4, the command "make ARCH=arm64 dtbs_check W=1" will fail to 
>> execute.
> 
> I know, but since it's reviewed, Greg KH will pick it for the next 
> release so it's fine.
> 

I have already sent patch 4 separately. From Rob's reply, do you think 
it can be picked up together?

https://lore.kernel.org/all/CAL_JsqKD=yespd0WM90VBr_XWdppimzDzecmwNfGMV+hNSHuRA@mail.gmail.com/

> Neil
> 
>>
>>> Thanks,
>>> Neil
>>>
>>>>
>>>> On 2025/3/17 15:16, Xianwei Zhao via B4 Relay wrote:
>>>>> [ EXTERNAL EMAIL ]
>>>>>
>>>>> Amlogic S6 S7 and S7D are application processors designed for
>>>>> hybrid OTT/IP Set Top Box and high-end media box applications.
>>>>>
>>>>> Add the new S6 SoC/board device tree bindings.
>>>>> Add the new S7 SoC/board device tree bindings.
>>>>> Add the new S7D SoC/board device tree bindings.
>>>>>
>>>>> Add basic support for the S6 based Amlogic BL209 board, which 
>>>>> describes
>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are 
>>>>> capable of
>>>>> booting up into the serial console.
>>>>>
>>>>> Add basic support for the S7 based Amlogic BP201 board, which 
>>>>> describes
>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are 
>>>>> capable of
>>>>> booting up into the serial console.
>>>>>
>>>>> Add basic support for the S7D based Amlogic BM202 board, which 
>>>>> describes
>>>>> the following components: CPU, GIC, IRQ, Timer and UART. These are 
>>>>> capable of
>>>>> booting up into the serial console.
>>>>>
>>>>> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>> ---
>>>>> Xianwei Zhao (7):
>>>>>        dt-bindings: arm: amlogic: add S6 support
>>>>>        dt-bindings: arm: amlogic: add S7 support
>>>>>        dt-bindings: arm: amlogic: add S7D support
>>>>>        dt-bindings: serial: amlogic,meson-uart: Add compatible 
>>>>> string for S6/S7/S7D
>>>>>        arm64: dts: add support for S6 based Amlogic BL209
>>>>>        arm64: dts: add support for S7 based Amlogic BP201
>>>>>        arm64: dts: add support for S7D based Amlogic BM202
>>>>>
>>>>>   Documentation/devicetree/bindings/arm/amlogic.yaml | 18 ++++
>>>>>   .../bindings/serial/amlogic,meson-uart.yaml        |  3 +
>>>>>   arch/arm64/boot/dts/amlogic/Makefile               |  3 +
>>>>>   .../boot/dts/amlogic/amlogic-s6-s905x5-bl209.dts   | 42 +++++++++
>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s6.dtsi        | 97 
>>>>> +++++++++++++++++++++
>>>>>   .../boot/dts/amlogic/amlogic-s7-s805x3-bp201.dts   | 41 +++++++++
>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s7.dtsi        | 99 
>>>>> ++++++++++++++++++++++
>>>>>   .../boot/dts/amlogic/amlogic-s7d-s905x5m-bm202.dts | 41 +++++++++
>>>>>   arch/arm64/boot/dts/amlogic/amlogic-s7d.dtsi       | 99 
>>>>> ++++++++++++++++++++++
>>>>>   9 files changed, 443 insertions(+)
>>>>> ---
>>>>> base-commit: 73e4ffb27bb8a093d557bb2dac1a271474cca99c
>>>>> change-id: 20250221-s6-s7-basic-f300c30877e6
>>>>>
>>>>> Best regards,
>>>>> -- 
>>>>> Xianwei Zhao <xianwei.zhao@amlogic.com>
>>>>>
>>>>>
>>>
> 
