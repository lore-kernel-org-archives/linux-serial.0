Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1A35CB60
	for <linux-serial@vger.kernel.org>; Fri,  9 Jan 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767968722; cv=none; b=WZLSlrIqs0HQiO2JKqlSZKC80P/TXDni9F3obRjKTq2ekXiMER8Dqz/XGUGC7u6pHmCApcxwIt1gx0md4gLPFnSQ2jk7H7g2SZyHYl8JbSCYs6V+lZETU6k2JL9Awrew7/QLoSVK32DHbq3owreTR433DVsCYxP7ZH2EmRL2IFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767968722; c=relaxed/simple;
	bh=vWS5wgStTvZMYsyqkJ91nJFk1e35QPzy/HyTmkbyjwQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=srI4s4N3ngn3BMixEwNV85AvlZTRzeaz1vEEYnFlEbfdjAZRS5ZzrZHV+v+4p9olKWpctxZ+6ISJC7E8b4+F8ASPRVS9jpEq34BnE1UHi8EY0tUU87rRZA5mXrO32YM0TEvW4qTIfJVH5OPFmNoREmx57c8sDTvI6t1ksW38+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THA6yVu5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THA6yVu5"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fbbc3df8fso2195465f8f.2
        for <linux-serial@vger.kernel.org>; Fri, 09 Jan 2026 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767968719; x=1768573519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2D/cMtJw19E2XiBZlICMduPGDZFgAVPWV/no22KZcBg=;
        b=THA6yVu5mLYJX4Wbmb8unRBsUVB2W87jVAja8vrRdnVB9MNzCAH2mOPnvrLbmKQTtl
         Afg6gB2+sYb10+vRCsW60YD2k5sNadf+RAMoXFHV7ja94ux8DFJH2E2Nmbw/GNP+kRkH
         BdGBVwqQc7cIP+U1IWOFksEFGJxktnCn7Q2Eto7SKYvbw3s2mnICRC2uE+eYx13nl6P0
         7SamgqP5yn5yEREWdng2uYX+S5IlkVu1FyJfr0g6mnM9GgpF5KD1FaPRQkOa9E4dX0dw
         wRL+5OYzJUAszmDtr5wIQzsuBnYWWeUmv/TLTA+jooPhuHxWcCss0LIYZe9X2fJPs5ru
         4qiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767968719; x=1768573519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2D/cMtJw19E2XiBZlICMduPGDZFgAVPWV/no22KZcBg=;
        b=XWJszfU41a2Tay915LWbP5ojx4wfSSPtqvSlpmN6bdYa0Nru2n/F776b5aRaAd4cK8
         GzyC47Pees6Yz/zHi24KOtes5HKYoN80plvpRrZZFE+nHwXHtJ/ESUI27SDPe2dTbHRX
         CB4E4VwGvtYb+GgifnNQlgpK9EAgWOMBOGg0loDfKFVosbfQ39X11e7SGNS8ViONttSK
         ZC6NLjFufVB421GfASdrIiwnk0YmTWZ+fwIbQ8o1EMGNeNmsbpLOHwf20ylDtjUjsMJf
         6kXv6+6IPTOFxwy3VWlKqBoZCwXCbftYlq/DbjidZHHC7isk5I/m0LGmCklIc980TYSd
         BI1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWllOhjeIfyOzlg5Ez5vFSonIy2/Yy3de8eyQibk0jFh/mNx+NWxe1XQf3At/MIYHNOlP0xqwcox6VP6o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxShGIRTg0DvOZTEKZA1ps8/mEbwUATjUD9BIUed57aUXGlMhOU
	YTDQfpodSXZhft+rZ77IjseKJh3rd/ycNaLm55EB6+pjkD/Z3/1zwwuEa7FCeosK/CTRW5P+LIb
	jKTVVKNwFxiy/Vzbko3nTiBziOsGwwmc=
X-Gm-Gg: AY/fxX7HUCgy05MVH23TpW8dSENBMHMYuyoJCemmunkGu7ZiY5Jig0D2M312WAcJWR+
	mYGZznPUM96OvvvFRQlU5hOtvnbA0SvdiSOYpO/lnuODSPWTSRiV0HlwPRyFXiQgYGesNs8VPVm
	2lVys1I40Ad6nhW2Wpmmcz3HlWgb5qDrStBsxN8wouYoGP2wnbd7c5dLKvYSklU5j1VAbchmSbA
	POmMZxbByRFtAEyLVTzSsLWibXD9hLocMMWGvTNoVAkHfCbzvUNId+Wf27qienP1ZK2Mc/VRupQ
	g6KE9uISdu0FdXO5kJjrGg6sKD0BqgBgrxtIOr5MuM6mEGeaWYdP5Rd0hY4OPlFijz7rsvfkMpW
	i5c9e7weFkHcZ
X-Google-Smtp-Source: AGHT+IFCXpHopv0CnTYKBGZQGAJBBDYem+SbnQhktvQUHhc24r5wwyxuIOji4OejFmeRbAePpFAv7cmMZfKOoTIcV+I=
X-Received: by 2002:a05:6000:200d:b0:432:8504:8989 with SMTP id
 ffacd0b85a97d-432c37c32bemr11765044f8f.56.1767968718975; Fri, 09 Jan 2026
 06:25:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109123828.2470826-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWz6_NzvjZNMLk+Bqoa0NR2CKNFwDXynfmrTZgOGsqxTA@mail.gmail.com>
In-Reply-To: <CAMuHMdWz6_NzvjZNMLk+Bqoa0NR2CKNFwDXynfmrTZgOGsqxTA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 9 Jan 2026 14:24:53 +0000
X-Gm-Features: AZwV_Qg77nOmp7wZB-kSrS_ejJiZLPin5aTjJnBXvyeQ0XDAs8licXEGydP6Z-Q
Message-ID: <CA+V-a8uPDpQ+wBW4EnKSJutywRhYDaRQoUUUJXaZQzknn1nyVg@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Fold single-entry
 compatibles into enum
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Fri, Jan 9, 2026 at 1:28=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68k=
.org> wrote:
>
> Hi Prabhakar,
>
> On Fri, 9 Jan 2026 at 13:38, Prabhakar <prabhakar.csengg@gmail.com> wrote=
:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Group single compatibles into enum.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Thanks for your patch!
>
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -20,6 +20,8 @@ properties:
> >        - items:
>
> I the "- items:" can be dropped, reducing indentation of the block
> below.
>
Agreed.

> >            - enum:
> >                - renesas,scif-r7s9210      # RZ/A2
> > +              - renesas,scif-r9a07g044    # RZ/G2{L,LC}
> > +              - renesas,scif-r9a09g057    # RZ/V2H(P)
>
> This block now indeed contains all single compatible values, but it
> is still located in the middle of other multi-compatible entries.
> What about making it the first block in the "oneOf:"?
>
Ok, I will move it at the top and send a v2.

Cheers,
Prabhakar

>
> For the contents:
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds
