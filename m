Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4EB357D0D;
	Thu,  1 Oct 2026 02:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790821665; cv=fail; b=NGGCy3H0AS3IrB/GqSTLRcT+CRJypKykP8kbjFP2sZHQcnEtjzPfTzuiFf/uL3zf/vJbnFrjEHJHkWKPUwpXuwzbX/rrwpyDhDs64TxS1P1GtcJkER+20kJ0Gz4yKumDRb+ZKeCo7Fb4Fakp/DveHmacgbg2txSgjLa15iJgOHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790821665; c=relaxed/simple;
	bh=Dh3iSTh38LHFjNk2S47/5BRDGKxBQ3UE/8cutDKDXxo=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=mtrmv7l3DkNFkrmZSJaOX13Gex2P1HP2h/RV0oieCBPZ0VLHh1/wOvf3Y8am5JUff2btSEL1mu4xFcVcyOKgoNYYdriJubxl14rkKUMWLGwt7NTqZjLuy7iqATe+lOxZBvVZW2RiACFh2TQD7oy57F+vdX6LJZWiqEYs49zN6CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=u2WHMzGw; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="u2WHMzGw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgOgQB/0kEbLVGV52qoEs3cn+K98zWfwfZ/P4paJSkK3F0RJ+f/IfMv/NJHhSkgTdI6a5cF/HvBVXgFtwbQZiaM1lseQOzviWIEY6fngO4uCKTGNa4u2Aos3a6FbChSfS+5iFxVIW8f/wBcMt1SYuSgiCkGRUBhPY95zXicBnhKe9NdFbauDiqglipTz8Ca4QBicyedxfnhF1dcPeYmmH+II7Yru3+vy5UoHyHX3xuqIp187J2kEAw0mH3px1z/NiBT6I5nC7X760Nonev6kxuvXWskzUB9iqdOizU6x+DjU/n02wuOPkqXzjOQCLBYz1gWVbKQiCyZ9oWbgzfhozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dh3iSTh38LHFjNk2S47/5BRDGKxBQ3UE/8cutDKDXxo=;
 b=K0sP6ymZiDR/WTHJhJxbuKg2I5tjzPH7swKU1fSUskeYSGQr55pDOdhkAuOYjHSeI/rW18sye2lahIwJflQsXMzhvTvwdGFT4dmgsI47XVSI2y+y+QUDPCiabV1JoS8Q6LhK5S0s/7Xcm2+5b4ML2nO4vuabVBsZFttQyFQ7Bs/CMHuoq7zvfE4I5EUDeytT5MWpW1N7zt1iKqtcLseGyZDIgXOwb2BJxGqqtt5Xy+Tq3uNUnYri1pRm+KMbIVdV61QVNIRvpQ1DXxbX1AtSMR44UyVdc72dkJqbdkS+rCCeYzM74PWksO2OunSppj77BbOmevOHRaY9cw3fTEdXGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dh3iSTh38LHFjNk2S47/5BRDGKxBQ3UE/8cutDKDXxo=;
 b=u2WHMzGwOeYpuWKSiAT8koYQCODvk5WaGy2KovlpFPXQouzRqdnFQ5uaCU4wzHpWKD3KYeAsVrzu5LJfno90pIPm3ndjUa7sw3DZRjqwNKd3VrHqL3Gl6uNCjHAgzRJkrTr8YuQTZm9JkGrFmHSoRlBX1KH/90ZMQAUP2iUbcHI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO6P265MB7083.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:31a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 02:27:40 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%6]) with mapi id 15.21.0451.024; Thu, 1 Oct 2026
 02:27:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 01 Oct 2026 03:27:39 +0100
Message-Id: <DLT5AOYLEZXE.C2HPEP6WSP33@garyguo.net>
Subject: Re: [PATCH v1] rust: serdev: use Delta<Jiffy> for timeouts
From: "Gary Guo" <gary@garyguo.net>
To: "FUJITA Tomonori" <tomo@flapping.org>, <gary@garyguo.net>,
 <markus.probst@posteo.de>
