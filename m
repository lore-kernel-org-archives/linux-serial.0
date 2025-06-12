Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FC915C158
	for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749770186; cv=none; b=W7OE1BCHReEYA1YQVTqHSZ6A6dlJz9/iVCrkwiwvW3gD4Zfiq2kv+InOV78dbLkuDAZ8lMM8OwqIBMihhNR0uebrdEBUM03npO/bwfq86cNw/V1WfiLn9OM8f+suIKR4rNLkLYtolyVFjwApxkW8u013kUxm/mhh4xijrYYNfaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749770186; c=relaxed/simple;
	bh=GVl2AarfDIZ4o7KzER4XK3b0vrUv5ejYJly+UE5yuvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XcM9sAlsHKZ5wYw+VoKgDkRET++eriVK5lsSNJg/jOQQTqV7RTtTBYTKLUtlNFG6PlTGU5yeb6YId6PJrioCwx2P45bNzcX8UJ3ScVbECtI842Jyjj7LTQ+ucbOBqg1/Xphuq/oCmr/w76OkLvSLSV8VN11llddTF0xP4S2iRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UhGeBphW; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UhGeBphW"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-747abb3cd0bso1958793b3a.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 16:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749770183; x=1750374983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VX2tp7vE9Xc39hTYGYaV6T2gV76j7v4yp4p4MnAvSyU=;
        b=UhGeBphW/TKFVpYGmAqJtd10OFBhx3yyOBAaKmFPj4OVsQWxj1FwPmpsqNYR+QbaN0
         je93cuJ1rbWvRTjnpKYzOnPRn747DML2rRnRI9cVnb4wVRUc1oF5IpJVoyukHRQITZHY
         zHzf1KRsrgwnSKbCcFJ7A7rmF+QnB+rqV5eu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749770183; x=1750374983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VX2tp7vE9Xc39hTYGYaV6T2gV76j7v4yp4p4MnAvSyU=;
        b=cB5GRRtB3yKa86Zc3l+aAsfGkwvBAQWD4jbXen5HNMR5t2ug5zGk04xzi8wzPhLevv
         OzIbIbnLc7P61E3RR4/J0SSIG5UvRBKSJL4GUVTn+8OawHV5XRA0So18gECNfmif1FRg
         bFPEhJUgs1s496P5yryCLG2EK9SjWNbeJqHjQ46ZLCNHSNRMwUXGy3b6r2FBCcGI6Pom
         4ESRNbmGaPqZJmZm62SLMtHHFPgC05EeGGwRAlgIY/zacS117awnyVdy6AO2w/hETseK
         LnRu7pAxuCmcLtRDJ+X9IvJX5v4X3AbnuFD6Fmc/2HC4Xp5AsvWkm1vY2zzalmYzXHya
         aa0A==
X-Forwarded-Encrypted: i=1; AJvYcCXTPB1IUzPdLbka/IAmyc743N7MMp0zvO0O5+ySrflLOLUaIy/s8jtFwb+NVAIA7FodzqVa4gmzP2KL8Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4jlqpRRfcqkIGaYWf90U+jPHpTv/5h+VwwVmKBTrqdY0t2StW
	o8yJMJjqgwpK5h8fUqAdPncy+FasrYTOfnDMi9kfq0WmDHkBrKRAx8KDKLLuK5U8y1VnTkJqWJp
	oAf4=
X-Gm-Gg: ASbGncsuJbD0fM26HxrZ9ijK/GrrytD2NOe/oWNSbO0CQJhxiwW0H9CWUh4lwlPTx/r
	APaaeeh3JNF1tRamLPrWOgPrPMrgYCxuKCYQMTT8VENJOb3UocNOy67/qOHvODIPFy5O7wF3i/L
	SRys2AN4YWPId1/XfXtmFbeuZT70+N21Z3ASUTLT2KzayBqeKQhLwraxjIjkFVBJStXLf8ukFPP
	/inyXV0d9w4rrBmqDJkL4ykcLJOKNWuBS0V8BZ3Xqsl+0WgPyGeh0XqSL8BRI5jSAtChwOAEMU/
	wd/zIiTIQ7NbPuwSjPYcweV32593rhLNtNc2RqO01P1nj6ytJFVaVHyzG8GGzMi4LXQAB6sOGgP
	+vv+MixvlFo5+HYLNIRytmXEe1ousRw==
