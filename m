Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020118.outbound.protection.outlook.com [52.101.195.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5462239A04C;
	Sun,  6 Sep 2026 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788725602; cv=fail; b=RH7xcy0yaqsBJWXfNlOAT0kW3wpgd/n8BNe1j0PS5c2gsizFXmKwA8GlJqE6ZrfoioRaviXCqtj1kWEOhppcyGQkCvqDrbXXTlvD/wI7re6uiJ8rQouKq7rg7VWxHoJGg2LVg8ppeecbM85EL5+/X+JCoJzCvWbwypV9uRrxoQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788725602; c=relaxed/simple;
	bh=GGeWFJXsHmKEdTinfRzA7jghKiwthK5rYypXiqbWVQc=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=eb8CzBfCMkl5Gcw7xTDApcEsDLQgXlmAxOtHqSTSAIRlr/O160hWkQLAAkby20H2v8RrNklAMuX7iMq7FqC5odOEN+Py9wRAga7D2oC2vANiLxJ425VI1uUZ57j+i6iDl5nzix1Ys7p9PLmxR73FspQ1hVMeVCRdI/IfiX7ih0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=ZXINFztP; arc=fail smtp.client-ip=52.101.195.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="ZXINFztP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzP7ySPjEE0hJ+lyqz8KOiuLybyZqZvurPf8jg+7PmrAi08p994NaiFQM4rekWnkbWWA2aO3GPKvAodd53X6moQMQD4EC3uqFjkheMcj4DtkzdWJyAmrzfqtS5KAxvrUwaT1YeVKZ5LVmyOcvtmf7PByEjUbk+QKArPsSTM9pv+9i7/dGWp18TOi6A9E10o721L+FKNSsJrrZgm7fu25nkbktgypctFmB6HRh6Cg5yH+K8D8J9k/FufZHeeu1YhziCR1gft9CB7zO6YMV1CBY/Y6cB9fNDnZpTG3iPKoOeD4Y7U+v50z2wRAHERXSAHi/rIKAepNrmipguZuz+JiPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sENCGh/9LNGCV1kNjp2RB5KbqwWBzyBwsNZKY7ySLDg=;
 b=krVWzoAkWMJ9D7nAsJxrAr17pTJf5mBryvh6pPoxzKmMJpUhPeVvbGSCvkAqTXixMFCTI7xIPIq3qGKjur2EnX5StLERlwssl78sxTTd5PtSkROoAFsXwvpf9r7N3sP4haG+hMIfE8jiz/61nLF20IXUXwDXX6qI22j2iscjKR8oGvOoO1ujUN8L4giuAOmZrqcc5qUQ0ujnilymFRqtELUA5ctsacz1CzGr1/4tNCfs70HTf1sGO6yx005UIOURNCCGD7e4DNOjhJfomC7FCaa6aV2MTrSJD2m83O+fLCcWGVYkUkjFfY2f49JC91/HDJzwcVOvW4grH4p2wyWecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sENCGh/9LNGCV1kNjp2RB5KbqwWBzyBwsNZKY7ySLDg=;
 b=ZXINFztPj5CiWyVlwJVaYPHhZ18iyyT2z2Hg69l5f/1nuA/56qLTqlSBUm0t5jJtIaykkLIN7UsZMTfQGmsO2dKlKkedbXuNWPHRztIDN0mKPhJtj8QYvEvPKeC7kdaYnLsEl9wnUJ4uRPe0opI8IxcLVz/NPUgXvFaMCRd9zQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWYP265MB9355.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:28a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sun, 6 Sep
 2026 20:13:16 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sun, 6 Sep 2026
 20:13:16 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 21:13:15 +0100
Message-Id: <DL8IAYDEO7VG.1HPQR4U9S7H2Q@garyguo.net>
Cc: "Ayush Singh" <ayush@beagleboard.org>, "Johan Hovold"
 <johan@kernel.org>, "Alex Elder" <elder@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Eric Biggers"
 <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R.
 Howlett" <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Jiri
 Slaby" <jirislaby@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 <greybus-dev@lists.linaro.org>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>
Subject: Re: [PATCH 5/5] rust: serdev: Pause receive callback before calling
 unbind
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Markus Probst"
 <markus.probst@posteo.de>
X-Mailer: aerc 0.22.0
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de> <20260906-rust_serdev_probe_refactor-v1-5-69cdae0074ec@posteo.de> <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
In-Reply-To: <DL8DCNMSENDS.3T14U5W1Y32IX@kernel.org>
X-ClientProxiedBy: LO4P123CA0617.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWYP265MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 18cf3252-cfb0-4f53-fb56-08df0c534940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|6133799003|10067099003|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hcKaBGAvGXRaPMHLmoyOFdXwPmmbwFwbGi8jxli/VADhQ1qmgPzjHq9kzInkR6yMbcMgFENeXNCxNUUdMDDz6TUuZ1ic0u4eEbAsanMIHiQwGgINJfCiVFUPwf6MIcbgoK6zyg00amRU/kvNkRG2XkenWg7blOKGkB4FXJLxJheY8Jji/vPMRY0Ss/WbdkhiX87edPs3F8KWj4aaKcy7Jy/+E8N78iN0eQORoaIIzmw7f7fc8GBmKC4UoHaWT7JMZjoQGr67aqEMiPDHgLdt1n0WqNF/F/0SX/o8x1DvGuiwjWcFy5LTr20pbVgvH/tnW83WUC5mHY3ma8KEPga60yoQtZKMB4F3syRBTICD4QBWOE+NVnOpIiWwld6JceXU0pSImMBlXKUAGj6lclXew9ATpNS9XU0l0ja/+hEw9WtHJltSX1UcR1BezFqRiir+ieERG9a8KM5yW2SOWJJkkmzow9TlzaQHWiaVC1SYANgu0tSEwp1VHcuMURqM+JDkEaCiLkXv8OFr5pjzAGuNXgyZrWtIyLm4ZBwFQse9zK0nxW00z9acoRlXjG0YlXhFfmjqclXMtdCCaerQ2ZUt4rRZN//3U3RMJzEaHvuDnsJhFNnyvd+uwFzwcb1SKENiFIbJ/szVDIwnzQTUVSlRezL/rEvrs1Xiv+TfLB2/C2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(6133799003)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlJrSzJ4ZXhUcHNCNVNBZ3lZQjk4UDUzRytkcVFnWm13RWpYMUNOZmNsMEJx?=
 =?utf-8?B?WXRRUkJCZkVMMEJibm52aThEUUR4MmRHZXFVYXlEYnB4alRSLzhKUkI3NDJu?=
 =?utf-8?B?Z2pLY3diQ0VxQVJwYk9ScTJxK1UvR3BZQXNvYkJ3RVdDZ3czbW1TeXB1amZI?=
 =?utf-8?B?Q09Leko1Rjc3TUJudThES3MzRWtqSUpURWNuU0l2c2lTQTM5SS8xNGdLWng5?=
 =?utf-8?B?Vm0wWFBWOVhEOXhkTmtZTEdkOVI2NzZaM1doU0RMbi84dG15U29iWitQQjhV?=
 =?utf-8?B?M3dPNmgzNjRWUklPSVlVVEpFSjRVTUJDK1hLVmk0SzZ3NklDNmVCQ3pLNFlS?=
 =?utf-8?B?SUdsRmlmRUQ5TUx3VUhJUkZXU0JKaGY2L1doUGsrVTNnQ1hJVVdqdjk3L3Q1?=
 =?utf-8?B?ZnhNYndENjVBc1NWSmNIa1dDTWJRR3Bhb0VrSEkxZFVlZlRFOFA5b3BxaWlv?=
 =?utf-8?B?ZE9FclpnM3JvU2hOcEdGaE9weGZxbXl0WDRiY3Ivc1J5UHYyM1hYNm1IV3Ny?=
 =?utf-8?B?djhUY3hjdXlGUTVISXBvdWh3S0VmVXJ5ZDRoL2Nwdlo4ZkozUjAySVQ5dDNN?=
 =?utf-8?B?ZzhUQ2FUWXY0TDRKYUN1UUJjZlJDVzU3bWZiSmxWeVJQTW5BMW5KNVRkZlVp?=
 =?utf-8?B?T3I3L0RJdlkxK2VjYWc1bmdQalYvM0pWcEdycTFOL2lpM0JRdUtyNW1pUVVI?=
 =?utf-8?B?MnVZa1RvbTVNajRtKzMrNk9lZ1B2c3cyTHlqemR2SHo5b0hwaXl6WGp6bUlM?=
 =?utf-8?B?OTIxUUJMN1U3ZDN4L2F0UDhoK1IwRVNsWHcvaFhFMmVySFFsWVNCeHowTGJt?=
 =?utf-8?B?WEpBelQwbVFiL2VwS1JneUlQSEdLSy9JZ3JzTlRHb2hQbWJCd0VvdFROR2VM?=
 =?utf-8?B?dVV2VVJnTzBiM3A5Ky9lV3pUN3pvNTFWVENiNm9oMzJGMXpRVmlTYTNFUHRP?=
 =?utf-8?B?VzFqS01KSFNvWVE2bEc0STI4OWZ0YzVoN0ZBN0NkdjNsbFdQTXZCUEZuVFJB?=
 =?utf-8?B?dVVzWENQK2M4YW5UUnU0bHhaM1EwRlhPOUQ3LzVZdEhIemtaSlVHQUEvK3My?=
 =?utf-8?B?dC9xWklXRmlEMlJML2xwcWZqRDhOa0cxV0ZQRThsc0dkRWdJQkpJc1NDeThE?=
 =?utf-8?B?N3FTaTdkZFg2aXM1aStmaUs2UDBzcEM2bjNwRTBPWHNVY0VvS0Ftd2puTzM0?=
 =?utf-8?B?N1lDRlNTQlo1WVlodjA0d3dqKzUxNC83YzV6VURyLzJZZjBlelBMaVVxdGxn?=
 =?utf-8?B?NWY0cDdlMUNyVEFvWWlLNHhFbmVpT2MwTUh2ZnloVUpSY3JsN1RmaUZQb3pM?=
 =?utf-8?B?NWVVZm9WeldHS3pNcThrUWdic1pXckRGT0I4aTdoSUFaQlhoRFpQUFRQNHB2?=
 =?utf-8?B?WnRmZktqaTZZbFpVb1RDYTNQaFNUazQ5VEJQRVFWemtQbnp5aTBPalJ5VHBy?=
 =?utf-8?B?ZGhBb3B4dkZkKzFkcHdFQlFIN2xYbFlNNy95YWRIMVZhcFlOajdtUHMwSFEw?=
 =?utf-8?B?RjN6V2VNQmIvdTY3UnAvbzdIMmp6N2FTRVFQMk1ZcmxSd3ByUEZqdlFoWU40?=
 =?utf-8?B?STNrWEdlYjhnL3NIQndqa3ZkUkZSTGJxNXIxVDUvSndtY1NmZmlQU3RlOUtR?=
 =?utf-8?B?WU9yUUl4ZDhGb25XK2FsTll5RGkrcTVkdWFyUzFSZFo3bzBtSUtJc2VnRjVs?=
 =?utf-8?B?YWpFcTZTK3JSZkR3ZmVLYUxTRmZIUHE3cU1KR1p6RXpYaXNBLzNsc1RyY2Jq?=
 =?utf-8?B?dVVlQWxwQU5xQ2VseGllNm9ZT1J0ajc3R2ZFbzVVWFVCUldpMjlCd1dlYTFx?=
 =?utf-8?B?Ylc0dytZMDlGSjFwTTgxaVdhOElDT3dHZWRGZWhxMUlmeXZodVpDd1FPMUty?=
 =?utf-8?B?dHdNakVDYUtIWFJzRklxcUY0NCtHbGw0RzEvai8wVGlPai9EZExTOUdxd2Fn?=
 =?utf-8?B?ZG1zbmFpTDN5VGgrN1IrM1IxaXhkVFFVS0RoVnp4M1dOaGIzbkg3K2hrVDN5?=
 =?utf-8?B?K3JhWnRIbGFBZWw2VFBaWWhsQ2pQQkR0TFlKL1lTRWw5R1grNXRDSWJSZUdT?=
 =?utf-8?B?WWpBcktkczI2UlMybnRaME5VNTNWUkJLY0JqZFlxbER1UnY2MDE3a0tFdGU3?=
 =?utf-8?B?RVZtRmhiMUZFbVNmUmJWSlk2WUYvbERkVjZVc1kwVTlhcVhGYzYxQUlxSHRF?=
 =?utf-8?B?WUZ0eFlKOGhZeDQvbHdiMUhraEpvMlF3TWpybzkrcGtRTlNpeXcxZEV5aFBL?=
 =?utf-8?B?YWFhRDB5VDBEeGNaSnBRK2V1Unh3TjZyR2Y1Z29WcW1WY3Y1V2JvZGxhL2Jy?=
 =?utf-8?B?U0VUOXdqaTNOWGh1YnArWnlsWkxWb3Boc01XdFF1L1dzekhDdWFIUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 18cf3252-cfb0-4f53-fb56-08df0c534940
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2026 20:13:16.1565
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M4tcOVlX0QXrkjS214mXjUDbenF9/QkyZTXuoWqQH1McpAHgIx5iXM149Hv1AFrVqPi9s1SMpGZLWqEeA6u2Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWYP265MB9355

On Sun Sep 6, 2026 at 5:20 PM BST, Danilo Krummrich wrote:
> On Sun Sep 6, 2026 at 5:55 PM CEST, Markus Probst wrote:
>> @@ -200,10 +203,14 @@ extern "C" fn receive_buf_callback(
>>          // INVARIANT: `sdev` is valid for the duration of `receive_buf_=
callback()`.
>>          let sdev =3D unsafe { &*sdev.cast::<Device<device::BoundInterna=
l>>() };
>> =20
>> -        // SAFETY: `receive_buf_callback` is only ever called after a s=
uccessful call to
>> -        // `probe_callback`, hence it's guaranteed that `Device::set_dr=
vdata()` has been called
>> -        // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
>> -        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pr=
ivateData<'_, T>>() };
>> +        // SAFETY:
>> +        // - `receive_buf_callback` is only ever called after a success=
ful call to `probe_callback`,
>> +        //   hence it's guaranteed that `Device::set_drvdata()` has bee=
n called and stored a
>> +        //   `Pin<KBox<PrivateData<'_, T>>>`.
>> +        // - `unbind_callback` calls `serdev_device_pause_rx` before ac=
cessing the driver data,
>> +        //   which guarantees that this function will not overlap with =
it. Thus we have exclusive
>> +        //   access.
>> +        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow_mut:=
:<PrivateData<'_, T>>() };
>
> This would break the driver core's lifetime design. Any kind of registrat=
ion
> (such as class device, auxiliary, IRQ, etc.) may borrow fields from the b=
us
> device private data. The whole design is based on the guarantee that we n=
ever
> construct a mutable reference of the bus device private data.

Mutable references should be fine (of course, provided that the bus actuall=
y
serialize callbacks).

It's only problematic now because in absence of pin-init self-reference, th=
e
immutable borrow is the only mechanism that prevent user from having multip=
le
mutable borrow of the data fields.

Say this code:

    struct MyDeviceData<'a> {
        foo: Resource<'a>,
        bar: Resource<'foo>,
        baz: Resource<'bar>,
    }

pin-init would make `foo` and `bar` be only visible immutably in the projec=
tion,
even from `Pin<&mut MyDeviceData<'_>>`, so the design is still sound.

Best,
Gary
