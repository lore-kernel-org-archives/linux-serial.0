Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB71C862D
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 00:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788566918; cv=none; b=mv/xtVUPXwYi+SdUD6lNRikkNf2JeMSWuWb6bxG0nNdfnXkgye+lT6KLcj3odEee5Fx/t/LIIIJ+GryvOVuCr3dakPYB/AiD/xxk/p9Kg3a55a91Aj54mAXjTkrmdbJc2EicKtARBSsHV3+nBjeifK9jBnmqC/j+uPCSZVOgR/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788566918; c=relaxed/simple;
	bh=QVcI+pR5aKk2kuRbnXk9j2WoKGZNZKd2yB7Fhu2O6yM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SxYBCwQDLN7oB4QGdD+CMLX088EmBCMLcKn83eqp6uNotkK2CruX4U/vpSaOvBkwyyi3+jvxOUO80UgbakfTnfKamAIJd6iHXz1qns+p8coPWOigxHk6GTMgllWrDJPjL35nrV4CgzeSHg6KCLSlyY3AqgaHM1iW1FsVXhTqW60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbo5BOWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbo5BOWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FC91F00A3D;
	Sat,  5 Sep 2026 00:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788566917;
	bh=Aoj0yUPkRr7wo/xl79j7f/OCkgSnEzCCt6lc1/tmLOU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cbo5BOWCejA/b4OoYrV2CJH5jwiy/zrKyaOiuW4RwH4dpz12QallH3aKaTXtQY6mj
	 vM1JTn8R18PZPUsXBVXauRyj1JpOWSDcuzb8qL7FppLB/w14FJxlswwWE2RNCbZKgj
	 H2W60zgjIITFjoSLu2JIHdmgKMpXwrPbtSOmZBQEGcHVrKzNg7J37DTvzyXimF3nA6
	 pmZcH2CmtD3yP1Q5w1EBX/oNQK7xv2ys4dPs73XMBrK5cvjzD8KM3fb3y0z2TFgqEA
	 TekgYjazf3HVgX4k8nXcpd3XoZmAIiawOT/KDQtAPiyc6wohKS+NTyBDoLW/jdQmTw
	 wbrLK0PVd6urQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: serdev: Fix race condition on driver probe fail
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
References: <20260905-rust_serdev_fix-v1-1-2ea92b154a6b@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 05 Sep 2026 00:08:36 +0000
Message-Id: <20260905000836.C8FC91F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Race condition leading to a NULL pointer dereference in `receive_b=
uf_callback` during driver unbind.
--

commit 1461faee0dc0950772fd25346941aca4f350fe5f
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Fix race condition on driver probe fail

This commit fixes a race condition during driver probe failure where the
driver data pointer is set to NULL while the serdev device is still open.
It uses a ScopeGuard to ensure the device is closed before the pointer is
set to NULL on probe failure.

Link: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@smtp=
.kernel.org/

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..4f57f4c453292 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
> @@ -190,6 +190,16 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>              // SAFETY: We have exclusive access to `private_data.open`.
>              unsafe { *private_data.open.get() =3D true };
> =20
> +            let open_guard =3D ScopeGuard::new(|| {
> +                // SAFETY:
> +                // - `private_data.sdev.as_raw()` is guaranteed to be a =
pointer to a valid
> +                //   `struct serdev_device`.
> +                // - We just opened the device, thus it is guaranteed to=
 be open.
> +                unsafe { bindings::serdev_device_close(private_data.sdev=
.as_raw()) };
> +                // SAFETY: We have exclusive access to `private_data.ope=
n`.
> +                unsafe { *private_data.open.get() =3D false };
> +            });
> +
>              let data =3D T::probe(sdev, info);

[ ... ]

> @@ -203,10 +213,12 @@ extern "C" fn probe_callback(sdev: *mut bindings::s=
erdev_device) -> kernel::ffi:
> =20
>              drop(active);
> =20
> -            result.map(|()| {
> -                private_data.dismiss();
> -                0
> -            })
> +            result?;
> +
> +            open_guard.dismiss();
> +            private_data.dismiss();
> +
> +            Ok(0)
>          })
>      }

[Severity: High]
This is a pre-existing issue, but while reviewing this fix for the probe
path, I noticed a very similar race condition exists during driver unbind.
Could this sequence still lead to a NULL pointer dereference in
receive_buf_callback() on device hot-unplug or sysfs unbind?

When a driver is unbound, remove_callback() delegates to T::unbind() and
returns without explicitly closing the serdev device:

rust/kernel/serdev.rs:remove_callback() {
        ...
        T::unbind(sdev, data_pinned);
}

After remove_callback(), the driver core executes post_unbind_callback(),
which calls drvdata_obtain(). Does this set the drvdata pointer to NULL
while the serdev device is still open and able to receive data?

rust/kernel/driver.rs:post_unbind_callback() {
        ...
        drop(unsafe { dev.drvdata_obtain::<T::DriverData<'_>>() });
}

If data is received on the serial port in this window, before the device
is finally closed, receive_buf_callback() can execute asynchronously. Will
it fetch the NULL drvdata pointer and dereference it when attempting to
lock the active mutex?

rust/kernel/serdev.rs:receive_buf_callback() {
        ...
        let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Privat=
eData<'_, T>>() };
        let active =3D private_data.active.lock();
        ...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260905-rust_serde=
v_fix-v1-1-2ea92b154a6b@posteo.de?part=3D1