X-Google-Smtp-Source: AGHT+IGQVR+DAbH0UGk5t3eLnQFJof7fCuv+8esFoguySH0AruVpDilvLjw1t1MCZk0lBJpRR1mYIA==
X-Received: by 2002:a17:90b:3dcb:b0:310:c8ec:4192 with SMTP id 98e67ed59e1d1-313dc298ab4mr496260a91.10.1749770183478;
        Thu, 12 Jun 2025 16:16:23 -0700 (PDT)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com. [209.85.215.173])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1bcbc4fsm2107095a91.1.2025.06.12.16.16.22
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 16:16:22 -0700 (PDT)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-b2f645eba5dso1999651a12.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 16:16:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU25CotZpMfLhA/3/U63/R2h867OVX0tUCCgSg9LgglRnRpABMJBlgrCwstdz3NJTHVKkVMADOk1O0/wcE=@vger.kernel.org
X-Received: by 2002:a17:90b:588b:b0:2ff:556f:bf9 with SMTP id
 98e67ed59e1d1-313dc227afamr497218a91.4.1749770181738; Thu, 12 Jun 2025
 16:16:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-4-f427c743dda0@suse.com>
 <CAD=FV=XXQyZLYKoszj68ZGFDY=9-cmEUp406WeOeSBVZOHyUHw@mail.gmail.com>
 <f962e9bab3dc8bf5cae1c7e187a54fb96a543d51.camel@suse.com> <CAD=FV=XFeokpbMUFjAc0OkwJ97vR8aB+4GbnFxRKymvpEY3gnA@mail.gmail.com>
 <aErcrCKcsi9cpANY@pathway.suse.cz>
In-Reply-To: <aErcrCKcsi9cpANY@pathway.suse.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 12 Jun 2025 16:16:09 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
X-Gm-Features: AX0GCFujYjZY5QQA0SHYIPZy8d0O0rad7ID3hPYo1lls7-hp2LxFCT3Du9JnL2k
Message-ID: <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
Subject: Re: [PATCH 4/7] drivers: serial: kgdboc: Check CON_SUSPENDED instead
 of CON_ENABLED
To: Petr Mladek <pmladek@suse.com>
Cc: Marcos Paulo de Souza <mpdesouza@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
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

On Thu, Jun 12, 2025 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(char
> > > > > *opt)
> > > > >         console_list_lock();
> > > > >         for_each_console(con) {
> > > > >                 if (con->write && con->read &&
> > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &&
> > > > > +                   (con->flags & CON_BOOT) &&
> > > > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &&
> > > >
> > > > I haven't tried running the code, so I could easily be mistaken,
> > > > but...
> > > >
> > > > ...the above doesn't seem like the correct conversion. The old
> > > > expression was:
> > > >
> > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > >
> > > > That would evaluate to non-zero (true) if the console was _either_
> > > > "boot" or "enabled".
> > > >
> > > > The new expression is is:
> > > >
> > > > (con->flags & CON_BOOT) && ((con->flags & CON_SUSPENDED) =3D=3D 0)
> > > >
> > > > That's only true if the console is _both_ "boot" and "not suspended=
".
> > >
> > > My idea here was that the users of for_each_console would find the
> > > first available console, and by available I would expect them to be
> > > usable. In this case, is there any value for kgdboc to use a console
> > > that is suspended? Would it work in this case?
> > >
> > > I never really used kgdboc, but only checking if the console was
> > > enabled (which it's always the case here) was something that needed t=
o
> > > be fixed.
> > >
> > > Maybe I'm missing something here as well, so please let me know if I
> > > should remove the new check.
> >
> > So it's been 5 years since I wrote the code, but reading that I was
> > checking for:
> >
> >   (con->flags & (CON_BOOT | CON_ENABLED))
> >
> > Makes me believe that this was the case when I wrote the code:
> > 1. Early boot consoles (earlycon) were not marked as CON_ENABLED but
> > were instead marked as CON_BOOT.
> > 2. Once consoles became non-early they were moved to CON_ENABLED.
> >
> > ...and the code was basically looking for any consoles with a matching
> > name that were either boot consoles or normal/enabled consoles.
> >
> > Is that a plausible theory? It's also possible that I just was
> > confused when I code things up and that I really meant to write:
>
> It is easy to get confused by the register_console() code. And
> it has been even worse some years ago.
>
> Anyway, the current code sets CON_ENABLED for all registered
> consoles, including CON_BOOT consoles. The flag is cleared only
> by console_suspend()[*] or unregister_console().
>
> IMHO, kgdboc_earlycon_init() does not need to care about
> console_suspend() because the kernel could not be suspended
> during boot. Does this makes sense?

Yeah, makes sense to me.


> Also it does not need to care about unregister_console() because
> the unregistered console won't be listed by for_each_console().
>
> [*] The 1st patch in this patchset updates console_suspend()
>     to set CON_SUSPENDED instead of clearing CON_ENABLED.
>     It helps to make it clear that it is suspend-related.
>
>
> Resume:
>
> I would remove the check of CON_ENABLED or CON_SUSPENDED
> from kgdboc_earlycon_init() completely.
>
> IMHO, we should keep the check of CON_BOOT because we do not
> want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> It is later removed by kgdboc_earlycon_deinit(). I guess
> that the code is not ready to handle a takeover from normal
> to normal (even the same) console driver.

I'm not sure I understand your last sentence there. In general the
code handling all of the possible handoff (or lack of handoff) cases
between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
point I thought through it all and tried to test as many scenarios as
I could and I seem to remember trying to model some of the behavior on
how earlycon worked. If something looks broken here then let me know.


> To make it clear, I would use:
>
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (con->flags & CON_BOOT) &&
>                     (!opt || !opt[0] || strcmp(con->name, opt) =3D=3D 0))
>                         break;
>         }
>
> And I would do this change as the 1st patch in the patchset
> before we change the flag modified by console_suspend().

Seems OK to me.

-Doug
