Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033539DBD6
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775636548; cv=none; b=BlJWWnWyoLtqH6tEwEDhGV+BanDzibLHYjLvIdABfNVrpNG4Yfjro5ALQnHT+XtXTPCo/kxEVJTDPKujMblatgpPp85R4ujN3gnvaSi+eymf4jNYkXo9cPyN+zpmXP7AqWBuTWDK27vY32TJuHs/eNkr/NOiSAzYgoeaFUHaJ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775636548; c=relaxed/simple;
	bh=b5sFFFnz7kI/kQaZbsJwv3/XfCSCJbUJYwCMYtZSKa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jyM3FTJcnc/RyywDLGlttDKGlccV3vesOPThU/Kb6AElj1xhkkwQoB9veBVJqfJJid9HmY9diICa+AQSTLAnLpgG7zonlXnjzrYFyggbBoFL9VEkGsylCxTRS76o2BAX0kwW3VlKMD7DjWRnvM/68OUE3cM90xLGupL+1lC6/6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-56d857af2a3so2179896e0c.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 01:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775636546; x=1776241346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/OdsvJnqKLpxIUdQmatNy3GAgeQFuXxN4Hc4a44FzU=;
        b=sLDxcTott33wwf7i5rzLyPoEsfBVMldi54BOvP2ctnx7HuikRHQezjRTTeIbCflhyq
         8YjVIqoin/Co7aIP6Ao8Cbg0BPyyJtrjmUMLe8xZeajSluptLSbvOYi1+HUtu/6XqxWH
         IIF+ZSq3te02dfFtFXC+qhSobbEZi5/0f2J45dqOAPujei/417yaQ6IDQWqFIikWWqnv
         tKA1CUqoLMwPEmrkIyvfTbnz+zYLHHXcn2A7DJ2uz17nDCvVrTzOgXX/SOtFFLq8iCV7
         HF1LR03KrSRx9n0eBkn2EVS8iHbssK/i3gzB2w0q9eTxZwAXg+NQe/9OkakwfYTFjbdn
         PO5g==
X-Forwarded-Encrypted: i=1; AJvYcCUerU3oPeYaSJJDjh9DLXRnU+WpfKRWyNUYI59ZzEFSCrScbizZwPvVLZ7uMU52Kr7noytxROlsYZSmOos=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/6o8/SJalaekF3+kZ2yxQ8MYOcOixDqwckGYwVxaN9A/EfBDf
	zww2HvJEsNJN76+iGg0op/DQ6tkt/sW0YFFBe+IElmnz/ydemGzc45rmtbcEIqHK
X-Gm-Gg: AeBDietiuZS72ve3sw/S6/HRAMLmzyTHiaMlzF05w6nIzhlwrnbn3rOa2vKHgcNGShY
	YdTQhhX31jpzVoE04BlptlynAyIn+hnZ/ECsxMaD/J6DgwC3MvoifiDbxvJLsHO/cYoewhCudH5
	1uCqnddKlxkyYQyxz/hAhyvEhNwkTAmBcHkb1RiahQLgqOXvpMBY7WddXE3WWL4yUG7YONGh4Uk
	tUWAD7m4J9s2vE/zBunMBOe5IF1gINqIqxvGbdGkA0VPHzN1LBfX9Ii4sqD1BZajgfuh6uw1vfT
	wZ8Whk6cDA9XJcGK48rn4F+2QYXAiHD5tFFbJdKUPa1+HvyIo2HdB5H1Fcfv33v/NRk3bvPxQ6l
	JXjNEssih3qs3JIvxqG+TTafAyGqRONVxQ8mdb/G1S+5kgtMDOhtXD48DGqQ03NVEdctl7VdmTc
	LsNSK3SLhalAbS39gg+mZYQZfcCYbobaBChNXhGaasKaiB81/PS/W5kE/EPeAT
X-Received: by 2002:a05:6122:a5ca:10b0:56e:e514:fcaf with SMTP id 71dfb90a1353d-56ee5150478mr3590778e0c.9.1775636545787;
        Wed, 08 Apr 2026 01:22:25 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9babf3e6sm19796935e0c.6.2026.04.08.01.22.24
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 01:22:25 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6058a7dc4ebso1895825137.2
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 01:22:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzLcjVVkKaD8dQRm89yKVI2SK1lr0Pw1fuWOwutVhZXeDepBWX5BFweH7O8QjxjiR2XpGNpI74e3tq9Ow=@vger.kernel.org
X-Received: by 2002:a67:e113:0:b0:5ff:ea89:44c8 with SMTP id
 ada2fe7eead31-605a4e20b35mr6740856137.2.1775636544455; Wed, 08 Apr 2026
 01:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407151210.102693-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20260407151210.102693-1-biju.das.jz@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 10:22:13 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVXRKHuV0F4gSu+SsyWAS6RYxhd-XBCjXD1jbYznXup1w@mail.gmail.com>
X-Gm-Features: AQROBzARKqorIdZHutGTZwD8x9EqzhXv0LaXrwdoOHx-u8Qf3SkhcMvk_8MboGA
Message-ID: <CAMuHMdVXRKHuV0F4gSu+SsyWAS6RYxhd-XBCjXD1jbYznXup1w@mail.gmail.com>
Subject: Re: [PATCH] serial: rsci: Remove goto and refactor baud rate clock selection
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Pavel Machek <pavel@nabladev.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Tue, 7 Apr 2026 at 17:12, Biju <biju.das.au@gmail.com> wrote:
> From: Biju Das <biju.das.jz@bp.renesas.com>
>
> Replace the early-exit goto pattern in rsci_set_termios() with a
> positive conditional block. When baud rate is zero, the clock
> selection logic is now simply skipped rather than jumping to a
> 'done' label, eliminating the goto entirely.
>
> No functional change intended.
>
> Reported-by: Pavel Machek <pavel@nabladev.com>
> Closes: https://lore.kernel.org/all/abPpZULsXhRmXTX9@duo.ucw.cz/
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/tty/serial/rsci.c
> +++ b/drivers/tty/serial/rsci.c
> @@ -265,20 +265,18 @@ static void rsci_set_termios(struct uart_port *port, struct ktermios *termios,
>         }
>
>         baud = uart_get_baud_rate(port, termios, old, 0, max_freq);
> -       if (!baud)
> -               goto done;

As RSCI has only a single possible input clock for bit rate selection,
there is indeed no need for the "done" label.

> -
> -       /* Divided Functional Clock using standard Bit Rate Register */
> -       err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
> -       if (abs(err) < abs(min_err)) {
> -               best_clk = SCI_FCK;
> -               ccr0_val = 0;
> -               min_err = err;
> -               brr = brr1;
> -               cks = cks1;
> +       if (baud) {
> +               /* Divided Functional Clock using standard Bit Rate Register */
> +               err = sci_scbrr_calc(s, baud, &brr1, &srr1, &cks1);
> +               if (abs(err) < abs(min_err)) {

This check is always true.

> +                       best_clk = SCI_FCK;

best_clk can be removed...

> +                       ccr0_val = 0;
> +                       min_err = err;

... just like min_err...

> +                       brr = brr1;
> +                       cks = cks1;

and the brr1, srr1, and cks1 intermediaries.

> +               }
>         }
>
> -done:
>         if (best_clk >= 0)
>                 dev_dbg(port->dev, "Using clk %pC for %u%+d bps\n",
>                         s->clks[best_clk], baud, min_err);

This dev_dbg() can be moved inside the "if (baud)" check.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
