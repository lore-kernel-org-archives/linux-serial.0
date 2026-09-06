Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA1E3009CB
	for <linux-serial@vger.kernel.org>; Sun,  6 Sep 2026 16:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711241; cv=none; b=I+Okh+o6PKwReDKCrfQGEUXEYmW2KMZCYC50Tif/HaRicye9W95SWjKYK99gymxoK/PzRgDu9WGDAyJGYEQr2XTa0ECd2r8tNH0zE0Z4zs+H8cMBTd/rN+rjdzPLXP3sfmkCkXeLu+YB6bu1O0lesKp+qEcVZX62dmmFDlVqhQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711241; c=relaxed/simple;
	bh=kz5bdFRD18D+ogvtqNSoXtuXdNvwrXWZJf9R5iNwUKw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CvVRLsAq8JiPVtIuoUte3dPIMLCoXOZ0yaGa45JLNJ76zNReOVpzAjU6pId6HzBj1448zO9PAUKq3mlUeVXECPmhH4G4EE2zQGqB/7Zi9qB89xHte4SyOoLa+RuVLeitBoMK3MjDL80VuMqCXyhQ9a2RJyP1heKaTxP1ftgZhkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOQHlHKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOQHlHKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713361F00A3A;
	Sun,  6 Sep 2026 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711239;
	bh=GulaQOvxIpSUIF8+wOp/oMEEZTr6rB2NEdT1pSUFieo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HOQHlHKS2emLM/nCP92K7x3TodQLGN804YB4a82p80GkZ5KmAYaoAuGwlx/xPTBIR
	 bNT96MZEZ0ONFV6mbNH8B+pteFwYfRdRZPH3OO8OljxcaCZnyeeksTm0mPk7JcVQwn
	 OyM9E7bwpuuDtWcr6fcFPjT7qjm7yaeAK2J1b/JykZBUjxYfz3ddzWdFesRrBSDNis
	 W/lfNZ7Q5+LUwf4W/cGIx3gOHD0SibklE/4WwTDPyx4HxTpUgDjoxRVKblIZ/NPLch
	 lUNz3tABkI95sMTmSOh9Yu3zSRYSHsE60f4RpsZ8E/dhabwzHyg4Hw/o4EyZ0AAnd2
	 UerUiiARxXv2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260906-rust_serdev_probe_refactor-v1-3-69cdae0074ec@posteo.de>
References: <20260906-rust_serdev_probe_refactor-v1-0-69cdae0074ec@posteo.de>
 <20260906-rust_serdev_probe_refactor-v1-3-69cdae0074ec@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 06 Sep 2026 16:13:58 +0000
Message-Id: <20260906161359.713361F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] TOCTOU race condition causing a NULL pointer dereference in `recei=
ve_buf_callback` during device probe.
- [Low] Missing `#[inline]` annotations on abstraction functions `PrivateDa=
ta::driver_data` and `OpenGuard::drop`.
--

commit 4244bd311fa3c091fa7a05ad05f18ce4e08829f6
Author: Markus Probst <markus.probst@posteo.de>
Subject: rust: serdev: Simplify callbacks

This commit simplifies serdev callbacks by initializing private data
directly on PrivateData. It also introduces OpenGuard for resource cleanup.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index c16d6593a8d2d..66543108ec2fa 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> @@ -92,24 +88,35 @@ unsafe fn unregister(sdrv: &Opaque<Self::DriverType>)=
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
> +        // SAFETY:
> +        // - `self.sdev.as_raw()` is guaranteed to be a pointer to a val=
id
> +        //   `struct serdev_device`.
> +        // - The existence of self proves that the device is open.
> +        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> +    }
> +}

[Severity: Low]
Does this drop implementation need an #[inline] annotation?

The Rust subsystem guidelines state that in abstractions like the kernel cr=
ate,
small functions or functions forwarding to a C binding call should be annot=
ated
with #[inline].

> +
>  #[doc(hidden)]
> -#[pin_data(PinnedDrop)]
> +#[pin_data]
>  pub struct PrivateData<'bound, T: Driver> {
> -    sdev: &'bound Device<device::Bound>,
>      #[pin]
> -    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
> -    open: UnsafeCell<bool>,
> +    driver: T::Data<'bound>,
> +    open: OpenGuard<'bound>,
>  }
> =20
> -#[pinned_drop]
> -impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> -    fn drop(self: Pin<&mut Self>) {
> -        // SAFETY: We have exclusive access to `self.open`.
> -        if unsafe { *self.open.get() } {
> -            // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointe=
r to a valid
> -            // `struct serdev_device`.
> -            unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> -        }
> +impl<'bound, T: Driver> PrivateData<'bound, T> {
> +    fn driver_data(self: Pin<&Self>) -> Pin<&T::Data<'bound>> {
> +        // SAFETY: We treat the result as pinned.
> +        let inner =3D unsafe { Pin::into_inner_unchecked(self) };
> +
> +        // SAFETY: `self.driver` is pinned.
> +        unsafe { Pin::new_unchecked(&inner.driver) }
>      }
>  }

