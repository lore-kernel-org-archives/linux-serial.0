Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D73D2B9B5
	for <linux-serial@vger.kernel.org>; Mon, 12 Aug 2024 16:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481698; cv=none; b=soTNZLYSb+Ia5ZgNKDMOBmDJr1nBd3nR7XFf5BLXxkkkuABw4RIntqKRRdeFFT/a7r+Wqk7TFJOUhRW7LShWSUdwgdqpEtHn7CVGql7cOli7sA+Xrf8pmxpG5hJC80apwNUl+q02K+CZOZuBpHuZ31/kj+HPJRTfjknKpf6hPjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481698; c=relaxed/simple;
	bh=74cmuXQyKQMY1F1bPCy1W6XjlRjNqu78NXP77nLThNU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=P5TlOQubpDPv7HoBD92pmUZzkHI4m18eQSMLUkvn7EBrYAnM/hPklBmNOnixXE3MyWTzAtXjQlBDimXwVLbgW4rrRjS/sRHrcDc+JCePvRhVIeEA1fKICik8wbsoUaeWWl0geCJv1/0CyjoNiK3GwkD5tszFcJ2opt5V+c0ulJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=kNf84Zta; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="kNf84Zta"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1723481695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIa7EUVONlUwLxTX5h8Ao+TJ2uqK3rhOokLSZLQxcC4=;
	b=kNf84Ztayj0ffMgC4NcmyVflKYehwJSA0XLNhz4QgT0gRPxGUW+HPh2IQ9QCpKH/x0MXhT
	brrqZksobLphBZjtq2zt/8/yWmXEyanzchwHaZRdafzinMPbNvgeqFEsR42wmq0D737ZKX
	XI3CNr8P99aqWWM9ruTVIBwaxGQIGNk=
Received: from GBR01-LO4-obe.outbound.protection.outlook.com
 (mail-lo4gbr01lp2104.outbound.protection.outlook.com [104.47.85.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-272-btZkcbUuMDKlhAWbELXEGw-1; Mon, 12 Aug 2024 17:54:54 +0100
X-MC-Unique: btZkcbUuMDKlhAWbELXEGw-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1bf::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.19; Mon, 12 Aug
 2024 16:54:52 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%6]) with mapi id 15.20.7849.021; Mon, 12 Aug 2024
 16:54:52 +0000
