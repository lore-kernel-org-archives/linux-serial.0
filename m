Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914743876C9
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788616660; cv=none; b=GkaQLYMIp0znujv2/0t++9pbRRKin/XKutPLDjwZoY3UcnQgxwDS8c3diLZXvlaGv2ghspZCt6AbNXZhX9HnPvGxFxkGTho3xn46XCHKVSB3csTjmtBVzadB6cRkW9jM28A7Axse7SBToFNqdi+Z4i6VpCOUoLE0edK3Ktj3Qpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788616660; c=relaxed/simple;
	bh=vXnU61UFpyt+DMM9G6XiZekl2auouMTqJgWDMTP697g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkHMqAc48eddciGHMNkZSPVPOCEVGJQ1bTpRwyd7A7MwQtq9u7IYD7+du0Y2P6WsNcMcpgPGD67Bg6b8Eg9ot+nwaTMzWaCbh+25wAw1l5buRKqdUZxNmeBCtBsZrgU/TZrwYNGlBcrfg16SB94SLj1h38M3jzsVasnq+7ZCT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=g8vjD7rq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="g8vjD7rq"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7BFAF240027
	for <linux-serial@vger.kernel.org>; Sat,  5 Sep 2026 15:57:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1788616655;
	bh=++lbWBbv/uaZwhIT+nh+7IAZo638rIqWLB59ftFSgf0=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=g8vjD7rq5/xiaEnzmlogu2jQxAj8G0r8g7wJxVXjOoegciHd4UCXznqxAFW9FxOR+
	 1A2Hf/tl5Go1pdrb7amOljiC5HtSnOcff9FhRi0Vt7a3NzQrTL2btSVHxJ26QYOEBx
	 RLZxphJVj9ew8UJ4sZ7Y3mgd9YdHopWiZ2CjZjv3n/5RlZp9Td568yW+CrEHR+NGUy
	 mbjVq7ohPw3Xwlv9NJv8Vl+voCkCRg9vr9n/l3fm8BCG7t5dc455vOGBF3NZT1IbiK
	 nJtxqufskdPaEviDw3NL8cV/8NxvMXXxKKco5zXxnVMMgwjfDmlfsAe1CKmDrWdN/m
	 B8jJ6tVGeiEFQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4hcZf708jkz9rxL;
	Sat,  5 Sep 2026 15:57:34 +0200 (CEST)
