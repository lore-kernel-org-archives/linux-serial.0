Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088F3815E8
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616178; cv=none; b=gLyw731JeqanhuV9e1u8Gf0VILQg+NAA8NbRJcESaDqIFwsbvtCWPGT2OQBwRbHzjnbrMohnHbjYEWymo8fMx7DsZ8i7J9bsBI57AxoGorTDMRQWjIIqz184sN2nymDBewlSe4JU0y5Srza1FKJfZv9fIajP+UZAucL/rZsr3nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616178; c=relaxed/simple;
	bh=6GvnAA7lvvhVs8i5y4NOZPBAotI1MB4x/mZZ1oxcGxs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fyx1y9mH1onpZ3UhjP3g86apPvjs+RDBpcfE+53fYZ2DpKUVONl0qisBvZ6vuw2Pl18BramUJR2REZ7HrwiEJ1Eox4FoW7t3wgnCyFUuUwRmAy4U8eiOUI9WUYIPMsl5wdwF92x2B/pHnIOp2d4+KepAdIuZvMIrz+4MufAtQvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBzgwZ1c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBzgwZ1c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8FD1F00A3D;
	Sat,  5 Sep 2026 13:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788616176;
	bh=Y2A8JhTz3A3QXrEvs//ei7pqIUTKB4MiM9QwE3+YZSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SBzgwZ1cmsmlVNqg4IJ2GHBTRGcy++KLRTbTEnQBEHtcN56ZzrjUPxaqXAVPgKYrL
	 SF7kWCc27NV66yBKbl6yfacN2hXNDzlMux0ohCt43xRz41G2WphFl7Cqv8IWP8W6TM
	 0J93Vpiv4FzdMZMQEx/VLLjWfcMEYamze26iAhxnLyHUWHmB8wCYbg+Un7P0gKciGM
	 +qMY4MksKa31KLD5T13x2zxaBOA7Yv8H1kPzlfqQv+JH4YrS5eM3cPz/ShokNyI2FO
	 KKqB2emuhq5ECS98Lu9G0QdThLmTFKdIUh9SVnmHDq6+rsBC+Lxl2+5Mh2NiECF7ka
	 hhPCn/hsLKItg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] rust: serdev: Fix race condition on driver probe
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260905-rust_serdev_fix-v2-2-35dfcd06ef2e@posteo.de>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
 <20260905-rust_serdev_fix-v2-2-35dfcd06ef2e@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 13:49:35 +0000
Message-Id: <20260905134936.7C8FD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free and Mutable Aliasing in `drvdata_drop` because =
memory is freed before clearing the driver data pointer.
- [High] `T::receive()` can run concurrently with `T::unbind()`, leading to=
 a Use-After-Unbind race condition.
- [High] Circular deadlock between `probe_callback` and `receive_buf_callba=
ck`.
--

commit 67f5ed19e07ddf9c3ef694dbb2c1e962df051525
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Fix race condition on driver probe

This commit fixes a race condition on driver probe failures by using
drvdata_drop() instead of drvdata_obtain(), ensuring the serdev device
is closed before the pointer to the driver data is set to null.

Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@sm=
tp.kernel.org/

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..a12b1dea12aa1 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -176,7 +176,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::ser=
dev_device) -> kernel::ffi:
>              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
>              let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
>                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +                unsafe { sdev.as_ref().drvdata_drop::<PrivateData<'_, T>=
>() };

[Severity: Critical]
This is a pre-existing issue, but does calling drvdata_drop() here introduce
a use-after-free and mutable aliasing vulnerability?

Since drvdata_drop() executes drop() on the driver's private data and
deallocates the memory before calling dev_set_drvdata(..., null), the global
device pointer still references the freed memory.

If receive_buf_callback() is invoked concurrently by incoming serial data:

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
    let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateDat=
a<'_, T>>() };
    ...
}

It can fetch the still-non-null dangling pointer before it is cleared, and
block on the active mutex. Once drop() completes, receive_buf_callback()
would wake up and operate on freed memory.

>              });
>              let mut active =3D private_data.active.lock();

[Severity: High]
This isn't a bug introduced by this patch, but can holding this active mutex
across the T::probe() call result in a circular deadlock?

In probe_callback(), the active mutex is locked before invoking T::probe().
If a driver writes a command to the device and synchronously waits for a
response during probe, the incoming response would trigger
receive_buf_callback():

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
    let active =3D private_data.active.lock();
    ...
}

Since probe_callback() holds the lock and waits for the response, and
receive_buf_callback() receives the response but blocks indefinitely waiting
for the lock, does this structurally guarantee a deadlock for synchronous
probes?

[ ... ]

[Severity: High]
This is a pre-existing issue, but can T::receive() run concurrently with
T::unbind(), leading to a use-after-unbind race condition?

During device removal, remove_callback() calls T::unbind():

rust/kernel/serdev.rs:remove_callback() {
    ...
    T::unbind(sdev, data_pinned);
}

It does not lock the active mutex, set it to false, or close the serdev
device prior to unbinding.

Consequently, incoming serial data can trigger receive_buf_callback(), which
evaluates the active check as true (since active is not cleared during
unbind):

rust/kernel/serdev.rs:receive_buf_callback() {
    ...
    if !*active {
        return length;
    }
    ...
    T::receive(sdev, data_pinned, buf)
}

This forwards the data to T::receive(), which can execute concurrently with
or after T::unbind(), accessing driver resources that are actively being
destroyed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-rust_serde=
v_fix-v2-0-35dfcd06ef2e@posteo.de?part=3D2
