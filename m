Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A1B78C9C
	for <linux-serial@vger.kernel.org>; Thu,  3 Sep 2026 22:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474121; cv=none; b=Z9PKh1E5QXiN2ZnTrChrBcD6TU/82t7g2oCPlvhjxTuNR58u/mkb6QiaEVIoEZP6IZICiHFo0Y0BnVFd/onlcIwvT96loGDAcl/J678LcxxUj+SotMqmpAAV975CJGSjKHXucAouAw2w7ciXAiE0C2/dKvzwu0JNIBQqZeGNfdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474121; c=relaxed/simple;
	bh=JxtKHfyZ+/w9SMIovhjQueb1oOLc2hsom6P9NxMPuO8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kM16+G2w1jJ1y1FPojPlAjxDTl0uPvUUrer40l7PU1a1XFemR1zxM9P6Wt2II9CgQnkyylgwQZZwUNwsg/WBWptb9Ln84HHCoKkjihg831iOhkyyJCsYfur2Mr/8MhXdTFEY1k7OXCv71ga6Dnw2/5j9dHW2zVXnTMwgIVgqe8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jttSgpNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jttSgpNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A911F000E9;
	Thu,  3 Sep 2026 22:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474119;
	bh=Oed5N0DUk3PISwSGyffArZK6n8k2OHYwDAwnNUoszjQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jttSgpNRsQmArOi0UFIX2pzyZVCKZZfhz9LLiKirMS4Fkgz7LAoOLg1wIstWd6x7U
	 4NW4L6+pVxh44ZKNpIa+eRD9/09ffnFq+3p/SbUpOW7P80qkUbuZCcl+aKM2BsZ42y
	 J3CuHuLkG3nH4wpgdRfW/kmBPFCh7FR+ti0CPJ7nutluOtW2bpg+ZaHmncgp18dXyF
	 1CoxqgoIL640U8dUkfs0z622Zu191g6ZSdwO0DB3iWwikld6LCP98ZJsVxrWmV+pZZ
	 yQJMEU1UZ46N6YBAPt38eUAOui7T57/AWYhAGUODBROXQJvtTXl7aNxWtjEv4AR46l
	 6wVQKivJeGAmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: serdev: Synchronize receive callback before
 calling unbind
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
References: <20260904-rust_serdev_ref_mut-v1-1-245db7eb09af@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 22:21:58 +0000
Message-Id: <20260903222159.70A911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Holding the `active` mutex during `T::unbind` causes an inescapabl=
e deadlock for drivers that synchronously communicate with the device.
- [Low] Logically dead code inside the error-handling `ScopeGuard` in `prob=
e_callback`.

Pre-existing issues:
- [High] Race condition between drvdata_obtain and receive_buf_callback cau=
ses NULL pointer dereference or Use-After-Free.
--

commit 6f561db35778bb34c19e46b1a5df116263c0adbc
Author: Markus Probst <markus.probst@posteo.de>
Subject: rust: serdev: Synchronize receive callback before calling unbind

The commit changes the receive and unbind callbacks to provide exclusive
access to driver private data by handing out mutable references. It removes
the Sync requirement for Data and introduces locking for synchronization.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..44f029ed93fd1 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs

[ ... ]

> @@ -127,16 +127,6 @@ pub struct PrivateData<'bound, T: Driver> {
>  #[pinned_drop]
>  impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
>      fn drop(self: Pin<&mut Self>) {
> -        let mut active =3D self.active.lock();
> -        if *active {
> -            // SAFETY:
> -            // - We have exclusive access to `self.driver`.
> -            // - `self.driver` is guaranteed to be initialized.
> -            unsafe { (*self.driver.get()).assume_init_drop() };
> -            *active =3D false;
> -        }
> -        drop(active);
> -
>          // SAFETY: We have exclusive access to `self.open`.
>          if unsafe { *self.open.get() } {

[Severity: High]
This isn't a bug introduced by this patch, but does the timing of closing t=
he
device cause a use-after-free or NULL pointer dereference?

If probe fails after the device is opened, or when the driver is unbound,
drvdata_obtain() clears the underlying C driver_data pointer to NULL and
drops the data. However, bindings::serdev_device_close(self.sdev.as_raw())
is only called later inside PrivateData::drop().

Because the device is still open while the pointer is cleared, incoming
serial data can trigger receive_buf_callback() in the TTY workqueue.

receive_buf_callback() calls drvdata_borrow(), which reads the NULL pointer
and blindly dereferences it, or reads it right before it's cleared and
accesses freed memory.

Should the device be closed before clearing the drvdata pointer?

[ ... ]

> @@ -176,7 +166,20 @@ extern "C" fn probe_callback(sdev: *mut bindings::se=
rdev_device) -> kernel::ffi:
>              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
>              let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
>                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> +                let private_data =3D unsafe {
> +                    sdev.as_ref()
> +                        .drvdata_obtain::<PrivateData<'_, T>>()
> +                        .unwrap_unchecked()
> +                };
> +
> +                let mut active =3D private_data.active.lock();
> +                if *active {

[Severity: Low]
Is this block of code logically dead?

The ScopeGuard closure checks if *active is true to selectively call
assume_init_drop(). However, *active is only set to true if the driver
initialization succeeds.

Immediately after setting *active =3D true, private_data.dismiss() is calle=
d,
which consumes the guard and prevents this closure from running.

Therefore, this closure only runs on the error path, where *active is
strictly false, meaning the assume_init_drop() block will never execute.

> +                    // SAFETY:
> +                    // - We have exclusive access to `private_data.drive=
r`.
> +                    // - `private_data.driver` is guaranteed to be initi=
alized.
> +                    unsafe { (*private_data.driver.get()).assume_init_dr=
op() };
> +                    *active =3D false;
> +                }
>              });
>              let mut active =3D private_data.active.lock();

[ ... ]

> @@ -222,15 +225,21 @@ extern "C" fn remove_callback(sdev: *mut bindings::=
serdev_device) {
>          // and stored a `Pin<KBox<PrivateData<'_, T>>>`.
>          let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<Pri=
vateData<'_, T>>() };
> =20
> -        // SAFETY: No one has exclusive access to `private_data.driver`.
> -        let data =3D unsafe { &*private_data.driver.get() };
> +        let mut active =3D private_data.active.lock();
> +
> +        // SAFETY: We have exclusive access to `private_data.driver`.
> +        let data =3D unsafe { &mut *private_data.driver.get() };
>          // SAFETY:
>          // - `private_data.driver` is pinned.
>          // - `remove_callback` is only ever called after a successful ca=
ll to `probe_callback`,
>          //   hence it's guaranteed that `private_data.driver` was initia=
lized.
> -        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> +        let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_mut()) };
> =20
>          T::unbind(sdev, data_pinned);

[Severity: High]
Does holding the active mutex during T::unbind() cause a deadlock for
drivers that synchronously communicate with the device?

If the driver's unbind() callback sends a shutdown command to the device and
synchronously waits for an acknowledgment, the incoming serial data for the
acknowledgment will be routed to receive_buf_callback().

receive_buf_callback() attempts to acquire this same active mutex to process
the response, completing the deadlock because remove_callback() is blocked
waiting for the acknowledgment.

> +
> +        // SAFETY: We already established that `data` is guaranteed to b=
e initialized.
> +        unsafe { data.assume_init_drop() };
> +        *active =3D false;
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-rust_serde=
v_ref_mut-v1-1-245db7eb09af@posteo.de?part=3D1
