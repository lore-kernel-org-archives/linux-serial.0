Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488FF13C67C;
	Tue,  4 Mar 2025 06:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741071151; cv=none; b=bG4OZPgbAzuEG3HXrSIeR/PxJVt6L5JKaSY/RbhuQ/uXY8B10g/DbpwzoRZwsSzXYtdZNtN6aMCJSY4z8J3DYxxGXvtLssQjd/M/EfKUksLpczoVmbSLylRZJ6X5Kra5Oa8XCvdtFz17oUMaNfNejnI/C0+VAMuLHusTwMdGDPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741071151; c=relaxed/simple;
	bh=uCJH4LgvbpYu+bgfhR7Xd1uT5mKWrAQGIbTGlA28vZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRO44CV+SJ+wz+5vQpN6pq3k5NJtWKLwQonD6MQRPBruvLYy9bNRfY1+OH9vUeh0gN4eJy0U8T7Q5vxgQF6R/UxS+BflVA950skEr/wanetpZvCOfGWynVZsth/IIqNGQiu4/ZNQnJrs74KFTLg3PYVMHGYCjKW+fZKa9FH7SMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HqOox4c1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqOox4c1"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e033c2f106so6079963a12.3;
        Mon, 03 Mar 2025 22:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741071148; x=1741675948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7gqvPATBpXryjGxb/fOnenuIg3PJ2BiF+tgAUytlmv4=;
        b=HqOox4c1+YlrvKSJ0f7ZaaDDH4VrBQlOG8ocMxtKu7nsySICayPoxHKslXLSLKxUxc
         COyvFkRgYBxJTFHNjAAyaXMx9E+PGQxeS9C5HQ43hl0oynUwJ3LPNqGptN8UFQbFkvik
         Ipw3kkARZhCEPkfau3FR9momvI4h7IQRCsjDx7C+i8j9oibyVkvWaS5dpVIuVgmfIGjD
         kwJF9nBTY+uDJJF0HtewQtU7A7MD7lCqq60q0dC9S0b1pyyDnHZDyhUvRaL1WyhYW6MA
         cYi0cqTBHWajYCyY3JbqETnsYdjLP4SboOqqiuJaPpJvhaaMnMnckrLehejh71u6WgRa
         1r1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741071148; x=1741675948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7gqvPATBpXryjGxb/fOnenuIg3PJ2BiF+tgAUytlmv4=;
        b=GAsaTgTXbhEbTlVDO4j+rREyQ1hzHkAayNi4B4ZXzsVvivSUzUYFi5ZzhWo9avtw7h
         WvVa6xuEnZryMw9s6Lph/N1l2FI61hP4dUiezfqPXhj8PxhZ4zYI3sowm4n4xZLeGQ+O
         meePRwD2mmFrz2OBY7IqpHGQOKqTDW5ivjl8cAiBns/pQQyNRmndp/a7iwu5CtxPzYDC
         FnMPRDAvSk6u6KFga+oXeWoIymhdo1UYYG3JwO0Uj2FvP4a6iD/H3bD3xSs4cYdGptOt
         pdbJXZnhmgJRVIpIO8D6/QYe3hak509kUB989i44RLtNwShOTxOvkpvp7+GEYY1M1f/K
         0dqw==
X-Forwarded-Encrypted: i=1; AJvYcCV8TXl4A32QjIuV9rKF6a+MUeiMoD8046Z3Wk+VTpyCfJ+NQlJ6W3+YuOw7juUxi62OLwM2x4cnIUNhbuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhDX27Ir1Doy3I5ID1v6t0dCgrkY2GQVML/VpYb+P6c+eWqhhT
	9VCib4/FEUtXH0KgzeIrz+JwkZj/R4IjHxRow5y/4tzF6mkyzHTox4c5cu9gwRLfHhvJNXMEiLe
	B+fhaMJMsAmGAGnkX4Aqql/StMVk=
