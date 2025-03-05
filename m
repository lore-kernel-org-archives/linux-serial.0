Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2178A1591E3;
	Wed,  5 Mar 2025 19:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202565; cv=none; b=GbSkFY5UNAuXU/eKiM8HVW5NAuk5p4w4A8SFZZbmOw1OBVV9ViA4n/5M4hc1av/+II52SjGS8+OjD0a24tjhOpyjkiF01zFAngAKFz4QFgZs6FulkG3HL/YnMQ4QHwG5eubPTihJDo8Coi+TirDyuaHBVR0juCDSXmdnEr1I5KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202565; c=relaxed/simple;
	bh=26RbaMAa8kT/2tcaTLRxOJBys6A4hO5+OiAFswQhDZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HUrck1HA7njYD42FBTlHqWqF1silo76I4LOjEcU+c6d4uSXm5xEt24+k0ZsGmC1s7SVErt5XbwIzaoZTMPQiZyL8cxMxTj+JAwzP2Krb8xS3xHZF7sJI/1USPqdxgg6axFklG7i9VDybi3RmgaJZjNHAbBfZUrC7yn5Npww2iSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PGfgZKbH; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PGfgZKbH"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e4ad1d67bdso11406683a12.2;
        Wed, 05 Mar 2025 11:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741202562; x=1741807362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8BxyIguz4rFyaCvdc6aubFwusQJviCL1i6QXLcS/YFk=;
        b=PGfgZKbH+eWPVVHUtHtzkmrAJVpyxE4GbPnKyC5fqS01Agck1iS4wKegx8kzeNluXK
         3FNXWJCsV1sp+zIfxGYaUecmeLNJ9VIFWNkCkAqXo/ZzQxTy9UCqNzgCGWT4F3pD4GLf
         1ZXeoe9EFKzQvIJMPBGbDxLgY84Etl3gf5fpUbK4gnCwTR/rJLZZo7ovFGTloElqMCdW
         KYg3US+rHb+FdxSzLhY7/J/tjsHPc5rdCKNSQI33GCtUwhQ0WpI5d0WXOfQ1GeoH1xHE
         ppYjkT1sszzkTf25imcLj0lV8UAYK+zrd9gCAVmKz6xRN8QQuhA+yb1Y7hr7egR6oVjN
         xWXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741202562; x=1741807362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BxyIguz4rFyaCvdc6aubFwusQJviCL1i6QXLcS/YFk=;
        b=R2cANNF4FcTqlYZsB3G3tH0mkhF3ygIJV8G9UwcrtspNRrLDXpipXapMbFULFvMXjW
         mE1P83j5n7SWnZgLyrVW8QYqYcvdTXDPVxg4vpwUWhrdQQ3cGCuiXn/9HfJkZVTUGZIe
         EqGDBJcSTRT0bJDLcyhNl5fgYsaNbnIPJilknas1Uc1ng+g8ki0ZScoKaK9zUGlIWyK8
         KdwmTpxAnXIuZv6HeSAecdtKO/6dATHFxEC06GL7A+Gi3lb8Fpn+elzkQopuQF2rCSHw
         vlUOAhP/z20W9NCWXF5+T6XTWLL0TvIXkQIudMs3eRPto3dmJF3CvatMJO1EYlhkj3sC
         /tEA==
X-Forwarded-Encrypted: i=1; AJvYcCU05ZQE+N5x7kDZNT5lu5RluNHOIzEOlriyZKvqJClnXTNXROIVkK2SSfYSUSHt7LITh1jgpD5mFZw5kGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXByyFkboytcMyWJAGAIMJHK5CxYuBUnhWocHD1k2rRAi16rUD
	uZjkj7B5EluYZhHWv03VLmVS/zO198J8l+7yA7ZkVzn3ZSSlA+vGwIgRtIhxux1cPhkNORK9dow
	KTALXShV7wvw0+QVK0c3NJet6SCs=
X-Gm-Gg: ASbGnctk2uLTPEgfUKXziD2rkxCJYs+k0hNzCZwq9aSGG+ZhLkh9YQGoyO9vP/CZZBc
	a+3IvLMZ663/6q8VgGLx6EfMCQ5bARxWYbYSF/4Aj9vF4bkN+qPjxHetn602NZ3s8StI8ZwOClp
	WEfyDxJ3tD3MtAXrx6Zpvf7WIBfwFI
X-Google-Smtp-Source: AGHT+IGlUZ6C9qCYg1gc6PfUQhojmvoQtlUdsWmN2P8WPB2amUwheTXZlFA2mOeN9Bh05Tc6tAD+WcrSIRivSgmgjxI=
X-Received: by 2002:a17:906:6a27:b0:ac0:6e7d:cd0b with SMTP id
 a640c23a62f3a-ac20d951583mr442488466b.34.1741202562018; Wed, 05 Mar 2025
 11:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305042930.3453265-1-adamsimonelli@gmail.com> <20250305042930.3453265-4-adamsimonelli@gmail.com>
In-Reply-To: <20250305042930.3453265-4-adamsimonelli@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 5 Mar 2025 21:22:06 +0200
X-Gm-Features: AQ5f1Jr9CT8d0VR1B8A5PdW5GUuBVSxR6hCDvQ3AJ7TYWCBwor9DwnJ86RMR3bM
Message-ID: <CAHp75Ve02Ma1EswjnsxiV5uyh3A9NU0B90QLFGS13ifr594QFw@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] tty: Change order of ttynull to be linked sooner
 if enabled as a console.
To: adamsimonelli@gmail.com
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jiri Slaby <jirislaby@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, John Ogness <john.ogness@linutronix.de>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Petr Mladek <pmladek@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 6:30=E2=80=AFAM <adamsimonelli@gmail.com> wrote:
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
> false value may skip expected logging to /dev/console.
>
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

Since it touches the link order only under drivers/tty the commit
message should mention what the effect will be on the consoles drivers
for which are located elsewhere.

--=20
With Best Regards,
Andy Shevchenko
