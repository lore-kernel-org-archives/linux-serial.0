Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF752D540A
	for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 23:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749597526; cv=none; b=Qv5lUeCnPw2uHnZa8eo3WRThTdqkpnUwVpM/zN/4h+F5EP0ndW9NoKTuBYWUTvF/XXO546erScGZuuQA8dNCeE9gfUD3IFPzeRMujX8ufvn+5MbjrmmhSE3M7VAWM3hk2TKVfDOP2e4Q6kZX/cTTNcZMYgqXY9rwLkXv50tWd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749597526; c=relaxed/simple;
	bh=6wCR/wOF6mnpcOQvAKfddSkIw1hDl8dX/s/2AHpXUDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AyzpbiZuf9+IVbkz4sss/x1bNfQEzPFbtJ4STn/tNzbG3Dl828GRbN65R+aRT3atwJKpKP+NeVv/9GFqLtz/rLNHxjQEq3sFhDZLg0FcQbzijdXLnUahBsQzeJ8/JsQtleJtWfPNR3aOPE+T8FGkBH5bVwF8gMltZP9BNgiWz20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KoauuRl1; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KoauuRl1"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2c4476d381so327954a12.0
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749597519; x=1750202319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mtgyGRFsx3W1moknyTRh8eklG3kKIqbE5e8lYnyeAfo=;
        b=KoauuRl1Q5Ren43HWyrch62TYXfpIRE6xXWyUZohupt9BTbP1r+at1InkhZyT1/v8y
         rq+Jm/sajhW+C2b+xyC1oLbYSkTeJPd1hZMPFRV/8retAA0qfXueRFQvYRrwhX92rEbv
         M1AR6wSJzuid0Olf3Hb9xrEGTo3HvBE2+0Nko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749597519; x=1750202319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtgyGRFsx3W1moknyTRh8eklG3kKIqbE5e8lYnyeAfo=;
        b=jEmacuOoLKb46oxzALwhpwAhehdV1XhAiswuVh28RLEz7ns/D2NqhrTHTGgG6H0w9p
         AkN9GDa10i2dg1MSl18pe5rdVfH62vJd3WYFyeFz/R+NFPhpFIjfg0UajBuNJwPCDsP2
         vyyrVhb/43LaTfLzm93LLuZvzMQ8g8oekvGAvC422RP85F1sMRQd61WSETUX2hMGMKYD
         q3FReaVyFdMzr7ABwFxscusdT7iNLGJnyv+tAn7HoJXS9odhF6yEd9E/zXyB1Y+pq70N
         /1WiHOX4uYdVIxQWOo+e+Nima57OPNqiJ8Howrh9yp4TZh559gO52Qd0jkysLJn6VlLc
         uXig==
X-Forwarded-Encrypted: i=1; AJvYcCVN89C7zDwv0bhwSnVBwmUsf63zIo212UBVrUdvGvv20r2S0LPocLmIfcLh3HuMtnco5BCfv+xI0WcFcx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUQ8ettCVbSzJb9wqkfKJsDpqI6N3gVSs53WU9cpEno5jD21x
	TCTbdjA/Ai9pJk0JtJQ9gKddjXPWvPxX3+UXwDTXtakXpRzFev+/3Y8LcJIjUZCWiJoltgkfK8j
	BUQ8=
X-Gm-Gg: ASbGnctl5AkupduimZkTyWh/qVhULIBjnsybindihWx5Ig3jS58DADriRrObPEW34oY
	0uy+xHM9wivQI3/ixFGvh/siPWO8oLccLGb56rm2806ZkhCWcJDgbin0dUdOLTAibWadZ8Be1Uo
	R1PFJQ6S04wqF1JLUXpWXIW9koUivu7n5g5B9YSnUr+5LD6Cq/BETFC+GByoMp42rR83c65X8hV
	f13Gka37S+NKvmll23DZd6MRfFldgflxrd4kndk54NxTmnIIYyIf+3pRAv/BAx0sLpc/5BgsaV2
	E14nr+Xx0mRpTVi4d8ng30Vjlz/C0HRsn7hw2jMJhbjkUpsxqt2p+Z7K2MCNzvdj4xojRr3kfxj
	dPP/L5zNffgk4lOCEW5qKoe6B1w==
