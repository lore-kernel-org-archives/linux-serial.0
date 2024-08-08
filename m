Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD118E056
	for <linux-serial@vger.kernel.org>; Thu,  8 Aug 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723132752; cv=none; b=Hqug0TxeJfY8QJGumFKme9CiomaAPH/GXfOikmzxZHBrln3Rn9lu9cx+26ZkC6ap0wLnZfuN44ilyypuTqyb03VhPwRhZTIIAJCW8ip289n9giJ/o8JfhsiNJfv5hwk+vYwRYn6NlrIesYzhi99b4BtaaMp2EYMNItS5VysJfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723132752; c=relaxed/simple;
	bh=eij8w6Fhg2Bfr6vouqrngWoYaxy6UiTAW14FH0A+C9Y=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=EJ+BQ3YiDaSrt1n+Gw7CziygJhKFVucxHs9VDYs8q1fpe71QdHTy8OB1u5H8J24Pv3Lkcx7ocy8omNOsWLM4W1jYAn4cWaOaKRtbT4yypzRH13Px1wj25rl9x3h7iAgR63lstsuC7lpoi0hjk7iW8/gZn+UoXCNxGtnhJBZyEMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=Ik1oWkDu; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="Ik1oWkDu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723132748;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DE2Z4JHfOIqMneh7wvwrsaGhwtMwfQT8hPB14RzG3dc=;
	b=Ik1oWkDuCRRt2IyKQIXTcUF+WbnQ4Ei9kwFXTAw+1ZiBmifOvnEo1CxPlk++0GPn564RM6
	UI1ZUhPZzZsyuplOD3xb1YzfsaQ8a6uZI82CvijY5+wTtVqW51eD3RUclBQl3OaHaRxUgZ
	DGsWGHh3HmpwIVQjDNZtyqDBUym3Lqg=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2041.outbound.protection.outlook.com [104.47.85.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-258-1tv8Uhf6OvunzEdls8ia4w-1; Thu, 08 Aug 2024 16:59:07 +0100
X-MC-Unique: 1tv8Uhf6OvunzEdls8ia4w-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by LOYP123MB2816.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 15:59:06 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.014; Thu, 8 Aug 2024
 15:59:06 +0000
Message-ID: <5973c217-9979-4107-85d1-be1ee342c950@camlingroup.com>
Date: Thu, 8 Aug 2024 17:59:04 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>
References: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
In-Reply-To: <6bfb7abc-0264-440d-b0d6-6dd6a8b64b5e@camlingroup.com>
X-ClientProxiedBy: BE1P281CA0328.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:87::20) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|LOYP123MB2816:EE_
X-MS-Office365-Filtering-Correlation-Id: 15bfb27f-38c8-4980-d0ef-08dcb7c307f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3ZKTHMyVGVjbDA5Q0FJNTIvanU4UDZleENabVVHaGJtcmUrWjhIMkowSWZ1?=
 =?utf-8?B?NjlqTnNYYURuMlVMWjE3U0MrcFBlamNEUGkycWY0bDhIQTd1WXdTTW9WTW5n?=
 =?utf-8?B?YXYyUW40TjBNRkJnZy91bkx5ZXp1ZU5KcVA0RmxjT2NtaUFSM1hPeGFJbEtj?=
 =?utf-8?B?L3JOZjhTckxMNTRDSk9MZUxuQlYvaVdzckUwSFdlblRiZzhYYmdOZVliNnU0?=
 =?utf-8?B?dHQ3cDJOZGdtT2NobmZTaE5lNk1OVGZEeHlldHhMc3BpczdFaFcyVG11aGUw?=
 =?utf-8?B?NnNwYjhYbjFMc1lPdFl5MzA3anhJTlR3U1FvSFNyYVhZR2c2NGhUOElwK09I?=
 =?utf-8?B?c1lYTDVMeDhvMm4wODhJNUk1QitycUVFKy9kYkVpNTdxVGNqeVJESmNabWtM?=
 =?utf-8?B?TERrRW1aMGFUSlNneXlpWG9JYm92WisrTXJHOGc1ZWVBT2RqSU4wZ0RGZXpv?=
 =?utf-8?B?YXdzYWFLdzY2S0FYSWZPVVNWbHEwVm1mU09OdGRxMG4xT09XM1ZMMmNDRXVS?=
 =?utf-8?B?UVJRWmwzdGN6N0hYNGE2Vm5ib2s4NTdpSXJyVVFrUXQ1RFFoNlN6WFJKYjBk?=
 =?utf-8?B?QjRRZ0hDc0hSd0tYY212TjdYWmZaUVhlaE1uczdHSmx5bXpKMU9vK0VPQWh0?=
 =?utf-8?B?YVA3Qkw4NHppM3E3YUFtbTBxcVFpU1l4VUFuQkwxMzZmY2IzQlVmdEVybUww?=
 =?utf-8?B?Y3NFSitzeVhQSGpKNVVLSjhiQUFmZ3NlT3pMT2NPSlhiS0x2OXlxc0ovVE9V?=
 =?utf-8?B?SnFVaElsK1NVL05KVXVTdVFJOW9nM2lud1hkd2tMR0VtRFluLzlqVUpTNmF2?=
 =?utf-8?B?MHhwR3NJdzJIOEdqcVZxb0lNcnUvK003b1BabHNLbDYvZUpxR1cwbm8rNEJx?=
 =?utf-8?B?Q092VWdDU2t1d3RySGpZaXR4dXJpMVBPaldKaGN1TmE4eFhxZFRoM2lPdXRJ?=
 =?utf-8?B?Vy9kNUkyU1Y2dGRCU0NWQWwxaTdEbGVHK2l6UzgzSEtTRVBRN2RSV2RiL2Va?=
 =?utf-8?B?UzVQRFV4enZ0M3ViUDhKc3Y0STlyVHBTVjVVeDU5YWovelhnVDF0YVkvU0F5?=
 =?utf-8?B?TE5Xc25TbzB0Uk1kU1pWYi9yTXNWV0NpRm5aMjY5dnd5TURzOUZXb0k5MEli?=
 =?utf-8?B?VmJUT0JoN0RjbVA1TWd2UUFoR2lYdnV0VU9LakhhNUJlYms4L1FmMUY3SXVj?=
 =?utf-8?B?c3lTc3ZVMTkzcGtuaTlCbXJaYVArSjJBTVlJeFpWVzV5Y0lZRklWY21KV21z?=
 =?utf-8?B?eFRiOUhua0d3ZnZZck1jOEJ3ZGpucnlldDFHU0h2aXBmMWdGblpFMjRERm43?=
 =?utf-8?B?ZDZ1NklEWnVnbzdpb1dENHJ6Q1FHRGtVVEFaYVNqMldzMzdOMUtjU0pMS1R0?=
 =?utf-8?B?bzhTV0szQ2RVTXJ2Um1zZmdsbWRPQkxiQU4zdW4rRlNYNzRKTWVlNHBKbmV4?=
 =?utf-8?B?U2xUT1V5QUFCN0tJTE9ZUHVNVFRrMUFoU1BzSkQvclloa1JIenpjbnRHV2N1?=
 =?utf-8?B?RVM4YkNDQTB4cDZETWd3eHMzcVRqVFYvakVsKy8wR2t2M0VZaHhlaDhQUVYw?=
 =?utf-8?B?Y01tWTlLYitaMnA1NGowT2o1R1BSZTZjRkdVQTlGSk0xS0xLdXJ2VmFsT01v?=
 =?utf-8?B?dmtvZ201MXZkWHhsdUJ6MmJ4dGFENTVRQ0FSTkdYZ0Y3WU84dmJzZktNa1dX?=
 =?utf-8?B?U3dTYkpvR3lLYnJhSnBVUlYzSkx6bHpBVWpJSm00SHJLdFRZVTBVZVk4S3Mw?=
 =?utf-8?B?RDRVTEpKYlV6RGpnYTZ2a0tPd2lvL2ZYQzlDS05TcWtTTmxuamlzV2lEa3dh?=
 =?utf-8?B?eldid3hSZlRXUkNWL3NPUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNxcmpJaWJiU2pMTGZXbFVSbXZTb3RvMjZDWERkVGtHMnZoajUxTlRmVGd5?=
 =?utf-8?B?T2R2UDVRV0FTb2lnTE94azNnS2dTeTArbS85Vnhua1JUOU13KzU3RmhlaVBo?=
 =?utf-8?B?Z0c5SzJ3akthQnVIZkNibE4yRE9ZaW5NS2hBSldRNG54QUIzOHlqWnhUYlM3?=
 =?utf-8?B?aUdrQzFPbEt3NGhrN3FvK0UwRkpmUHhuNHhqOUp2WVVPTTdWZXF6THBFeldy?=
 =?utf-8?B?bFhxUlF2V0hXQ2hSWEp3d2ZsSEo1QnJaTWJRZ3IvdUplL0NOeXdhcVNVcnp5?=
 =?utf-8?B?emhYbjdmNyt6TDU2UkhMR1dBQzcyRVpoZkN3SjhCWWRIUG05WWRaa2NiRUVy?=
 =?utf-8?B?M3RncS85WUFrallpbWRzRHJzU2p0czNNS0pIbWlFQ29RNDJ3YUtyNlBMT3VC?=
 =?utf-8?B?ZUd0bWZ6WTlkN0cyczhxR21pV0crbThja0tMZEliWVpwNlhhQm1tUnZPSjgy?=
 =?utf-8?B?VWJ3WHBBU0tUOGJWbEJOTVlvY3lGbUJ2ZGozZTBwVC92ZzBhVXZpNDBNMk1i?=
 =?utf-8?B?bE5idDlYdkNBaUpTbzNWSlpwTnVOZEVEMEtpdXVLTVlDNlFIN21NWkRMMHlR?=
 =?utf-8?B?UnZaUTd3NU1GSGhYcW1tV3N6U2l1Z2dUQ1RmVUk1eFJORkNCSElyTHZaNXNI?=
 =?utf-8?B?dTdjWWNSVWRIaG5FYjVHdkRqSkdzL1VEQ1llZk9uVVZTRmlKU09Qc0NEU2dR?=
 =?utf-8?B?dFZVQnF0a0NQaS8zc2VEYzBTOUk5dzBIcXJmcjlRM3RzbEpMRzl0cWFISFA1?=
 =?utf-8?B?ZU84aFBSVnpNbWc4ektCZGptL0xqRFhCOFF2MzUvTUhNRERPaVNSeWR0cmlo?=
 =?utf-8?B?V3V4QVZHdlBUbDBOVmJxbFg5QVJYOFQ4dkw5Zlg1RFFrdHhpTUFobHhucGhK?=
 =?utf-8?B?Z3VNR242bmp5L1RucUd5dDU2SGJ3OVdJY0YrNjIzenBNdDhwUmVsOWtvNFQ4?=
 =?utf-8?B?Y3hhUXhvSVdBV3U4VEdYdVo3V3o3R0NtUmx3K1k4MTFHU0h6U1YwUjBhekRa?=
 =?utf-8?B?bENkU25CaWNYWHNSV1pEVGpRS3RTUkJnVjhESWlpM0hrR2xSWUxlcEw5NWpp?=
 =?utf-8?B?U1RiZ2tldDhWd2kreEJlV29TazgxWnlETXJWbUVEdXNZSDNxNnVnRDlvRFpR?=
 =?utf-8?B?dHc2R3kxMGNCRUh3TXdjRlh2UG12bktSZkc3alI5Q2xNOGpmMmlGTWlwZkxj?=
 =?utf-8?B?ZHhEQ1pIWmNNM1RuSDd4TDZ1UmQra09LVEhFUlUycWI4Q3U1YnZPQ3lhVitn?=
 =?utf-8?B?YkMrMm96QkpSei9nTHBFRlpFN2VxT2E1MmJaNFJYOFBkNE11c3hsdGx3aUw3?=
 =?utf-8?B?WUkyeXhpWU5iWVYrek0wdEcwQjdGL1NnbUpURjJEc2NCR2VBdjMxajFUVUF0?=
 =?utf-8?B?b3RWQWpvVk9ndlBrM3prVW9kMENqclduelczb2VGR0xORWR5d3l3Z052cnVO?=
 =?utf-8?B?RnJyRjJkc3RXTkl5emYrdVRSMERMbTdxZS9ZeVNHSEJsUXRzM3BsNGpnV0Ji?=
 =?utf-8?B?RlhLREp1ODRhSGh1UzRFWXhTR00ycDIwamJOQndkZXh5T2pRYnhIZkhvdHVM?=
 =?utf-8?B?bVVZa3dibE9HVmVmdXpKUHJnRFZvcWRYaFdZNHVTVTc0dFovcFNiYmpEZWIz?=
 =?utf-8?B?dVlzQXZQQ254ay81bk1GQ2tuWlpkMmtxMTVpaXZLL2ZzMTRHTXdkeG9MaERq?=
 =?utf-8?B?Qm1qVDQ1VUtIQXFKc2JBaDloMTZuVWNMN1dXNGFVSTlUeENWY2dKY3VvWk1G?=
 =?utf-8?B?UHpVOEdnTlY3dkdEa0NTa1FTUklKdGRPTkQ1UGpYTUQvM3g5Nm9jd2ZDdFdu?=
 =?utf-8?B?OGgweSs3dmhKL0pGMzhMRUFyVEVscnMxbWxmNVMrZ2RFRU5LbUcrVUxWckVC?=
 =?utf-8?B?SlY5eGlTZVVjcWkvZWtkdVJ0eDRldVZKUUQrd3J6RzN3ZWZpY1c0RmRmU3pj?=
 =?utf-8?B?dUdvTHJKS2NFTGlIa0E3S0FrdlBtanZtMnVzOTYwTHlqeDYwTG1VKzkraTVo?=
 =?utf-8?B?SDVZZlVnbmE3OExoVWVPTWhPdHZjV3Q0MUZOa0hOR1I0Ti9TZk1QUitvUFJN?=
 =?utf-8?B?UVk3bWQrRWNYbk9CUU16dUQ2ZXZqOXlVa0xsUTIvSXhlbTNHMCtwc1BKUm5H?=
 =?utf-8?B?cnNidDFrUHZTQVc4MFFoUUZvLzhobmd3Z2RGVk10RW9NWExTYmI5ajVDQUVV?=
 =?utf-8?B?TTgzd2w0Rk54K2lRMmpSRXc0L0dJcTJIUnh1MGdOVUhxM2U3OUlSSmdRUFBV?=
 =?utf-8?B?dk81aEZTNXVyZ0FGTzZ0WTZtYXJ3PT0=?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15bfb27f-38c8-4980-d0ef-08dcb7c307f3
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 15:59:06.0795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q0HV1DsX5fJ2wXFZtPlq9dny0kBQ8qSuLkog0XhSfDXemqlwZm9YvEDPX4luXINP24ZqcV1Xii7Vn3BSDPUr6cUpB/x9WDlkLZYEZDt4Bo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP123MB2816
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This define isn't used anywhere anymore, let's delete it.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
 drivers/tty/serial/sc16is7xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index bf0065d1c8e9..8a2020f9930e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -207,7 +207,6 @@
 #define SC16IS7XX_MSR_CD_BIT=09=09(1 << 7) /* CD (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DELTA_MASK=090x0F     /* Any of the delta bits! */
=20
 /*
  * TCR register bits
--=20
2.34.1

