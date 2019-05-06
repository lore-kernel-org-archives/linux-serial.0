From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: 8250: Add support for using platform_device resources
Date: Tue, 7 May 2019 00:04:30 +0300
Message-ID: <CAHp75VevGGYiWPLE_T5cXFKSNHDh=ORUNC2xW_CwTAtYsS8S1A@mail.gmail.com>
References: <20190430140416.4707-1-esben@geanix.com> <20190430153736.GL9224@smile.fi.intel.com>
 <874l6efxta.fsf@haabendal.dk> <20190502104556.GS9224@smile.fi.intel.com>
 <87pnp11112.fsf@haabendal.dk> <20190502153124.GA9224@smile.fi.intel.com>
 <87ef5boaa7.fsf@haabendal.dk> <20190506164426.GO9224@smile.fi.intel.com> <87o94f32iw.fsf@haabendal.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87o94f32iw.fsf@haabendal.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Esben Haabendal <esben@haabendal.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Enrico Weigelt <lkml@metux.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>, Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, He Zhe <zhe.he@windriver.com>, Marek Vasut <marex@denx.de>, Douglas Anderson <dianders@chromium.org>, Paul Burton <paul.burton@mips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Let's start from simple things:
- I really failed to find where resources are requested in
mfd_add_device():
https://elixir.bootlin.com/linux/latest/ident/mfd_add_device
- as for 8250_dw.c (as MFD child of intel-lpss-pci.c) see below...

1. 8250_dw.c remaps resources, but doesn't request them.
2. It calls
 -> serial8250_register_8250_port(), which sets UPF_BOOT_AUTOCONF
unconditionally, as you noticed
  -> uart_add_one_port()
   -> uart_configure_port()
    -> port->ops->config_port(), if UPF_BOOT_AUTOCONF is set, see above
3. And ->config_port() is defined to serial8250_config_port() in
https://elixir.bootlin.com/linux/latest/source/drivers/tty/serial/8250/8250_port.c#L3147

So, it *does* request resources implicitly via 8250 core.

I maybe miss something obvious, though.

-- 
With Best Regards,
Andy Shevchenko
