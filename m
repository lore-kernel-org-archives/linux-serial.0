Received: from eu-smtp-delivery-197.mimecast.com (eu-smtp-delivery-197.mimecast.com [185.58.85.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F84B13BACC
	for <linux-serial@vger.kernel.org>; Mon, 26 Aug 2024 15:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724686974; cv=none; b=a4xWJ00IuY2VD1XEVS4z5udH3LjvDRdZ9j+UceLdPWxh1ojyY97jwxCC9zEKo3TbLz+1obPN/mBPZqGRoNyWXo55ARBHfKOGVF1O7WXXG4+aJc53FqRL57KjI5FVWYmBGGBBFIjY2zY7ojDpBSmjIBAM6/v2w9jqbvdYy5f5XDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724686974; c=relaxed/simple;
	bh=UjvnLMUDMfc+j7A8/WoqdzT3+j1pbSsqe+J2JuF9IHw=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 MIME-Version:Content-Type; b=K69cDNWNWjDFMp3oE0BotkiLwD49rxHpF88rEPF8RONgexW0KK2wk6gvXqSdkWS/DFSzCck30X/NFk+ShDYFyvvpd7sBC+zShQI3OeymNh/LkUv3Yb7sWXqkHNdD+lCecgSmhJEG2BnHoLc0PDdYT1/nIQRhL15T9jh+4uWPOCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com; spf=pass smtp.mailfrom=camlingroup.com; dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b=MgIqjjNx; arc=none smtp.client-ip=185.58.85.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=camlingroup.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=camlingroup.com header.i=@camlingroup.com header.b="MgIqjjNx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camlingroup.com;
	s=mimecast20210310; t=1724686970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AgoVt8VqJlH0A8f/vm7f8KFzcVBCBLnfB/o6iJQupdM=;
	b=MgIqjjNxJajbz0jhQkIoEEew96yVAO6Yth2lSkMrxOy/2a8fSOr8F09YKGwRCRyJ7v4yy1
	BIuRGd4jsVkv8CuLxiK/6T+L6fSJopg141yZVEBnpf4tLbocPee4KiivLqM+QbJHjv8Jf8
	xurPQr+5hptGMlua2hUiuyzUv9Yasis=
Received: from GBR01-CWX-obe.outbound.protection.outlook.com
 (mail-cwxgbr01lp2046.outbound.protection.outlook.com [104.47.85.46]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 uk-mta-104-CLoAvBhtM2aqIynmkHUVjg-1; Mon, 26 Aug 2024 16:42:49 +0100
X-MC-Unique: CLoAvBhtM2aqIynmkHUVjg-1
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:142::9)
 by CWXP123MB6192.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1aa::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 15:42:48 +0000
Received: from CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f]) by CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 ([fe80::f866:62f9:716e:ca4f%4]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 15:42:48 +0000
Message-ID: <8b45a01e-7cc5-4d53-b467-c6680bc51ef4@camlingroup.com>
Date: Mon, 26 Aug 2024 17:42:45 +0200
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 3/3] serial: sc16is7xx: convert bitmask definitions to use
 BIT() macro
From: Lech Perczak <lech.perczak@camlingroup.com>
To: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, Andy Shevchenko <andy@kernel.org>,
 =?UTF-8?Q?Krzysztof_Drobi=C5=84ski?= <k.drobinski@camlintechnologies.com>,
 Pawel Lenkow <p.lenkow@camlintechnologies.com>,
 Kirill Yatsenko <kirill.yatsenko@camlingroup.com>
