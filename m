Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E8A44105E
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 12:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071201; cv=none; b=cGI+Oz1yy/Bs0OQy3qzED77XQPg/7NOX67kPuyVYyHvyYkUXnvu0vXXze88Wv5rKO+Jf3uH0Rb63zPYQtxGPma4qFyfyMb+ljYZMZTzc0gXx1A14SKzqR3/M15mXPHMXRqIOL82/KSo+bxQEThsDAAl0ynNzs7OcJWU9BOhlAco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071201; c=relaxed/simple;
	bh=a0i9PcKMdWANqaB+IUJUTJNOSFa7mwJ9bIwX2/ZqpK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCkPCExHOCtCpvL5h28yTkFNShRlrK2KQZISrXjASakzPIvtSKtw/w8pvemmctiPvUYC9Q6JuWPHsc6JpAUzt3Rl4mjyt+Z0sxEyEHMVNS6+4KSCcT1lWkNQkGCvj0G3TyeiUAWzEtqeNRYnuU06EqX5EQTLoPj+XgNKym/TLIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bc56c52a0d1so104662566b.1
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 05:40:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071199; x=1778675999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJXDoBoMNXZBdaFZ5fzB7q32zHx8RAwwhrvDhIPA51E=;
        b=tXKg/MwHucbQOFH11SWE5hFI/pHKIu095ZQolFamm2Aj94D4BMt2du/vVPgYn3IWFH
         dlfSW84oWxh/5QHDnsHQwxtAhX23cFmIlwDp+o2D67NGKiJq89qSJ+t6L8SA7/GYJEq5
         j7F0t/Gdz1MPUFDYNxq/f3okzyxLaEMJzQfZa7bOgAvcOOOa71mTrJSVTNpY0pL2/gmr
         HoOlEMO9GLmQENqnhEPpM7iGNEbfThW26qWyBocdYpfkR5M2g9Nh8KcZXTw+lmiiHWjB
         cf/WJ7ahL5xRYtlSYFX+FScjhZ5/+7MHgkYR02MPLTKY5zKp64UPGeJ1rJOha0en2x3x
         qiOA==
X-Forwarded-Encrypted: i=1; AFNElJ+/yN6Ye1auBwGdteYGrAcU32Aecde+fjuQjpDUNYYXVtxXJB+YoS3ocCJ55etHmRHKA7ml3JuMohwI5aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YycBuO35XJYWqVSOx2ZP+nJRMfkTpd+r8iOSXDqyt96NckmVGko
	coJ/ak/sglCRzedJQannHLPakWTHpbNyn1a4uI63CSBMfX3O7WGFgcox7/8k6HFGgFo=
X-Gm-Gg: AeBDiev3s3QGVJjsqcHJarkOtn1DwjkyZQNf9uIP7G4wqUdn3P0/lpgMhWiwuJHgZfN
	gyuDO+SlcBM6xdRERHcPZKaVfXQSj9T+fF3YlFoajdAGD9y+LexTFKKnKb/ZMVHJNIQCyGGG7c6
	ZHvgAxumPaBVIMR8g1wNAaJeJln8WDS0eSbeSnYPVSpYn1ZPAxh5wkuh4U/jDNqJAivJmq6YdHM
	MetYoACX/de0zB2ruevN/3iHk1MeArN9u8x+HG+GfHl1ggXfAyeHT0Fu1wKdAgpM9mZZdM01IJq
	Jlf4Kn/SLrYOhd5VMlrCf5MXpDA/oVkv0/qp7zposQgRCVNQ07Ac5qTFTZkEkb7UKlsnmL66z7z
	OEEmnCr5yd93jxMNRWsqiut12ViJlZ4/XJaNEmGFCHaofZhYkpn4cx6XSWMiiCO3tdQQ1J4Y2GI
	FgZtR5VhEepYhZeuBp1X9iYKo4PR7YrDiYcG259trBLnaFhNJSGpFWlAn+e0AXIpNAVrbolWg=
X-Received: by 2002:a17:907:9304:b0:bc5:111d:3c96 with SMTP id a640c23a62f3a-bc56b41dd69mr141391866b.10.1778071198570;
        Wed, 06 May 2026 05:39:58 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bc55b58c61asm83503666b.17.2026.05.06.05.39.57
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:39:57 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bc47a96d3bbso246154066b.3
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 05:39:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/IZII6fKkHeRvDmOQN/Bf++dJqqEdZ+d0bIBgNPnwexOYw7wDAjwDkE8SzZSEkjknlTM2caQ76Is9Wr8s=@vger.kernel.org
X-Received: by 2002:a17:907:fd17:b0:bba:3cf3:2ba6 with SMTP id
 a640c23a62f3a-bc56d32b942mr158973966b.29.1778071197425; Wed, 06 May 2026
 05:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506121606.5805-1-john.ogness@linutronix.de> <20260506121606.5805-4-john.ogness@linutronix.de>
In-Reply-To: <20260506121606.5805-4-john.ogness@linutronix.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 May 2026 14:39:44 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
X-Gm-Features: AVHnY4KCjVaMYpPMvAk_XF6WniARJldzRzB6DCs_7WQ0a9A0J7Jk1ZecnxRKgW4
Message-ID: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
Subject: Re: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-serial@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi John,

On Wed, 6 May 2026 at 14:16, John Ogness <john.ogness@linutronix.de> wrote:
> Avoid setting the uart_port.flags deprecated UPF_CONS_FLOW bit if it
> has been configured in the platform data. Use the new cons_flow
> wrappers instead.
>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Thanks for your patch!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
>         }
>
>         port->type              = SCI_PUBLIC_PORT_ID(p->type);
> -       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> +       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
> +                                 (p->flags & ~UPF_CONS_FLOW);

This seems over-cautious to me.
The last setter of p->flags was removed in commit 37744feebc086908
("sh: remove sh5 support") in v5.8.  No platform data ever set the
UPF_CONS_FLOW flag before.  I would rather remove plat_sci_port.flags
and this "| p->flags", so we don't have to care about UPF_CONS_FLOW
in this driver at all.

>         port->fifosize          = sci_port->params->fifosize;
>
> +       uart_set_cons_flow_enabled(port, p->flags & UPF_CONS_FLOW);
> +
>         if (p->type == PORT_SCI && !dev->dev.of_node) {
>                 if (sci_port->reg_size >= 0x20)
>                         port->regshift = 2;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
