From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/4] serial: 8250: Copy em485 from port to real port.
Date: Wed, 06 Jun 2018 16:11:46 +0300
Message-ID: <2abe2137e699e5ae3100b97316da469f6d1c9bb9.camel@linux.intel.com>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
         <20180606094942.71190-1-giulio.benetti@micronovasrl.com>
         <20180606094942.71190-4-giulio.benetti@micronovasrl.com>
         <069f5cd3309e83d13c74929f240720b232ea7251.camel@linux.intel.com>
         <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0bc400b1-6178-2021-c9a3-3190d1a1de32@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <mbrugger@suse.com>, Kees Cook <keescook@chromium.org>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-06-06 at 14:15 +0200, Giulio Benetti wrote:
> Il 06/06/2018 13:56, Andy Shevchenko ha scritto:
> > On Wed, 2018-06-06 at 11:49 +0200, Giulio Benetti wrote:
> > > em485 gets lost during
> > > 
> > > Copy em485 to final uart port.
> > > 
> > 
> > Is it needed at all?
> > 
> > The individual driver decides either to use software emulation (and
> > calls explicitly serial8250_em485_init() for that) or do HW assisted
> > stuff.
> 
> In 8250_dw.c, during probe(), I need to call dw8250_rs485_config() 
> against local struct uart_8250_port uart = {};
> Inside serial8250_register_8250_port() not all uart fields are 
> copied(em485 too).
> So after probe, em485 is NULL.
> 
> Another way could be to call dw8250_rs485_config() against real uart 
> port, after calling serial8250_register_8250_port(),
> would it make sense?

Look at OMAP case closely. They have a callback to configure RS485 which
is called in uart_set_rs485_config()  which is called whenever user
space does TIOCGRS485 IOCTL.

So, it's completely driven by user space which makes sense by my
opinion.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