Message-ID: <f040f319f077f1fe21991c3546d76430c799034b.camel@posteo.de>
Subject: Re: [PATCH v2 2/2] rust: serdev: Fix race condition on driver probe
From: Markus Probst <markus.probst@posteo.de>
To: sashiko-reviews@lists.linux.dev
Cc: ojeda@kernel.org, linux-serial@vger.kernel.org
Date: Sat, 05 Sep 2026 13:57:35 +0000
In-Reply-To: <20260905134936.7C8FD1F00A3D@smtp.kernel.org>
References: <20260905-rust_serdev_fix-v2-0-35dfcd06ef2e@posteo.de>
	 <20260905-rust_serdev_fix-v2-2-35dfcd06ef2e@posteo.de>
	 <20260905134936.7C8FD1F00A3D@smtp.kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=mQINBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93
 qReNLkOWguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVA
 m76Ww+/pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt
 9k5JARhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbm
 fAjaoT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwT
 jRQxBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1
 J+FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN
 6OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
 8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJCX
 CeMe4BO4iaxUQARAQABtCdNYXJrdXMgUHJvYnN0IDxtYXJrdXMucHJvYnN0QHBvc3Rlby5kZT6JAl
 QEEwEIAD4CGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AWIQSCdBjE9KxY53IwxHM0dh/4561
 D0gUCaIZ9HQIZAQAKCRA0dh/4561D0pKmD/92zsCfbD+SrvBpNWtbit7J9wFBNr9qSFFm2n/65qen
 NNWKDrCzDsjRbALMHSO8nigMWzjofbVjj8Nf7SDcdapRjrMCnidS0DuW3pZBo6W0sZqV/fLx+AzgQ
 7PAr6jtBbUoKW/GCGHLLtb6Hv+zjL17KGVO0DdQeoHEXMa48mJh8rS7VlUzVtpbxsWbb1wRZJTD88
 ALDOLTWGqMbCTFDKFfGcqBLdUT13vx706Q29wrDiogmQhLGYKc6fQzpHhCLNhHTl8ZVLuKVY3wTT+
 f9TzW1BDzFTAe3ZXsKhrzF+ud7vr6ff9p1Zl+Nujz94EDYHi/5Yrtp//+N/ZjDGDmqZOEA86/Gybu
 6XE/v4S85ls0cAe37WTqsMCJjVRMP52r7Y1AuOONJDe3sIsDge++XFhwfGPbZwBnwd4gEVcdrKhnO
 ntuP9TvBMFWeTvtLqlWJUt7n8f/ELCcGoO5acai1iZ59GC81GLl2izObOLNjyv3G6hia/w50Mw9MU
 dAdZQ2MxM6k+x4L5XeysdcR/2AydVLtu2LGFOrKyEe0M9XmlE6OvziWXvVVwomvTN3LaNUmaINhr7
 pHTFwDiZCSWKnwnvD2+jA1trKq1xKUQY1uGW9XgSj98pKyixHWoeEpydr+alSTB43c3m0351/9rYT
 TTi4KSk73wtapPKtaoIR3rOFHLQXbWFya3VzLnByb2JzdEBwb3N0ZW8uZGWJAlEEEwEIADsWIQSCd
 BjE9KxY53IwxHM0dh/4561D0gUCaIO9eAIbAwULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgAAKCR
 A0dh/4561D0oHZEACEmk5Ng9+OXoVxJJ+c9slBI2lYxyBO84qkWjoJ/0GpwoHk1IpyL+i+kF1Bb7y
 Hx9Tiz8ENYX7xIPTZzS8hXs1ksuo76FQUyD6onA/69xZIrYZ0NSA5HUo62qzzMSZL7od5e12R6OPR
 lR0PIuc4ecOGCEq3BLRPfZSYrL54tiase8HubXsvb6EBQ8jPI8ZUlr96ZqFEwrQZF/3ihyV6LILLk
 geExgwlTzo5Wv3piOXPTITBuzuFhBJqEnT25q2j8OumGQ+ri8oVeAzx24g1kc11pwpR0sowfa5MvZ
 WrrBcaIL7uJfR/ig7FyGnTQ1nS3btf3p0v8A3fc4eUu/K2No3l2huJp3+LHhCmpmeykOhSB63Mj3s
 3Q87LD0HE0HBkTEMwp+sD97ZRpO67H5shzJRanUaDTb/mREfzpJmRT1uuec0X2zItL7a6itgMJvYI
 KG29aJLX3fTzzVzFGPgzVZYEdhu4y53p0qEGrrC1JtKR6DRPE1hb/OdWOkjmJ75+PPLD9U5IuRd6y
 sHJWsEBR1F0wkMPkEofWsvMYJzWXx/rvTWO8N4D6HigTgBXAXNgbc3IHpHlkvKoBJptv6DRVRtIrz
 0G0cfBY0Sm7he4N2IYDWWdGnPBZ3rlLSdj5EiBU2YWgIgtLrb8ZNJ3ZlhYluGnBJDGRqy2jC9s1jY
 66sLA9rQZMHhJTzMyIDwweGlvMzJAcG9zdGVvLmV1PokCbQQTAQgAVxYhBIJ0GMT0rFjncjDEczR2
 H/jnrUPSBQJpa71VGxSAAAAAAAQADm1hbnUyLDIuNSsxLjExLDIsMgIbAwULCQgHAgIiAgYVCgkIC
 wIEFgIDAQIeBwIXgAAKCRA0dh/4561D0gKJD/9uOQKYlsDoQX65Gd0LiMT0C+5vXgr3VI0PHDOwcv
 51fJ3A1vNyPZRFPGrz8+mDEXUQOF/INfnz5Tu1QHwf+iYcWcTGAN/FHgVR6ET6VBNU2hJaKhu+Ggo
 kjYyJTOvyX+3yNRUfSny0GjTjIPuPTErjqmHF+BtjXslpgwqnNMznf3lRIuUjRORupos6p3k1DndE
 5vzUTmXSvMyXyOD2KhBl/kL76k0bHYyAQytZPag12pltrtFbA/r2phDGN2si8PooDT99bSTJjaM45
 MTAAHbHKJfvgfK41bNFD5mMtpWpL195XRtS0Nrxdg3PaYBxN5gtTG0RyZfpYRlkdEhm+jj/8RxuSG
 i/qdhRdbiI7K2IELWeQVHSNDi9JabR/UzlR4NSnhfAjRIVlRM+eFbUl8XwxwVrAkojF5IraH2qRvg
 VCmuFsHUW07FUlrDrzpjXsD73cKppoFGDCdDR0BHJepXbFLS9+AqkT+guRJlnCTg2p+TQtnbwPgKp
 Vj98JixovCl99zRYTsL2bRNU5+q8iET65VMJ1ydyNanvLd5vI/NqDkXhlXLsGmdaDTtu4R21PkToX
 dQNGrZ91M9nlIBKw8Y7c7xZ4098qX2b8JX/CxD+gC1r4C8vuA3GkhFLx+KlkON7LyiJPkrePp6Qky
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-rH98I0mo4wPN1oB5PLYf"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-rH98I0mo4wPN1oB5PLYf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-09-05 at 13:49 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [Critical] Use-After-Free and Mutable Aliasing in `drvdata_drop` becaus=
e memory is freed before clearing the driver data pointer.
> - [High] `T::receive()` can run concurrently with `T::unbind()`, leading =
to a Use-After-Unbind race condition.
> - [High] Circular deadlock between `probe_callback` and `receive_buf_call=
back`.
> --
>=20
> commit 67f5ed19e07ddf9c3ef694dbb2c1e962df051525
> Author: Markus Probst <markus.probst@posteo.de>
>=20
> rust: serdev: Fix race condition on driver probe
>=20
> This commit fixes a race condition on driver probe failures by using
> drvdata_drop() instead of drvdata_obtain(), ensuring the serdev device
> is closed before the pointer to the driver data is set to null.
>=20
> Closes: https://lore.kernel.org/linux-serial/20260903222159.70A911F000E9@=
smtp.kernel.org/
>=20
> > diff --git a/rust/kernel/serdev.rs b/rust/kernel/serdev.rs
> > index 17ca504b7f8d6..a12b1dea12aa1 100644
> > --- a/rust/kernel/serdev.rs
> > +++ b/rust/kernel/serdev.rs
> > @@ -176,7 +176,7 @@ extern "C" fn probe_callback(sdev: *mut bindings::s=
erdev_device) -> kernel::ffi:
> >              let private_data =3D unsafe { sdev.as_ref().drvdata_borrow=
::<PrivateData<'_, T>>() };
> >              let private_data =3D ScopeGuard::new_with_data(private_dat=
a, |_| {
> >                  // SAFETY: We just set drvdata to `PrivateData<'_, T>`=
.
> > -                drop(unsafe { sdev.as_ref().drvdata_obtain::<PrivateDa=
ta<'_, T>>() });
> > +                unsafe { sdev.as_ref().drvdata_drop::<PrivateData<'_, =
T>>() };
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does calling drvdata_drop() here introd=
uce
> a use-after-free and mutable aliasing vulnerability?
>=20
> Since drvdata_drop() executes drop() on the driver's private data and
> deallocates the memory before calling dev_set_drvdata(..., null), the glo=
bal
> device pointer still references the freed memory.
>=20
> If receive_buf_callback() is invoked concurrently by incoming serial data=
:
>=20
> rust/kernel/serdev.rs:receive_buf_callback() {
>     ...
>     let private_data =3D unsafe { sdev.as_ref().drvdata_borrow::<PrivateD=
ata<'_, T>>() };
>     ...
> }
>=20
> It can fetch the still-non-null dangling pointer before it is cleared, an=
d
> block on the active mutex. Once drop() completes, receive_buf_callback()
> would wake up and operate on freed memory.
>=20
> >              });
> >              let mut active =3D private_data.active.lock();
False positive.

The PinnedDrop implementation closes the serdev device and therefore
synchronizes this callback before the data is freed.

>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but can holding this active mu=
tex
> across the T::probe() call result in a circular deadlock?
>=20
> In probe_callback(), the active mutex is locked before invoking T::probe(=
).
> If a driver writes a command to the device and synchronously waits for a
> response during probe, the incoming response would trigger
> receive_buf_callback():
>=20
> rust/kernel/serdev.rs:receive_buf_callback() {
>     ...
>     let active =3D private_data.active.lock();
>     ...
> }
>=20
> Since probe_callback() holds the lock and waits for the response, and
> receive_buf_callback() receives the response but blocks indefinitely wait=
ing
> for the lock, does this structurally guarantee a deadlock for synchronous
> probes?
False positive.

On failure, the drop order guarantees that the lock in probe will be
unlocked first. It is still possible for receive_buf_callback or
PinnedDrop to acquire the mutex then. In any case, there is no
deadlock.

>=20
> [ ... ]
>=20
> [Severity: High]
> This is a pre-existing issue, but can T::receive() run concurrently with
> T::unbind(), leading to a use-after-unbind race condition?
>=20
> During device removal, remove_callback() calls T::unbind():
>=20
> rust/kernel/serdev.rs:remove_callback() {
>     ...
>     T::unbind(sdev, data_pinned);
> }
>=20
> It does not lock the active mutex, set it to false, or close the serdev
> device prior to unbinding.
>=20
> Consequently, incoming serial data can trigger receive_buf_callback(), wh=
ich
> evaluates the active check as true (since active is not cleared during
> unbind):
>=20
> rust/kernel/serdev.rs:receive_buf_callback() {
>     ...
>     if !*active {
>         return length;
>     }
>     ...
>     T::receive(sdev, data_pinned, buf)
> }
>=20
> This forwards the data to T::receive(), which can execute concurrently wi=
th
> or after T::unbind(), accessing driver resources that are actively being
> destroyed.
It can for now, but this shouldn't be an issue (as the driver should be
aware of that). But this will change anyway through:
https://lore.kernel.org/linux-serial/fe6a21fa8604bb35e32971b80cd75efb8ee3d2=
02.camel@posteo.de/T/#t


--=-rH98I0mo4wPN1oB5PLYf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmqcH84bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSZGgP/0qRNsYq/cJDE6B63cAT
hDNqIJFmTFt8VmPCEAKLiZhFBe6tkb/yVUtPJU3lKSJz9Yti+EcB4EWcWs887Amx
dpA0MMcSOmbegVmsW35LwpRjO680E7AOP0BzDlS4fVX//KAHvMk/BQrNWIzyEInX
NGRkAi9t1hPcKjGihek2LeXWL2+HnhbaskufkDhbgJBWQdbdJ9aW3uS3o1u9WA3j
JY1oSSp+qdPK9stka2onUGP9mBBw1wO9O5IfDpbWDI4tZHPEdhRXexsmyW/sBTQX
9bWsrg5Rso76GKytmGsLFQ5v5VIYqXvRZ2p4/8zQbbkbVpM+8P08VDsCCgkOyC8/
SOzz6RLfeUaYBjTl1IgZEBisp5erG6iYKhaIQii0LFi9lb83VFYnOG4VI7Fp8f3L
Lbi4hOjQYzH3XFRso+gudlUPlFo7CvnVYNOY1mZTyUzq7nh2cAKM07Y5iO4Sshx/
QuQ1DpPu3ijLBICMRFShD2QqX04U/oWa0CuWgN2rWIjmLcJ++a/reHClFb4BN6ip
T8PCodmU3nohtFfizWnTgWs7kyVVDjRlrtkEkRICpSPzXnkGowLyBxrsXywaAc6c
s8CzQUXLuwnG668u+X2mGsqVMSpjKAT8mjiEyX6sRmiKMzEwEf4LP9A2GUG3qsxb
1svX/ThlUYjAJTEYkeadlbVq
=+lew
-----END PGP SIGNATURE-----

--=-rH98I0mo4wPN1oB5PLYf--
