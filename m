Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907D31A556
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767108129; cv=none; b=Zb8rJpAUgUw/IX+siOXO+M/Hns0yNGMyN72msFiJAYtjimcOMmdHBwgBH4OzGYs5bWWk8F/CYuozF7PR+KYMaolOihcJYoNIiI9jMtHFUTelADA0OI1OUZg4jgd+3cgkK4DrewJq+MIpLkJybI/0H2tSxzJ20PHikNEwSepR6Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767108129; c=relaxed/simple;
	bh=H2790WoLvikyZR/aEdE8RPL6zHqL0rU8f9B5hIkiMx8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ij4yHXbwHcDHnzdoqWRSnzezWes85VOUpvnUZ7n3yQn0NhVSjUhf1BBN6xl8wCNcr13BCbHyR+VWhBPMazLwMOIL0zKFP96c73QdLB4243nQxTRV251wTHhRj/hBVWj2tpAXEYl7A2/DUrvu4X0knwT2zULixe/btlJ5OhjUrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYzfLelP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYzfLelP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7EBC2BCB0
	for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767108129;
	bh=H2790WoLvikyZR/aEdE8RPL6zHqL0rU8f9B5hIkiMx8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PYzfLelP17xxI4uMH4vxKp0zxSh8TGNCiBeNRJ7pg4YouoI5wMq3RBqbXNGZ2GMKc
	 CcPrDfc/RNd9mAtiO+jggoTffAbefjJjP34jdFCddRJ5YKWcxJgseeYnn9Y8nzMGzt
	 Ur4WxhycZ797lAkWj/iPiJuEP7mEsWwcfBxO+Zv2NMpJfrn9FS+9dZ1SA3FNad5T+j
	 Vqi+QbG9RQJeu199Z/LLISyz7H1oFCuvxg+8DgVg7XF4LUmFr7S6bad3aj2Hz/oJNf
	 fC4N+xRwmobCmVeIg1FfkcCtVozyLeZyS9kmh++53UGQXIzaR9UFcU82rJqpdZVok8
	 DCjGDoSsV5hnw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so2204469066b.2
        for <linux-serial@vger.kernel.org>; Tue, 30 Dec 2025 07:22:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxuisN9FstHyypqln8ThCAScd215sH3ZfAUsaSQ+NtyKFf4tR+OyMWAYR57iear4S8e6do4p/pGz7zdFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUbou9lUBqVe/5UZJicTRjcgD6K6UnlLRgmNWahGtkWioWNLF+
	tGMgArZdkZOiD5zDHSeTIZ11yO1IbGd3VU3dHcHSUUhyOJQdCH5inXR8wUYxRdfaTTUMJtzl2is
	AdraIgM1qyyUswcyJWKXKW2TmE+b8XQ==
X-Google-Smtp-Source: AGHT+IGgMUh2wDMtCLD4FQ/4n5kInvO9Hj2g8b7NZ7InxlarGA9KxRQ6Bk4MJxJTlQFvjcTH2u3r21ia8rmut5A5+kI=
X-Received: by 2002:a17:907:829a:b0:b83:246c:d125 with SMTP id
 a640c23a62f3a-b83246cd206mr1113571366b.41.1767108127778; Tue, 30 Dec 2025
 07:22:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-11-3af3f3cd0f8a@riscstar.com> <fc719e92-10bc-455f-b402-c93bdbf878cf@riscstar.com>
 <20251230021306.GA3094273-robh@kernel.org> <80e18a32-543a-48f5-81f2-4fa64cb8bf8c@riscstar.com>
In-Reply-To: <80e18a32-543a-48f5-81f2-4fa64cb8bf8c@riscstar.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 30 Dec 2025 09:21:56 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com>
X-Gm-Features: AQt7F2oUAcuZgOKGmytF5zWoPN9kK4MNOhIzhcBZ1Fbq2d5Goxy_iVvpoy95C7s
Message-ID: <CAL_JsqK8hRsVWV6WfbZ6hF1PwFfOJhyOrpWwoOhviAgv5ZxKUw@mail.gmail.com>
Subject: Re: [PATCH v2 11/13] dt-bindings: riscv: Add Supm extension description
To: Alex Elder <elder@riscstar.com>
Cc: Guodong Xu <guodong@riscstar.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Conor Dooley <conor@kernel.org>, 
	Heinrich Schuchardt <xypron.glpk@gmx.de>, Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, 
	Andrew Jones <ajones@ventanamicro.com>, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	spacemit@lists.linux.dev, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 29, 2025 at 9:14=E2=80=AFPM Alex Elder <elder@riscstar.com> wro=
