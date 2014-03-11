From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: serial core: crash / race condition on unbind
Date: Tue, 11 Mar 2014 11:58:01 +0100
Message-ID: <CAMuHMdUeUjuBe0tWpYBZqwqWT=euPAn6fwzmXMYCP573Q1BDXQ@mail.gmail.com>
References: <CAMuHMdVV_NrQ3PPJwPNx7MoM9TWLdk02d+10zNipNcC7VC0HAA@mail.gmail.com>
	<CAMuHMdVwpQEWAVHA5BO2xXzaNc1DTdteDMWFHQ=MFJoo4Afm_A@mail.gmail.com>
	<531E7F81.20400@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:41312 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972AbaCKK6C (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Mar 2014 06:58:02 -0400
In-Reply-To: <531E7F81.20400@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

Hi Peter,

On Tue, Mar 11, 2014 at 4:14 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>
>>          [...]
>>
>>          /*
>>           * Indicate that there isn't a port here anymore.
>>           */
>>          uport->type = PORT_UNKNOWN;
>>
>>          state->uart_port = NULL;
>
> How did this ever work?
>
> Detaching the ll driver from the tty port in this manner is not ok;
> as you already note, it blows up if consoles are still running.

No one unbinds serial drivers using serial_core, as all these drivers are
for fixed hardware?

Hot-pluggable usb-serial doesn't use serial_core.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
