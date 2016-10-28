From: "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH v2 0/2] serial: Add IrDA support to 8250_dw driver
Date: Fri, 28 Oct 2016 20:13:12 +0300
Message-ID: <CAJs94EZ5pX5DGf5E41n+QE+18O9a4=0UDr8ZsKRUFacz6hP+bg@mail.gmail.com>
References: <1477674274-16283-1-git-send-email-ed.blake@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477674274-16283-1-git-send-email-ed.blake@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ed Blake <ed.blake@imgtec.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, wangkefeng.wang@huawei.com, Heikki Krogerus <heikki.krogerus@linux.intel.com>, noamc@ezchip.com, annie.wang@amd.com, anton.wuerfel@fau.de, phillip.raffeck@fau.de, Peter Hurley <peter@hurleysoftware.com>, alexander.sverdlin@nokia.com, Yegor Yefremov <yegorslists@googlemail.com>, yamada.masahiro@socionext.com, tthayer@opensource.altera.com, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, james.hartley@imgtec.com
List-Id: linux-serial@vger.kernel.org

I like this idea. OMAP UART (8250_omap) also can be switched to IrDA
mode, but I don't know anyone who use it.

2016-10-28 20:04 GMT+03:00 Ed Blake <ed.blake@imgtec.com>:
> This patch set adds IrDA support to the 8250_dw driver. The first patch exposes
> the set_ldisc() function in the 8250 driver so it can be overridden, and the
> second patch adds a set_ldisc() function to the 8250_dw driver which enables /
> disables IrDA SIR mode if supported.
>
> v2:
>   The 8250_dw set_ldisc() function no longer tries to enable/disable IrDA SIR
>   mode if not supported by the hardware configuration.
>
> Ed Blake (2):
>   serial: 8250: Expose set_ldisc function
>   serial: 8250_dw: Add support for IrDA SIR mode
>
>  drivers/tty/serial/8250/8250_core.c |  3 +++
>  drivers/tty/serial/8250/8250_dw.c   | 24 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c | 12 ++++++++++--
>  include/linux/serial_8250.h         |  4 ++++
>  include/linux/serial_core.h         |  2 ++
>  5 files changed, 43 insertions(+), 2 deletions(-)
>
> --
> 1.9.1
>



-- 
With best regards,
Matwey V. Kornilov.
Sternberg Astronomical Institute, Lomonosov Moscow State University, Russia
119991, Moscow, Universitetsky pr-k 13, +7 (495) 9392382
