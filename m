Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B98423C8A0
	for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764260204; cv=none; b=P1ovbE0bW+lz9T/n7BijaC/rncquJM9mI4PPG/xV9tKJ02Rv782v3iznk8Yy+XtNL0o8QfaY6LHHxag6IniJL7z1FLvLLabsgBX+N6tJQSL0/t1on7lpxwHhWPNUo+Z1DhSGzXaZe6bkPegK0oDCeF4hsuWj7zyVQ0lsBAMtDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764260204; c=relaxed/simple;
	bh=xDypKOX/n6GRcGDAU8VyLfV/rY9GENv82TIM6XTxRto=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmXb6ff6cUEkT4UqLz9f7q8LdrnXjMx1lfH91sSWXTM01IjXOaDRzqI/p+HHptBOZqPXLytSETO92H4l1SV6FkyLNvsgHN0YP17OxpTjH/Ec57L6SPuP/ymp7EAcIYHf9yma93NvVvgqDaxJtNye8rrDq2rjd3Ox+t38CbPMq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPs5FdL0; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPs5FdL0"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-645a13e2b17so1629398a12.2
        for <linux-serial@vger.kernel.org>; Thu, 27 Nov 2025 08:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764260200; x=1764865000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KNO28PzgIsx+2Ndb8A3ECc1R+7TzxXSai5xVu+osWaY=;
        b=KPs5FdL04I8adeZnQ9V4xT1D/R21qLv4bEymY7y1NKEsv1aSHOxF7+0WOhOANz6hEu
         H0t9EqE3YzDceOOA3aOZJ50d9mUgX6KkcBRvBSfaqWx0Vx5/aQXfdqzXkhrn9NrISEpq
         FNhREaJi6TU+fIpTf4p3drfvf7RVIdc9L2+mIuGhqUNNVtnf4tdoPBB0GJ8B1hso97xG
         XEQnXkv895T5F58P8cYDt+Z/7cV2HHFfsC5TbUh7o34q52u+qWHcnDjbG1vyCouftlhm
         Ojjghv40AkxBRREjFwcO5yf9SysAncr+yoDaaiYIpcUnwfWjCWKTlUaJcVSdFALHypzg
         bynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764260200; x=1764865000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KNO28PzgIsx+2Ndb8A3ECc1R+7TzxXSai5xVu+osWaY=;
        b=ILIw0n2to27J+NchxRDRop7cTCe2XHctON4P+cSvrAbynwT1qIp+0VVXKLwSnKaCHn
         2CrUN7NS2C3Tf2fqPnC2XBCBWsv9PEPLgZt4x9RkHzDCPyhJF3/Y0+xPHe4MXLK8wUpo
         55xpBanlU0IrcS7FHu+uqUQKKZVoMCRaSkYA+ijBpMzZ3MRPn7K+QTP6hA5dPywxGuNr
         ixk0hbh9GtRF/aCN0ah1FJ6x23ZY4b88cy1Yw3e5hxaj8Dx9E5bHBYR88J3aC0g9b7LL
         tocTaOe9y92dSE7RS0IYrdqVxXQZE6dcIUWOpHf85d+iG9RXUiyrdbD3ynh4ny2/3vTl
         Pw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVrvw+b+R2ugzIfd7ZNxc0jp1bt17InRIanq+aaEshWYo59HVSCxiwkLOwPgJXhI1e7UYiQtKOsixh68NE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcbUvuCEQFy76juZxYFj0uRbop+Sy9yOw9kgVCLXo4XakrWg4
	Jr8IGdyoqpAf5KJRDmv5qxLBRV7xuTzyCfSuAnzQSLsSdyRmqmRF0oT7RIR0jU4T7s3v6JSbaRs
	kcL1KOi8OehZiTk5w4dbK83BwKT0D3Lo=