Cc: <aliceryhl@google.com>, <dakr@kernel.org>, <ojeda@kernel.org>,
 <a.hindborg@kernel.org>, <acourbot@nvidia.com>, <bjorn3_gh@protonmail.com>,
 <boqun@kernel.org>, <daniel.almeida@collabora.com>, <lossin@kernel.org>,
 <tamird@kernel.org>, <tmgross@umich.edu>, <work@onurozkan.dev>,
 <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <fujita.tomonori@gmail.com>
X-Mailer: aerc 0.22.0
References: <DLSP8RHJMYFZ.3II53ESHY15IL@garyguo.net>
 <20261001.092931.734162860031900892.tomo@flapping.org>
 <DLT305M0I5L5.19LZT0V02L1NR@garyguo.net>
 <20261001.102816.848418815165006267.tomo@flapping.org>
In-Reply-To: <20261001.102816.848418815165006267.tomo@flapping.org>
X-ClientProxiedBy: LO4P123CA0297.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO6P265MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1612d0-5a96-4a24-c565-08df1f6390a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|366016|1800799024|23010399003|376014|10067099003|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	awbVb6bHAtgnzpEJPu1jO9e3MXcaZ9XKcdxBc1k5Z+Rv2aKaddf2HdP7sv1POqmLGD0KZBx5lpMBfpWglfwpmWU2tfvN5kGKKZp9iQH7iXhqkSEAJQ6lPc8YV1XNBS9yTd6NrHfb7Lh3eif/CSsRV7RRIkio/5qlrlUTq9H3562l4yMMJIE4Zc0qUf69R84/JfZgLk0tLnAm5jlqcLRR/qIQEP4tOCwdyETZusabBeHiSWi9fR3Dg/Jo0JrgP4wnYSPQemO4n+4cVhkI/iOuLLEnPscuIigk8R4FjLPvejBWEH19FpwXeN4O6bAMB6pdUTlHv6jju0AXU1QuOenuSgabS82i+CVDyCG4RymtcXPdsSSCdT1XjVxZmujitG/OmdMc2B0VCB5rIkLiVDWxUa2uLRawOAVxelSiv51KE0Eam2b2W88t+1Nykpu3hWa0wWhVayqi96g1x8qrcJchoPc4PQTYVTHJwe1GzUgWS6yCwy0WJpM0doj3uS2n4P1vFiyEvSQxpmYAQAvKEk0dDz2tVttMb08jK6xrtxJs0J2ONjvkow0k1LDl5m14uOJY7J57Nw5qI7Qa3t7wR0wc7sYeSRERkz+o4Srb7xq5hgQSgnUoLMIm8sG9Qsv69BXVcEEbL9ruwK+6bIuvdk3adDJOobscIuBgEKX/hhWFm70=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWVlMVo3dW5mVTZxNnJsdmpxeHJyZ2cxQWJ3c3d1Q0lEdkQ1aGRhdDd2dlh3?=
 =?utf-8?B?S3NabkVwd0hSazNjRkhXYmxYaVcwRXVhcFRFZ2xsakh5WkhXZTY0a0Z1ZEth?=
 =?utf-8?B?Uk55bXRleEJIRlU5TGFvTm05Y0NYZmd2Y3hlRXFyWERET0FZNlRkbFpIUjRh?=
 =?utf-8?B?ZkpQYlR4dmdlWWs0bHd5M3RHanBHT1JQZTZ1Q1hQU0RHbWFWWGVudndKNmd5?=
 =?utf-8?B?a3NwRExSdy82WktUWFk4OWxHSjNzOExTWStJMk1oeWFlRTRBNDBFT3p2Z2dx?=
 =?utf-8?B?Wm5pUXJRWVljTUV2UmRqYWRRR3UzaDhmTjE5L2VZenBLbDNTN25pSGYzQWhU?=
 =?utf-8?B?V2R2QTZKZVhsTDRnMlE4alRlNHN6dkI1Rk9kNG1hNVMvWDdiSDRvVzJxMk8z?=
 =?utf-8?B?bGJvQVQvOXB3SEpOZmVvY3c5RkJ3RU9WQ2Y3Qk1kWVRkN3ozbEdsZmwrZEhT?=
 =?utf-8?B?bVZyWVl5SG9jdnlLTU5lYnFRUm5td3MvdVNiZkJQM1FnWFZrcmN3R215WVNB?=
 =?utf-8?B?NVV4SUNPQUkrRjJleVRkMEZVZEZ4Vmp3Q2dCUDdNRTdySVBaNDVsK2Fra3FM?=
 =?utf-8?B?aXRWeXVJcEZyQWdmSmpSK2hoelVZYmZNTHh6dG5WRm1jZGlLWXFyS1dZSjZV?=
 =?utf-8?B?MTQ1c2tVZGtqS1FKS2FRZmdHQjFwakk5Ym9kTElPQ3pFM0J4RjJtdmN4dDA3?=
 =?utf-8?B?Z1Z3a29lZ3NmYndTK1NTQ2NTTUhQN1FUeFZZZ1hrdllsaUh6NnZ4QmRIQnNO?=
 =?utf-8?B?SEFiREFUU2FyOW1ZbVJKN25QNDQzZUdocTJCdDlhek13eGY4UUM4UmZhRlpX?=
 =?utf-8?B?dkpUSjlXZHhvM2pMYTNReHRMalUzVEpWdEZYVjFhd3dZNktiRFJiM3NOa0JI?=
 =?utf-8?B?V0N4VnRtb0VFN2s0eGFCRHhFaCszYWdCQlJmTEtSVUJVRlMzcDVwVGxYSmhH?=
 =?utf-8?B?OHJKYWpiQjVyT01lcXBtUUxZVlJ1Vi9neW1qRHpRc2FOdWlrSW1RaTQvbUNP?=
 =?utf-8?B?NDdGTXZWd3hzSFdMWTMzKzl2VFZCUjlzUHVKUGlVQ2tOMkwrRXlpWHN1UEZx?=
 =?utf-8?B?dGFiMHZIQ3V0cURQWTRkZzlEU2FzNnc5amo3WmhLVEdUWDF2bTlka3ZjTWhB?=
 =?utf-8?B?Z3VBUHlVV2hlY05HTUQyK1puMjk5YmhuWmk5VzR4NEVreGxxSWY2aVN5eFUy?=
 =?utf-8?B?dk83T0dCaXBONFdqbFE0bHRVRzZaaEQ1YXc0dEErUHRVbEM2UlNMU2FyM0lx?=
 =?utf-8?B?Y1Q5Y2hVam91dXJ2YjJVZFdFK205NEw5NUFMWlU3WGR0dDRJNndTbGdHcitN?=
 =?utf-8?B?S0ZsZWtNaE9jRDBlQ0ZxRjRBRjJFMm1JZ2FjRlJSTnlCZ0cxaXlsYU5WTkp2?=
 =?utf-8?B?ZVlHbitjZ3ZNR3p5Zm03VVNSZkl0OW5HRVBqRjdhdE80N1dnVEhnQjZXQnlU?=
 =?utf-8?B?NjlLeFY0RGNaUmpudmY1SkZ4OFRCUlZocmJweEd6SXFlK0VXVmtrczZYUHJG?=
 =?utf-8?B?VzNVaStPbld2OWplU0lpU0RaRlF1WldTL2pUNWo1UEFoOXRja1MwRm1Mb0J4?=
 =?utf-8?B?blBUREhkY0JUd0tFOEhmOUpDRDA4cE5ORGNJU3VLb0pEZ1BxQzVwcnBsQXY0?=
 =?utf-8?B?b0FURlpVaVJOanRZQng1REhob2lXQ1VyY29nNmY1bFJXRStoNGs0S0g3M2RO?=
 =?utf-8?B?WDJwcmtWK09CSzZPckpmU2xWN0x5ZDdTNDd4Mk1BcVVhTkRBY0Nrano4T1NP?=
 =?utf-8?B?SjBMamI2ZG1Jd0tQbndMakptSEpsS2ltTllGOFlLTm13bEhpMkZQditDRk9G?=
 =?utf-8?B?dHZWNEdUclY2dWRoa2x5ZnBoVEViM0NOcURhdDRlOWtLblUrQ3Z6WTNreEZh?=
 =?utf-8?B?OXpxVjdWUHdPeHcrWDc2eWF6c1R5bW1DTmNLVXQvQXhHRmFhNTdPaUU5dGxq?=
 =?utf-8?B?YkNaL3U5Z1FCMnp1bjdiMXdNa0d0ZTFuR1kwWnk1Slp6dVNGOEhGeUR5QS9o?=
 =?utf-8?B?ekNHVmswTUwzRWRJcTFWYjNCK1RuN2k2L0ZoWHRjdUp5WFNzMzRxa0VQUHFR?=
 =?utf-8?B?TGpDUWdMOENqMUd5bllTdks0OGlPcFhGTURqVmQwVzcvbUxKNldsdjI0RG15?=
 =?utf-8?B?Vk9tWkNRdit6NFM3YWtwRjZjVTVpSmROalNVSXpaZjRya3ZBQ01YMnZJcjg2?=
 =?utf-8?B?U0UwVHdwZjh3blZFclZxVlI2aEFGVUFhc2dFTXlRTWdOelE5cWZ4Z2pxdmlL?=
 =?utf-8?B?ZVlTbklPbG5DT0p6QXA4NGc0SnljbWVnbmNVcGZUdDlDOHdqZmZUQkt0NFVj?=
 =?utf-8?B?UVIvSzJ2SjlEQ1pvL2V4b2EycnVUd2J6aFE0aEdWam55N3hYYVc0UT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1612d0-5a96-4a24-c565-08df1f6390a2
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 02:27:39.9534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dxU6UxX//3EKKLdYV7x9ux7bQRiKPkEtl7YgaluAjJIxvxkMXbBE99ZpN0hNKKnm6XkvE3NwJq3VfaHo13WikQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB7083