[Severity: Low]
Does this helper function also need an #[inline] annotation?

Similar to OpenGuard::drop above, this appears to be a small projection
function in an abstraction crate, which the subsystem guidelines suggest
annotating with #[inline].

> @@ -134,46 +141,30 @@ extern "C" fn probe_callback(sdev: *mut bindings::s=
erdev_device) -> kernel::ffi:
> =20
>          from_result(|| {
>              sdev.as_ref().set_drvdata(try_pin_init!(PrivateData::<T> {
> -                sdev: &**sdev,
> -                driver: MaybeUninit::<T::Data<'_>>::zeroed().into(),
> -                open: false.into(),
> +                open: {
> +                    // SAFETY:
> +                    // - `sdev.as_raw()` is guaranteed to be a valid poi=
nter to
> +                    //   `serdev_device`.
> +                    // - It is safe to call before open.
> +                    unsafe { bindings::serdev_device_set_client_ops(sdev=
.as_raw(), Self::OPS) };
> +
> +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a val=
id pointer to
> +                    // `serdev_device`.
> +                    unsafe { bindings::serdev_device_pause_rx(sdev.as_ra=
w()) };
> +
> +                    // SAFETY: `sdev.as_raw()` is guaranteed to be a val=
id pointer to
> +                    // `serdev_device`.
> +                    to_result(unsafe { bindings::serdev_device_open(sdev=
.as_raw()) })?;
> +
> +                    OpenGuard { sdev }
> +                },
> +                driver <- T::probe(sdev, info),
>              }))?;

[Severity: High]
Could this sequence introduce a race condition that leads to a NULL pointer
dereference in receive_buf_callback() during device probe?

Because bindings::serdev_device_open() is called inside try_pin_init!(), the
device is exposed to hardware interrupts before the initialized struct is
passed to set_drvdata(). This means dev->driver_data remains NULL during th=
is
window.

While bindings::serdev_device_pause_rx() is called before open, and
bindings::serdev_device_resume_rx() is called after set_drvdata() below,
resume_rx() uses clear_bit(SERPORT_PAUSE_RX) which lacks a memory barrier.

On weakly-ordered CPU architectures, can the CPU reorder the store to
dev->driver_data to happen after the atomic clear?

If a concurrent RX worker thread observes SERPORT_PAUSE_RX =3D=3D 0 while
dev->driver_data is still NULL, it could trigger receive_buf_callback() and
crash when dereferencing the NULL pointer.

> -            // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> -            let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> -            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> -                // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
> -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
> -            });
> -            // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> -            unsafe { bindings::serdev_device_set_client_ops(sdev.as_raw(=
), Self::OPS) };
> =20
>              // SAFETY: `sdev.as_raw()` is guaranteed to be a valid point=
er to `serdev_device`.
> -            unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
> -
> -            // SAFETY: The serial device bus only ever calls the probe c=
allback with a valid pointer
> -            // to a `serdev_device`.
> -            to_result(unsafe { bindings::serdev_device_open(sdev.as_raw(=
)) })?;
> -
> -            // SAFETY: We have exclusive access to `private_data.open`.
> -            unsafe { *private_data.open.get() =3D true };
> -
> -            let data =3D T::probe(sdev, info);
> +            unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()) };
> =20
> -            // SAFETY: We have exclusive access to `private_data.driver`.
> -            let driver =3D unsafe { &mut *private_data.driver.get() };
> -            // SAFETY:
> -            // - `driver.as_mut_ptr()` is a valid pointer to uninitializ=
ed data.
> -            // - `private_data.driver` is pinned.
> -            let result =3D unsafe { pin_init::raw_try_init(driver.as_mut=
_ptr(), data) };
> -
> -            result.map(|()| {
> -                private_data.dismiss();
> -
> -                // SAFETY: `sdev.as_raw()` is guaranteed to be a valid p=
ointer to `serdev_device`.
> -                unsafe { bindings::serdev_device_resume_rx(sdev.as_raw()=
) };
> -
> -                0
> -            })
> +            Ok(0)
>          })
>      }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260906-rust_serde=
v_probe_refactor-v1-0-69cdae0074ec@posteo.de?part=3D3
