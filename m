Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD84189B9
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 08:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376249; cv=none; b=bRO8h2xuvzu3BUtZMfar/Ebu85OpC+3Mvp/xuvnU4VrsJfEKPCe2xL1FG0y8qsIYq9S0XZdo4K9glTTbfjGXaVcezkmAcEfY8Z2bdHMZb4/62TdotmOl7CJKzc/jHK6YKhtYuE2qnxHt5lZFiQasrfgEdjyD1SXlfMP9pyckstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376249; c=relaxed/simple;
	bh=JCvFHGCA4rHUgkn8fPq4I3sbSzAZ4NWsrmGMQGr7b3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubCuXW5GWqcAKQ7Sz4U6Xfy1ibRtjXgDBpDujVuOR9dO9ZF+MLRQ85ionndETFA5qx0cURLMdzxY1hiQIBgoiKxXiqrxCfQG7s5Fy0cgoC/JilVE98HbFsip3x1dMiwsobThMk3SmfOGVK8JLvHuL7fRq4dHcYTZZz5M2wh/vQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIuB5y36; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIuB5y36"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF71F008A1
	for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 08:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789376237;
	bh=xKdkdtTMOIdPI1/d4Upir9+jkNvwkE+aa7zOe3c/KSU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aIuB5y36Tax6rIEyx6gsawh+nmQi+CfR7FHrKZuLBVJ4edweefoGKhuMVg5N3UqNj
	 w8WPgPnmc6SnBOWB/RoqfAFiNTtkcDcqqluau4qWXwkvQejYkikrsevok8AeItp24r
	 w0NOEcSf13yoJ2z5Izs7lRKIHTY19wMhPVvqFYbRrR/skINOBT2ElFCdNrfHv7CZYD
	 cBf8v/VGY/WFbjHPjlmFdEGdxzLGcUvOnyNI7DAZfPtF75ROZI9XIHTqQgZ5MT+tEC
	 Eg9x1EkAZ0Uzc+gabb3oL2Xea10cpHDZIq9Vvp9rfnkzUvPOW06wQB24AMnMPSJV/B
	 B8xN1hI9PqiNQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b754cc3b6aso3226220e87.2
        for <linux-serial@vger.kernel.org>; Mon, 14 Sep 2026 01:57:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBznITEsD7H62PG7qJ8uKz5ZzUvMDoFycH0iG1oQmVywF2BsE1POUauPbdTQ8HWQ3iU/dQ2pmtEZdmND1CU=@vger.kernel.org
X-Gm-Message-State: AFuF++mQbNLVds1OynJtBBL4rmpURwaw8/udots0EhIcLz2gFQxalMpR
	CVb6AB0PtzpI6Asa+9lcMlVKEuuUABO3GN+OCyLMU7ZGjGV5RU5FaXFOkDs1nb/6u4+ZWseKgVF
	/BCMXXPhopmQQ4/WTOe0/9ETU9+NfW0g=
X-Received: by 2002:a05:6512:1293:b0:5b6:1a7c:aa12 with SMTP id
 2adb3069b0e04-5b8ae6acc3dmr443850e87.42.1789376236013; Mon, 14 Sep 2026
 01:57:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAD++jLnKXqbV0xB3wvTF9Ri7g1MuWV6csO0MGzCtv5LBwmSr4g@mail.gmail.com>
 <20260827220805.23112-1-michael.zaidman@gmail.com>
In-Reply-To: <20260827220805.23112-1-michael.zaidman@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 10:57:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLksAPyfZz6d--n7a1KhPackigEucQJqbYiA-e9S835seA@mail.gmail.com>
X-Gm-Features: AcwNN1W0b8mgLF0Lz5Bd-fzU0UbPDLmwUn7TUmgZbPxFYpvvpI8bzXM8UFvEfRo
Message-ID: <CAD++jLksAPyfZz6d--n7a1KhPackigEucQJqbYiA-e9S835seA@mail.gmail.com>
Subject: Re: [PATCH 08/13] HID: ft260: uart: add modem pins control via ioctl
To: Michael Zaidman <michael.zaidman@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, brgl@kernel.org, 
	germain.hebert@ca.abb.com, rio@r26.me, brunoceg1@gmail.com, 
	contact@christina-quast.de, daniel.beer@igorinstitute.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-serial@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Fri, Aug 28, 2026 at 12:08=E2=80=AFAM Michael Zaidman
