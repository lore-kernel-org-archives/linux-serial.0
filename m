Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6037C109
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788615900; cv=none; b=nLbOfr950xHDUNlsG9Wpa/afEHkGZ0Ya/Vu0YElvluljK1VYViMZ7HDw6lPCVAiMHGZqxkDVwuWV+6FQooxsLVbpBV4HFZBZdVHqjgfphgwQjDO6enWAg5yZXFoj7n1fGdcX/mW7pUFVOTxUZGwwHOdYefVXGyt7fsm4vKsBCiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788615900; c=relaxed/simple;
	bh=+0N5e8YFspJnYgnh26Hi32f1PZNdG4+QAdOTh9pXv0Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=k1QeIUnbw+THIUvNwt9CqXj5fmMbemBc+VDEabHuEE33XZqb3WI9Ctp+JwKL+lj3pzefIBBu3ageOeRGBrK2/uPO2Cxl7ceoOEU8uZ3aSJ5PeKznyhvYC7f+2dLFDdQdJH/wSjJn58HZGuYlXzfW7Oqtbt/3ro3uxivivxtVzmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZpYYgVgO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZpYYgVgO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BDE1F00A3D;
	Sat,  5 Sep 2026 13:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788615898;
	bh=X6OumRkz1KaG6XxRqHGdUlxWxBVWoMfkEe6eRfrJwwM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZpYYgVgOzA4xUnh3uiT3tHEEyhF08ie1g9vlc6ZtNHLV0Fx53Y0SbcP6mQSXgXHpU
	 7n1TuijSTQ32pVe39aDu0qFcalG8ZgGl7uuFsD+MwcXULIDXIpz7Cz70LLhvyauvg1
	 FyATPO+M94sJluf+z0O3oQ26yzJOHHKJxqufRBOFZNHpI7QTuzHOhJ92wOGhLGpBC7
	 Z1iIKhbTUaaukaFdTkLv8fCbAlh6m6QhAkXMupPalT0MtFthutV3IywwYGtZxgVjci
	 CgLL3Wvx820O1ijWNg2DLXOYCpCRNklWwHy1kILqTkYyoQMaKGRj9cQ5G7wdXrCwAC
	 btJyRfdG/GH5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] rust: serdev: Fix race condition on driver
 unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
 <20260905-rust_serdev_fix-v2-1-35dfcd06ef2e@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:44:58 +0000
Message-Id: <20260905134458.85BDE1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The function `drvdata_drop` introduces a Use-After-Free window and=
 mutable aliasing vulnerability by dropping the driver data before clearing=
 `dev->driver_data`.
- [Low] The new helper function `drvdata_drop` is missing the `#[inline]` a=
ttribute.
--

commit 26ab6ef2b4c35bdc9d899d45004d0c1a7f3fca80
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Fix race condition on driver unbind

This commit attempts to fix a race condition where the driver data pointer =
is
NULL while the serdev device is still open. It does this by introducing a n=
ew
function drvdata_drop() that leaves the pointer valid until the memory drop
is complete.

Closes: https://lore.kernel.org/linux-serial/20260905000836.C8FC91F00A3D@sm=
tp.kernel.org/

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849e..3886cc713c28b 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs

[ ... ]

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

[Severity: Low]
This isn't a bug, but should this abstraction function be annotated with
`#[inline]`?

The Rust subsystem coding guidelines mandate that small functions forwarding
to C bindings or performing small abstraction tasks should use `#[inline]`.

> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        if ptr.is_null() {
> +            return;
> +        }
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

[Severity: High]
Does this create a Use-After-Free window?

By dropping the driver data before clearing `dev->driver_data`, the pointer
remains valid while and after the memory is freed.

If a concurrent context, such as a hardware interrupt triggering
receive_buf_callback() in rust/kernel/serdev.rs, runs at this exact
moment, it will borrow a dangling pointer:

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };
    ...
}

Could this lead to a memory corruption vulnerability during the unbind path?

> +    }
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-rust_serde=
v_fix-v2-0-35dfcd06ef2e@posteo.de?part=3D1
