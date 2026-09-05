Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021083.outbound.protection.outlook.com [52.101.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F10E36A022;
	Sat,  5 Sep 2026 23:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788651581; cv=fail; b=AgSxU1/qEjtT3Ez3Kdce9oEL7+3Nm0wjIXqfdzPiPDE6qnw/NjcsN1FnHVTMeMAniZIdsxTsbAZKtR10ip3MwsGiQ/XwWMqI+BV+odgbwGfJoFh8DWZvHvay/1LSxzfoj3PwR8fEfhR2Wm17gMIek+DG9dhqyCTE7obNrqQLLWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788651581; c=relaxed/simple;
	bh=nn7406eNhJBePoAU8K7iVhSvvLFhD6MXsngDOXclLg0=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=bC0cHRMxzkErnrT/m8l4JT3LJ5xc5hOeBxtZMATz/Ct2swzCwyvYesQbMMwpjWd8sAAEinqddQx9qkCmjqjl8GLPM0IsQ88tjJsqAM2+ItHc3feVpQuI4WUaPuYzRhr65g1yb6Fo3bhA3pXMP6l/O8zEvN0OYVn+gSF9c3zt+Zw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=P05lDEHm; arc=fail smtp.client-ip=52.101.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="P05lDEHm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L5n/DAYyVxHelCTffUYhaSiXVXWaKAMvwdhC7Ups9cBxVUXMqaKoQ9bpdl3yG6cjRHSa/mDL08eI5a9be0mN9eUmA0HyKW6gUSE15sg+KfWHjudHuEevRWJQjVr0O6rzMaUolXhGoDZiRrUuBQe9w9QfT84s/PtuJmbMj3wO+lnGejbZCHM5c2A+qq/mgctja64hladMN0dL5HL2MlNOEipqCqDd+ac8pKnlKQf8XkhRtn8Xsho5kak5iy+u1cI5vJxr2UbjemdHaiRJB05w1zoHBehSC1GaC41FtZt+MjNvrj38lWVFeiFkkiPVCA8xsLqJWlmbhS4Fx0Z3852eNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54YGzR5UisNvLK7y2e9goYC5g39BxS0jcSim5CjA6aE=;
 b=NDUa3ZB8DLNZqDwKZCiPsKnSJ9RB3nxo223oiYq6xCiVR9Xg+hevX1a0u7LgTKz50Y3fuKB9hY2nXAkftSi+MPJTETZmdHyWzNUaB8Ahj32jWAJvRvp/xCsYWbnnZz74tLNmxuo/skVZ441Gmdn/xIpg8CsI4KjpRz2i9IVCMzmmw7UkgF/xO9ymUc7bxKqAr/1kpZ8uFMDMMmzHelgltDEzBuPRFymXhjXSj5eyPWRlISU5ThEUVuVSPWb/EfPELDnz++WLDw6ScRtBEMZK297CYi1ylyOYLC/xhhBF9dLjGGu+3Nb2bVlrKXekGCFJaMVdyvDxCo5wF5/BZwI84w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54YGzR5UisNvLK7y2e9goYC5g39BxS0jcSim5CjA6aE=;
 b=P05lDEHm5FTf042x9Hni7UFahMIlLbiqS3Lat26cbjMUH+LzTdgJLttFbcNgp/wDA+eNL4eUgJ0REvb+611zm6vZ0+kScJk8CiUXciv6goBQhslMdaKMyvYLVdkG7pDN/mWnOYxkaDKURogHksyEXKGssyedZrhKcnAQcDXNcUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO5P265MB9367.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sat, 5 Sep
 2026 23:39:36 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 23:39:36 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 00:39:36 +0100
Message-Id: <DL7S2EDXP5IH.395Z0FSCRMNIF@garyguo.net>
Cc: <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko Bot" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v4] rust: serdev: Mitigate race conditions
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
X-Mailer: aerc 0.22.0
References: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
In-Reply-To: <20260905-rust_serdev_fix-v4-1-31e1bbcc0c00@posteo.de>
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO5P265MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: edd41035-9b2b-446b-cad1-08df0ba6f240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|376014|7416014|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gpxFCRPUUcRB/91AOzkP9veonC0ScyHTCa0zf+JdmMCUnWqqxYKa37O2C3Bd/JiNi5XSuF+pBpnn7deiCKawtx3KhtfIhnRhnPSyKg7lpJSPH/0u+o/pW3GjXpU4eTjsaMa8gRe85K0M9iyltAc95ue+Q2fenzgwdRBptGWr+RGApD0Sdf9rr0FKRnw8GI6iD6XJsVlkH0UDhESkgdYFsxF1aJDrxJcbstapTJcBETC4jebmz4LaVsx+mR5jxCsUGIjAMruz5Qu5ruQJYciXnBA2NOnYpdUKmAE4ymNqFKBUqllbC1S3bOdixWw2kLcdXg/pIZhp1Mom9LcRKSD3mcZwJfB8Wtuj1+nCm58snMs/UZTqHuVXx+lVfsaNKLJRcSEmc9PNNk9dV7kqSUlE5UgDjN9UVJff604NDyCYuRvxpuHeYLbJKD1Xou+rAv3GwiHLluM9j2IMBWh5w5NdD9a2RFmjUAI6tME1pK6DAfoBaCEWf8OGkf5828bSsgGW2jIXaBhE9fSgF9gr8S5Pk7PZj0/GPja+QIWMgQpRVlA+jNwGCLhE4pxMrmvE6N/dlhR80Qwi2cC2qG0i4aUVeRk1JB2BDlrwCj6lOzaDUgyZ8CxBMMMwCpW2Nnu6BCP+0tOwIByQ4JANqWriIFgx3iAhKow7g9emH0E8+twxvuM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(376014)(7416014)(10067099003)(56012099006)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUMyWk1tVG1pVlo2aUErM25FWmtBZElCMVhkby9KVEUybkt4OEJEbHpKYU9V?=
 =?utf-8?B?YVZoZzQ1ektHdXM0YjdFZXh4TGNFN285Rk4yb0N5MS9LTkFzOGlBclhlbmUz?=
 =?utf-8?B?VXhhWVB4SXB3WGxlQWlNck9vZ3Z4SFNiMlhZcnNYTUFYN2draHM0b01RQ2du?=
 =?utf-8?B?NWgydEEya2k0c1M4MHZyMjIrYUQ0NWNUQ2VYTXhZdzIxMFhSMGJ0OFQ5UmRN?=
 =?utf-8?B?R0NIZU1Kc3hUNmtFQ0ExQ25EQ1RIVTZja2N3UHZnWitjZUlrNXlGcWo2aVE0?=
 =?utf-8?B?dDVHcXYxTWlkQitISTdHU2lVVnY0YjlORVdJN0Jld0xBdldIMmM4WnpBQnVJ?=
 =?utf-8?B?aHUrVWczNEVQTzN4WnNRMStuRTU5QXVoditnTWYwTXpTdTNXN3JrWGlJSTM4?=
 =?utf-8?B?UW5HMVV1SWY1dVhvVDNjbW9PMVhpOEdIb3hPVUplVmI0ZXcrK01oSWNKVCs4?=
 =?utf-8?B?QkU3aGRkdjlZWFRzOW55aVBSRVBtbzRrc2JDKyt4b3RzSlE5QndYK1AvVmdy?=
 =?utf-8?B?TmJFZW5CQ1ZBMU1JZG5PbEltWmZ1ZmZ3MVY5OGVzUlpyVVhaV0ZSeERSakgr?=
 =?utf-8?B?N0YvbVFYaVl6NWxpQmxYZkp6RytpSC9wek9sS2RaUjErRkhVVTlLRHNDSTl4?=
 =?utf-8?B?bitaZkJUQWpmVlo1TmQ5bVdsZHBFa3M2Z0h5ZG5BUVd1Yzl1R20vL2Z0REFH?=
 =?utf-8?B?VFBud2FON1ozVVJUWWZPeGRLMFR0bjVKWlV3dmoxYlpMbk5pMUcwYXRFMEE3?=
 =?utf-8?B?TjdycWRJRWllMUdOZUhZWkM1SmNGR2VKT09Qc3VINUQ3VUFQT0o4RVNOa2kz?=
 =?utf-8?B?blVCVmkwYmJsbVl3Z1RwdmRXbGlsU2hsQTA2N3lxV3U4YWYwMVZsOWZVWXUr?=
 =?utf-8?B?MitxdFZ5SDEvTVdMRnZ2OU1nNUdKVUZ0R3Jma3NuMWp3LzJrbTkxM09vNHZj?=
 =?utf-8?B?UlVScDZ4SmQ2SDNCckFUN0pDR1htMHhYa2YzMHV1am9lSE0rckJqaDNYVEtp?=
 =?utf-8?B?V1ZjN1c4YmYya1d5U2l4MnhvWDJxMkoxWGsvb2g0NUtKcUZyOU5vTjl4bng1?=
 =?utf-8?B?M0U3enMwdDgxNGgwcFpRRHB0VVEzNjhCZXlpN0tRdUtPWG1RU0RxSnBqV2dQ?=
 =?utf-8?B?b1kxSCtKUUtjVFdJVXRsajBuSVZvbExaNURRN3FHMmlMMTJ0UVJMMnFERGhC?=
 =?utf-8?B?bitOZEdTa3AzWnhCSlFmTTIvUGpUc2dxKzdVVkloU0NBN21PNjVCL29VaE5T?=
 =?utf-8?B?bzdQclNvZnFVa3ZUZk5BbXFqcWhCRVI0N0VZYjlUbmNnMDBOYmN1elFaV2Nv?=
 =?utf-8?B?MFBtaWV0N2N4UysyUlZpNkZOTlFlNFVUeVpTOE1tYXdyaEtVRXl3US9EY0RS?=
 =?utf-8?B?UEh3NnlxMmNhUENQSlFsYnlwNnVEMzB6QVBvdWw0Qyt3cDJqYXUyRUorQk52?=
 =?utf-8?B?Umd0YWhnakV3Ry95MHRWYlBnUURPU2lkUFgycHhCWXVaRmloQ0dMZ3UxcmEz?=
 =?utf-8?B?dlhZZDJuSWtyVDRVeFZ0enZxTWJPdjRORTd5TnpVc3R3L01hY3JTUk1zUUxK?=
 =?utf-8?B?YTlKQ0FnandhTW5GN2lGTHpDRDJRSko4SjlFMWJaZHBzTjJPa2cxMmFKVFd4?=
 =?utf-8?B?WkFCWTdSR0QzTHVDeTROUXBzNVdDRzRnVEZyYVFoR0tMOXNtaXdNTGZRQk1p?=
 =?utf-8?B?ZEpvdndMdWV4VHZaWStvZUEvR1dlR2VKWFp3TE1pVXE3MkRFcktNOHB1ZzBp?=
 =?utf-8?B?NFR4NHFtc2xVbTM3SnRvY1l2cmcwc0h1OTFPeHFuQmhyenpGa3JxT0Q4bHQ0?=
 =?utf-8?B?UHlUaUlDb2p0cThWV0RrYm11YTJEeFNDWGpPRVVmdmhjcXcwaHhzTGtocHN5?=
 =?utf-8?B?OGROdGI0dDJYWldLZ3F3d1hSeXBVSW51blJWOVJtdmVVL2xpN1NiU09XOVpJ?=
 =?utf-8?B?L3FaYm9ydm9QTGh5Z3BmdEN3TzVPVUo0UnU2cG82QW15WDJ2dHZEOUFoSk5T?=
 =?utf-8?B?UGUwZTVSaTA3V2VjajBWTTVVdGpHMlN3elBFbnRsVUJoMGxtSTYrR1FkeXlV?=
 =?utf-8?B?d213QTBhZkhOQ2JXc3V2TlZRVXFmQlRNaUh4ckpBWmVTSmFiVU1pVUhweXVW?=
 =?utf-8?B?QzJDd1ZWanFNUlFOemlJbEs1Mk1YbHV5VkdmSFRhZEpEZzNSRXpWbDA4OGc2?=
 =?utf-8?B?UDlDTDVDUTJ6dytudlJmZmtqRWlJMHBrMFRTY2JYQ2hyOEVZYUplVURPT3Jn?=
 =?utf-8?B?UGxIQkEzWTVieFJQelRBc3hkUmhCei9XTUN2cmZvdm1XTVZWL0dqNE5GTFMw?=
 =?utf-8?B?RE0xazZTR05uWW00S3pacVp6SXhLZysvWmRmVC9OYzZYRU5XK0hMdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: edd41035-9b2b-446b-cad1-08df0ba6f240
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 23:39:36.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PY3R+P/c4ebFy5q4KmJ0qCgeewjYWwyG+nOZ0N9YDcejlDtbvPzkcORQsRn/VvFVTn2ful73ekB9qqopLH4Vtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO5P265MB9367

On Sat Sep 5, 2026 at 7:47 PM BST, Markus Probst wrote:
> There are currently 2 race conditions:
> - in probe if `Driver::probe` returns Err
> - in unbind
> . In those cases the driver data will be set to NULL before the serdev
> device was closed. If data is received while the driver data is dropped,
> the `receive_buf_callback` might try to access the `active` mutex on a
> null pointer. The race conditions can only occur if `Driver::receive` is
> implemented.
>
> The issue cannot be cleanly fixed without rewriting some logic, which
> might introduce new regressions.
>
> Temporarily disable the use of `Driver::receive`, until fixed in the
> next release.

Isn't this basically undoing all the usefulness of having the serdev abstra=
ction
in the first place?

As this is for unbound only, I don't think we need to rush to fix this for =
rc
anyway. Many C drivers don't get unbind correct (and our misc device). Ther=
e's
no in-tree user that will hit this API anyway.

I think we'd better just find a proper fix for the next cycle and leave the
current code as is.

Best,
Gary

>
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
> I will submit a patch (for the next merge cycle) soon, which will
> address this issue and make the probe and unbind code less convoluted.
> ---
> Changes in v4:
> - remove comments
> - Link to v3: https://patch.msgid.link/20260905-rust_serdev_fix-v3-1-b860=
56c3f7a4@posteo.de
>
> Changes in v3:
> - mitigate it
> - Link to v2: https://patch.msgid.link/20260905-rust_serdev_fix-v2-0-35df=
cd06ef2e@posteo.de
>
> Changes in v2:
> - also fix race condition on unbind
> - Link to v1: https://patch.msgid.link/20260905-rust_serdev_fix-v1-1-2ea9=
2b154a6b@posteo.de
> ---
>  rust/kernel/serdev.rs              |  6 +++---
>  samples/rust/rust_driver_serdev.rs | 13 +------------
>  2 files changed, 4 insertions(+), 15 deletions(-)
>
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d..f4c0f43b5273 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -148,9 +148,8 @@ fn drop(self: Pin<&mut Self>) {
> =20
>  impl<T: Driver> Adapter<T> {
>      const OPS: &'static bindings::serdev_device_ops =3D &bindings::serde=
v_device_ops {
> -        receive_buf: if T::HAS_RECEIVE {
> -            Some(Self::receive_buf_callback)
> -        } else {
> +        receive_buf: {
> +            const_assert!(!T::HAS_RECEIVE);
>              None
>          },
>          write_wakeup: Some(bindings::serdev_device_write_wakeup),
> @@ -233,6 +232,7 @@ extern "C" fn remove_callback(sdev: *mut bindings::se=
rdev_device) {
>          T::unbind(sdev, data_pinned);
>      }
> =20
> +    #[expect(dead_code)]
>      extern "C" fn receive_buf_callback(
>          sdev: *mut bindings::serdev_device,
>          buf: *const u8,
> diff --git a/samples/rust/rust_driver_serdev.rs b/samples/rust/rust_drive=
r_serdev.rs
> index 51b4898cd855..3fd3eef15371 100644
> --- a/samples/rust/rust_driver_serdev.rs
> +++ b/samples/rust/rust_driver_serdev.rs
> @@ -4,10 +4,7 @@
> =20
>  use kernel::{
>      acpi,
> -    device::{
> -        Bound,
> -        Core, //
> -    },
> +    device::Core,
>      of,
>      prelude::*,
>      serdev,
> @@ -60,14 +57,6 @@ fn probe<'bound>(
> =20
>          Ok(Self { sdev: sdev.into() })
>      }
> -
> -    fn receive<'bound>(
> -        sdev: &'bound serdev::Device<Bound>,
> -        _this: Pin<&Self>,
> -        data: &[u8],
> -    ) -> usize {
> -        sdev.write(data).unwrap_or_default() as usize
> -    }
>  }
> =20
>  impl Drop for SampleDriver {
>
> ---
> base-commit: e5e04726cdd043e309677071ab1b65a4b18f422b
> change-id: 20260904-rust_serdev_fix-be3ff9c8a5e8


