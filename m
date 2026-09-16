Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6E4AE13F
	for <linux-serial@vger.kernel.org>; Wed, 16 Sep 2026 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789552783; cv=none; b=AFBIPBeKOC+tXh8tnktNVLwM9stouKpEMRQ4/4WtlmlB139IFo9x1P5PmrjBjERqF4AlyK0bvQJDRL9kJhNBpxocmgxc4gpEs/BZ8HF328g/W3Ho4Xfg7igm6otyUjtbIP/WSb7Sjy1AjsIYyUo4cKpPFYEwIVDM8pMm3tKiPQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789552783; c=relaxed/simple;
	bh=j6X7Bs17gaSaJFRUt7lHrhlHJhRLtxzOq5WqmLxICaU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tIvuOLf4cVhoQ/eezXrbtZHj12/OFZZQpImkt6rpmdTKwn19vBLHMpGqdqiR9AS3ePbtFWimD/GCE/zzLBLk4jckg15T6fOJHK3+PbCDTy9wi/HVqWswwqg6SyZVMNC3UGwEcwi6ehaypQxXzjwfETGrCEK58IMOAp7SdKW4cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuS0vWwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuS0vWwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 068BF1F000FF;
	Wed, 16 Sep 2026 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789552760;
	bh=MH0CiH64p/hE9/4OEAA57OyRC7Fh0M5TWjGkhaXqYQE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NuS0vWwvdE3JmiUEA8l22c7gQYBcENMV2z6ZQyk2ltCYDV/W5VBdmHvvKcy2kXKMN
	 nG2ATAEswqB1XpfX2gjrKohSBuwceoR5TyKTtibpOKfcrRtkeumJeV5EvsjSXjLWlO
	 4wFSMFB/LCv3B4RgXIePj3vVfrXJH14f4BpJm7k5W4FXAOgfr+42HbjAF933nid03I
	 WIaHNozVlAjCg/z/FZ8XP7BGoKxvKVgehnYxIMJ+UR1Pv4QoZABre3YoqfrNOjVP8c
	 ES0b/2i6EuQlLOrfGr6F3qqkZrVd+NE2zoTY8zUKSeE79Nw0J8WAsv258y75lGVekd
	 pGVtRyfJq8SVQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] rust: mem: add DropGuard
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mohamed Osama" <mohamed.osama189110@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, linux-serial@vger.kernel.org
In-Reply-To: <20260916094959.538394-1-mohamed.osama189110@gmail.com>
References: <20260916094959.538394-1-mohamed.osama189110@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 09:59:19 +0000
Message-Id: <20260916095920.068BF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] rust: serdev: compilation error due to invalid method call on DropG=
uard
- [Low] rust: mem: DropGuard abstraction traits missing #[inline]
--

commit e6da4b253a1c111afae2f6a79a8b6b1616c3e342
Author: Mohamed Osama <mohamed.osama189110@gmail.com>

rust: mem: add DropGuard

Add a `DropGuard` type to the Rust kernel memory module for running
cleanup code when a scope is left. `DropGuard` runs a `FnOnce` callback=20
when dropped and provides `dismiss()` to take the wrapped value without=20
running the callback.

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
       ^^^^^^^^

[Severity: Low]
Does this small abstraction method need an #[inline] annotation?

> +        &self.inner
> +    }
> +}
> +
> +impl<T, F> DerefMut for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn deref_mut(&mut self) -> &mut T {
       ^^^^^^^^^^^^

[Severity: Low]
Should this method also be annotated with #[inline]?

> +        &mut self.inner
> +    }
> +}
> +
> +impl<T, F> Drop for DropGuard<T, F>
> +where
> +    F: FnOnce(T),
> +{
> +    fn drop(&mut self) {
       ^^^^^^^

[Severity: Low]
Should we add #[inline] to this method as well?

> +        // SAFETY: `DropGuard` is in the process of being dropped.
> +        let inner =3D unsafe { ManuallyDrop::take(&mut self.inner) };
> +
> +        // SAFETY: `DropGuard` is in the process of being dropped.
> +        let f =3D unsafe { ManuallyDrop::take(&mut self.f) };
> +
> +        f(inner);
> +    }
> +}
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
Does this change cause a compilation failure further down in probe_callback=
()?

Because private_data is now a DropGuard, it no longer has a dismiss() method
that takes self. Later in the function we have:

    result.map(|()| {
        private_data.dismiss();
        0
    })

Could we change this to use the associated function syntax instead, like
DropGuard::dismiss(private_data)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916094959.5383=
94-1-mohamed.osama189110@gmail.com?part=3D1