References: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
In-Reply-To: <9c1f8fd4-a2a5-4f92-9e86-2cf0103b1908@camlingroup.com>
X-ClientProxiedBy: BE1P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:67::14) To CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:142::9)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB5267:EE_|CWXP123MB6192:EE_
X-MS-Office365-Filtering-Correlation-Id: 719b0ba4-d255-4cfe-5d42-08dcc5e5bc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzZVZmdaczRudEVrZmpYdHo3MkpFN3JPZlhQYkVrOVFBVW1URktnUWp4NjVo?=
 =?utf-8?B?S0U2ZEdsWmhPMGp0TFNNZ1p1cGZTcTBrb0RJVDNUNmcreGUrdE41NlJJRlYv?=
 =?utf-8?B?K0lrK2h3Z3NHYWliOGJhLzNyaTA4eGVTOXFSTVdmZ1UvZTNvYmZST3N2UUI2?=
 =?utf-8?B?K3pkR2JRVEo5dzBxM1lyOC9QREJnalM4Y3VkcWIxYjM4ckNaa2VVR2FMVGxO?=
 =?utf-8?B?SHM5R1FEOVVxbVFiZlpFVFhxUGxOdGdsUlhsbnh4OUZjdlA5OG03ZHFGcU5Q?=
 =?utf-8?B?cHlVNDlCMVVRZW5wdERDR3Q5eXJEQU9ISWl0TFNZdTlFZ0tuVEJZODhDS1pJ?=
 =?utf-8?B?dWVTY2Fabjd3WVU0RlJEbWp0WG1kNFFtS05abVdxc0VCTm54ZUpoWFFXMHdI?=
 =?utf-8?B?THpoeFZoOGhkVFVoZGFZdXdUKy8wV0F1T09oZjk3ZjVpa3lQcmMwNUdybVhV?=
 =?utf-8?B?MDZYampXRzN2c2tPUjRzb0RnYmlldGpXeVFwejlwS3JabS9pOWRhQ1Z2KzAx?=
 =?utf-8?B?TkI0UWxwcHc4a3VybXRla2FGandLeVQ1NzQ4RFIzak9qRHVyM1ZIZXkvWGlI?=
 =?utf-8?B?c09qQ1hjMVpSbVRCbmhkWmdaUkpjZC9RTzFXc0NLK1BHcXFNdmRpVG9Rc3Zt?=
 =?utf-8?B?V3VBUVIycjZ0NW9oc3ZxNFkvVFZ0U1MwN0luQ1oxaGtUQ0F3M0oyQ2pPOUJx?=
 =?utf-8?B?R3RSMDdpZnNuZkxWSUVXL3NlUEVISDdjTHJCY0VwU1FmTnRQM21jcTZha1Rj?=
 =?utf-8?B?UDBCZ0dDcVlCeWRKN0JtTmF4RnlCWXdQemc1d09lY0FNUk5mTEh5Qmg4ZGN0?=
 =?utf-8?B?MUZaY01PRk5jRWxjMmVGeUhZdEpBL3JNZlg3OHJ4cnhGa3lSYnV6eStiOGI2?=
 =?utf-8?B?VUNUT2laNllJZ0pjR0Z2Vmhrd1IxY1JlalNHNklDTlp5K3VWU0d4R2JSOGlq?=
 =?utf-8?B?Q0Z1SVE4RHFkMEF6YVdmVFgwWG40bi9DblBNT1FHTHdyaDNaNFZnSTVSOUVu?=
 =?utf-8?B?anpKSTdxZXhQY0JKR3p3M3QwN0M0TGxTdWxUeVVxK2VPK1BETXlodnpubTdv?=
 =?utf-8?B?NzhVcEY5OHRFcDlWVi9kSDR5WEhOK0lkNStUMFd6SlhCWm9aSGhkU3FxRUdJ?=
 =?utf-8?B?bzA3QXV4QU8wZlJoZUZmcVdNenRnLzVGcW8xTkZzeVdFQXo2MEs4aEZncHZw?=
 =?utf-8?B?blpJQnNVWisrMC9INWRmQjhWVDNNUEEyT3B4SUh2WW1MUEVFYTAyemlrMW5Z?=
 =?utf-8?B?ZVpVZ2NiNTRtNUE4ZnB5TVdzaGtlYVIwaHBiUmJYUjY0aGRsMWMrckdYcCsx?=
 =?utf-8?B?YjdpOW1rSEgyY3ROS2pRS08vQWpYTWlDV3YzQ2wrR3g2K2R1VmJ0eHVjZTkv?=
 =?utf-8?B?dTFCYmFqeDZtejJlN081YzE2Y3FYeWJNdW4yQ0hVOVVvbE1nTTFqekN6aWVj?=
 =?utf-8?B?MHB5dTBvd3AyUkQrZ0FiRWdTOFIyYzdJM2pSQVJkOTJoa2dyTW0vRzExbUwz?=
 =?utf-8?B?TmJlQ2lDKzVVNW5ENTZqTzFwQzN1bW1aQmVJWUNheUhFSklaRmhWU2RiUWl0?=
 =?utf-8?B?dmNMblF3TW9KUG1jb1FBa2RhZEZNNExFSGVCZEdLY1c5WXNsMHFsTEpJS0ZF?=
 =?utf-8?B?MTA3dUUvMGlJTmRIUlhvZ0hvNEltZWJJWVljQjQ0N0ZFa2xjcjVKOENEZEJx?=
 =?utf-8?B?SERCK21sRnNQQ0hFZklQRUxTOWdJVUVUVXFFU1l4TE1kQkJpcE54eUZxUlpn?=
 =?utf-8?B?Z3ZaZXZxZEphdTQyazBNK3pCVWUwbkVJZkFPY3VVaHlHN3M3eVhycXVEcGtu?=
 =?utf-8?B?cDZsM2x0aWZpY0JYQis0UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTNxOUhOaFljVnBzbEVRUmN0R2V3TjRtd3JrRlp0cWF6SHNCeTJ3aDdUZ0Jl?=
 =?utf-8?B?OVNHZm5nYWt3Z3BYWExNT09hUURoWjlrbDJEeXpJb0xpMy9tcWpicE1uNWZS?=
 =?utf-8?B?R2tzK09BbWQ2bXo5SGs5c01BRi9xaEE1UXhKMXM3VkhqSzVFdk9BRXZxbTY2?=
 =?utf-8?B?NDdCUmsxd2pCS2ZxOUNkOEFia3F3N0VkNWtNbzIxbmhEMFIzTmZmYmpVNUN1?=
 =?utf-8?B?aURLRFlOeEsxeDJ2alBQS1JWUU1wT2xxR1lQcXNMVHN5TmxycDlVQ0ozNmQv?=
 =?utf-8?B?ckRKL1FVbkhJR1hGQmNpSHFTSjMxN3plNXRKWUtCTVBWRVp3aDVaYXh4WjFK?=
 =?utf-8?B?OFpOZVVQYzB6QldYNldpS2xLNktGTVNZZTRXdkNrTVZCaTUwSEl5Slhqdkda?=
 =?utf-8?B?VzNLejhCQmNIN3RqZkJZbElrMVAxWVVZeWZLNlI5VzQxek1Pb2V5Zk9OS29C?=
 =?utf-8?B?MmlrdWVpaUZjZ1ViKzBRMjdrZDY0ZDc0ODBhZG9sc0NUcWplRXhxdUlWbHB1?=
 =?utf-8?B?d1FvRVhXWTVZS3VFaXdEbzRiWldXM24zeFMwV1BpWU9yWCtTOFBqK0FVS005?=
 =?utf-8?B?TWUxMTVOVHJNWWVlcVZ3Y2xoeDVsY3I5Z0I1OWFHL0l2SHBQVHRLK3pqeGg3?=
 =?utf-8?B?MnVIM2Uxa2VGSkRoQ3VZQlozUko2ckk4S3RpZEVITzU4elJxZTA2VDhPZnBG?=
 =?utf-8?B?RlVmclNzZ0c1b3pseU96YzVuSXJ5cSticHBUcGFxNXhFaGRPOHY4T1NwdTRB?=
 =?utf-8?B?LzFtWGJWNEpVRmtDUHo1TXF1QVZ6ZG41aWpuOU1zUXNtSzNNczFJNGE3R3hG?=
 =?utf-8?B?TjZVYjB4R3BOZW1HMnlBbExzMGNGSWl0ckNxdVl2cFBFb0xQc3NZNkFoK0or?=
 =?utf-8?B?SU02SkhDMzFrOHpUS0ZWWEM5Y2YwanBzT2JpL2llaTVSSngvUE03akhtZjgw?=
 =?utf-8?B?K0dWS3VlR3h0TUxyc05BN2F1alREak1kNFp0QXBpdzZITEt2L28yaXRlbVVo?=
 =?utf-8?B?VFVFYTVLSXNLOTZTNDhxaFdQU2NzT2s1SURMRUh5T21CYXY3ZWs3M1h1WW54?=
 =?utf-8?B?c3lCSkM2NEt5d0RVS3hqZnRhVkttSXhtcTdkb3RjSnh6Y2tuUWFBUU5wYzhX?=
 =?utf-8?B?aTBlZlZLU3VRSDJ0ZWFHcEJKZUFTeTdPYy9MZHpqSXlOOFdwdndQSlAvRENh?=
 =?utf-8?B?MFlwbkRsMGNpaWgrSmVRbWlneEJGMVZmcEhkSXJUdHljdlZTWGIzVzZ3ZFRs?=
 =?utf-8?B?L21xMkhRQmlDeERsQm03MlFwMFU0dXR0VVNua213S2ZFZHJZK0gwUk51bit2?=
 =?utf-8?B?SjNBR20vM3Fuc1ZIbm02TDNxS2xSei9wT2wzRTMwUHRrN1BHOUhkMEFmYmhW?=
 =?utf-8?B?clhjZnZEMlZzLzJabzhhNzArT1VHSi91TzZZVE1TcjlhNjl5UXY4bkg3UUl6?=
 =?utf-8?B?NksxYlVuZHUyLzN0cVFzdENvMFVtOWphNmlkN296TzArRFUrbTVCL3AvWW81?=
 =?utf-8?B?TUlZWUl4eW4zNzA4blVJSm04VVRVUGdjRERGeXprSnRsYTI5S0Rndi9CS3NK?=
 =?utf-8?B?Y1o5cHV3SENuNkFnZnB4bHZBdGZDSUtvcDJ0c0ZRbTNPZFFXdWVRbmxwUVRD?=
 =?utf-8?B?eWpXTjFGYlY2MVJMWDNQSVQvQmY5WXk4aFJtT1FscFQ2ampmMXIzS2F6YTJN?=
 =?utf-8?B?TWh3R0taa2c5V000OFJVdktYbTN5aGI3T3BUcmNWME1MVk80M1JWNmFCRHBo?=
 =?utf-8?B?Zm1Ja3NBbHB4VWs2QnlTS0hibzI0TUJ2eFNIWm9RblRIaWZLOTFsQ05ZdVNx?=
 =?utf-8?B?QXViNk9YQ1FIUG42SzJhSjlUem1WU1lTSzBNYWIzT0RFTFdVZ1lXOUg1OVVT?=
 =?utf-8?B?WHBJZnhRMklkc1E0MnZ2aXBscVZ4Q3hHZTRnUVBLdUpJMXR6bFZaREM5ZjF1?=
 =?utf-8?B?TXlXM0tTZXA5aTJ2SjMyTWRDbFpMYW9KY3ZsenllWHNlSk5KVCtRa0svSHJi?=
 =?utf-8?B?d1U4WGdiMnhvK2FWRFdBTnUrWTVXK2RKbmlVcFNMNDJ6WnJaNEE4SUd5ekhx?=
 =?utf-8?B?TWxSb1VoZ1Y0Wkx2c2gxcHArZTZQN2cxUSsvMXJLQk9PS0U3VFZWMmFqakxn?=
 =?utf-8?B?MnpONmVpMnFWeUY2bGMvMXRxZWtvY3NOWjAwQkFBWkVVQXNURytUL1YxT2F2?=
 =?utf-8?B?RXc9PQ==?=
