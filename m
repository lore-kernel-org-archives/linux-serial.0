Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8130327C05
	for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 12:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764334428; cv=none; b=FSKgzdIPOsqwfFlv/wb+qkmoBugdN+xp1NY7KEWZ/NondorM235CXi4YBivvgvAvw78eQJVxjfWKBEtt2oH9pjYgjB5abVHGt2mySCCkHeXycI29AIzEDMWYA1ROwzkdTfuC4vvp0shnKjvsIydlosWXXulLuXayI7LtfSX4xdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764334428; c=relaxed/simple;
	bh=UPOcep9n81xsv668vSa9PNoqgPqmlBy5Zw/nNjOG7e0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQozKyfCTI6nO0mFOkKG9hqR5ceDJIywIj6diPaWTBA7nXwIXdVOx5vz0E3bnmM7IIxWMHgzo/yxi1OPl0CRntBpgmjHEngzEOIyko46gqFJCapZ1Ozlx8krK3H9klm/umhASBO+Fy1tofjGyosPUplerW5vbinUWxcwBV/vHqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b22d3b2a6so1147487e0c.1
        for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 04:53:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764334425; x=1764939225;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDseQkJisg4CVIxAT/T+T8CEfU/6CIXfQEhtmLfidg4=;
        b=QisQMJoIvIT91uf+CFIzA9Uu4vpaMiNFyKapTeKXyOrzFAQ+zl1T5YEL187kf5kRe5
         ucBnlzBb38Fh1D2xk+W42SzjH65FkstbAo5BfdRRD7TEEgHRZSCAM4nlPwiulaeDvuJC
         u14K6PqaQVL/Dv4as8Yp56EAkPgwjw1yhsUijbS4nCWdc/Tk+J50rm74It8Utp2jQlKw
         2pRwofuKaz4Ka1E9i/n/JZ8RUbeUK90VAZPwgIEjpoBlxX9MX8+ejL7fBolAf2LT5kQw
         slUoo32xlJTY2eauCuQecwehQPzGKm4lnAbKt1mi7fkvT5g0+TA3x5PIcfAKjX3qe4Bj
         0cRg==
X-Forwarded-Encrypted: i=1; AJvYcCVGdOOkigmjkZRI13dMbQ3g3RHyYfZyXYzMvJJQMmOZK/dL6cj0HcGSjPX4z5t4/ag4bGdzFvKDXJ78vc4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdibioY1YMzrl2DdrdqYbnohZgximRoGyuH3Cy+3tiUzP9NI/4
	6afbna+//zA1c5ExQ2U6ObFsO5Jxp8mq13UKbXlJzXNrqynJt1daeLNflOrfROHT
X-Gm-Gg: ASbGncuMIBM/aIOKDUcTWeaPyoJY+Anpyof9wengX1GE0/OFoXwYIrATDJxAe6MKTxv
	oOyMV0gq6gQQlf3/J56xdtc64B4vTYzJiAIGa3G9BZmSKXmQxuI3YCAfZ/NGxc27c3YEwQCh6Wl
	aCqfuESd6sfPI2a0LndfnJRuGKa/Zsdj7hstpqYXfQI8+sL740BZZBuGoEUMkmc9TFfwuEiH3eD
	kXdej6jTiYP9K1RI2v16zXv3B0CLjPsjCaiWbi8cWTaZZwVbQrU1Df/rIZGs8jG3b9dNlNyDIkE
	QFm5sGxRzkTySfYea92jhQYoiJ+44iQKVmdq7vlpb1LYlolxm8d+Vn5Olg4A+6UG4ZO2HoTNMc6
	6tqH0oP9FmHyiCJ97mF3jBKxnui0bQ3PPHzn7U3PDE+PEaR7RvTWYPiz2SbNdMNaSi/IlD6VFer
	1o0qXyNTcERF4CTnH0dyZiRUKF18ACyjy9jVAs6PkO1UPUiqVY
X-Google-Smtp-Source: AGHT+IEqiR/tCuy2/QyMtkJ1cvIg3mjQbWaRO5TeggAAvToo1Ca6pEe0+j6a2PVMEJzwQwm063s1Lg==
X-Received: by 2002:a05:6122:926:b0:55b:305b:675e with SMTP id 71dfb90a1353d-55b8d7dc685mr9954305e0c.9.1764334424729;
        Fri, 28 Nov 2025 04:53:44 -0800 (PST)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf518c3efsm1783732e0c.22.2025.11.28.04.53.43
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 04:53:43 -0800 (PST)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5dfaceec8deso1250723137.0
        for <linux-serial@vger.kernel.org>; Fri, 28 Nov 2025 04:53:43 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWMGXws7X7dxA+AJp5WJHvL5/9mmjdSVwZzfvlBl53AQpJp2M19+/opLTLXIiGTno97FM1KoC+7GRWamI8=@vger.kernel.org
X-Received: by 2002:a05:6102:6444:b0:5d5:f6ae:3903 with SMTP id
 ada2fe7eead31-5e1c41bae5fmr14290159137.20.1764334422864; Fri, 28 Nov 2025
 04:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125150632.299890-1-biju.das.jz@bp.renesas.com> <20251125150632.299890-2-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251125150632.299890-2-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Nov 2025 13:53:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaqnCmHBk+Zxo23KU7e+GuH022nDgpR59dH6K8Ei9O4Q@mail.gmail.com>
X-Gm-Features: AWmQ_bmgULqFLeFRcycOL4pCRTkS5R6pidDFCRXPqROfRT1ZMmUGtqRK8msYPEk
Message-ID: <CAMuHMdVaqnCmHBk+Zxo23KU7e+GuH022nDgpR59dH6K8Ei9O4Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/16] dt-bindings: serial: renesas,rsci: Document
 RZ/G3E support
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 25 Nov 2025 at 16:06, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add documentation for the serial communication interface (RSCI) found on
> the Renesas RZ/G3E (R9A09G047) SoC. The RSCI IP on this SoC is identical
> to that on the RZ/T2H (R9A09G077) SoC, but it has a 32-stage FIFO compared
> to 16 on RZ/T2H. It supports both FIFO and non-FIFO mode operation. RZ/G3E
> has 6 clocks(5 module clocks + 1 external clock) compared to 3 clocks
> (2 module clocks + 1 external clock) on RZ/T2H, and it has multiple resets.
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v3->v4:
>  * Dropped separate compatible for non-FIFO mode and instead using single
>    compatible "renesas,r9a09g047-rsci" as non-FIFO mode can be achieved
>    by software configuration.
>  * Renamed clock-names bus->pclk
>  * Rearranged clock-names tclk{4, 16, 64}
>  * Retained the tag as the changes are trivial.

Thanks for the update!

> --- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml

> @@ -62,6 +82,46 @@ required:
>    - clock-names
>    - power-domains
>
> +allOf:
> +  - $ref: serial.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g077-rsci
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 2
> +          maxItems: 3
> +
> +        clock-names:
> +          minItems: 2
> +          maxItems: 3
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,r9a09g047-rsci
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 5
> +          maxItems: 6
> +
> +        clock-names:
> +          minItems: 5
> +          maxItems: 6
> +
> +      required:
> +        - resets
> +        - reset-names
> +    else:
> +      properties:
> +        resets: false

While technically correct, please move the contents of the "else" branch
to the "if ... renesas,r9a09g077-rsci" above, to increase uniformity.

Also, RZ/G3E RSCI has two more interrupts: AED (active edge detection)
and BFD (bus collision detection).  Sorry for missing that before.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
