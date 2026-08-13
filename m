Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9524908C0;
	Thu, 13 Aug 2026 16:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637331; cv=fail; b=tXrOoYXwvmDGSs2aDln2oU+PbAIRcWPxlSVxqu0cXZBeJmjGwSf4W9F1FTAQ+s4mIzby0dL0OG9wBICwrEzZZ6xU6To2tpU/T1rQ25qgpT5xIY+MHUmxMNsO3VjEvQrN2OzEJduWnjJdrId3ZqG0Z0h6Go8v05/Zd/V7in+FdsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637331; c=relaxed/simple;
	bh=P4OddW1PcItUZQlp+qP9uojttxhDFUrx3CYm6wTRn7w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=o4nf3k25miWMMzu9iUXAScIDFezHO5xXK9w0qgVcd8Deo2MTtJPKRWWC5TBxcXLkDr9QHJKkbSogMdpYYcU8SzPvaEI8EdJL+Z7DhmDHM5KWR0R3tYkosuXR0Aqw9i97SnmfPXbn7oN2NyHMbFipCkqViYM0dH+MU/VWq2Xs8SM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ipFmbbdk; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ipFmbbdk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKRVSEDj5BPWr4CNolcGX7g/FHj1OEHZnrDM/6h3IBW8pBru2R89sZs/1JlD8+AeXL0dob/IbFyYpoz57lDUH+FcKFmspMMz0vEXgLbnrIb6LYziX8maz+MJj94FKJbMSUVCtFvzIKVFPdD2iD/Wbs4SBCkarHreu1/P/QbFytShL90+rblEfnD2HIlPOmdAO0QU9i99sCDdjEDr1RVb058lfGjFhoHURVRrJrCRQCuZipYR9qFRlvAY9xUYk7AAi1pXDBOhHYrwxdohEmObzYiXiZIzJxNP96UHuLqfZYceh6ouAkNjXFHWtfcjcxVOKcp2mK9+SK6Brx1WkgnZVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kcxDrzM+5Ou3tOU9RphwLf8pFWMaAzlqtz389f1Cxo=;
 b=oOfoNIgTrIoHVAo2IfWs1X403RH5Vb+H598gBmwgDDQ4GF3JWgHNUCahbG4VfQxkGRSwxRaja8LTIXWDA118F1L+2iaSWexFf987SCvqJ6b/JesegMIDALCdxgXW+qN75ouquhs7Lexo/6IZpwDAiuboJqmrftgY2yJNGFnHKH3zNwId5/VyLxx1/GhU7uA2usj6fNz/2apdeCL9szoHtxHVji8L4BMh8BbSzUmdmqi8zWL8q7GlfhgK7FGREbfV0YSof71dmP7QAOFLWMM+5cvb1VgXfH+6cp3YMzrGYYBsDp1wyQRwF4RfUoLDzhdn5KwgYMY0RL21FL3UpO12vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kcxDrzM+5Ou3tOU9RphwLf8pFWMaAzlqtz389f1Cxo=;
 b=ipFmbbdkAvTsTOv9tczZpPmrwpGSljzNzSE3qpD9Cn/OP9LQf0kruhSQ2jplro3pxJZ54NwF5Cbm54wkFhee+sEsSFeAxaOlBTGsVUO1j54NtgM4/B0wTGiQ8oH0ylQgO8R1emE0cL54x1JntxW96Iw4o9TVlIONKdYSIhFqwws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOBP265MB9411.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:08:33 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:08:33 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 17:08:32 +0100
Message-Id: <DKNY2IJH29IL.7P64CPJFVGDC@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field
 access
From: "Gary Guo" <gary@garyguo.net>
To: "Markus Probst" <markus.probst@posteo.de>, "Danilo Krummrich"
 <dakr@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <ojeda@kernel.org>, <boqun@kernel.org>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>,
 <daniel.almeida@collabora.com>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260813152444.514580-1-dakr@kernel.org>
 <8e716c8ed7172fa28b569bf59a146c262a29e0c2.camel@posteo.de>
