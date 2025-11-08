Received: from mail.rothwell.id.au (gimli.rothwell.id.au [103.230.158.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D978B17A318;
	Sat,  8 Nov 2025 23:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.230.158.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762646360; cv=none; b=W/Hh35jRzDnk7ke0Ntshktbi8yYdgsmDE73m3pwWugQkIdrzzkbzweUmFmDo1maQZc8C6UdPHAydGZXKiC927dp7uAOZ94GU6Ub/zBHlXQ7wnJo3YoCXV3EIGfWsuuyJFab5zspNj6GsSfMN9wy8LOFkmuV/vTrDrUEy13WFEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762646360; c=relaxed/simple;
	bh=+1E47EH8rxVpjX2CAdprYw4Di3IpDYFLIhdUC15ux/U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k9J9JP7UtGEojUzGjuIU5JmWhxDUwhUZONFQAD9mYBqF/5U5qXJ43dCG7ajZ6gAaBnhSUd6679WeB2mCL005pz9FwN92JJM6P6+eE5ILiAcY2XFFg4+bqiPW/rPon9XG3BA+rGMYCa9wihvOePbwnZLUOmH6idcfzOv4iN0JDH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rothwell.id.au; spf=pass smtp.mailfrom=rothwell.id.au; dkim=pass (2048-bit key) header.d=rothwell.id.au header.i=@rothwell.id.au header.b=jR5OBiKw; arc=none smtp.client-ip=103.230.158.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rothwell.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rothwell.id.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rothwell.id.au header.i=@rothwell.id.au header.b="jR5OBiKw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothwell.id.au;
	s=201702; t=1762645945;
	bh=cYUPLdCrS8zDAREt5PgYafk5U3i0ZvDcNTZmCFatbjg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jR5OBiKwdw/IbHkBfZpWmStbMsM44PaIYA7NTwxrHc4XV+Q/Nv22Epio+KpCrxHSv
	 HQJinF/C95WFQcjq3+20QXhBKEFhqa1dOmW2IU6e9+1lAlRekVnk3zpTkmN3ojpkn0
	 v9SPEvnd4ymzr23nJDqD4zM1H8AXMBDIxmg/2JMwUAtHBX/0Rj2Iq1XcKw4D9TSu9a
	 /jMC0S7G09dPZxlQb6CZCisZ2ld2uUDGvIsvr906bdk8iDyaI/Z5sevI313hunhWxY
	 sx1p06zwCkb8pG7H7EE46Yt2tnjyDCA+Ah5SmXp33f+SQnkyKMJxa1Hs8ul1mqJvYs
	 KntDwFZCmtcIQ==
Received: from authenticated.rothwell.id.au (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.rothwell.id.au (Postfix) with ESMTPSA id 4d3t5L0M52z15;
	Sun, 09 Nov 2025 10:52:21 +1100 (AEDT)
Date: Sun, 9 Nov 2025 10:52:03 +1100
From: Stephen Rothwell <sfr@rothwell.id.au>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Alex
 Davis <alex47794@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Borislav Petkov <bp@alien8.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, John Ogness <john.ogness@linutronix.de>,
 linux-serial <linux-serial@vger.kernel.org>
Subject: Re: [Regression] depmod fails on kernel 6.17.1 rc1
Message-ID: <20251109105203.622ebe9e@pine.rothwell.emu.id.au>
In-Reply-To: <82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>
References: <CADiockCvM6v+d+UoFZpJSMoLAdpy99_h-hJdzUsdfaWGn3W7-g@mail.gmail.com>
	<20251106160235.GBaQzGm8W2Gt_VMy-s@fat_crate.local>
	<aQzJveMYT6O3EHeK@smile.fi.intel.com>
	<20251106162436.GFaQzLxBW-_50ndwtr@fat_crate.local>
	<3fe70726-80d6-a84a-4101-446fd8b49209@linux.intel.com>
	<ddfbc4bf-658f-3eda-5b4f-f111ecd932f5@linux.intel.com>
	<82e2ce7f-bd08-4b53-b232-3dd8cb1a0726@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2YyYEpAAK1MtV.mE/IPn2AG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2YyYEpAAK1MtV.mE/IPn2AG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Fri, 7 Nov 2025 07:20:26 +0100 Jiri Slaby <jirislaby@kernel.org> wrote:
>
> On 06. 11. 25, 19:00, Ilpo J=C3=A4rvinen wrote:
> > This seems to resolve the build issue for me:
> >=20
> > --
> > From: =3D?UTF-8?q?Ilpo=3D20J=3DC3=3DA4rvinen?=3D <ilpo.jarvinen@linux.i=
ntel.com>
> > Subject: [PATCH 1/1] serial: 8250: Fix 8250_rsa symbol loop
> >=20
> > make allmodconfig build fails due to dependency loop:
> >=20
> >    depmod: ERROR: Cycle detected: 8250 -> 8250_base -> 8250
> >    depmod: ERROR: Found 2 modules in dependency cycles!
> >=20
> > Break dependency loop by moving 8250_rsa.o into 8250_base and by
> > passing univ8250_port_base_ops to univ8250_rsa_support() that can make
> > a local copy of it.
> >=20
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Reported-by: Alex Davis <alex47794@gmail.com>
> > Fixes: b20d6576cdb3 ("serial: 8250: export RSA functions")
> > Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> =20
>=20
> LGTM, thanks for the fix.
>=20
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
>=20
> If the reporters could give it a shot and mark this by Tested-by, it woul=
d be great...

I have not seen this for quite some time ... I assumed it had been
fixed.
--=20
Cheers,
Stephen Rothwell

--Sig_/2YyYEpAAK1MtV.mE/IPn2AG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmkP16MACgkQAVBC80lX
0GwO0Qf+Mxy5X+u1cMVpG5RotRjuCmMxt57/B9IU4VVYIxmE3FRSZdB74RpCZE49
5lUTfcNodPBYgmlufF5usix7tS3mTp8IjdYIfM/psbG04bGkV73TPaQHN2G9D5dT
IxlJHidUB54qweDYg9nN3DZK5JCbeNzE4Ur8+Q8Edu2bhne8iYBy090LjjLSnhbt
3KVMTE7k86zM6SN3TGozp45grezc0AOhD1/wLzC8kPb7xRyYYuQA2Z5+x47spttO
PEx+jSv2SOg7XHzfMUQHZKEF6OeqgSxYSAbz65ap8EWrjljoMEZR+OZHQNKQX9Ae
pYcBS67lRyJJoN44XXSqnLKjR3bBvA==
=jV7i
-----END PGP SIGNATURE-----

--Sig_/2YyYEpAAK1MtV.mE/IPn2AG--
