Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65AB2BE7DB
	for <linux-serial@vger.kernel.org>; Wed,  8 Apr 2026 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775663606; cv=none; b=GSZmZGgDkuIsGu7+6sUydv+cfY2ysCjodsxbPMFcckCHaW3aUe5J5oRaF0APG8HCVKq3XGvV4+cNpqguuNNN1K2bwIR31aLZ+b6gA2unvpOLvHej6AZE/Mqlgq4UBnNL2MsQQQJI98flAIh+yxX+Wbi2NRPuvzv7Jb2zX0WaDTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775663606; c=relaxed/simple;
	bh=c10W5ALCADJM1BWfUr7/O+YUC+18d/aUdsA2Gn//Un8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diZkhmQopixEPNnuFCpJ7GeHcarQoWsKepfw6N3Pc5sEe4cRzBxdKWjodqd0Pl9/47XXcmVDFSFNspPJeh3KqtcGHkHj8v7ZvxcoM6vPjSQ95c+caLaaKWKRa1nSNjQBVHvUgqshG4b+nBMx1sm1BWaK/9S+Z47IB1DwvqlDb6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-60581b491a0so8905137.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775663604; x=1776268404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/744x+XjzJ75+fqhcq25ueyNm8LBC4TfdouHQzrR540=;
        b=caha4HywaOKGuCuALr3pnLAhGtIX2/qQSorJUrbjoDEf22CLqwEMorawdIFkPv9zQz
         6KbTxlUQ/mp+YKONGXebu5Yf5FZO50Zc5EEurtpxfNHZ3ks2tqtgjduIHP5eIEZFyc+F
         BtoofREsw3fopSLCG3t03YzIYyxC0M6ND3oaUnGFQrcJ3HE/0j0bzlik2SPnkF1MwdDm
         3Y7cKCIXYjkyZPOiTHhXeXWXk9RqpA35cRaGZYvnNiIOFlHSJkRUn46bwwFPVIL0VRn3
         GUnANNdV11P9iu1OgeH9kczim3/BQ0fhJN740ACGf60CAXnxN3N3woQCF0H/pA9RUKY1
         gbdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWDhnxDFXyHnEiBUQkYPOUH2n/c3STDXXQv5rzrklxMAA0Q1MDcfLATfi37S7b334lKDMxvPxcOmhAgKA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk5RtIkAnTDx+DZJmSxQV2o7EVwkcutiNm3swJIlULR8UMa6h9
	ULm3GK/bkEam+dXAJf7MBuD0e14a0gnOuG8UZ45Kmk330uAVbvb+9USmO9ItW0P7
X-Gm-Gg: AeBDieuZgp05UyhFX/QZbX6Afxc7L9q+BRoBF/3fiok3cs6qAiSIF8H9Ohep+5UyVSb
	Fh6jLt9isQQgxfCizabt+z+VFuoikJrGTwKmU18guzw8Np5/OwAYJFBXvMlCnwyDwqU7hOXu0Pq
	EVIHpCBMCccLMhWXm/eOFqdodiLTk/RNagzkb7f5aeMLCX2TH4zG4d+1hu0uaiLC/ODI71lWSJb
	4BUhucMX/WvIdvWjOONo8UcdXvHygaOyWD7XYsHVIKpwKSD0PQmMTeg16yLxjh7nPTKroNL4MlJ
	dXXvu1aczv8miPPI6+IPMwbjVZtHFd0RqzUSB+AwljAxL5Qb+Etm0O7Ov2ik3hn09STimlhnCf+
	epSSC6UhCbavaa+dUvcUYEadImG7QcPM8L3pQVFQb79a9nPQxstgHyQKkC1sEBs3q0/YYlkaS0l
	tjtDUOW/MLOTj73ZiKSg3yAMhHuj2fvbHL59V7P/FQlUN0K4/hcOJyyQHLYQQQ
