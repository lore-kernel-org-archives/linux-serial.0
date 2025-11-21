Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A073934F491
	for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763738086; cv=none; b=eKiczNjgHHNk5yKWNtIux9mcTjzoQykBUuFCBxBGL26LTfxT2CSN/tICAG6F+fXJYo9cqID6fU3zorbDjf/Zjqzmkp/c3IXPiYzNKf3WCVY5JLsjS1EKa0t8RFQBPIETzbxEM0AMAKKINFYPTGdUdzW7XzKp1pSjaTCpaU2eVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763738086; c=relaxed/simple;
	bh=RpuNqsSj7Kc56XlifgXqnEt5UzwwZYKGCkCdReC7HR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jqaV5hTWL2r1L+JOPcik0PaF3jSSppIBGgDIRZcFYbAt60j/Jr2wWe0DmWdFTQZ6o+wwUkOh3acUfL/YV8W0S/bPf97SWkSW4j36s90oyrxtQ5ZwmKSsdDuI01smP7MvuevNSJoNGdGRFt9Kh5sdzTpZNAR5qoeoL+yomvdIc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-55b104727c8so634553e0c.0
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763738083; x=1764342883;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y56A9w+ayETztMmsAhsdSXSsWoHRaLyp5EoPWD48iM=;
        b=R8s6kYMaFwxsYvWQXwcLYwK2gnvw9LE+IPNPXw3kH4Yt7kUvNkf/jjFtaWdLTGrKxZ
         kANGcXEBmh+cngoDaHjZMzYfj91AyCfi8eQ7GwcgWL4K1i2EsD+4Rb3qqnVOBWvmX4rb
         pZcSJccb0crAm0tmS5oV0vGX5nwDywtJM37YX3u+jHG7+ZBV7B7XO42hOSpEvqTlrvi+
         +WSgdJ9DjnhPs9PLCBM8fMUtdPnInFTHI15TuRTILu2+pR/0EN84vasb6fHv5YGw8x+8
         aRzwS7oZYaasCkwvNXF03lpN0z9H3yZujLmkTRrv/+1COf7GguSOu+p97eA+MrFktke4
         3u/Q==
X-Forwarded-Encrypted: i=1; AJvYcCURjqMIgh1e6LuBKTcX+A60aCvT0uZi83UP5EEeZzVyKAeU6o0pA1oEJmB1DCJNhdf+FS/CusApN++OOLY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6HfApoza8FJopSnAwhe/wK+Q1ipzbCggw4mrbSg6FKA1Lk+Y
	ORdpoKxpNPbTa5z3bK/uCZyXYVD/9Z1cqBuJHKJgzagADE6uEAgF++j8Tgxhd2iy
X-Gm-Gg: ASbGncsRKQCVV1O/x+uW9t8vf8z4J7CseNZy22rYh59ugQqesHSAP12ufiCik0Bl9RJ
	1PVJGztyi1OtICFUL34P3spih9cKwCODpBRhUv6geKDfboK4K6zQOL/p8lurL/alnCsF4T7Clnn
	zmUnOjaHjICY/YljqrQJ4biQiR93vnTA+qhXgKe6Gnsub3V9XSx4TIh7jILOZQD5e/rsgP2F5Ie
	X5eJ4jendbgN9Zz+m84LMtyfELx6isEZ7RTUeNxP6B+yTnffvUDCzjuCJgzijfNbucz68hC5tRS
	y5ZlghEQ9SDJ1xhQXJMm2wXa49MrLwiMYZm6ERZk0TdidakNtdbxohXmzG/oIsiqKwIyJSWXvo1
	9f8r+Nd+OF/XldPrSX/WOBGcQrZ6rpZzAdNcsAPC0V0InqWTFeE+6xyeuN5trPGwdKsEjxidcHe
	iAyMP1CCEuvFCm9x1sRPKQPLOv4X+3s6lo8EwXbIErlekih21QlTOt/jjG9QE=
X-Google-Smtp-Source: AGHT+IHCwVxvSFIwr4vxkyX2OrnVK0E2ceqNVS3JewIl62b8l/Cc536ECKMJDEizhD5hLe5laW8z9g==
X-Received: by 2002:a05:6122:3d14:b0:559:70bc:ca54 with SMTP id 71dfb90a1353d-55b8d794745mr667975e0c.14.1763738083493;
        Fri, 21 Nov 2025 07:14:43 -0800 (PST)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7a06b7sm2451082e0c.17.2025.11.21.07.14.42
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 07:14:42 -0800 (PST)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-935356590ddso604816241.1
        for <linux-serial@vger.kernel.org>; Fri, 21 Nov 2025 07:14:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPSpmHa7asF+cpygzvMiM0vc8JF6KBinmB2ihh+7ut16nusRB95x+qcybyLfbImRlsi7YOYmgwQ6g4U2w=@vger.kernel.org
X-Received: by 2002:a05:6102:5109:b0:5de:6dc:2296 with SMTP id
 ada2fe7eead31-5e1de2cfa42mr755696137.31.1763738082352; Fri, 21 Nov 2025
 07:14:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114105201.107406-1-biju.das.jz@bp.renesas.com> <20251114105201.107406-8-biju.das.jz@bp.renesas.com>
In-Reply-To: <20251114105201.107406-8-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Nov 2025 16:14:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXgYD2wfC3Z=3CAR4KVaMh_hMe09KEjg+NeEwu_DN1i5g@mail.gmail.com>
X-Gm-Features: AWmQ_bmqxyLYxYHgTtODb61giIoyovXVZpvdWPsXqQFHa3nh7Q7VbXNAXdTaohI
Message-ID: <CAMuHMdXgYD2wfC3Z=3CAR4KVaMh_hMe09KEjg+NeEwu_DN1i5g@mail.gmail.com>
Subject: Re: [PATCH v3 07/13] serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
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
> RZ/G3E RSCI tx/rx supports both FIFO and non-FIFO mode. It has 32-stage
> FIFO. Add RSCI_PORT_SCI port ID for non-FIFO mode and RSCI_PORT_SCIF port
> ID for FIFO mode. Update the rx_trigger for both these modes.
>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci-common.h
> +++ b/drivers/tty/serial/sh-sci-common.h
> @@ -8,6 +8,8 @@
>  /* Private port IDs */
>  enum SCI_PORT_TYPE {
>         SCI_PORT_RSCI = BIT(7) | 0,
> +       RSCI_PORT_SCI = BIT(7) | 1,
> +       RSCI_PORT_SCIF = BIT(7) | 2,

Oh no... Anyone who can reminder what is the difference between
SCI_PORT_RSCI and RSCI_PORT_SCI?

And now some RSCI IDs use the SCI_PORT_* prefix, while others use the
RSCI_PORT_* prefix.

So what about renaming the existing SCI_PORT_RSCI to e.g.
RSCI_PORT_SCIF16, and adding new types RSCI_PORT_SCI and
RSCI_PORT_SCIF32?

>  };
>
>  enum SCI_CLKS {
> diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
> index 78fb3b6a318b..66ab85571230 100644
> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3326,6 +3326,9 @@ static int sci_init_single(struct platform_device *dev,
>         case SCI_PORT_RSCI:
>                 sci_port->rx_trigger = 15;

Hmm, why is this 15, and not 16?

>                 break;
> +       case RSCI_PORT_SCIF:
> +               sci_port->rx_trigger = 32;
> +               break;
>         default:
>                 sci_port->rx_trigger = 1;
>                 break;

Anyone, all of the rx_trigger setting for RSCI variants is futile,
as rsci.c does not implement sci_port_ops.set_rtg() yet.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
