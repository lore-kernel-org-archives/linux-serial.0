Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C623DD852
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 11:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784286878; cv=none; b=iI4LHDBIWSKszv8K89+oKEOZcX00zOsDj/WGLMArRnP57hi+ceHbVXegS0Fo/g24roi0NHIwbWQZVZ4TDkLHMnBfGoZP0H+BJnGmyLd5jiUidDhLgiaTjHidvQvmSieOfCcEvOwK3pcbUVJWKdZiQFh/RvCWfHRI9w6U5dryfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784286878; c=relaxed/simple;
	bh=5EoX2qRLOhPwz+xiO+Xx4HWq3PlYEgHEN20wtnt2znI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BIBUAU4hBI604I+Va39Q+proDyeDn0+RWg1ulW+iba/YmXWNFPaoDeVY2gZ1zwY3t9XxB/UIBGYcI//0+JxFJJra+C3Xtg++iWLKCjX8s9xcbRj206x2AiVKrwlEsG1ANMoDusZxr86b7SU77OwmXSSK5apuak+0ubZHp4LJV4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=oOGdhIRY; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="oOGdhIRY"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 656BD240103
	for <linux-serial@vger.kernel.org>; Fri, 17 Jul 2026 13:14:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1784286866;
	bh=5EoX2qRLOhPwz+xiO+Xx4HWq3PlYEgHEN20wtnt2znI=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=oOGdhIRYIb3H+55vr9EEztrNOGQQoAN0hV1crCd0odZnjKWmk41BOvgzmOI9cYa1U
	 9kRvJcGrpKCBrdvyBYlFovIP3Ttrm8vIERO5GQXs2hYT3jIRNNsrQEoM6gxWZc/1yO
	 hOgs3VBDK1IoZaEzQ1fAVppYhBhyO5Aew9iHqUylrIUe06eNV000ERpOheBjmWB7sa
	 R4DqW9w9Jvx/MCN/GuN2Ep3hWANUqsiI8hx6qHhaFnqb6V1tk7f0Vsild5w80JSOtq
	 xhj9UXOS47HaFxbxj3BSflUcXtmop2Ze4/KQfJirSeOsTjEdc2+X2stnZ+mVGt5BrO
	 TL7AKJ4UJFesg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4h1nNt2M9pz6twB;
	Fri, 17 Jul 2026 13:14:22 +0200 (CEST)
Message-ID: <6aafea3fdb0847766787dbe5c7c7dbaad606d649.camel@posteo.de>
Subject: Re: [PATCH v14 0/3] rust: add basic serial device bus abstractions
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?ISO-8859-1?Q?Bj=F6rn?= Roy Baron	 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Andreas Hindborg	 <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross	 <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Kari Argillander	
 <kari.argillander@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Boqun Feng <boqun@kernel.org>,
 David Airlie <airlied@gmail.com>,  Simona Vetter <simona@ffwll.ch>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein	
 <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?ISO-8859-1?Q?=D6zkan?=	 <work@onurozkan.dev>,
 linux-serial@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, 	linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, 	dri-devel@lists.freedesktop.org
Date: Fri, 17 Jul 2026 11:14:25 +0000
In-Reply-To: <2026071747-android-overhead-c927@gregkh>
References: <20260715-rust_serdev-v14-0-b4ed5c93606f@posteo.de>
	 <2026071747-android-overhead-c927@gregkh>
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
 keydata=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
 jfGillcaQOqFZ3WwVqyzG1BUfTow==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-/wrSw0tCa4IHnTtGtE6C"
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-/wrSw0tCa4IHnTtGtE6C
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-07-17 at 12:55 +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 15, 2026 at 09:00:14PM +0000, Markus Probst wrote:
> > This patch series adds the serdev device bus rust abstraction into the
> > kernel.
> >=20
> > This abstraction will be used by a driver,
> > which targets the MCU devices in Synology devices.
> >=20
> > Kari Argillander also messaged me, stating that he wants to write a
> > watchdog driver with this abstraction (needing initial device data).
> >=20
> > This series depends on [1].
> >=20
> > [1] https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dak=
r@kernel.org/
> >=20
> > Signed-off-by: Markus Probst <markus.probst@posteo.de>
>=20
> Given there are no objections, I'll go queue this up now, thanks.
Thanks for merging, but I haven't seen the dependency

https://lore.kernel.org/rust-for-linux/20260530132736.3298549-1-dakr@kernel=
.org/

getting picked yet (its at least not in linux-next), so it might not
even compile. Not sure whats holding the patch back though.

Thanks
- Markus Probst


>=20
> greg k-h

--=-/wrSw0tCa4IHnTtGtE6C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmpaDogbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS5qQQAJtMpRGF8IHOVOvETzHs
x19H3q3MrvCtV+RY6GMeiByLOMjBn1V4TXN+xiq2nHNvKPNkCjpuQytfGkWOr0OB
GIrW/q4GofuedrrGE2wZnT0iK4mnUbU5pDtupTPVXjJ/jefZqkH3T60eefGya64q
UmcvNfPFLt7AVJ5Jv9r1tvOpD7Z7oqwca32tqGrYJNSDtP9EYTtf6axqilaSEo8I
uwjq9MFbvqeMY7vz7dYsuoKdzpY7pAhH24Nf5vtykSfqllJ84atRT+iNCk/ikaz9
u+ebPpzCDRu7Pgh8/tLq26XM4hYRyZ9L6kMrJnp8uYDxQjXb1IqUtz9lVTbxuAmo
v6SbfixfhaNlTar/yDo3v0iU1Of0WNHj7ka0X5eXoT2Q1GS4o5Axa4wofgL5Y8Fo
mbGLNj5ZuiqPbYZvnV3jiJQsctywcnHCXsr7Vggtp6YaGA8DpGxSfpOOpwpXcM+a
U0LObSWWzRYwV/w72Vc58rNvB9Fk0437WMQgIXPWCsArX9ScjQL2TSJJY+/Umd1+
f1LB3/WilFyi9N1WT0Ji9NAlcWN7lhZW0XdAgyrgZmAS6vKMSL9haLukYL0SjNdI
w6kgIjdoKCOOIapgTGQEWpTSj8q2kCh3HASW0JRo+jqgSOO76i4bUi/y5uOfwVqP
+n2ju8HhTIXLkw4BTAhcZ4Dz
=YH/g
-----END PGP SIGNATURE-----

--=-/wrSw0tCa4IHnTtGtE6C--