X-Google-Smtp-Source: AGHT+IFE9cJTc7Y5EhrtYC3OSOSY8Zk+LJg5fRyXS4CyMCQSj6GgD8YND+gpsBEX9/Der4ipfAqLSA==
X-Received: by 2002:a17:90b:2241:b0:311:b5ac:6f7d with SMTP id 98e67ed59e1d1-313af81e8f6mr1364842a91.6.1749597518594;
        Tue, 10 Jun 2025 16:18:38 -0700 (PDT)
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com. [209.85.216.47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313b1fecf2csm134082a91.6.2025.06.10.16.18.36
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jun 2025 16:18:36 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-313a188174fso304214a91.1
        for <linux-serial@vger.kernel.org>; Tue, 10 Jun 2025 16:18:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXn9Az0G5wa7OS9eJFK/euEDnpId84O36zhTxM9QUcngSMLolrUIYHNkytgKszZUOpfLWJ+Szd98d7qbAQ=@vger.kernel.org
X-Received: by 2002:a17:90b:3908:b0:311:ab20:1591 with SMTP id
 98e67ed59e1d1-313af9711a2mr1450240a91.15.1749597515737; Tue, 10 Jun 2025
 16:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com> <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
In-Reply-To: <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 10 Jun 2025 16:18:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
X-Gm-Features: AX0GCFt6n77pbmil8IDH9ETyvVBk9GLYcHe7RwT91u86Q2sJf5v-ZMY6TwpptAA
Message-ID: <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Jason Wessel <jason.wessel@windriver.com>, Daniel Thompson <danielt@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
	linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jun 10, 2025 at 1:03=E2=80=AFPM Marcos Paulo de Souza
<mpdesouza@suse.com> wrote:
>
> On Mon, 2025-06-09 at 13:13 -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jun 6, 2025 at 7:54=E2=80=AFPM Marcos Paulo de Souza
> > <mpdesouza@suse.com> wrote:
> > >
> > > All consoles found on for_each_console are registered, meaning that
> > > all of
> > > them are CON_ENABLED. The code tries to find an active console, so
> > > check if the
> > > console is not suspended instead.
> > >
> > > Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> > > ---
> > >  drivers/tty/serial/kgdboc.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/tty/serial/kgdboc.c
> > > b/drivers/tty/serial/kgdboc.c
> > > index
> > > 85f6c5a76e0fff556f86f0d45ebc5aadf5b191e8..af6d2208b8ddb82d62f33292b
> > > 006b2923583a0d2 100644
> > > --- a/drivers/tty/serial/kgdboc.c
> > > +++ b/drivers/tty/serial/kgdboc.c
> > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > *opt)
> > >         console_list_lock();
> > >         for_each_console(con) {
> > >                 if (con->write && con->read &&
> > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > +                   (con->flags & CON_BOOT) &&
> > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&
> >
> > I haven't tried running the code, so I could easily be mistaken,
> > but...
> >
> > ...the above doesn't seem like the correct conversion. The old
> > expression was:
> >
> > (con->flags & (CON_BOOT | CON_ENABLED))
> >
> > That would evaluate to non-zero (true) if the console was _either_
> > "boot" or "enabled".
> >
> > The new expression is is:
> >
> > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
> >
> > That's only true if the console is _both_ "boot" and "not suspended".
>
> My idea here was that the users of for_each_console would find the
> first available console, and by available I would expect them to be
> usable. In this case, is there any value for kgdboc to use a console
> that is suspended? Would it work in this case?
>
> I never really used kgdboc, but only checking if the console was
> enabled (which it's always the case here) was something that needed to
> be fixed.
>
> Maybe I'm missing something here as well, so please let me know if I
> should remove the new check.

So it's been 5 years since I wrote the code, but reading that I was
checking for:

  (con->flags & (CON_BOOT | CON_ENABLED))

Makes me believe that this was the case when I wrote the code:
1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
were instead marked as CON_BOOT.
2. Once consoles became non-early they were moved to CON_ENABLED.

...and the code was basically looking for any consoles with a matching
name that were either boot consoles or normal/enabled consoles.

Is that a plausible theory? It's also possible that I just was
confused when I code things up and that I really meant to write:

((con->flags & (CON_BOOT | CON_ENABLED)) =3D=3D (CON_BOOT | CON_ENABLED))

...AKA that I wanted consoles that were BOOT _and_ ENABLED.

In any case, I booted up the current mainline and I put a printout here. I =
saw:

[    0.000000] kgdboc: DOUG: console qcom_geni has flags 0x0000000f

So that means that both BOOT and ENABLED were set. That makes me feel
like it's plausible that I was confused and really meant BOOT _and_
ENABLED. I didn't spend time trying to figure out how to build/boot an
old kernel to check, though.

In any case, given my test then I think your change should be fine.
Given that it does change the boolean logic, it seems like that
deserves a mention in the commit message.

-Doug
