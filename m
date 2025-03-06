Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C181A5BB5;
	Thu,  6 Mar 2025 07:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741245070; cv=none; b=ue7uHwolOFkC/RAJryJ4XKddapVK3qPPewG5rhWf6quvOShyfN76U8sriwGPGw3jGqJwQka6e7FWr99lPwmexry86EZc9xIOFrUjoKL2EnFLCbNXjofZ1KPp6vH2nIGiSCBmuKr+SXhkzoktOhrN/TDd7DjkiVaPoXBP7z08eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741245070; c=relaxed/simple;
	bh=xN0GSgo1YgrQ84SnN1b56MUMz5jIvfTrI3SY/kuEBRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eQUThN0o9US/qDAGEJB6tREAkZU0RMagzTPF6e8GzF3RLpYYEwy9K6HiVE2tIdFmEmBb8DBvUH2EPQ/WA9kk5p5tA8hcvVg0kJbIibmjwg+5IYW/L6LVjhUlkKmWjJsJ/WSEs3ca1Lw+Fp/e2IBY1qZ05Ual2f5fLDQSeqTMiBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F8XyFjF4; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8XyFjF4"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac202264f9cso59264266b.0;
        Wed, 05 Mar 2025 23:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741245066; x=1741849866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eq1N4bGBvJPpN/I5LSt/1X49Dltjy7IGKVFQlpiMSBE=;
        b=F8XyFjF4VtFA97UkJnYTKGICrWR80aPq3Gtt8smyJ+os8yI0eheA+N9I5071qSeeUe
         loG2q7N7E+kY2OQoY4/1dJaOFRtRFdgzKiUnMbU+L0Ir/mptkz4zyNBP1kAGO7UPeMRG
         r55sMr/8C/rpo5dpdapqegypWARy75bb7rZZZNwD1F8xlFDC/6kdlInw7tRx2UlexrVI
         Pr5a0e75MeRhusr6gZkX3J85hic/xKSR8KRtMF8n13d0hZK4j6yy8bUTTPEcWCMKL3kS
         nRyFlawu5+861cm/xr+dKwabv9XWfcilhGneIjkCyU7qRKujbxDMVSYqumk6H7sHKXfA
         5N+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741245066; x=1741849866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eq1N4bGBvJPpN/I5LSt/1X49Dltjy7IGKVFQlpiMSBE=;
        b=aNYP4STKsqLPDbZQi1vS5zNKQqORaNsq+a7sn5/DQMZdzNlbZSBcPtcQ50S4vbiEpy
         9Vu/DaDaZBt2sOmghv2ypxBR8AqLsdUlfAJdXQ2mRAUbbWTE7II/AAUTyiccRhYlVgY/
         kMtmiKUvtt1b9IDdYCjr8oo5xpK7Z38aXq8l2+PJ5vN4fsRpTbqBVhfDzT/8vos6M7xO
         tSAog+Tzoj+/0oM5tPPDfPZdxXASTLoTnCC5v8ziU4MlA0fCt2lf9OGTJRUum2qFhIjs
         QthYNcwmQ11Lo7yVlGX71PB+bCR99EbI1MTpK2E78x0uK43e+hyIjoD/djwdcoZdFbvB
         nr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWaepUHYWrl8yxJWFXiS5xlyAufDQ2YnmuN+l6G6FGIf5TRUjC0fgcg0W3Dv3CT626hjYFvzfifrfd/vHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7y7+2MHBSR2QaTJoMFLVAMmFy7nX6vNWACfCJjS7DR3wBzZlY
	3/wrsXayFhuhsQVZQBuWlozrmRQiOYgmex9ecpXeWj9lzWdA6GM5JLv6iMzU1YSKMFY/tdmnOPh
	A6DsnKWjGTYNiKYqGtA+QInLindM=
X-Gm-Gg: ASbGnctvd9aEvUgFwJkvQkHO1TR1625kyF3l8QLsZmuSlL5Z+QCFwxVq850Z24eev8A
	XSDaOlbmLHfAw6WCKKhPJznJkZ5PoJVx5jOGm6Cy86XsvtkkxuZhmREHIbXY9Tt2qzaK0mo7JPG
	zFFukb+JpF6B6nUNOpl96kV3zzlw==
X-Google-Smtp-Source: AGHT+IFsFFd0j9Nf6TtQ26FR2dBi3ZDy5r4JM229KJ++sWK2cR1afB18UmXezAYMjkZDOPQ3/RT7d/rbS5d+t+ddxVc=
X-Received: by 2002:a17:907:d092:b0:abf:56e3:e88b with SMTP id
 a640c23a62f3a-ac20e152abdmr549115066b.38.1741245065891; Wed, 05 Mar 2025
 23:11:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304035447.3138221-1-adamsimonelli@gmail.com>
 <7969025.Sb9uPGUboI@nerdopolis2> <CAHp75VfadXS8Z2G6U_DcOOZFFmaOSn_9uQN_N7Psse3kiSGj0g@mail.gmail.com>
 <4451040.8hb0ThOEGa@nerdopolis2>
