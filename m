Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41761A8F82;
	Sat, 11 Jan 2025 13:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736602736; cv=fail; b=HpLm/l6+INXY9BXyMmFJLzH3/bOogIDoY7aDHTZCOx6kdrbogExRjLT8zPup2wP9IXK/jr+QNMQQbf6Jb3M9uuEvOT9IYxx+Hj4nm/nNWIK5B4c8gC8HMA0283isOUSEHrm/baNE7SZStMoOlHQ2fBiMmVdI7mUvT346LVnWZDo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736602736; c=relaxed/simple;
	bh=rV8IoexQrGEOTsWXaDR3VhrM2teaqWG4HIcbfDqUdP0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AHKF0RgBDeQYFQcVjTQAuGYUe9ARisVMVvNASxLC9fs0bHtVfYXvyrR1Irct31NBUf6Oc3YhraEweM5ceGem2hk6XNmCtUNkbKCBVVy5hAlqI+18t691sJlDyKp6hIKXkKfZOGH6bapHmfUVpEPH23OsCTj4bv+lVcdFihlmgfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=UI7+K6fI; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="UI7+K6fI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VB3INX3aQ1yH00uGTwvgHfFRHpYZ7Hkq6ilcVT95WA8jz8ZIk+BS+pfekt6YgXYF26cGapd57c7SnoY7GYkxvSJfXARav2IEMBvpCY+YSHKxOqYkdQW99E+MGejYAfq9GwK4dU/ClbyYaRBdUr4QMT4J4fw/lzcwqgpPzKJezeXkBkrxDDs0u+tgRSKLqFCwm+JZPau6GYw5dIDuAlOwE+70fiTPVEBPsqyhXtT1nhGwHgnEeTLWJoDmsLmXckoJcjJxB6wJdZyzZ+GoStt6j5cpNCIsHEM6150SwnoEdSZDO1XiYGZAz6gIjLf1MmhvZnLL29cBH8UeozFy8dk9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbeDFqzJ7e7ov5O9Zg65ywFCK23G+1FNTbkiD34loGs=;
 b=SRG3govm2F04R2/ilCuoGs7dQwMO7hVB+n9j4E24pLBl2AViTlL124+zGzWLhayTs8oWHuJyFWVVRPyfxig2QZMjUhT+mUD3Q72FDj8MUbuCcAvhka9pThqHaZBEeC5ikrWDuQXZ7jd/codGNuzsJ/1ySHkS2eRkedBt0Rf7eaqklWGZFLLEp9JP3P7NAa0RpSLDuKnY3nmwbXDODVSg8D3DIaT7aofgh6W/quAipi8+spb9el9qiaNKc55hUuZKQmx8vazNwqv/xy+/98XV1wczGYWlwng3sy5zCTujgXLjHZngdbXRBTYiHuXpvVCntweaaZ7mbxzyePYQ0PgBGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbeDFqzJ7e7ov5O9Zg65ywFCK23G+1FNTbkiD34loGs=;
 b=UI7+K6fIvPc+tox3/Nmqmx6FSH9Xv/oRkIA0Pvo1WRrdy+fm0zmjsz+Sh73GPBfLwSDiKEuXsiGNuCOIEkhTPsI1E+1ZXoZVutt8ORER+rjV/lDH8j3tg1PzkmdMMsGO/Mi4av8L+sef2RUmWVuUQWSqvBMcp3iPcCFKfdilSgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 by GV2PR08MB8028.eurprd08.prod.outlook.com (2603:10a6:150:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.15; Sat, 11 Jan
 2025 13:38:46 +0000
Received: from AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42]) by AM6PR08MB4215.eurprd08.prod.outlook.com
 ([fe80::f8bd:a866:322f:7b42%4]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 13:38:46 +0000
Message-ID: <f949e0b2-58c6-467d-ba33-89bc172b1a64@genexis.eu>
Date: Sat, 11 Jan 2025 14:38:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: serial: 8250: Add Airoha compatibles
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-serial@vger.kernel.org,
 devicetree@vger.kernel.org
Cc: ansuelsmth@gmail.com, lorenzo@kernel.org, gregkh@linuxfoundation.org
References: <20250111132250.3642694-1-benjamin.larsson@genexis.eu>
 <20250111132250.3642694-2-benjamin.larsson@genexis.eu>
 <606db6ae-bed0-4c35-967c-303b6277b716@kernel.org>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <606db6ae-bed0-4c35-967c-303b6277b716@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0112.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:8::23) To AM6PR08MB4215.eurprd08.prod.outlook.com
 (2603:10a6:20b:90::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:EE_|GV2PR08MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c80bb5-1188-488a-ed0e-08dd324545ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VUYyWWJ5d1h0WlN4bXhyc2YwbWh3TlpJbkVZWk5GdmNRV1RxdFhtSFdnWGFP?=
 =?utf-8?B?bEphRUFVcm5xQ2RCZmpvUVJoM0dncDFrZXpDTERGclZETkUzRUZOdys2S1dM?=
 =?utf-8?B?dGFFQzVFTXZmc3BXL053cEpUNStvWGIrL2pWc3ZwbmZsOFFJekxScXBaeTNw?=
 =?utf-8?B?cFloU2hROFZMbStEMkh5ckxtVTh2S1Z6WG5DL2FldlpEOVRzZkNuT1h3VXJv?=
 =?utf-8?B?dkRUNFFnZ2hPY1g5VzlTd1EwMkgwbmZHOWgvNURwVUMyRTJFNktVMXM1UHF2?=
 =?utf-8?B?VEVFcWN6d1ZNcTdxVkFpa25aaHVENWE4NEkyZ1ZuS0VTWDZGbHBqdGQxdm9z?=
 =?utf-8?B?WndKYTdLTmUxVXgvN2ptRWVxZnBNeERKdllyWnMxMnBseWpPUjJWZld6clox?=
 =?utf-8?B?bllzVUNrZGtBTlQybkUwZjdMTDJGZWRsaXhIUHNmRWJNem9qNEtVTVNxMXJO?=
 =?utf-8?B?bVJ5T1hPUWxpOU5kVGsrZXNXMzByaTdOQ1dwN0I4SEIzOEpOS0IvYW1hejUx?=
 =?utf-8?B?ZWw1dU1yaDhTMWJoRTYzbkJMNFJmdEdxVXBqbUQ5UjJqeU5ZcXpnaDFqSElz?=
 =?utf-8?B?WkpsN0NCR1VuTXVFZXRFcDRFaTNHUHlsdzdvVElxUXVUR1luUkc3SkJ6ZWk4?=
 =?utf-8?B?Nnpab2NTM2tYZjRGMG90WkQ3YWNzNHJ4VXQzd3VJbVlxM0R0YnlhTGVRKy9V?=
 =?utf-8?B?cTZmMjFoY3ROTStBZVhJckp3QUw4aWt3N0FHOUlWdjM0UWNKM3JUblhHSVZ3?=
 =?utf-8?B?eTJhWUxMMjd1cTc1VkdER2V5b2h1NklONmppVmhvMzJpczBLZVAySFFpOFNO?=
 =?utf-8?B?bzhSenN4M1NJdHhlcVNCdHZlRWx4RlZjRkI0MmZxbmU4ZnVVZTlvN3lHSVFq?=
 =?utf-8?B?aitHOTEzNFpucjFRVmhwV1BOK2pyUHh2bzlTTXhwam9NMmlIcW1WYTE3Y2tZ?=
 =?utf-8?B?dkJmOFhyb09KaTEwdG1SYTBuSi9NYkhFelVzR2VSbERkaGpPQjZKYmRFYVRq?=
 =?utf-8?B?MEZFb2xzRGpuZkpGaUpYbnI0RnpORjYxTnVnb0JqNExaaDc0Mi9BZXRTTUkr?=
 =?utf-8?B?cHZqK25IMWdWcWFBTTdFTjg5bEw3T21uNkVZY1ZGOG1LTUxoQyt2QTYrNEVz?=
 =?utf-8?B?MGk3ZWJNTkMwNnFVT09yY2VCc1h2T01Ba0daYjd4akNqSElVNlhrVVUwcHJr?=
 =?utf-8?B?MXpuNG5MMm1lbCtZY215b1B5TFhya09XaEJaUnVEblBaRGxwTEUzNzNKSGNx?=
 =?utf-8?B?akgrc1BlR21leVNWQnY5S0E1eEh6WWprdjNzdDJYR0p3cGhhcGRXOFlOMjdT?=
 =?utf-8?B?dmRGYW1XM3Y0UE1qMDVoTjA4bjRldXhoZEttMUxmU1NNQ3h1VW5DbDgwdnBh?=
 =?utf-8?B?RnRWZk96c2Q1NkZVMnJQWlBEUUZtQ09HelBDbHNOK0RySitBODAwRnl6SEl1?=
 =?utf-8?B?UXVDamI0T2p0b0RxZ01HVkV6N1RaOXdKT2U0Rk4vUlJsTTEzUWJFVkhlUGRN?=
 =?utf-8?B?bVVyZXdhaGw2a25IRXljajFSZml3bHNZOHlYZkt4T0lPb1FVRXdXSlVRdEZS?=
 =?utf-8?B?djNRTFYxY3l0M3RDMmlFSG15NUtpMlh3bkF3RldzalB3VjFvNmpEN0RuelFK?=
 =?utf-8?B?OXRvNExHQ2l3MGZVenZlSDlaMGZTckFqTmtGWWErTWNCS2JwYkpBcHkwSllx?=
 =?utf-8?B?U05JQkE1Qk1JWmdDU3RFVXlzYmZaTU5pbWRkVDZlb2ZDMS9DaW9oYjhWMWNl?=
 =?utf-8?B?VUhHWVlQeWFOTklJVzR0QnI1bHQvMHN3dWJBVjJhbDVwWWdrY0kvZmNEVEZr?=
 =?utf-8?B?S214MzZVc1BmMjZ1NlNzVFlWT0ZtaUZ4RnNETUJxY2JBNjM4ZVZhYldCQTVv?=
 =?utf-8?Q?z1M6cnMnzhW0v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4215.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTg4OWYzUHN1WVdZb3lhMENMZkk3TVNIQnZmSWJ4MXVXU2wzRlVkZzNwVVY0?=
 =?utf-8?B?aXRReXFwVE5YbHZMR081UnpXemIwMjFUZEdVeDVrODNFdm5SUlhKVGkrWnRL?=
 =?utf-8?B?YktON1dESjJrRkxNdE1FTURMQ3ZtWjF2aFVVMld4ZGdzaTZTTEIyQ0U0b1dw?=
 =?utf-8?B?MFBYY3QwOURNUWx0Smk1TXI2SERPaEh6WkE2dHMzK0ZoU3hXV1hlV3J2WkMw?=
 =?utf-8?B?MXVYUGk4Wmw4Mnh2ZkN0NzRDWDgyY2llTFZVQXVZMTFneVVRZ1hGMUFGcXpw?=
 =?utf-8?B?T3YvTDByMGhuQ0pTdVpIM3RrMlZGQlV3T0Q1QnlSRHpNNnYwRFJMTjIvMEMr?=
 =?utf-8?B?NE9HYTZWOUExMUVwL1BodnRtc3NhcWxXNTJUMWQ4L0F6OERnNlprL0tzTjBY?=
 =?utf-8?B?QWd0V2UzWXdrczBWMGVubUdCd2RvaVhuK2FpTlZLU3lSZ3Rqem9ET002YjF0?=
 =?utf-8?B?U0N0S3ZaVGhJR2VTUUZMSXJ6SUZuOUlTcGdGSG9GN2JBbDhaZ1dCZms0c2lv?=
 =?utf-8?B?TUwwL3JnTGFqTUtDVnE2ak9heG5NVHlxck10M0RKUUR3aFlFNUorMnI5cTRK?=
 =?utf-8?B?ZXEyT3lMRkZMRGFVMEZSdUcxTnhrVTd1OWlxL3o4TW1nbGRZRW5TS05vSm1S?=
 =?utf-8?B?eEIwK0ovT0wvUnhQeTU0VVNRMlN4MGhjV3VYaDhiR0lxK0hSdUtEdjBMNnZV?=
 =?utf-8?B?MWtzdStDMjdldHhxanRyc1NLVmhTVWQ4Tk81SjNQMkdKc2RTZU1tT1craVpP?=
 =?utf-8?B?cG5saHc1NG9IRXZ5SEpyUktzNm40UEwzSzhLRmU4VkhJWlpxM3BFekZPK09v?=
 =?utf-8?B?czFGNFZyYWJEdEw2d2trVWpwSmM4Sk9vOFNSRTcwa3M2bGFEdGp2bGZuYlNG?=
 =?utf-8?B?eEg5Y0RRa0lGaTQzVGNxRWsyZElUVXZJNmhXSUdUV3ZQbHI4Q1M4RDYvaDda?=
 =?utf-8?B?elVxVURtM1FLa25taDNvY1Y1ZjUwOUlmaVhKcTNFU0JUVmtyQWFYdjRsaFM4?=
 =?utf-8?B?MmxsamJRem1uQklxQkVJQzN4V0FVYXYrVDZaRExXWlBxTDFPS083dzJuc0Nl?=
 =?utf-8?B?aEJhekZaSTQwNDNJd0Zqc09PZlR1ZjRmZ2RrRnpHazVwaytSQUdOanhtbmsv?=
 =?utf-8?B?di95ampiaTVibUd1M2xMWDN6eFJ5UG9SaUJDNS9xYytHVk96VHJHRDBmSmdZ?=
 =?utf-8?B?NUUxUkEwV0d4TXBObDBlMXg0MXZ4TWkwcUZRV1BVbWovRDMwTCtoaG5tc1ZL?=
 =?utf-8?B?M1ZJdDhyZmM3aXg1OGlMQjdXV0xLNUZrMDVPOUgzSnZjbzJwTDE3Z1REZnB6?=
 =?utf-8?B?U3FTQVIwM1R2KythZFdhekVPbHU0NGkrOWU2a2dIcDZ3NUFiTE5QUytIdy94?=
 =?utf-8?B?ZS85QzB0VXpaajhLSzdmR2YvbGdOV2ZmL1EySUNVQTFBN3hoNGc5c0NTdnM1?=
 =?utf-8?B?ZnNhNHAxT0NOWGFPVnk0cGt1R0N1VXZxRWUxUnNkVWFIY1kvcXd2Tk5CODRl?=
 =?utf-8?B?UlJvaUlpN0htWnhmbGFjWGp5TzhNa2xsVjZGMFljVWoyUFBydmVOUXhsdURl?=
 =?utf-8?B?dHlGSEZVUmZjRGN1cUk3L3VrL2xrb0dNWWpiY0VQVDZCdDhRd0dRZ1lhenJk?=
 =?utf-8?B?cnZMRkJua3YvaFBUNCtuTklvb3VrSTJqVFFLeERYaGpQSWdYMGtFUG8wRHkr?=
 =?utf-8?B?WG4ybWNHdzI1L0tRa1hjOTdBT2xRN0hpekxGMmJvNlZnSFVLVWtVSm9OU1Ey?=
 =?utf-8?B?aHczaEdpN3NUVXEzVHRPYk9oTmFsdzFxcDErS0ZmRDF0S3hPYjRjZjB4bERp?=
 =?utf-8?B?Z25uL0syb29HdnZ5a2ZtUnlLdVB4ZlNkbmw1eWVDdzdKanJXZkNpd25idlZY?=
 =?utf-8?B?c3NXWmdmTm8zbThNcEpMYlhOeEZKWFpWWmZ3ZUVGVVpoTVdjbDZ2Q25UNmpy?=
 =?utf-8?B?Wm05YlZBZ1JDSkt1SGVnalZZZ3lBSnY5NEpQcklCYlQ4bjFpR29xelVCTDB1?=
 =?utf-8?B?UGVNbHdueVBOa1VCc1h4d1ZPc3AybnQwdEhmSDlQd0V5SmRhSmh3UndZemM0?=
 =?utf-8?B?dzB1MFZveTZJajFVdXdTdFMvUFo2QVpwR1dEMEJScmRQRVBkcThLaHp1N0lx?=
 =?utf-8?B?YStRSFZRQ2l1WUkyM3lnTzZjOTlXUWdqeW1LOVYzQ3V3ZnFqdUV3MkcrRTJs?=
 =?utf-8?B?ekE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c80bb5-1188-488a-ed0e-08dd324545ae
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4215.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 13:38:46.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZinnua63vdSRsG5L4b8UG43rzZrgpUBUYGhtVZC1/VpWDSBPAvWlP5DaBuoAcw0xpjUlV+ySMgXjd/yxN6HYJBG8lq+aJylCfeZ3e2Ma/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB8028

Hi.

On 11/01/2025 14:27, Krzysztof Kozlowski wrote:
> On 11/01/2025 14:22, Benjamin Larsson wrote:
>> The Airoha SoC family have a mostly 16550-compatible UART
>> and High-Speed UART hardware with the exception of custom
>> baud rate settings register.
>>
>> compatible = "airoha,airoha-uart";
>> compatible = "airoha,airoha-hsuart";
> 
> I don't understand these, not helping to understand the commit at all.
> Do not describe DT syntax in commit msg, it's obvious.

Will address that in v3.

> 
> BTW, that's not correct address you are supposed to CC. Please use
> scripts/get_maintainers.pl to get a list of necessary people and lists
> to CC. Or switch to `b4`.

Understood.

> 
> Best regards,
> Krzysztof

MvH
Benjamin Larsson
