Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.67.36.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606480;
	b=HIriwb99LoskMWPhi3WnB6d/PfBvUPb9o76jRF5TdsiD/PefqitOjsqB9g4AvJu7wss6
	 cCr3xsjZTviNF70c15gsAOrK50rx4PeKLgcDOAQgdJowfU0lzhlCy8wob5UuaGXW8GVgQ
	 TnkvariQE3OOlDCUm7KGknbQQhvTwIgbdADA+Cva7mtUp9hNdjgiWGO7WBU6nyMMs7UpB
	 0xhgkrRQEX0BO4SdIEPqiw7EzfCrFAI9ChFDpL4yRR11zmrlvyfvHPPx2L0arMK1cVXDk
	 t3EjfQf0FZFzTDP8Ssx3CdV1G2eUVo6R+BqOFg5UVPzlw3eFU5TyGHC9TfV6JjD3YAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606480;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP;
	bh=upISL5VcKfB0IUzXvKf/csjl1o76bI/wcMHoqPwE4qc=;
	b=huVxEpwJTwiPiB1h2pHDc3kWisbcTR9jTitRDqbYykKkzp69dGyCo83qBcuYsAcFmAqb
	 S5Q1XuRTWNmHO8ROBjzerj9ozJJtWLe9fvA5qu04uJ1QJKSm59hqL2ZxTR7JtyF4wd8Sg
	 by5Yw4iDUbWVi/tp9xQTAGjhP/XWmFM9wPnzdI1SmbM6HtpYLejT89lOHYU6dhDRTofjp
	 2FGrm7e/WOs6X4UEe1QVnrPnljQAW8CVekQPSVyXRMwT1Iovh1bxAzy5Sz9DT1PqGNSHV
	 PmoV/eMcT9mNHYF9pYpvA5nqus9sIq5YYP9gZ1YK8zUitOrc2G/d0e+n+N5TxSNWaPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=posteo.de;
	spf=pass smtp.mailfrom=posteo.de;
	dkim=pass header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=iEvwwhiR;
	arc=none smtp.remote-ip=185.67.36.66
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A43606A31B
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 18:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26A43606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=posteo.de header.i=@posteo.de header.a=rsa-sha256 header.s=1984.8680eb header.b=iEvwwhiR
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 44B87240101
	for <linux-serial@vger.kernel.org>; Wed, 21 Oct 2026 20:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de;
	s=1984.8680eb; t=1792606472;
	bh=upISL5VcKfB0IUzXvKf/csjl1o76bI/wcMHoqPwE4qc=;
	h=Message-ID:Subject:From:To:Cc:Date:Autocrypt:Content-Type:
	 MIME-Version:OpenPGP:From;
	b=iEvwwhiR8NWiTz36FlFoyhD1N1KnFCXenbI22g82uMPV4vZqV1dwqZGAbo6d6mpVv
	 F5Jmzc/qN31R4aWaCky4CCCsRgzSEuaVSmIg6Bk4nZLd0Zpnav/yfEKi4U+tXwkOd2
	 qy21swIgjhev2vWm09kk89sN3Mn/KWmKD8zPADHQrkMOS8HnDNMLPMuhVj5ywkPgzh
	 meJ17oohINw7mI2RjO8cDJeomVTPycOn+l5YFe6u3iCWXk42+wWNZhM/xwo3MrxHQB
	 1YNNuqu7+yWAYQ2NFbd4G+gElwdoeSLa2V+8FAiYn94xeaP1mGWInx7X73st2TlpL5
	 KKPfImpqGrRCA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4j8y9L3yQJz9rxQ;
	Wed, 21 Oct 2026 20:14:30 +0200 (CEST)
Message-ID: <90df4e3068d89c37b4c6813aacae02fcf9fc188a.camel@posteo.de>
Subject: Re: [PATCH v2 1/3] serdev: handle devices without an ACPI or device
 tree node
From: Markus Probst <markus.probst@posteo.de>
To: Hans de Goede <hansg@kernel.org>, ChunAn Wu <an.wu@canonical.com>, 
	linux-serial@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, 
	jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com,
 mpearson-lenovo@squebb.ca, 	derekjohn.clark@gmail.com
Date: Wed, 21 Oct 2026 18:14:31 +0000
In-Reply-To: <97dd05c2-0a6f-4856-a473-59183a5b3424@kernel.org>
References: <20261021092124.2306053-1-an.wu@canonical.com>
	 <250bded6-2a51-457d-9bf2-24c299dbd7a9@kernel.org>
	 <59137675cf11f7b034220c3b71c5ababab48f8d0.camel@posteo.de>
	 <97dd05c2-0a6f-4856-a473-59183a5b3424@kernel.org>
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
	protocol="application/pgp-signature"; boundary="=-7FxLjH+liG0hWwWorbVz"
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt


