Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191D49483F;
	Thu, 13 Aug 2026 16:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637345; cv=fail; b=NC8lDEYJmS8jPZNOlGsMeCM76BL+vSBzjgtYBIzJJVvu2+sorgFdhG7rT9wmS/Uzvix3Wl3ROYVwOMxaYOSG+lNCclN4MnnXZhTHAR5CGmwJnO0jBoBfDQoVxBRytXf/aOZQikNZClEo+6QkR51TModIYcRC0ilsYF0P9NM4FyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637345; c=relaxed/simple;
	bh=uHOGmIyxsBwpuyYQAnqqLiu4nN7l1A1SzFuo7IR/cO8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=dUv+z7q5ANSoz/ZSpKZWqsitTDnqAhS19hVD0zsUVuD90gMGhwiC4L1v+iMUWcyWtPT3pIz4BK0Za/7Jf3lnSZzAm9VL+IRqYgSpeVoIhVQHh4+CR3nqFfmLn8UrM4/H71zVfFlwTOsROJZoaKVCx9eHU76OKRe/bbJvQKCnZTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=RRKAEW3K; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="RRKAEW3K"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fYdUQteo4cT1KkNXinh9Sxf3Cc5N0xqVnNVQPVS63LNVAPJH9VZX3oPMu5TcmJpMmBmdHG29kukcyT81JMK0wLSZI8jTmf+9zTrVgDqysCjlLROyq8EPp5VpeqQ6DSqBeDKGbmNFqbnjguW/Fds2hsaUewSlZkz57kq6QEvmw6WpM9t8te9tJzgdgrPQw7sh7xiHtugOe+okyhKeelTUVAELP58Ddl+sn2v4ZCaqKOE3Hcekx1ByH7q8ju9Dn6ILMEgrSIMXoU0fMzCg+0onsoujzscKq9yvD4nLuogdXRKs1D+ArOYCB+ANK52PLixAcO5zR1T8E002iYiO81/ulQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zB9a7yNCeBLkxk9QjO8f6CeYrg4vvmyWmj7PhjY9rqc=;
 b=fIqlY50Mi7emXqiqsKCwqNTywAc86BoL2qfQA28Iyl+SMgtwf4masL4wHpTLr6IEsdEm6LkFD6Kv9cncbMTrp+mbCgMy+6bARNT4EUVaPdUuvh33ej5V1zE1rCor9imaccQwbvBf0TGYlco+SwoyUsN7QdvpS5cewaPnu796Q3q5F2RaDirtCL9Ix8UBMdhaHbx3Ia01ZJ+mh4FUscspLLMj4h7t65Z4w1Z3MxPDxQmLNJmZLk0CW00fb6SyuAdKS2G4iXYIk49SH0wGW4zstijjfA08l33jsdp66+Pu2mf0hY0XGZnObe6i+QJNkulwmdJwQQlJ94GTcBJwovN8bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zB9a7yNCeBLkxk9QjO8f6CeYrg4vvmyWmj7PhjY9rqc=;
 b=RRKAEW3KiiuFdfJPyCI1B2z9PzDz5eTjSpJja4f+GlnlKq8qUJfhF9jCcLTJijlCKsXy3yoH+gYKprYOUzyMX+8Bm52GLtrEXueoku/SAGQ7zxuwIdyZ6J/AY+I/ZcaKDSKPeVK2FYJjjrCNDRCaAYexa+xi6HJyR4VjjqRFSUU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LOBP265MB9411.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 16:08:40 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 16:08:40 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 17:08:39 +0100
Message-Id: <DKNY2LUW9PVR.1V73H081WW065@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-serial@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: serdev: use ThisModule::as_ptr() instead of field
 access
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <markus.probst@posteo.de>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <aliceryhl@google.com>,
 <tmgross@umich.edu>, <daniel.almeida@collabora.com>, <tamird@kernel.org>,
 <acourbot@nvidia.com>, <work@onurozkan.dev>
