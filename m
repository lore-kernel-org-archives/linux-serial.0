From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Expected behavior of set_termios() w.r.t. TX FIFO?
Date: Fri, 17 Mar 2017 13:28:39 +0100
Message-ID: <CAMuHMdWVOFVxb4bfexg5ZPOdC6Yig4g5Rd+5rRAOfrhH3W83GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg, Jiri, Peter,

I'm wondering what is the expected behavior of calling
uart_ops.set_termios() w.r.t. characters that are already queued in the
UART's TX FIFO.

  - Should it wait (block) until all queued characters have been
    transmitted, before changing the UART's settings?
  - Should it apply the new settings immediately, affecting the already
    queued characters?
  - Should it apply the new settings, dropping the already queued
    characters?
  - Is calling uart_ops.set_termios() while the TX FIFO isn't empty
    allowed (this can be triggered easily from userspace)?

uart_ops.set_termios() returns void, so there's no way to return an error.

Currently the sh-sci driver blocks until the TX FIFO has been emptied,
which may never happen if hardware flow control is enabled, and the remote
side never asserts CTS, leading to:

        NMI watchdog: BUG: soft lockup - CPU#0 stuck for 22s!

See also "[PATCH 2/2] serial: sh-sci: Fix hang in sci_reset()",
https://lkml.org/lkml/2016/12/2/225).

Thanks for your answer!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