In-Reply-To: <8e716c8ed7172fa28b569bf59a146c262a29e0c2.camel@posteo.de>
X-ClientProxiedBy: LO4P123CA0599.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:295::11) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOBP265MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: fc1c0418-3bcf-41be-b143-08def9551fa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|10067099003|56012099006|4143699003|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	1yVUW9GlT4UgHoSLVFST6b+tfiFSTj/AiXfyWj7A/MRsVWJTxxU8v+gdUcvFmj3lhwZXHXeOwv/4pNrKBUKtgMSed5Fdp23aOS2XZrCWaqMsgtDimEgvy1l1X5/UxnUX3pnazH9b0APtItRuV3KviMli7eA6p8CLsUwIj+A5rR92Xsb3rtTQLMZ/6u07WOhVyUzI3vmChSe8yegl0egG8v5YGrPmewG7ScMvJ+/fRxlqOiQitW+9g1dxLkxrhTL3bgRyOAtGerpmi0phCV7iXLMgLvnTCqEDk93Yh8s+OPLKbixw1nSCf061sAe5QfDHyAYub5zc+ffFSLILQ1AAC05WmZU3Cno6JSFUaa0z1cpDHyt6JPX98J++LUhlgnJZlKbAo49Q0t/j1B0cehZ77gIL7EcfmcxjXwOjEriG7fpqHBfIX9oGBNEBDyGImyaujyguoOJ8noTb7DjP6pdVCqqyrp2G0drabr9witpg2MKbmj1BnABBp3hvDB4dwNKwZ4qAGUHUyon31uR3fvMqgGgx/4bKRpwFp+4cHM6mmKSQgKisp1i0Hf2PgsLpBSbwfHyC48pS32Yy0YRQyuUxYA9TQ9o2AtJSc5CMTtp9no6x/suwaBbWjgtwipaLBGfOw3Bg3iQ51p8t1xM0PKZ5aVE5YRQbM2fVtaLoBpfEA1BWDmnNwlBqbaa6gdMl94wpANrdwi1X82g08gcTTni5Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDdjN0M5Qk9TSTd1ZGFsVjYxVlVyNDlpL0tTK2VxZkhxam8wbDBRcC9mK3BB?=
 =?utf-8?B?TlJ3Z3FjSHBNVXlFWlV1ZmJ3S1NoT2pIOS9scVRHTlhjMHJTcCtCSlFMTlNQ?=
 =?utf-8?B?bk9ERFlzVVFtSnRjd0RhNkxhb0VWb1pNZ3dMWnF6UGhoU1hLVGEwa2xycU01?=
 =?utf-8?B?dUdUeXo0YkcvTHV5WnJKNVpTU0RJTGR4MWhKSEVmdDRCUXA1NjFzTS9MUW9j?=
 =?utf-8?B?YkV6WUlMcDJaTDBLdUVqMWJVNmFXTmZKcHJrSXdEQkVQdFJDMFBQMEFOUWl6?=
 =?utf-8?B?bWY3bm0rdC93eWNac2lqZklvR1lLZjhOcWNvMlk1QXYyTnJWV2F3YkRQa0Yy?=
 =?utf-8?B?NnBQaE9MQ2dLQ0tYeUZaL0ZLaWRBSGl6VTZ1RGhlNTRHaVI5OHZlUWxFVUFT?=
 =?utf-8?B?cWZLRFB2RFg2ZklaSHE5RHhXQ0o1L3I5YU90cElFWEJzbU5DYllqYXB2ZWl2?=
 =?utf-8?B?UXB4QUJxbTZBY2FEMmorVmpWOWJrTlgvTFBKZkczcHJDbWZnRFJWNjFBT0xv?=
 =?utf-8?B?SlhVejlvbyticG5NUXlKR0dDM2VFaE1Kc1lmUUdZMS9abk5sRjQ5cytFcHM2?=
 =?utf-8?B?bEFXZ2FhQ0ttcHhLK2RQNTdubC9nUHRxaFcxeDFvYVNNYjhFRlZwaWFqUXZo?=
 =?utf-8?B?OEMxdm4zVTdzS2J2aTNUWm92M1kzUWpVNzlxT0EvbERSaFdYODkwWmlNUWpY?=
 =?utf-8?B?aXpJazNwRENEOEUvOE1JSFZmK2NBRWdOalltV2FiTmZROVJNZXlMQzdpLzZl?=
 =?utf-8?B?cDNLRlQ0ZnlPYWRRY3hJZjFUaE03djMyaU53VGpFaEZTRDVXVkp4OXBUTFZN?=
 =?utf-8?B?bTNyTTMxazltdHVmQ1I2bmVHMEc1b3p4YUZPRXNIZFFoWElvaUVKYnlOVzhp?=
 =?utf-8?B?TFFtS3JNdVVPc3FNVktlUjRHWmFWOENiNklMWDE1UlJzOHpwdzNSZmI4Wnll?=
 =?utf-8?B?d0tEazYxbk9MdlNiWi9OK2RkbS9GRHo4YVc4QTRFYUhTeEgrcFNyVy9UQjZs?=
 =?utf-8?B?QjNkQmtjZDZYcHhEMzZCdWFUTzd1aXNnN3lWQmk0WHJ6YTBhK3YxaVNEWFBk?=
 =?utf-8?B?RjdJNXV6ZWgyUDVIQWtiOUZYd0NXaWczekkxclFnaGNnN3V2THY2Z0QydHky?=
 =?utf-8?B?KzBtOGhucW5pZndtTW94MlZKNVdkREdQQ2kwTFF2YWhrSVZUYUR2dllJUXZw?=
 =?utf-8?B?ay9qUVZSNW5VQjEvSGptUzFsd041U1lCLytvTVZ3bjJ4MzNKbTkxZi8vRGxM?=
 =?utf-8?B?M1VXb00yR25TUmF6QUhnR2lTc1kzMVp4ZXdGWEtYYkRxOFFxckNucC9nbVgz?=
 =?utf-8?B?TXpocVFnS3JjOTdIbVRDeHlyVHN3V1Fad0tISC9IZW1XeDltK2YxZkovZ1Jw?=
 =?utf-8?B?aXgvSnlQM3J6VnlNQkNybTFxdldYemlNODlTVm9MUmNFVC9yUm9VWHQyOEhr?=
 =?utf-8?B?anQ5UXNrYnJEbWw5WEVKRklJbElwRTNXc29UT3RMcXYybmF3cGxaeTJQckpt?=
 =?utf-8?B?SVlYWWFEaUFGdUFlQ1p6a2ZySmY1OWwzWGplMHhHV0hIOVJ0bUtuejVzVmVT?=
 =?utf-8?B?azkzSGwzYzJvREcvOXVkUTNJZ3VDZEwrcTFkRVBpdzRlUTE5U3ZMemtBak9H?=
 =?utf-8?B?M0FNTFFyUTNiUW1oYVpDWERwckVibTBVdjdaY1NMa2xIeDg4WnUybGtrTUM4?=
 =?utf-8?B?c1crVFk4QUJBM1RPRWF6OC82ZnN2QkZBQytFcFFLR0EvbG1DYUpsTTk5Y3RL?=
 =?utf-8?B?ZEViUWtNMlNCbHVTYmwwTG9ad2NHcmVDWVFXazBiTzRlUnQ4dktaL0M1Y1Vu?=
 =?utf-8?B?TTRIQ3JvUlBKaTNLY0hjeTRZcEMwZjNLVXVMK2FHTjhKWmdhMXZiOHFOVWIx?=
 =?utf-8?B?VWxnU05veDBrMHQ3SmFQYjlkNkJRUk1wRVplUCt1ZXdYcVRjS3lIc3FJZFNq?=
 =?utf-8?B?MjVxc3lBdnE3elQ4R0JrMFJvVStLdms4SncwM1RUQllXUjNxM3lKRlJwZzhL?=
 =?utf-8?B?bm5zaDY1bWhmRVN0a2tXeTUrWUtmdTNRUHI1UEpnYmUrNnNlbzFqWkMvQURv?=
 =?utf-8?B?aTlvZjRjaFJYaEpNYXFJbUp4Vlh5R0N3enhkZjhjUUtkNUJLSW9MV3JIMEdN?=
 =?utf-8?B?YmxoaUpNQTFlY0hjOUgxT1dUYTFnMVl3T1hzbW4xcHJLdWlYYTk0S0gwb0dn?=
 =?utf-8?B?cE52YlBuVVlKaGVnV1NOaUl2R1dUMVBYbm8yY2ZPaVJXOW10Q1puOHQxL0pP?=
 =?utf-8?B?QW1NeDBJa25rSTBJbnlFVEZYQ1BMMXg5ZXlUN0tnUllIeWpnTWl1a3FnU20z?=
 =?utf-8?B?NW1sRTBCMDlvM2hjTGc3TW1lK2NmR084QzdPTHdzVUNkeXEyVTk4dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1c0418-3bcf-41be-b143-08def9551fa9
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:08:33.3015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkDwOU+69lFIvPUaf+EFVNgVPRQELJ6zkmTR2RbeBQ/9yXFIlT2fQTHfenXqO7yI5sJz6GoT7ewhGRajTuuSAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9411

