Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC185304B2;
	Wed, 23 Sep 2026 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171534; cv=fail; b=asz8jQ37OdmY1ABG4Clb9r4Pd+7LWPr4GZl9LH6PEJVipxeBQ4wKyUq5NY6fXZwyhO3c8IxFfIg50+79H69Uragegki1vyaLiO+FNUksrTSzNZrO1XQXGS/c8JuiUvA8Jwiq2WDS2domad2FhsPU/8alThb5i7OV3okHYJmZ5Hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171534; c=relaxed/simple;
	bh=Hin5EKSXrJvYW3IXu/CUNAMIXEpWuVD+FshVSZOnpRw=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=mldIaH3DOPmCIltGcr31oATP0XUe4KbatV6/SASQ5HEkchxJsG62aPvtAhqh2iLzZX+DpfqbHnpvywD7ZTz9h2TQexcdEH4IGrbpQN2qvT+EHSaNDJs7ME9uwohs4RPEBfYTWNBDt0PB29nZTukKvR/kGr0bnB//NirP84aS+ZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=uHh6at0l; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="uHh6at0l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlxkiWx0n2NRoaI9XzZwT37gkKxc26pmrneUxwqb9KcPrvgJSmsRqVMcNhkjczH2BrSYCc+TkZQXm1iVOfJCkGRQ4arsU4lkYtlydFrM4vF1ulZx0rfvcVVHzDJ+QVpJPR+Yc5xefAMyi9EkcvSKatYX44TJdBFaabYaxuKWjrvkiBjVD0soGHkaKF3YeLyCaLuSXEiwkG9bv8Ecaius2fQr70Ii1hbnL9pGouuAn/eq6xSu/XCZV3kIPh77u77iT9eoEcGmPLkcXQ05DtxU1XkEiwZ1W4nowYBKyF+Sl8pu1bL+YB38Wv/DsnIUBIaBL2756Tj3+eSrJirECOZ/6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biKKDDb5TM42skkUDESqhKhzvm+b4cUsZncVArJ/g74=;
 b=b51/+dezp+zgwf4QTP5ngh1YUUAj9cszkTGreB04TlxUjGHPe19TJ1rpZ2Df7+rhMnCOnf7PnUnEcNHZfooDFVmZEvgO4ZRHsjphwTtEAUVxlu8UuxQaHUAO2HGj9QdhXVhVUv/ZfkyhFOpTnCn9ht3yN4S7G9QnkxhESRE6aKmsJMdgFl3qhRoYAi0V6ZpcaCuBjn3SnrligX3L02o9xz6ybYg2zDeqc3mpSyQhpOmZFWxHLCxzHVpkVXO2/WiVpDSmZT8dEoF8G6GIV+YqMdwZQLz571TO+PPjp5eIjcE4WFO9zg9EFF3kQHdaIVCjLVAh6PYZGoA7SP+fpuN2nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biKKDDb5TM42skkUDESqhKhzvm+b4cUsZncVArJ/g74=;
 b=uHh6at0lIw+Afj1TJ9mayjQeniTJqUX3FS61ZJYswbM/qLUepFOFD/+DDxYH2CHdgYCUi7rorxP5vSiQ4tSmAvTg/BlweUp/RBToIH/lRHsSwyj8PPF0X7ILXz1oRbOLpKNIEFjO7drMnZlQddm5aNx75m2asayZyWrW0CHvVr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO0P265MB9178.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Wed, 23 Sep
 2026 13:52:09 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.014; Wed, 23 Sep 2026
 13:52:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 14:52:07 +0100
Message-Id: <DLMQUEKCSXRS.2OBTL1GV4FXVV@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Cc: "Ayush Singh" <ayush@beagleboard.org>, "Johan Hovold"
 <johan@kernel.org>, "Alex Elder" <elder@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Eric Biggers"
 <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <greybus-dev@lists.linaro.org>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH v2 1/3] tty: serdev: Export functions to pause
 receive_buf callback calls
