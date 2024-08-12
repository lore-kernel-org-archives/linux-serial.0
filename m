Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEE5187346
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 16:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481769; cv=none; b=ei4PZCFnlzWWvrx6Q3NfuFKdX17TYHaOs34nP2uVa0KhXUTZwEVBKW2zsfUHuNeo1rzPSUe87M2xeP8PPq1axPYfwsyEQw/ojJsnSWZC6mepg8Dm18c08Hmd7tiZ+QDdew0zOdVksN76jHFBEFOYEOGO6M7rHbCtXvgBrKC9HHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481769; c=relaxed/simple;
	bh=IFYyDrQlhaChM1BXR1Ah4KaIMTWjzxPm0nPaONhAc1A=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=u4bELbYgMTks2hPvdB0fHhQX8Npm+MMd7DpX3+I29o3mW5mq3Pq0EUXZfVLbMiHWDeiEogNMhkUF0nQRVJVwcfr/UJOKSXgP4WuoDVZtCszBoJMXC1ClHQTIEWG4iIBw1ZkVyHgYdR10kX+AlNC2etkQdBTyQDIS5Trwle7T75M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=aryckVxs; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="aryckVxs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723481766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TImInwuQeNn0V67c6QBik/KEYA5EfCsxmOHbDywLG6w=;
	b=aryckVxs+KFp7A7XEvVIytSC0+iJyYf0GWP6yDj9u9A2k/IqdrpSliGkg620+SfFPTyLeg
	izumvTmACw+h3TMT9xMFIPi3GirdDaAgzgs8yzJJQj/dv3PjOOF96oSIbrMRWUHr5fr34P
	g89Yyjinih8r2ZwuyjLy8TVCPNWPE8o=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2105.outbound.protection.outlook.com [104.47.85.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-32-wR5AI8hEP4iN-TpjWtDIig-1; Mon, 12 Aug 2024 17:56:05 +0100
X-MC-Unique: wR5AI8hEP4iN-TpjWtDIig-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 16:56:04 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 16:56:03 +0000
Message-ID: <497a8d04-665b-410c-aad6-e1a05869c744@camlingroup.com>
Date: Mon, 12 Aug 2024 18:56:02 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 2/3] serial: sc16is7xx: fix copy-paste errors in
 EFR_SWFLOWx_BIT macros
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
In-Reply-To: <16b7bff3-71ec-4042-a9a8-755f32b85716@camlingroup.com>
X-ClientProxiedBy: WA0P291CA0005.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::13) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 3166ec86-8d2e-490b-1342-08dcbaefa6ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDVacXBGeXYxaGYwamdRblVUYUxQdm1OSWcrZEJnTnVOdi8zSStkK3dmNm5R?=
 =?utf-8?B?aEJaNEgxaFNhbUpydFBxYk92cWszZ2U2TnpndGRHaWhHa3FxQit6Ymt1ZmVh?=
 =?utf-8?B?cnd2UHI3UHhUNndSaHZ2bVNpOEV5OXg1djJtNEs5OE1SRWRxbTB1amM0TlV3?=
 =?utf-8?B?YTdFaGZNOGxYOW5WenhtUHN3TlRoQWE1RzFyMjdUUzhWc3RkTjU2KzhUejZF?=
 =?utf-8?B?bWRMN2toZjVLZk1kU0JlejNkS2RtZzVIL3F0dDlmdmRZeEI1MVBWZk1vMW04?=
 =?utf-8?B?NFNGVlhHdktaMmcxVHBmYS9UZVAveTllQml2bi9mTnhtNW9DaVF6RTJhWnQr?=
 =?utf-8?B?dmRHMHlMd1krNGtCVFlJYXlDYXFmQmdPazVWazFMOENBTUJKV2VIMVc4c3R0?=
 =?utf-8?B?ZlYyTEMvdFpsZXBseldDdWNuVkhaeTJUM1hwbXI3S2wreWovY05qbWZ1a1Zy?=
 =?utf-8?B?Zm5uc1haOTF2OEZIVStPZnI0bTUwdTR4LzdyQytEbXdlVXcraUh5RTAveTgz?=
 =?utf-8?B?MzlDMTJaYXI3dm0wVzUycklYWGs4c0h6QldwNjgxMG13RUZ0YjdKNFluSGVF?=
 =?utf-8?B?bDkyNlQwcDI1MFEwYXN3NTVaZ28yaTl4MzV1Ymh6UXZTS2c1VDJEcDdTU0Rj?=
 =?utf-8?B?b2RHNzNQWERvc0JlM3hkNmp2T1JYZXJIYWRrZ01qbnZJRGdveU4vRnhvVXZp?=
 =?utf-8?B?TW0xU2Z1OEQ3OXlIeWd2Z1pmeUdIYzlLLzM1RkJ5UjdlSFh3TFJTaTJ0M1d0?=
 =?utf-8?B?VDlJZll4YlVoR3pXYTIrTXlua2Z1M1RoU0Jkem95RU8yNTBoTmVUNEFZTUZP?=
 =?utf-8?B?c1lUSGYwWXB5bmMzTjg3dTd6VWQ2SDhLUmxDcXU5ZXdQUDd5OUVJT005bmV2?=
 =?utf-8?B?N2NDc1E4aUpPQVIyU1VCWFM3SUpqT2lWQVp2eDNDOUsxakxFbjhqeHBoQkho?=
 =?utf-8?B?STlVc0J1NjN5TW5yS1RMOWNRUHM4WkVNbWQ3R3dWZDQzWElLa2JBQTI0UXE4?=
 =?utf-8?B?alBrRXJ3OHpGZjg0dlpkNzY3clJxdWZPb01rSkhKM1B0QzRhNHBTb0hYYTNY?=
 =?utf-8?B?WFZId0FFWUZzUms4cVlZYjA3SW1aZ1l3Yk10YnBiYzQ3S3pkdlRRZFlidksz?=
 =?utf-8?B?NkFzVWdyREtEZGJ6T05wSFJzbzRqT0NuQ1ZPNVU5dFMrWWVlc0ZXWkQ2blV5?=
 =?utf-8?B?TUswNFp6MUw2MWduVmZsekZ4N2ZObHlmT05hNUNtRUVjME4wNWdVaEpTYkda?=
 =?utf-8?B?YmY2ODhWQkR0bFVPNFQxZHBydSsrU25qVjRvc3hvSUsxSmxIVEl3WDZFOVlZ?=
 =?utf-8?B?NXg2U1JPQ2dGNm56ODlVT3NJYVZPOTJQMFFQbnFzOEUrNmtKVTQ5UVVuUmMr?=
 =?utf-8?B?NldHdUtkWUwwZkMrNGVmV21TVjZ4Qmw3M0g2NldKelNtY3d1UnNVOWhBaGdB?=
 =?utf-8?B?dXFzQlM4R21UbWxhSzRac1hoanpFcDBLOEJBL3gyYzB2ZDZ4eGpqWE8xTjZF?=
 =?utf-8?B?ZmhUakdzWVZ5eEdHd1oxNjN0Z1lub2l1ZXI3aDZ1c3d0ckRtdzR5ckpJWExa?=
 =?utf-8?B?YmJOTjZIb0o4ZHFGVDdBR25BVW5ubDdzaDhwL0lBSStiZWxUTWhUTzBPeDdk?=
 =?utf-8?B?ZTgvM2NoWXNDNE1IS3JHM0o1Vkc1MzFyMzlFNXRUVGI1OHlBd09BV2U5bTFi?=
 =?utf-8?B?SFZDZFBFdjB5UUhJT1FSaFVGU01Ham51Q1Fvd2h6cjVaNDd4bFU4ZjVybDQr?=
 =?utf-8?B?Tkg5ZG85U25PSlVST1hxV1lPOG5UdVptUUlJdDRRYWIrQ1ZKRDBPeUptVWp2?=
 =?utf-8?B?THRsSlh3eVkrWmM3eG5IZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjN6eEljRUpQUnFMU2Z6bEtDTk9rUml6M0oyaFd3VWhsRWcyRUFNMWUzQnNO?=
 =?utf-8?B?Um5GNURMenFqZkdVU0V1NGJ4SEd1UTdmZktlYW5hRjVQbHFHdXZJL0djcEFN?=
 =?utf-8?B?WUN6L01VZEZlNG9wN2RIQXRmVklrWHY4N2VUL3ZjRURVYVliNzc1MnlSZnZ4?=
 =?utf-8?B?Tmh2N2dXYVJiNHJ5cmdkVEgxM2Nsd3pDU2IzZHVxZElEYXNpdjlkazBDMVla?=
 =?utf-8?B?aHkwS3pFQ01sOEJIOXRNNFhlRlRHQU93QXF6V2xHa29zNjdoMEFFK3lpMnRj?=
 =?utf-8?B?OEdEYUtobWUwZms4dGtyWTZuSU5Xc1p2RHIvN3NOMm11U1o2aU54c0RFTm1V?=
 =?utf-8?B?ZlBnYWVrcFp0YVBlSk9ickpoenZzdi8rSCtvZmtlWHUySUxKR2t5NExKaGow?=
 =?utf-8?B?aUU2VE1TbWVHcWEzaGtsMmRsRjRhTnArbGRkRGJxdExpZ3JHT1orN2hndWF1?=
 =?utf-8?B?ZGNlRkVFSllJeUptNmZUVVlEMG1DckVnTi9VYyt0dWRxZEFTdHpEc21aTE42?=
 =?utf-8?B?N2hDNlZGKy9mdGpjeVR2ZHU5dWxENFVZUUtiT1N4dTJTUWc2aHlIWTNHNkpD?=
 =?utf-8?B?NmIvZ0VGSUNtd1VzNENLY2dRMVlleFJtNXNnTU1ZQWpuQjdmekNyTmNLL3dp?=
 =?utf-8?B?YXpFQXM3ZDY0OWtMemtGaExscFUvOEVuV3piQjJJK040WkZBNlEyWngrRzNt?=
 =?utf-8?B?RGVQQmJIVW9tdU8yVEJ3STRyZ3k1ZVNLb0xHNDI3NCt4R1V1YkdXMlU1NGYr?=
 =?utf-8?B?dWdZR0h0eTNicEJKRWpxTzN2cnJQUUsrdE5jL3pjdERoV21IVW9wN3Nyc3pi?=
 =?utf-8?B?N2s3Y0FScUlxcUl3Ris2UUlVYTRGWlk1bTV5K2pVM3ArUzBCS1MwYWR5aTZS?=
 =?utf-8?B?S2x6RjBRN2JDalZ0SUxKS2hXSVVWRW5CMDdLb3R3SjkxNTZtd0dJS2F0L200?=
 =?utf-8?B?R1VWUzI3ckdSakdiZmFrQ1ZGc3VSUzhDOTl0Z0IwSkZ3QXZ1a0FxaFNta1c5?=
 =?utf-8?B?SnFDSGgyell3dCszL0M4dU12d3RmUGt6NWFTWFJlVFl0bnJhcUFlMnFLVW9Y?=
 =?utf-8?B?QW5uRmhJV0huRnNnN3lXU1hVeFJITHRIbzhtT0hGbzRVOGFnZW5veDRlUm1L?=
 =?utf-8?B?YzcwelBHWU1oYjFEbC9DbWpZc3UzMjk2Z3RGVXhiNThObEN0S21wa3hYVmFM?=
 =?utf-8?B?ZERTemJuamg4SWxtYUVHNFpjQ3ZFdWpHMTBITlkyVmdmam1RNGVlNUhsRktq?=
 =?utf-8?B?MlRKdjhXNWdJK1ZHNUpEZnlaNGNzQ3ZMVm8wSXNKYlQxQ25scDRJUURHOFIy?=
 =?utf-8?B?d1BlbWs1L3FEU1JRMHdRMXg1RDF1Wi9NMkJvTVhEWGVKR2ZSaGg1T1RTdmp2?=
 =?utf-8?B?UXBEYWhiTWVkUEJhT3F0VVZ1TFpHWUt4MVBhZm9nblJqYmFpSFFHaXVabXhY?=
 =?utf-8?B?cnpBeFdvVVdXME5aZTZ1S294WnNiTEF0aFRxMVJQQXlXdzBkb0lYUEhvbFY1?=
 =?utf-8?B?Vi8xZ3hPVmVOT3k4cWdwNTdkbUhXalVTd05oNkppazFqazUwYWNCY3RJRmEv?=
 =?utf-8?B?L0Q1OEZOaXkvRFQ1V255N3ZkSHpMeHN0WmVyTy8wNTJoai9BQTMxU3lvb0RZ?=
 =?utf-8?B?OVVOT010OVFPR0daSzU3Wi9UUUYydk1zaFFyZEZuQXc5SXRsUW1pNjN2UDBr?=
 =?utf-8?B?ZDV4cWRSbWdkclpMdW5SWUozV3JpVDB6bkJLUStreUQ2b0hXdDhXUDVRVmgy?=
 =?utf-8?B?L2k5UGtJR2ZJRkwvRjRxSkdTSERvQWNwaStJazRhN2VjL05lVmxyZkNzVUls?=
 =?utf-8?B?VXljdEd3UDRjSkM1dUpuNE9wN1RvbXJUQksxSGQzd0J6K1RjMVNRZlhyT2tD?=
 =?utf-8?B?U1k2SmdXVTl3bDAvZjgzU2JnWXNLdzVSeHhvOEY5WWs3VTIzemNYQkhCTHFX?=
 =?utf-8?B?YXNwNWN1WWRvQjI5MHlJVytVdzdaZ0VZUlh4c3I0ZFY1RWhPV1pBZnY1aVUv?=
 =?utf-8?B?QlMyWHBlbjExby9IK3lpU2UxWW9IRXMrdVQ1ZmJobzlEU2tUQTFNS3dYNDA0?=
 =?utf-8?B?U0RsZ2NrR1hvYmh2T2dGbnlEWG9jSytkUFpGRlB2clVyVlArTlZTRGk5WjJv?=
 =?utf-8?B?ODR0eFo4QXRkNFJqZ2ZFc2lqeVJOTWlKVGlkN1dhY3l1VE5qN21Ub3FSamg4?=
 =?utf-8?B?TWc9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3166ec86-8d2e-490b-1342-08dcbaefa6ce
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:56:03.9141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aF0DeAYjz4PK5HC2wZacNusLrOX4tVKwF9D27ZOmPp36QLnSqNcFSEfjz9FSJaIUM6Pkv1UEgMa1MQYwoboiygZL5ZNKOwD39bl81dsIRRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6004
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Comments attached to bits 0 and 1 incorrectly referenced bits 2 and 3,
which don't match the datasheet - fix them.
At the same time remove comments for individual macros, as they add
nothing to the definitions themselves.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 8a2020f9930e..36b7c682ae94 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -266,9 +266,9 @@
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3) /* SWFLOW bit 3 */
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2) /* SWFLOW bit 2
-=09=09=09=09=09=09  *
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+=09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
 =09=09=09=09=09=09  *       control
@@ -280,10 +280,10 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1) /* SWFLOW bit 2 */
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0) /* SWFLOW bit 3
-=09=09=09=09=09=09  *
-=09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+=09=09=09=09=09=09 /*
+=09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
 =09=09=09=09=09=09  *       control
 =09=09=09=09=09=09  * 01 -> receiver compares
--=20
2.34.1

