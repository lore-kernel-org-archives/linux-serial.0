Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8451EC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 30 May 2022 23:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238515AbiE3XJn (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 May 2022 19:09:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiE3XJm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 May 2022 19:09:42 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770EA66F8A;
        Mon, 30 May 2022 16:09:39 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ff90e0937aso122401637b3.4;
        Mon, 30 May 2022 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AQ/TcDJKc0jhzN+sY1hgsn8chSe+TJF41fz99zrVrys=;
        b=CJEe1o44mGM/UfwXuuR5hyUpSnKaP4UczfdxGQuWJ9hzc3/WXKIvUQedvuOKd9Zp5N
         8PGpjY2U2OavdpcupKucsBNJSWx0o0GXK0dggW70RsCUGJSeDbBz2c//yrjzC7SBzCKK
         nLL8hvAyApvTU85Mz+aiVUQ4e8oltCz/wPmJK61v5aHFIPf2oAWKn0wops+2OFHJINHq
         ZaSMl4wqZv3YX9A0Dwb40lS8rG3T8/qYSvp9xVJ4RM/EfPsGetiBw1sgHBok1YQScVDy
         2205uMjI20V6iKCaqUdbm8WYGMmqJQVjadKJaMtgv2/e4xY943LQLSCqPXmHzj1/+i/Z
         VhZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AQ/TcDJKc0jhzN+sY1hgsn8chSe+TJF41fz99zrVrys=;
        b=N3Tkr809hyhLqyQcviucCcYkISvAQKXXOnZ0dvjoSBLbFgVd3utHwj0bY8Sh4d0rxH
         PM8AsJc6eyYWhNCKSm5bn6l8OyhwvVRGbt8iHvtjTPFQyrCxaTUrnq7XjONXNZOlHj6B
         9WJGLESHCRzuFUotFdMxhNXgGNk2PNDlQmKT2YKJkdgbjpaLvnXyErWdo7vsqqbnLEt9
         CpKt1qMjwNfw7RPYDyZrGc830SnOu8oNLzbnoiBjKDc2oVyzv4a2+GXIAxcuyJYSyg78
         bm+OW9gLSWjn3q0oa0E1Iu+8et3boP5itB0CVQ67cGG5NbSNEZPjqNXDzcCN/jk9bvlY
         9LBQ==
X-Gm-Message-State: AOAM532uBdUO1mDAt7a+FtI/n/JT6IqCn3MYlVqQhkkBvAjNVCd/pNzi
        UifonYAPDqClIOHOmlnsPjgzwNqs1yp5yhjMKAMuwXN3CPg=
X-Google-Smtp-Source: ABdhPJykXZ5/DdjRwsYO/qjwfoo9/mjHvNmkuHXd1XLZsSrpJvcPKhAumnMNMmPeb8ecMDukTz/LNlv0H1nlql06XA4=
X-Received: by 2002:a81:4f51:0:b0:2ff:e87d:b966 with SMTP id
 d78-20020a814f51000000b002ffe87db966mr45183098ywb.4.1653952178650; Mon, 30
 May 2022 16:09:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:7aa7:0:0:0:0 with HTTP; Mon, 30 May 2022 16:09:37
 -0700 (PDT)
In-Reply-To: <CAHp75Ve2WG3bQk5XXumX6r1V=qunOE-z5F90eS0tMhvbBY-Qug@mail.gmail.com>
References: <20220527222713.A369E3740211@freecalypso.org> <CAHp75Ve2WG3bQk5XXumX6r1V=qunOE-z5F90eS0tMhvbBY-Qug@mail.gmail.com>
From:   Mychaela Falconia <mychaela.falconia@gmail.com>
Date:   Mon, 30 May 2022 15:09:37 -0800
Message-ID: <CA+uuBqZKcrvP=0OOC1Mt42-c09R3NhS26r-SwQDCzLuUquJt-g@mail.gmail.com>
Subject: Re: [PATCH 2/6] serial: core: add sysfs attribute to suppress raising
 DTR & RTS on open
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy Shevchenko wrote:

> As I read this I think of the pins used as GPIOs.

Viewing my repurposed DTR & RTS outputs as GPIOs is a valid way to
look at them.  The target application has one 8-wire UART, a secondary
2-wire UART, and two GPIO (really GPO, output-only) controls.  Because
no major USB-to-X chip vendor makes a chip that goes from one USB to
this combination of two UARTs plus GPIO (there are some that may seem
to qualify at first glance, such as CP2105, but that one and others I
know of have other issues that preclude their use), I took the next
most practical route: I used FT2232D, and repurposed its otherwise
unused Channel B DTR & RTS outputs to be GPOs.

> So, sounds like what
> we need instead is to list the pins that are used for (dedicated)
> GPIOs and pass this information to serial mctrl layer and perhaps
> prepare that layer to handle exclusions like these.

What you are describing would be quite easy to implement for *my*
device, and the implementation would be entirely contained in the
ftdi_sio driver.  My particular FTDI chip (FT2232D) doesn't have any
pins that are officially regarded as GPIOs, but other FTDI chips do
(single-channel FT232H, FT232R and FT-X), and Linux ftdi_sio driver
already has support for presenting FT232H/R/FT-X CBUS pins to gpiolib
as a gpio_chip.  It would be fairly easy to implement a second kind of
gpio_chip within ftdi_sio, made out of an otherwise-serial channel's
DTR and RTS outputs - but here is the big BUT: I don't know how to
conditionalize enabling of this special mode (stealing DTR & RTS from
the ttyUSBx device and handing them over to gpiolib control instead)
other than by keying on specific USB VID:PID codes.  The latter
approach would work great for my application, but I keep being told
that the solution must work for "everyone", whatever that global
specifier could mean in this context.

However, this idea of moving an FTDI device's DTR & RTS outputs to
gpiolib control at the ftdi_sio driver level will not help anyone who
has an old-fashioned RS-232 (not USB-serial) device in which DTR
and/or RTS have been repurposed in a way that does not tolerate
automatic unconditional assertion of these signals on open.  I don't
know whether or not any such devices exist: there aren't any in _my_
world, but I keep being told to think generically, outside of my own
repertoire of use cases.

At this point I need to ask the maintainers with decision-making
powers: which approach would be more acceptable?  The two approaches
which I see as feasible are:

Option 1: implement a special mode for all serial ports, both "hard"
and USB-serial, that suppresses automatic assertion of DTR & RTS on
open - but allows them to be controlled with TIOCMBIS and TIOCMBIC.
Yes, the signals are really GPIOs in this case, but just how would one
go about turning UART signals into true Linux GPIOs on any arbitrary
serial port, whenever an end user decides to connect a particular
RS-232 device that needs special handling?

Option 2: implement a VID:PID-keyed solution in the ftdi_sio driver,
stealing DTR & RTS completely from the tty device and handing them
over to gpiolib control.  This solution would work for my specific USB
device, and if anyone else builds anything similar, they could reuse
the same ftdi_sio driver quirk - but this solution provides no help at
all to RS-232 tinkerers, if any exist.

M~
