Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD344D9F6A;
	Wed, 30 Sep 2026 13:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790776388; cv=fail; b=DVMVJYGRX+7RvTUhZsK78qVjWceyPEK7SvLB1W7DTbx10QiRYtjmZuX+/e8F/ZEEyKiAs+I08yv1BLAg3Ik2DTqt5BurcHB2uyjivlauuJwXuF3T8JeASSs9VJ47Q8GO2Ilg2EAruz3i77m8RFM4Ep1qTg8JU742f8G0g6Uu5DM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790776388; c=relaxed/simple;
	bh=w4asgwYTOxNoK/8WuInm6stdc0IS3wgVd4u9oJ19LIw=;
	h=Content-Type:Date:Message-Id:From:To:Cc:Subject:References:
	 In-Reply-To:MIME-Version; b=KdJE1mXe+mODPaFxtP8fxJ5og97D5jmNXAh4zXHyUiRze/GTVe+mGp1Onsbk8MDkamUQsDa8SwxLqS3Z7d7pDghQFhtEqDsNH7vJvrh/bwygqXQLkFdzlkymQLKDaGylJSEfvDu0cceyxzn4Vvk4jfOaI0O3RB8TlRC65ApAMrA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=PRvk9fu2; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="PRvk9fu2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8zjF0Jsr222oK0rnSsSUoD3gphsV2YfmM79A1JhjpmuuaxN2r2S1x3LvLE/Gw9FacJP27OHkqgF+Y69RPv5xChNkMTr/l37A7B0Dr5YXB3JPkJNcZNP2VOxrAQlC65qSsZsMt5rawvYWEKCHwf8J/V2VyzIRzh6W9mp0cDNVXu9EtpoxiDQ9ZYSiOT+YpmuvjkxSdHqR6oFizfheLICbIv/i9ZyLoFGSbUqGXhqZUWeBPeGM3Kgu3I/f1VdQ3zV+soCtbwRgj9taUvlCPlux9y2W1U5+de+zhCLXflniim7fm76Ms2Wf18pbwZvrVDIHprrViWBFxWADzPpu4QhOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilz5ybdMvUBPyNe2CuKTaY68YwvNK7S80D0j5Vt+8R4=;
 b=Z2AWnydkeM86WVaFLB53nKKm9t0xTp5m/CnU0r834sd/YL7SCkjdKy/zUIRNBjGle0KEVb5VtjUrr6BSm3cuH5s4lt8/zi0DjYHwIju/WmiPNbuhDXjUVi2457hzNh/lidujsh/rv8MVsyC8xFCdAX6fnPVEdSsZtDMQ1X73zRhx0K6i2XBL9V7QXcW/HX+51acYoEA37NXNGtAC3UNUOJLiEJi9paT+FMOK8o+nCiwbfwoxOgsuTYiX6BkUDWSa+UuuXmvGX4icTkDfe0a91V0VZWEazORJA/Z85Z9LUSL+1dCik6i/NE/m+YNpWnJ4F6+9woGdaFd+BggK39uQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilz5ybdMvUBPyNe2CuKTaY68YwvNK7S80D0j5Vt+8R4=;
 b=PRvk9fu2i+EzkEnloX8D2Y5TXaHT1cVfyKWmLMAw+JAjdtNf8BPzht+iyHQ2E95GxdmuV1tYee96BEI54qM9s0UloA5/GH2VJBnHT1FEhGcNHXXXXBc0JdOcHV7xBENaSb5aXx+yLcRKDiZCgqJmDTSPrzkDOJY1oZYH49nH6HU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB9199.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 30 Sep
 2026 13:52:51 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Wed, 30 Sep 2026
 13:52:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Sep 2026 14:52:50 +0100
Message-Id: <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "FUJITA Tomonori"
 <tomo@flapping.org>, <dakr@kernel.org>, <ojeda@kernel.org>
Cc: <a.hindborg@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <bjorn3_gh@protonmail.com>, <boqun@kernel.org>,
 <daniel.almeida@collabora.com>, <gary@garyguo.net>, <lossin@kernel.org>,
 <tamird@kernel.org>, <tmgross@umich.edu>, <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "FUJITA
 Tomonori" <fujita.tomonori@gmail.com>
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
X-Mailer: aerc 0.22.0
References: <20260930041339.1551129-1-tomo@flapping.org>
 <a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
