Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF11EB1AA
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710906; cv=none; b=jKAxnkJnyQOpvy9jG/AuGG/tgVfYsmsEy6UlrfrIdyX112t9fHRDpDO/r58FMjhh4QSWLsvhPeWtdPvOSS8yvIDVXWP2yl6SIs10v5t6epIRoxTcq6pGfWqzmroRqQodenWlS21l3RDVlmd0XyfRL9X7nY3Y4AQY/7N33Uu4S2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710906; c=relaxed/simple;
	bh=pE/FIBa75Qv4ZJv7UHEs9Oz89TBSBwHzuTOxe1jMs7A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jm5/MgwVC3LWaJXAZ+83VS6S5SLhQ4mRGehzyued/2OmCycvPVFyQbhppVEImGvXmG+/dIts4d30vjgzMQryQ7KJbH/TRARe65+NhJaTY+wFgT0H57WXeTPgIaJWIqLfSRgSw6JLOorzput9pOdLAlZyoUkvJEfUje4a1tpwJ8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mECVkfYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mECVkfYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4ED1F00A3A;
	Sun,  6 Sep 2026 16:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710905;
	bh=ifYZw01fjIt/ZJ31UEWG/6aiohANseasZZ/FY/fxAdw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mECVkfYvgSv2ft1qMogLj+qioWQz1uL1V29QfYsiKRWeI49XvA6FeBIlkd4cCi/Fd
	 nv1qLHNSRATbMh7dr1pbCmJUCIcsmIsSOvzI193U6Z/5ckFtbnfMcXmpt5g4E7//X/
	 on21TJd/n7nZZkMJjROG15s6yDWogen0y1sS1PAzxbvP23eTzdCycnsfCOjsnevdIZ
	 HsbdKKMZDXcbet8h9nO21b50urqgpp4a2oePkrMKnUjTw26WUJ3CTn0yNXIiXljPTc
	 QiKOShVSTevdoWax0HbPAOc/+8/dD+PTwYQEZkJabLYuFL+u7ZknGfXlG4uMubotAg
	 KYv9LFVmVxCdQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] rust: Add `Device::drvdata_borrow_mut`
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-4-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
 <20260906-rust_serdev_probe_refactor-v1-4-69cdae0074ec@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:08:24 +0000
Message-Id: <20260906160824.CB4ED1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Incomplete safety contract for `drvdata_borrow` fails to forbid ov=
erlapping with `drvdata_borrow_mut`, leading to an API soundness hole.
- [Low] Missing `#[inline]` attribute on the abstraction function `drvdata_=
borrow_mut` which forwards to a C binding.
- [Low] Grammatical error in the documentation comment for `drvdata_borrow_=
mut`.

Pre-existing issues:
- [High] Potential NULL pointer dereference in `receive_buf_callback` due t=
o reliance on an optional C callback (`pause_rx`) to suppress data receptio=
n during probe.
--

commit 0556399b0fd78424186d5ad317732507484df8d2
Author: Markus Probst <markus.probst@posteo.de>

rust: Add Device::drvdata_borrow_mut

This patch adds Device::drvdata_borrow_mut to allow callers with exclusive
access to obtain a mutable reference to the driver's private data. This
functionality is intended for use in serdev to provide mutable references
in callbacks.

> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 2291d85b6849e..aa2d87c6f4d3e 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -258,6 +258,30 @@ pub unsafe fn drvdata_borrow<T>(&self) -> Pin<&T> {
>          //   in `into_foreign()`.
>          unsafe { Pin::<KBox<T>>::borrow(ptr.cast()) }
>      }

[Severity: High]
With the introduction of the mutable variant below, should drvdata_borrow
have an explicit safety contract requiring callers to ensure no overlapping
mutable references exist? Since drvdata_borrow_mut is being added, the
missing contract on drvdata_borrow could lead to aliasing mutable and
immutable references.

> +
> +    /// Borrow the driver's private data bound to this [Device] mutable.

[Severity: Low]
This isn't a bug, but there is a minor grammatical error. Should "mutable"
be "mutably" to properly modify the verb "Borrow"?

> +    ///
> +    /// # Safety
> +    ///
> +    /// - Must only be called after a preceding call to [Device::set_drv=
data] and before the
> +    ///   device is fully unbound.
> +    /// - The type T must match the type of the ForeignOwnable previousl=
y stored by
> +    ///   [Device::set_drvdata].
> +    /// - The caller must have exclusive access to T.
> +    #[expect(clippy::mut_from_ref)]
> +    pub unsafe fn drvdata_borrow_mut<T>(&self) -> Pin<&mut T> {

[Severity: Low]
Should this abstraction function include the #[inline] attribute? According
to the Rust subsystem guidelines, small functions in abstractions that forw=
ard
to C bindings should be annotated with #[inline].

> +        // SAFETY: By the type invariants, `self.as_raw()` is a valid po=
inter to a `struct device`.
> +        let ptr =3D unsafe { bindings::dev_get_drvdata(self.as_raw()) };
> +
> +        // SAFETY:
> +        // - By the safety requirements of this function, `ptr` comes fr=
om a previous call to
> +        //   `into_foreign()`.
> +        // - `dev_get_drvdata()` guarantees to return the same pointer g=
iven to `dev_set_drvdata()`
> +        //   in `into_foreign()`.
> +        // - By the safety requirements of this function, `borrow` and `=
borrow_mut` do not overlap
> +        //   on the same object.
> +        unsafe { Pin::<KBox<T>>::borrow_mut(ptr.cast()) }
> +    }

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in how
serdev handles data reception during probe, which might be relevant
since this patch is intended for serdev callbacks.

Can receive_buf_callback dereference a NULL pointer if a serdev controller=
=20
does not implement pause_rx?

In rust/kernel/serdev.rs:probe_callback(), the code opens the device and=20
relies on pause_rx to suppress data:

    unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
    to_result(unsafe { bindings::serdev_device_open(sdev.as_raw()) })?;

However, the C API treats pause_rx as optional and fails silently:

drivers/tty/serdev/core.c:serdev_device_pause_rx() {
    if (!ctrl || !ctrl->ops->pause_rx)
        return;
    ...
}

If a controller missing pause_rx is probed, serdev_device_open allows=20
data to be received. If data arrives asynchronously before probe_callback=20
finishes and calls set_drvdata, wouldn't receive_buf_callback unconditional=
ly=20
borrow a NULL pointer here:

    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-rust_serde=
v_probe_refactor-v1-0-69cdae0074ec@posteo.de?part=3D4