--=-7FxLjH+liG0hWwWorbVz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-10-21 at 20:07 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 21-Oct-26 17:08, Markus Probst wrote:
> > On Wed, 2026-10-21 at 16:32 +0200, Hans de Goede wrote:
> > > Hi,
> > >=20
> > > On 21-Oct-26 11:21, ChunAn Wu wrote:
> > > > Driver-created serdev clients may lack an ACPI companion or device =
tree
> > > > node.
> > > >=20
> > > > Add a creator-supplied name for these clients. Use it as a serial
> > > > modalias fallback and to match a serdev driver of the same name. Ke=
ep
> > > > returning -ENODEV for unnamed clients.
> > > >=20
> > > > Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> > >=20
> > > For v3 of this series please include a cover-letter and explain
> > > why this series is an improvement over the` existing situation.
> > >=20
> > > The dell-uart-backlight and lenovo-yoga-tab2-pro-1380-fastcharger
> > > drivers are both pretty special cases and here you are adding
> > > a chunk of code to the serdev-core for those special cases,
> > > so I wonder: why?
> > >=20
> > > The current manual attach approach taking in these 2 special
> > > drivers works fine.
> > >=20
> > > What does this new approach gain us ?
> >=20
> > That was my review comment [1] that resulted in this.
>=20
> Thanks, that is useful info and the kinda info I would
> expect in a cover-letter :)
> > From what I can tell from revision 1, ChunAn Wu is trying to fix that
> > accessing uevent and modalias of the device (via sysfs) results in a -
> > ENODEV error.
>=20
> I see. Makes me wonder though how that -ENODEV is a problem,
> it is weird. But is it a problem?
>=20
> The v1 patch writes the following about this:
>=20
> "This makes the modalias sysfs read fail and suppresses the device
> add uevent, even though the device is registered and bound to its driver.=
"
>=20
> Ok, but the backlight driver ultimately ends up adding a
> /sys/class/backlight device which I assume does get
> a uevent, or is the problem that one never getting a uevent
> because of its parent not getting one ?
>=20
> And the lenovo-yoga-tab2-pro-1380-fastcharger driver does all
> it needs to do fully in kernel and does not even export
> a userspace interface.
I am not sure which issue is solves precisely. Maybe udev doesn't like
it?

ChunAn Wu has to answer that.

Returning -ENODEV on an existing device there is likely not intended.


>=20
> > As mentioned in my review:
> >=20
> > - "/* TODO: platform modalias */"
> > - "/* TODO: platform matching */"
> > still exist in the serdev codebase (drivers/tty/serdev/core.c) and are
> > unresolved. Resolving those also fixes the issue mentioned above.
> > Therefore I think this would be a better approach.
>=20
> With that said given that there are TODO comments for this
> I guess addressing the TODO-s is ok.
> > A cover letter is ofc still needed.
>=20
> Ack.
>=20
> > > Also if you are going to do this may I suggest looking at doing
> > > some sort of of-compatible matching based on a compatible string
> > > inside a swnode ? I do not know what that would look like but
> > > that is something which seems like it might be generally useful
> > > also outside these 2 special cases.
> >=20
> > I haven't used them before, but I don't think of-compatible string
> > matching inside a swnode is done anywhere in the kernel (At least I
> > haven't found a case).
> >=20
> > They can be added supplementary if needed.
>=20
> The idea was to make this a generic match mechanism / helper
> function busses can call, like the current of and acpi
> match (and modalias) helpers. And then have matching by
> a compatible string instead of by name since matching by name
> only works if there is only 1 instance.
Please take a look at my previous review comment [1].

In this I suggested adding a `id_table` field to `serdev_driver`.
This allows to match multiple instances, including providing different
private datas.

software node is only relevant I think if you already use
`fwnode_property_read_string` inside a driver next to acpi and of, and
also want to handle devices without of or acpi.

Thanks
- Markus Probst

[1]
https://lore.kernel.org/linux-serial/0be5624e3778c3426f88daf2d67376435f4744=
97.camel@posteo.de/

>=20
> Anyways this is just an idea and somewhat out of scope for
> this patch-set.
>=20
> Regards,
>=20
> Hans
>=20

--=-7FxLjH+liG0hWwWorbVz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJPBAABCAA5FiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IFAmrZAQAbFIAAAAAABAAO
bWFudTIsMi41KzEuMTIsMiwyAAoJEDR2H/jnrUPS+fYP/RN5aeIpd2NqW43K/Kf4
aRfJXUBdyVuAvxHzouIeVju4RSZgDOHwbhUxaVIMxKFVfCz7g+GuhCWXXb/oQvZL
jNrR7hXw53CE5DnXBPHO8wtzqD9rGU+Nwy3fCacP8t0MKL2ajh99le4b8tmWHmyN
OoZyFQ19f4blE84fMZTZpOP/3NHZNqhsnVUIXvA48izhik6AV49cmiDjqWwanwcN
aJcbCdq1yCh8xyPhEevahSe8KFuMdHYrPRqfX7G4+W/rhy4sOAPXkcCTUb3dSWOb
kGgdpeTk7hL1cbfQ4XKHr4LSC62UTK/jt97PeMfKkFswjbb80scCaDAyocuz16Ao
0l4qpXLAc2hVnwgAjFIwHOSjqfnfPsw1j3hNkRhWzgqOy1bCsmQlCl4VyZN8kMaR
5CxcB5j//rmohc4FkWEVIoP7mD8eeDU0AFO5syrejfdhSV6NYFfYtuv2Jb70tyeM
sHmt/vRmSWNjq33OTyvGTM0buz64rC3W53S0nz4841GZF/Is00R2y8vgpxEmaVA/
q6LzZr2aDSpAooxFaYmeDF1N9OVKph7uAtIJdUMd2dGYK12Rhb6oUZfMs538se32
lp1s0BtO/4j3I/3ylJLaSNgBLLmqw7HTBdnCQ+pD4o0/+BKcxaG2LyQbiROFhqlj
sCxxVgpWyHUU3Id7q9Tssu63
=Ej9S
-----END PGP SIGNATURE-----

--=-7FxLjH+liG0hWwWorbVz--