Message-ID: <f1e730eb-1804-4a31-a4a7-1717330d3525@camlingroup.com>
Date: Mon, 12 Aug 2024 18:54:50 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 1/3] serial: sc16is7xx: remove SC16IS7XX_MSR_DELTA_MASK
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
X-ClientProxiedBy: WA0P291CA0006.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::18) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: f0f78f06-772b-41fb-b09a-08dcbaef7c64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016
X-Microsoft-Antispam-Message-Info: =?utf-8?B?clZtaTNFM29lRStBczFkem1QRytBUzNWNGd0ZUx5VUFHSExYTTYyNlF4dGFC?=
 =?utf-8?B?WTF0YlNvaWdKcW1ReTluMHYwZHV1dSs5cldJdy9qRC9jeWkvZml3YWgxN2Qz?=
 =?utf-8?B?eGIxclRVMDEvU0hSWUdOclRFdU9FRVI1dWpsUTk1OUVGaks5NS9lc0VtTm9l?=
 =?utf-8?B?TkJ1aDNXaGc5dXg0d1JhWUNXQzVRR256aW9kbGpSUmpxSEpyby9iQzF5Tk9s?=
 =?utf-8?B?ZGZEY0s3bHFOa0l5VG5Xd1dGQXIrd0JxcmNZV3E1RHFDdzU5T05sbHRDaVE1?=
 =?utf-8?B?YlBTZFRzZ1dxWFFuZE5tMklQblc0b1oySFgydFNIODVhQTQrMGwrUnFGV3ZX?=
 =?utf-8?B?eXF1UDlwZDFrMURzK2UzTzlnVG1wVmpHKy94RlJjVk1KMTBYbkFhOGRLYVlH?=
 =?utf-8?B?eDc1RGF3V2I0UVRBbEY4WTZyNHN4dlpHK3J0YWd1SDE5ZEpRbVdqOWUvaG9Y?=
 =?utf-8?B?MzhsVk9pQ05UMVhJTW5WTjdjWTBKbVhaZnFuTzhIRExVSE0wVFJHWlhoa2dw?=
 =?utf-8?B?Wit5NGxtakFFTjVhRTFqMm9pVmJXakpKSEFxZSt2K2k1Y2prWktPWmtqOXB3?=
 =?utf-8?B?OXc0WDJqOWNtYi9rODNyNkxzbWNRUFM5WU1pU1JOSkp2OHQvOHJtMWgvQkgy?=
 =?utf-8?B?UHRmQmJtcUdpZTQzVlY5K1dtK09HdHg0dDRXNEJUdW9LU2xGSjBjaDYwRUhr?=
 =?utf-8?B?Y3VYTWdUemJUYlJPOXZETEpyeXJzR3RHSEJQMEpTNlgrS1MwS0VQS1NVVk9o?=
 =?utf-8?B?NWtVT0l6OElYOTVNRVUzK1BkaXRhaWJaQk1DclJXZXJJb0dvVGIvZUpoSzND?=
 =?utf-8?B?amk1NGVURi9HUkFOZnpFd0huSXFRTUppU3NzSzducE9tU2phTkVRdFJxbXZT?=
 =?utf-8?B?QTBYOVc1MW43ZytqVHhQekllMXRoVEFET05qSm9QakdINUp6b2FKZkNWdUN4?=
 =?utf-8?B?Tjk0ME91d3dzbHkydVhhRXZ4NE1qbzNSNFBuQzVjbjBHT3h4SklsSS9wa2g3?=
 =?utf-8?B?OXpJeGxQL2VFMjVWNEtiVEt0c0FORnRnWnhmZ2ZtN3dHaUQwb2ZvSGZKdVlO?=
 =?utf-8?B?c3VhUEdrMUxTMWpqRWx4KzNIc0IyQjJoWlJ3MW95L3plUlYrei9wTEFlYzVI?=
 =?utf-8?B?ZTM5V0grWUZHcXphM0RlOEJjZlBGR1FQSHRid1FRd2ZPdlRNRlpaTjBqc2Jw?=
 =?utf-8?B?MVluZEk0ZVArVkNDZWRINDZPZ3VCYXNtS2hCZm9Cc1I4QWpnbUVBN3hTdTNR?=
 =?utf-8?B?Z1VIaWhtMkpvZzFIaDVNU3JQQWh6SU5vVmh5aG43VTN1Mll3ZXB0QS9kTVEy?=
 =?utf-8?B?R2FMWVdvNjhQWCtEQ1JNY1BLSmxKSlpqajROdjNMbGtOcitEd3ZJc0dsNVd4?=
 =?utf-8?B?RFNWYVNNYzVLZUpFYjRxRkwvOXRNSk1jZnlzUzFWTkpvbUo3MXgyTkVBNFZz?=
 =?utf-8?B?RE9TbjV0THhmRGRHcXlCY3J3aFJpODJvMTNCMERPbXpmc1NuOE0reWtqaUNV?=
 =?utf-8?B?VnpjZjFVVWNZamNjRUtQekF1REhYb25INWlIYTNoV09HTnVQazRvM3IvUS9X?=
 =?utf-8?B?QUNPKzA0YmtoQkpvbXhKRjNyNk9WaEdGVGZib1BpbWVtTUpTdkQrRFU1VDZF?=
 =?utf-8?B?TDhNV00vVzduTGVLSzU5ZlVPVjc4aURvYzl5NDBrNm9DcmhwdXpMK2M2S2Fq?=
 =?utf-8?B?Q3JNUlh2eUIxOXArYzRKQWlnLzl1bWpGaXpWU0Y4akRIZHZBM0dFU1Ryb0dx?=
 =?utf-8?B?YXhGT3FPL0dlRHdPM00rcXI2emxuaTYzQm12bXF6TGFCREtZdzVRQndpR0hX?=
 =?utf-8?B?TndDRUpuSmg3NHMxZjJkQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFB4RWlyZk1tak9GemdDRWhYaklicHIyQmt6YzN1QzdmbGpHWFhhRWFxeThk?=
 =?utf-8?B?NFVpRlJHVW9pTHY3cVN5bmN5Z2Z6YTFQV0Q2QlZUWGtlQXdNL0xNNVMydzBP?=
 =?utf-8?B?K0MxTHdNUVlwdmxYTld5ZUI1ajZPdTB5YUFzaDdrdmJoVmNhallBSWxjZVhQ?=
 =?utf-8?B?bGNFa0JBckdtQW1kdGxvWjUwcDBhUXNWOXpSZS8zRUxnQTAvazk0eUwrZWVU?=
 =?utf-8?B?M0VQdTV5YTIyNFhOYjB5MG8rTjJFNkVaS2xPZ3ZuK1gxSzdXQ1RVa09wWW1C?=
 =?utf-8?B?b1g4WkpkbnViNHp5Zm9jK3hDVy9ObU1FWWUyZVZtSm4wSVBtc3RQYWxPdWF1?=
 =?utf-8?B?OE0vem50RVpKM1lwcXpYMHlmTXFBL2hEWm5kOWlpc1VnSVdONWFBS2pqNHh1?=
 =?utf-8?B?QUpaWjlxVzV5dCtvOE9USUpzQlQ0bHh1NFNnY1RpQ1hoYmthM0VHNG1FWm9h?=
 =?utf-8?B?Z2FUVUwybEE1SmJwVi95dUdBRklCNy9MeG5pcnBHdTJqN0ZLTnhLcCtlTVVw?=
 =?utf-8?B?djNEQkZDZlBFYkNtN1FISDYyL3FPYzJCU2wzdlNadWZleUVtUjR6WGxlQnN1?=
 =?utf-8?B?SHY3TWRSejVMbnVCOHNOZ0NBWS9WemI3QXVrcVhHWW8ySnV3VE1COTlxcWc1?=
 =?utf-8?B?VzcvTG9xN0QyZlpJNUJLVDFVbThncmJqS0IrV1FxS0NzQTlRa3pBaW1SU2tH?=
 =?utf-8?B?M1E2MG9Ja1c3YTMwNEUyVmRxN3ZqZWVMSEpCM1BSN0dQMlRJcHFFb25XajZj?=
 =?utf-8?B?eDJJT2IrMVJUeUsza21iUStpT0FtQzJqNVpMT21CdHZ4VW5ZWTBYSW43Qi9U?=
 =?utf-8?B?NDVSS0x0TFJPeDJLbURWVGVYNWJtUWVVTEZzRWk2aVNZaUZ3Y1BJVUhKWFhp?=
 =?utf-8?B?N0kzQS9rbFFubGNqbmJySkoybWVrY2s3R1B2OXVMTEZEWFVwRkorRE0rWXQx?=
 =?utf-8?B?YlhSaUdibHNTNU0yb2tTdHlLMXZBWDk1Z2wvdUs2STZISlVDdFBjM3hwdm1K?=
 =?utf-8?B?bEc1V0tYeitKU2JxVUQrSzZNL0dyMVJ4WlgweGVuVFRsS0FwQmdxdXpTU09Q?=
 =?utf-8?B?OVowN0RhUnJMQnlienNQWS9NMmI3L0FCcnNuRTlidUFieHJmMlA2b2gza2Nl?=
 =?utf-8?B?alZ4aVlPNDV2WTVlYXZ2SSs0TC93OEJHWWpNRjZCVDgrb3dXaWlOQ0RiZk5U?=
 =?utf-8?B?V0VHZ2FkNlZmOEdQSUtITnpvWVBWc1F6K3NMcTBCdmpYa2pScVVwS0UxWmhH?=
 =?utf-8?B?Q2Vsd1FzaVhtK010dndSZ2FBTURTQ1NoeGx0TktQWFZ4S3BocHFXSGZSczY3?=
 =?utf-8?B?b2hvSEJ3aHlZaThjQUw0U3BhNnEvUWRmNUFXOEZjbnR3dXI5dk56em81Y2M5?=
 =?utf-8?B?bXJBVExVN294dmxjdXFEaVRjUlhtSXM2VnJyR3JFWUorMVh4VVRHMlFjQ0dD?=
 =?utf-8?B?cFlVSWZsYlRXVGFaeGlkNEdtWWFiSXcyT2RUTUdlYlBUdjBHZUJITW0xUUNz?=
 =?utf-8?B?YjJ0Tlc0d0daWjRPYnVzd1hMWFc0RkcwQUhOTmJGbGt4YlNVaUx3c2RIZUhz?=
 =?utf-8?B?QTg1VlRCMk5zc3hyUEFIZE5CM0FaTER2bTVRaUhydmZ6OXA4L0tBaW1jVkFt?=
 =?utf-8?B?RFB0WXpOVUVSbDYyYTgyUTVuR01UOStraE5sTWFrazZZdlJCSFl4RGx2bXNm?=
 =?utf-8?B?STN5YjJXeUYvaHh5Y1BxMk5yd0VUR0Exbzh2VWhJcEVqdy9mOE9uMURZUlJz?=
 =?utf-8?B?S3prWFBINTJNSUZwT3czakViR0pnK0Y2QVZ1RGhQK0tkcGRabVN0R2Y2dStw?=
 =?utf-8?B?OHdzMWdsdlBDVXNnWEM5b1hoM3FUQUJualV2Z2VQV3lPWlVWdk9FelB3WW51?=
 =?utf-8?B?MU42RlBjRW1INnFZeUNvM1hHUTR4djN4bzd4T1BheTVScnJiNnJHUkY5SjRj?=
 =?utf-8?B?Q0FvdjJZYmd3UGpQdG5QcXd3U1VYekJxeXA4UVU3ZU95YWpLUWRXWml2d1JJ?=
 =?utf-8?B?SVovMWNzVW5GdzF2cWMrdEorWmg2d2tpMnk3VktMdk5xRi9IS2gwRFh6MHAz?=
 =?utf-8?B?cWp4WmFXdTZkanhDUFZ0dE9uZUl3c1d2OHZqOG9yM1NQS0pUakNWUThqbzIx?=
 =?utf-8?B?WlZrK3dzY200NTlTQnZrNUdFaGJ0cG9yUVlDM2l1R0RudG1kSjVSVVo2eUpL?=
 =?utf-8?B?Nmc9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f78f06-772b-41fb-b09a-08dcbaef7c64
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 16:54:52.8193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EwR/w7vcbR1hLCBQik/u8FseshyeGfD6XK6+I+accP3lINL60zPSKVjM98wrkvp30mUT+QG7EIviJy9yZG5D0XRYuS31OFJsdQydAh6udgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6004
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

This definition isn't used anywhere anymore, let's delete it.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
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