<michael.zaidman@gmail.com> wrote:

[Me]
> > On Kconfig, so that gpiolib is always available and you can use
> > the generic modem control helpers for modem control over GPIO.
>
> I looked into this, and it does not work for the FT260 without
> changing serial_mctrl_gpio.c first. Three blockers:
>
> - Every GPIO access on this chip is a USB transfer, so the
>   gpiochip has can_sleep =3D true. mctrl_gpio_set() calls
>   gpiod_set_array_value() and mctrl_gpio_get() calls
>   gpiod_get_value(), and gpiolib does WARN_ON(can_sleep) in both,
>   so every TIOCMGET/TIOCMSET would give a WARN backtrace.

Can't you just patch mctrl to use gpiod_set_array_value_cansleep()
and gpiod_get_value_cansleep()?

I don't think any of the users depend on call thing this
in atomic context.

> - mctrl_gpio_init() takes a struct uart_port and its IRQ handler
>   needs it: uart_port_lock_irqsave(), uart_handle_dcd_change(),
>   port->icount, delta_msr_wait. This UART is a plain tty_driver
>   with a tty_port, so only mctrl_gpio_init_noauto() is left - and
>   the FT260 GPIO lines have no interrupts anyway.

I don't understand this :D
But hopefully the TTY/serial maintainer does.

> - mctrl_gpio_init_noauto() only picks up lines that exist as
>   firmware properties: device_property_present(dev, "cts-gpios")
>   and friends. A gpiod_add_lookup_table() table is the machine
>   lookup path, so every line would be skipped, all descriptors
>   would stay NULL and both helpers would silently do nothing.
>   Software nodes could satisfy that check, but there is no
>   PROPERTY_ENTRY_GPIO in the tree to build them with.

Using software nodes is the way to go I think,
<linux/gpio/property.h> contains PROPERTY_ENTRY_GPIO.

> serial_mctrl_gpio.h is also private to drivers/tty/serial - all
> eleven users are serial_core drivers in that directory.

Well having serial drivers in drivers/hid and having all kinds
of misc drivers in drivers/hid has made it a dumping ground
for anything HID.

> Registering a uart_port instead was tried for this device and
> turned down. Daniel Beer's 2022 FT260 UART patch was built on
> serial_core and called uart_add_one_port(); Greg asked for
> usb-serial, and Johan Hovold answered that "neither USB-serial or
> serial (core) is a good fit for such a HID device", pointing at
> Christina Quast's tty driver as the right approach - which patch
> 1 of this series is a port of.
>
>   https://lore.kernel.org/lkml/638c51a2.170a0220.3af16.18f8@mx.google.com=
/
>   https://lore.kernel.org/lkml/Y6WNl6+ySy8zcSyg@hovoldconsulting.com/

Well if it absolutely has to live in drivers/hid then do the
ugly thing and

include "../tty/serial/serial_mctrl_gpio.h"

It's perhaps the lesser evil then?

Otherwise we just bite the bullet and move
drivers/tty/serial/serial_mctrl_gpio.h
to
include/linux/serial_mctrl_gpio.h
?

(Unless Greg want some new subdir such as
include/linux/serial/serial_mctrl_gpio.h)

> > The core idea is that the serial modem control should look
> > up the GPIOs from its own gpiochip and use the MCTRL
> > library helpers, then this should result in very little and
> > compact code that is easy to read.
>
> No argument with the goal - I would rather have that than my own
> TIOCM handling. But making it usable here means work inside the
> serial helpers: cansleep set/get, a path that does not require a
> uart_port, a lookup that works without firmware properties, and
> the header moved to include/linux. That is a serial subsystem
> series to agree with Greg and Jiri Slaby, so I propose keeping
> the ioctl implementation in this series and doing the conversion
> as a follow-up.

These things have a tendency to never happen and it's
not like we have a shortage of technical debt.

Yours,
Linus Walleij
