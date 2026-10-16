Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956C48DB58
	for <linux-serial@vger.kernel.org>; Fri, 16 Oct 2026 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792174622; cv=none; b=PWxo1lBzeC2l3NIgrDLynjXoI/kaL5MTVEJjZLuxJqvCKmA61SgSkZlKlBfS8P8y8kdE5m3oTypJZnnofKQ/aPCDo2jzodlnrVaN6GS+GQto8FwnkVIb4vDGvaQztJKIcIniJML3bzHbzHG/uD/t+MRAKsqV1GjKWTJYgtbfNII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792174622; c=relaxed/simple;
	bh=bPb241viZ5sD++FC6TXKSe1W3sOOOQ6FC32q3tPD6UI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=a4xwU4seYoBwKGqQLnlF/GBllW99qezWKDAnX1QIO7CyDoKkmN9B/q5CawZjRgcKgsVK5ftv8aFEBnTE1XBli2dd2LlMYnRA0tDLp8jlhY/a40bHEjs4lZxnI16axELFaXKrrw7OAHWiauy7pEqglmxSaxZG2cyZMDobkYuhR6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcN9dcGI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcN9dcGI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5701F000C4;
	Fri, 16 Oct 2026 18:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792174621;
	bh=7bhIjrcZmtcmglZ8nTz/fem7JZzNpPoQbN6LgO66dTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OcN9dcGIlWFQhK1COo9wTbDYC8ZTRctFOc8Pd7PRfaV5MhRJgS7NIYM42WcaVuHmS
	 gsokUXvaivMdyV9Vyq2ffMCsdEjGWj1A97M4YVuPOoPxsT+G1GgMNKPhL3AjXjRmXA
	 t1Vf6wUFTjb6wREBeVLG+V+zqwAhwTZsIsl6nsOeXgCTsggC6vbsYgvLmYfU+Wjv9P
	 /1VBarWc5aPtW0Ox5JrNChBBdpd1PLiFQYDoWMfl3mLyIdZxDqwc6T/SrOsHWSMnth
	 FMbdaSvcDhqJjdFbwlg/4kdyQUG65O0/Qb5mn9ngTkd5pgjQC3FhwNyxR8JN0BEX7q
	 +Il62zp0wTN5Q==
Message-ID: <sashiko-outbox-174761@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261016-rust_serdev_probe_refactor-v4-4-46832e034757@posteo.de>
References: <20261016-rust_serdev_probe_refactor-v4-0-46832e034757@posteo.de>
 <20261016-rust_serdev_probe_refactor-v4-4-46832e034757@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 18:17:00 +0000
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] on OpenGuard::drop
--

commit 3744d6179fccd8a1197885b1019f91d6e5f289b7
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Simplify callbacks

This commit initializes the driver's private data directly on PrivateData
and introduces OpenGuard for resource cleanup.

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
This isn't a bug, but should the drop method on OpenGuard be annotated with
#[inline]?

The Rust subsystem guidelines recommend using #[inline] on small functions =
in
abstractions that forward directly to a C binding call, such as the call to
bindings::serdev_device_close() here.

> +        // SAFETY:
> +        // - `self.sdev.as_raw()` is guaranteed to be a pointer to a val=
id
> +        //   `struct serdev_device`.
> +        // - The existence of self proves that the device is open.
> +        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016-rust_serde=
v_probe_refactor-v4-0-46832e034757@posteo.de?part=3D4
