From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC, PATCH] imx: serial: Take tty->files_lock opportunistically
Date: Mon, 12 Jun 2017 08:55:44 -0300
Message-ID: <CAOMZO5DBAzCLgL2C=cN0i_zPZoE44JBxQzXELmFhhGDDALXemw@mail.gmail.com>
References: <20170530123726.18598-1-andrew.smirnov@gmail.com>
 <CAL_JsqJUF8NhEhGY2FPPX5GUF3oP9XONQJy9sj42uPYATskz9A@mail.gmail.com>
 <20170530144213.48df2a1c@alans-desktop> <20170530134427.GD6786@collabora.com>
 <20170603093048.GA9120@kroah.com> <CAOMZO5A_hLkuQkmfQFmCmLtCFimf0i70WbtYMr0o811vpreKbA@mail.gmail.com>
 <20170612064656.GA15926@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170612064656.GA15926@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Peter Senna Tschudin <peter.senna@collabora.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Rob Herring <robherring2@gmail.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Chris Healy <cphealy@gmail.com>, Jiri Slaby <jslaby@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Mon, Jun 12, 2017 at 3:46 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:

>> linux-next is good, but mainline is not.
>>
>> Actually we need 4dec2f119e86f9c9 ("imx-serial: RX DMA startup
>> latency") to be applied to 4.12-rc as well.
>
> Why?  Can't it wait until 4.13-rc1?

Because without 4dec2f119e86f9c9  the imx serial driver behaves badly
in 4.12-rc.

Just tested 4.12-rc5 and there is scary verbose warning:

[   11.714904] =====================================================
[   11.721006] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   11.727628] 4.12.0-rc5 #413 Not tainted
[   11.731470] -----------------------------------------------------
[   11.737572] rawtest/219 [HC0[0]:SC0[0]:HE0:SE1] is trying to acquire:
[   11.744018]  (&(&tty->files_lock)->rlock){+.+...}, at: [<c04d83a0>]
imx_startup+0x2c4/0x510
[   11.752403]
[   11.752403] and this task is already holding:
[   11.758241]  (&port_lock_key){-.....}, at: [<c04d81e8>]
imx_startup+0x10c/0x510
[   11.765571] which would create a new lock dependency:
[   11.770626]  (&port_lock_key){-.....} -> (&(&tty->files_lock)->rlock){+.+...}
[   11.777791]
[   11.777791] but this new dependency connects a HARDIRQ-irq-safe lock:
[   11.785712]  (&port_lock_key){-.....}
[   11.785726]
....

Complete stack at: https://pastebin.com/a2gUTwZK

This problem is caused by commit 18a4208826dd0 ("imx-serial: Reduce RX
DMA startup latency when opening for reading").

linux-next has a fix for it: 4dec2f119e86f9c9 ("imx-serial: RX DMA
startup latency")

Applying 4dec2f119e86f9c9 ("imx-serial: RX DMA startup latency") into
4.12-rc5 makes the issue go away.

Thanks