X-OriginatorOrg: camlingroup.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 719b0ba4-d255-4cfe-5d42-08dcc5e5bc52
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB5267.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 15:42:47.9217
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fd4b1729-b18d-46d2-9ba0-2717b852b252
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fhTTcozVmxikKt1yYK5AFlU896d8dsh0cXS0gtr1+jXm8OA6IjgNVbjRUkT7tn7vZo1HjIPlAMBj/qE/qrHAQperr0uOI21tgDuAHqqoJUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB6192
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: camlingroup.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Now that bit definition comments were cleaned up, convert bitmask
definitions to use BIT() macro for clarity.
Convert SC16IS7XX_IIR_ID_MASK to use GENMASK() macro -
- while at that, realign comments.
Compose SC16IS7XX_LSR_BRK_ERROR_MASK using aforementioned constants,
instead of open-coding it, and remove now unneeded comments.

Signed-off-by: Lech Perczak <lech.perczak@camlingroup.com>
---
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Cc: Andy Shevchenko <andy@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 176 +++++++++++++++++----------------
 1 file changed, 91 insertions(+), 85 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.=
c
index 36b7c682ae94..943ec53e71f9 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -10,6 +10,7 @@
 #undef DEFAULT_SYMBOL_NAMESPACE
 #define DEFAULT_SYMBOL_NAMESPACE SERIAL_NXP_SC16IS7XX
