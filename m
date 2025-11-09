Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EF11EA84;
	Sun,  9 Nov 2025 06:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762670064; cv=none; b=PVuobsClAcyii5EZTqLAwo22aZi/JIk583YMt3duKTv2KfCbfjt/9zqx0yEvEiAyKJarREdoOd86/kz7jIbg+yEnrvo6GKRquSAHq2rVgxgBZwxw6x09pq3cubSr71TtmRLbO3EY09C4sFZJafK3mPxWdKvyrdK9dO6ifDrO7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762670064; c=relaxed/simple;
	bh=PvLsezPb55Ku64wwVWq1Pwq9FCTfXjF/4zx64GEYf30=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V1gujD6Cvf37F/PfnhZYmasHeaB2NgOpvTUZ9KoErUcehTcK0DxxSb+NVdE8ayRZuzhk13ZaIObDdGlzeZWeDp/uHxooJ58Yg6AJaucPjGhfZkswch8v/j3FgavUIBp0dWmVb0kPlOZxGboHv6wp0yB5KlshOwYDa52/S261rq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=M6OAyfNy; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="M6OAyfNy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=202503; t=1762670056;
	bh=iTxpyLfLeTpVAiZsSYEVK0JzDkKFtKFM58lXr4a5DFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M6OAyfNyK0XtXvtDHZ0rH7o5FQ4blauGEklg4lMFPSNUynFbk2tVKt2EaGZ9uvvLi
	 kxq4VLPNtz3O66CH2LAX0QNv+BYtQJ08x+oBDf990NotO6J38s5Zoo/hiETeykuP6W
	 Q7TuYVT764ZhTyRKfhY73N4TqtiNYxLKS98/uwqL6gkG9ZMLfWP51V83K7f64NIzwZ
	 9gWK2lPB/a9BGMTrIPOeHhAHYVN8iIJJuYU1sTikL6LkqJC9cDIjjsiJnkVuF/eiSt
	 SQhJGB/c83b7FcgLyH9B0FCmE7ILM6Prs8suj05zjrCeNyHyF82QT0MEgadDEX3WFL
	 V60MFu5+lK2Jw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4d43133WDmz4wCy;
	Sun, 09 Nov 2025 17:34:15 +1100 (AEDT)
Date: Sun, 9 Nov 2025 17:34:13 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, Ilpo =?UTF-8?B?SsOkcnZpbmVu?=
 <ilpo.jarvinen@linux.intel.com>, Alex Davis <alex47794@gmail.com>, Stephen
 Rothwell <sfr@canb.auug.org.au>, Borislav Petkov <bp@alien8.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, John Ogness <john.ogness@linutronix.de>,
 linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <20251109173413.10c9aa0a@canb.auug.org.au>
In-Reply-To: <2025110956-swaddling-chapter-5932@gregkh>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
	<20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
	<aQzJveMYT6O3EHeK@smile.fi.intel.com>
	<20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
	<3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
	<ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
	<82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>
	<20251109105203.622ebe9e@pine.rothwell.emu.id.au>
	<2025110956-swaddling-chapter-5932@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ERe9ELmpjLeeLV7K/w=rF49";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ERe9ELmpjLeeLV7K/w=rF49
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Sun, 9 Nov 2025 09:49:29 +0900 Greg Kroah-Hartman <gregkh@linuxfoundatio=
n.org> wrote:
>
> On Sun, Nov 09, 2025 at 10:52:03AM +1100, Stephen Rothwell wrote:
> >=20
> > On Fri, 7 Nov 2025 07:20:26 +0100 Jiri Slaby <jirislaby@kernel.org> wro=
te: =20
> > >
> > > On 06. 11. 25, 19:00, Ilpo J=C3=A4rvinen wrote: =20
> > > > This seems to resolve the build issue for me:
> > > >=20
> > > > --
> > > > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@lin=
ux.intel.com>
> > > > Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop
> > > >=20
> > > > make allmodconfig build fails due to dependency loop:
> > > >=20
> > > >    depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> > > >    depmod: ERROR: Found 2 modules in dependency cycles!
> > > >=20
> > > > Break dependency loop by moving 8250_rsa.o into 8250_base and by
> > > > passing univ8250_port_base_ops to univ8250_rsa_support() that can m=
ake
> > > > a local copy of it.
> > > >=20
> > > > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > > Reported-by: Alex Davis <alex47794@gmail.com>
> > > > Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
> > > > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>  =
 =20
> > >=20
> > > LGTM, thanks for the fix.
> > >=20
> > > Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> > >=20
> > > If the reporters could give it a shot and mark this by Tested-by, it =
would be great... =20
> >=20
> > I have not seen this for quite some time ... I assumed it had been
> > fixed. =20
>=20
> I too thought this was fixed a while ago, what changed to cause this to
> happen now?  Anyone have a .config to reproduce this, 'allmodconfig' on
> x86 works for me.

Actually, I think the current report is for v6.17.1-rc1, so maybe
something got missed in a stable backport?  My original report was for
next-20250728 (July 28).  The only response I got was on October 1,
but I am pretty sure it was fixed well before then.

Also, you probably only get the error when you do a "make
modules_install" after the allmodconfig build (at least that is where I
got it).
--=20
Cheers,
Stephen Rothwell

--Sig_/ERe9ELmpjLeeLV7K/w=rF49
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkQNeUACgkQAVBC80lX
0GwmQAf/fM0Bs9Nfx/z6nbUfIRZh8/1JVIQNV2aTeD1nt7G9YH6EjT2jvAQJTEpe
B5WbwQG80WyO/PHh+7PjVfH8Y/xHJU0d0dbrtsMszYxTBQYuD9zLpxx09Iiz0MaT
bHlI1N0rJ893GJYEeuq5SzwibY8pUcxiCT4H5rsWRq7LNuHDwNzpiNBiHnFh48Ay
DoyenNiVlX3JkCFcc+Ah4ea5HRUPVyb06+3eoyXaME66pgpHhJ05TWXiUUi4QzDe
ubnkMJp8TyDqD1WIgksONjX3NG56UgxETgjjEkdMJeXwAtpEnXjm5NyHLIk+UmHJ
KC5P964Z6NAdSbrylNjVJ2nTTaipUw==
=TzBH
-----END PGP SIGNATURE-----

--Sig_/ERe9ELmpjLeeLV7K/w=rF49--
