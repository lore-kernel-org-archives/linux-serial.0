Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19D522540A;
	Wed, 26 Feb 2025 19:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740597780; cv=none; b=I14PnW5qwjdUH5/cSB/N/WOCHnPejEvuETMGdW+3Re8kHWTI9K0mSnXc5a4OYDHtLxSmY84l4q5ulbXhF68P3ie/QBMqqLrkOMkCFb1jWM3sS2Hv+ULJUMfjeawJHSmi/WboqpTdM30yoFxULSAy6Ib/PcV5Ebu73lOfOItHm8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740597780; c=relaxed/simple;
	bh=V/mmqmDUXBV/WNhpZpAYGI7TJI5eQO/qS6T/SI0kdMU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lL66zvnclH8D1q93KOBFIlNEsN7DwpjGnWoyFMCl1rqgjgm4WQX8KwT2gk+TTyrdbrgwuvroF0hj70og1UQ0CZTVvzxymqCSBowkHlYxLsWrfpXu4nL+lSlFYqL1bm6OfWa54AwXuifqtAwkZHcgBAI1BKPPKW8Zu3Yj30epaAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6iAvy2p; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6iAvy2p"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e04f2b1685so85483a12.0;
        Wed, 26 Feb 2025 11:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740597777; x=1741202577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9RsHlNSqS5MkkVEupmlknbkQ54jFXc5YczNH1s4hNAU=;
        b=U6iAvy2pJIL/0hIfB4YBuZXzNa0proSRzSI6Xl4q3pcjp2liQI8uASXGQZklPk7ALM
         CVWuUMJ1Wxc7WGZcOz5q4brCAKOaLNFZpXUTilqp/8xFfKZ9SyDgIfxmpBRS6wm1ak6Q
         k9YFU1C/NPqa5+J3tYmihya1zP4w9no1IH7q4OigNX+bxY2l2TlS8Eff7fwQmX5nl46p
         E57Q5k2tn7ZXcSarrh/IrIgXduDtJ06zYVLz7KAk+nm4BN98fXMoN4io8aeT6yMUH6qP
         a3p6bSG7UC9cBxpNLQ+YNOrPxkr3I6L08P2pgC1QUEA8MgRMsYJPLcHxaTsL3ji7iHNc
         Kfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740597777; x=1741202577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9RsHlNSqS5MkkVEupmlknbkQ54jFXc5YczNH1s4hNAU=;
        b=ErELgsS6DJG7CGMyB0kCbXXGtyAvwGVH8fU+5GnRGkA2732tl7Kciaq+FXNs0C4IkF
         k/Ac2G7TJFKAAJkFe/AvwIXi7yGC7AXJmK76PUW1pFpvQjK0mDzxfcfGjDtYDcY4gFCr
         FX1zkGNTGrktuILGW82ofcGPVt5d2BruNZDzZK7Abatb9ac/4NdizeoB+O+3Uvc+7LYv
         NSsQGRuSYx/jxA0rKdB0saSu2fe1TBPIoi0xNdzDWEXcIGC80jVUSXm0mt0ogcJ8NBCd
         E+6KyMBjoe6Yeoih4Xk0dqLonLV2wOWR7ffKvw2a3BZgClIpo+mrilVpnFQ7DDkqvj/P
         knfA==
X-Forwarded-Encrypted: i=1; AJvYcCV+gQtsu0O1tNGhVOY+tVIMfciGKsDWAEdc2Z+LU+Cwm4cjThd3NiaWDlVgggm+4jOudmnZ3QEkweKmZoU=@vger.kernel.org, AJvYcCVjAtkccSojfbgC45K2BfdfqBcraILl5z/5UJ8snsmHGxLEYES1KGC6U5a85lKKFfw9LWyLItaBU+X7jUvI@vger.kernel.org
X-Gm-Message-State: AOJu0YzWndVK1tm8zK0ZaHDTNko2VXLfMp6mywenW0zDAEDM1+N4eKYa
	8d8y2BX3i7cwQat2ElbhMrt4v1odcCF9Zcxagu+f1zxHWNThPAIxkQFqLuMlCAmyHVDLUHsD5wz
	a0Rq1rsZTlFZM50ieel/gd/PAfSY=