=20
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/device.h>
@@ -77,52 +78,52 @@
 #define SC16IS7XX_XOFF2_REG=09=09(0x07) /* Xoff2 word */
=20
 /* IER register bits */
-#define SC16IS7XX_IER_RDI_BIT=09=09(1 << 0) /* Enable RX data interrupt */
-#define SC16IS7XX_IER_THRI_BIT=09=09(1 << 1) /* Enable TX holding register
+#define SC16IS7XX_IER_RDI_BIT=09=09BIT(0)   /* Enable RX data interrupt */
+#define SC16IS7XX_IER_THRI_BIT=09=09BIT(1)   /* Enable TX holding register
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_RLSI_BIT=09=09(1 << 2) /* Enable RX line status
+#define SC16IS7XX_IER_RLSI_BIT=09=09BIT(2)   /* Enable RX line status
 =09=09=09=09=09=09  * interrupt */
-#define SC16IS7XX_IER_MSI_BIT=09=09(1 << 3) /* Enable Modem status
+#define SC16IS7XX_IER_MSI_BIT=09=09BIT(3)   /* Enable Modem status
 =09=09=09=09=09=09  * interrupt */
=20
 /* IER register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_IER_SLEEP_BIT=09=09(1 << 4) /* Enable Sleep mode */
-#define SC16IS7XX_IER_XOFFI_BIT=09=09(1 << 5) /* Enable Xoff interrupt */
-#define SC16IS7XX_IER_RTSI_BIT=09=09(1 << 6) /* Enable nRTS interrupt */
-#define SC16IS7XX_IER_CTSI_BIT=09=09(1 << 7) /* Enable nCTS interrupt */
+#define SC16IS7XX_IER_SLEEP_BIT=09=09BIT(4)   /* Enable Sleep mode */
+#define SC16IS7XX_IER_XOFFI_BIT=09=09BIT(5)   /* Enable Xoff interrupt */
+#define SC16IS7XX_IER_RTSI_BIT=09=09BIT(6)   /* Enable nRTS interrupt */
+#define SC16IS7XX_IER_CTSI_BIT=09=09BIT(7)   /* Enable nCTS interrupt */
=20
 /* FCR register bits */
