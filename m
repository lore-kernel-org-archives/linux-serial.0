Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C609A7262E;
	Tue, 30 Dec 2025 17:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767115360; cv=none; b=M853kBEpDgjb52cTiS1YvK9wbnbMfPywMh3y7C+sxzxIkBam3DsLVkLxDyyKczpYnSlEeMLdhk3jt+lmurkvMB+OKKcxK5JQ6BueKUC+HctQpaNE2MOYQoD0Qaoweus7RZMgBSxWsZxVCiJS+5M4QiiH2nP9lxfmVcRn5V8mYeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767115360; c=relaxed/simple;
	bh=Nq4eJiscCSUjJWXnlK8KVH+lfFVCQ3hTMfu5rY2MBRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCZhiBBxMvusVrIBiPyk7MJbHsFBvR1ZUyZq1cOQ3tFhs+Fgb/50cFAensWUlpcjPVoZJHXXzEPNxA/X8ogmI3qCgGkAHdE2KoDaOPAjWTQStgm7UkA5nvt5Xw0eelJYbCR7NFPFFBHFXleY1V+sA+T+oa92BigtLs5fvGFtwKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE3cbSfI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE3cbSfI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB942C4CEFB;
	Tue, 30 Dec 2025 17:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767115360;
	bh=Nq4eJiscCSUjJWXnlK8KVH+lfFVCQ3hTMfu5rY2MBRc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hE3cbSfI8mSOPtVbdyFudBIGR8EJtvSMWIxTZSpFUJVbgVToufldtftaPt7mTaFG+
	 20SPOxO/jHi94w4Zh3dju5YFCq6XTK+CH0cUv16D6W8QhNaPTJ6xqTgzIx9UXjjkQ/
	 NWRiMITIGr/JHCta/CP6IsiVx1k7MJe7V+R6hnJqSURx+3lsJQ5t38LzWdCApd2lI9
	 VYXcuc+x0EHPvGvsjK6HEfz8ZxpEUmcO0/g7qPVCE5UqS8DkhDMacDfNrvbpcLKJ72
	 ftl0XXH56DDMK6cNKlV1iPhmIRZADu6kv+xRoa897FehEvFwrQ7QOOoyXW7fB8Bjq2
	 LMHKwEzK1+Ybg==
Date: Tue, 30 Dec 2025 17:22:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Alex Elder <elder@riscstar.com>, Guodong Xu <guodong@riscstar.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Yixun Lan <dlan@gentoo.org>,
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
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension
 description
Message-ID: <20251230-outing-discourse-723547cc14da@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
 <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>
 <20251230021306.GA3094273-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6T7N+P1CP7qWF7aZ"
Content-Disposition: inline
In-Reply-To: <20251230021306.GA3094273-robh@kernel.org>


--6T7N+P1CP7qWF7aZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 08:13:06PM -0600, Rob Herring wrote:
> On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
> > On 12/22/25 7:04 AM, Guodong Xu wrote:
> > > Add description for the Supm extension. Supm indicates support for po=
inter
> > > masking in user mode. Supm is mandatory for RVA23S64.
> > >=20
> > > The Supm extension is ratified in commit d70011dde6c2 ("Update to rat=
ified
> > > state") of riscv-j-extension.
> > >=20
> > > Supm depends on either Smnpm or Ssnpm, so add a schema check to enfor=
ce
> > > this dependency.
> >=20
> > I have the same general question on this, about whether it's really
> > necessary for the DT binding to enforce these requirements.  The
> > RISC-V specifications are what truly defines their meaning, so I
> > don't really see why the DT framework should need to enforce them.
> > (That said, I'm sure there are other cases where DT enforces things
> > it shouldn't have to.)
>=20
> Does the specification have some way to check it? What happens if a DT=20
> is wrong? Are you going to require a DT update to make things right? Or=
=20
> the kernel has to work-around the error? Neither is great. So having=20
> this as a schema makes sense to prevent either scenario.

The reason this whole mess exists is because extensions got redefined
after the kernel port was merged and the bindings defined. This is
almost all a hedge against there being future redefinitions. For now,
and hopefully forever, this will just be a list of extensions with
citations to their relevant documentation so that we can say "this is
exactly what this means". The added bonus is avoiding messes like people
implementing development versions of specs and claiming support, because
that just becomes "your devicetree is wrong".

The dependency stuff exists because it is far too easy to miss something
in a list of 30+ extensions and dt validation can reduce some of the
complexity required when checking what extensions are supported.

> > And now, having looked at these added binding definitions (in patches
> > 07 through 11 in this series), I wonder what exactly is required for
> > them to be accepted.  For the most part these seem to just be defining
> > how the extensions specified for RISC-V are to be expressed in
> > DT files.  It seems to be a fairly straightforward copy from the
> > ratified specification(s) to the YAML format.
> >=20
> > Who need to sign off on it?  Conor?  Paul?  DT maintainers?
>=20
> I generally leave this extension mess to Conor.

And generally I do without that much back and forth, just so happens
that a couple of the ones in this series are the less simple cases to
deal with.

--6T7N+P1CP7qWF7aZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVQKWQAKCRB4tDGHoIJi
0ruvAQC9BigE9R61JyhJdX+DbP3aP9RL8kQil3NqsFlUy1u7zAD+NHwDjf6ZDeRL
rXlytHW0eR8tJlt4hbSavsCcP8lVPwU=
=yKDh
-----END PGP SIGNATURE-----

--6T7N+P1CP7qWF7aZ--
