Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF4182D2;
	Thu,  1 Jan 2026 00:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767226099; cv=none; b=faa+94XEAbkMaGSMAYz8eT7GhHwy5QkVYSNxaXGmyKRbGGnhuz+jGgZ0N3T9WjsUQkNBtm/O4mTkzskcxpzLwtHB+CqcCAmLqoiVArWZgAJdIUGgIGVNBXkV8HQk5VtWaFhR3eE98sEUIPogIQDug3ZUv6Z5jPjWC1qRCx65jo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767226099; c=relaxed/simple;
	bh=6X/Tp+Z3T5SzuykhqjUR/+IFjPdcuJD4olbZ2RtSbB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG+tUViQfaBJw1DCPg+0XbjVnGZtI6/5qh83NtEyMeeSHF1rcUExgQQd5uYUhKVm1ghzZtoHTlyKrfXRdjOdZ8zOy0+Ol1V23lUfbKRJOiBiS02IZzqX5nJzYMWrZ49ceb3Pwq2AVhBkHB2iFclsVITzxCKpkZyt/TbfncYr1BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vz50lUO6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vz50lUO6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC0D6C113D0;
	Thu,  1 Jan 2026 00:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767226098;
	bh=6X/Tp+Z3T5SzuykhqjUR/+IFjPdcuJD4olbZ2RtSbB4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz50lUO6Ev5+SRB4FShQPTcJK0g2BnszKVTYTQJj8W9zYe1MSD7dXlKg4LXgdmIx3
	 BCbOrFCfkJwJfPs1lLg+kg8lL0JvOLIVQLVxKOLz2zGqaBo0o8M7Gn47dAYMalzYAg
	 IsTZ4WFYsxv2f8xLvcsyJDJWgVk8RTiz99ADbpdN5Ks25aC27GNlMf6co0aygCGY+F
	 zBn+wXxt03uAe5MxUsjawLofeuhQYi5+x6+OumtscQC9R8ORN2WhZkn87Si613pQ7a
	 ShWpVZQWS5FD5unbP44pw6M+MP+av+29s5MEL5gerp7g8aDI1S9S99TxAsNRen4k8a
	 JNynEgmb7tvAA==
Date: Thu, 1 Jan 2026 00:08:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Rob Herring <robh@kernel.org>, Alex Elder <elder@riscstar.com>,
	Guodong Xu <guodong@riscstar.com>,
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
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>,
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension
 description
Message-ID: <20251231-grew-abrasion-dc1a9d34e632@spud>
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com>
 <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>
 <20251230021306.GA3094273-robh@kernel.org>
 <80e18a32-543a-48f5-81f2-4fa64cb8bf8c@riscstar.com>
 <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com>
 <20251230-budding-dimple-c34636b0ca4d@spud>
 <05B0AE03-E7B1-4DCD-88D0-DCB9053F30BA@gmx.de>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="U5hKiFJHOMcGatbm"
Content-Disposition: inline
In-Reply-To: <05B0AE03-E7B1-4DCD-88D0-DCB9053F30BA@gmx.de>