-#define SC16IS7XX_FCR_FIFO_BIT=09=09(1 << 0) /* Enable FIFO */
-#define SC16IS7XX_FCR_RXRESET_BIT=09(1 << 1) /* Reset RX FIFO */
-#define SC16IS7XX_FCR_TXRESET_BIT=09(1 << 2) /* Reset TX FIFO */
-#define SC16IS7XX_FCR_RXLVLL_BIT=09(1 << 6) /* RX Trigger level LSB */
-#define SC16IS7XX_FCR_RXLVLH_BIT=09(1 << 7) /* RX Trigger level MSB */
+#define SC16IS7XX_FCR_FIFO_BIT=09=09BIT(0)   /* Enable FIFO */
+#define SC16IS7XX_FCR_RXRESET_BIT=09BIT(1)   /* Reset RX FIFO */
+#define SC16IS7XX_FCR_TXRESET_BIT=09BIT(2)   /* Reset TX FIFO */
+#define SC16IS7XX_FCR_RXLVLL_BIT=09BIT(6)   /* RX Trigger level LSB */
+#define SC16IS7XX_FCR_RXLVLH_BIT=09BIT(7)   /* RX Trigger level MSB */
=20
 /* FCR register bits - write only if (EFR[4] =3D=3D 1) */
-#define SC16IS7XX_FCR_TXLVLL_BIT=09(1 << 4) /* TX Trigger level LSB */
-#define SC16IS7XX_FCR_TXLVLH_BIT=09(1 << 5) /* TX Trigger level MSB */
+#define SC16IS7XX_FCR_TXLVLL_BIT=09BIT(4)   /* TX Trigger level LSB */
+#define SC16IS7XX_FCR_TXLVLH_BIT=09BIT(5)   /* TX Trigger level MSB */
=20
 /* IIR register bits */
-#define SC16IS7XX_IIR_NO_INT_BIT=09(1 << 0) /* No interrupts pending */
-#define SC16IS7XX_IIR_ID_MASK=09=090x3e     /* Mask for the interrupt ID *=
/
-#define SC16IS7XX_IIR_THRI_SRC=09=090x02     /* TX holding register empty =
*/
-#define SC16IS7XX_IIR_RDI_SRC=09=090x04     /* RX data interrupt */
-#define SC16IS7XX_IIR_RLSE_SRC=09=090x06     /* RX line status error */
-#define SC16IS7XX_IIR_RTOI_SRC=09=090x0c     /* RX time-out interrupt */
-#define SC16IS7XX_IIR_MSI_SRC=09=090x00     /* Modem status interrupt
-=09=09=09=09=09=09  * - only on 75x/76x
-=09=09=09=09=09=09  */
-#define SC16IS7XX_IIR_INPIN_SRC=09=090x30     /* Input pin change of state
-=09=09=09=09=09=09  * - only on 75x/76x
-=09=09=09=09=09=09  */
-#define SC16IS7XX_IIR_XOFFI_SRC=09=090x10     /* Received Xoff */
-#define SC16IS7XX_IIR_CTSRTS_SRC=090x20     /* nCTS,nRTS change of state
-=09=09=09=09=09=09  * from active (LOW)
-=09=09=09=09=09=09  * to inactive (HIGH)
-=09=09=09=09=09=09  */
+#define SC16IS7XX_IIR_NO_INT_BIT=090x01=09=09/* No interrupts pending */
+#define SC16IS7XX_IIR_ID_MASK=09=09GENMASK(5, 1)=09/* Mask for the interru=
pt ID */
+#define SC16IS7XX_IIR_THRI_SRC=09=090x02=09=09/* TX holding register empty=
 */
+#define SC16IS7XX_IIR_RDI_SRC=09=090x04=09=09/* RX data interrupt */
+#define SC16IS7XX_IIR_RLSE_SRC=09=090x06=09=09/* RX line status error */
+#define SC16IS7XX_IIR_RTOI_SRC=09=090x0c=09=09/* RX time-out interrupt */
+#define SC16IS7XX_IIR_MSI_SRC=09=090x00=09=09/* Modem status interrupt
+=09=09=09=09=09=09=09 * - only on 75x/76x
+=09=09=09=09=09=09=09 */
+#define SC16IS7XX_IIR_INPIN_SRC=09=090x30=09=09/* Input pin change of stat=
e
+=09=09=09=09=09=09=09 * - only on 75x/76x
+=09=09=09=09=09=09=09 */
+#define SC16IS7XX_IIR_XOFFI_SRC=09=090x10=09=09/* Received Xoff */
+#define SC16IS7XX_IIR_CTSRTS_SRC=090x20=09=09/* nCTS,nRTS change of state
+=09=09=09=09=09=09=09 * from active (LOW)
+=09=09=09=09=09=09=09 * to inactive (HIGH)
+=09=09=09=09=09=09=09 */
 /* LCR register bits */