X-Received: by 2002:a05:6102:8557:10b0:607:5cd7:d7c0 with SMTP id ada2fe7eead31-6075cd7df12mr1713768137.19.1775663603676;
        Wed, 08 Apr 2026 08:53:23 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6074fe8cbbasm1985198137.8.2026.04.08.08.53.23
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2026 08:53:23 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-953b7d2c820so2027318241.3
        for <linux-serial@vger.kernel.org>; Wed, 08 Apr 2026 08:53:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUqTTKYHLXksh3Oker9j0eLaHEu2COfBX1y4Zxr9tbnzjNMNhbFYULcdIxzybWSP1Or1pej8TgK82R2FdQ=@vger.kernel.org
X-Received: by 2002:a05:6102:6043:b0:5e8:1d93:921a with SMTP id
 ada2fe7eead31-605a4dfad28mr6809315137.15.1775663603186; Wed, 08 Apr 2026
 08:53:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408142105.310210-1-biju.das.jz@bp.renesas.com>
 <20260408142105.310210-3-biju.das.jz@bp.renesas.com> <CAMuHMdXVbWg=nz-E0VTet2YgCP-GvmVY_3MJeZbE0Thp-mMpHQ@mail.gmail.com>
In-Reply-To: <CAMuHMdXVbWg=nz-E0VTet2YgCP-GvmVY_3MJeZbE0Thp-mMpHQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 8 Apr 2026 17:53:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVnD7XxQood1qy7_7gz5nzFz7QDiCXP_Fo5s12zZ_qSCg@mail.gmail.com>
X-Gm-Features: AQROBzA_Av2LUf2OVaQl-DbtKrMDxqlexE1J6D0bFc-L2X_SitOpW85jiR6Spjc
Message-ID: <CAMuHMdVnD7XxQood1qy7_7gz5nzFz7QDiCXP_Fo5s12zZ_qSCg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] serial: rsci: Remove goto and refactor baud rate
 clock selection
To: Biju <biju.das.au@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Thierry Bultel <thierry.bultel.yh@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Pavel Machek <pavel@nabladev.com>
Content-Type: text/plain; charset="UTF-8"

Hi Biju,

On Wed, 8 Apr 2026 at 17:45, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, 8 Apr 2026 at 16:21, Biju <biju.das.au@gmail.com> wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > Replace the goto done pattern in rsci_set_termios() with a positive
> > conditional block. When baud rate is zero, the clock selection logic
> > is now simply skipped rather than jumping to a 'done' label, eliminating
> > the goto entirely.
> >
> > Since RSCI only uses a single clock source (SCI_FCK), the multi-clock
> > tracking variables (best_clk, min_err, brr1, srr1, cks1) are redundant
> > and removed. ccr0_val and ccr4_val are likewise dropped, replaced with
> > hardcoded 0 at their write sites, as they were never modified from their
> > initial zero values.
> >
> > No functional change intended.
> >
> > Reported-by: Pavel Machek <pavel@nabladev.com>
> > Closes: https://lore.kernel.org/all/abPpZULsXhRmXTX9@duo.ucw.cz/
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v2:
> >  * Dropped the check (abs(err) < abs(min_err) as it is always true.
> >  * Dropped the check (abs(err) < abs(min_err) as it is always true.
> >  * Dropped variables best_clk and min_err as they are no longer needed.
> >  * Dropped intermediate variables brr1, cks1 and srr1; results are now
> >    written directly into brr, cks and srr.
> >  * Moved dev_dbg() inside the if (baud) block.
> >  * Dropped ccr0_val and ccr4_val, replaced with hardcoded 0 at their
> >    write sites, as they were never modified from their initial values.
> >  * Scoped variables err and srr locally within the if (baud) block.
> >  * Updated commit description.
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

I spoke too soon, you need one more change to make it build:

--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -308,8 +308,7 @@ static void rsci_set_termios(struct uart_port
*port, struct ktermios *termios,
        rsci_serial_out(port, CFCLR, CFCLR_CLRFLAG);
        rsci_serial_out(port, FFCLR, FFCLR_DRC);

-       ccr0_val |= CCR0_RE;
-       rsci_serial_out(port, CCR0, ccr0_val);
+       rsci_serial_out(port, CCR0, CCR0_RE);

        if ((termios->c_cflag & CREAD) != 0)
                rsci_start_rx(port);

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