te:
>
> On 12/29/25 8:13 PM, Rob Herring wrote:
> > On Fri, Dec 26, 2025 at 03:28:47PM -0600, Alex Elder wrote:
> >> On 12/22/25 7:04 AM, Guodong Xu wrote:
> >>> Add description for the Supm extension. Supm indicates support for po=
inter
> >>> masking in user mode. Supm is mandatory for RVA23S64.
> >>>
> >>> The Supm extension is ratified in commit d70011dde6c2 ("Update to rat=
ified
> >>> state") of riscv-j-extension.
> >>>
> >>> Supm depends on either Smnpm or Ssnpm, so add a schema check to enfor=
ce
> >>> this dependency.
> >>
> >> I have the same general question on this, about whether it's really
> >> necessary for the DT binding to enforce these requirements.  The
> >> RISC-V specifications are what truly defines their meaning, so I
> >> don't really see why the DT framework should need to enforce them.
> >> (That said, I'm sure there are other cases where DT enforces things
> >> it shouldn't have to.)
> >
> > Does the specification have some way to check it? What happens if a DT
> > is wrong? Are you going to require a DT update to make things right? Or
> > the kernel has to work-around the error? Neither is great. So having
> > this as a schema makes sense to prevent either scenario.
>
> I'm really glad you weighed in.  I actually have several questions
> related to RISC-V extensions and DT.  But for now I'll focus on
> just this...
>
> To answer your first question, I'm not sure how the specification
> is "checked", or what "it" is that you're asking about for that
> matter.  Also I think we have to be clear about what "wrong" means.
>
> RISC-V is defined by a (large and growing) set of specifications
> that are developed through a well-defined process.  When a spec
> is *ratified* it is committed, and it won't be changed.  These
> specifications are ultimately *the* definition of RISC-V
> compliance.
>
> I assumed the "wrong" you're talking about is a DTS/DTB that has
> been committed but somehow does not match what a RISC-V spec
> says, but I might be mistaken.

That's correct.

> Anyway, we can flip that around and have a similar problem:  What
> if we define the DT binding in such a way that it doesn't match
> the RISC-V spec?  The (ratified) RISC-V spec is right.

Sure. Any time there is more than 1 source of truth, they could be
mismatched. But it is 1 spec and 1 schema to compare, not N DTS files.
Checking the schema matches the spec is much easier than reviewing
every new DTS file.

The only true fix is to make the spec machine readable.

> My thought was that we should have software do the verification,
> and recommend the software (e.g. arch/riscv/kernel/cpufeature.c
> in Linux) be updated to verify things before committing to a
> DT binding.

That moves validation from build time to run time. How is that better?
And what about other OSs?

I'm very much of the opinion that it is not the kernel's job to
validate the DT. It obviously has not done a very good job given
issues we find with schemas. It's fine to have some checks in this
case if the kernel can't function (or use/enable the extension)
without the dependent extensions, but there are lots of classes of
errors the kernel doesn't need to care about.

> To me, C code is more general and more universally understandable
> than YAML rules, but I'm biased by how well I work with C versus
> YAML schemas.

Personally, if I was going to do validation with code, I would pick
python or any language that can handle lists and dicts natively. I too
would prefer C for everything, but it's not the best tool for the job
here. Even if we decided to do validation in C (I'm pretty sure we had
a proposal to do just that at some point), we'd just end up defining
our own data structures of validation data. Because at the end of the
day, most of the validation information is all the same structure of
data (i.e. a list of properties with lists of allowed values). I'd
much rather follow some standard (json-schema) that's already
documented than try to come up with my own poorly documented
invention.

I do think there is some need for code based validation as there are
some things which can't be expressed with schemas. We have some of
that in dtc, but that only works for core bindings. Some sort of
python snippets of code in schemas is kind of what I'm thinking.

> In any case, a "wrong" binding is a problem no matter what the
> reason.  One way or another there are things expressed via DT
> that must match the RISC-V specifications.  And yes, we do have
> tools and bindings that can verify things related to DT.
>
> >> And now, having looked at these added binding definitions (in patches
> >> 07 through 11 in this series), I wonder what exactly is required for
> >> them to be accepted.  For the most part these seem to just be defining
> >> how the extensions specified for RISC-V are to be expressed in
> >> DT files.  It seems to be a fairly straightforward copy from the
> >> ratified specification(s) to the YAML format.
> >>
> >> Who need to sign off on it?  Conor?  Paul?  DT maintainers?
> >
> > I generally leave this extension mess to Conor.
>
> Sounds wise.  Should I address my other few questions on this
> topic to Conor?  I don't want this particular series to get
> held up on unrelated discussions.

Probably so.

Rob
