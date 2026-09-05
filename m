Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022075.outbound.protection.outlook.com [52.101.96.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532851F938;
	Sat,  5 Sep 2026 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788618269; cv=fail; b=U3/HJ+FtpN9RPszx0YUqEn1lvMxiMKIVLeu0JXbrfw8NaeJMHqVqIhx+O2qVHvLTRJz2TD/1wCoddh3zOkWaTjZ2hKpF8tWg7hsztLJcRYDWxFLnWKx4BknIYRJLoIUbPPa8F6uTp73tNP6RoGGI6ur0xbHH+cE23Y96Qvm13qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788618269; c=relaxed/simple;
	bh=6WN5/q0JEoyXFw4KNK5stJwbjAKF7QN+H13RSB0V3hs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=AOMbe2pVvJPBhxBUlilzV9XlhgPG9zSKDuudSzVRwxnb1tmdSDBbipjYAOsca/cXVgiJsxrxxzMAdLCC+2CxKwJPq/c3JxPARp0GXE59Uz1N3mIrVUvkUnQappxT/tXR9GOBVy3/9375tl2MBAnLgjofiuPzrKQM21Ewqm86Rgg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=WLaYjThH; arc=fail smtp.client-ip=52.101.96.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="WLaYjThH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jp1IdwMKnRJUpmUUuDE7IRLGZ+0aazXtfxvEc2THbdWxDMO1gZJdFbeB2vefdYwEGgvcLuhXVuU36f9hpMFhTLc2a3Ck7k1/1e+d5m86w8qZlJAumhT8AeiMJ/x/7RZiMifCljlLNxNthU7QuNBCNA12uAeZVinGpkjPbwWDt01/DP/0HC/LnCDTpj4E4Kq1HP00JgEgTzwKzShID8xucE0EY2OBqSwfp+H/vwiUxLrEtFeiKvl/BbvNb0t4s1XXu/8TI1xmc3pMpfKXU7vJa8wbUSoOK3wNWHo3C4xX28xveWdAMk+rUo6rkHWCNDXMenyRhqlKt9Tl2zT1dk/FzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WN5/q0JEoyXFw4KNK5stJwbjAKF7QN+H13RSB0V3hs=;
 b=oQEB2hJGQn+n+5htyhrQZYDW42VZfgNSNmgw8Lv9ZvhsQeUFWd+Sbi29+7BVNlMDgfiRhLD2yiXTQkHcZnDnaniQJpNXd1KV4aajIBZQ1W3hYazupCSyM152+bMIdTaoqPGD5yk3V3hg48qj5cqgEU+EC1t8lX1p8u7c0mtM9ZV9MGCOVcT0mrrEDlKv2RMFeMSjyf1/qKQA4OJEGAVfWEnRU7Iaijpq8u3ra5md2qbACZeOAyK3E4bxoFETA/4/ek38UYSpakMqqnVI7ooHNhTlonBrV0IAhVQNxzSqS1qk4qaMAqXXWS75g0u9L3MMBiPStDSd/N4Og2/u9lcSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WN5/q0JEoyXFw4KNK5stJwbjAKF7QN+H13RSB0V3hs=;
 b=WLaYjThHQKMyu6ghY/sEQyuDtGQ6nODqDv+uaTVv9r2tfXRpV32TsCYNbg2HnRm7LVn13cSk73KMzKkLO7C22596NZWC7s8f3wj1x/+0PfMaMzkoJ0+7RQnj9ZNbkG/SUgTQEZHr1YWKTYE7BGGsmK/5egBiYcywLylvh93NRA0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7587.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Sat, 5 Sep
 2026 14:24:25 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 14:24:25 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 15:24:24 +0100
Message-Id: <DL7G9BAEFESY.2LS09S43WOK9V@garyguo.net>
Cc: <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Sashiko Bot" <sashiko-bot@kernel.org>
Subject: Re: [PATCH] rust: serdev: Fix race condition on driver probe fail
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
References: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
 <1b247f730001ea39b6e4044f5673e1a01e187362.camel@posteo.de>
In-Reply-To: <1b247f730001ea39b6e4044f5673e1a01e187362.camel@posteo.de>
X-ClientProxiedBy: LO4P123CA0613.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::19) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7587:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a945ee-19f5-43e9-6530-08df0b5962e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|23010399003|7416014|366016|1800799024|376014|10067099003|18002099003|22082099003|56012099006|4143699003|921020;
X-Microsoft-Antispam-Message-Info:
	tYrxO1fHXs5pZIepZy5xx7XXUkUy/McHfTqqKYM+G4c+3tP3DXctt5BIzy4QeKA36vnmmvqJVTMewa099vSw0l0q56nZVb9q+mSm0ylMjrQfD13PM1vrSQJ65Io2VgF0HIPsWB5P4NfTud1XbvmfkrgsRAtc6kU7qmJg24VBTLcLLEExE6/m8qA8M6yyzZcFlP3mElbf6rfVulXdD6Egz+KmKtuffU+5ljLC+XViTEtLzIRX7fhPBzurMum7Qw0NWCXmZLJca8vrdn/pVBz7CtIJlvolVRthXzD7Sn3ycLE+9DStwEqz1vNBcBNNGQYI53P+hmCy3wnV2ignBYL5Sg7ZDIFx3Uz3V/TRyNCH6pdUeA3sGthzXyV7XWaiKdPtmmDIcU/6RNUEZQoTrkWVDf6FRApn7Fz2OcAPFGWrjMtQ3fUfpptGonM8lY9h9MWbbkR8p2MFedcJvkHus3fpgubfMEZTmfvkU7C8Dqzjjbqx65wxUoJhmkJP5Qet3GqmN3OxoEAViek41y2apka8SdxDXBqmkijkT2N5Rl/RLgBpRIxoqF+LLW2vsiD+6GGk/WvT7Kj67W3z3RVIlnHOCi5XH9gyIBGP0uw/V5rmDyM7u4QbWUqwpo5xiJBekdHExDY59aEEiTXwAqvMcS363w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(23010399003)(7416014)(366016)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TkJBYkZRS2p2Q29HVE9TaENjR3lqbW5JMDJ5Y3pZSDkyZzhMT0RhaGdFU2hS?=
 =?utf-8?B?MzhPTEg1UE9mNmJKdFhTTU42elVMeWgyZVpybnkxWWt3TXIxbnFzaXRReCtm?=
 =?utf-8?B?YXpkeUpQeHpLZnFCRndkU0cxR1lwalg2ckRYa3ZEWmtGdTVwYlpZRnZvVU5T?=
 =?utf-8?B?VFV0Zll2SWhqOWcwWStiQndnYkZubWVwQVN4bW5GK0NFOEE5L2ZWdjNIVFRH?=
 =?utf-8?B?VEExN3JqNFZ6a3cwUmpPKzZmb3AvTGxFMCtOWGd4NkUvWTVsQ0JFL3pFZGlE?=
 =?utf-8?B?em1pbzg4ZmdsVUFZd0dVVVVhUmRqSG9qWTdNUWRwYmxYZFFOZTJ2cFp3dGFj?=
 =?utf-8?B?MmhHSGp0dnpwSUdpenpKTFJPSnVqM1lGMzFuS1dXS0tNeDZpODViQ21Kbld0?=
 =?utf-8?B?QUc0WkFEVkFTbFJQUGc2bC9mbFBDUHRpODBTUlZkdXJnRm9jbjZScEVQMDZJ?=
 =?utf-8?B?S05yUnBqeDlTTGx3NURaSWtzc3o0aTRveUNxSjY3eDlZc21rNW5aZDFUV1Jt?=
 =?utf-8?B?Z05aQ1JWY0FyWGkxY1RGNmlPZkcrUjdhK1kzZndCNWdBWlFtQUNGSHdHTWJm?=
 =?utf-8?B?SDBSenJDRHRUOFVmMlBBTHczVFdUU1VEUE1kc2tBNzZwejlTRElrOVNGZW13?=
 =?utf-8?B?blVTZ1Bjd3Jpbnd5YjgxZ2RFR3RCenU3MHE5eS9ZWmd1MXhORDNkeHA4a0k5?=
 =?utf-8?B?U2FFOWxKczVOYStiWS9OamFDMHJ4QmRTb3hoTEg0NDR6Z1NwME8reVNtejR1?=
 =?utf-8?B?NUtPZGhyQlRGQjJvZU5oSmY0ZXRKSnZoU09pWXl5ZHpOZG53QTlzeVlvS1Jk?=
 =?utf-8?B?d3F3N0FyRVBSMTBVQmdTZlo3bUliZnFhS3k3cGpIUlRDaS8zVDRwR1JycGlR?=
 =?utf-8?B?OCtJWHZXU3lBbEd1aUZTYlNvSTBzdTBoeFNkN1kyaEhySzVkUHU3VlRIUlBV?=
 =?utf-8?B?Zi84ZHdYQm1PYklnNlcybEIveGFqZzlQMmg4U21NTVBkUENTUi9UV2ZiNGtX?=
 =?utf-8?B?cFJLVjVZWXVPMzZuM3JSQVNlRlFwYkp1TVZuV094dmcxMWlZaG90cndvdnFs?=
 =?utf-8?B?Tk44L2xmbktpMUJIbHhuczBQWTZVTkZ4bGhoSU5mV1Bsc0hoZER5Nzh0RGRX?=
 =?utf-8?B?bFlxMUdWTXg2QTRLMmpWVjFQSFM2aG9jcy85MUVDRVkrbWJFY0NGUzBpRmQy?=
 =?utf-8?B?RFRldnFRT2hkUGZyV1hpQnlzS3FKZHZhVG4rTUJWQ25SOGIvWkhjVzFrUlJa?=
 =?utf-8?B?QnZ3eG9tUFFuY25MQUk2dlkwZlBiRnBvN1pIelloOExwT3FuL0paRHZ0dTJY?=
 =?utf-8?B?VzQ0YXFWaVFiVHVzU0xWNE9pUlUvRkhiY3poekE1ZTBnZ3RkdmQxRmxJWEtw?=
 =?utf-8?B?SVFheUNYTjB5cDV1MnduTVNMNWxOUUNXOHp2bHFMY3hsWlBSZ3QrejcxcUV6?=
 =?utf-8?B?aWtML2pSS1NJdUsyRVRvT0psUTMwK3Fxa3dTVTRVQTdVMVdDNk8wcnFJc3Bh?=
 =?utf-8?B?N3NCd1lXMnJPSzc4ZkFVd0lmTEtNNi83MTBPWDJVNHdpSWd4cmt2V3pCR3lw?=
 =?utf-8?B?TDgva29vaXVnbmtKcGV1Ym1Ibm9CVWIxU2RieTBXdzVvcUNpcGNnbE9ZSmRZ?=
 =?utf-8?B?ZVVyZ0V1MU53OG5RL3o3dG1GdmpHWndDMTF1bnhCYU1IQ2VONkRVTFdPVzdC?=
 =?utf-8?B?Z1Awd292RG1JWkM1aG9qN2FPa1BBc2YwdFViU0pDZHRGdWlEdk1lODZEUVFM?=
 =?utf-8?B?bURNa3BkTFlWQzJLU0lxUzVjQ1NoQ1lkSS9UNHJrbTE4T2VRckxCVHMvblVK?=
 =?utf-8?B?cDg2MVJaUHJQSVdvZnZTL1p1RVRUS1M3dmdaRlByTDU5akhaRlB3WU1DNEhq?=
 =?utf-8?B?b08wajVBZ1YxQ2NVT2IyOTg4OUNZR0d5VUNUNjVLWWpxUFhDMzFLQ2QwMFRz?=
 =?utf-8?B?NlNzY0RadVhZUUp6QmMvVG54czkzRHRtNnNDQjZTRFNvODFBQUVxdlVidmdx?=
 =?utf-8?B?M3FJODhxU3lqLzlKN2xYV0dSMlpCZGk3MXMxMDFwTnlUanBHOHpRazVyWk40?=
 =?utf-8?B?ZFl6YVkvVUpBWTRuSmRWUURzdjVTZzBSUXBPdlg1Vm5UekxqNk82RkZoejEx?=
 =?utf-8?B?d3B0RDVTUXNHV004Y3NiV3Y5KzBiY0VSd01LY2E2cHhYRnlISzRrMkhiMmdl?=
 =?utf-8?B?TzgwWkdlemxRdUFzT3JUMFFOK0FqMjhYUjVnSFFORFFFVkM3aGFYUHl6dUVI?=
 =?utf-8?B?WHNtK3kvK1BjTE9iOFFVNERZaVcybHZ4YlFmRW9zMkxBeXpiang4Zlp3OU5Z?=
 =?utf-8?B?d0lPVlB0aG8xSitYdTFpaDNicnRzbWMyUGd1eWxuWWdYYzluNTBldz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a945ee-19f5-43e9-6530-08df0b5962e3
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 14:24:24.9606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhN5P88DDqKdlefAXzWp5h4x7uGdRDKH22UxSucivrL8uTuIoEFHiqseuPaQjrl+KgNHLTE7uBK2U+dBWCSB0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7587

On Sat Sep 5, 2026 at 1:22 AM BST, Markus Probst wrote:
> On Fri, 2026-09-04 at 23:54 +0000, Markus Probst wrote:
>> If `Driver::probe` fails, the pointer to the driver data (`PrivateData`)
>> will first be set to NULL by `drvdata_obtain` and only after that the
>> serdev device will be closed by Drop. Thus there is a small window in
>> which the serdev device is still open, but the pointer to the driver dat=
a
>> is NULL. Therefore it is possible that `receive_buf_callback` might try =
to
>> access the `active` mutex on a null pointer.
> It seems, Sashiko found the same issue in a different unrelated place
> too (while reviewing this patch):
>
> https://sashiko.dev/#/patchset/20260905-rust_serdev_fix-v1-1-2ea92b154a6b=
%40posteo.de
>
> Unfortunately, I cannot fix this one so easily, because the serdev
> device needs to be open for the entire lifetime of the "real" driver
> data (Driver::Data).

What would go wrong if the device is closed before destroying the driver da=
ta?

Best,
Gary