--U5hKiFJHOMcGatbm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 09:41:56PM +0100, Heinrich Schuchardt wrote:
> Am 30. Dezember 2025 18:37:25 MEZ schrieb Conor Dooley <conor@kernel.org>:
> >On Tue, Dec 30, 2025 at 09:21:56AM -0600, Rob Herring wrote:
> >> On Mon, Dec 29, 2025 at 9:14=E2=80=AFPM Alex Elder <elder@riscstar.com=
> wrote:
> >> >
> >> > On 12/29/25 8:13 PM, Rob Herring wrote:
> >> > > On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
> >> > >> On 12/22/25 7:04 AM, Guodong Xu wrote:
> >> > >>> Add description for the Supm extension. Supm indicates support f=
or pointer
> >> > >>> masking in user mode. Supm is mandatory for RVA23S64.
> >> > >>>
> >> > >>> The Supm extension is ratified in commit d70011dde6c2 ("Update t=
o ratified
> >> > >>> state") of riscv-j-extension.
> >> > >>>
> >> > >>> Supm depends on either Smnpm or Ssnpm, so add a schema check to =
enforce
> >> > >>> this dependency.
> >> > >>
> >> > >> I have the same general question on this, about whether it's real=
ly
> >> > >> necessary for the DT binding to enforce these requirements.  The
> >> > >> RISC-V specifications are what truly defines their meaning, so I
> >> > >> don't really see why the DT framework should need to enforce them.
> >> > >> (That said, I'm sure there are other cases where DT enforces thin=
gs
> >> > >> it shouldn't have to.)
> >> > >
> >> > > Does the specification have some way to check it? What happens if =
a DT
> >> > > is wrong? Are you going to require a DT update to make things righ=
t? Or
> >> > > the kernel has to work-around the error? Neither is great. So havi=
ng
> >> > > this as a schema makes sense to prevent either scenario.
> >> >
> >> > I'm really glad you weighed in.  I actually have several questions
> >> > related to RISC-V extensions and DT.  But for now I'll focus on
> >> > just this...
> >> >
> >> > To answer your first question, I'm not sure how the specification
> >> > is "checked", or what "it" is that you're asking about for that
> >> > matter.  Also I think we have to be clear about what "wrong" means.
> >> >
> >> > RISC-V is defined by a (large and growing) set of specifications
> >> > that are developed through a well-defined process.  When a spec
> >> > is *ratified* it is committed, and it won't be changed.  These
> >> > specifications are ultimately *the* definition of RISC-V
> >> > compliance.
> >> >
> >> > I assumed the "wrong" you're talking about is a DTS/DTB that has
> >> > been committed but somehow does not match what a RISC-V spec
> >> > says, but I might be mistaken.
> >>=20
> >> That's correct.
> >>=20
> >> > Anyway, we can flip that around and have a similar problem:  What
> >> > if we define the DT binding in such a way that it doesn't match
> >> > the RISC-V spec?  The (ratified) RISC-V spec is right.
> >>=20
> >> Sure. Any time there is more than 1 source of truth, they could be
> >> mismatched. But it is 1 spec and 1 schema to compare, not N DTS files.
> >> Checking the schema matches the spec is much easier than reviewing
> >> every new DTS file.
> >
> >The objective is not to define things with divergent meanings anyway,
> >only to say "this string is exactly this version of this extension",
> >so that if some other version of an extension comes along we have a way
> >to differentiate. We didn't before and that became problematic for both
> >standard extensions and vendor specific stuff. You'll note we don't look
> >to define anything ourselves, just cite the spec that provides the
> >definitions.
> >
> >> The only true fix is to make the spec machine readable.
> >>=20
> >> > My thought was that we should have software do the verification,
> >> > and recommend the software (e.g. arch/riscv/kernel/cpufeature.c
> >> > in Linux) be updated to verify things before committing to a
> >> > DT binding.
> >>=20
> >> That moves validation from build time to run time. How is that better?
> >> And what about other OSs?
> >>=20
> >> I'm very much of the opinion that it is not the kernel's job to
> >> validate the DT. It obviously has not done a very good job given
> >> issues we find with schemas. It's fine to have some checks in this
> >> case if the kernel can't function (or use/enable the extension)
> >> without the dependent extensions, but there are lots of classes of
> >> errors the kernel doesn't need to care about.
> >
> >By and large what's in cpufeature.c is there to turn extensions off
> >based on kconfig choices (vector support enabled etc) or kernel design
> >decisions (kernel requiring both d and f extensions for fpu support). I
>=20
> Should supm be handled in the same way? Add it to the device-tree of
> RVA23U64 devices. If a kernel does not support pointer masking in user
> space, hide the extension in cpufeature.c.

Perhaps.
Samuel opted not to add supm to dt when he introduced the other relevant
extensions, so the rationale from him would be helpful but I'd like to
get more opinions on how to deal with supm specifically. supm doesn't
really describe hardware capability, since the privilege specific
instructions are what does that, which makes me question if it should be
in dt at all. On the other hand, it could be argued that supm describes
a combination of hardware capability at the dt consumer's privilege level
and is valid on that basis. Some wording like Zkr will probably be needed,
specifically mentioning that having supm in the dt means that corresponding
version sxnpm for the privilege level that the devicetree is provided to
is supported.

Either way, we are going to need something in cpufeature.c to imply
supm so that it appears to userspace if the privilege specific extension
is detected and supm is enabled in the kernel. The kernel already does
the implication internally it just isn't reported as an extension to
userspace IIRC.
If we permit supm in dt, we're also going to have to turn supm off if
the Kconfig option is disabled, but that's relatively little effort
since it mostly (or maybe entirely) reuses code from implying supm.

--U5hKiFJHOMcGatbm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaVW66AAKCRB4tDGHoIJi
0jdtAQDh+sAVToaEfPjzGxpRTEXEReCVS1mCPwrMK8rPVPTCgQEAwjo7fMTy9Dft
Y6qKnMj6ZPI2VhbDfPQ3i6/wGzgxiAE=
=aAhy
-----END PGP SIGNATURE-----

--U5hKiFJHOMcGatbm--