-#define SC16IS7XX_LCR_LENGTH0_BIT=09(1 << 0) /* Word length bit 0 */
-#define SC16IS7XX_LCR_LENGTH1_BIT=09(1 << 1) /* Word length bit 1
+#define SC16IS7XX_LCR_LENGTH0_BIT=09BIT(0)   /* Word length bit 0 */
+#define SC16IS7XX_LCR_LENGTH1_BIT=09BIT(1)   /* Word length bit 1
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * Word length bits table:
 =09=09=09=09=09=09  * 00 -> 5 bit words
@@ -130,7 +131,7 @@
 =09=09=09=09=09=09  * 10 -> 7 bit words
 =09=09=09=09=09=09  * 11 -> 8 bit words
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_STOPLEN_BIT=09(1 << 2) /* STOP length bit
+#define SC16IS7XX_LCR_STOPLEN_BIT=09BIT(2)   /* STOP length bit
 =09=09=09=09=09=09  *
 =09=09=09=09=09=09  * STOP length bit table:
 =09=09=09=09=09=09  * 0 -> 1 stop bit
@@ -138,11 +139,11 @@
 =09=09=09=09=09=09  *      word length is 5,
 =09=09=09=09=09=09  *      2 stop bits otherwise
 =09=09=09=09=09=09  */
-#define SC16IS7XX_LCR_PARITY_BIT=09(1 << 3) /* Parity bit enable */
-#define SC16IS7XX_LCR_EVENPARITY_BIT=09(1 << 4) /* Even parity bit enable =
*/
-#define SC16IS7XX_LCR_FORCEPARITY_BIT=09(1 << 5) /* 9-bit multidrop parity=
 */
-#define SC16IS7XX_LCR_TXBREAK_BIT=09(1 << 6) /* TX break enable */
-#define SC16IS7XX_LCR_DLAB_BIT=09=09(1 << 7) /* Divisor Latch enable */
+#define SC16IS7XX_LCR_PARITY_BIT=09BIT(3)   /* Parity bit enable */
+#define SC16IS7XX_LCR_EVENPARITY_BIT=09BIT(4)   /* Even parity bit enable =
*/
+#define SC16IS7XX_LCR_FORCEPARITY_BIT=09BIT(5)   /* 9-bit multidrop parity=
 */
+#define SC16IS7XX_LCR_TXBREAK_BIT=09BIT(6)   /* TX break enable */
+#define SC16IS7XX_LCR_DLAB_BIT=09=09BIT(7)   /* Divisor Latch enable */
 #define SC16IS7XX_LCR_WORD_LEN_5=09(0x00)
 #define SC16IS7XX_LCR_WORD_LEN_6=09(0x01)
 #define SC16IS7XX_LCR_WORD_LEN_7=09(0x02)
@@ -153,58 +154,63 @@
 =09=09=09=09=09=09=09=09* reg set */
=20
 /* MCR register bits */
-#define SC16IS7XX_MCR_DTR_BIT=09=09(1 << 0) /* DTR complement
+#define SC16IS7XX_MCR_DTR_BIT=09=09BIT(0)   /* DTR complement
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_RTS_BIT=09=09(1 << 1) /* RTS complement */
-#define SC16IS7XX_MCR_TCRTLR_BIT=09(1 << 2) /* TCR/TLR register enable */
-#define SC16IS7XX_MCR_LOOP_BIT=09=09(1 << 4) /* Enable loopback test mode =
*/
-#define SC16IS7XX_MCR_XONANY_BIT=09(1 << 5) /* Enable Xon Any
+#define SC16IS7XX_MCR_RTS_BIT=09=09BIT(1)   /* RTS complement */
+#define SC16IS7XX_MCR_TCRTLR_BIT=09BIT(2)   /* TCR/TLR register enable */
+#define SC16IS7XX_MCR_LOOP_BIT=09=09BIT(4)   /* Enable loopback test mode =
*/
+#define SC16IS7XX_MCR_XONANY_BIT=09BIT(5)   /* Enable Xon Any
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_IRDA_BIT=09=09(1 << 6) /* Enable IrDA mode
+#define SC16IS7XX_MCR_IRDA_BIT=09=09BIT(6)   /* Enable IrDA mode
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MCR_CLKSEL_BIT=09(1 << 7) /* Divide clock by 4
+#define SC16IS7XX_MCR_CLKSEL_BIT=09BIT(7)   /* Divide clock by 4
 =09=09=09=09=09=09  * - write enabled
 =09=09=09=09=09=09  * if (EFR[4] =3D=3D 1)
 =09=09=09=09=09=09  */
=20
 /* LSR register bits */
