From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Date: Mon, 02 Jul 2018 14:51:03 +0300
Message-ID: <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
References: <20180702180428.331b36c5@xhacker.debian>
         <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-07-02 at 13:18 +0300, Andy Shevchenko wrote:
> On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:
> > For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
> > valid divisor latch fraction register. The fractional divisor width
> > is
> > 4bits ~ 6bits.
> > 
> 
> There are several serial IPs that have fractional divider built-in.
> None
> is using any specific hooks. Why do you need in your case, esp. taking
> into consideration that we have a custom ->set_termios() callback?

Okay, I see that in 8250 we have hooks embedded into 8250_port.c which
is not the best solution.

For example it prevents better splitting Exar code.
So, we would need these hooks, but better to integrate them in the same
way like it's done for the rest of 8250 ones, i.e.
- rename existing to have a "do" word
- create new functions which would be a replacement that choose between
"do" variant and custom one
- not sure if we need to export "do" variants (at least for now)

> 
> > patch1 introduces necessary hooks to 8250 core.
> > patch2 implement the fractional divisor support for Synopsys DW
> > 8250.
> > 
> > Jisheng Zhang (2):
> >   serial: 8250: introduce get_divisor() and set_divisor() hook
> >   serial: 8250_dw: add fractional divisor support
> > 
> >  drivers/tty/serial/8250/8250_core.c |  4 +++
> >  drivers/tty/serial/8250/8250_dw.c   | 54
> > +++++++++++++++++++++++++++++
> >  drivers/tty/serial/8250/8250_port.c |  8 +++++
> >  include/linux/serial_8250.h         |  7 ++++
> >  4 files changed, 73 insertions(+)
> > 
> 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
