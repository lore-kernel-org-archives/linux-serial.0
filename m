Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF81214223
	for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833075; cv=none; b=a8AGGIUxFx2bmDHkaqUu8PPWNNX96ZWw0JabZiItwVnquOmaXWEpxBkVd8YMQwbB/dAiDBwNHkqZrKthh4nH/JEEVnSJG7SwAVy0HE2VDdL/6u9JoMyBzcp1TO7k6yoqNfYGtVVvVMLEbGIQPdfK4YJFPcIRvkAZ9NZhoVMGk98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833075; c=relaxed/simple;
	bh=xfwOxsDgYunx//JZHasoSCroD3+r4OvjrSj4RQ3NaR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qtCfw5gL1afbzGBMtky21n4bDhVM/tKcw+6aAkgIDdjRYDeS0sTMCHbl8DGXAaH/wVcIOEAsSjIBSLTX968h50jhWTMPZdK0Ck26jRfWwkYUeBZoGdgMwQDOYqjESKL0jJbzWnQqraekF5L+0gzU0Upo1aJ59w41956xdFjmzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YC+R8j3N; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YC+R8j3N"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747fba9f962so2116762b3a.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 09:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1749833071; x=1750437871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oFsHs2L6+8EBoJ/ILRzyWwmWoJe5zrU0k/YrygGMeNA=;
        b=YC+R8j3NF8nZ74DBbo2H4YE/g6+wREQVqpk7Ksfw+IbQpMDrk7+qr4bEHB7Zwib/09
         7HT7QNfpqhN20tltPqld5knkYk9+3tG+kFpKxp8Zq1zvPKJEvg7SORggAk8v8rJYLiM8
         0yEl+y7XQC+bYRE4T8yxbr9khIh9YSkpilKV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749833071; x=1750437871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oFsHs2L6+8EBoJ/ILRzyWwmWoJe5zrU0k/YrygGMeNA=;
        b=UaiDKQudSGATrkt2Fmq0lE35K/huaakMKcgsrXWEPDUCtN7t/X98ZOFLdqFHw4/LM7
         CObj+tBmq+L3m7cRVd6wgUduu0sS8KKU8Cebl2vtZZ7+tO8BLYnCvdF25cfDGU3MSVgd
         JpvGekJXHgVYYJ1xIleBrbz6BDO08LMrsJVRMfYtzT8AJNRYW2mh/QAAh5gEdBP4TdBM
         bbBxlfJevPE3Ocqt1keqsBwiaUErj1fD3nGTSvs7Fa7iz4EQADmaxFoPSkFTG8wQ+p86
         uMpln1Avw3xvXQBqf6qoLDOtntKAxBrEjDw20HpTHgtlLl6NjEyuQvXTOV8DTt1nLhb1
         90Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVcfVwPx2ePSVZlB5tPfwhnZsTi/pTSXCcadtkIvYsyF+goqaA5BYYeK1nz2RzycjJvyA76C65gukJNeg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+g98gPzzeg5zPvRJzkpkQjs8LHeLXPf9OtxgTNnqGjLRYO4eV
	Y8fRZ/boUnl7zkkDZQqnpKSs5xMRmrhXLZtDu+lA/48AL6ZEbY1rtj3DRtx4OwErQcHnwYpH94/
	vdeg=
X-Gm-Gg: ASbGnctimZ8jmFFYwFg7edmN9AVY0tSFp1+hSq3zy0v8llO9erY91w4v7yubGMoF+fy
	1nzzAzbnh0mlZu6UN17z6zKV0ew+5MKPOw4ff8xxu5ycubnU3OaANHlsRJAJb9WarNrCUuYSCdt
	YPMKSpsA42M6xNoipdjLYOErmRHue+XhZGtW2DWSh7RPLOQcCEwkY1ybAfGzjTfAhv2dcgn8gTj
	a523JYJJHP88ViEhjuAQrG/mX3/VqZjSSPl7Z/5xxNtKeGGiFW3oslMhlh6lOw75V64EOXRpaDv
	AuNWmtjP3QnAsx2y56PArUIwdjyV4reEGj5YiBA9jsG2ekH+z3O0xfpgQpdjXDpXLxOhnXtTWSF
	iBJGCQ93gYPAIIPNpOTV/qHyfKTLytQ==