X-Mailer: aerc 0.21.0
References: <20260813152444.514580-1-dakr@kernel.org>
In-Reply-To: <20260813152444.514580-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0310.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::9) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LOBP265MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b84864-1a9b-493a-c6c3-08def95523f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|23010399003|1800799024|10070799003|366016|10067099003|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	j9HSEffu0SiOoWMoUP5O8Yd0Q4XjN6B+BmdHScHJyBI1ntikxfB1oAE55PLZ0Hy0HzdqHO8xwDV0emTFGnVyxVQpZAkBrU+5kWLyGKFjGSZtx+oCtTSqzMhJBT6z9+UbgvPyJQ6TaDswZdpvpnR7tAfq2OFZQH9DZvOjMzjQ5kralTYSAOrVl6/mYivda6yzV8jgOQZJFwezXMrMQbgBloLdZ6oLsNfvog4IBdjkrxyAU6wyaUnx4bkJe/yF0tyCyoN7mZDUef/K0wMZFHW9mbHs+EUVuG1qUrygekYvf3xaVUyaRTg3y/hIyl2A9DcDGm5BlkBnOF1Ome6GJGur7jXuSQmbThwj++onq04h8K8R0YQjRtuWhjTviT3Cq66bU+7bvRskELBca6hkCfVWcKua0OZyryYmNgmNjPVrVfCDwDvUhKemsc4l2sCxh/dQKI0LsiHxVxH6KPRVYxIbmJSHiKRbGNAB2LYe2EcSb5XxD6vfUIFb3Y++ZC0auwKpQkBkLPpq7oVOI2JQ2e6kvFYLhk1g72/E7HHekN8Bo3Z92thfO221bT2meq22LLEkrPks2kGpTnNrHXASxhjN5B8CDd7JWQoQCNqcm8dU2TA+dzFi9pBVltEN/FNIx02yTTgKUxtYuvc/MRFe29DSJ3RgaBggPyfbGoFgEOe6Nsfg4JVHDEHpfq2X4Ag0Ls6unHD4UrlowMgwh0FE80hvdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(1800799024)(10070799003)(366016)(10067099003)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UVVRbnZlL1E0Zm1jY2pxZVdROWZTM3dISStSeXUvRlhFTlhHU1lFTm9LeUtB?=
 =?utf-8?B?VEF3NEd2azNsMCtvc1FIMW1LMkdTNFZBdnlGL3pSSWdSUkw0M25xNFV5N1Vx?=
 =?utf-8?B?MEpta2c1ZjJvenlaTmtMRGNkSlE4WXBVTWJCQXlkeTg1a3dkeVpUWmJDYUpU?=
 =?utf-8?B?R2lSczdGR0hkTmdiQ2tzNGFGWUVYU1FrVXhKYnJmTEhzVmxLcTc5VlBHRWkx?=
 =?utf-8?B?dGQwT3luYUltYUJIT0t4Q3crdzV2RHdVWXFDQnE5b2tnSnNkdktqMDE3dHBZ?=
 =?utf-8?B?ajY4NkNOZ0ZXSThYVmdWczIyM3cxY1RGNEd3UUl1WUhZeE4xYkZTODdPUWdE?=
 =?utf-8?B?WlVZemJrRXV3QVV3RkJXby9rUTBUaVNYRXZUV0dhYzhxSFJ0L1VKT0RaVEY2?=
 =?utf-8?B?cmMyUnhGVDBxNHNVTDVsM21sQ1dtRlZ4L2pBL1h6RytkenVGN29MQXVsaGxG?=
 =?utf-8?B?T1ZLeU8wd3dLaUZ6OFlMUlVJb3lzYXpLTy9pK09zclpZSURINTVTaFpsd05T?=
 =?utf-8?B?aElSelNhNGVpVWQ4WllnSHA3RmZkcHRxNWEvbW43TFJSOVFoeTl1bXFNWmJG?=
 =?utf-8?B?aUFHTk1Pdjg0Q3h6cmF4Y1pmN0FUdkpLMUwwYmxUUUtYSGlJTVhKaXZVaU9P?=
 =?utf-8?B?VUJNT0cxTG1zeEtBYXdkQngwRjBQTDRROFE1NzhLTGtuYzZhL3AxZ0lYMnVP?=
 =?utf-8?B?dk9uemFrV3VGZGZwYTdsTzFJWEQ4bU42VGpuY3E5TTIvZ3h3WHprd2tRRzdQ?=
 =?utf-8?B?cHFWVUlmUFNLY21PMTk3U0tKMU5ncUtrTFBhdlo1WFVhdno0TVZ3RndidWwv?=
 =?utf-8?B?UWF3dDdZelZHR3FHZVkwV2paQlRmYmtEVkM5YnlYRjNlbHNKUnFuRFo3dkxN?=
 =?utf-8?B?Kzc0SFkxWWF2ekZNK1VBaC90YTFjZ0dkQXJYd3MyMGZTTDM3L0hXZWs1QURm?=
 =?utf-8?B?aGpIVnlMSFFxdUFQOEtKZmloRVlNZHMrL2ljeDBEdnMrU2dDenRkQk9JbjdM?=
 =?utf-8?B?b2t6L3lIOHRvV0tUaWdUVUcyUlBaSnIzNFVwQWFpazg3amc0RWZYVGVabHNo?=
 =?utf-8?B?SHh3MTJaOERVRFRmd0FLTnZQWTZrN3dBS1RWOFQwZnN3dlcveEZyYzRJWGVy?=
 =?utf-8?B?NW9jUCttdzlpenNUTThjVGZYYWZNTTBEa2o5bDhodXF0cmpkTUpmMkM3VlJJ?=
 =?utf-8?B?YVZVbUZHNDFqL1NSei9FZ2JXaURaNVpRUkFieVF0WXlHZXp0ZVJsT01IMkRk?=
 =?utf-8?B?YnFHbDVXRlN2TjFIak0wTm5oNnBHemVjZlkrbnU2cHlheGVSckNiNEZ4SUhu?=
 =?utf-8?B?aENSRE1uMzQ3a3F5Rk00VjJsTmFFeTZTUGZWa1lOb2lIZTlwNzdacUpmYXN3?=
 =?utf-8?B?TGwyRjk1c0NhY0pqQWRuY2Zuem5Wa0VjTm9HUzFxKzJFNnlSak9YYm5Ka3Fq?=
 =?utf-8?B?L3gzS0NEOHBaL3RabElrL01heXI2M0VVOVRuNUpyQmZuN2JoVjVrTGZBaXg1?=
 =?utf-8?B?b0w3KzQ3KytsdTREWDhWZVVHMkFmR01sd1JXNmUrNFhpMEJzaVdTQ0g5OWtq?=
 =?utf-8?B?WXVQS1V1UHJaMFoyWkpiZ0R1WTVyQTlsY1NlOUEyeHJaZDlFYmc5WVBOK2tn?=
 =?utf-8?B?OXVQNHgxOUJxdHBvOThJT09lM2lSdWkyb2JsMnBJUW00a3BjamFldk5Oak5j?=
 =?utf-8?B?T3V0MmRyMmZKL2o4RXRCOVBZMERwTTQza0VXWHNSdDB4blBNdk0yN3o1YXl0?=
 =?utf-8?B?UkdYanM1U0VhbzlQK1c5eHdtK3AvbExnbC8rMGFDRnBYanZJTWZ4WEFMMzJM?=
 =?utf-8?B?NzhENGd1ZjUvR0hNSUFyU2lyeGZ4VkhsaXBCek83WHh3cXd3MUFOWmx6aUtl?=
 =?utf-8?B?cFZZalh6VzVRV1c1MENwZlBzdWVtMG9ucnRucjIxaHhYaUo0b3V0TjVUTWFw?=
 =?utf-8?B?UnZjZVZjMUdldFBJQVhGYWlQSzUzak54c2RiT0JTVXBOeitSY0xoMTZkTFVV?=
 =?utf-8?B?Tm8rdlA5a2tBcm5aYm5ZN2F2d2FhTnFNcGNHR2REeXNHcXlzT3h3Zko5SnRo?=
 =?utf-8?B?QkkzY0NHeUxIa04wWU1xcDJXVUtKbGpVR054cStKVkd6V2VoazdHRHdDWGIz?=
 =?utf-8?B?b1NMYmRQdU5kRm9LMlJmbFllT24zT2lmS1A0WTZxRzNuK01uNkR5S2tKdVI2?=
 =?utf-8?B?UFlJbFFSOGJpdUJuRmRHM1M2TzhYVGUwaUptbkVlY05FNUFwcXMwcExEbTla?=
 =?utf-8?B?YTJQVitMR0dGV0xDQTVGV09qdDJxRFZjUHhER1hkdGdWVjc5S2pOZlJOY2h5?=
 =?utf-8?B?aG5Oa0FOcUFuSEtTYndlZFpPd0NjU01sZDI0cDFyVjBBMTRYZ3hidz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b84864-1a9b-493a-c6c3-08def95523f1
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 16:08:40.4490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EbntyziPCAGBCNukw/z0ZBa4Rx3OqFjfGCDBB/e1nvzLeV1v5/Q02Lm4YBtCS3z/tz92lZTwj8jKSp+ZXeijww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9411

On Thu Aug 13, 2026 at 4:24 PM BST, Danilo Krummrich wrote:
> The THIS_MODULE series [1] applied to rust-next moved ThisModule from
> lib.rs into a module.rs submodule, making the tuple struct field private
> outside the module. This breaks the module.0 field access in serdev in
> driver-core-next.
>=20
> Update the call to __serdev_device_driver_register() to use the public
> module.as_ptr() accessor to fix the build.
>=20
> Link: https://lore.kernel.org/all/20260811-fix-fops-owner-v10-0-7e71776f9=
dbe@linux.dev/ [1]
> Closes: https://lore.kernel.org/all/DKNAS52KYWLD.M15VEC6U0F6R@kernel.org/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  rust/kernel/serdev.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

