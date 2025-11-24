Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C9C303A19
	for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763989424; cv=none; b=knJD8uFzZnsGprK/CGi2McQAOhjAj0cc7vZektkUzLzzCiW7ulI3ViHGy7UXxnFCq6DNisc6VkWPYqOxKTHY/X9gg9hokpYi8fIBTao+74q15rXZ39Cvp7uEm9h05R94qwxozZxcyHXERqX7OofUq24uneFI8aOqacUs5gpv3DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763989424; c=relaxed/simple;
	bh=juEwwBHwWVxDO9we5PhqbI1FUp9575Si/nd6yLinO7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGAAOwIWZahGGjNgAQnhKDv+n3DouJ35FkK/lKNz0fL5QRPzkmNGQZXYv8NH3EVcD5GFDn31Cfyp01wDYlcw8/63uNEgBW3QmMaHzDxvRZIV7ziyjUvSmyTfaHBqeyM7RvJ2cO0mFZTM8mhDFu2aqIPlcIoTZ5VdZlG0MFp1wIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ee158187aaso42910131cf.0
        for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 05:03:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763989421; x=1764594221;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c6ZohreewlB1g3ntJmej8PVH+g85TvJ2XqeezukQsPs=;
        b=l33BLMTnfh87R2Jr1zaw5J7NaYJ9OxP83De0XYIM5/bsorxwzZNW5XEUrdIG2Oo3Jp
         FjKItUGgkm42MiUQyMmop52PH1PWlgfBQuANmi7Viv52RjO9hfc8/BQqa7cWHkiO1bE6
         cxEHcg4cDNuqBoXwpJjZvfhJtEqqWUIAGK3O6aANmSFb2RrDhHQt7ItFW3vdwgi8M1rU
         pRdtC2tFOQXuJ+Iv/SH6PSAkjyV0Hte38SZWl6dVSCc4luO+ETyhgRj+ojqO5BfUsr9P
         ZsMkU9K/yc/1b2WXZPs+M1EJX0y9atgcfYn2whMoF+QOuaDdV6SMBz5MZQnnQBj75PLC
         gqPA==
X-Forwarded-Encrypted: i=1; AJvYcCW0/GKIVqrA/ramQ1BXQkryXLlWVls0SunRLekpYCivN2ZxgL0t27NFUUGHIHi5RoseFgQ4a03e4rUdHbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcJxlyj3XX0HtsOS/bIs7RtB88uXFcBQZwjXM5wut8kQVzjFjf
	fsTKP9q6Zj/UA/h8KHvy/Ipbac9rUXPSpaCvlgTC2vL1ACPNWeRvO7hGommpnmku
X-Gm-Gg: ASbGncsjwcuSDuHmxgdFcrUbEjswRdW7XdQznC3It1jc0lXN2dHqBVYph71QamuJJBw
	XY0wx09Yovxfgy2+RqGY4C8YbAIC0TL/2t5512bHoGkEyiatJUgUbWTbobpqIyhzqKkjkdbNcEH
	c8s+tDIkULRHmzRkdCK87PxS1qjap9pBjT4zRPyEgTNnrIZxveeqHdtwRVNOrOG2qAH7i3mA+9n
	I4+XMlXWASOqzR6SJXOyhY8t1wc5E5cG8p3hAvvVohWDAAyqxxfXi9r6eI6EXNwDZXlncJjInIx
	R+4P+M9Fh4JwdbFL5lDfWTRpOv0qjsFA8BmbAND1tRUd6mo3LKFA9f1KtW9e06MOpXuyD+HUW0f
	Elg8LKI6hz79wef4iOjuftLhGQPItdUaGe5QetqhjkQZoZUTxck6wgriBVKdmVRR2UJrVDw5pi9
	xJYcf0nuYR06px4HwYx/QW9e9TAftUrYc5JdxCK6hGfg2XjYa6