X-Gm-Gg: ASbGncsZFh5J49G6NR0m3q3tCWEUiCwv2WVYcIo/VhwMR7n0rMhJjgQ7ESHGgMgrcbH
	Q6L3a4ik9YLQosrecGS0F+fLPqUUMp3qXQ+cDkR0T+P9H5LDtA2e7lb4lLYupRxYC3oKozsDpJa
	1rMJ4SpUdwDA==
X-Google-Smtp-Source: AGHT+IHQ8ZFD5JfXR2fesrEAGair6UTQZEjsQtjsJB1JeIUqbAEuXpCUSdJpZP4Rve5rO8yUb0/8Kisq7HPOXEizwSA=
X-Received: by 2002:a05:6402:2113:b0:5dc:80ba:dda1 with SMTP id
 4fb4d7f45d1cf-5e4457abb93mr20924895a12.9.1740597777056; Wed, 26 Feb 2025
 11:22:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224123915.2859682-1-adamsimonelli@gmail.com>
 <20250224123915.2859682-2-adamsimonelli@gmail.com> <Z73teICMWNx7BiHT@pathway.suse.cz>
 <10194425.EvYhyI6sBW@nerdopolis2>
In-Reply-To: <10194425.EvYhyI6sBW@nerdopolis2>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 26 Feb 2025 21:22:20 +0200
X-Gm-Features: AQ5f1JqE-10IPSQGRUnH7pmW7kd9wzDQqE0a8tBy_gw2DMMkxsKIiWqLf3i_qsM
Message-ID: <CAHp75Vdr1yNamVMP12X2bZs5=PL=R+Lsio5b+ba_NaPOsvzobA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ttynull: Add an option to allow ttynull to be used
 as a console device
To: Adam Simonelli <adamsimonelli@gmail.com>
Cc: Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>, Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 3:39=E2=80=AFPM Adam Simonelli <adamsimonelli@gmail=
.com> wrote:
> On Tuesday, February 25, 2025 11:19:04 AM EST Petr Mladek wrote:

...

> > My proposal is to call:
> >
> > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> >       add_preferred_console("ttynull", 0, NULL);
> > #endif
> >
> > somewhere in the kernel code. The question is where.
> > I wonder if the following would work:
> >
>
> > #ifdef CONFIG_NULL_TTY_DEFAULT_CONSOLE
> > static int __init ttynull_default_console(void)
> > {
> >       add_preferred_console("ttynull", 0, NULL);
> >       return 0;
> > }
> > console_initcall(ttynull_register);
> > #endif
> >
> OK, actually in earlier revisions locally, I did actually have
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index dddb15f48d59..c1554a789de8 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3712,6 +3712,11 @@ void __init console_init(void)
>         initcall_t call;
>         initcall_entry_t *ce;
>
> +#ifdef CONFIG_NULL_TTY_CONSOLE
> +       if (!strstr(boot_command_line, "console=3D"))

Just a side note: strstr() is fragile as theoretically "console=3D" can
be part of an argument unrelated to the console, like
foo=3D"bar,baz,console=3D10,key=3Dvalue". Although I haven't checked if thi=
s
is allowed by cmdline parser (lib/cmdline.c).

> +               add_preferred_console("ttynull", 0, NULL);
> +#endif
> +
>         /* Setup the default TTY line discipline. */
>         n_tty_init();
>
>
>
> Which worked as far as I could tell, at least on x86. Not sure if that wa=
s the
> right place, and yeah, I was trying to better copy how CONFIG_VT_CONSOLE =
worked
> because I thought that was more correct.

--=20
With Best Regards,
Andy Shevchenko