X-Mailer: aerc 0.22.0
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de> <20260920-rust_serdev_probe_refactor-v2-1-43b855162f5d@posteo.de> <2026092356-chatting-dust-3de9@gregkh> <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>
In-Reply-To: <2fcec4f3cd70a41e282505ff5c99b19e5809aead.camel@posteo.de>
X-ClientProxiedBy: CWLP123CA0253.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:19e::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO0P265MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 46b80fca-ddc9-4386-b576-08df1979dc6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|7416014|376014|23010399003|1800799024|6133799003|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	M+Bl8tQQUvHlW98s9BrU3ybxMU5Z/SrEoK+h8BSbz8lVdw6UYoi5cf8DHFzjnCQLrTHr68UmFcO6RSKdGzz50cQCRFVShsI9DGF7XsICn/PAYv6MxsV3i3IeBvOx8+kzvi+61H8/TgFs1Qxsu77+v7craG6lg2iCqJlgcogsVKDt1ds+0ovAlSxsT98W57/DpYtCfjHRpiOZf7Y8otr6sxGivwdNxieg12p56ta0bEyoS03YPwfrIfjogQ7lfuMqCdIc37pUlTz40f11BA6pClZBebrBeVoMaQA1F2cQhi0j9141TrIztJUkQ+Siu2cK2/aH9cN/lAdMLRFO4Gke033WvMX5vF4G12eOkGYkA6rkGORROnhUR82+jgRiQ4Uzr0LBTyV6bDAHE1Q7zCmWfE8H9w9cR3dgq304M8A5xcyc2jbXwzVNR0AlS9i3WMMa9EmRJAEjKmL6NNkQkcLw8jsBxYiNlSE8g0sIEgp03ukp9+QcgYVpNn2F64uFVVLERhTIMMvirNIH22imPwFfV1QKNQ2s0B+DS3gLZXEecvAHaclQm/8WwWAXxDg0O1XZvjc9COVOxi+iH9yTdQxhnmV8oIe+Z+Fh5KTV4tmhct5b2S7/3R/SY9S2aYm0KIoIZBuLRb/iWTH251eigIdhyfyqyyYc/y2yb//Os/+s37M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(7416014)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE5zZWh6Ullqc0JlZlJaa3h6bERIdS9pWXdrYnN3Z2YyZzlKak1UQXFnWXpa?=
 =?utf-8?B?NFdUcHMwdlRoNXBnR1gwcWhGZ2FSQWkxU3ZjaGk3UFZ2bnJKNmJFVFBaU0cw?=
 =?utf-8?B?NDV3a0NGM2NIMGlDdjB0Y1hlbUdSaHNTK3hyL2JBV1lNeEczaGFEOE9LNElP?=
 =?utf-8?B?VXB5TlZYRmN4RkJMWXdQV3FNbHUrL01nendaRzFvUWFxekZuRmx0L3QrSi9w?=
 =?utf-8?B?aHlBSHVEWDJFSk9DNk1kTVFOMHYxejBuSzNxMjNCWW5tbWc4SUgwVjY5aXNy?=
 =?utf-8?B?S2ltL3FoZktBaTgzL3ZTaHJQTTVIbGpCQUxYSzNSSDhZQVl4bEZoNGJ0YTJn?=
 =?utf-8?B?ZGlaSGUzUm5LblE2eXl6cm0raHNudU1ZZytxZUtpeUIvSW1EeFZaejhzb09q?=
 =?utf-8?B?UmlDWFFaWmYyek95a05vdHU1MWNEanFhZ2I0MkZHTnFFd25OUVZ0UVROL1VP?=
 =?utf-8?B?T05DcE40VnE1NTFsdjdWdnlEM0RMWGE1N0t4NnVOWHpRRWxpZENwaWs5UEFU?=
 =?utf-8?B?aDgwdDd5cXR4U1dCSHJweVlTRmNZUTR0dGV4QUI4SUdFbFZWMlUxVXBXNEtT?=
 =?utf-8?B?NGJsbG5hbXFVYXJYM3hsVWRjWDEvZHNaSkZZYVlsTS91TWZWM2ZwWktRWmhY?=
 =?utf-8?B?c2pQNTVVb1laQjRhd1VjZklrK0VOMWxKL29PckhaeTFZT1F2QmZVYXlJejJ3?=
 =?utf-8?B?TTNoeHNXQW1XekRKUVk2QjdjeW9LTy93SmNyYmxOa2t5LzBsZ1dGV0ZVN0h5?=
 =?utf-8?B?VStDcDh1NTE0cTAwdUZOZ1NYSWlTQUMzekdiUFp0dnRGRTdkeHkxQ1pFMVhI?=
 =?utf-8?B?dkZRK3UxemYrcTBCREp1Y1lpUkdJeEJQenN6UHhYN2VvWlJhN3Baa3d5L0RH?=
 =?utf-8?B?Mm9tRlhSeTczRXV0NzY4aFFBOVpORXgxM3NkRzNyQlNhaFJNd0VRSkU1b2R4?=
 =?utf-8?B?dDE0WnlsWkpBS0Z4b09IWVZlOWU3ZXAzVklVRmpNRSsxKzlLWUtyZEFhNjNm?=
 =?utf-8?B?Ujl2bDRjMVU2bDVFNERkdFFhSE93TFcybjFmOExLRkxIL0VTcDlmOFQzWG5L?=
 =?utf-8?B?bnYrdDV1NmpiaWk0MjRDTW5WdG53Qmx2RGs4aFVuN281N2U2bXJKdnFGeHEy?=
 =?utf-8?B?U25EdEo5THdpRTgvb3MwN0JhV2FreWNUb3ZKK29TU29ESGoraHRzVEhNclAy?=
 =?utf-8?B?dmk1SmN2M1lESVJCYmc5K1JDQlB5TEk1ZzFzdHBGc000WTJxN3h1K1FqNjRJ?=
 =?utf-8?B?SE5ZNXBqUDNoVXBqVVlmY2xRcTBUb2tISUJDWVhFaDRsSjlCWlhTRVdSSDBD?=
 =?utf-8?B?UlpScEVIaFZRVGFDQUIzVG11L3NwVGU4Vmoyb2l3a2JZWTNIanUrdmpRaTJU?=
 =?utf-8?B?S3ZhQnZrenlzQTRjVjRxSm1VNzdBSmNLVG02VExiVG0rUlkxMXZocXQzMXBl?=
 =?utf-8?B?a25vemZrdnRXUUM1ZmMrUERWeW5VTDMxNllFYlZZdkFTOGtQdmFZMFBpdXBm?=
 =?utf-8?B?WHdHLzV4SDlwcis3eUUybmw0d2ljS0duSjdCNjdMV3hxM3F2S28zZHRXanBa?=
 =?utf-8?B?SU1zNU9jd0QrV2t3YTIreHp1NHZBdzNDY3ZwcnN1OEozN25GVk9aVkR5V1Zy?=
 =?utf-8?B?YWRSckc4Kzgzd3N5c2F3dXNLUmxzK1hITVhPSUIvQ296ZEh1TTg5TU53c0ZX?=
 =?utf-8?B?Vk85VkdaOGw0aTNDNTFsamVQS3N3V1BicDNMVTJGck11MFFtdkN2UG15bnBu?=
 =?utf-8?B?RVlWclVxeUJSd2YyTUo5VHZJeWtDZHcyckYwaTRPcFY0aXQ5YzhDVDRESWN5?=
 =?utf-8?B?WGVRVjc2cnVGM0l3SjhkVUVUUUwxejcranFhYUFneUlXbFFva05abWF5dVBw?=
 =?utf-8?B?NWxzRDRVTTFOQ2RsZzMyMllXa29McWtTUnZRWmY0UU8xbC9SY3NHaEJxL3Bo?=
 =?utf-8?B?UFRCNVlQb1duN3ErUDUrZXUzdk4yN2MvOXR3a08wakJYNzdJOFlkenpsdXB4?=
 =?utf-8?B?cndYeW5mWVJBNGthWnh2bkdIbVR4Q3NvUGRpUGh5QkFXSjJjOWs2b1hXRHFr?=
 =?utf-8?B?aUJvVWNPbnlOWGduMEk2aWNGNWRlTng1SUV4SExPL0o4QThSbU5XSzlZU25z?=
 =?utf-8?B?ZFIxTVQ4V0grVFlSMmlCQXRHcit3R0xWYWg1RTdUdnV3RGF3Q3lZbllyL2dE?=
 =?utf-8?B?SU82R29GbmFWazhUMUF0bit1b0h1KzcrTXR2cTB0ZGZKZktvSUtETVpxSk83?=
 =?utf-8?B?S05KeXU5bm91ZXlWY240MGwzbnJWcXdYUTR0aWlOWXF5a3prY2Y5bmF3UjBx?=
 =?utf-8?B?UnZ5bEd2eGIvUkhtQm9vQzAwY3lzTHlZWGZaSmZORjl0RzFpUnJFUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b80fca-ddc9-4386-b576-08df1979dc6d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 13:52:09.0932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kMn4H9a3/7P31fx7GpObwR1dGdkPo/IF/w7zRrHII6/kpGs9D4sXu5cVR5PbQsDBtvI1aVkWbncejxra92t+Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB9178