In-Reply-To: <a8693eaa1f8eeb167ee334e7c35371832e43bb4f.camel@posteo.de>
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 3695d25e-dab9-4443-25d6-08df1efa1e4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|23010399003|10070799003|1800799024|10067099003|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	q3oNvjGKK4hH3W5twE3TQpEofIH3yqi01w2bVC7wMUeYc0B0BpPZb2+SmQ/0XkEMKICBa4SGqyksycecJSdR/BVGUApqzKJFise1Rn3i2azndKYxP7FMAdBucjM/Rk7LYd2y0Sk3lV+IXTjTnvstTSzsYJ8t/GwBmBTknXfD++R3xF7K4u5fGtRaPeLIKKePz4yPHoQgOjXpAToLiqwllj8QG0jOE4mGjHJD7qs9GES0IN39K6VfRlYKyeZJD1A3H6O6fXPcJrKFTQ/lJa1yBNY9OZsbGo9IYV53VhMgpZPwEC5IGehPiQUNYIFcS7eAHR08GE2PolwgmHSkgK3tl5ATDsLbyCcs7NNL9jPF53CEkwZCZGXF8eWs1/OVwPs4tk1Y/AkduB4FGNczb2B966nwzsKZSQUdf/l5Qvp6NFpEV2LNeAPmYIUyRX6Qogqp3I3tv8IBv2JCXGshwfBptmLRhdDhgzzJciLq8dLz2BshdQ20IIXxlSTDKKCg8Z0olDo0lRFL0vQx3BC1clSb1d2feWVIfQ0LT7PzjtfNyGaA1hjkGDeztNwsASBPJT7jA6TNMdqX8yf2uirTPNLGixNy9ozaIC4SIpF1/6xIm8SPSsyAwoTIfs/t9YElMT4hyqteNRhmescB75CNk4jT5kUGYp6YBBQjsN31Xoxu7WY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(23010399003)(10070799003)(1800799024)(10067099003)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SENUTEtiUGhBazNRNWRnVHp6dWtSZm4wVXVPR1YrMXZqd2lYKzlSMTRPV3Bj?=
 =?utf-8?B?VHRhM2xzbHRHbEJPK1dGZ3hkbUx5emErVG1WTnNWV0RSQkJ1bVIvMHUxUTNm?=
 =?utf-8?B?TkZGNDNnQ2pqNi9PN0pkNjdZT3ViRWJEaTdKWHVaOWxvckZQS3YvemgyQjRq?=
 =?utf-8?B?clBSK1RtemhXV1RweWsvcU9EYmtLeXpHV2xBemJmU240SWQxSEtlR09pRVJJ?=
 =?utf-8?B?RnllRXZNc1Y1RFR4K3plY2VBWUM3R3ZnM3JNYllrTUUyY0xjek5sZzlxVzZq?=
 =?utf-8?B?cFh2UEhERHVEbGJCWVJ5c21yczUzeWRybk5ENm05eWJPTENkL1JJWVM3M3Qw?=
 =?utf-8?B?NXR6S3BhZUJkc2dWc3JvT1B2VWszbERCaktXTnJOOW40YlN4NmdmQ013ZTFm?=
 =?utf-8?B?clI0RkFuaENKV2lUdHJ6dFQwUHdxa0F3cmM0WjdtUWFiSXF5YnRpajBBUWlV?=
 =?utf-8?B?NGxhVmlGNkhTeVpNRmpqTnRxUE96UEM0ZWRSTXpWbVV4OHJZNFU3UzJDZGdT?=
 =?utf-8?B?UnRLNkwrdFpKK2N4N25XVnFJOExlWVB5M2JRSDV5SXR6SGtFQ205SkpVdTJX?=
 =?utf-8?B?MXdZR1RMakR4U1VSMVkvSHJKN0JKd2lnQkI4NzlzdTl1andXR2lMVGQ1YWM2?=
 =?utf-8?B?SkRmMTZBbExSeWVCRjlTS1VRU3ZQQStYNjl0ekVvR2p3eXJIdVhncmUxcFFa?=
 =?utf-8?B?VnduZXZWWEhVSHArbkJRaytIMTJmRzFhMnIrb0lveldhWnh0U3pNUzBVWjdR?=
 =?utf-8?B?UkxJZEJDZjUxT1F1bUdHOEYwNTBlalZrK0llUGQwdUJUWjQ0bnZZSU00eXRx?=
 =?utf-8?B?RTdFMWVMV2pkc0xRZE5Bd2FzZTFhNXBiMlNvNy9PckZxWnRVd0phU3cvUFkx?=
 =?utf-8?B?cUp3VS94QjNnbGFMWCt1ckhGaUpzY1lRSEpWejZ0OHFobWxkd1JOaVo5bkVX?=
 =?utf-8?B?ajh4blEzMUhTdE5kZmlFbWRKclAzZ0J0NFNSaU5RLzY2RDZBcy8xSkd1dEdP?=
 =?utf-8?B?d1ROeEhudThWbll4RHE5MzJRT0dHb2t3S3NPcEZ4bE5iUnhNck4rcDJRMW1B?=
 =?utf-8?B?RDdiYmEvNjBqeDhhT3hoSVh0TDJZcHJHK1cwcEU5WDVKcHFSMjNiVG4vR2tP?=
 =?utf-8?B?cDBaNmVpeGtTeG1HNnJpbWlDTUtFYnR0T0dSVGVUd1kxV2JNR1lvN1o3TytJ?=
 =?utf-8?B?bTJtTy9GQWFKNjZBU1VETkZUQW9LN2J0UFZiZjM3cHhGWVdwb082SkdmQUJ0?=
 =?utf-8?B?aVF2cXpJTXg0aTdxQ05WQnBNOHJtUTBJUVIwMFZVdUNVN0xNay9KTUpvQXFF?=
 =?utf-8?B?NXZBLy8yTy9sTlg5RmVoVHk4V1kxQXU3ZHdGM3czYUd3QVRHSUt1NThUb1pK?=
 =?utf-8?B?eU1EbkNxM21KWUpMc0FGOEJWR1dKZTRjMnhIREMza3oxVTdBQkVXZDVtV2pZ?=
 =?utf-8?B?ai9zcGE4eWFwLy9TdUhGM1BvelR6c3ljWGtZV3dZL0FkSjhjcDhXYkZaeWQy?=
 =?utf-8?B?Y1k1SFNNUWFJRzk5MVBZaGx3RHY3dklGVFVwU25HRlkzTEQ2NUp4VW9maDdL?=
 =?utf-8?B?M1NxSnpJRHhhblJTYXZ0ZlJ1R0JJdEF4QVd2ZkxUd1Z2b2UwTkQ0MTFvTHJX?=
 =?utf-8?B?eHJQR3poT2k1VFc0bERheFlQbk42UTZwenVTVWJhNCt5OWNPL1VHVVMyL3V2?=
 =?utf-8?B?TUpGbTIybTM0UEdsWXhrS0xPZzdOVVhGL0hzaXMvaDFQaUJtdEwyTHp1ZzV4?=
 =?utf-8?B?NUdSRkZzRGdFd1ZUYWcyL0Qyem56T3NINVBUbjVBUTNvRHJhQ0hTL3hMRDBK?=
 =?utf-8?B?cjB4cjUwMVBJSVBXbitWbkc1Zzl3a1VIclIvSElIQm5xTzhoZFFjSkd0eUMv?=
 =?utf-8?B?bGNDNjgxcU4yRFBHODAwdmhweGRrK0FqdWU5U1RzREZOWVFMa3VoTVhDamNx?=
 =?utf-8?B?N3dZaG8rOElSeTRETGQzUWVqZGRpT0QzOHpRajloVDdSSFNtUWlwRGdXZEJn?=
 =?utf-8?B?STNYS0J5L096d0JCaVg2ZkR2dEVxTExuaW9kL3NMZ2dqaWQvVEFadXkrTnpR?=
 =?utf-8?B?S3dpU3E0cUswREl1TFYwaElkTGxEa1I4MEIrMVhudHBzbklWT0JiS294S2hj?=
 =?utf-8?B?UExuN1hneGh3OG5Eb3QxS1VqVU1IeVFqaWxGYnhxUmtEVTFmSU8ra1pURjJP?=
 =?utf-8?B?QXVCWHlmdHY2dUJZUnBjQkoydzBYQk9GNk4yYklabS9EWENPOVhCVmwzaWhO?=
 =?utf-8?B?S1hEbHFPMXpsVENQL292ZEJpOVZBcFpmM2ZCa2pSSlZCbE9yakhPMW0rZ0dD?=
 =?utf-8?B?NWxPUUI0RGNLL2dsVUxYV0JyLytBQ2VEblo0ZlVtdis5bDM5SExJdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 3695d25e-dab9-4443-25d6-08df1efa1e4d
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 13:52:50.9956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAfNH2ndQ5fBu8hw+Y1bZ7E4DQs/gqcChrmejGBjpaeCYiFiPzj8skRdfj7QAXd6T99rIKDt5ZZMg2PPlEhbuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB9199

