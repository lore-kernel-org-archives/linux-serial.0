Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC623171CD
	for <linux-serial@vger.kernel.org>; Sun, 28 Dec 2025 02:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766890293; cv=none; b=absRJ5pkFWp7aRicj+z0SuWz+EyclgU3vQOL87OxN/kMA34ZDJ7J+cHw39E/YUa4RRvtg2HvlC2ysnXYvQ1mxKr1oqQRCVRkZzAmkAGYaJx42h3AHacxFpkNfPCZ0QWIgpH5NTt8PM3X6mbb2d/N5W78zN9AW+EEHkb+mk1lRdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766890293; c=relaxed/simple;
	bh=pQXGQ5o8UonNog9Yxlk36qtPZV2LXTq+Oq3el+trUIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1lEUcbFQuo1hhyeAVlrKAWR1mSi9RW55sPp8BsixO5MqQ212YAhQ0sq1Fzv1wSQ5jmNf/4xpQ4hOfbvIgRi+nhRbpNabC6H6zEhHgWIe1IlyLDTYGe+HjprHgEUuD5Ph9Qs4Gy5e+j2WzqUp7luWCMnSAayjEKeJFVGUyRbuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=Ff5kLJdN; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="Ff5kLJdN"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787da30c50fso73024577b3.3
        for <linux-serial@vger.kernel.org>; Sat, 27 Dec 2025 18:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1766890290; x=1767495090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18qGTvniKulXXWT/wKk72xoOo8IjxyBBayqhOjXKPqU=;
        b=Ff5kLJdN+q1uu6az8BZmWLYAaOOgNs5rY74Aza7rTYjP3XbO9BODCYnYOiCubKUyDQ
         RiScfwA58fQm7flAg6l7xprJJG4uB80apTdafPAfq4aasj/SZYdQsy21aLezItsbmRwG
         7mT/s5iQSzutadUcdeQWC5De9HSGtWfnO1N/GLvUL09PWQQLPaT/vWm7bAzcrGnwb9zd
         xWKSJMtmsmZF4XGXlZ3kN6q/OhhueRNqA1ZAknR43Qdwr3xZFqFOOT6f29NsLUZ2yban
         jc8AYk+REFpmddejUtkuuGK1Xq0iqvEV96mwPXVbK1jUVXz0Np93YatPexM56fHWHAB1
         l9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766890290; x=1767495090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18qGTvniKulXXWT/wKk72xoOo8IjxyBBayqhOjXKPqU=;
        b=cZWCei5BikJpMvfUCTEzhpWRyE8UpROiY0R0bC71mg2XnUYmfGzW6KGut3SnMYwBUV
         u42R2vZzQ0aOBy2Y+Im+jtUVN0vD/6I7jn4vOwHw/y5MdRLm4ZZ6agabhmqgnuI0Qa+R
         kzWwMmc0/ghaikc79Hd0iE7R4+In7a5IAra1EieWKoA/rm6+vewPUKZZatQAajpmO0QO
         rXpWJQSrXU9aTuuLh9uJB76b8vVcV40YqUvI151uQoUyn4c0uRuS4gW/+0ytEcjiBAc3
         jXh6Tis9zsDj1zkC0BPFnXoHvJvPHWrUGLvGi1fTGDlXN6pZMXIbZgora94DWSF3ewaJ
         NlDg==
X-Forwarded-Encrypted: i=1; AJvYcCVEl07SWbFz4rikLnjBY6e0wpFtiristi1zwMwWWVmaT/3b40XXDFr92DEOYLM67zVE5epEfTsYs0fMyVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyseZ5kZ2n1bzDUYnvQuGL7tT8hMDI8wSpyzVd5oapHmSe/Ezb/
	rsmGBIYIXWizcgrtOOAdTFlhq1di9RtDNrD1v4yXrL3WuRws+gK+ZV9+BeqlXAfp1WRkUGZYQfD
	MH23pPNtUOyankoKml8Dj+pVY2dHMcy5YqAgduTNGpQ==
X-Gm-Gg: AY/fxX4QAIh71fGuWeBX/AqSzgLUPNP6aQkk2JAEDJOriAPdlPziFy1+pzBlifmtRIP
	VeLJnMY/a7LQ83CD9tc64lPuHQZUnKqkWfOYdSMEGJ2/wq9L64LftM9VBShusIA+Yw4zJ1rrCk1
	rEarfyI3NLnl2wmrLkReUIyeTq2MafLq5uyFSFHdTvwekZ3GwF+9/EMhxinZ3dKumZbzxDpSgA4
	Kk/pjc6gAZH5OuTWTwUTEdhzWmXMKCPNwmsDn47tjFqKl2R6C+J4SUCfgd4a3dPWcVhocmUs/t/
	jF7IlVVQEM84MNcQd1R5x399DPL1TpksELbfJ9v0D3Uw
X-Google-Smtp-Source: AGHT+IEc7vrvqgLHTFGlN3GYl8BNYF5Xijr5Fz6yp8EHf084aPqSZUjYIDTL+WyA328b2h++sOgSe5PHolFKTubOv/Y=
X-Received: by 2002:a05:690c:2601:b0:78c:697e:738 with SMTP id
 00721157ae682-78fb3f37a5amr462215137b3.18.1766890289821; Sat, 27 Dec 2025
 18:51:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251222-k3-basic-dt-v2-0-3af3f3cd0f8a@riscstar.com>
 <20251222-k3-basic-dt-v2-7-3af3f3cd0f8a@riscstar.com> <20251222-stitch-preachy-3fab87fd6f0f@spud>
 <CAH1PCMZ7ywZ3unLy0yHYK+fFHk0y=q2cEtPnRi=qSpf=fc75rw@mail.gmail.com> <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
