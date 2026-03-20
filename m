Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8D369225
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 21:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774040906; cv=none; b=FC8Gox5tusdB17iSzrI1CNv+2ycwbgz+7CHnaeA11qOQVOQcUU1FHhT8nEWJBqy4VChYQ4E1G39/tnNN9OSI4u5wFIJPkysiCnYUVquLlYCgc/ooYL0Z80chAQ9OMM2Dysk8PZNFgZLpqHs3Ylyi6pefxEj/EZuLiaRAYdkXfwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774040906; c=relaxed/simple;
	bh=bOXHsWAp1TX0zN8K8H757WiBAvP7U7qBrrbxGi3Pp24=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=smgCaoGNjoR7bZpy4RKbUGuv0sMkAXig4QtBPQ3NsSboa8OMvA18285P8KVcXBw1PXFZPFOgggj783/UA7SRw3nWpHbvQUcM3JyWWuHMlLI5JJMTIh9A4qZ3WSn8eFg74q3pI02iFxaRor33tzc7zaGDh2Lso53eHtfOF9mFGnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=PX0Z1sp0; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="PX0Z1sp0"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 25BA4240029
	for <linux-serial@vger.kernel.org>; Fri, 20 Mar 2026 22:08:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1774040897; bh=bOXHsWAp1TX0zN8K8H757WiBAvP7U7qBrrbxGi3Pp24=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=PX0Z1sp0t6pX38KaTQ49UnsvJxfg0VQwnrCce046SBz06hkxbI9XvGx0TUKJnYwGC
	 6gAgjBy3IH310/CXMKV1Ps/yRHmr2MYEwBSwLQy5zdmrNt/5Z2ZJMeQz/VDYIs2Lzj
	 1h9vBzUu6qhZTXbg6CTZcLxTj2jMfT6aTVueBE17ESmZZYL7atxMHCN9Jxpdmt3D3+
	 cXq8MkMOYGKWR6kt45tg86fTr5P0StedTybxO0q/ce+tkK54+0mo2QJB6+iEuDeX7h
	 Qp0NGu4xujF8eTB0p4Bzr+J1B1/3TIroKuffPwTY/jdthOcCPbqdFDDjq7bSInSkZp
	 REi52bFkXkf8Q==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fcwC22z7dz9rxB;
	Fri, 20 Mar 2026 22:08:14 +0100 (CET)
Message-ID: <6d9004bbfcce5158fc502a560ff14a0ce15d9a63.camel@posteo.de>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
From: Markus Probst <markus.probst@posteo.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring	
 <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda	
 <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, =?ISO-8859-1?Q?Bj=F6rn?=
 Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg	 <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>, Kari Argillander
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-serial@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	dri-devel@lists.freedesktop.org
Date: Fri, 20 Mar 2026 21:08:16 +0000
In-Reply-To: <b8465b11-7a4a-4842-b292-6e3659bd95b3@kernel.org>
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
	 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
	 <2026031402-absence-graph-af5d@gregkh>
	 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
	 <2026031422-shaded-matchbook-5078@gregkh>
	 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
	 <2026031447-margarita-untamed-e976@gregkh>
	 <9e07a53053d1dd75a4ebe94aaa06e2279ef3701d.camel@posteo.de>
	 <2026032048-curtly-refold-e4df@gregkh>
	 <4f4c09d683023df9daef89ca634b17b5c16625f7.camel@posteo.de>
	 <b8465b11-7a4a-4842-b292-6e3659bd95b3@kernel.org>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-sp4lf+Wd/8VggGMFY3qC"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-sp4lf+Wd/8VggGMFY3qC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-03-20 at 20:59 +0100, Danilo Krummrich wrote:
> On 3/20/26 6:13 PM, Markus Probst wrote:
> > This is unique for a bus device.
> >=20
> > A class device has its own Data (e. g. PwmOps), i. e. it will only be
> > registered after this Data has been initialized by the driver.
> >=20
> > The receive_buf callback on the serdev device on the other hand must
> > happen on the drvdata, as there is no place to store its own Data.
> >=20
> > The drvdata is only available at the end of the probe in Rust.
>=20
> In other words, devm_serdev_device_open() relies on the driver having its
> private data set before this is called, since once devm_serdev_device_ope=
n() has
> been called, the driver's receive_buf() callback may be called.
>=20
> So, in C it is the driver's responsibility to do things in the correct or=
der, in
> Rust we want to make sure the driver can't do it out of order in the firs=
t place.
>=20
> I'm still not sure whether the current approach is the best option. For
> instance, we could also solve this with a separate callback.
>=20

> Wasn't this even
> what you had in a previous version?
Yes, but Kari pointed out that changing the ops while it is in use is
unsafe [1].

Thanks
- Markus Probst

[1]
https://lore.kernel.org/rust-for-linux/CAC=3DeVgR2WYdDTW3kOeemyQPP-H0aAUsrz=
n5Gk5zCe2hQEB709w@mail.gmail.com/

--=-sp4lf+Wd/8VggGMFY3qC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmm9tzsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyAAoJEDR2H/jnrUPSq2EQAKirZFnVWlQ38HRT0Hri
Co3bk89tdBXqZBKxN1NK9kUMFnOxDFAjA+PeK2YE+RzCPxFDvvASsLmp9ooZ7lJv
IVUdDTxJrQ+j74dMk7mkuC/m0O/ZXMaEf3RVRScQCgeogpRBUjK24nTVNz8cCNS+
485UOa9F5v3aIwkiWv7+XP2rF/8AH8NxaL5N1OngmxJ7K78GVgDvsXPM33u2DsBd
XWkDqW+dhJtSGRHueTbqV+BZX7wI0SIGPuSCI+9+l/lX7Pr3jhPrWk6G1B/QExY7
GO7+uu7WH+Gkjfhckhj0+4oXC3wpVB8fFIDCqJxtArbkXeKmS5oH9z7VijESjaQn
dVY+iX8wTODaP9x4nO9QaaqenYy7ofuJYEWRTbQRv06lUYlSKVWuwolr+/QXoCUl
cDvu9kVDOnY7Vh3GDWsYwDPgsSGr+VaBMJIV+URuwX49XPC9BO31gmt3WQFP2Hul
BHctukmiJLXPkXaNKlzl+SKD4GUyqJZcMBmOO7HZlaF+YXhP+18ENdX2wMm9l0Eu
o9N+NUir/FPsChx0ktWcnpl4OCrtHLQqlQ4JfxGLK9zoSK5inCx8KGWqQanFlziT
M15TwJ1gtH19R4kyeedwRTJORGHWIaeatWpBckpdXLfAyWVM+FtAEwnbKdNlxUbD
/vp/9ilH+WH0BoOCSaQjYp0g
=0B9T
-----END PGP SIGNATURE-----

--=-sp4lf+Wd/8VggGMFY3qC--
