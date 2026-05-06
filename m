Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0367C1CAA7D
	for <linux-serial@vger.kernel.org>; Wed,  6 May 2026 12:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778071833; cv=none; b=aTiGqWouYkX8Ud7qTw50r45vnCD2jB69zQKZZDD64ZSHeGJjoRbPAS7mmGhw/dHWG5nhm4CKFfaKrBBeNZxXnAM2jtDDtwwnSfJH9FMdM/NRedPBm9xbF1dFx8nHrYi2qok5sZCWKr8X2try/UAU8CvPnJEamkjji3HatOdzelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778071833; c=relaxed/simple;
	bh=P7fc9lmuTUzjhUsdr9qur0wqnZkctC6uOGBl/ZL3xG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2KMZiwUSJ2QOE+j7+qXD4C7w6SvbymQGvEVj19yHNQWbW9t7c7WrH9mxGNRAl2b/iEQxFJgbySwKGorETDEAOk2CLWDpqeq30NWFj5vlZ4QrUd9rR5QYG5kZAMiNE+vG9YjwY4pNjku2bYKf2IjyJaXalN9aoYcyeMVl90Utvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-95ce0cf2d4bso573078241.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 05:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778071831; x=1778676631;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aOo6lMLccHifJjC2IxVa3ecG3CMUTyXwBFE4QlmBc6Y=;
        b=fPIhh4d0qSp+eANQt+zHq0jCVxcIxawKcH66AzNb656mVC2YeLmiqo/86AR0w5USlT
         QeNKhFB+qz8kdzAUwI+6s9WftSef+hTTeFaeZH3QEnEEDzqG01hlysaZ6K3pmedh7lZ8
         5xbnIeEWgXzevyEFuQz+YgXMuRYBtKSqsJX60Pkewg9Nx+oJHc1taLyDj53kyNFeJGHQ
         Uucvpw9CDSb2sfuepPFSi3AEzyGoRpGKE1YVOZzMg1yUx2gOphLYFeGHqxz2NPMAEh/z
         lcx4zGx3j5c+o3clQCy0xIv13pIQ/d3VEnhr/5l80dTiAlDUW1YJcKMlsvo0b6YKMXGe
         CCzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3mkzVXNzKRA+tqdST0WPpHgAURggCDRB6udR1u7UOYgcI7nuWE8yzBmj0IYYqdhcBA3lZC2fXo9sU9oo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFej9GL1P+ffYzD0FNoTaaRvkbXevvVpGnIP9BRTV8Zgj3DR1f
	m/TheupRMjUNVT2hrn5pdAX0sloMqnkLsokqaDuwVaU9TorKGzIYyaKI1OUTwN0pH3Y=
X-Gm-Gg: AeBDieuAePE696xCrei2esDJUVgQHJkeLdiYSPnNxZYIAea8gaNwTrX5EZoTLrd0phO
	94r81DdkwT5pwEVqvobMj9K8qxQ62nMtycXVcpmMOMokUvF550UpgrI2fLIaLFwYB5kuuswAITO
	qUNAE4vLvSJWoV1lPawN862rYgZ0cD6OkjVPNFCIt1QBXiLPsxmzmcLBNGK3wCeEg4CqHiG5W7h
	FzOx2XCMZbf8zp38NAht80AECQLRKefGpta93bJLbNgt29TJqCjLO8KgYaVXtyNUBM3KTUoLr5H
	+gBmoGstAcMyM1+JYZQ/6ioBNCgtD2VivX6GW3tdo39DIn8da8EjxL3qhznjtFHXwFIGYIjcxXm
	Bp/OYv+YD3zWSjBXc50DmXssM7lVRAhzF+tuvLSAnUDiZaEuS+TsVC7aNbzkPN9cysY2/ZJXuaS
	Mco8hKRQXfRaABKUifNT9moqb8YY66+EO1y8H+1QFphgvJFeaqzWQuccXF4ZoAITyX5fNuG0MiG
	SviJHqxiA==
