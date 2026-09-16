Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC974A4EE1
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 09:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551442; cv=none; b=K4B7Jo2h38R0pXJHEA3kjPuP2HpLQTdpFdQoly+Ao1OkOQOAEngPwWRGQK1x0GPJPrbFI9jV0RZCDgLniXnpvEzapoNc1FpUR0hZ+4RPkdE334UxO406lMgFSdhEXipoXdQe7Tnfqt+S0wQY7E1tb+LjU0AJGFIS6L3aex/llPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551442; c=relaxed/simple;
	bh=R5t7rLies3CtD5M2tioxAIzdci9sc0oex+9hRIBT6iw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9CEljwL8TI+POJQKJ3hQ/MztuYX+i8Disb+IgJayftNyLzFKlnrxuVF63XrVEqMJQ82Bbgk8Tum/qM/KUckS06aiXMm2zoc+YrJhWfrDyJBfVOU2Ga8jSRQbx9gnphbKr1wYXheXaBfyegW2XAG6t6M7xWs9Uj5ZO+j6sR/mAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ne1yxjVf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ne1yxjVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349FD1F000FF;
	Wed, 16 Sep 2026 09:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789551431;
	bh=7HcwGUVpe56WfAmumcvhJhD671b+axOKuodySQFHSoA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ne1yxjVfLPaw9tGUVnFGbl1V44gHrJ65/0uJoV4V20t8SwLOa+r8CSMYA7bYSRz0E
	 RstUQPQoedkulbt+r40DTpuy0JuFdE8mSrGACNA2rJh0c+o1zj5mzLpYOH0Fu1lJRw
	 JVdEDI7Y3Fkg1FE7lK0uPb3Lo3AxI+zqoRuXYWPoDcvkxLbjUacdvzQ6jzQo9AUjTW
	 dcStExoVvMYp4fic2TyfsPMK5vC6L6JGctPrLTisc7K9U6NbGgEx3dB2zLXmyNvNMZ
	 RpM7Tt9h9TnPhhczX1H6v8JqifT2lvOb3Vwnt1RKUcjZsJHAkC/zQY6uCvOtzxQEGw
	 euhYbTVhM+qsw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20260916092626.533461-1-mohamed.osama189110@gmail.com>
References: <20260916092626.533461-1-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:37:10 +0000
Message-Id: <20260916093711.349FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] rust: serdev: compilation error due to invalid dismiss() method syn=
tax
- [Low] rust: mem: missing #[inline] annotations on DropGuard methods
--

commit cb72c5069d5d615bc6c2f05a5b1ca631930446aa
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

Add a DropGuard type to the Rust kernel memory module for running
cleanup code when a scope is left. It replaces the current ScopeGuard
users in gen_disk, serdev, and sync::lock.

Link: https://github.com/Rust-for-Linux/linux/issues/1255

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index f2d4cdf87d00b..f2d1f9bc93379 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
[ ... ]
> +impl<T, F> Deref for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &T {
> +        &self.inner
> +    }
> +}

[Severity: Low]
Should this function be annotated with #[inline]? According to the Rust
subsystem coding guidelines, small functions in abstractions like the kernel
crate should use #[inline].

> +
> +impl<T, F> DerefMut for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn deref_mut(&mut self) -> &mut T {
> +        &mut self.inner
> +    }
> +}

[Severity: Low]
Does this function also need an #[inline] annotation?

> +
> +impl<T, F> Drop for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn drop(&mut self) {

[Severity: Low]
Could this drop() implementation also use #[inline] since it is a small
abstraction function?

[ ... ]
> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..a400d241c2ad6 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> @@ -174,7 +172,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::ser=
dev_device) -> kernel::ffi:
>              }))?;
>              // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
>              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::=
<PrivateData<'_, T>>() };
> -            let private_data =3D ScopeGuard::new_with_data(private_data,=
 |_| {
> +            let private_data =3D DropGuard::new(private_data, |_| {
>                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`.
>                  drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateData=
<'_, T>>() });
>              });

[Severity: Low]
Is there a missed migration point further down in this function that causes=
 a
compilation error?

In probe_callback(), the variable private_data is now a DropGuard, but later
in the function the code still does this:

            result.map(|()| {
                private_data.dismiss();
                0
            })

Since DropGuard::dismiss is implemented as an associated function rather th=
an
a method taking a self receiver, does the compiler attempt to resolve
dismiss() on the inner type (PrivateData) via Deref and fail to compile when
CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS is enabled?

Should that be updated to DropGuard::dismiss(private_data) to match the new
API?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916092626.5334=
61-1-mohamed.osama189110@gmail.com?part=3D1
