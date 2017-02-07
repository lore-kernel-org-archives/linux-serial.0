From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] serial: sh-sci: Temporarily Revert "implement FIFO
 threshold register setting"
Date: Tue, 7 Feb 2017 14:06:18 +0100
Message-ID: <CAMuHMdUGMFpfDyCmhj7VYT7UkA0hn9rPmZV4S_Ls4NSbXgn_JA@mail.gmail.com>
References: <20170207130109.502274-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170207130109.502274-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Peter Hurley <peter@hurleysoftware.com>, Simon Horman <horms+renesas@verge.net.au>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

On Tue, Feb 7, 2017 at 2:00 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> Patch the first three patches out of seven were applied, up to commit
> a380ed461f66 ("serial: sh-sci: implement FIFO threshold register setting"),
> which introduces a new helper function. This is not called until the next
> following patch, so we now get a build warning:
>
> drivers/tty/serial/sh-sci.c:977:12: error: 'scif_set_rtrg' defined but not used [-Werror=unused-function]
>
> The patch is good, but I think we should either apply the following patches
> as well, or revert this one to get a clean build.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> This is mainly a notification that I've applied the revert to my randconfig
> test tree, if you plan to merge the following patches for 4.11, we won't
> need this one.

The follow-up commits were added to tty/tty-next earlier today.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