In-Reply-To: <4451040.8hb0ThOEGa@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 6 Mar 2025 09:10:29 +0200
X-Gm-Features: AQ5f1JogMmQH0eE_du27Z5fWg-tESulb8jPOXXKpWslA7vl3W4sc_8S8SYErBKo
Message-ID: <CAHp75VdogqwA2qJBp5Sp-tuJbKvmj9mLuop8GZP+vLVeJNg2DQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 6:22=E2=80=AFAM Adam Simonelli <adamsimonelli@gmail.=
com> wrote:
>
> On Wednesday, March 5, 2025 1:52:00 PM EST Andy Shevchenko wrote:
> > On Wed, Mar 5, 2025 at 4:06=E2=80=AFAM Adam Simonelli <adamsimonelli@gm=
ail.com> wrote:
> > > On Tuesday, March 4, 2025 1:51:52 AM EST Andy Shevchenko wrote:
> > > > On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wr=
ote:

...

> > > > >  obj-y                          +=3D vt/
> > > >
> > > > + blank line.
> > > >
> > > > > +# If ttynull is configured to be a console by default, ensure th=
at it is linked
> > > > > +# earlier before a real one is selected.
> > > > > +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> > > > > +                               +=3D ttynull.o
> > > >
> > > > Here is the question: are you sure that all console drivers that ex=
ist
> > > > in the kernel happen to be here? Have you grepped the source tree f=
or
> > > > checking this?
> > > >
> > > Grepping for console_initcall, the only other places I see outside of
> > > drivers/tty/ is
> > >
> > > arch/mips/fw/arc/arc_con.c
> > > arch/mips/sibyte/common/cfe_console.c
> > > arch/powerpc/kernel/legacy_serial.c
> > > arch/powerpc/kernel/udbg.c
> > > arch/powerpc/platforms/powermac/setup.c
> > > arch/um/drivers/stderr_console.c
> > > arch/xtensa/platforms/iss/console.c
> > > drivers/s390/char/con3215.c
> > > drivers/s390/char/con3270.c
> > > drivers/s390/char/sclp_con.c
> > > drivers/s390/char/sclp_vt220.c
> >
> > Which means you need to test your stuff on those cases, to see how the
> > linker order is done there. It might be that your change wouldn't work
> > there as expected (quick workaround is to mark the new option as
> > depends on !S390 && !PPC and so on.

> It will be difficult to test other arches, I mean I guess it is possible =
with
> QEMU, and cross-building, though I did do an experimental test on x86:
>
> Making it temporarily adding an architecture specific console like
> powerpc/some mips/s390/arches with Xen enabled.

Thanks. Make sure the summary of this gets into the commit message.
Also consider updating the relevant documentation under
Documentation/, if any.

> -------------------------------------------------------------------------=
------
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index 05c5aa951da7..bcd248c44fc8 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1159,6 +1159,8 @@ void __init setup_arch(char **cmdline_p)
>
>         e820__setup_pci_gap();
>
> +       add_preferred_console("ttyS", 0, NULL);
> +
>  #ifdef CONFIG_VT
>  #if defined(CONFIG_VGA_CONSOLE)
>         if (!efi_enabled(EFI_BOOT) || (efi_mem_type(0xa0000) !=3D EFI_CON=
VENTIONAL_MEMORY))
> -------------------------------------------------------------------------=
------
>
> to see what /proc/consoles will look like, to pretend that x86 is an arch=
 that
> sets a console somewhere, and I get:
>
> ttynull0             --- (EC    )  242:0
> ttyS0                -W- (E  p a)    4:64
>
> and I got console messages to ttyS0 with no issue.
>
> which in my mind is acceptable I would think. ttynull is first in the lis=
t,
> which is desired effect of CONFIG_NULL_TTY_DEFAULT_CONSOLE, it doesn't ha=
ve to
> be _exclusive_ AFAIK, especially if there are long-time default consoles =
that.
> users or the hardware expects.
>
>
> The only arch that seems to _unconditionally_ add a console without some =
other
> circumstance, like boot loader env var, and command line option, or firmw=
are
> flag, or suboption (like CONFIG_SERIAL_PMACZILOG_CONSOLE) is Jazz.
>
> Like platforms/powernv adds it if CONFIG_HVC_OPAL is disabled, or the fir=
mware
> is missing "FW_FEATURE_OPAL". I would assume that a user of this situatio=
n
> turning on CONFIG_NULL_TTY_DEFAULT_CONSOLE in addition, will just get tty=
null
> and hvc in /proc/consoles instead of just hvc. Could that cause something=
 to
> break?

> Correct me if I am wrong, I could very very very well be wrong.

I leave this to Petr to comment as I'm not that expert in the area.

--=20
With Best Regards,
Andy Shevchenko
