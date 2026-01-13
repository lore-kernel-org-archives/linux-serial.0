Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8909172610;
	Tue, 13 Jan 2026 22:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768342628; cv=none; b=nPUFzjv75xSb7Sy7cmLe8gaouS/L6guAOESNZMP7Ir3I5T1ptNscgIvyRmO3Jolrmi6m5C3qWWB7o3i96VvpYhukdpObr3/vKq1WocjdiSReBQvYNi8skw23PpJYc23nL+Ibe3x1LftbQI2K7gB/e9POfcyphGQis0Y7OphWhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768342628; c=relaxed/simple;
	bh=+3ONtD2eR+s+kOgpmP2sSSr8GNW6z60TPEcWwd0I1sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xg+PO6E2DZ6PLgmJgdftgVEVygVedBgztEwvrkSnVjjo2LKi3Xr9sgxqgdqP0n2rT6kP5gRQAisFgxnwuR1YWVHO20K9eLRQCoPY8Jli8sznM5Dx/cDPmg3rznEAdOTieVPh6RJ+ciXu5KSRrcHSFE4VJxM8o/2Y+vQmTNjIQp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mK5+qEb1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mK5+qEb1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3894C116C6;
	Tue, 13 Jan 2026 22:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768342628;
	bh=+3ONtD2eR+s+kOgpmP2sSSr8GNW6z60TPEcWwd0I1sg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mK5+qEb1w6ITkZA4f1kCvraKXZ4nw6/IB986JiaILnjehCVdOQgO3D33B3BcTEwn3
	 drbxLmGvLIRDstNaX8/TmR5DkhdmsrMsy2qc1rFcSAWZL+kujYTRc7jMnJ6/nE4hhM
	 C/LbK7JiXKWskezaDTu9xGfYe4RPQi4U3ST6w8fif48X/lo1ARSCXhY4G+MCtcwakE
	 GOp8IkUPzi7CisiyFgEwzhZKwduYOkETw00qdIGlQdS7MbVJ9UxkzR3Aoi77MVqOT3
	 XxO4WiBClPfzdrfRw1oNNpU7vuA5uzrIsOfpiQGgVqHpXSxUXEn8diy6Vy+fPNTiNr
	 TZwHFeRQgHtVg==
Date: Tue, 13 Jan 2026 22:17:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Guodong Xu <guodong@riscstar.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
	Yangyu Chen <cyy@cyyself.name>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v4 00/11] riscv: spacemit: Add SpacemiT K3 SoC and K3
 Pico-ITX board
Message-ID: <20260113-swarm-mama-cbd7d0546578@spud>
References: <20260110-k3-basic-dt-v4-0-d492f3a30ffa@riscstar.com>
 <20260112-shrivel-sarcastic-36d9acd2d96a@spud>
 <20260113002123-GYA19926@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xUPru1lBOhmdPMEM"
Content-Disposition: inline
In-Reply-To: <20260113002123-GYA19926@gentoo.org>


--xUPru1lBOhmdPMEM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 08:21:23AM +0800, Yixun Lan wrote:
> Hi Conor,
>=20
> On 21:45 Mon 12 Jan     , Conor Dooley wrote:
> > On Sat, Jan 10, 2026 at 01:18:12PM +0800, Guodong Xu wrote:
> >=20
> > > Hi, Conor
> > >=20
> > > For the binding riscv/extensions.ymal, here's what changed in v3 (no
> > > change in v4):
> > >=20
> > >  1. Dropped the patch of adding "supm" into extensions.yaml. At the s=
ame
> > >     time, I will start another patchset which implements the strategy
> > >     outlined by Conor in Link [2] and by Samuel in Link [3].
> >=20
> > Okay, that seems reasonable to separate out.
> >=20
> > >=20
> > >  2. Dropped the dependency checks for "sha" on "h", "shcounterenw", a=
nd
> > >     6 others. "sha" implies these extensions, and it should be allowed
> > >     to be declared independently. Like "a" implies "zaamo" and "zalrs=
c".
> > >=20
> > >  3. Enchanced the dependency check of "ziccamoa" on "a". Specifically,
> > >      - added the dependency check of "ziccamoa" on "zaamo" or on "a".
> > >      - added the dependency check of "za64rs" on "zalrsc" or on "a".
> > >      - added the dependency check of "ziccrse" on "zalrsc" or "a".
> > >     The commit message of this patch is updated too, to better explai=
n the
> > >     relationship  between "ziccamoa", "za64rs", "ziccrse" and "a".
> > >=20
> > >  4. Enhanced checking dependency of "b" and "zba", "zbb", "zbs", maki=
ng the
> > >     dependency check in both directions, as discussed in [4]. Since "=
b"
> > >     was ratified much later than its component extensions (zba/zbb/zb=
s),
> > >     existing software and kernels expect these explicit strings. This
> > >     bidirectional check ensures cores declaring "b" remain compatible
> > >     with older software that only recognizes zba/zbb/zbs.
> >=20
> > This I asked about in the relevant patch, I would like to know what your
> > plan for adding the "b"s is.
> >=20
> ..
> > Spacemit folks, I assume you weren't planning on taking the
> > extensions.yaml stuff via your tree? If you weren't, I'll grab it once
> > the question about b is answered.
>=20
> sure, please take extension stuff which are patches 6-9, for 1-5, it's
> all about adding support for SpacemiT K3 SoC, to avoid petential conflict=
s,
> I wouldn't mind if you also taking them? then I can handle the rest 10,11=
 for DT

Stuff for spacemit is either for you or for the relevant subsystem
maintainers. You're probably safe enough taking the
timer/interrupt-controller stuff if the maintainers don't apply it in a
reasonable period, it's not abnormal for those in particular to go via
the platform maintainer in my experience. Just be clear that you have
done so. I'm only interested in taking 6-9.

--xUPru1lBOhmdPMEM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaWbEXAAKCRB4tDGHoIJi
0v1dAQCafQYTWiGoSJPD2C3gwhnu05KfEBJ3q6AZTkjohRvudAD/foVWQs+/lj8U
CTtVpHi8NR/uKI23LWrPTtpjaG0dSgo=
=4H5t
-----END PGP SIGNATURE-----

--xUPru1lBOhmdPMEM--
