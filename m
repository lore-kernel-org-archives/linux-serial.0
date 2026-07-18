Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020094.outbound.protection.outlook.com [52.101.195.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C93D5C3C;
	Sat, 18 Jul 2026 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784388191; cv=fail; b=Hhxift7yTH7/f6tmBdmDu8ru60/LSFv9arL+02jQKifDIjpAOgg7EYpATSOIgR3EWF1SvzZBd97GTee2uAeK8uJRp8cMs5a5yy/QpQ5KFqnYcLJVfZxMQw1GEQNe7slwAi3E2DQJIM6e/ddCoq8cdUgarE7W1i5lVC5pMXnwefI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784388191; c=relaxed/simple;
	bh=1QJkFj5MHAnsRrCW+WgoInAsBrQFT68rNQvI4zGLA7o=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=aCYDUZwwvWHsgCiv/8SS3h95Xf89SbW3YHt7d1d3ZaHwY3/IaSOm+MIXxK/wF9s3y0Gm7HiFmGX3SYgtOPT4qrcr+sts9IJXhYmvrK1tl0Cb3Rsen1CTA9xMh6eWOUebONyqUEuFDiti6wS6PTFy9PUcZhJKEGMTjBbY/NGj2Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=Rij3Et3i; arc=fail smtp.client-ip=52.101.195.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="Rij3Et3i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y/BQV371UhvW53FhFMi9r8a0XOZ5wVzO3Z0/3yah/iohCQq+fswd8vrRmc5dg6OucNNXAsKMH0CKexRDRxLxM0lsW5/oWi8HWqo+5EKZlymaHkPz5bFEuSxTlWB9hOkUfQ8ItSegrZnqzTIbSzxWI6wC94EZIYDiv0AB1i1gaNCsuhRErT0Qv7Tjh8nNt14E5a86N3ek1bS+FRkd9ELRCWi9d73/ATAw8GZwjar33ND4jsw/T5c1ybHg1to4hpgpmqKMZmFg72vts4vLiwqRPbSDFVFCxRg5jZtNlx4+Ws37hIq+ERv2Cg8S2VzbCV+SgNL1E9NjffEG8hn7JAUp1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uskUmpC5IJw/onYE39BdserOU3Sd0go1pAVcvyx4fME=;
 b=w3zeHS2cTMPZ9GxivBe9AKgni9M3fokuM0hpmzPlm0cKuuYpoD6Mfg0QEVEp1xJHNUrIVzZt/bopx+cWirQwFVK6gYdTE54FAR75rZCgoyFuBBx2ysTWPIfxe5fZLM3I88ME+/mqLzKG+yo0F9FaJ6s5mSex8xCsh0HW8+7HccRxrDGU4y5PcR9Yfbt0un7fCqVR9lCGtHIrljqCR7/6nxitS1XUhTiVN/ZpZ4JuXP9VV13YPJxezQgLkftFsa4LoFvpUy0kvpiMS1c3GILnNdkVf301TuwJ4wnBKFFwQvPsytqPjnlwG0A4fC1vfTxepi9r7lvp2iV5RTsCnR1KSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uskUmpC5IJw/onYE39BdserOU3Sd0go1pAVcvyx4fME=;
 b=Rij3Et3iX2R3284FFlLj7RlVIT1TobeysgcglNuzeze+mdDCi/KtIE67cSdofPMThWEaIhV8Wfw/7sVBz5SWwhuOrxFd7Xy8Ohw3KKZ9U4vT/AKxXQ5Ic7WjCKxBdOXvLs6LEtAVtrQMofOLxY7QTuJ6qyEGFqabPXPaqF7If+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3389.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.15; Sat, 18 Jul
 2026 15:23:06 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 15:23:06 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 16:23:05 +0100
Message-Id: <DK1STJX916M3.J94WL07DKDHW@garyguo.net>
Cc: <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: serdev: remove `serdev::Timeout`
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Gary Guo"
 <gary@garyguo.net>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260718-rust_serdev_fixes-v2-0-e5214e03de13@posteo.de>
 <20260718-rust_serdev_fixes-v2-4-e5214e03de13@posteo.de>
 <DK1SDT57QY13.3ZXZYQGOTK2P@garyguo.net>
 <dd8cc1a98c48338bd8b29168d312b7a1f466c8f3.camel@posteo.de>
In-Reply-To: <dd8cc1a98c48338bd8b29168d312b7a1f466c8f3.camel@posteo.de>
X-ClientProxiedBy: LO6P123CA0052.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3389:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5cf84b-dc6b-4868-88e7-08dee4e07777
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016|23010399003|4143699003|3023799007|56012099006|22082099003|18002099003|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	POM2z7ZrbhdOeYy+jKQF74S9xn5l2LK2SMBEX7IiVsJC3OHVD/gKHjIZRXvcsaG878aLUlJvOgC38ztlIO6blsfUrX59FC+I4mcfK/oLdvWrnHh+ZoF6Vb/vwaXm+IMlNLTRVSuMxsi+ozVayB30mx6C2uoPQp011v5p1dxejXXHANWUtCWvODyszd2i883xEJygjFmMswtYLRg2PgiEtgEh3XdKc0komUPOjqH/OuikOonxmp+Us95p4lNfQikrsL1+J9GsZKXdMcEVdMjQa+9PcNnjb8Z9nl/dGA98OIVJ+9Z79A/WCJRluLRDUlkPgQoomQTM5rm24XWWMBPjIl5Tt/6PkhkUoeFoCBVRBA8Nqk5ga7vxMCWiWdk1gFPQUzi9bVyIuDPNZjPR2z7OWJ9bk9mv+gOav8xX1cT3B4m8ODEaT+rPCszESOYW/RJfOSL/Gb4k5Z7bFtJK8QbSk9VbqkWd+5lRnEUbENPw+n8V27YXexm2EOuvsnEXPgsCCizj1FMnEL/sDyoi5OL6JuIyYSl12ked4NwIpbQC2ZhX7hT9YCmtSpvgq3PD6fa4LCIHKaOD86cXzk8D2h3izBno7HGNU3jZ/GE0/KAIHXWIxIAJxa0LGgnJ9t8O6Mz2ZJbInxUCvlX/aXt1WOOyEnGXZf0YL8BPQfcuSGCaKm5VSt/91wlv1v6pAEG90BKbJuAwdVVhV5GE0ZnJj0oXQA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(23010399003)(4143699003)(3023799007)(56012099006)(22082099003)(18002099003)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VCtpL1RsZGxRRU9HWTNLTHBuODZJSFd1M3JzY2VPQ2lwczE1RXNNUXowY1Rz?=
 =?utf-8?B?ZEF1cC9BQTFRUnhNYk45ek1OTFg4ZmpxdnRTUXlySUpacjNEUkUyM3pMQll5?=
 =?utf-8?B?S2tvWWRJKzJYNytuQW0xdmVxeExPU3BMVFNTYzh5dGNuaXA5N1NnSnUwZTd4?=
 =?utf-8?B?VE5tUEdicmtlR25XNm5MU0MrdkdrTHJBaXhKNDcxR1RvK2w2Z1I0QUhFS3Mx?=
 =?utf-8?B?aGg4TW1zbDlVUVZHZFpJSGdwK1FkTWdGZi84dHRDcWxoQU1ZVEJpc1UwYlRm?=
 =?utf-8?B?MllLM1I2SVNXWDl5cUtZU1Z0amViME0raytZOGpMZ0prYkQzSDd0U2FBL1pD?=
 =?utf-8?B?dE42bDhDNVZidTdWNmNJSjRKRExhSGM0dUx2UW8yTzVraUt1Q2xBWlh3QmZ0?=
 =?utf-8?B?WFQyN3NNU1ZaNm8rVDlnRXpNMHVZb2oxNGRUdjNZQ2cybGxoTXZCWHh6VlhL?=
 =?utf-8?B?QnBrOEVuekt2K2RMUm4rRThiRW1qWVFtMVlDWWIxWExka0pwZHFHcml5YnJ4?=
 =?utf-8?B?YTlaQWdZdER3Tm9IVVlVV0lKYjlPdWFYQTkrdVU5SlpPaVpXZ3ZyaHpPWFBN?=
 =?utf-8?B?azR6WVNoVmwxQzh6S1RrSURNcS83S3lHUWFwRkNSZ2Rla205eUFyUGpvcTE1?=
 =?utf-8?B?cm1PK2U2bUQ5cFBiQ3NJVFJEVFhVSGRGMVphc0dNS1dZY2ZNdUdOaU8wWW1L?=
 =?utf-8?B?TDBFUE94RE9iRUltVDg4a1Z3YkwwbFc4NWt6L0M1VlpvRnpLbWtkUHc3cmNL?=
 =?utf-8?B?RkY5ZTdPYVplUWVHOGtpbEZJemw3c0V2NUJVR1JCMHI3MitZbDRJRHdmR0JE?=
 =?utf-8?B?ZmtuYkR0Um42eWZxV1VwWnNGaEY3RnV1TkZJSnUwcTRMMUZudXYxRjhRYXF5?=
 =?utf-8?B?eUhhTWVib2wvQjBaS0VTQTV0V2hBcnRVYWZORlVHelhMMXpWM0I1eCtCS0x0?=
 =?utf-8?B?VjhMZndaZU1iU1lLeFcxVUJQc2ptMm51K3ZLM1drUlg2SWkwWkRGUVVlYmNr?=
 =?utf-8?B?aHdGVDZDMDNTNFRGWis5bGxBNWlueTBZWU8xamNndHRHY3pGaFcrZmhxZEdo?=
 =?utf-8?B?emZNSTFkOVkxUy9FZE5UblpsZjRSOUZLQUtFQ1FpS0cwTUZOd0lSU1BBc25X?=
 =?utf-8?B?OUtJZjdReFpRZU44Yjl3a3V3UUtmTTcrOXFSNm56enByK3JpSWI3bVJSVlpr?=
 =?utf-8?B?ZnV6VHZrQkpqaDNDRHNpMmM1ME5zT3ZwbXZIRjVHUU03K0YzbUpYOW0wbWxE?=
 =?utf-8?B?YWFLZXhqdkpZN2NLYURRVDNJa09SaHR1THJFSk5NWTVNc3M4bk1RVnF0WnRT?=
 =?utf-8?B?N2xlRnFUSzJFdFRDWENVTExNRU5uUW40b3UyT2YreG5rWWpDS1N2Ym0wNExa?=
 =?utf-8?B?d2lCQTVpREdpa3BHbzlvQ3V3KzBmOGlGcFJQYzFYYXptRHJ0bytWRmI0S3Nh?=
 =?utf-8?B?S0l6azQ5T3J6cURkV3BxemZIZGRLWGhyN3pxdGlmZWRxNVlGWEREc3hab1Iw?=
 =?utf-8?B?TTJaL29VdDlSWUFWQVpsNEd3WWc4S0Q3U1I0SGRxcms0Q0grYjFuc25kc2xm?=
 =?utf-8?B?elVhVkNVMkRaSHhTQ281NXJUK1ZIYWR2L2g4Tzh6UmpveFlVbGNObjBoaDI2?=
 =?utf-8?B?VkhWd25qNjcySHJhdzI0bzcyUWxpNmRYdjE1ZUV0UXRUalEwWnhBOU9BNTR2?=
 =?utf-8?B?MEFpSllQL0QvWWtyOW5hR0MwSlk4UzllRW4vUEhoL3h4NkZCOTV1OUFtUFNs?=
 =?utf-8?B?RXllWWZQWFB4YUc5bkY4NnZnbUxqVEp6Qld4T1pqVFR0eUpxNG1aSkpQcUxH?=
 =?utf-8?B?VWk3VVNTNnB0OFpuUXc0dEN1YWYvK2ZMd28zTmcyMERBM3hVUWxlUzNsK0Fv?=
 =?utf-8?B?QUk3L1o5aWxneFUxVXlKU3R1blNmd2lpeVJ5TXdPSFhuU01BNGN1aThqaC81?=
 =?utf-8?B?L0RtZE1JdGNsRS9Rck54MEhJS0xRQzNvdUVqVk00QlhsMGlLK3JlOXUwa0xC?=
 =?utf-8?B?UE0vQ0QzQ01HWEpobGFTbHU2UjZ4TlhPcWNjN3p0VXoyckVTT2tNeFErZjcz?=
 =?utf-8?B?RDJ1NjVTTzFTc1ZySGxGVjJaTHdGeDNOaFBHaWR1S1NTS2lvNjQ0cjc4TVdY?=
 =?utf-8?B?d2V4cGdpNUw3U01EVE5YQndvMHBIRXAvMnFWM250aWRBNVA2Lys2cmdKQnNV?=
 =?utf-8?B?K0lCY3MzZktpanJyQTVMTCtianh1QVBieTVHSXB6NGpFeTN0QjFEdFlZOXMv?=
 =?utf-8?B?N0NRc2hvSlU0M1RsbXFKZ290TUM4cU8zT3MrRm1RaklTc2h3YkVsU2VIbTA4?=
 =?utf-8?B?bHUyaEFoQVhtaytVTXlDTUdRVXEybmtuQXpTazZwMnMydzVEZE83UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5cf84b-dc6b-4868-88e7-08dee4e07777
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 15:23:06.1943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGOozjicPUyKtwDQSBpkMwiEccGqrjBuhS7VLyyjNfiHPJgMPhog/9vKsdUpyLeN3thuK9mROotQRUogo8jDIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3389

On Sat Jul 18, 2026 at 4:12 PM BST, Markus Probst wrote:
> On Sat, 2026-07-18 at 16:02 +0100, Gary Guo wrote:
>> On Sat Jul 18, 2026 at 1:47 PM BST, Markus Probst wrote:
>> > Instead of relying on its own timeout types, the abstraction should ma=
ke
>> > use of `impl Into<Jiffies>`.
>> >=20
>> > Suggested-by: Gary Guo <gary@garyguo.net>
>> > Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83=
R@garyguo.net/
>> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>> > ---
>> >  rust/kernel/serdev.rs | 55 +++++++++++++++++-------------------------=
---------
>> >  1 file changed, 18 insertions(+), 37 deletions(-)
>> >=20
>> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
>> > index a78dfa6e2c27..0fdb37cff15d 100644
>> > --- a/rust/kernel/serdev.rs
>> > +++ b/rust/kernel/serdev.rs
>> > @@ -20,11 +20,7 @@
>> >          aref::AlwaysRefCounted,
>> >          Mutex, //
>> >      },
>> > -    time::{
>> > -        msecs_to_jiffies,
>> > -        Jiffies,
>> > -        Msecs, //
>> > -    },
>> > +    time::Jiffies,
>> >      types::{
>> >          Opaque,
>> >          ScopeGuard, //
>> > @@ -35,7 +31,6 @@
>> >      cell::UnsafeCell,
>> >      marker::PhantomData,
>> >      mem::{offset_of, MaybeUninit},
>> > -    num::NonZero,
>> >      ptr::NonNull, //
>> >  };
>> > =20
>> > @@ -50,30 +45,6 @@ pub enum Parity {
>> >      Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
>> >  }
>> > =20
>> > -/// Timeout in Jiffies.
>> > -pub enum Timeout {
>> > -    /// Wait for a specific amount of [`Jiffies`].
>> > -    Jiffies(NonZero<Jiffies>),
>> > -    /// Wait for a specific amount of [`Msecs`].
>> > -    Milliseconds(NonZero<Msecs>),
>> > -    /// Wait as long as possible.
>> > -    ///
>> > -    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
>> > -    Max,
>> > -}
>> > -
>> > -impl Timeout {
>> > -    fn into_jiffies(self) -> isize {
>> > -        match self {
>> > -            Self::Jiffies(value) =3D> value.get().try_into().unwrap_o=
r_default(),
>> > -            Self::Milliseconds(value) =3D> {
>> > -                msecs_to_jiffies(value.get()).try_into().unwrap_or_de=
fault()
>> > -            }
>> > -            Self::Max =3D> 0,
>> > -        }
>> > -    }
>> > -}
>> > -
>> >  /// An adapter for the registration of serial device bus device drive=
rs.
>> >  pub struct Adapter<T: Driver>(T);
>> > =20
>> > @@ -379,7 +350,7 @@ macro_rules! module_serdev_device_driver {
>> >  ///         _id_info: Option<&'bound Self::IdInfo>,
>> >  ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>> >  ///         sdev.set_baudrate(115200);
>> > -///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
>> > +///         sdev.write_all(b"Hello\n", 0usize)?;
>>=20
>> Note that the jiffies type is being converted to a new type (in fact,
>> `Into<Jiffies>` only make sense with it being a new type.
> I assume it won't take long for the patch series for the new type to be
> merged. Currently there is no user for any other timeout than 0 (which
> corrosponds to MAX_SCHEDULE_TIMEOUT in serdev).
>
> Or should I revert to `serdev::Timeout` until then?

`Timeout` uses `Jiffies` and `Msec` directly which would be changed too. I
think we just need to treat this as conflict and figure out how to handle t=
he
conflict.

I think realistic there're some designs to still iron out for the jiffy ser=
ies,
so yours one may land first. The easiest thing is probably just have API th=
at
take `Jiffies` type directly without `Into` (as having it doesn't bring muc=
h
value at the moment), and that can be converted by the jiffy series.

Best,
Gary