X-Google-Smtp-Source: AGHT+IHV/jJwobfF7ujkxwfT9JWDnhWWuPwQMERt5Gy8t1oiYrIwrIiatKW0BzDOkmDlc+LgimVdJg==
X-Received: by 2002:a05:622a:1b91:b0:4e6:fa8a:47f6 with SMTP id d75a77b69052e-4ee58853cc7mr140097331cf.21.1763989420703;
        Mon, 24 Nov 2025 05:03:40 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b32932ba76sm951029685a.4.2025.11.24.05.03.40
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 05:03:40 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8823dfa84c5so49299946d6.3
        for <linux-serial@vger.kernel.org>; Mon, 24 Nov 2025 05:03:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV2Ta4ubprU1x0IjiaCt44/6h7S2qwBuP88Dd3uaqtSWNEPjx09S2r5VxglKi3BNXlD8CBjfyAvUIGYjzA=@vger.kernel.org
X-Received: by 2002:a05:6102:5e84:b0:5dd:83de:badc with SMTP id
 ada2fe7eead31-5e1de4050c3mr2748242137.38.1763989094662; Mon, 24 Nov 2025
 04:58:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com>
 <20251114105201.107406-2-biju.das.jz@bp.renesas.com> <CAMuHMdX41rq-sd6_g1oCrQVPpgb-MXakpJ9mEbS0K+FY8Q7NDg@mail.gmail.com>
 <TY3PR01MB11346D401362BE3B37564C28586D2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <TY3PR01MB11346A0864AF1CC5A3807E40C86D2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To: <TY3PR01MB11346A0864AF1CC5A3807E40C86D2A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Nov 2025 13:58:02 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUwn8Ad3OYRX9jB-gFKskmwYwTna882d4J=28+zra=awQ@mail.gmail.com>
X-Gm-Features: AWmQ_bkJ9yYGno433AB6_f4xArSaLX1y3Xoz8TuybuRBTCsS8wWuv5G8ykFxnzA
Message-ID: <CAMuHMdUwn8Ad3OYRX9jB-gFKskmwYwTna882d4J=28+zra=awQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] dt-bindings: serial: renesas,rsci: Document
 RZ/G3E support
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: "biju.das.au" <biju.das.au@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"magnus.damm" <magnus.damm@gmail.com>, "wsa+renesas" <wsa+renesas@sang-engineering.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Sat, 22 Nov 2025 at 15:15, Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> > > From: Geert Uytterhoeven <geert@linux-m68k.org>
> > > On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> > > > Add documentation for the serial communication interface (RSCI)
> > > > found on the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC
> > > > is identical to that on the RZ/T2H (R9A09G077) SoC, but it has a
> > > > 32-stage FIFO compared to 16 on RZ/T2H. It supports both FIFO and
> > > > non-FIFO mode operation. RZ/G3E has 6 clocks(5 module clocks + 1
> > > > external clock) compared to 3 clocks
> > > > (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.
> > > >
> > > > Acked-by: Conor Dooley <conor.dooley@microchip.com>
> > > > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

> > > > --- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> > > > @@ -10,17 +10,16 @@ maintainers:
> > > >    - Geert Uytterhoeven <geert+renesas@glider.be>
> > > >    - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > -allOf:
> > > > -  - $ref: serial.yaml#
> > > > -
> > > >  properties:
> > > >    compatible:
> > > >      oneOf:
> > > > -      - items:
> > > > -          - const: renesas,r9a09g087-rsci # RZ/N2H
> > > > -          - const: renesas,r9a09g077-rsci # RZ/T2H
> > > > +      - enum:
> > > > +          - renesas,r9a09g047-rsci # RZ/G3E non FIFO mode
> > > > +          - renesas,r9a09g047-rscif # RZ/G3E FIFO mode
> > >
> > > I can't find the non-FIFO ports in the documentation?
> > > Do you mean "Selectable to 1-stage register or 32-stage FIFO"?
> > > Isn't that software configuration instead of hardware description?
> >
> > Basically, it has 2 modes. FIFO mode(CCR3.FM=1b) and Non-FIFO mode (CCR3.FM=0b).
> > DMAC can be used only in FIFO mode and there are some hardware differences between two as FIFO reg
> > block is applicable only for FIFO mode.

Still, sounds like software policy / configuration to me...

> > It has to be either a compatible or a boolean property "renesas, rsci-non-fifo"
> > Or something else
>
> I believe it must be a compatible to support non-FIFO mode from boot.
>
> I maybe wrong. Please correct me, if it I am wrong.

Why can't it be configured through e.g. the rx_fifo_trigger device
attribute, or some setserial option? Any guidance from the serial
experts?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
