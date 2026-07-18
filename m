Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021124.outbound.protection.outlook.com [52.101.95.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC0337BA4;
	Sat, 18 Jul 2026 15:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784386961; cv=fail; b=YYNdfhIhyDl7W3oLLUjbJ838uNMz/zE3vkkEJzc/de+jH5WVBthHymfPDYqKeRHSWzEs+ozcZyRZzCxbNVEg4BNJ6SLdtNdFnpS79d0Jc44VJZG3vd4ak+FBiIZnIhtp0M5mHhd8dE/+ewxY/+9ePfyGwLP45+N/MCK+Ov/CLFQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784386961; c=relaxed/simple;
	bh=R1zdfw0tKlpToeFGy/2bvbjF7pMBzVgU5hEWxDHc2Oo=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=jXcfOGRwLtOqhbNQzEWYU5GvW6QOtAG3AIeic1kuIVumb7RUZl5z8bwfyloimW68bFdq1FtIrqCouAEHjppFT2sbwyL4NpsXO2iFXg1S+gKHg6ruM6p72BY0qYaVgu8vhb0ZlEAIdo4PmM4x5XrrEQbYrCSt+DLfAUVWsGfdsqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LTw0foUK; arc=fail smtp.client-ip=52.101.95.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LTw0foUK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfDcdpGt9wqp511Wuam8RnTMlx3eW1kzZuF4+R8BHs/VBlHe401CINAIADeIjpHXpnadMyxts1SjzBIwzDpo+0xjxVIgILKpeQzz46itgnxKM/J/L4HOxywxZSiJmUsnMfat5QLREIb4eZl8sS3o65muxKXDrbaLxiUP3ASNHDKqAb2Rb0m3Q0EtBtnIu4wfjixAir0aHIMdacsOBt1l++63RUV4zNVly1NFw6cjD/nTBnrSPd/TUdIIIyoUlLj79ckQJSaJJ28ZNrjNPAnxGcYn45X+CkWTz+LKoBouj9t01NxxG+Hikf2IaQk7gdfc+Zoc7I+Yq8c2/MOLIocMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPVQfCFCjHhmEPsimXkiq7/hXup6EZTJENn6kCMvgGY=;
 b=TkAoqN0JUDm8WyxcVYFqdIPeuo+wbq5/Vo5aBDsFwAVCUHoeS2oudSPBiM0C/ILM1stA4ApNg6R8jbaOYRMz3Eq+a7AD+J/kOyEPU4L95EkYfV2Vnuu61I/N7jjtj2cif11+Ww4nsDyPd37nveC3wYcTJm5f1o9UFqRK6UxbZwFq35alQEyG9WonLUu2YzhY2HyW4UOqWAYCFw/nfYtb0B8WhcR+kHMB/FDGBFbg7rs1m4cNJkrFsTGaqyXBs7NKFAngjL2xF8z0lHmT3HmeI+TpI3z4f8L5cUOfEOu2zIGcxm0J8MP/K+qB5o75/3NYjPl836WJB9cUuMKWXwPDCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPVQfCFCjHhmEPsimXkiq7/hXup6EZTJENn6kCMvgGY=;
 b=LTw0foUK7+fWFvu5tDi7uYy5G8WZAvObvKLckgnfCTKJ11k4zmDAuGYcQCbNbBhLZ0+OLT4dSH7oWfEQtKe3zc78tX2WOTNIJCuPJrLRbGtVvcQl0ISHpH3mIPDLV0nwauF005erTt4OQvqMP2jq1j+LxO2Fnz0XonTXnAQ226o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB2993.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Sat, 18 Jul
 2026 15:02:32 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.013; Sat, 18 Jul 2026
 15:02:32 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 18 Jul 2026 16:02:31 +0100
Message-Id: <DK1SDT57QY13.3ZXZYQGOTK2P@garyguo.net>
Cc: <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] rust: serdev: remove `serdev::Timeout`
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
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
In-Reply-To: <20260718-rust_serdev_fixes-v2-4-e5214e03de13@posteo.de>
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB2993:EE_
X-MS-Office365-Filtering-Correlation-Id: f9576ca6-00e2-4f89-cfb1-08dee4dd9820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|7416014|23010399003|10067099003|4143699003|56012099006|3023799007|6133799003|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	TnvSJFmMrxJG9VDTKcjrBrBPlNWWUZ3O4vp/hpVQR+5zln829F6zg9TsR6g6SnXpoQmupOlPVJqrNHSUuOqUNAfsX/xyxC/7THNFKSk2JeepkxT3rUUA2TM8adgToacwB3pP+lYKuuEKa3RgYdx+ubWzFLWU4UgnAnyDGjLw3tn1/M1jqXvR6LhlkWS/p0493dZnyJc21anB4Fkw6Vtahld5P/w+W/sh4rK/YS7s4a2/87uscafppt+k/922/skUCtjto6EM5hdZxx6awkGBWnXYGJVj/G9+N2VKc0FtrADoK3gQ65esv9U9kA1ksc6Icb5bHMum45x0zmXlA4zaGBQrpNeUnSNC4UsMBpanjveCkf7mL4AsiMVGvjQ/VpPKBNm705C9m1dKzuntqTkJxUKmFEXUuXiMKfBnYJNBSCrGQT8OGAU8xKfiNrOVFUPz4+T2R+oXRZz2QEV+7FF4CkS6Clb7ySpiJMM13f+bBjipr04QlskN+2oC5Ntnf5dQSJ2ILkFWxp0q/ATmbhXQNv81gO9thNdpJVdsO2byJ843BeXEzaNEVvicEmqy5Ml+BnxujEWVs1ZpmFD2miPoqPqnXIxUM9JIp7H1yfr2fMcqR/UijeA1TrxGKksPPkdxXkWumQkVLr+eRBOc1IZQffq+c7uZXfjvGqSaGFj/LTYBr2kcQJF8Yw44LtEwB0eiSBkFParIisacGVp45XM3wQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(7416014)(23010399003)(10067099003)(4143699003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cStlOUV0bGpiNUx0TTVPd3ZuRW1aSVBjNGc4YmlmK3BSQ3hKdWI2bGRVZ3lT?=
 =?utf-8?B?SnNWLzgxNHVHSStLOGFzZmpNOEpsTU12Y3c4anBRNGpZRGk3WXN5K1FhL2xE?=
 =?utf-8?B?MTJYMHJoV1hxSFNvOWVWekh3b2VMaHREOTVEbWhFTlF3eWFLZExWYWVLWDFU?=
 =?utf-8?B?ZVl6ODVEUEp3czgvK1czSFdoNzBuNkNmd1p2eWM5VkFUWFpOdzNXODdUWUpH?=
 =?utf-8?B?NmxkeFc0VjlTcXpnSDVxS2tDb01WSVFvMU9hZHBvdnBWVW4ybEFvSzBnSTJC?=
 =?utf-8?B?RXlHejdneDBocXViR1NUQW12Q1htUVdicnFnU2Z2MkNCZ3V6NjRBTmh5YkRG?=
 =?utf-8?B?NkVTRHIxOHRGeWF4UXJ2cjkzNVNVbFVaaitwS3plemVQUVJ1ZUhqa1k0Z25S?=
 =?utf-8?B?dHV0OGhqWU5MeDF0Y0k3ZjBURHhnSWRNek9IUm1xVHlwK0wySlZqQ29KbFFP?=
 =?utf-8?B?cTJCWGhFUlBwNjFxMzhKVmtoLzUxckdZU09pZWJ4ZHgyQVlsSjUyYTJTeHo0?=
 =?utf-8?B?YitEMlo2cjY1NXRrU2hML2JtamdPOXl3RUNkMU5mMzVvRnRCNzN2RHJzMEFv?=
 =?utf-8?B?NUJnZ2hkVjB6WmE5clVGYUt3ZHI2NEFzZ2xFN2NIT2d0WXRNWUpLMTFDbm9W?=
 =?utf-8?B?VFFkTXFHaUwyc3pZcjlmam43WjBhNU9zSHdOUFRyRmcyYWYwR3RFZGEyL2Vs?=
 =?utf-8?B?ZVppNHF1UnhEek56cHRydUxJVDZMWGU1ekNVTGorUVY0Yk9MMlR0M1JBMmdO?=
 =?utf-8?B?R2hORFNQUWtiaXZCQjNSZ3IzeXNuWWk2Q1JnZ0RKQ2xEYkhtTHVKYTdOd3Ju?=
 =?utf-8?B?aUl3WVMyc2dySHgrbWkwZy9xeC9Ield3Z2g3cmVwekxvOExPTHZzNGxwUEJq?=
 =?utf-8?B?WmZiZlg2eWNHQ2w0OFAvRUZjSG1WcWU0dmtJVGhGTEw1TjlDUjd4NFoyR2Jr?=
 =?utf-8?B?RzJoeUZMZFNKcy9vaFlUVlVjbEloWk9NMUd1RHdTMi96aWlHa2FDWFJNV3FX?=
 =?utf-8?B?Q2ZKbXlWdDc4U0szQkI3RUk1YzBxYXZoZktSU0RkUEZ2SUFKR09UTTNGcXNT?=
 =?utf-8?B?YUlTZERJTlh0MFVUSGJ4VTBmbGkvMmpYVE1IUWxsTTZRZEd1VXU5d3M4bGtk?=
 =?utf-8?B?NERGaU1BL2h6aStnSjdhYlZkcEFUb0kxNnRZNXpDQXlLejI2ZGRERnNPOEZK?=
 =?utf-8?B?MFJydUV4dDNhQVNqMTBuZWdzQlZRdEo1TllZb24xZkRmNFRLRExRdnFZUVpw?=
 =?utf-8?B?VWYveFRLanpCUFZPcGl3WDFsNVFQNE1IVU0vRi9sWTRWSkJpcW91QXp5YW83?=
 =?utf-8?B?TXJXY1ZaVGx0WjZSa3NMR04wVVY4T1JNWk95d01lRnFaZTlTSnZJSFcxdG8w?=
 =?utf-8?B?NkNBTTdGdzhnVXAwczdaUDZWVjlmb1hwSmFucVpHdUJ6a3Bqa1Ewb0tjKzJr?=
 =?utf-8?B?YjVHMWhNaGpHYnVMS0RGR3J3cDNRS1p5V3NXSlJkek5IYnU2KzVHcnRXdnNy?=
 =?utf-8?B?djIrMkVpM0ZWYWxOUHhzMVNOYndLR3pRTFFYRUdzWll0QXhTU1M4UFBzLy8r?=
 =?utf-8?B?Qk9aZGh5MXNuekR0eDZtVFEwalQ2Wi9vL3FtRnh5TU1USVl6WEFtSnlveGxL?=
 =?utf-8?B?OERoYVJObDZLc2Q4S2lRSVV1amNuZVJYdUpLMHZSc1ZRTVZRTDVOeGdlTzI4?=
 =?utf-8?B?dVR5NFNUTXlkeUt6WGZzR1FmZGc1OHhaVmh5MUxkOFFJYytTZzlJcEtoUzBi?=
 =?utf-8?B?M0g0bkxmOFZMaTAwNWd3TmdIZzdiK0xPcEM4NlMwUUhHbGZsYkJEZ1Q5SDVv?=
 =?utf-8?B?eWxoTDhnU0dEVmJxVGdqemU4VSt6dWdLQWFOdzdOOTB6WmcvS255Z2hDRzhx?=
 =?utf-8?B?V3FNSTBuTlVIc20xa3V4TGEvN056TE1lTngyYWdNbDdtMDVsZk9sY3lmV3gz?=
 =?utf-8?B?Y0V4dXR2M3VTL3NZUHJwSEF4SUZFeTFrK0lUTm9OMnpQWEFvdHhma0ZlODV2?=
 =?utf-8?B?dG1uV01uaWxjaEMrZ2JzY0RYY0d0UCtFeGJMQ1MxdU5rSjB4T2c2UHV6bkFG?=
 =?utf-8?B?WGFxSUZISkdla0grWWp2RzVYYWM1cE43STJQejdScnhrL1lLa1M3NWNaNjY0?=
 =?utf-8?B?c2dDd3M3WXRwdHcwR0JuRSsyMTFGZWhpa3R2WG85SFhuMXRaTlBXUFVsWVJX?=
 =?utf-8?B?YlVZVEUzTnlyeDI0dnpMbHpqSTVGWVluUFhBYWtIV2E3dG1qemtzR3pua1Nl?=
 =?utf-8?B?d01sanRvY3hBQ2ovUmpDcUIyOVNxajliSmduejJxSHl4eGgyQnhzZ0RFMDJm?=
 =?utf-8?B?WE51UWt6dXpDL3duQjVJeksvVjdKVXhwSFlPRzJIMyszRUpXRmZmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f9576ca6-00e2-4f89-cfb1-08dee4dd9820
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2026 15:02:32.5520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Np/ipW82rYMrSSDR3CnDjvNxJPgFzKAXmTiDNu54fQgri69k3v9obivFc9FqRJNkN1pLHHiqkvR2yjWujS3Gag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2993

On Sat Jul 18, 2026 at 1:47 PM BST, Markus Probst wrote:
> Instead of relying on its own timeout types, the abstraction should make
> use of `impl Into<Jiffies>`.
>
> Suggested-by: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/rust-for-linux/DK0SX3P5K1J6.1OV4ETJMXW83R@g=
aryguo.net/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/serdev.rs | 55 +++++++++++++++++----------------------------=
------
>  1 file changed, 18 insertions(+), 37 deletions(-)
>
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index a78dfa6e2c27..0fdb37cff15d 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -20,11 +20,7 @@
>          aref::AlwaysRefCounted,
>          Mutex, //
>      },
> -    time::{
> -        msecs_to_jiffies,
> -        Jiffies,
> -        Msecs, //
> -    },
> +    time::Jiffies,
>      types::{
>          Opaque,
>          ScopeGuard, //
> @@ -35,7 +31,6 @@
>      cell::UnsafeCell,
>      marker::PhantomData,
>      mem::{offset_of, MaybeUninit},
> -    num::NonZero,
>      ptr::NonNull, //
>  };
> =20
> @@ -50,30 +45,6 @@ pub enum Parity {
>      Odd =3D bindings::serdev_parity_SERDEV_PARITY_ODD,
>  }
> =20
> -/// Timeout in Jiffies.
> -pub enum Timeout {
> -    /// Wait for a specific amount of [`Jiffies`].
> -    Jiffies(NonZero<Jiffies>),
> -    /// Wait for a specific amount of [`Msecs`].
> -    Milliseconds(NonZero<Msecs>),
> -    /// Wait as long as possible.
> -    ///
> -    /// This is equivalent to [`kernel::task::MAX_SCHEDULE_TIMEOUT`].
> -    Max,
> -}
> -
> -impl Timeout {
> -    fn into_jiffies(self) -> isize {
> -        match self {
> -            Self::Jiffies(value) =3D> value.get().try_into().unwrap_or_d=
efault(),
> -            Self::Milliseconds(value) =3D> {
> -                msecs_to_jiffies(value.get()).try_into().unwrap_or_defau=
lt()
> -            }
> -            Self::Max =3D> 0,
> -        }
> -    }
> -}
> -
>  /// An adapter for the registration of serial device bus device drivers.
>  pub struct Adapter<T: Driver>(T);
> =20
> @@ -379,7 +350,7 @@ macro_rules! module_serdev_device_driver {
>  ///         _id_info: Option<&'bound Self::IdInfo>,
>  ///     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
>  ///         sdev.set_baudrate(115200);
> -///         sdev.write_all(b"Hello\n", serdev::Timeout::Max)?;
> +///         sdev.write_all(b"Hello\n", 0usize)?;

Note that the jiffies type is being converted to a new type (in fact,
`Into<Jiffies>` only make sense with it being a new type.

Best,
Gary

>  ///         Ok(MyDriver)
>  ///     }
>  /// }
> @@ -505,11 +476,13 @@ pub fn set_parity(&self, parity: Parity) -> Result =
{
>      /// [`Device::wait_until_sent`] to make sure the controller write bu=
ffer has actually been
>      /// emptied.
>      ///
> +    /// Use a timeout of 0 to wait indefinitely.
> +    ///
>      /// Returns the number of bytes written (less than `data.len()` if i=
nterrupted).
>      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ERE=
STARTSYS`] if interrupted
> -    /// before any bytes were written.
> +    /// before any bytes were written. [`kernel::error::code::EINVAL`] i=
f `data.len() > i32::MAX`.
>      #[inline]
> -    pub fn write_all(&self, data: &[u8], timeout: Timeout) -> Result<usi=
ze> {
> +    pub fn write_all(&self, data: &[u8], timeout: impl Into<Jiffies>) ->=
 Result<usize> {
>          if data.len() > i32::MAX as usize {
>              return Err(EINVAL);
>          }
> @@ -523,7 +496,7 @@ pub fn write_all(&self, data: &[u8], timeout: Timeout=
) -> Result<usize> {
>                  self.as_raw(),
>                  data.as_ptr(),
>                  data.len(),
> -                timeout.into_jiffies(),
> +                isize::try_from(timeout.into()).unwrap_or_default(),
>              )
>          };
>          // CAST: negative return values are guaranteed to be between `-M=
AX_ERRNO` and `-1`,
> @@ -570,11 +543,19 @@ pub fn write_flush(&self) {
> =20
>      /// Wait for the data to be sent.
>      ///
> -    /// After this function, the write buffer of the controller should b=
e empty.
> +    /// After this function, the write buffer of the controller should b=
e empty or the timeout
> +    /// elapsed.
> +    ///
> +    /// Use a timeout of 0 to wait indefinitely.
>      #[inline]
> -    pub fn wait_until_sent(&self, timeout: Timeout) {
> +    pub fn wait_until_sent(&self, timeout: impl Into<Jiffies>) {
>          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a va=
lid `serdev_device`.
> -        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(), =
timeout.into_jiffies()) };
> +        unsafe {
> +            bindings::serdev_device_wait_until_sent(
> +                self.as_raw(),
> +                isize::try_from(timeout.into()).unwrap_or_default(),
> +            )
> +        };
>      }
>  }
> =20


