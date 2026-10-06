Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023081.outbound.protection.outlook.com [40.107.162.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DB35B636;
	Tue,  6 Oct 2026 04:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259574; cv=fail; b=X4S0+VHjT+wxvV8Kkp7zA5TBAQCZJWCdL0MeUoLXiIUGwbxqFTVEGiI0cIok7ri/dWV8VScQK0lb/TmYyL7fxpqJSFwEfNzlCi3g5rvGM09De9OHsOx3Fzam8+XulEuqskgdk2cC+/MvHNn/dd+T0B9qexWu4kJCJUmLwmCwsXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259574; c=relaxed/simple;
	bh=HE1RDIHubKIOk/3f84uTn4q36hP7WHs11XmaEBstJYE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohPED+j0LuDpEwCkwXySltHlkQLFbQ+Nf/69aRcYtW1CUXygaECWRvxLNTzBKUc4UU5liKOIDpvJinoEXdzjQBgbmffhyZtJxbUJ3ykYaNNxHNj5XIThj3DeamnJs/ECoha+f6Cys1xdwQ0R/nrtF7SpgWNRe5E9UREaCFZ92r0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=L28DL6D8; arc=fail smtp.client-ip=40.107.162.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="L28DL6D8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QFQPtEFcJEYhj98WnMbVYeTgFJlyFZw2ChKUU/SzQC0CChNBNwrEb7FBK/bivNISLaZPo4bRtWpmqed6CXs2959hgPQX+Vx0tJ4sHyXPZa3X9PjHnUhBEGRCha+rGQTOaWumO6nQTG4iqvM5kiqtznlZ9FPXVFQIyRxHgEdaXAi6OU95jwtuvKgCy4G/gTyzdXfpBJrSbeuCZtSFzNjSd6CCUPO19bdUsSusT8jQHC8qdIbL+2WfZ5kBfusN26Qh4ybpOgvol6ZYhNiCtgiDOlVqWzGBAQ44ghobLehc7BY+4STLWmoRrORbxd2hjShbw369VLT6j7vI1lT+e6Hyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HE1RDIHubKIOk/3f84uTn4q36hP7WHs11XmaEBstJYE=;
 b=ZIF9jCFmcTPm0W92LxTq9YkQu1fns6hqjAsOtD6zPDU9smWJ0WcZuiK225IaE9UQgWhtvEGeA/EfhkW3Sj/RXyuTj4dy/C7OkTsoctz0AkTcKO065fZHF/qANWievW/E1qLvI/IPvrftvVWaKG3MmN9x1Z2WJuHX8YPcitJb59t1EpwXE/oMU17IrWj/K6s9kegc2CRGJpHT69pFPDmuqyEaxn+0BNcWKE1FIiq6uIYv4XI03ievRfcdj3H6PPbRvTZLqCQGSdHv0AWwKBzD830Ubroe6cDzDZlUt/QB8pQqcbgQ2DZfFj7hI4E/NJHD6xeC21AGOjYbI/2tqSCuvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HE1RDIHubKIOk/3f84uTn4q36hP7WHs11XmaEBstJYE=;
 b=L28DL6D8scSFu5DL4P1eErK8+jPWGbDEfX8C97rVSB0hTMTctgFC6oP99e6/hjsacGhzaiYUqspFeN6GpdSMCVwh/79tBO5pIitaTT+kpb3e4E6ylWnEq4UW4+wEuzmy1DBlLuqOzlzw+6kfVLOk10TrJc/uzHTkAKiFik+d+6W5gvt0PnBoHzdWzBrLgOGuWO91UO59FGY25KqnRReiFHlVnJAvHOuNIHpy/pN4ueflmHG6G9P3jvIVb5P6dkEDol7m1fGR98DKyCZ/PIeMBBmdM49EIxlW2JfrjwLsWBhAgVnllHl389H545qUPq/rHuanaA/DMPBmJ73NG8X6JQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by DB9PR06MB7867.eurprd06.prod.outlook.com (2603:10a6:10:294::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Tue, 6 Oct
 2026 04:06:08 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 04:06:08 +0000
Message-ID: <a69c09a9-76d8-46c2-9aa3-64b7a961cdad@vaisala.com>
Date: Tue, 6 Oct 2026 07:06:06 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/9] serial: max310x: don't clobber the TX break bit in
 set_termios
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>,
 Maarten Brock <Maarten.Brock@sttls.nl>
References: <20261005-max310x-rs485-sw-delay-v7-0-6ae392eca08c@vaisala.com>
 <20261005-max310x-rs485-sw-delay-v7-1-6ae392eca08c@vaisala.com>
 <20261005115737.3a26240eadeff00262e920ff@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261005115737.3a26240eadeff00262e920ff@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0006.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::6)
 To AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|DB9PR06MB7867:EE_
