From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Initial Console
Date: Mon, 13 Oct 2008 18:02:06 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810131800510.30181@anakin>
References: <241b8f7b0810130520g1f8a2573v3261e24218546b75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759538AbYJMQCa@vger.kernel.org>
In-Reply-To: <241b8f7b0810130520g1f8a2573v3261e24218546b75@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prabhu Chawandi <prabhu.chavandi@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 13 Oct 2008, Prabhu Chawandi wrote:
>    Initial console /dev/console in  the kernel is directed to /dev/ttyS0,

Depends...

> Any bosy is having info, where exavtly in which file has been done so..

drivers/char/tty_io.c, look for `TTYAUX_MAJOR, 1'.

> if not what exactly is happening to initialize console to ttyS0.

... depends on the list of available console devices, and the `console=' kernel
command line parameter.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