-#define SC16IS7XX_LSR_DR_BIT=09=09(1 << 0) /* Receiver data ready */
-#define SC16IS7XX_LSR_OE_BIT=09=09(1 << 1) /* Overrun Error */
-#define SC16IS7XX_LSR_PE_BIT=09=09(1 << 2) /* Parity Error */
-#define SC16IS7XX_LSR_FE_BIT=09=09(1 << 3) /* Frame Error */
-#define SC16IS7XX_LSR_BI_BIT=09=09(1 << 4) /* Break Interrupt */
-#define SC16IS7XX_LSR_BRK_ERROR_MASK=090x1E     /* BI, FE, PE, OE bits */
-#define SC16IS7XX_LSR_THRE_BIT=09=09(1 << 5) /* TX holding register empty =
*/
-#define SC16IS7XX_LSR_TEMT_BIT=09=09(1 << 6) /* Transmitter empty */
-#define SC16IS7XX_LSR_FIFOE_BIT=09=09(1 << 7) /* Fifo Error */
+#define SC16IS7XX_LSR_DR_BIT=09=09BIT(0)   /* Receiver data ready */
+#define SC16IS7XX_LSR_OE_BIT=09=09BIT(1)   /* Overrun Error */
+#define SC16IS7XX_LSR_PE_BIT=09=09BIT(2)   /* Parity Error */
+#define SC16IS7XX_LSR_FE_BIT=09=09BIT(3)   /* Frame Error */
+#define SC16IS7XX_LSR_BI_BIT=09=09BIT(4)   /* Break Interrupt */
+#define SC16IS7XX_LSR_BRK_ERROR_MASK \
+=09(SC16IS7XX_LSR_OE_BIT | \
+=09 SC16IS7XX_LSR_PE_BIT | \
+=09 SC16IS7XX_LSR_FE_BIT | \
+=09 SC16IS7XX_LSR_BI_BIT)
+
+#define SC16IS7XX_LSR_THRE_BIT=09=09BIT(5)   /* TX holding register empty =
*/
+#define SC16IS7XX_LSR_TEMT_BIT=09=09BIT(6)   /* Transmitter empty */
+#define SC16IS7XX_LSR_FIFOE_BIT=09=09BIT(7)   /* Fifo Error */
=20
 /* MSR register bits */
