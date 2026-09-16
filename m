Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C65348477
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 01:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789521849; cv=none; b=dXva9shHW3yg3mP3JfZaZrHZveRYkefgFG1aclb/uxkt3jr65iSXEhstzWtraAs7zfwUaesqCcXdi7GLWAo2zMoNxcocABEC+IUU9NnITKBFzkFS+XELHkKmUqI/ygJX9Xqn/n2EjYfGGgMCRLCcfd1ErtMLBzv8GyTUKYFLJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789521849; c=relaxed/simple;
	bh=FSk3DNQ0BHryUkhlWF6T+3R6qsl/8itlRK8GuYjZX2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhVXrPavkxjFs0TJqr6+VoytRTfRHuAQAUojz6S029ES54u7hzMId77l7MjFVU/2SPgaaarNkhcEsK8F63Ah18gKrpWopi5xeQ+XaXYoICu177vHhR0Hrcv+PXoHOu8CqKnM4X8J4UVKCCn6Id7yI0ikdfarXEOl7aIub5fubMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SunUZiH2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SunUZiH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE0621F000FF;
	Wed, 16 Sep 2026 01:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789521848;
	bh=JAsa7Ymr26hffaVmNPmrV03QorvFtXNt8teUrCemVDI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SunUZiH2uo1Li7qKUeezUPjsjZodZwyISoDA5EdzqEDYJ64cLIMGUKEiuheFOtii1
	 7sHDC3TC2Fbx/jSbqukkEY7/6zXbi2JpIokqL+b8MoR80Nnf1OR4DNM1vMHG1YPZQH
	 26P81mPu3ns/JBbmW1lyLRzpnty7b3acjvkNl9tp8GGkgFnXPRHVlPz4jzMLEhs3Kz
	 qoC2w/TVllnQbPJ+zGhnlXkTnuBoXTvYNawFGTn5IJz6nrOd+4myBqqwnoewWOcQHf
	 e1Nl+nEeuhm7PMMN/M/8m30LpPS/he9MNZIajoLyZMg1Ahi2nFOm5fLCBp094rXd4A
	 u/ZlZjNM3kHZA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, linux-serial@vger.kernel.org, ojeda@kernel.org
In-Reply-To: <20260916011500.529743-1-mohamed.osama189110@gmail.com>
References: <20260916011500.529743-1-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 01:24:07 +0000
Message-Id: <20260916012407.AE0621F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Low] rust: missing #[inline] annotations on DropGuard methods
- [Low] serdev: compilation error due to method call syntax on associated f=
unction
- [Low] rust: non-compliant vertical import style in mem.rs
--

commit 3aca124644cba985e548a767bb3361277176f547
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

Add a DropGuard type to the Rust kernel memory module for running
cleanup code when a scope is left. It runs a FnOnce callback when dropped
and provides dismiss() to take the wrapped value without running the callba=
ck.
Users in gen_disk, serdev, and sync::lock are updated to use DropGuard.

Suggested-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/1255
Signed-off-by: Mohamed Osama <mohamed.osama189110@gmail.com>

> diff --git a/rust/kernel/mem.rs b/rust/kernel/mem.rs
> index f2d4cdf87d00b..e098675ea1957 100644
> --- a/rust/kernel/mem.rs
> +++ b/rust/kernel/mem.rs
> @@ -4,6 +4,88 @@
> =20
>  use crate::prelude::*;
> =20
> +use core::mem::ManuallyDrop;
> +use core::ops::{Deref, DerefMut};

[Severity: Low]
Does this deviate from the required vertical block formatting?

The newly added imports in rust/kernel/mem.rs are horizontal and
split across multiple statements. The Rust subsystem guidelines mandate that
commits touching imports should follow the vertical import style (e.g.,
grouping them vertically under a single use core::{...}; block).

> +
> +/// Wraps a value and runs a closure when dropped.
> +///
> +/// This is useful for running cleanup code when leaving a scope.
> +///
> +/// The [`DropGuard::dismiss`] function can be used to take ownership of=
 the wrapped
> +/// value without running the cleanup function.
> +#[doc(alias =3D "ScopeGuard")]
> +#[doc(alias =3D "defer")]
> +pub struct DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    inner: ManuallyDrop<T>,
> +    f: ManuallyDrop<F>,
> +}
> +
> +impl<T, F> DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    /// Creates a new `DropGuard`.
> +    #[must_use]
> +    pub fn new(inner: T, f: F) -> Self {

[Severity: Low]
Should small wrapper functions in abstractions like the kernel crate use
#[inline]?

The DropGuard::new() constructor lacks this annotation. Missing #[inline]
annotations can prevent the compiler from optimizing away wrapper overhead
when calling small wrapper methods.

> +        Self {
> +            inner: ManuallyDrop::new(inner),
> +            f: ManuallyDrop::new(f),
> +        }
> +    }
> +
> +    /// Consumes the `DropGuard`, returning the wrapped value without
> +    /// running the cleanup function.
> +    pub fn dismiss(guard: Self) -> T {

[Severity: Low]
Is this trivial state-transition function missing the #[inline] annotation
as well?

The DropGuard::dismiss() function in rust/kernel/mem.rs lacks #[inline],
which may prevent optimization.

> +        let mut guard =3D ManuallyDrop::new(guard);
> +
> +        // SAFETY: We have taken ownership of the guard and prevent its =
destructor from running.
> +        let value =3D unsafe { ManuallyDrop::take(&mut guard.inner) };
> +
> +        // SAFETY: We have taken ownership of the guard.
> +        unsafe { ManuallyDrop::drop(&mut guard.f) };
> +
> +        value
> +    }
> +}
> +
> +impl<T, F> Deref for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &T {

[Severity: Low]
Should #[inline] be added to this trivial trait method?

The DropGuard::deref() method is a thin wrapper and missing #[inline].

> +        &self.inner
> +    }
> +}
> +
> +impl<T, F> DerefMut for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn deref_mut(&mut self) -> &mut T {

[Severity: Low]
Should #[inline] be added to deref_mut() for the same reason?

The DropGuard::deref_mut() method in rust/kernel/mem.rs is missing
#[inline].

> +        &mut self.inner
> +    }
> +}
> +
> +impl<T, F> Drop for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn drop(&mut self) {

[Severity: Low]
Does this drop implementation acting as a thin wrapper also need #[inline]?

The DropGuard::drop() method lacks #[inline], which may prevent optimization
when dropping the guard.

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
Does this break the build when CONFIG_RUST_SERDEV is enabled?

The patch replaces ScopeGuard with DropGuard, but further down in
probe_callback() in rust/kernel/serdev.rs, there is an unmodified call to
private_data.dismiss():

rust/kernel/serdev.rs:probe_callback() {
...
            result.map(|()| {
                private_data.dismiss();
                0
            })
}

Since DropGuard::dismiss() is an associated function rather than a method
taking self, private_data.dismiss() is now invalid method call syntax and
fails to compile. Should this call be updated to
DropGuard::dismiss(private_data)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916011500.5297=
43-1-mohamed.osama189110@gmail.com?part=3D1