On Thu Oct 1, 2026 at 2:28 AM BST, FUJITA Tomonori wrote:
> On Thu, 01 Oct 2026 01:39:51 +0100
> "Gary Guo" <gary@garyguo.net> wrote:
>
>> On Thu Oct 1, 2026 at 1:29 AM BST, FUJITA Tomonori wrote:
>>> On Wed, 30 Sep 2026 14:52:50 +0100
>>> "Gary Guo" <gary@garyguo.net> wrote:
>>>
>>>> I think the API should ideally use `Option<Delta<Jiffies>>` for this c=
ase, and
>>>> use `None` to represent indefinite wait.
>>>
>>> For read_poll_timeout(), where a timeout of 0 means "never time out"
>>> in C, we did not take Option for the timeout. Alice's comment [1]:
>>>
>>> | Another thing is the `timeout_delta` option. I would just have
>>> | written it as two methods, one that takes a timeout and one that
>>> | doesn't. That way, callers that don't need a timeout do not need to
>>> | handle timeout errors. (Do we have any users without a timeout? If
>>> | not, maybe just remove the Option.)
>>>
>>> serdev is in the same situation. Do we want an API that uses None for
>>> "never" here?
>>=20
>> I don't like the "using 0" to mean forever, because 0 has a more sensibl=
e
>> meaning -- which is just do a poll and don't wait.
>
> Fully agreed.
>
>> This one doesn't even return a result at all, so `Option` sounds reasona=
ble.
>
> That's true for wait_until_sent(), but write_all() returns a result
> and it can be ETIMEDOUT.
>
>> Alternatively, just use `MAX_SCHEDULE_TIMEOUT` (i.e.
>> `Delta::from_jiffies(isize::MAX)`). We can perhaps add a `Delta::MAX` fo=
r this.
>
> I don't think Delta::<Jiffy>::MAX is a good idea. Whether the maximum
> value means an indefinite wait depends on the function. For example,
> it doesn't for Queue::enqueue_delayed().

Whether it means infinite or not depends on the function, but that's still =
mean
"MAX", no?

Also, it's not like serdev_device_wait_until_sent use it to mean infinite
either. I randomly sampled two wait_until_sent impls and they just use the
timeout in arithmetic, so it's just a very long wait.

Best,
Gary

