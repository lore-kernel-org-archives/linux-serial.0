Received: from CWXP265CU010.outbound.protection.outlook.com (mail-ukwestazon11022085.outbound.protection.outlook.com [52.101.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D64F3F8717;
	Fri, 17 Jul 2026 12:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784290074; cv=fail; b=sfCbHTir1B3rdZav4HpXTh/dDGgRqdW4wEbmwYg9LxGEtN7LLe9vS08Kd3t/Ykec2dOUevyS81qprcxwqdSK5AtX8+xRXcF/vxU0zButZkYzn4mkUKj6Zuodq7pw3LPTHUQPQbWwc08ygOq92wE2XXJW4oRe13NV5pQcKoa8B2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784290074; c=relaxed/simple;
	bh=kahgD7FXZR45f6K7FPS/WTzQgUg1Xe2ilCixD6erSvI=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:References:
	 In-Reply-To:MIME-Version; b=Rzl1ukgZlnaG98Nz9vizZE4Lpowbfv+zntHWe/FrFWUlSa5xPQ+wWgtO2sr4ZRQeGvNs28f3lf2BSBIZIeEGm3D/HKt7DZIPHc2J3l8wqxeR33q11tDaFzD5aQgW6TjAITQreTTRU+MJqZlTzHS91nuzeVOCuTEX5xm17IhoZCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=bo9kOlMq; arc=fail smtp.client-ip=52.101.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="bo9kOlMq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7+bvLHoT91ud6LsXBfknwNEVoL9onOJWxSnUAFvjW69zqkQxWXNHtvz8LGWb1rloyzr947mApVJdDwAZO77BixmSY+AAtQEnFrPnJz782zvPDfuh9JeDMk3/wqDChxA+QMcoxyTZ7BXdBJle9YmVb8fzZyABrFv+nCXrDccuPfKCcCt7B1n3XAybL0uY7G5SoVj03IS7guiUhKW8puUJ8rd1lf036+2vWPIdeqw+VXiNlTMr/FF7cKDShdxjwvWnoHsq9xK9sVKf6T6CgOAKgMM7LwPBvPNh7Ire0D7/+tURfVw6CdDHKhgCT9uJyffKPQbwQngxAlUUR52GTQ30Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IULrHlWc0HaMEwFvrBjT707Aew2fGhf9blSMSVtbrVA=;
 b=IKJ6pKdF1ma3fzdgAdimaBqSzuRoe4xq0RlTmRYY/B2rmMT3HzvH+cdrNC6M1wGxZh1jYwE47azfjebwjksbup5yi5/U3j6vGJT41v4ld+KuglDve5xw7WGdfqCSWVNkx5esoIHW6r9cs3ikfhpdYdnIK1sNGSf1E6U3YTNSMDLSig9ZCcRssW9ilkVVo7k7ArUj1dJVTR2oE8fHep8214glzo2SqI9VZ5LedclZbpV/AnTjHLt84jkWAoGkRJJcnb8dAQWUgGwm6QhqKsRpbUh/MEodpE30oEgEHyp6m47uaqI36Vkmt9c/nJM3M1FAboSjzn1KylbLf2XbOJHPOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IULrHlWc0HaMEwFvrBjT707Aew2fGhf9blSMSVtbrVA=;
 b=bo9kOlMqmpTwm6MJCuZdCmIigb2yuqkBn/fsE6TyM6FZASJth/yr8H36Oc+f14YD6aI0ZtCwj4kirmhPM0t4Wlj9G8lnKaiLRpq0fRZ1X50YtWXPk+1bLCeM17LATffU6zZXBxFmXI2tUlsQfyA0tSi8NUtg52u5VmoYdMnP2CA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CW1P265MB8334.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:26f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.13; Fri, 17 Jul
 2026 12:07:46 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 12:07:46 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Jul 2026 13:07:45 +0100
Message-Id: <DK0U1G9NCIS9.228MIUKBL4KEL@garyguo.net>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Danilo Krummrich"
 <dakr@kernel.org>
Cc: "Markus Probst" <markus.probst@posteo.de>, "Rob Herring"
 <robh@kernel.org>, "Jiri Slaby" <jirislaby@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Kari
 Argillander" <kari.argillander@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Boqun Feng"
 <boqun@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
 <2026071747-android-overhead-c927@gregkh>
 <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
 <74213297-d3da-4637-8f31-8fecebd65f60@kernel.org>
 <2026071719-afflicted-eleven-1be9@gregkh>
In-Reply-To: <2026071719-afflicted-eleven-1be9@gregkh>
X-ClientProxiedBy: LO3P265CA0018.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::23) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CW1P265MB8334:EE_
X-MS-Office365-Filtering-Correlation-Id: 2178b5a0-041c-43bb-56bc-08dee3fc0390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|7416014|376014|10070799003|1800799024|13003099007|10067099003|56012099006|22082099003|4143699003|18002099003|5023799004;
X-Microsoft-Antispam-Message-Info:
	DCUU4lwMjbg/qesNjTQwFgHeQ+t4zcPgWmgB+rUJsT+l1WDFDIhuDeHynbBH3GptDfAmDcVJHNXU8RynvxFRZF8s/cE0Q23zzta2yOqQCxuLJOmNWCJk9X2AmDwzcCV3c+eo79rCALyBy0MRATdDgpebbS9+0AOICk8yT6azCma+Dj2M87HG/bpNGzWeUrHhQeRqdgvkkA6fTUGfCzGUN6uZaIDyyPZKIKiP3rC1XSeA0iwqLOejEtCUlcI4T17U/8VLmWwjiRb+B0+w4K4MplRxIhQ4ThB4QkLRc3zR5/itKrvtcUBW3vqU83rRJLIObTj4iU/9pMrGAjDY2oZ8wD5kgDttmhDFQjOGzCS8YZZo6wkFjgc6JI5N/LuNktlfcfxEjLR9UhdTX/r4kGrSrS3GOlpsWszAdrWhr9+eLDKvuVRAOYDG+np237A5qsJ4p7s0Cdd10EQg08l5n6JArYUUIJMGKfF6oynmeSlB1idop2SrEvmvrodmGEDPOkfOwAxZR8MUAL6Z83huDtNp01gnOBT4SJ4TBObWe20wxKA/7QZVVE64GV5bThEr3/LpOr3IrinGRboVOEs79jAcMb5yXWlc6nP2dwMDEtHwL4kUwpopCjhlpzHAQdejHGD/4pj/PAB5qKumdT3kpb+Xhm3M5YSWhvu3vkexrU4nNY0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(10070799003)(1800799024)(13003099007)(10067099003)(56012099006)(22082099003)(4143699003)(18002099003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S05SU3BuRjhoTCtxbzVqdlF2dzRJS0tsbjVETUdQMlZLdnI1NGtXMm9iU05y?=
 =?utf-8?B?VWxLc0NxbHF6d0xxUEN0MEJ1cWx3dWtuTURSckRTdFE5eDNzcStBb3phdndV?=
 =?utf-8?B?STZ6OWora0wvSFd0ZDNhOXEzQVZ4VXBkYVZZMFV1MEIvUWNZUGdwWWRNMGt1?=
 =?utf-8?B?NEt6akEzSjdJUXNaaFFjRWc3WmxMbndZWHpaMFJaem16djNSZEFONEo1Z2oy?=
 =?utf-8?B?RFprM2wzZk9RSVVlYTV4L3ZUeGlHaTIvMmpCUmtLbitBQjhiZWxzSlNBZ0Fu?=
 =?utf-8?B?UkROUkxBekorNkVjdXk3eXV3M055QkdMbVdrc3NRNmtQL051UE5nOTBqaUJB?=
 =?utf-8?B?ekxiNjdxeEdhWTFvNjdZdEN4eDRkU1lMdURVVTY1d3U5V0NzSGpZVFZqMHlk?=
 =?utf-8?B?RUpmTE5BSytnWjJSZmdmOWV1L3RZME00ZVV4c2lpZzBnL09BT3RpNE5JT3pJ?=
 =?utf-8?B?K1EzbGZIWXd4bVloalpXZ3Y1aDZ1RkZ0ZWlRemozQnpDRU9SaVI0c2lJVllJ?=
 =?utf-8?B?LzNtbTVJdFd3d1B1UG5TdHdOazZ3cUZPc1Q1MFpIbXY3bTM4L1h1TGlWTkRt?=
 =?utf-8?B?NnU4R0pCaGtYK3FIVS9iSTNPYVBvT0lPYjF1NHN3bzB1SjU4K240akxiSGZW?=
 =?utf-8?B?dVA5U0pLbXFhdDMyODZ0aGJQRHcxY1ZkTWNDejQ0ODhhZlJBaXBreVM0RnEz?=
 =?utf-8?B?a3FtRk5DMnNLb294MUl4blVyMkk3N2RSYldPOERCcUdNSS9tY1IrYkZWajNE?=
 =?utf-8?B?NVkrTXM1YWFjbFR3MFd0WjNkWnhKTGl0S3l5aUdSRlB3dVNCYWF3ajdyQXdI?=
 =?utf-8?B?TFpMNDNVZjlVdzhqNFhrMnV6WXkvV0RyQmxyZ0RFd0UxVHkvYzU4cHJTcmov?=
 =?utf-8?B?ZUhXdzlYeHNtYTFpQW15Z2pCOXVQc0hPU1pJdXprL2xjLzd2cCtOc29OYnI1?=
 =?utf-8?B?TTQ5cDgvR2VhME40dzBYb2s1aWMzcXA2elRneEpTK0JCZENSLytQSGx2OHE4?=
 =?utf-8?B?RGp4S1kycFpPbDh4b09uMWFiVkRCOXpkbmdRamNLb0l1c2w4aWFnb1BjZytN?=
 =?utf-8?B?aGJtNWZGeG9BcHpyT1BnWUY1MENoRHBTaTBkMG1zTnM4MmV2eWhPTjVoay9o?=
 =?utf-8?B?bUIyazlNUmhvTXZudTVBNDlvazdWbFo0WFovNjJyZkkzeUNRRVdhYXlkWnJj?=
 =?utf-8?B?NUpFRXNjQWI4dUhTanYzTTFUOFp4MUo0cFhBL1JrNjh6SmpkMXdlbUhPRFVu?=
 =?utf-8?B?LzYvVDl2aEhPOVRSYTZVVTRReXl4STQvTUhhU2lsdGs2QWtWWVFwYzRjSzZh?=
 =?utf-8?B?ZVJmckJNM2IvWkxRNlg3WE83RksrdjNGSnd1OGNwSTErb050QnVNeGMrVURs?=
 =?utf-8?B?SW55Q2VuU1NEYXZHNU1SL3NTN3luMStqbk8wMFBxMXI3UUtBMW5xZjNqeis3?=
 =?utf-8?B?SkNnb3lFTnFVYk5FWDRwdUFTaU1vYW52eTJxNktOTXZWR0R2SldNa1dsV0hL?=
 =?utf-8?B?alVRZFpvQnFzV2M5MytHY3FmUFprdW15bXpNVTljNTFYR1ZETTBoemdITy9D?=
 =?utf-8?B?eE91L2dpTzl1WHgxRFBVZW1HaEV1eDZ1eDMraWNOcFVEQVMzaWs3M29vcEI0?=
 =?utf-8?B?VmJFT2tObDE3cGEzRzdLcFZiZllrQ0pBVlNuVHlrcStZVXB2bTlDS2U1dUp4?=
 =?utf-8?B?cFc1cm9SZDFHSTVucjZMZVdKTTlFVVZKbk5PYS9LSjB3bm0yazNRRDlRam5y?=
 =?utf-8?B?VlBxN3hjSmd5dXRJRDkydXM5d21GcndpYzM5OEI5Vm9SbjZWVHNZWG5qUTNE?=
 =?utf-8?B?OExJQ1RxRU5BeGhnamM2aHgvZmo5UzNkSGtkZURYODVmWk5iMzNsaWN5bjd2?=
 =?utf-8?B?eUV5QzlUWk5BeTN0ajZJTGl2b1JkeVJ0S1pCUU1mUzhZb2lsWEkydXFuckVr?=
 =?utf-8?B?bUVqa3ZaQ2ZIODUrOXBrekZ1TWVtRk5MMFc0NDkzWEsvZXdVRWR4Z2hPcGFJ?=
 =?utf-8?B?RGZMOXhwcktLUkdsVDgrZVFJWGNuOGV3eDlSRlliZzBGQzBWZ1RIbU50ZWRl?=
 =?utf-8?B?Q1poM2Z2TStpSWZtN2t1V3h4elg0L1ltM3BCY3A5eURqSnF0M0hNRndscyt5?=
 =?utf-8?B?aSt6MkFtbjJuQVduSnZORkpGZUJ6WVhkN3hzQWN1UytLeVlBV1Fjcnp5VVEv?=
 =?utf-8?B?YjhicDRJQ2pndmlZZXV3QVFBN2JjMXNLaE5BWTJCR3doNGJOZUg0Yi9lOUMr?=
 =?utf-8?B?ZmdMTS9INFVqTEVxU292eENzRTZKUy9DdWlwU2R5bFZVTXN3V2cyWTI1V1Ez?=
 =?utf-8?B?WUJaQkhJVXpzSVN3ZFJ3ekl4L3RheGk1dksxdUFIdEFYdy9VdVhmdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2178b5a0-041c-43bb-56bc-08dee3fc0390
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 12:07:46.5471
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCAskwp4Q9eeTXBpAyaBZ9Vm6qptuhwNmRDKBuC1/AurhO446onQB+7q+k2mpniWghr0w5iiJebExIX08AlqHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB8334

On Fri Jul 17, 2026 at 1:03 PM BST, Greg Kroah-Hartman wrote:
> On Fri, Jul 17, 2026 at 01:22:40PM +0200, Danilo Krummrich wrote:
>> On 7/17/26 1:14 PM, Markus Probst wrote:
>> > On Fri, 2026-07-17 at 12:55 +0200, Greg Kroah-Hartman wrote:
>> >> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
>> >>> This patch series adds the serdev device bus rust abstraction into t=
he
>> >>> kernel.
>> >>>
>> >>> This abstraction will be used by a driver,
>> >>> which targets the MCU devices in Synology devices.
>> >>>
>> >>> Kari Argillander also messaged me, stating that he wants to write a
>> >>> watchdog driver with this abstraction (needing initial device data).
>> >>>
>> >>> This series depends on [1].
>> >>>
>> >>> [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-=
dakr@kernel.org/
>> >>>
>> >>> Signed-off-by: Markus Probst <markus.probst@posteo.de>
>> >>
>> >> Given there are no objections, I'll go queue this up now, thanks.
>> > Thanks for merging, but I haven't seen the dependency
>> >=20
>> > https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@k=
ernel.org/
>> >=20
>> > getting picked yet (its at least not in linux-next), so it might not
>> > even compile. Not sure whats holding the patch back though.
>> (Ah, saw this just after I replied to the other thread.)
>>=20
>> Nothing is holding them back other than requiring a user (which is your =
work),
>> so I did not pick them up.
>>=20
>> Also note that tty and driver-core are different trees, so picking it up=
 in
>> driver-core would not have helped tty.
>
> Should I drop this from the tty tree and take it through driver-core
> instead?  If so, no problem for me, just let me know.

FWIW this series will also conflict quite significantly with
https://lore.kernel.org/driver-core/20260629-id_info-v2-0-56fccbe9c5ef@gary=
guo.net/
which is routed via driver-core tree.

Best,
GAry
