Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E21330EF92
	for <linux-serial@vger.kernel.org>; Sun, 20 Sep 2026 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789915484; cv=none; b=qpmbwlCN/fXUaYvK2h2yYgx3xzf4yIocyMDwh8RxPRBYQYFMSCu9OilpS2p2yy/4+l392aJ1VXsGFKeasaa4NeJHHtHUetvXt68JyFZcJUTUDV+dMT5yN/h8txlkhZE94w+Eb6wRNRh7+kQDK2mNc6kWK5HHU90XBpRc4wk/A6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789915484; c=relaxed/simple;
	bh=7rCc6kJdMXeuHgYZM/oFljAxwQYj17GI+W3Yyy1U+0g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rfQ6oNLMKJbp259pul5AEim65U33fb/ukuPcGtKXoINJUu1uxGCyDZmpINh9KnHPYHA3P1gjv/veF3BJd0q33Y1V+b7pUlqgI3jGBsWRUmiRRcIpaWJyKW+/grj4LU2KBqzenmxLIr7X6R4Sgevs9LrZbg+2TxTfc+olFHzg4ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZJXqRzSm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZJXqRzSm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A6A1F000FF;
	Sun, 20 Sep 2026 14:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789915482;
	bh=9XSHXWxz3YB9CMytJgt7jgn+BvV/Oxxp0i9/LSPVgqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZJXqRzSmZeGtGz9gveFFC+UdiJTKlntuw/qN9eRnsqwEMBcPRTpfqdhvFvQGG25GX
	 aUxIFYWOXROaCHlcR3Zp6fkeyxgm6GoI3y8tL5TlONxEUS5KuU3F7iq9yiG2p9AJfy
	 vnDPlDoZ0OOxGzy0JSpISm53e3wMvS9sjBPAyVTa/L7QMJBjlR72omi/+o9dBXLPes
	 /eJAcjSdvAXoHIrQHVTHC6Jx8MW3RPM1TwgZ3Hoqv9YrfWnPoq8AgKfvJ9RBKjMyWE
	 9tJSpSsI/gmhxGnGEneL0/OYfenBy9Of4GThw7O9HUPh/DZFn6nKdxIqm6uYIXloKt
	 KMfMJgQM2sDMQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] rust: serdev: Simplify callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260920-rust_serdev_probe_refactor-v2-3-43b855162f5d@posteo.de>
References: <20260920-rust_serdev_probe_refactor-v2-0-43b855162f5d@posteo.de>
 <20260920-rust_serdev_probe_refactor-v2-3-43b855162f5d@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 14:44:42 +0000
Message-Id: <20260920144442.83A6A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] serdev: compilation error in OpenGuard initialization due to typ=
e mismatch
- [Low] serdev: missing #[inline] attribute on OpenGuard::drop
--

commit 9ef182dba6207d4d0437751e74011a0c64fbd6e3
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Simplify callbacks

Initialize the driver's private data directly on PrivateData.

Introduce OpenGuard for resource cleanup.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index c16d6593a8d2d..3f9165e167764 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> +struct OpenGuard<'bound> {
> +    sdev: &'bound Device<device::Bound>,
> +}
> +
> +impl Drop for OpenGuard<'_> {
> +    fn drop(&mut self) {

[Severity: Low]
Does this function need an #[inline] attribute?

According to the kernel coding guidelines, small functions in abstractions
(like the kernel crate) that forward to a C binding should be annotated
with #[inline].

> +        // SAFETY:
> +        // - `self.sdev.as_raw()` is guaranteed to be a pointer to a val=
id
> +        //   `struct serdev_device`.
> +        // - The existence of self proves that the device is open.
> +        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
> +    }
> +}
[ ... ]
> @@ -134,46 +142,30 @@ extern "C" fn probe_callback(sdev: *mut bindings::s=
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

[Severity: Medium]
Will this compile successfully?

It looks like sdev is explicitly typed as &Device<device::CoreInternal<'_>>
in probe_callback, but the newly introduced OpenGuard struct expects
sdev: &'bound Device<device::Bound>.

Since Rust struct field initialization does not perform auto-deref coercion=
s,
OpenGuard { sdev } seems to cause a type mismatch compilation error.

Would it be necessary to explicitly dereference it, like
OpenGuard { sdev: &**sdev }?

> +                },
> +                driver <- T::probe(sdev, info),
>              }))?;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-rust_serde=
v_probe_refactor-v2-0-43b855162f5d@posteo.de?part=3D3