On Thu Aug 13, 2026 at 4:53 PM BST, Markus Probst wrote:
> On Thu, 2026-08-13 at 17:24 +0200, Danilo Krummrich wrote:
>> The THIS_MODULE series [1] applied to rust-next moved ThisModule from
>> lib.rs into a module.rs submodule, making the tuple struct field private
>> outside the module. This breaks the module.0 field access in serdev in
>> driver-core-next.
>>=20
>> Update the call to __serdev_device_driver_register() to use the public
>> module.as_ptr() accessor to fix the build.
> I encounter 2 errors when building with both driver-core-next and rust-
> next
>
> error[E0616]: field `0` of struct `module::ThisModule` is private
>   --> rust/kernel/serdev.rs:90:89
>    |
> 90 |         to_result(unsafe {
> bindings::__serdev_device_driver_register(sdrv.get(), module.0) })
>    |                                                                 =20
> ^ private field
>
> error[E0599]: no method named `__pinned_init` found for associated type
> `impl pin_init::PinInit<<T as serdev::Driver>::Data<'_>, error::Error>
> + '_` in the current scope
>    --> rust/kernel/serdev.rs:200:40
>     |
> 200 |             let result =3D unsafe {
> data.__pinned_init(driver.as_mut_ptr()) };
>     |                                        ^^^^^^^^^^^^^ method not
> found in `impl pin_init::PinInit<<T as serdev::Driver>::Data<'_>,
> error::Error> + '_`
>
> error: aborting due to 2 previous errors
>
> [snip]
>
> Should I send a patch regarding the 2. error?
>
> It seems the `PinInit::__pinned_init` function is not only deprecated,
> but also behind the `#[cfg(not(kernel))]` flag, which causes the error.
>
> Thanks
> - Markus Probst

This is a semantic conflict that cannot be solved on a single tree and has =
to be
done on the merge commit.

A resolution is already on linux-next, see
https://lore.kernel.org/rust-for-linux/20260807074729.108159-1-ojeda@kernel=
.org/

Best,
Gary
