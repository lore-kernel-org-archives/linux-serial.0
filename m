Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11023081.outbound.protection.outlook.com [52.101.72.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C715E239E9B;
	Sun,  4 Oct 2026 10:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791110756; cv=fail; b=T+URCvtYwKLISi9VYYM5RV5zIcNXCqocSfxRLZunqggBhp2dRZeP/1oJXIQM+r904bLG6uzoFUXqChkFEYSNKLrI1Rn8CGxlolTWUyGaDMeFfj6bxo98bvwOShSHbg6T5F14mYKT0CEjz5HTo/X4nfzDt9c5vQZcXupdv4aW168=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791110756; c=relaxed/simple;
	bh=Yz8V0pmIV8p2uOQdwF+gQGMXrobh0qQBEIJBB2mbjz4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0dOqBJhsY2m8T2ArSa2x2TXYmjqMvEpaV65VuLMVqDLo5HrFC912ji3wObjC0wlN78c7m34NKdoA6hs0fT2wgNe1clYoKKbe1SMi+/hk8PQuC47Tdmf+msD48+7D0uIpw+LhjN31Q0rzp384qNE0CHPlGGgXu7lyZfs06BAgLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=3QFSLGXW; arc=fail smtp.client-ip=52.101.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="3QFSLGXW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCA1sW4ESqoMdWgyan+5I3cWRQSDybwYZ9ijDkcWszLeiwis2VpnJw8480wSRNgwswzu2iZWHsEiAwwWXjdbuNJe38KOVGy/5NCEUhDbGpfFFn+XZFsi85bfZDXAsIdqsmrvANOksmiBYl044QXJHqM090wkgp05brjaKpnLwHFevGecNw/DSOmO+5bEY0rguOatNI0Ho5TRvAxH1wH+5yRxvU1ISmkDDzlRdopuT+qY28ONx6HD3W7jbx8X6WTpbP5+4ZiqpU6oxy/bk0a98M9mMWce0SH4rk2MrbmHjaw7+oYfQ/M0QPuOCJP1yS16TYdKbsvhJ+6a8GgxY6V81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yz8V0pmIV8p2uOQdwF+gQGMXrobh0qQBEIJBB2mbjz4=;
 b=l46ZklE3wrtvAFendtSKmNiQnomqj7UpAqiNEqE+j9318u5WOsINSDPFmQFumkQzP0cRz42zcf3jUvLNd/LWbVYZHihUQ3kcAlcOJw6opQ06okWExm+zTnByZYSthoU09S1nCj+vZWK8zXZSxcSEX+axmNQyPWlSN+smANE+jJNHLl94Tgmjp9tWyu06Qm5TpEn4NAGrl8HB7bR5P+55SSONLg/0aeRnmVMovAGhS0Y0tiFmMybdSz64sye79I70uoOR36QCBF8L4zq75LMwBqJ+7Py2bGnxQzYGBQhGzPHIi1C41ZOyKb9y91DVsuTzHVcMFUP3tUWPtZkPqDE42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yz8V0pmIV8p2uOQdwF+gQGMXrobh0qQBEIJBB2mbjz4=;
 b=3QFSLGXW5e/MdZvXMMPHE//0AV7gee0z0DCAZ2+2B8oP35NN0dbmFobyPHxOhQUj8MhMcDuio0qHhN0VA1GQcEPuyJatODQyNpvrch6S99ICKdPC3f9D4XokWNXdIG9d/+qrf/qykCcQNt9nxnjCMnH7Z30KGtZ9BlMK6PfkPLPdasrvIR36S4sCHtEef8kHBdsIs2Y2TES9ypPLtJQgKm24GFCcUAEp3VLMDHuKxLios2Qp3A+YjdI5Te4QZo0qy6kaS3BuM4xtAjzpfRP9Xv5Pwfd6YqbYwbQBg6QMTUut4TGXLnZBsDskYmfI7mfcBPaP1caTRowb1kX2BXQLWA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com (2603:10a6:20b:3a6::23)
 by AM7PR06MB6819.eurprd06.prod.outlook.com (2603:10a6:20b:1a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 10:45:42 +0000
Received: from AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17]) by AM9PR06MB7907.eurprd06.prod.outlook.com
 ([fe80::a597:33a7:d4e2:1b17%4]) with mapi id 15.21.0472.016; Sun, 4 Oct 2026
 10:45:41 +0000
Message-ID: <075c7075-d0bb-4980-a3de-749115a4d6b5@vaisala.com>
Date: Sun, 4 Oct 2026 13:45:40 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/8] serial: max310x: don't clobber the TX break bit in
 set_termios
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Tapio Reijonen <tapio.reijonen@kolumbus.fi>
References: <20260929-max310x-rs485-sw-delay-v5-0-ae46afa583f2@vaisala.com>
 <20260929-max310x-rs485-sw-delay-v5-1-ae46afa583f2@vaisala.com>
 <20260929094019.67a4d5e9f473134dbdd39d93@hugovil.com>
 <453bc692-8979-4e5c-a504-0b735da595d6@vaisala.com>
 <20261002110341.47799d87f9930a8e2a44e8f6@hugovil.com>