On Wed Sep 30, 2026 at 1:59 PM BST, Markus Probst wrote:
> On Wed, 2026-09-30 at 13:13 +0900, FUJITA Tomonori wrote:
>> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>=20
>> write_all() and wait_until_sent() take the timeout as a raw Jiffies,
>> which is a c_ulong alias. The type does not show the unit.
>>=20
>> Take the timeout as Delta<Jiffy> instead. Clamp a negative timeout to
>> 0, as the current code does for a value larger than isize::MAX.
>>=20
>> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
>> ---
>>  rust/kernel/serdev.rs | 27 ++++++++++++---------------
>>  1 file changed, 12 insertions(+), 15 deletions(-)
>>=20
>> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
>> index 17ca504b7f8d..094503f059ff 100644
>> --- a/rust/kernel/serdev.rs
>> +++ b/rust/kernel/serdev.rs
>> @@ -20,7 +20,10 @@
>>          aref::AlwaysRefCounted,
>>          Mutex, //
>>      },
>> -    time::Jiffies,
>> +    time::{
>> +        Delta,
>> +        Jiffy, //
>> +    },
>>      types::{
>>          Opaque,
>>          ScopeGuard, //
>> @@ -481,22 +484,19 @@ pub fn set_parity(&self, parity: Parity) -> Result=
 {
>>      /// [`kernel::error::code::ETIMEDOUT`] or [`kernel::error::code::ER=
ESTARTSYS`] if interrupted
>>      /// before any bytes were written. [`kernel::error::code::EINVAL`] =
if `data.len() > i32::MAX`.
>>      #[inline]
>> -    pub fn write_all(&self, data: &[u8], timeout: Jiffies) -> Result<us=
ize> {
>> +    pub fn write_all(&self, data: &[u8], timeout: Delta<Jiffy>) -> Resu=
lt<usize> {
>>          if data.len() > i32::MAX as usize {
>>              return Err(EINVAL);
>>          }
>> =20
>> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
>> +
>>          // SAFETY:
>>          // - `self.as_raw()` is guaranteed to be a pointer to a valid `=
serdev_device`.
>>          // - `data.as_ptr()` is guaranteed to be a valid array pointer =
with the size of
>>          //   `data.len()`.
>>          let ret =3D unsafe {
>> -            bindings::serdev_device_write(
>> -                self.as_raw(),
>> -                data.as_ptr(),
>> -                data.len(),
>> -                isize::try_from(timeout).unwrap_or_default(),
>> -            )
>> +            bindings::serdev_device_write(self.as_raw(), data.as_ptr(),=
 data.len(), timeout)
>>          };
>>          // CAST: negative return values are guaranteed to be between `-=
MAX_ERRNO` and `-1`,
>>          // which always fit into a `i32`.
>> @@ -547,14 +547,11 @@ pub fn write_flush(&self) {
>>      ///
>>      /// Use a timeout of 0 to wait indefinitely.
>>      #[inline]
>> -    pub fn wait_until_sent(&self, timeout: Jiffies) {
>> +    pub fn wait_until_sent(&self, timeout: Delta<Jiffy>) {
>> +        let timeout =3D isize::max(timeout.as_jiffies(), 0);
>> +
>>          // SAFETY: `self.as_raw()` is guaranteed to be a pointer to a v=
alid `serdev_device`.
>> -        unsafe {
>> -            bindings::serdev_device_wait_until_sent(
>> -                self.as_raw(),
>> -                isize::try_from(timeout).unwrap_or_default(),
>> -            )
>> -        };
>> +        unsafe { bindings::serdev_device_wait_until_sent(self.as_raw(),=
 timeout) };
>>      }
>>  }
>> =20
>>=20
>> base-commit: f1850e443b0e4f2429ddf42a8d5033ea54ae8a90
>
> Both functions have "Use a timeout of 0 to wait indefinitely." inside
> the rustdoc.
>
> Make sure `Delta::ZERO` is also usable for `Delta<Jiffy>` and replace
> the 0 in the rustdoc with "[`Delta::<Jiffy>::ZERO`]". You might also
> remove the "timeout of" part, but I don't mind if it stays.

I think the API should ideally use `Option<Delta<Jiffies>>` for this case, =
and
use `None` to represent indefinite wait.

We might need to round 0 jiffies to 1 to avoid C API change. But ideally th=
e C
API should be using MAX_JIFFY_OFFSET to mean indefinite..

Best,
Gary