In-Reply-To: <66c0676a-7920-4825-b916-3c00b1648a08@riscstar.com>
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 28 Dec 2025 10:51:18 +0800
X-Gm-Features: AQt7F2qn_DuwN9wJBAHmU8RWoNvuj8xcFk9LYANOqbaLNy2Gt0ggjV_dYt2ZiZQ
Message-ID: <CAH1PCMbBURb=DpChf+Y-DjYjzpXG-pKgoaHAu=TUuG4oVC56cg@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] dt-bindings: riscv: Add B ISA extension description
To: Alex Elder <elder@riscstar.com>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@gentoo.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lubomir Rintel <lkundrak@v3.sk>, Yangyu Chen <cyy@cyyself.name>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
	Kevin Meng Zhang <zhangmeng.kevin@linux.spacemit.com>, Andrew Jones <ajones@ventanamicro.com>, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, spacemit@lists.linux.dev, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Alex

On Sat, Dec 27, 2025 at 5:28=E2=80=AFAM Alex Elder <elder@riscstar.com> wro=
te:
>
> On 12/23/25 12:51 AM, Guodong Xu wrote:
> > Hi, Conor
> >
> > On Tue, Dec 23, 2025 at 5:17=E2=80=AFAM Conor Dooley <conor@kernel.org>=
 wrote:
> >>
> >> On Mon, Dec 22, 2025 at 09:04:17PM +0800, Guodong Xu wrote:
> >>> Add description of the single-letter "B" extennsion for Bit Manipulat=
ion.
> >>> B is mandatory for RVA23U64.
> >>>
> >>> The B extension is ratified in the 20240411 version of the unprivileg=
ed
> >>> ISA specification. According to the ratified spec, "the B standard
> >>> extension comprises instructions provided by the Zba, Zbb, and Zbs
> >>> extensions.
> >>>
> >>> Hence add a schema check rule to enforce that B implies Zba, Zbb and =
Zbs.
> >>>
> >>> Signed-off-by: Guodong Xu <guodong@riscstar.com>
> >>> ---
> >>> v2: New patch.
> >>> ---
> >>>   .../devicetree/bindings/riscv/extensions.yaml         | 19 ++++++++=
+++++++++++
> >>>   1 file changed, 19 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml =
b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>> index 565cb2cbb49b552959392810a9b731b43346a594..385e1deb23996d294e766=
2693f1257f910a6e129 100644
> >>> --- a/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>> +++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
> >>> @@ -109,6 +109,13 @@ properties:
> >>>               The standard C extension for compressed instructions, a=
s ratified in
> >>>               the 20191213 version of the unprivileged ISA specificat=
ion.
> >>>
> >>> +        - const: b
> >>> +          description:
> >>> +            The standard B extension for bit manipulation instructio=
ns, as
> >>> +            ratified in the 20240411 version of the unprivileged ISA
> >>> +            specification. The B standard extension comprises instru=
ctions
> >>> +            provided by the Zba, Zbb, and Zbs extensions.
> >>> +
> >>>           - const: v
> >>>             description:
> >>>               The standard V extension for vector operations, as rati=
fied
> >>> @@ -735,6 +742,18 @@ properties:
> >>>           then:
> >>>             contains:
> >>>               const: f
> >>> +      # b comprises the following extensions
> >>> +      - if:
> >>> +          contains:
> >>> +            const: b
> >>
> >> What's the value in adding b, if it depends on having all 3 of the
> >> components defined individually too? Currently all "superset" types of
> >> extensions are permitted without their component parts also being defi=
ned,
> >> this doesn't follow convention and therefore needs to be explained.
> >>
> >> You obviously need this construct because the kernel does not understa=
nd
> >> "b", and even if you added support for interpreting "b" to the kernel
> >> this is probably still needed to make sure the ABI is maintained for
> >> anything importing a devicetree from the kernel.
> >
> > Yes, exactly. Unlike other single-letter extensions, "b" was ratified
> > (Apr/2024) much later than its components zba/zbb/zbs (Jun/2021).
> > Existing software and the kernel already expect these explicit componen=
t
> > strings, so enforcing this dependency ensures cores declaring "b" will
> > also be correctly understood by older software that only looks for
> > zba/zbb/zbs.
>
> I might be misunderstanding you, but I don't think extension "b"
> should *require* the other three extensions.  Instead, the "b"
> extension should be considered *equivalent* to the other three.

You are correct in saying they are equivalent.

> That's what I understand it to mean, anyway.
>    https://github.com/riscv/riscv-b
>
> There's no point in supporting "b" in devicetree to represent
> the others if it also requires the others to be present.
>
> I think that, instead, "b", "zba", "zbb", and "zbs" should all
> be allowed.
>
> I might even go further and harden the requirement, saying that
> if you specify "b" you should *not* specify "zba", "zbb", or "zbs".

Historical reasons here. "b" came too late. The chip vendors have published
cores with "zba", "zbb", and "zbs"already.

That's a migration bridge to require "b" must be listed
together with the other three.

BR,
Guodong

> But that might not be normal practice, and it's not necessary
> because they aren't in conflict.
>
>                                         -Alex
>
> > I will update the commit message in v3 to clearly explain this reasonin=
g.
> > Does it sound good to you?
> >
> > Thank you for the review.
> >
> > BR,
> > Guodong Xu
> >
> >>
> >>> +        then:
> >>> +          allOf:
> >>> +            - contains:
> >>> +                const: zba
> >>> +            - contains:
> >>> +                const: zbb
> >>> +            - contains:
> >>> +                const: zbs
> >>>         # Zcb depends on Zca
> >>>         - if:
> >>>             contains:
> >>>
> >>> --
> >>> 2.43.0
> >>>
> >
>