Content-Language: en-US
From: Tapio Reijonen <tapio.reijonen@vaisala.com>
In-Reply-To: <20261002110341.47799d87f9930a8e2a44e8f6@hugovil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GVYP280CA0030.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:f9::11) To AM9PR06MB7907.eurprd06.prod.outlook.com
 (2603:10a6:20b:3a6::23)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR06MB7907:EE_|AM7PR06MB6819:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f0fc767-faa7-40c0-0af4-08df2204a2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/3CuaeUe4sTCizDpK+f0WEDix3gL2DhVVwL9xNWn/CGfAWwctZuq3dgbRjLT7vezGbR2OhRWaLG2MDD2P+xXQVG2YQop0WB5oyhLJby+xNe6Df13EnYL+7o209kERuOT7BC0MGYXB+ZnWnOV5vxvNO6gNYDV1ftfSyNPEg87lBMrkiDAwlfdGWueEepy8RuvPbIc2QTUXf2yE17QX/PETwWiVBcj4Zw38eowzHIfFGWanCpBw0wFuhRKsn7E1zfUS/uf+sut8o4GJ6XIjy/kvG0Baf+F0BijaCRp7BTXizisT6VbGzWvRHuUoHpOvMHknxk/E6egOqUuhDD+KHK/I1GlHTAO5TYYYSHuQajKlvHFSE+mCP+Aqi32g70Ct9KIu1cIFaEopvYQ0TuvY4I1Whfc8V728TOfXiE5kBMPFeNT3cGC/EmteHCUf5X6D9HeEtB9ELqNSuPxPdlFadXQ3C1BZbAVdyMMf4oV9iIPG0QJoR+0bWWIoeBECX/qIPMvrOOJrURNmAPgIy1izI7RanJC5AzC8+FE5ljgqxKhzLOc1ARITcOsp8EV2mDRcsuOTQr1ilBha1MHCTGQBmYwGRZtw0DRBZbmXL7QZZSS/MoZn115yPn0Ps+m5vD6AP92rqYDCinoSOkBVWFDfYf4V9lgtCzdfTOfBs1QWw/emI4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR06MB7907.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QzQxdFRGTzVJYUpJcklXVWJRNUV4L3pId2dHWFFwK00yQ3lmdnAvUnhJQUlq?=
 =?utf-8?B?VzJldFBDZDZab2R4cHhYZGlHakR4WEpMVXdnVVkyT1JZalhoVE1XYjYwTFho?=
 =?utf-8?B?Y2dORU5kR25oRk0xVlhrN1ArZDVTMGdqZHFhWVRpclc1NU1wREhzODJEVzR2?=
 =?utf-8?B?bzFVUENhVE5PK2tTanp1dWN0U2RTNXpaOFltbHJUUjNTOS93enVBamFZQ3Qw?=
 =?utf-8?B?TThJWVhHTGhSUExNaVFIR2Vob3NKYWRWR1UxT3JVR3pCSFZUYlJBMDU4M1Nn?=
 =?utf-8?B?YW0rWXBrVnlLM2hwNFhLMkNLVmVMaXowa2Q5UDNUSndlWU9MR3YrMjFpSE9H?=
 =?utf-8?B?K1MzNmU1K1cwcmNRcnRSQlhkc29BOWV4YkdtaHA0TUZaV3VOMUxpeHc0TUFz?=
 =?utf-8?B?TXZOakgrZEJLVnhpZUo1QW9ubnovVEtxOVQwelpWS3hadGFzQngzclV0N09m?=
 =?utf-8?B?N24zYkNsclpJUkJETzVZMzc3cEN0TlpJaVJSMFAxdnRyZGtwWGV5ZG9WcHhF?=
 =?utf-8?B?bi9yOXBZU3FBMmMxVXlJZ09CKzdzbkhQQS9ydzFWTmVZWkNSUUthVUxobGwv?=
 =?utf-8?B?dUtkL0xHQ2UxUzdSWUZRWkErTWxZRlIxRG9SRHpnSFgzS1V0blo1Y05RaWdB?=
 =?utf-8?B?ZGZMM2ZPUDIvdEduQTRuUGhGT0toS0JjV2RxTHlieEdNbTJvY29oYThzUzlR?=
 =?utf-8?B?dDhvS2dhMThFNnZnQjJjNmlOWXF4U3NUdFpDaWlvNkRuMUs2S1VGdVZzYTVm?=
 =?utf-8?B?Y3ZaUVFveXROWDh3azBDNTA3Y3dwbUt5TGE1UHRzZFlEa2ZoUFQyenl6YzE4?=
 =?utf-8?B?WjJ0WDhoY1pQOTBmVHhKcmM3THowczJpZVh4WWxGcFZLdUM0TEFVcjZrQkth?=
 =?utf-8?B?R0hjS2IxSThXd0Y0NTlsRmpPZXI1K2M4czJsSFFOU2VYckdpdlhZUHhBM0FY?=
 =?utf-8?B?ZFhMLzFiK2hCMml3RlBwU3VXNkRhUUpLZ3Y2VGl3T2l1VEl6UGZpMW05eFlm?=
 =?utf-8?B?SHkzTitkazVFaEk2d0J3eTNTNjViQ2F5NmUrSnRtZTZvT3hSRzF3dUJYZndr?=
 =?utf-8?B?S01TMFpoYjIrOVI4T2JxM1FSa3lLK2xxZElHOW5GRmtVZHJRaFZoNm42UnM3?=
 =?utf-8?B?TTljelJyNDZ1N1czQlpqUzBxb3IrUERBMGZnMkRpckltNVdFMjNqa3k1UzRl?=
 =?utf-8?B?SGZlOFlTdXJNeWVEVXVCaE84V2VVVm9oQkxjSHlhNDhpSEJxQUpUcDBKS0lC?=
 =?utf-8?B?R2ZBR1Jja0IyczdkWFhaM1JzcUlBTjc3TVU0alZOK2Z2SE81emRlQU1tWFhF?=
 =?utf-8?B?bWtDT3kvbWRON1NqMmpReU9QSXhHb1k3OHdieEcrUk00ZE9JcFVneFlIbEdm?=
 =?utf-8?B?UkpyMkFhd21Fc3NuSm9YMkp3djRxSmxyaVFKcmpuaGNiR0I3Y093RXRGQkVZ?=
 =?utf-8?B?V2RUVzU2THIyVTNIOEtjdVF4TTRBZEpocjNwYlc3Z3NwTlNuY0pDYmE1em44?=
 =?utf-8?B?TUNOMU4xdVRwNERMZTh4QTlXUFdPbjZQS0FLaHRERjI2UEVZUkY0N3lKS1cx?=
 =?utf-8?B?ZE1WaGxlbThHSEhzSDJHejQ0MExZZldUV251TnYyTzUxM0hXWG5vWlBqbmY4?=
 =?utf-8?B?MWVQNTFpbWpRQUR6RXpmaU5sSTJydFFTWEtPYUNsaGVyNmU4aDBIRmhQKzJp?=
 =?utf-8?B?cDZYU0cyNHF2d2RkbmpZdUtjUSsrYmJEakEvcCtHMFRyS1c3SENhZVk4b0lr?=
 =?utf-8?B?MHpBMWQzWmJmMENXQkVIQ1BlUUNoS005YjFueExOdTNNKzUrcnRxVk5HYmE4?=
 =?utf-8?B?eWdFUGcxV0IwZ0VObnMrdThwM1VTZTFFLzVwUWwrVnJJOFgramUwR25TU3p6?=
 =?utf-8?B?Z0NTQ1JONHgwV2szeEhZMTdCeHovK1BLM1JhL1ZZbldTTE02VnU2OTNuTlFj?=
 =?utf-8?B?aWhIY2pSVThRbzhuSTFaYmlVS3k4S1E3VHBZRGpMMDJ6cTdFdlRKYUNOT3Ru?=
 =?utf-8?B?dVBMZSt4UU13SUVWNUlFR2l2YjFjYW05WWpTdy9aSkhtK1o5b0RMbHUzQnlx?=
 =?utf-8?B?eXBTbkFGVUZTQWNGdUxSZ1cwdi9ZODBmS3RYSnV6dktwNVhseU9zQzV5c0Uz?=
 =?utf-8?B?RVNaNWJPakFVQTRLSmlVZUY3WkhpYWtEWTJsT1drMHk4MUN4TzBqZTBpL0tz?=
 =?utf-8?B?alRlUFI1TW56bzlITTJHa3U3RnZKYitJNXRvK25PVFNlVXVhaEhIY1JYeGRD?=
 =?utf-8?B?dk5vMVlpRGdDWVhFNXJwKzI3Zm1zZWx6bDZza3EyVU1FcEs2ZG85VTE0MVNk?=
 =?utf-8?B?ZjZXbU9CSCtOR0Vrak5VVW5hVS9POU1Oa0FodTAydjFlTVpkVXZCMmRZdUF3?=
 =?utf-8?Q?YgNa8/MZ0N6LUfuo=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f0fc767-faa7-40c0-0af4-08df2204a2c3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR06MB7907.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 10:45:41.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C1sm3HGXru8mrbG8Qg1AWVofkqjBZg35+VwfbDJonlf2IOiGR4WvA7YtmcwhTOvpWbD4l5fbwONN7Orr8OhOMj1qRPKW5R2c0I/BcIYbE0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR06MB6819

Hi Hugo,

On 10/2/26 18:03, Hugo Villeneuve wrote:
> Ok, so if I understand correctly you mean that max310x_set_termios()
> overwrites the whole LCR register?

Yes, exactly: it computes the word length, parity and stop bits from
termios and writes the whole register, so the TX break bit (and the
RTS pin control bit) are zeroed on every termios change. Your phrasing
is clearer than mine - v6 will say "overwrites the whole LCR register".

Tapio
