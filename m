Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538451D52B
	for <linux-serial@vger.kernel.org>; Wed, 30 Sep 2026 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790790816; cv=none; b=gy2sWB9E+wBDNuv5uMcYNhfG/tLh5ByMEePyO8Y21uh7s7JzS4IDwMz0xd333R6w4eBvQDvZxcOEhy2lCUimRX2jDNT7ReWmkX9x7sTNV14NdVCziE0QpSe73SCRpobKGyNzxF5zy5zhjMoN/jHgP+iqcaRQR22JxhaUFybjCWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790790816; c=relaxed/simple;
	bh=YQ1aH1DkIqLGAB4NUfXhnWxFtPJR7SMsqgfNXZ9h0Hk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJBXRZKLcFcZYCcOSTp6w5nupNcBMOjGEqFAdD7YG3+NXYWqztK8HrqLQEspvG0KNzVWQj8TtAAmTNn7jInsxiQP0AnVWrcXollYK0mKOt1kUskL/llY101iObni6E3j2g2C+HYZ/Yw14lzLnb0mPIhBevHwhP3DRrK9lfmFuVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JikNDJof; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JikNDJof"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A3C1F000FF;
	Wed, 30 Sep 2026 17:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790790814;
	bh=HAmgVwKLF3/NjPEBRly7U29UP1vc5Zj/UkX2WeFfoxU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JikNDJofG2QKIypLo4ChTX+e0JPCL74B+228Cb3EgW4xEznCG8lNU0a4XvRYkkLrV
	 p2ggYDtfO592x90fy5L9YsEqBShBRu/XnxmzphyQl1QgztZFg1Apr93fM8rgoQn1I1
	 XCyzaR3AGxYcEVrc9pIVQzWi2Ty4pr8c86ZDSXWPAXh+qzECyUwZ29miYvRriW2q3R
	 ecE/l2F6V1F10zYrCUSoIm9AuVIYY4tCNKxEf8fdZ90vREavJJuBCT2ePCNTnGadXv
	 7EwHwrmGDByXez+ECpkNqaw+Xs0ehCgWi0u6D22aiTxDnBir1frliVqvjK7lPYsc8K
	 bIpTaQFHH/6GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260930-rust_serdev_probe_refactor-v3-4-d1b6e77135e0@posteo.de>
References: <20260930-rust_serdev_probe_refactor-v3-0-d1b6e77135e0@posteo.de>
 <20260930-rust_serdev_probe_refactor-v3-4-d1b6e77135e0@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 17:53:34 +0000
Message-Id: <20260930175334.A9A3C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] on OpenGuard::drop
--

commit bed85685e823335d80519c5fa72de2689c661486
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Simplify callbacks

This commit simplifies the serdev callbacks by initializing the driver's
private data directly on PrivateData. It also introduces the OpenGuard
struct to handle device resource cleanup.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index c16d6593a8d2d..3f9165e167764 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs

[ ... ]

> @@ -92,24 +88,36 @@ unsafe fn unregister(sdrv: &Opaque<Self::DriverType>)=
 {
>      }
>  }
> =20
> +struct OpenGuard<'bound> {
> +    sdev: &'bound Device<device::Bound>,
> +}
> +
> +impl Drop for OpenGuard<'_> {
> +    fn drop(&mut self) {

[Severity: Low]
Does this small abstraction method forwarding to a C binding need the
#[inline] annotation? The Rust subsystem guidelines recommend #[inline]
for small functions or functions forwarding to a C binding call in
abstractions to ensure compiler optimizations across crate boundaries.

> +        // SAFETY:
> +        // - `self.sdev.as_raw()` is guaranteed to be a pointer to a val=
id
> +        //   `struct serdev_device`.
> +        // - The existence of self proves that the device is open.
> +        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930-rust_serde=
v_probe_refactor-v3-0-d1b6e77135e0@posteo.de?part=3D4