On Wed Sep 23, 2026 at 2:31 PM BST, Markus Probst wrote:
> On Wed, 2026-09-23 at 12:35 +0200, Greg Kroah-Hartman wrote:
>> On Sun, Sep 20, 2026 at 02:29:58PM +0000, Markus Probst wrote:
>> > These functions will be used to simply the serdev rust abstraction. It
>> > also contributes to the fixing of 2 race conditions in the serdev rust
>> > abstraction.
>> >=20
>> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>> > ---
>> >  drivers/tty/serdev/core.c           | 50 ++++++++++++++++++++++++++++=
++++++++-
>> >  drivers/tty/serdev/serdev-ttyport.c | 38 ++++++++++++++++++++++++++++
>> >  include/linux/serdev.h              |  6 +++++
>> >  3 files changed, 93 insertions(+), 1 deletion(-)
>> >=20
>> > diff --git a/drivers/tty/serdev/serdev-ttyport.c b/drivers/tty/serdev/=
serdev-ttyport.c
>> > index bab1b143b8a6..e8aa89e733bd 100644
>> > --- a/drivers/tty/serdev/serdev-ttyport.c
>> > +++ b/drivers/tty/serdev/serdev-ttyport.c
>> > @@ -7,8 +7,10 @@
>> >  #include <linux/tty.h>
>> >  #include <linux/tty_driver.h>
>> >  #include <linux/poll.h>
>> > +#include "../tty.h"
>> > =20
>> >  #define SERPORT_ACTIVE		1
>> > +#define SERPORT_PAUSE_RX	2
>> > =20
>> >  struct serport {
>> >  	struct tty_port *port;
>> > @@ -32,6 +34,14 @@ static size_t ttyport_receive_buf(struct tty_port *=
port, const u8 *cp,
>> >  	if (!test_bit(SERPORT_ACTIVE, &serport->flags))
>> >  		return 0;
>> > =20
>> > +	if (test_bit(SERPORT_PAUSE_RX, &serport->flags))
>> > +		return 0;
>> > +
>> > +	/*
>> > +	 * Ensure writes by the driver are visible before allowing traffic t=
o resume.
>> > +	 */
>> > +	smp_mb__after_atomic();
>>=20
>> This scares me.  Why not use a real lock?=C2=A0
>>=20
> I can use locks to make it less "fragile". But I don't I think I need
> them.
>
>> WHat's the issue here, you
>> need this to be "flushed" before this call:
>>=20
>> > +
>> >  	ret =3D serdev_controller_receive_buf(ctrl, cp, count);
>>=20
>> here?
>>=20
>> And you just tested a bit, you didn't set a bit, so what are you trying
>> to ensure is written exactly?
> This should be an acquire load operation (paired with the release store
> operation in `ttyport_resume_rx`).

Then you should use `test_bit_acquire`.

However, this isn't sufficient because there's no synchronization between t=
his
bit test with the bit set inside pause_rx.

Best,
Gary

