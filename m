From: Guido Classen <clagix@gmail.com>
Subject: Re: [PATCH] atmel_serial: general fixes for RS485 and TTGR
Date: Mon, 11 Feb 2013 18:05:29 +0100
Message-ID: <CAJa4H3cy3ZXcQE2AZJu7S5o2SV7c3jWw7NBH4Wxak0RoK5Rg8w@mail.gmail.com>
References: <CAJa4H3fQ_khDVNcSu+39C+oZyc268YUgq9ahzt2ugk1_6eqYfw@mail.gmail.com>
	<1360598067-3577-1-git-send-email-claudio@evidence.eu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:56319 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757805Ab3BKRFb (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 11 Feb 2013 12:05:31 -0500
Received: by mail-lb0-f182.google.com with SMTP id gg6so4819190lbb.13
        for <linux-serial@vger.kernel.org>; Mon, 11 Feb 2013 09:05:29 -0800 (PST)
In-Reply-To: <1360598067-3577-1-git-send-email-claudio@evidence.eu.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Claudio Scordino <claudio@evidence.eu.com>
Cc: linux-serial@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Dear Claudio,

I am not quite happy with your msleep patch because
a) It doesn't assert RTS during the sleep, so we don't have the intended effect
b) It will do the gaps before / after each character, not frame
c) It will raise a "BUG scheduling while atomic". As far as I see, it
is not allowed
  to do sleeps inside of the tasklet code

The crisv10 driver does this things more the way I have expected
(although it doesn't
implement delay_rts_after_send). But a direct port of this code seams
not to be possible
because
- this driver still is build on the tty interface while the newer driver use the
  uart_port interface from serial_core
- the crisv10 driver uses some architecture specific fast_timer code

I will continue to work on this issues and hopefully I can provide you
a patch in a few
days.

The TTGR patch looks good, but why haven't you used my dev_get_drvdata(dev)
code?

Regards,

  Guido

On Mon, Feb 11, 2013 at 4:54 PM,  <claudio@evidence.eu.com> wrote:
> Dear Guido.
>
> I agree about splitting the patch. Therefore, I've created the following patchset which
>
>  - Adds the unit of measure (i.e., milliseconds) in the documentation
>    serial-rs485.txt (it is already available in the header file).
>
>  - Sets RS485 delays using msleep (as in the cris driver) rather than using
>    TTGR.
>
>  - Adds an entry in sys/ to get/set the TTGR register for this specific driver.
>
> Have you tested the msleep part ?
>
> Best regards,
>
>         Claudio