X-Received: by 2002:a05:6102:8009:b0:62f:3326:fa4c with SMTP id ada2fe7eead31-62f55a5d6c0mr3657656137.21.1778071830869;
        Wed, 06 May 2026 05:50:30 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc7dd4sm10823365e0c.14.2026.05.06.05.50.30
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 05:50:30 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-95d226e3ed8so629436241.0
        for <linux-serial@vger.kernel.org>; Wed, 06 May 2026 05:50:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9kQ+ZlqVXmmmHzAED9V+WTZc+nfZasCdN6mTwpYz9d0QysI0rK3Nv2nKDGNymLR7tsPTskz2lS56i5yB4=@vger.kernel.org
X-Received: by 2002:a05:6102:4a8c:b0:5ff:ea89:449a with SMTP id
 ada2fe7eead31-62f5598ee1emr3912391137.13.1778071830384; Wed, 06 May 2026
 05:50:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506121606.5805-1-john.ogness@linutronix.de>
 <20260506121606.5805-4-john.ogness@linutronix.de> <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
In-Reply-To: <CAMuHMdXs94k3-7YD-yO7p2=+u8waYGAz8mpP5LDbMf3szt4V-w@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 6 May 2026 14:50:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWH5eH48JkS7phxhgVxAqC_8x1Z=GSxgAVF-eb5Xnt=yQ@mail.gmail.com>
X-Gm-Features: AVHnY4K2Y8QFvbNKiXgndIgGKPZBfZhbzm7AI2XgjtB-KEbHbRZBoZmutt17w3Q
Message-ID: <CAMuHMdWH5eH48JkS7phxhgVxAqC_8x1Z=GSxgAVF-eb5Xnt=yQ@mail.gmail.com>
Subject: Re: [PATCH tty v4 3/6] serial: sh-sci: Avoid deprecated UPF_CONS_FLOW
To: John Ogness <john.ogness@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, linux-serial@vger.kernel.org, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 May 2026 at 14:39, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 6 May 2026 at 14:16, John Ogness <john.ogness@linutronix.de> wrote:
> > Avoid setting the uart_port.flags deprecated UPF_CONS_FLOW bit if it
> > has been configured in the platform data. Use the new cons_flow
> > wrappers instead.
> >
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
>
> Thanks for your patch!
>
> > --- a/drivers/tty/serial/sh-sci.c
> > +++ b/drivers/tty/serial/sh-sci.c
> > @@ -3369,9 +3369,12 @@ static int sci_init_single(struct platform_device *dev,
> >         }
> >
> >         port->type              = SCI_PUBLIC_PORT_ID(p->type);
> > -       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF | p->flags;
> > +       port->flags             = UPF_FIXED_PORT | UPF_BOOT_AUTOCONF |
> > +                                 (p->flags & ~UPF_CONS_FLOW);
>
> This seems over-cautious to me.
> The last setter of p->flags was removed in commit 37744feebc086908
> ("sh: remove sh5 support") in v5.8.  No platform data ever set the
> UPF_CONS_FLOW flag before.  I would rather remove plat_sci_port.flags
> and this "| p->flags", so we don't have to care about UPF_CONS_FLOW
> in this driver at all.

I have sent a patch to remove it:
https://lore.kernel.org/20260506124643.128021-1-geert+renesas@glider.be/

Builds on Renesas ARM/ARM64/RISCV/SH, and boots on QEMU
(rts7751)r2d.

>
> >         port->fifosize          = sci_port->params->fifosize;
> >
> > +       uart_set_cons_flow_enabled(port, p->flags & UPF_CONS_FLOW);
> > +
> >         if (p->type == PORT_SCI && !dev->dev.of_node) {
> >                 if (sci_port->reg_size >= 0x20)
> >                         port->regshift = 2;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
