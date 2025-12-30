Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9DD02777FE;
	Tue, 30 Dec 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767116253; cv=none; b=efr5EW3m12dvZ/4wTw+lZEPPqgM4e2htreZWyMejkAJZnS4OaZzqI6eRfd48pCEwomxJuHjRiblJcZTTbB2/DKmKVlS1nCSSQuR9cAV0FXuowJSMvlpwiURniXlLZjiQLDgQoIYZYn44+8W3oAKgaeQjh2K3j4TwULCdxPLQhjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767116253; c=relaxed/simple;
	bh=ER043jVCO9ksspnoXQ3DT8YenpRNj1BgFtkwPByCQfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6ItHXyX2IyzYUjjebhFsQXGBRKtkHblEE/Cl1NkYSbgFuapL9HF2KcvU3KdQy6u5G/x/vHetk2ZkzbQ0TOu3mXnH4XV4LCZslZc9fXR/tW3AEs5TRv5C9YyWNvuThS4HXWPcY7auY6YeMeOL4S6BMo3XSBtzbMojmEiNnHCmxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trHJTh89; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trHJTh89"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD252C4CEFB;
	Tue, 30 Dec 2025 17:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767116252;
	bh=ER043jVCO9ksspnoXQ3DT8YenpRNj1BgFtkwPByCQfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trHJTh89ZZ0TlEasQyjQuvfGf3jU5D1a4C0y5jjMoIywc9mrU3sfLzjoQqpW8NgAI
	 e5csb5YBL+JkJHJHw3JWwglX/STcIoAS+Wb1L5i2LyqYz13QgnQLrozBM/uWo8Rc8r
	 U6ItN4iNXdSpNwdTMxFLD4M442kNyTNAQBLs/vQwyuhb80KCCa9ShIWm1wAsqSKaNh
	 NiPbwN/XNzGGvo8pUv6GXFm7u0SUgj2qUKzLt6s8oQvQ9cpB3T1cNWxyU/uGBrS0TG
	 Tpw+JJK5/xMBZpFcBIlLC9qYJrmla87YrKaszP8iNrAn7fRV6Oj3mE8Q3QvOgle4ai
	 dUVR/Y0g0PLpQ==
Date: Tue, 30 Dec 2025 17:37:25 +0000
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
Message-ID: <20251230-budding-dimple-c34636b0ca4d@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
 <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>
 <20251230021306.GA3094273-robh@kernel.org>
 <80e18a32-543a-48f5-81f2-4fa64cb8bf8c@riscstar.com>
 <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ymaqOL8nauUqvgFe"
Content-Disposition: inline
In-Reply-To: <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com>


--ymaqOL8nauUqvgFe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 09:21:56AM -0600, Rob Herring wrote:
> On Mon, Dec 29, 2025 at 9:14=E2=80=AFPM Alex Elder <elder@riscstar.com> w=
rote:
> >
> > On 12/29/25 8:13 PM, Rob Herring wrote:
> > > On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
> > >> On 12/22/25 7:04 AM, Guodong Xu wrote:
> > >>> Add description for the Supm extension. Supm indicates support for =
pointer
> > >>> masking in user mode. Supm is mandatory for RVA23S64.
> > >>>
> > >>> The Supm extension is ratified in commit d70011dde6c2 ("Update to r=
atified
> > >>> state") of riscv-j-extension.
> > >>>
> > >>> Supm depends on either Smnpm or Ssnpm, so add a schema check to enf=
orce
> > >>> this dependency.
> > >>
> > >> I have the same general question on this, about whether it's really
> > >> necessary for the DT binding to enforce these requirements.  The
> > >> RISC-V specifications are what truly defines their meaning, so I
> > >> don't really see why the DT framework should need to enforce them.
> > >> (That said, I'm sure there are other cases where DT enforces things
> > >> it shouldn't have to.)
> > >
> > > Does the specification have some way to check it? What happens if a DT
> > > is wrong? Are you going to require a DT update to make things right? =
Or
> > > the kernel has to work-around the error? Neither is great. So having
> > > this as a schema makes sense to prevent either scenario.
> >
> > I'm really glad you weighed in.  I actually have several questions
> > related to RISC-V extensions and DT.  But for now I'll focus on
> > just this...
> >
> > To answer your first question, I'm not sure how the specification
> > is "checked", or what "it" is that you're asking about for that
> > matter.  Also I think we have to be clear about what "wrong" means.
> >
> > RISC-V is defined by a (large and growing) set of specifications
> > that are developed through a well-defined process.  When a spec
> > is *ratified* it is committed, and it won't be changed.  These
> > specifications are ultimately *the* definition of RISC-V
> > compliance.
> >
> > I assumed the "wrong" you're talking about is a DTS/DTB that has
> > been committed but somehow does not match what a RISC-V spec
> > says, but I might be mistaken.
>=20
> That's correct.
>=20
> > Anyway, we can flip that around and have a similar problem:  What
> > if we define the DT binding in such a way that it doesn't match
> > the RISC-V spec?  The (ratified) RISC-V spec is right.
>=20
> Sure. Any time there is more than 1 source of truth, they could be
> mismatched. But it is 1 spec and 1 schema to compare, not N DTS files.
> Checking the schema matches the spec is much easier than reviewing
> every new DTS file.

The objective is not to define things with divergent meanings anyway,
only to say "this string is exactly this version of this extension",
so that if some other version of an extension comes along we have a way
to differentiate. We didn't before and that became problematic for both
standard extensions and vendor specific stuff. You'll note we don't look
to define anything ourselves, just cite the spec that provides the
definitions.

> The only true fix is to make the spec machine readable.
>=20
> > My thought was that we should have software do the verification,
> > and recommend the software (e.g. arch/riscv/kernel/cpufeature.c
> > in Linux) be updated to verify things before committing to a
> > DT binding.
>=20
> That moves validation from build time to run time. How is that better?
> And what about other OSs?
>=20
> I'm very much of the opinion that it is not the kernel's job to
> validate the DT. It obviously has not done a very good job given
> issues we find with schemas. It's fine to have some checks in this
> case if the kernel can't function (or use/enable the extension)
> without the dependent extensions, but there are lots of classes of
> errors the kernel doesn't need to care about.

By and large what's in cpufeature.c is there to turn extensions off
based on kconfig choices (vector support enabled etc) or kernel design
decisions (kernel requiring both d and f extensions for fpu support). I
don't think there's anything there that doesn't assume that the
devicetree is correct. For my money, it's much simpler to describe
dependencies in a binding than add more code to the kernel that tries to
figure out dependencies at runtime.


--ymaqOL8nauUqvgFe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVQN1QAKCRB4tDGHoIJi
0pPPAP4x6bW65umXa6RU00YxbiyATI4Z5w1FZqeGJ2pVpPy15wEAn/l7pCbOzmgf
4bOyYpW9PLJJt0w+gKHxg8U0+X6LcAg=
=Cne9
-----END PGP SIGNATURE-----

--ymaqOL8nauUqvgFe--