X-Gm-Gg: ASbGncshylD2p9BiJ+7gqpA1ICKBCtgErfYQf65Ml2I7ka2uQYKvpwzlvMb19w1KAdH
	Rmg136eWm1eJx/wXwlpArvblMdKkwZMLa0LsdP468G3BrEeQEETURIIaQ+nrixn1Sbkv+5tSxLc
	omQ0rsTpZJ292aE4k53Q1drHwEgD4m3R35M1yrbFFinv99qbSLBms1l5UKJ1Jlsfgfut12YdKTs
	vnwQ9956t6gsCd5ijcKziO8FlI4OOzjxB8cg7GMy8NdRx+BDG11Gus1ZwuTx/KNpVMc1ilpP94O
	EK8dcbWQD2CruMrnfnxanrMXadeicf0wUqGvNYdrc0tXMVh1wbEpSm3I28K92spao0oz2u0=
X-Google-Smtp-Source: AGHT+IE6et7KPZp2GkXfofcAVlXzT7muZvGR6VaoGxIvgHz2tucfIoZqOFaUmU2ZIt9fSGn6WlPk+6UoVkEjoIjxQZM=
X-Received: by 2002:a17:906:f5a5:b0:b3f:f207:b748 with SMTP id
 a640c23a62f3a-b76c547167bmr1211487466b.10.1764260200132; Thu, 27 Nov 2025
 08:16:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
In-Reply-To: <20251127155452.42660-1-dev-josejavier.rodriguez@duagon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 27 Nov 2025 18:16:03 +0200
X-Gm-Features: AWmQ_bkZa2nrqUftdjH6MAYONe3JSVeW4Th2GGUqnpqYo2uuwkRVZXIvhkoPc0g
Message-ID: <CAHp75VdvJUFwFBRKT+iqwQXiK-toah3gZq6pX9Omcp6d2R7g+A@mail.gmail.com>
Subject: Re: [PATCH 0/2] mcb: Add modpost support for processing MODULE_DEVICE_TABLE
To: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Cc: linus.walleij@linaro.org, brgl@kernel.org, jic23@kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, morbidrsa@gmail.com, 
	jth@kernel.org, wim@linux-watchdog.org, linux@roeck-us.net, nathan@kernel.org, 
	nsc@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 5:56=E2=80=AFPM Jose Javier Rodriguez Barbarin
<dev-josejavier.rodriguez@duagon.com> wrote:
>
> During the process of update of one of the device drivers that are part o=
f
> mcb bus (gpio-menz127.c),

> one maintainer of the GPIO subsystem

Krzysztof? Did I miss something and he is now a (co)maintainer here?

> asked me
> why I was adding new MODULE_ALIAS when I also added the same new
> information on MODULE_DEVICE_TABLE.
>
> You can find the messages here:
>
> https://lore.kernel.org/linux-gpio/80a20b13-7c6a-4483-9741-568424f957ef@k=
ernel.org/
>
> After a deeper analysis, I came across that the mcb_table_id defined insi=
de
> MODULE_DEVICE_TABLE on all device drivers was being ignored as modpost wa=
s
> not processing the mcb MODULE_DEVICE_TABLE entries. For this reason, form=
er
> contributors were using MODULE_ALIAS for enabling mcb to autoload the
> device drivers.
>
> My proposal with these changes is to complete the mcb bus by adding
> modpost support for processing mcb MODULE_DEVICE_TABLE and removing
> MODULE_ALIAS from all device drivers as they are no longer needed.
>
> Jose Javier Rodriguez Barbarin (2):
>   mcb: Add missing modpost build support
>   mcb: Remove MODULE_ALIAS from all mcb client drivers
>
>  drivers/gpio/gpio-menz127.c            | 1 -
>  drivers/iio/adc/men_z188_adc.c         | 1 -
>  drivers/tty/serial/8250/8250_men_mcb.c | 3 ---
>  drivers/tty/serial/men_z135_uart.c     | 1 -
>  drivers/watchdog/menz69_wdt.c          | 1 -
>  scripts/mod/devicetable-offsets.c      | 3 +++
>  scripts/mod/file2alias.c               | 9 +++++++++
>  7 files changed, 12 insertions(+), 7 deletions(-)
>
> --
> 2.51.1



--=20
With Best Regards,
Andy Shevchenko