X-Gm-Gg: ASbGncuIWExX3xr9C685zvqRDbYEXOT3AEqKLHWrndymrp3N1prGELol2P70FUbdHcg
	n945b8qwOHtv4n9QtCVftpTwKZIik53aDuMo1tDTyS5nyMTtbTZqdCUTndgWxDivB94nGecLtuv
	QT8Qlzj5AsJmttfxt+tSmJB1PVxw==
X-Google-Smtp-Source: AGHT+IEoEgoewhNzbrocvPAgQEJRFCpSWbb0viTio+R2IaeI6ydmAhu05tIqy0cYx2sId9e5nBM5ugzJxlTNtDSCyPM=
X-Received: by 2002:a05:6402:1d4a:b0:5de:dfde:c8b1 with SMTP id
 4fb4d7f45d1cf-5e4d6ac536emr37983231a12.4.1741071148207; Mon, 03 Mar 2025
 22:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304035447.3138221-1-adamsimonelli@gmail.com> <20250304035447.3138221-4-adamsimonelli@gmail.com>
In-Reply-To: <20250304035447.3138221-4-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 4 Mar 2025 08:51:52 +0200
X-Gm-Features: AQ5f1JrjwVMGYuo4mncDNMG2zmDdlxKpJ9E0m4MaDvLRULtrFcJaHkUZADWwYh0
Message-ID: <CAHp75VftQASqajiG_z-==CmVMu5Orv_Q8QMj-7W=sxsJPq6bJw@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 5:55=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
>
> From: Adam Simonelli <adamsimonelli@gmail.com>
>
> If CONFIG_NULL_TTY_DEFAULT_CONSOLE is enabled, and CONFIG_VT is disabled,
> ttynull will become the default primary console device, based on the link
> order.
>
> Many distributions ship with CONFIG_VT enabled. On tested desktop hardwar=
e
> if CONFIG_VT is disabled, the default console device falls back to
> /dev/ttyS0 instead of /dev/tty.
>
> This could cause issues in user space, and hardware problems:
>
> 1. The user space issues include the case where  /dev/ttyS0 is
> disconnected, and the TCGETS ioctl, which some user space libraries use
> as a probe to determine if a file is a tty, is called on /dev/console and
> fails. Programs that call isatty() on /dev/console and get an incorrect
> false value may skip expected logging to /dev/console

Missing period at the end.

> 2. The hardware issues include the case if a user has a science instrumen=
t
> or other device connected to the /dev/ttyS0 port, and they were to upgrad=
e
> to a kernel that is disabling the CONFIG_VT option, kernel logs will then=
 be
> sent to the device connected to /dev/ttyS0 unless they edit their kernel
> command line manually.
>
> The new CONFIG_NULL_TTY_CONSOLE option will give users and distribution
> maintainers an option to avoid this. Disabling CONFIG_VT and enabling
> CONFIG_NULL_TTY_CONSOLE will ensure the default kernel console behavior
> is not dependant on hardware configuration by default, and avoid
> unexpected new behavior on devices connected to the /dev/ttyS0 serial
> port.

...

>  obj-y                          +=3D vt/

+ blank line.

> +# If ttynull is configured to be a console by default, ensure that it is=
 linked
> +# earlier before a real one is selected.
> +obj-$(CONFIG_NULL_TTY_DEFAULT_CONSOLE) \
> +                               +=3D ttynull.o

Here is the question: are you sure that all console drivers that exist
in the kernel happen to be here? Have you grepped the source tree for
checking this?

...

> +# If ttynull is enabled, but not as a boot console, it is linked and use=
d later
> +# after the real ones.
> +ifneq ($(CONFIG_NULL_TTY_DEFAULT_CONSOLE),y)

Also can be written as
ifeq ($(...),)
but it might be less explicit. Up to you.

>  obj-$(CONFIG_NULL_TTY)         +=3D ttynull.o
> +endif

--=20
With Best Regards,
Andy Shevchenko
