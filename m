Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2093.outbound.protection.outlook.com [40.107.105.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA88137C37;
	Fri, 21 Mar 2025 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742589439; cv=fail; b=TCjyu0r+xohBG19wm0EWu+a89J5Tw68umsoxnEAZiW8hgXOu2wWUmoNPZIaxy7xqe2Hd/F5dw+L5Rt8FeANd0OXX/lPlLn/LmEVEIKWp/RA88VxscSASbF/2ZTPkXIW7/lbJV2xpyO6n4bGqzDhWR9k3Ild9XMrH+X+cncdnBZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742589439; c=relaxed/simple;
	bh=bL2BVjIa1Zf6C7zrWsidsKLrH34Q75SFRdWAXLo4EeQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lelxaOusvZPDEJG2JRy/p60gY5vZ+gdnqdvaVbXOPIKbBM7SkvkIRTqbgSow+mo5rva5KKGxhtkddVWTZfzFUd65OA24PYIwJYrtPpJ4ZkzwRKoc1iZwTJXVzoNFj4WOz7ndbHPlMQ3Hfr7LDj1OC9vUkdNJDxEiu0ASCcUqJ0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu; spf=pass smtp.mailfrom=genexis.eu; dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b=LCTd5KIs; arc=fail smtp.client-ip=40.107.105.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=genexis.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=genexis.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=genexis.eu header.i=@genexis.eu header.b="LCTd5KIs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1ISzMVqlEMhM70EF3tcKXWrMJlFKpgKDAGRne7QGJc/donUdHI4knauGdZW0/psKOxRBvLK02L62tTbCbzqflJb0/td73T0i5NGDyBiqkIp3rPc80Zeu96ZrGu9inSzEUE7DWttm0aIQSgjosH5DzDqtlzMatjiGgnSmYzc+rXKN3XhSr9ebAKUcmbxHebU4QH1mShk/SIQPzr1DwsDdRmHMemSL6Or80Ospn2xvkh5HD6FSBkAC5RiGQkBtCQhTjqz1dH7evKsvM41fVdZ7BUC8OxuryEhQPxaAw+GDZEUUeUBYynJKP6jmZSN/xxJx1sos2H6DvhhPVqeQdEEjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czkSA5+7Sxteem+BYPefrLU0ZnxHwB5fvr+KeChgmHM=;
 b=R/AZf7jg4XJM7ADKVhwsLdXigty1ocNuwBqFXiVfre3fPFCeiVnXGLwkXHrhINoxDxJcXFIV4ijTkv5UCAfMAEoFuHD+I4b7WlWR4oZ8QQFSAmvsvMkYt6MrKn7E+V6s8gt81QHVD+T6j5nb1V9WLlsetatCo0F5XgCk4Ko1umVXUdhIp9kdkocqBcnOUAtSP9VN6OGU15MQuvw2FWUnFD+4xEOu962RNgbnhuzTXyxlBnXsfmh8tAKp5LXJdpS1uk7ZAEASvr2ujIjKE8nms9tJABGBHInm/ooNa3/zOuxHDfO2lxhJKZWib9h/JNF/jf4kVMWy7dY65ewzN/yVkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czkSA5+7Sxteem+BYPefrLU0ZnxHwB5fvr+KeChgmHM=;
 b=LCTd5KIsQiOyXilODNAdSh4vkudtzaQ3DB3axZSRiwRll7Bgf9aF8EqJMKC2Ws30yYkoL97+DBi1Up0bim8Ol3CC98wfcvYNnvYKJDMoofqJ+tJtFXq+p9LTp2gGO2OajmB2k7BIyhypAus4dRuqmjvuek/urHtD2sYrXAvAMQg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from AM0PR08MB4209.eurprd08.prod.outlook.com (2603:10a6:208:10c::13)
 by PAWPR08MB11039.eurprd08.prod.outlook.com (2603:10a6:102:46c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Fri, 21 Mar
 2025 20:37:11 +0000
Received: from AM0PR08MB4209.eurprd08.prod.outlook.com
 ([fe80::85e0:261c:f717:5ffe]) by AM0PR08MB4209.eurprd08.prod.outlook.com
 ([fe80::85e0:261c:f717:5ffe%4]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 20:37:11 +0000
Message-ID: <28a3cbc9-53fb-44e3-bc87-d33cbc406c8e@genexis.eu>
Date: Fri, 21 Mar 2025 21:37:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Airoha UART support
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
 ansuelsmth@gmail.com, lorenzo@kernel.org
References: <20250209210241.2622309-1-benjamin.larsson@genexis.eu>
 <2025021019-overtake-elk-e644@gregkh>
Content-Language: en-US
From: Benjamin Larsson <benjamin.larsson@genexis.eu>
In-Reply-To: <2025021019-overtake-elk-e644@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF0000385C.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:c) To AM0PR08MB4209.eurprd08.prod.outlook.com
 (2603:10a6:208:10c::13)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR08MB4209:EE_|PAWPR08MB11039:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d26a551-c7fc-443b-c4de-08dd68b827dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnVMUXpSRlp0T1RQVXZQeTcvblZnOFQwVUxSbnVpRUhDeG03Qy9PYjk1L2NH?=
 =?utf-8?B?aHdvYm5DWFRkYmxtQzMyZUhuKzcyM1FPNzYzREx2Q2g4WCtPY045RE1yczNS?=
 =?utf-8?B?VFpubW5ETEJMQlVHTFhWTWJ6WVdkQ2xLQUlZOGVJNERMdktYbWhLTzJXWXpI?=
 =?utf-8?B?VU90TFYzK2FiaVEzWTcvRXVOWVVOL2NQclIrTEpyc2dQTHRDUmg5aWtVRXNQ?=
 =?utf-8?B?NmdQT3J5MGZDOEJSZ3d2SmpGT1JWQnNQQ0VaRnVMMlJJcXF5MnN0QVVQd0lM?=
 =?utf-8?B?cWZIMTNoazUyUTZueUNOK1BWY2JqL1IrSlBweFAwcENnZ1FDWU5BcVNWcmpT?=
 =?utf-8?B?V0trdXhsQmZ4TDNBM2U5cEFYalI3ME11eVlHbjk4UEpFRzFocnB2dnFqcjhi?=
 =?utf-8?B?Z0pac3c3ZUVtbGlFOHlOcWUxb3JoWVBYRWFlSUxseStaQ3JOVzZvT2xqRnlj?=
 =?utf-8?B?NlgvMHFCTFo1ZXpIelUwRjhXQWYzbmc1NWMrR3BPVVRKZ3BodnUwVlR1azNv?=
 =?utf-8?B?VXFoYnFkVVpMN1VQOU5UUEE5TFA5NkdPZlZsbUoxVTRFOEgxdmFncHczanhU?=
 =?utf-8?B?ckZ1eTdYc2czbmlrMXd0anFWc3Q0aFJFU2pGRXIrMzdLTnJqT2duTzVhQzNk?=
 =?utf-8?B?RHJ4OWxvbVVMU3lhVHpEbURSMTUxSUJVL2VhVmhwanhhZ2g4TC95VDlEQ0pV?=
 =?utf-8?B?cC92Yy9ETEZFMGFEMnpuM3ZMdkNON3RlZkZzZGFlbFpmZTJqSU1kMENGUHlO?=
 =?utf-8?B?UjdsZFNDVzcySFE5M2ZNUWd2emF3aUJkSXhEUWxoUWxuRTRrS2w3ZEhWZ1hC?=
 =?utf-8?B?VEh4bTVCM1VBR3VKNWE1a0VNMnNmakg0ZDBwNU1GVmJDbzkyNG05NnBKNnpU?=
 =?utf-8?B?bCtDVDVHSC95SlptNjlnWHkrQUNQbXJMbTRsRXovRHRHWnhsMTRxcm5iQjZP?=
 =?utf-8?B?TDdDVCtjeXJWRGxXR2V0Yk54dDhuWEF4bWt1VnhBMERyWFJkWWtmMmg5Ukgv?=
 =?utf-8?B?TCt1bkN2aGN2QUhha2l6Z29VYURtS2syV2lZZjJRTmVWM2RtUEJkNlg5cmRK?=
 =?utf-8?B?c0psQlFkcmNXSlB0VWtpNlk2SmlVUEZjaERqZUlrM3B6UkhxeFFEQWdiT3dv?=
 =?utf-8?B?TExDSTVWU3VKM2Nzays5ZDA2dkVLWXdKdlNGZnl3aGpHQTNkdGJ2YXlGREoy?=
 =?utf-8?B?OSsxRXdzS3Q1Q1JmTzZKUktxM1Q2VjNzeXZpVXhLZ0ZFU3FrcDFHbHI3dFBr?=
 =?utf-8?B?NE5xUzNTaDd4a3hwK3FmQnhmWDJMVnpsb1RVYS9qM3lCV0I3M1B2RU9KMUhw?=
 =?utf-8?B?VFlMY1BHdmE0bkkrcFhtUWZUaG5nVktHck04YkhtRkJ5MlU2MWVZVHZ0Mjk1?=
 =?utf-8?B?YXBZRTVUNndPbXdtUTlYYlhOSjRLVzBCaEg4bVVBbVhTYXZpbU5YYkxmUVFU?=
 =?utf-8?B?bnRuMjA3V3YyRXNDRUNRbWw1YjVjSXpSWVVhRitTMGR3dXhiVHhVckRvQXh3?=
 =?utf-8?B?YzI1QTJBZTFpY28xQm5vY3o0Q29WdDlKOUFyYW5IckpVcG1ib0FkVGRkTVZ3?=
 =?utf-8?B?dUVJbUNxdXRLUlhKdGdTR3czbHNIODcyNCtQNCtjQSs2WmdwcHlHOXVSSkd3?=
 =?utf-8?B?T1ZoN0JGQVBRUFQ3UW1ENVZlUmZxRXE4YmMwWnlHalhOMElMaDdteERMOEpi?=
 =?utf-8?B?akROYUFJNVJsUDYwdXRGaSs4N21lbnZQUHpoUEZKTmRGaHVWVThsc3dZN25O?=
 =?utf-8?B?VVhPanZSa3FJU0ZwenRlQldLM1MvWitFS2xGZmp1aDlKMXA5cXA3YnduRUdw?=
 =?utf-8?B?TU5sR0pvcHd0SUxRdEowNlcvN1IrbFBPWnZNb3VhV3JLVXkzdW9KR05oWDA5?=
 =?utf-8?Q?QsumKgpnnEjo7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB4209.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk0zcFZDVWZONDJ2QWtFUEdqZEVSdllxS0hXMFFOSzVqaTBNMGdMMnNMVG1Q?=
 =?utf-8?B?ZGxOZ3JrS0RCTG9tUEN0SzhJUDBPc3gvSUdGK0o3Q2dIWHdCb0lWcFhXZTF6?=
 =?utf-8?B?bGpQSUhGSmlCemp2WGwyeEkrTjNjdHRwTmF1Rnp1K1JNUFJpNnVPZC92ampw?=
 =?utf-8?B?cmsrTDFJWUNTWnhxQXVFLzJtMndOd0doMGQyV3Aya2FVbFVDTUdjRmVlSXFw?=
 =?utf-8?B?SGVQb3pFQmJNVmpyVTVGZXkwZXh4d1R6WExwb2IxdzdFNUlUVUxmRGd2SC9i?=
 =?utf-8?B?R1NjNU8rNXNMdnQ2ZVhWR0ZaK0lKTWtEZ0lUM1dqOEdGL3RpaVZ2TGZlV24x?=
 =?utf-8?B?V2h2NW9FNDJPZ1B3YWVDMHF1cG4wRTV5M1lhRTh5akRodkdhaDZHeWd4SFFh?=
 =?utf-8?B?UmpWWHdPelVTV2xoTit4cGtqMnFVNzh3WUQrVE5hOFVNaG9oT0hxRmx3bWUw?=
 =?utf-8?B?SnZ4bUpDZGZkN0tBM0c4Y1FraVdINGxtU3dJOE5xRjN1c09RL0lQclhNemRP?=
 =?utf-8?B?NVNlVzNhcnEvU3lXVVRWYkxiV1hucHl2VlB3aVVDa1orUk9VTmY3Wnc3WEJj?=
 =?utf-8?B?NHVKeCtQZE0zLy9qMDIzOStsOERBa3RmL0hMMks3bzdlbXAwQ29PSjlaRjNl?=
 =?utf-8?B?Nzk0OW44aldZUWV0S2J0cWo0T21Nb3YwR0l6TFBkZDREd2w4RjNrN21QK1ov?=
 =?utf-8?B?aE9VMEFuR0lLNlBWVTBaQ2RrSDJtNVBuc1JQY1dPNUp4TFlUSmp1VG9TNGVo?=
 =?utf-8?B?ZXFkMWdqdWxpRjBlZjRsV2I2REVBdXdweGJEVWtCejFBbzJvTVlhc0tyYm5z?=
 =?utf-8?B?Z2xKZDUxQkdhcm5YUzNnemtGUWI0Yk5IMlRyVjRoaVNDM1BGV2FFWTBqVnRv?=
 =?utf-8?B?Q3hoWVJOSWtpZ1YweHh5dVNJbDZyZmNZSHhGSll4MGNGb05CZUE5eVpEZlRL?=
 =?utf-8?B?NW0rTTZwekNpYnFUSUorVkRza2tHRnRMNEZ0dUZoRWZBM2VzK1ZRN2ZneWk3?=
 =?utf-8?B?TWFQeXRZV0VMWTVJaW4xUy9yVVRLOHpUWkxhWWlvRXo1cml6MW9WdDNvYnhU?=
 =?utf-8?B?SVVDT2c3cVU1MlVUcUtqSDJXNFlhREJKak1zK3pKNXdwMEZvOFRSSG1QUkQz?=
 =?utf-8?B?a2QvSTNlVTRFRk4yanpvejlmN0V3eFAyMnMvWGdrM1NrQkExTG5HU2xIYnIw?=
 =?utf-8?B?MS9BQm93SUNXbzBZT2dVZDJyK3g2U044VkZHWFREQ1Foajl2MzB3dU5tNUhZ?=
 =?utf-8?B?S08vcXBhQnJNdDI0VGgwdzZ6RnhLTElPNHU1elp2aHBOdSt0SW1jZmFENnE1?=
 =?utf-8?B?SWt5c0xBbmVzSlp6UnlJaklpc0R0eG9KVmZVMitCMytpdHptaG1ySk5ENnRr?=
 =?utf-8?B?aUszZE9VNE1pTjhjNXVJNno3MlJzUGI4MEVWSDR6OTFYakNWUk5VUjhOd0ky?=
 =?utf-8?B?Wi9GUFBHdEk1M2hTb0RNOGdnMDhFblNMSWEvN3BaRjZxR2x1cWNiN3FhUlhZ?=
 =?utf-8?B?L3FWMU5LTVp4ZkpZVXpqQ1I4T3R2dGg4L3c2TWVIcFBoQnoxSG9uNWd4RWVm?=
 =?utf-8?B?bDJyRWxLeE9mYzY0L2tFQ1ZuUlpjVjdqTUZsNE83aXNsWTJ1TjJaeFJwOW05?=
 =?utf-8?B?WkxYWXZUcFhMcjJjdkFaRXhIaktKcUh3WUlxTTFvYXhvRCtBSnpORFF1eDlT?=
 =?utf-8?B?M1h1WGgrRmtlOVZxeGxFUUY2cUFQMW12RVp4WDAvVzIvWXltcWdFT0hzdi9I?=
 =?utf-8?B?aHd3eU1Bbm4yc2N4RUIwYTRtSUpBUHFncmdoU0xaOTEwVGtjRmd5MGlpREt0?=
 =?utf-8?B?ZGFrRmFuVWlpTVpBKzBqTE0xTFdrMTB1cUYzRzQ5VWw4cEJwcUFXNHR0Y1Q5?=
 =?utf-8?B?RlVOSDhJWHBhamRUd0xSSWt6cXh6NDdzeVNobmpuY29pUFRWRkxwU1dUWThN?=
 =?utf-8?B?ZEJLalJ4bUFiZXZWOVFYY2t6YUtNbkJ0d2xCUDUvdFljc3V4WG9MaFpLT0Z5?=
 =?utf-8?B?d1hJNUs5OWJ0MDY2VlBWUG1PVlY1KzBhTTZKcXpKVlpxRzhNVjViS3JpQjUz?=
 =?utf-8?B?NXRPTVpOTzRhanlaOHdjZ2ptZWgxdnpkZHdEczNkY05YeFhXdzAxcEs3bzN1?=
 =?utf-8?B?NG1ZVmsxM0xEcCtZQkYzVE5DeW5VQW1ibDVVdWQrb0RONFF2alV0YzRpSkgr?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d26a551-c7fc-443b-c4de-08dd68b827dd
X-MS-Exchange-CrossTenant-AuthSource: AM0PR08MB4209.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 20:37:11.0560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XgT9Luwyhwjka30p8H21zqKb4u+cZD23ZBBmbKaLgVQ3fP1lJZjT5v4IBARjYTqUEQB0LThoKwg/HMcfSgcTftMM0Pk/LmoKnqCS4q+sQOA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB11039

Hi, I seem to have missed that you commented on the patch.

On 10/02/2025 07:14, Greg KH wrote:
> On Sun, Feb 09, 2025 at 10:02:39PM +0100, Benjamin Larsson wrote:
>> The Airoha familty of SoCs have a UART hardware that is 16550-compatible
>> with the exception of the baud rate settings.
>>
>> This patch implements code for calculating the baud rate for the Airoha
>> UART and HSUART.
>>
>> Signed-off-by: Benjamin Larsson <benjamin.larsson@genexis.eu>
>> ---
>> Changes in v4:
>> - Removed COMPILE_TEST from Kconfig
> 
> No, please don't do that. >
>> - Removed Kconfig option to build as module
> 
> No do that, you want your code as a module so that it can work in a
> system that is built as a "generic system image" that does not force
> your driver to be built into the main kernel image, wasting memory if
> the hardware is not present.
> 
> thanks,
> 
> greg k-h

I would argue that I follow the current flow of the code. In 8250.h we have:

CONFIG_SERIAL_8250_PNP
CONFIG_SERIAL_8250_RSA
CONFIG_SERIAL_8250_FINTEK

none of those enables COMPILE_TEST or the option to compile as a module.

Neither the Airoha code or the other code is not intended to be its own 
separate module, it is to be part of the 8250-driver. The 8250-driver 
can be loaded as a module with or without the Airoha baud rate code.

Implementing COMPILE_TEST when the 8250-driver does not support it seems 
tricky. All the ways I could think of would result in messy code and 
logic. I came to the conclusion that a smaller patch that reuses the 
current logic was preferable. If that argument is not good enough then I 
need some guidance how to implement something what would be accepted.

MvH
Benjamin Larsson