X-Google-Smtp-Source: AGHT+IF+F59PBLCOU4Bdae0pnGcOPenqtCWLKnRt0EH6V/BEogAUD3W6Mu69fb5tECA+IztdddX0Pg==
X-Received: by 2002:a05:6a00:b8b:b0:748:6a12:1b47 with SMTP id d2e1a72fcca58-7489c47e470mr458785b3a.10.1749833071283;
        Fri, 13 Jun 2025 09:44:31 -0700 (PDT)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com. [209.85.214.174])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890005f55sm1877256b3a.56.2025.06.13.09.44.29
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jun 2025 09:44:30 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2363e973db1so29179855ad.0
        for <linux-serial@vger.kernel.org>; Fri, 13 Jun 2025 09:44:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX9J+nd4ZG/zIbg4+GHEC/5xgIlPu2P60AUXYSkMWhkNG6fDVguDlZ4nXHM4DOru1I2/gnGzL6e/zQcYPk=@vger.kernel.org
X-Received: by 2002:a17:902:fc84:b0:234:9fe1:8fc6 with SMTP id
 d9443c01a7336-236678a6caamr20933585ad.18.1749833069252; Fri, 13 Jun 2025
 09:44:29 -0700 (PDT)
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
 <aErcrCKcsi9cpANY@pathway.suse.cz> <CAD=FV=WFWviPPR6VWmsN2-+vzRDoU6oTNH=EP6z1usG4EDR3+w@mail.gmail.com>
 <aEwC81RhvveGP73Y@pathway.suse.cz>
In-Reply-To: <aEwC81RhvveGP73Y@pathway.suse.cz>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 13 Jun 2025 09:44:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XwJ8b2Qd52dUG7DrbkVz2XdjCgXoThh2i3gi=+vGqFAw@mail.gmail.com>
X-Gm-Features: AX0GCFsbz4DtEeKeZs4XLMlp6WpvZqtedSANACGhbS0pNgSY94ZUMPk-yfpPG_M
Message-ID: <CAD=FV=XwJ8b2Qd52dUG7DrbkVz2XdjCgXoThh2i3gi=+vGqFAw@mail.gmail.com>
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