X-MS-Office365-Filtering-Correlation-Id: e2601663-b97a-4f8f-d9f7-08df235f2669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|10067099003|56012099006|5023799004|11063799006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NObWffUVrEHK6AfLf7ex3VLTrhwquVOoocRpZY15KTLJzHstsIckOPh30cu2IuUvxZ6f14tfKAZWDgFJPruk7iUx43iv4C79yTrgdqX+YWP1XNMd+IvtpbiSL/GcZCekiN1Pr2uUlmCMt2qj8RhIe6ZUAU+YGs5207y/FpW1sZBfmwVOv6LnEQKFS+AAW3w5BEaEqziasADWgm6WddDzY+tQXbHizL0R+mHGHwpsDAFo8l6kHyqE4ebDakff2hE+mZQv15CyxZeJKB8FoO7OyafSnZ7HiKVlaz8TWgEJ/PMjIeOebIzweDrG5LJInexKkFJ+j10oZJtfM6q/Zz5tu6GuvpA/2H6OF8QtNYe15eC5D2+6WsyEa6KblCUTW4zfVHy76Fywo8U8MV96tg7L2REC+csQx8qoivrg2gLXKw28sxQIuODciIEVzwBM+9Y23qTY1gT4d8NIlQ7pXukxduo+LnhEyu+l+/YgsOI9xvL3s04pHOP6KpigvyFg1GT7BRuEimg99b0KYaBHfF0VpJ8jdi24RBL4iO9ol111uOjF2adTV+KOgopyReWimu0ahIGltXnVlRZs63aI5LZmx4ASOZkvkFSwRqsbd0Ath396x+DVcnEjIErFL3TfHavEs/TjYygznl/bK5hMv9cSAtgzGxGoVy2HthxmtZsgELY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NU5WbXUwcEJUVVpCOVIreVhIMnJZM1BWZ05TNW1wWGhKVkZtSlpNZ0srTkpz?=
 =?utf-8?B?bEM0OERuc3VMTG1oRSs3T3FVN21LZ3M4K2k3TXU2elQwb2pDekRiZ0ZPQUhk?=
 =?utf-8?B?cHRKQTRNMkI2cFFSZEtQTzh2aUVkZFhITDNqUlNEcGN1KytSTU4zL250b3Fh?=
 =?utf-8?B?Z0JiRGoxUVNIdVdYR3MzUm5Qb082NDFBRWlGcXAwNERLdzQ1Zm96M0tWaDM0?=
 =?utf-8?B?dXVoaCtyNFhSM3d4WVRsVWdLbmYwTVl3cG9IWHNFN3NZS09EK05nRHNuZUdy?=
 =?utf-8?B?aStWRVhGMWpNd3dWSEh2cS9ScGdhd0pwQnNhTzlHb3h6VlNKRmdvaWsrVC9S?=
 =?utf-8?B?a1l3M2xLbGlJSW9tUGtsaVk1bTJMckdDOUZSeDhkT1Yyd3ZTaU1xVThlcFYv?=
 =?utf-8?B?bFhKcVo5T3VZUTRTKzdiMkNvblVMMmFaQlUrWkc4bEoxNkY0TXFPdnJBS1BG?=
 =?utf-8?B?R1JYVVhQWERjbnpOQUpKWVJVY1ZpOVZPcUlJazJzRGRMdjV5OFlwNW5MeGgw?=
 =?utf-8?B?ZFRUeWhUanZsbmxPSnRyWkNUVjdyU1FCdWx1Q1lmTzd0M3Bmb3RVWENOUWpv?=
 =?utf-8?B?MEVsZ2JMVmFHUWQyVjVQNHRkeWkwTW9sUU1EVmlwekdTODc2a0YzU0VuRERw?=
 =?utf-8?B?Y1hRTU1FTWZuaGxPUzdnVFc5T2xNNUl2dWpsSzFWU2FhVGRUYWVWZ0VPdVFl?=
 =?utf-8?B?S1czZWFieDA5VU1YeDd6MUNCeDRJNHptOVFUdzVrMThLTWxRa3RtSTA3RUFG?=
 =?utf-8?B?Z3l2ZVNHcTRsSWVQMUswUHZLR0JVOUM5dTJtdVJOK2UrclA1VWlUU1daOXNR?=
 =?utf-8?B?L3pydytWMWF3WWtkS1p5Z29LZjdNTkdwZldwU09wdm1tVWE3aDMraUNGQXVH?=
 =?utf-8?B?aml2VWVOV2VZcU45Tk9FTW5scVFKRWM0bWozellXUkg3TmJtUC8xcFJqV2pF?=
 =?utf-8?B?ZjNKcFFScXVFVGJZOXh1Y3dReURuUm9MWGpGTnZyb21CaklpVm1jbStuUTNw?=
 =?utf-8?B?U1NnOVRhYzQzWVgxWFUvbXdVdmFza3BUWVVyM2dOMjBhOFhDMTRMdEVtMVdv?=
 =?utf-8?B?dSttbDEwMi9jNC9WYWJYVDlwdDVLZFdjaUVqNzZuamFWRzR1c3BqOEMvVnNJ?=
 =?utf-8?B?dWsxMFRZT01JRncvZEVxWFpFUmlheHFNbCszV0s1SWp0RmdLbkZXMWRPVE11?=
 =?utf-8?B?aHFac1pHYk5wL3NGK21DSzY0Y0ovS1dyWDFhWlB1b1Iyd3dSY3V1L2ZHQWI1?=
 =?utf-8?B?N0hzb0dYYWhxdGpGOVk5djJVeEhjOU5VQ2VtRFpJaTdlUlRGNUg1TGh5WTR5?=
 =?utf-8?B?ZlNleS9BM3JEN0hhbG94SkwvTHNCY0twR1M0YXBneWxGOXQ5SVlrZkk2VlNQ?=
 =?utf-8?B?U3dpVUxaTm85SkdIVkhHdXlnTHljdGxhbzNic294bzJuaE9rckV0bDBmRC9S?=
 =?utf-8?B?QjFuNWhuOFdkaU5vbXh1dWV5K2NIdXgxQnVFUVYrN25RSlNiL2pQNld2MW5l?=
 =?utf-8?B?T3NyQWpqeVFyQnlNbmpKcXA1ekU4ajFTSW1BUFJINjQrVmY2eGZ0eFF4eUpt?=
 =?utf-8?B?OENOTDNJZzFYeThOMlJlVlRpUkdiajU1Wk1xNUxCTEJRVmM1R1ZWeXFXdmNG?=
 =?utf-8?B?VjJQajdqbmtaYWFaSTE0eWtZOE9NSW9iaE1jbFdvTmQxajVidXdNMGkrWDdy?=
 =?utf-8?B?NVVQUGlTVGN0RkVPOEFkOFdiTHhVZ082YVorNVNuZUFvYzNjUkNpTkQ1am5n?=
 =?utf-8?B?OXNEcmhqVDVBSFBlcXFQc3N0RjZDY1U3WU0vTEFIOXJCMkVtd01rNHdpbm9x?=
 =?utf-8?B?UzlCVzdHVUZiRjZNU1pHb0tSQWhldE1lZGJ4YWNsUnZhNm80OHN3cktoSy82?=
 =?utf-8?B?eHZlTUdDMGQwTUpTZ1V6cjFiU2FmUzlaVzdvb1J4LzdpV0VjRVE3blZweFBU?=
 =?utf-8?B?S2VvSzJyeG00b2RZTEtYSHdqVFhNRnBMNHM3MlRaUkZYUDIyU2p3VTgzNHJ5?=
 =?utf-8?B?cXlJSCtUVER3dzgxK2JPUGFua1pySCtoQ0lTampzQk9wdDhpaWUxZTJMSDk3?=
 =?utf-8?B?QksvcThVTTg1K3B3THZXNVc5NmExU2x3STN0Zk96TExnNTlIdUtXVXNkdEEy?=
 =?utf-8?B?S1BQTG8vVjVtMWV2VHAyRG5nT2xxanYzQnM5ZWsxTU9iUGVEYzU5SzdBbzhO?=
 =?utf-8?B?OGMvTG05UmlQN3JSOUVWN25FYURMSVgwYkErMGZ6YVNiRmVHM1ZkWFlmTHE3?=
 =?utf-8?B?ck4zNGc5SVgyUHlmUXN0VzVub0t1QXV5SEM2cXRjUkpPU0J1dE9NbVBlcUU2?=
 =?utf-8?B?V01kSmlOOFIwWUxhQkRVbmxLMUt3WnVuRldYRUZOZFlvTUg0eFo0TmFhOHhI?=
 =?utf-8?Q?MogZBn6LUgjypFdc=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2601663-b97a-4f8f-d9f7-08df235f2669
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 04:06:08.5514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQaYl1YeZZP9CSs0Gnzio5g9rnoi8Xbac9d2p09CjgQvat/acvJaibuDE9oV5b+5JSc8Cuol6fEc2q+KOZL9czlxi1Ze1gQcG7GNVmZVF4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB7867

Hi Hugo,

On 10/5/26 18:57, Hugo Villeneuve wrote:

> You commit message indicate only part of what your patch changed,
> but not why.
>
> In this case, IIUC, your patch prevent ending a preconfigured
> TX break when calling set_termios()?

Yes, exactly: a break asserted with TIOCSBRK must stay on the wire
until TIOCCBRK, but any termios change landing in between rewrote the
whole LCR register and silently ended the break early. The second
hunk covers the leftover that fix exposes: nothing clears a break
still asserted when the port is closed - the unconditional LCR write
was the accidental recovery - so startup() now clears it, the same
way 8250 does.

I can reword the message for a v8 to lead with that user-visible
failure rather than the register mechanics.

Tapio
