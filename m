Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670643;
	b=BaawoRNmWiyKxE4B2zWPQIMG30NUPGu6lHUqZJ3APfGBkAugdZKQ8FPhnCpGENG4456j
	 EmErShtfjQYlSYKZykeXlChenc1cdhWenR9Clb9MvsW1bUolSyRxo9rUoOQ9tth+YSMMY
	 aUiB1J08GsnDoIUJU2bIorJHsMi+UMeP3LzrO+lXnnzsixpKCiRB2QejhXorNL8dWFg2J
	 2yKYYtQnlAN+wOUqMquIeypma8fEyMkS2oxXXogsMb7b3KL/NgonSKGlA3zxfXVHPv1Zp
	 RHTSwIU3i0zMf/SmccucT7ObH7DecrntgH2Bz/YQ6Unxd2jkhBFFYFwxJu9i+Lxt+ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670643;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fe4hVtcK6U9cbz/hAsDEMwN5DN6aA32Ok/TIGhJowts=;
	b=EYoGkFTJ8FnS1CMfmWpvJSzqfYhXZCR3NoYBSY1M3+ML1QrnTLixIDcT4ypyetA16H1l
	 w+UA9nu2qvh25gsz7PoGxPhSfk6+2PekLhsOtOXKiucxRAflxR0hVryEwgOaNNmJ5p+2H
	 Uz7kQoRw+j1r4ughk1i/eBKVc6SjiVZljeuCGY+lozUkjQcpzhLwgp/sFbsi3rmIKWl3P
	 rhIfQv3aqcFLHBtDh0cNKbmPe5XxRhmaA5Ts2W4SitG/Nm8sCqXoU4Z4ClKBKxkgULvkm
	 Zq1aaagocyQm6nsK2Rp3IWTqwy6/EXHdzAtKfplpO55fcCgE6t354S6jy3dSojZA8gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgLh926F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89155606A31B
	for <linux-serial@vger.kernel.org>; Thu, 22 Oct 2026 12:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgLh926F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF791F000C3;
	Thu, 22 Oct 2026 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670643;
	bh=Fe4hVtcK6U9cbz/hAsDEMwN5DN6aA32Ok/TIGhJowts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IgLh926FQm0BOBOF5VScwPNi1AYiuxsu4lTxqj6hNY9Vzv/o5fDpNufsKV+Wx9BMx
	 TtKoaeIuU7pq0pOmCgrUnGgdjKpsEwqrQKqULnCxvy51zLneq30SdQcWDaCGi3k3w7
	 NNPOQvOxx+J7v2y7JWAdX6GAL0tPiDt+8+NuUGWG/YjGLzVb7mCg7t4UmJJ+qlwyrA
	 9XxZfRIu3I4dhjlgLh7cyG3XHpXu1RXz1DLk7qv6SPbhON1tTWTiTPF6TTGrTi1b47
	 DX0FVtReUuw9irccrpYWeZ9qxCGQv5D3ldFE+kxUggzToHE8UbkdLk/2sXrgU7UvOJ
	 JTLTsI7TUfIDA==
Message-ID: <sashiko-outbox-181411@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] rust: serdev: Replace `active` mutex with
 receive pause
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-serial@vger.kernel.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261022-rust_serdev_probe_refactor-v5-3-a27d862a415a@posteo.de>
References: <20261022-rust_serdev_probe_refactor-v5-0-a27d862a415a@posteo.de>
 <20261022-rust_serdev_probe_refactor-v5-3-a27d862a415a@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 12:04:02 +0000
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] rust: serdev: mutable borrow of shared ref in remove_callback()
--

commit 7873e32e25475629867563ba84c28fd279d7f25d
Author: Markus Probst <markus.probst@posteo.de>

rust: serdev: Replace active mutex with receive pause

This commit replaces the active mutex in the Rust serdev abstraction with
serdev_device_pause_rx() and serdev_device_resume_rx() to fix race
conditions during probe failure and driver unbind.

> diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> index 17ca504b7f8d6..c16d6593a8d2d 100644
> --- a/rust/kernel/serdev.rs
> +++ b/rust/kernel/serdev.rs
[ ... ]
> @@ -231,6 +198,12 @@ extern "C" fn remove_callback(sdev: *mut bindings::s=
erdev_device) {
>          let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init=
_ref()) };
> =20
>          T::unbind(sdev, data_pinned);
> +
> +        // SAFETY: `sdev.as_raw()` is guaranteed to be a valid pointer t=
o `serdev_device`.
> +        unsafe { bindings::serdev_device_pause_rx(sdev.as_raw()) };
> +
> +        // SAFETY: We already established that `data` is guaranteed to b=
e initialized.
> +        unsafe { data.assume_init_drop() };
>      }

[Severity: Medium]
Does Adapter::remove_callback() in rust/kernel/serdev.rs fail to compile
when building this commit with CONFIG_RUST_SERIAL_DEV_BUS_ABSTRACTIONS=3Dy?

Earlier in Adapter::remove_callback(), data is bound as an immutable
shared reference of type &MaybeUninit<T::Data<'_>>:

    let data =3D unsafe { &*private_data.driver.get() };
    let data_pinned =3D unsafe { Pin::new_unchecked(data.assume_init_ref())=
 };

    T::unbind(sdev, data_pinned);

Because MaybeUninit::assume_init_drop(&mut self) requires a mutable
reference, calling data.assume_init_drop() fails with rustc error E0596
(cannot borrow *data as mutable, as it is behind a & reference).

Since receive_buf_callback() can still run concurrently during T::unbind()
and create a shared reference to *private_data.driver.get() before
serdev_device_pause_rx() is called, data cannot be changed to a mutable
reference at the start of remove_callback().

Although a later commit in this series ("rust: serdev: Simplify callbacks")
refactors PrivateData to store T::Data directly and removes the
assume_init_drop() call, should this commit dereference the UnsafeCell
pointer directly after serdev_device_pause_rx() establishes exclusive
access:

    unsafe { (*private_data.driver.get()).assume_init_drop() };

so that git bisection and standalone backporting remain unbroken?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-rust_serde=
v_probe_refactor-v5-0-a27d862a415a@posteo.de?part=3D3
