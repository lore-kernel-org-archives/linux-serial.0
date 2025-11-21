Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15234E779
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 15:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738255; cv=none; b=a/QANKSiRel7h7ARBJSITVoM03VClSxRYMsZKoJRde9VK2OyX8J+0eYBV1nH+jSar+UbyzE8k70tGrMB0xb77C8mkokfl9dQpd+U43mtowR/3D/cqsM8yQqfNHve911R0Auvyjx8fE8V0DvBLf1BWwSG/2ao+zRYpQEFf90IikI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738255; c=relaxed/simple;
	bh=5eBeEdjkR/Hkm6+xplE8icfNSmSd/34vcdQdGK2qte8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T7bMN630MPgCgDVbLq9dz+xMA5w4Yfg5ue1c8qv5th7XKqoDEhwBieS1XMZMNVnjoig4LpN4C/QlnPGJFKMlPYWbWJU/Bt82IB++6r0w60z/q7qr4HG1wQ5zjx1TyCglYgAJdkaVk77fu0cAzlD6C9ev+/f8CKMNQJRisH30JFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-93516cbe2bbso611651241.2
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763738249; x=1764343049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIua8RfV2AxpUiobTVSq3dGuqkuUf86Fn/APkM2iKmk=;
        b=kDOR40RwbmVF+q+GsRhiUWVO06TzDN25LcWVjlcjJKVM8TUiJ1/sbpE/vp5frCBpih
         9P17l+8lHe1qX2A0x8xkBnAGZk7qdlxSh6P2JZgZk6/i+qjRmvXy1Yns6MZKZF/SVEBh
         TptbqdSAfeeXO43b0O6qVCprCUJKrgm1ZUClSmUrsQ+yOAowLNJ9ZmzUQCNmCWc66Z8C
         A3TznK7b2yIGX6tOKdA4RaaZusARMW68ik68thUcDG8Aj8ac7ARwANJGCJNW9AROG+tv
         Es326B4jJZc2x+Wykg1OexvhSpumnO9C/aU6JN0U5z6rOgnqnjcwo2SuRuoUpYEcDgik
         VG2w==
X-Forwarded-Encrypted: i=1; AJvYcCWvdZnVVCvs1whYTVWKoxW1mUqkSKmZQtAch/3gkzr9xeSdp5X8zKC28sszLd6JsVphlbI1Ta4tYObE69E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoeEpvsfz521hMRyAXaieczmC96XE2o/SClNsKcr0+pJdvEf4O
	DHrcJLBYb/QS2pPK4lUszk/ZGoL5RWy2/mC8eCZx3lAad+pJTJwnBiN5JyxMDCVw
X-Gm-Gg: ASbGncsSxofy6C1PXFsUcba3jXI8zq4nUn/0JtSeMs4b2KRbVmbaH0x5xpzd1w0V2Lo
	a0kjUGcC41Eobo8QVP4R6OLBMadL22wACbsPze88toJeX/he45z7yEmtMm1L9P7g9Xu0EDJhoa1
	zBX1epClurqnYqcRAk+QbojIkelr4xMGaj2E4Vftsks3yYsBsVDqzu81zmlOfno9ZL9oMU7qdi3
	RgTN9B/kaxG4sBm/FaPwsZhChIMdZi2gXn+0aXO9lhkkG+boiUMa7UqAiA3f6Ms1QMWI/3tO4uB
	QVZlAXhnV7BKj2hupnD3em04pltscNxKvDkDbykuqAu+6mKSg9iFhOoI0VTjo7ysLBXTOs1A2r1
	shIiYROxk/QbnyyJoJIvgpJyThI5/jM2Uo5lLuJiPepZOkwFKZbm1kAqorwSm8NTEkejWubkfJM
	SWzWo3uUEf/ofezXz0+82EmRWoEDHwBqCCdVAol7+e4rdQGr8frP1h
X-Google-Smtp-Source: AGHT+IHts9kybxL/5ZPV/JyKSvL42UJfc1tCjVFFS85Zmc2z21ZrgD/WF8W2b0SH+bfIgrikNX38dA==
X-Received: by 2002:a05:6102:441b:b0:5db:f5d1:5786 with SMTP id ada2fe7eead31-5e1de2fe275mr737457137.23.1763738249056;
        Fri, 21 Nov 2025 07:17:29 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93c561c4c2asm2324270241.2.2025.11.21.07.17.28
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:17:28 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-9372a52af7eso659998241.3
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:17:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8IwLVXuj3EY3jYYv/CIHXLUd2ZFqM/qO9byQ0PMU8pBFl/nK3HVzkR1v3y86g0sJnpVL9rLcH0VxuHmg=@vger.kernel.org
X-Received: by 2002:a05:6102:e0e:b0:5df:c1b5:82e0 with SMTP id
 ada2fe7eead31-5e1de36be43mr798925137.32.1763738248035; Fri, 21 Nov 2025
 07:17:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-9-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-9-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 16:17:16 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU2bougdWmD1CpaKDKe0iVJD-H03qbNhhLgyfSpsxp15Q@mail.gmail.com>
X-Gm-Features: AWmQ_bl1HYrUoeR3tLvRWfUvLCultmhzxtsQnjvLxVOOYGWOny4VgM7c5de7q4s
Message-ID: <CAMuHMdU2bougdWmD1CpaKDKe0iVJD-H03qbNhhLgyfSpsxp15Q@mail.gmail.com>
Subject: Re: [PATCH v3 08/13] serial: sh-sci: Add sci_is_rsci_type()
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Fri, 14 Nov 2025 at 11:52, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Add sci_is_rsci_type() for RSCI port type. This will simplify the code
> when the support added for RSCI_PORT_{SCI,SCIF} private PORT type.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -1182,6 +1182,11 @@ static int sci_handle_errors(struct uart_port *port)
>         return copied;
>  }
>
> +static bool sci_is_rsci_type(u8 type)
> +{
> +       return (type == SCI_PORT_RSCI || type == RSCI_PORT_SCI || type == RSCI_PORT_SCIF);

Would be much more consistent if all port types would use the
RSCI_PORT_* prefix...

> +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
