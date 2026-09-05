Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021128.outbound.protection.outlook.com [52.101.100.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66E92FC00D;
	Sat,  5 Sep 2026 14:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617789; cv=fail; b=YtsVvKDihd1oKDT594qQ9FLrQNRKAAA3wKddIMlvZVzIJ1bjH22YaP+zCvbaSmcza/LP0GI/0kNJHCuNCH77AxYxCXM4L/HyS5BlBIA6P3hh+96dln1+0Hjii4Bx/KjjCKhCMzFV9EhqEdIAVxN6Ly5yoZTZAw8fqH7sEEdfpXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617789; c=relaxed/simple;
	bh=cFcrbbkdfo+DenHpNTouBpuoiQBiJFe6/NO0nmP0M20=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=fCrE4OQDKeC7laW7jVxBOlDwaFCMExcn+G7D4siQKYyOnbGP2y9/fBwQXQBLdXjnYC7cIk+4MGeb8FzMu3hkYLzchFTboiQQbIIII3HOvlSqdTJnsWZFQu6dLT0tLGqcvZeeL/vCkDExMv+MjS/vB/SnSFrCnP9TG2BxAXcSu2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=BaKAd3sn; arc=fail smtp.client-ip=52.101.100.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="BaKAd3sn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rf4romSJj+R8yEur+2KRuxpV7pRjCzR/dWkJmaYioPmKF3nY1dgilfTc7NEy9j48xWmoMnxSNLa/jz+KcV32UsvMuaqOvLAkXAODMNaT3KM/JE0Bm0xzfITOFA19B8wjKwZ3RHlSWLnJ41hHh/Y4d/9zkpMaVkSuclG1AJqbDOuurVkF302Ze/CFKC9nKeyrz3QjDWdInkHyZR91W7qLkbTeuvK0SVobuxPiVQBTJ4vy2B5iSaekm7JgoG+MSQPzAiCvl80F8jglNsQ7Y/65LsQETn9TJLx1d+7T7G4J7DbSF6gN2BIrnQ50Dh/I9tgQ2RkXwOj6suRwIaJnXwP4EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARg6uw20G+l+jgEaebJwYFIa3m6zJzp1njGWEXgvAd0=;
 b=Z0jPtKIAt4RJki3y9g19hqxo8YsKaw5GvbmonSR7WGnsHi/BPgATD+MZTx54ViGr0zaMMApdEf/ytJQJBklO9gs1IdopMrjzaNj/LpoUMdam7+cjj6s8JRKGPd8nb7KY0y3SeL/NhEiDUfe6JM07OOjbajGw7JcnPNcM5dKJXu/zh92kX1x1sKZZraQYSBInOaiNcSYLPY0oFYD19tTcNvRtWb+NEKMWbhdgcOY1TdeBWlGWobuMN8I6eZ034bs8de6wA78/7551HIj1jrUl4LD5UL4UuiuYDsVUsj5RgP2qEwly+T5mk7vpq7BCC2F77CXjRk2xUfoNLt77yISuSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARg6uw20G+l+jgEaebJwYFIa3m6zJzp1njGWEXgvAd0=;
 b=BaKAd3snIhacOcZw7Khza0pSkWpRqxY+Gi8qY7T6mkuPOsxf5yvYoXpRpIKfPuQNE2ksDKfBIN/5V0LKtasiJjo30CAt5y/6/Fc7TAcNghhAgmZl/I60SWJW/I4HE1NRZ//jyJ5CCI7PhCuuye4vS+HPjXj/4CQrrjfmhu91Zl8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CWLP265MB7225.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.14; Sat, 5 Sep
 2026 14:16:23 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0382.014; Sat, 5 Sep 2026
 14:16:23 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 15:16:22 +0100
Message-Id: <DL7G35VOSQ6H.V15LOQS4I2RJ@garyguo.net>
Cc: <linux-serial@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>, "Sashiko
 Bot" <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: serdev: Fix race condition on driver
 unbind
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
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>
X-Mailer: aerc 0.22.0
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
 <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
In-Reply-To: <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
X-ClientProxiedBy: LO4P265CA0022.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::14) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CWLP265MB7225:EE_
X-MS-Office365-Filtering-Correlation-Id: 687b5026-cc4a-438b-d80e-08df0b5843b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|23010399003|366016|921020|4143699003|56012099006|6133799003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	lAGVchfUCfyE/czBxx3Bg0zsDtlw3T+07/p2U/O6IPRJoxv3xez6OepMqGKwfQrRoU0g1x1BfTfFmn4H94cR1ONsGGeR6Ap1Yb7cWZzR9wQMeE+qbmsyE/ZU1zhHZFjAvS79nfEfgh13FSrnXGfZ5q4fsqjtTnasmYZs5ARKgevjzKnEuzfLoZ3M6aozBLME21PsiLZZ0ykrLrm9Dn9nCrcQWMPkGB2h/bBzE/PHFQ47dJGraSclS0Ar/5SRfioeEsoxBFCmVOtZGlZpmBaEXhh1fsq/+FbXVKHeFtDtcQqHSzZceynbODJVxvF1YvpjkpakuTR+1Tjkdte71P3WOMCV8yTPoCpAEir16rdDx5evgLq8g1XtM148q3OhsFOEgjjchvGimNwIOlmcqMdXNGoeHNTvy1X2e6LvAh3WuaTyZQVzynChHOulbzyET0OUEXC7ZbJEsrB7IjUTQjKlFDo0NU1ax+GJ+Cd85yUULRMGbG/fMf87aZzbjtXtUeXCG28AC1iV9YoExIt6WYJ79WENGcSiIi9HbYbUZJDDZs66mL/a01b0C38vvvCqI3d6f8yD4APFt9cSU3YW5u6WCZGu95EOOy6MPhmFCJWBldIZ50gLvTnaEE01xsv63DhH1MmMETBWyxcyoQUBOS3T1OwF2fD7+whSTE+D0Tu9xjQHEMLLDFUEovi1srHikbZgFqiUDJles63NbJcwQtK+pg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(23010399003)(366016)(921020)(4143699003)(56012099006)(6133799003)(18002099003)(22082099003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVJXT0luWjNzSkk3QjRkMW1xWnZLYXlpVXkvNzBGekdiK3IwSU9ZZm1PUGUv?=
 =?utf-8?B?RWhLbWtSU2xmNXZ3bWRDK040WnVhUGdwblFrc3YyaEZCR0FKM1kvOERiWkRF?=
 =?utf-8?B?WU5tWGJrV3FKeW5wWU1nLzUvaHNsWm5OelFVWFBJY0xQZjVrWXFXeUMrU3cy?=
 =?utf-8?B?OUcyNGFhcjFBVFNxUDRzcWNiMUNwRVhuUDhsMnBZVW9HWVlJYWhlQVgrSXRC?=
 =?utf-8?B?NjUyaUIwZ3k3WTAxeDR0ZFR6ckZCMXpwR0MrOXV0QTJ1QlJvdENlaktqc3Jq?=
 =?utf-8?B?TjlaenpyRW85Mkhmek0xTmJxMWx5clI4ZlRabTZ6dDBEak9PaEVvUmZoRnBa?=
 =?utf-8?B?SU0ybkg5V01FaU96YnFqVHhiMk1uL2xTSHRqUHpsZkdIb2hvWDl2czdKNUxJ?=
 =?utf-8?B?eUZpK3hWTkxEMGpvWEdnTkdVSVVQRCt2bG9FcFlndWVpaW5neXpMTi9NVHpC?=
 =?utf-8?B?ZjI3OXRJZW9DWW90NnNMNERsd3JMc1VCT1ZXdFVwem13T2J3b0l5dnRYanhy?=
 =?utf-8?B?N2JmQ3pwbUFjNVU5YkVRRjV5YVdZR2h3ZDhOL3lJOXI4clJtSTJxZDdNUkNp?=
 =?utf-8?B?UWlFanVncTBSTHNzbC9hYnNNWkZ2TFk1amFSeFp4eUVBblJsTG5TYUE1Smx3?=
 =?utf-8?B?UnBCUUVub2daSDdNS0RJSG9xVTl6M24xcmZEQjFlU0NMaUF4VUJoNEh1b2dq?=
 =?utf-8?B?UEl0dndZQmkzR1FKc0pFeXl0RERWVnNDaG41NFpSa1BkL3hrUXdGVGtORXky?=
 =?utf-8?B?VFh4TDBnNlRPWnY3REsvVS8ya3Q1b01jczRoSEptQWQrNDlaTjFOSDArS2hF?=
 =?utf-8?B?YnN4N1hKQzZNdERJNXJNdkI1MTZ4aThUNTI2RFpoRmxYK1IzL2hiSmJVbXNB?=
 =?utf-8?B?cVJQR2ZnQWFOcWpsOEhudDk4d2VKMGx0cWRCd0p1ejJXWG40QW0vNWF1djFj?=
 =?utf-8?B?VWJ2RWlPQVNGQ0dFVUtHdWJFZ1U3RktGVFV3UURaK0ZzK0tIWjNzZTN0SlhU?=
 =?utf-8?B?a2tpNERoaFVuQ25OZ1RzY1pybTJ6R2t6aUIvVTJCeVV6OWFpRkVVWkxlenpa?=
 =?utf-8?B?S1dSQXQ4bTBLbmd2bjJzZHRnblRadVhZN29zUXdCdnVuQk9aNjV4U0VIK0pO?=
 =?utf-8?B?OTZYaTdmcytTQlc4bkpSQUhiVlducG5YUnVVQjAzUEhScHh2cmtQRWZ1d0Rh?=
 =?utf-8?B?MzNtRG42N2RFMHBzQjV2Q284TlJpRUVCK2NTVDkwZUdiRkNaZHpWUm1XdGRq?=
 =?utf-8?B?c1h0cG1KWjM1VDBjZGdCRHlNZ2xJZXFBYUM1ZVZBS2ZiVWJqTTZnS0tVazFC?=
 =?utf-8?B?OFU3SVk3RzYrczRRK0d4QWxvNXVUbU4zbkpQTGpheWRzeFpHZ3FSNEN2UW1V?=
 =?utf-8?B?YnJQMDdHRnZ5d3ZsaG11ejRxbyszTUszcDdPUUFnQjlINjZBR3dsSDFTc2lT?=
 =?utf-8?B?M1BoZEtycmNUL1B6bXRsenUya0RBYkQ0RzVFTzZ2TjlVUE12QU1kazkxZ0hN?=
 =?utf-8?B?M1Q0eDhmbG00NWU3U0ZIdEdVSWVta2ZZc2s2aWNpRmZPUmtHZDI1Nk9sY0Er?=
 =?utf-8?B?OUtldndkNHpqdW9qN3dnQzlRY3ltTk8zRFoyNmdLaFpFRGVXc1RGYUQ0bERJ?=
 =?utf-8?B?VklSN0tUWUdUOTlVMFdlOWlKazdWeWpJTVJzbXJUeDJGYllLYnk4U25jcHc0?=
 =?utf-8?B?bnFZQ2pVZ1VTT2ljUjd2WERlNERtUUZSYmM4MGFURjNTYVliMDZqd1czNHNs?=
 =?utf-8?B?bWREVFBxNzhPMXE2YlRzYkZqL1g2SnQ3THVqczRXNlU1OHQ1VmxFK2hCTjdZ?=
 =?utf-8?B?WjZsdXJBU0lCdENnMysyRkswM2NBSlNoNDVnNjZZaG1xQWxSdDY4bTQxa1gx?=
 =?utf-8?B?N3dYTFJpU0orcnhhU29iNnR5QTduV3ZBZ2p6cTU5TFBlMW1KWkFzR3NzdXdt?=
 =?utf-8?B?NWZER1lSdGJDYWYrSXZiQlhCK1VZRW9oNE5wbFI4NnArU2ZueG5vQUV6Tk5K?=
 =?utf-8?B?RnU0NWQ1QmtYcnRyT2o5VkNXbjZUSUROWk9obWdoOVFoTkZjWklyaXJQMVNr?=
 =?utf-8?B?US9VWDJzQzEweUhCdmtYWHdydGRZZXU0UTR2a2FVdUVqbXdHOVJRZ2xpemV2?=
 =?utf-8?B?K1prUkJOcTQvSDA5WkpscnlqZW9MeWlJYWsvL1NMTW5URG9aOXhzaENYd2c3?=
 =?utf-8?B?T3pucGo0UEJkenJzbnpLanE5RzlDTFhxbjV3ZTc0QkJKc0pGVThtaDhYT0hl?=
 =?utf-8?B?dEkvMExoVEQ1N3dQTytDOXlYTm1lMUpKU2F6Wm83dU9aQWhIek5paWVKcEtv?=
 =?utf-8?B?T2lKVHRicWNCbGs5VVcvZVNsSWdmdkNEQkNScnBkM3pUanJHUFQxZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b5026-cc4a-438b-d80e-08df0b5843b8
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 14:16:23.2266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exlspWRC/k77FlPYWvhDkgo5ZYQ1nRfAziFRKHHDTitXrcHMzqh9l1lYPtu85QHhyZBhBc6k5LQhffgJE8fkJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB7225

On Sat Sep 5, 2026 at 2:30 PM BST, Markus Probst wrote:
> On device unbind, the pointer to the driver data (`PrivateData`) will fir=
st
> be set to NULL by `drvdata_obtain` and only after that the serdev device
> will be closed by Drop. Thus there is a small window in which the serdev
> device is still open, but the pointer to the driver data is NULL. Therefo=
re
> it is possible that `receive_buf_callback` might try to access the `activ=
e`
> mutex on a null pointer.
>
> Add function `drvdata_drop` that leaves the pointer to the driver data
> valid until the Drop has completed. Use it in the post unbind callback.
>
> Fixes: 99f59aa82341 ("rust: add basic serial device bus abstractions")
> Reported-by: Sashiko Bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@=
smtp.kernel.org/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  rust/kernel/device.rs | 27 +++++++++++++++++++++++++++
>  rust/kernel/driver.rs |  2 +-
>  2 files changed, 28 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849..3886cc713c28 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -219,6 +219,7 @@ pub fn set_drvdata<T>(&self, data: impl PinInit<T, Er=
ror>) -> Result {
>      ///
>      /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
>      ///   [`Device::set_drvdata`].
> +    /// - Must only be called before the device is fully unbound.
>      pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Option<Pin<KBox<T>>=
> {
>          // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
>          let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> @@ -236,6 +237,32 @@ pub(crate) unsafe fn drvdata_obtain<T>(&self) -> Opt=
ion<Pin<KBox<T>>> {
>          //   in `into_foreign()`.
>          Some(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) })
>      }
> +
> +    /// Drop the private data stored in this [`Device`].
> +    ///
> +    /// The pointer to the private data remains valid until the drop is =
complete.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - The type `T` must match the type of the `ForeignOwnable` previ=
ously stored by
> +    ///   [`Device::set_drvdata`].
> +    pub(crate) unsafe fn drvdata_drop<T>(&self) {
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        if ptr.is_null() {
> +            return;
> +        }

How does this help the problem? While drop is running, other code should no=
t
attempt to obtain a reference to the data anymore. Otherwise this still hav=
e UB
potential by accessing fields that are just destroyed (not to mention that =
Rust
alias model also forbid it).

I think the existing actually catches it better, because *if* NULL pointer =
can
be observed by callbacks, a synchronization is missing in the subsystem. Th=
e bus
should first perform a synchronization to ensure callbacks are no longer fi=
red,
and then proceed to clean up resources.

Best,
Gary

> +
> +        // SAFETY:
> +        // - If `ptr` is not NULL, it comes from a previous call to `int=
o_foreign()`.
> +        // - `dev_get_drvdata()` guarantees to return the same pointer g=
iven to `dev_set_drvdata()`
> +        //   in `into_foreign()`.
> +        drop(unsafe { Pin::<KBox<T>>::from_foreign(ptr.cast()) });
> +
> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        unsafe { bindings::dev_set_drvdata(self.as_raw(), core::ptr::nul=
l_mut()) };
> +    }
>  }
> =20
>  impl<Ctx: InternalBoundContext> Device<Ctx> {
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index c9c74c4dde8f..83410141ef1c 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -204,7 +204,7 @@ extern "C" fn post_unbind_callback(dev: *mut bindings=
::device) {
>          //
>          // SAFETY: By the safety requirements of the `Driver` trait, `T:=
:DriverData` is the
>          // driver's bus device private data type.
> -        drop(unsafe { dev.drvdata_obtain::<T::DriverData<'_>>() });
> +        unsafe { dev.drvdata_drop::<T::DriverData<'_>>() };
>      }
> =20
>      /// Attach generic `struct device_driver` callbacks.