On Fri, Jun 13, 2025 at 3:52=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Thu 2025-06-12 16:16:09, Doug Anderson wrote:
> > Hi,
> >
> > On Thu, Jun 12, 2025 at 6:57=E2=80=AFAM Petr Mladek <pmladek@suse.com> =
wrote:
> > >
> > > > > > > @@ -577,7 +577,8 @@ static int __init kgdboc_earlycon_init(ch=
ar
> > > > > > > *opt)
> > > > > > >         console_list_lock();
> > > > > > >         for_each_console(con) {
> > > > > > >                 if (con->write && con->read &&
> > > > > > > -                   (con->flags & (CON_BOOT | CON_ENABLED)) &=
&
> > > > > > > +                   (con->flags & CON_BOOT) &&
> > > > > > > +                   ((con->flags & CON_SUSPENDED) =3D=3D 0) &=
&
> > > > > >
> > > > > > I haven't tried running the code, so I could easily be mistaken=
,
> > > > > > but...
> > > > > >
> > > > > > ...the above doesn't seem like the correct conversion. The old
> > > > > > expression was:
> > > > > >
> > > > > > (con->flags & (CON_BOOT | CON_ENABLED))
> > > > > >
> > > It is easy to get confused by the register_console() code. And
> > > it has been even worse some years ago.
> > >
> > > Anyway, the current code sets CON_ENABLED for all registered
> > > consoles, including CON_BOOT consoles. The flag is cleared only
> > > by console_suspend()[*] or unregister_console().
> > >
> > > IMHO, kgdboc_earlycon_init() does not need to care about
> > > console_suspend() because the kernel could not be suspended
> > > during boot. Does this makes sense?
> >
> > Yeah, makes sense to me.
> >
> > > Resume:
> > >
> > > I would remove the check of CON_ENABLED or CON_SUSPENDED
> > > from kgdboc_earlycon_init() completely.
> > >
> > > IMHO, we should keep the check of CON_BOOT because we do not
> > > want to register "normal" console drivers as kgdboc_earlycon_io_ops.
> > > It is later removed by kgdboc_earlycon_deinit(). I guess
> > > that the code is not ready to handle a takeover from normal
> > > to normal (even the same) console driver.
> >
> > I'm not sure I understand your last sentence there. In general the
> > code handling all of the possible handoff (or lack of handoff) cases
> > between kgdboc_earlycon and regular kgdboc is pretty wacky. At one
> > point I thought through it all and tried to test as many scenarios as
> > I could and I seem to remember trying to model some of the behavior on
> > how earlycon worked. If something looks broken here then let me know.
>
> Later update: The code is safe. The scenario below does not exist,
>               see the "WAIT:" section below.
>
>
> I am not familiar with the kgdb init code. I thought about the
> following scenario:
>
> 1. kgdboc_earlycon_init() registers some struct console via
>
>         kgdboc_earlycon_io_ops.cons =3D con;
>         pr_info("Going to register kgdb with earlycon '%s'\n", con->name)=
;
>         if (kgdb_register_io_module(&kgdboc_earlycon_io_ops) !=3D 0) {
>
>    and sets
>
>                 earlycon_orig_exit =3D con->exit;
>                 con->exit =3D kgdboc_earlycon_deferred_exit;
>
>
> 2. Later, configure_kgdboc() would find some "preferred" console
>    and register it via
>
>         for_each_console_srcu(cons) {
>                 int idx;
>                 if (cons->device && cons->device(cons, &idx) =3D=3D p &&
>                     idx =3D=3D tty_line) {
>                         kgdboc_io_ops.cons =3D cons;
> [...]
>         err =3D kgdb_register_io_module(&kgdboc_io_ops);
>
>    , where kgdb_register_io_module would call deinit for the
>    previously registered kgdboc_earlycon_io_ops:
>
>         if (old_dbg_io_ops) {
>                 old_dbg_io_ops->deinit();
>                 return 0;
>         }
>
>    , where kgdboc_earlycon_deinit() might call the .exit() callback
>
>                 kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.=
cons);
>
>
> BANG: If both "kgdboc_earlycon_io_ops" and "kgdboc_io_ops" pointed to
>       the same struct console then this might call .exit() callback
>       for a console which is still being used.
>
>       But I am wrong, see below.
>
> WAIT:
>
> I have got all the pieces together when writing this mail).
> I see that the code is safe, namely:
>
> static void kgdboc_earlycon_deinit(void)
> {
>         if (!kgdboc_earlycon_io_ops.cons)
>                 return;
>
>         if (kgdboc_earlycon_io_ops.cons->exit =3D=3D kgdboc_earlycon_defe=
rred_exit)
>                 /*
>                  * kgdboc_earlycon is exiting but original boot console e=
xit
>                  * was never called (AKA kgdboc_earlycon_deferred_exit()
>                  * didn't ever run).  Undo our trap.
>                  */
>                 kgdboc_earlycon_io_ops.cons->exit =3D earlycon_orig_exit;
>         else if (kgdboc_earlycon_io_ops.cons->exit)
>                 /*
>                  * We skipped calling the exit() routine so we could try =
to
>                  * keep using the boot console even after it went away.  =
We're
>                  * finally done so call the function now.
>                  */
>                 kgdboc_earlycon_io_ops.cons->exit(kgdboc_earlycon_io_ops.=
cons);
>
>         kgdboc_earlycon_io_ops.cons =3D NULL;
> }
>
> It calls kgdboc_earlycon_io_ops.cons->exit() only when
> unregister_console() tried to call the original con->exit()
> which was reassigned to kgdboc_earlycon_deferred_exit()...
>
> Updated resume:
>
> It looks to me that even normal console can be used by
> kgdboc_earlycon_io_ops and we could remove even the check
> of the CON_BOOT flag.
>
> My expectation:
>
> If a "struct console" is registered then the driver is used
> by printk() and it should be safe even for kgdboc_earlycon,
> as long as it has both "con->write" and "con->read" callbacks.
>
> So the check in kgdboc_earlycon_init() might be:
>
>         for_each_console(con) {
>                 if (con->write && con->read &&
>                     (!opt || !opt[0] || strcmp(con->name, opt) =3D=3D 0))
>                         break;
>         }
>
> Heh, I hope that you were able to follow my thoughts and I did not
> create even bigger confusion.

I didn't go back to the code and trace through every step you made,
but it sounds like the code looks OK even if it's a bit convoluted
(sorry about that! at least it's commented!).

I agree with your final suggestion for the check. That has the side
effect of also being less of a change from what we had before. Because
of how the code was written before, it would have allowed any console
because it checked for "enabled or boot" and all consoles were
enabled. So just getting rid of the check for flags seems reasonable
to me.

-Doug