-#define SC16IS7XX_MSR_DCTS_BIT=09=09(1 << 0) /* Delta CTS Clear To Send */
-#define SC16IS7XX_MSR_DDSR_BIT=09=09(1 << 1) /* Delta DSR Data Set Ready
+#define SC16IS7XX_MSR_DCTS_BIT=09=09BIT(0)   /* Delta CTS Clear To Send */
+#define SC16IS7XX_MSR_DDSR_BIT=09=09BIT(1)   /* Delta DSR Data Set Ready
 =09=09=09=09=09=09  * or (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DRI_BIT=09=09(1 << 2) /* Delta RI Ring Indicator
+#define SC16IS7XX_MSR_DRI_BIT=09=09BIT(2)   /* Delta RI Ring Indicator
 =09=09=09=09=09=09  * or (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_DCD_BIT=09=09(1 << 3) /* Delta CD Carrier Detect
+#define SC16IS7XX_MSR_DCD_BIT=09=09BIT(3)   /* Delta CD Carrier Detect
 =09=09=09=09=09=09  * or (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CTS_BIT=09=09(1 << 4) /* CTS */
-#define SC16IS7XX_MSR_DSR_BIT=09=09(1 << 5) /* DSR (IO4)
+#define SC16IS7XX_MSR_CTS_BIT=09=09BIT(4)   /* CTS */
+#define SC16IS7XX_MSR_DSR_BIT=09=09BIT(5)   /* DSR (IO4)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_RI_BIT=09=09(1 << 6) /* RI (IO7)
+#define SC16IS7XX_MSR_RI_BIT=09=09BIT(6)   /* RI (IO7)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
-#define SC16IS7XX_MSR_CD_BIT=09=09(1 << 7) /* CD (IO6)
+#define SC16IS7XX_MSR_CD_BIT=09=09BIT(7)   /* CD (IO6)
 =09=09=09=09=09=09  * - only on 75x/76x
 =09=09=09=09=09=09  */
=20
@@ -239,19 +245,19 @@
 #define SC16IS7XX_TLR_RX_TRIGGER(words)=09((((words) / 4) & 0x0f) << 4)
=20
 /* IOControl register bits (Only 75x/76x) */
-#define SC16IS7XX_IOCONTROL_LATCH_BIT=09(1 << 0) /* Enable input latching =
*/
-#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09(1 << 1) /* Enable GPIO[7:4] as =
modem A pins */
-#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09(1 << 2) /* Enable GPIO[3:0] as =
modem B pins */
-#define SC16IS7XX_IOCONTROL_SRESET_BIT=09(1 << 3) /* Software Reset */
+#define SC16IS7XX_IOCONTROL_LATCH_BIT=09BIT(0)   /* Enable input latching =
*/
+#define SC16IS7XX_IOCONTROL_MODEM_A_BIT=09BIT(1)   /* Enable GPIO[7:4] as =
modem A pins */
+#define SC16IS7XX_IOCONTROL_MODEM_B_BIT=09BIT(2)   /* Enable GPIO[3:0] as =
modem B pins */
+#define SC16IS7XX_IOCONTROL_SRESET_BIT=09BIT(3)   /* Software Reset */
=20
 /* EFCR register bits */
-#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09(1 << 0) /* Enable 9-bit or Multidr=
op
+#define SC16IS7XX_EFCR_9BIT_MODE_BIT=09BIT(0)   /* Enable 9-bit or Multidr=
op
 =09=09=09=09=09=09  * mode (RS485) */
-#define SC16IS7XX_EFCR_RXDISABLE_BIT=09(1 << 1) /* Disable receiver */
-#define SC16IS7XX_EFCR_TXDISABLE_BIT=09(1 << 2) /* Disable transmitter */
-#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09(1 << 4) /* Auto RS485 RTS directi=
on */
-#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09(1 << 5) /* RTS output inversion *=
/
-#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09(1 << 7) /* IrDA mode
+#define SC16IS7XX_EFCR_RXDISABLE_BIT=09BIT(1)   /* Disable receiver */
+#define SC16IS7XX_EFCR_TXDISABLE_BIT=09BIT(2)   /* Disable transmitter */
+#define SC16IS7XX_EFCR_AUTO_RS485_BIT=09BIT(4)   /* Auto RS485 RTS directi=
on */
+#define SC16IS7XX_EFCR_RTS_INVERT_BIT=09BIT(5)   /* RTS output inversion *=
/
+#define SC16IS7XX_EFCR_IRDA_MODE_BIT=09BIT(7)   /* IrDA mode
 =09=09=09=09=09=09  * 0 =3D rate upto 115.2 kbit/s
 =09=09=09=09=09=09  *   - Only 75x/76x
 =09=09=09=09=09=09  * 1 =3D rate upto 1.152 Mbit/s
@@ -259,15 +265,15 @@
 =09=09=09=09=09=09  */
=20
 /* EFR register bits */
-#define SC16IS7XX_EFR_AUTORTS_BIT=09(1 << 6) /* Auto RTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_AUTOCTS_BIT=09(1 << 7) /* Auto CTS flow ctrl enable =
*/
-#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09(1 << 5) /* Enable Xoff2 detectio=
n */
-#define SC16IS7XX_EFR_ENABLE_BIT=09(1 << 4) /* Enable enhanced functions
+#define SC16IS7XX_EFR_AUTORTS_BIT=09BIT(6)   /* Auto RTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_AUTOCTS_BIT=09BIT(7)   /* Auto CTS flow ctrl enable =
*/
+#define SC16IS7XX_EFR_XOFF2_DETECT_BIT=09BIT(5)   /* Enable Xoff2 detectio=
n */
+#define SC16IS7XX_EFR_ENABLE_BIT=09BIT(4)   /* Enable enhanced functions
 =09=09=09=09=09=09  * and writing to IER[7:4],
 =09=09=09=09=09=09  * FCR[5:4], MCR[7:5]
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW3_BIT=09(1 << 3)
-#define SC16IS7XX_EFR_SWFLOW2_BIT=09(1 << 2)
+#define SC16IS7XX_EFR_SWFLOW3_BIT=09BIT(3)
+#define SC16IS7XX_EFR_SWFLOW2_BIT=09BIT(2)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 3 & 2 table:
 =09=09=09=09=09=09  * 00 -> no transmitter flow
@@ -280,8 +286,8 @@
 =09=09=09=09=09=09  *       XON1, XON2, XOFF1 and
 =09=09=09=09=09=09  *       XOFF2
 =09=09=09=09=09=09  */
-#define SC16IS7XX_EFR_SWFLOW1_BIT=09(1 << 1)
-#define SC16IS7XX_EFR_SWFLOW0_BIT=09(1 << 0)
+#define SC16IS7XX_EFR_SWFLOW1_BIT=09BIT(1)
+#define SC16IS7XX_EFR_SWFLOW0_BIT=09BIT(0)
 =09=09=09=09=09=09 /*
 =09=09=09=09=09=09  * SWFLOW bits 1 & 0 table:
 =09=09=09=09=09=09  * 00 -> no received flow
@@ -307,9 +313,9 @@
 #define SC16IS7XX_FIFO_SIZE=09=09(64)
 #define SC16IS7XX_GPIOS_PER_BANK=094
=20
-#define SC16IS7XX_RECONF_MD=09=09(1 << 0)
-#define SC16IS7XX_RECONF_IER=09=09(1 << 1)
-#define SC16IS7XX_RECONF_RS485=09=09(1 << 2)
+#define SC16IS7XX_RECONF_MD=09=09BIT(0)
+#define SC16IS7XX_RECONF_IER=09=09BIT(1)
+#define SC16IS7XX_RECONF_RS485=09=09BIT(2)
=20
 struct sc16is7xx_one_config {
 =09unsigned int=09=09=09flags;
--=20
2.34.1

