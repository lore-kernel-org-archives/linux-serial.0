Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C86A3AEB5C
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 18:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164005; cv=none; b=ti42hbjFtyChvz77PMxRBme/gLFP0lR8Har8ah7DT6Rw3o4s9QMbT14RS9n9Ag8kDHoHPUP1P2ok6vK/V3S/cl5ucZXPC422sQgE8dtSo6kPuZBaKCu17NOH5eV41u/QogzrTUXgxTVGkVUAiy71Hwqt4mW9POpaMaLspa2Rudg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164005; c=relaxed/simple;
	bh=ld6v9KtJzzWT1+D0eL6RHWGuC0WgYHy7UXBZlKa+iMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nohvHSNXegkFK2P4vwJt1Bq+3vjZ0yHR5bhdFC3qA5/OXhRAcnt1bywrbi3dpRhVQ/b1h+kIPPkenUhTPR+jxBShkVfAJoLy7vOGxS7TUGR/o71rSbKhZceNEyxnI5wOe+BCdzCFNLNRUSpTeyR8bhJoaZtDOddQB5ff8GSJeyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=XRZskBUd; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="XRZskBUd"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 97C99240105
	for <linux-serial@vger.kernel.org>; Sat, 30 May 2026 20:00:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1780164001; bh=aMme/b7aJrnbG+SKubX74OAuyLaZdkWD0dg31B6c8YA=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=XRZskBUdXcKsKI/jEoGaHkIm1o98nPlxTpdDwWMRknfw0EnRAOT2lyzeFBpTIewnX
	 cOcZl/3/Pqnh5j+rVljeQKCT5iQ4ClQIIMf8QEoHjbmUyfDQf0iJRqoOplTWIrc2L3
	 jDzUH/3ImDxNuIIoYwkFuyZUcjR1rMXx4clVWIXGTNPkNmNWpUbxYDoDSnevyIp4Wi
	 /VDPfTjz8xLSxo28JO2TxBPHLyP715XRIIMX1C11RvAeqq2ZLKX0aBBqIJPJjjlO3g
	 lJ2RGFrdc4KbX2vo/ETpojySGFj7MEgFQ7srh0SQ/xuMUGDMyzZRxPborY460yMv4k
	 EsnjwpwAZ+wGQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4gSSg30SNsz6trs;
	Sat, 30 May 2026 19:59:59 +0200 (CEST)
Message-ID: <fa841fad5493953f7932cde83d7a1b2e3356faa6.camel@posteo.de>
Subject: Re: [PATCH v9 1/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Rob Herring <robh@kernel.org>, Greg Kroah-Hartman	
 <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda	 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Kari Argillander	 <kari.argillander@gmail.com>, "Rafael
 J. Wysocki" <rafael@kernel.org>,  Viresh Kumar <viresh.kumar@linaro.org>,
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,  Simona
 Vetter <simona@ffwll.ch>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
	driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
Date: Sat, 30 May 2026 18:00:00 +0000
In-Reply-To: <20260530-rust_serdev-v9-1-f8b5fccb49c3@posteo.de>
References: <20260530-rust_serdev-v9-0-f8b5fccb49c3@posteo.de>
	 <20260530-rust_serdev-v9-1-f8b5fccb49c3@posteo.de>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-YD5z8kaBMv6Utdv9eVyT"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-YD5z8kaBMv6Utdv9eVyT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2026-05-30 at 17:36 +0000, Markus Probst wrote:
>=20
> +#[doc(hidden)]
> +#[pin_data(PinnedDrop)]
> +pub struct PrivateData<'bound, T: Driver> {
> +    sdev: &'bound Device<device::Bound>,
> +    #[pin]
> +    driver: UnsafeCell<MaybeUninit<T::Data<'bound>>>,
> +    #[pin]
> +    probe_complete: Completion,
> +    error: UnsafeCell<bool>,
> +}
> +
> +#[pinned_drop]
> +impl<T: Driver> PinnedDrop for PrivateData<'_, T> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // SAFETY: No one has exclusive access to `self.error`.
> +        if !unsafe { *self.error.get() } {
> +            // SAFETY:
> +            // - We have exclusive access to `self.driver`.
> +            // - `self.driver` is guaranteed to be initialized.
> +            unsafe { (*self.driver.get()).assume_init_drop() };
> +        }
> +
> +        // SAFETY: `self.sdev.as_raw()` is guaranteed to be a pointer to=
 a valid
> +        // `struct serdev_device`.
> +        unsafe { bindings::serdev_device_close(self.sdev.as_raw()) };
Ok, I might have sent this too early.

ignore for now. This is unsound.

Thanks
- Markus Probst

> +    }
> +}
> +

--=-YD5z8kaBMv6Utdv9eVyT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmobJZ4bFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPSf5sP/A6J/lvVI7uxowdg6WiV
tnnsrCN/G10ZUfcHUUrVWDNAmzYReB42SLmLYZsvo24QHdH4LIj5JSU1W72Fp+dY
UJSZYdw/GlJuskU2iizV6l1rm0g4HkBoUex9M7ELzDN9JPUiy50k9I6TVV7jW6zj
/575K4cq+JCmJ9OCG/Bmf6hP93SQUYgRQWOowXQMpk4G/IX4aL3ocU8WnstlbPAI
F58CDeXkxZyHmXYr265PSdZoWo8bdDdyZmWsMpg0nu+OECAr6bOKfPipE61ZkdCA
uYRvrc9aSJcLwEYDDp4evm2WyZnJ+X7VMYhpgkwlazGqormyHnValJo8yE+XGq4O
K3g4k/ip85KcaCCgX5qW8b8dzs3qD+bE+fHILPUl6BFjQwuifiX6T5rVQTVVhTZZ
GrNnXSgdUpMWBeN64LXerjuHxNhoQWPzhJwYoH1b1d/AsKqpoWG30sHhC9GKo8A4
T3A37gsx26XZY45pqMnGT/Z752oqYiEn3fMMPRPKND5GWZaJHP5fBvRx6sYsJ8Ly
x2ZkVCUqGz7CCDbN8jlnRjiDlmbFdSwy7wcjcvmXQMdzUb2pI0bDU5XXDwUNSlfY
Wr1WMfCSgO/Er+lBc3WeS+zFEh2pn4/qqrhnYWzPfCLMw7O6OVfhVoo5puEyBxZo
ekgS6qe0+XH3HWq2q99CV8tD
=CqxB
-----END PGP SIGNATURE-----

--=-YD5z8kaBMv6Utdv9eVyT--
