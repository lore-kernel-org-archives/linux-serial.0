From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250_dw: add fractional divisor support
Date: Tue, 03 Jul 2018 16:02:57 +0300
Message-ID: <db3f1fbf30b1b2adcf9a6e1a84b21d9fd6c1bcf2.camel@linux.intel.com>
References: <20180702180428.331b36c5@xhacker.debian>
         <fef0bf484ead5e0998666168ced86438bf935ce5.camel@linux.intel.com>
         <59b14f97234271a7d859fa07f27bd66ec252ccc9.camel@linux.intel.com>
         <20180703102257.678db6a8@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180703102257.678db6a8@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2018-07-03 at 10:22 +0800, Jisheng Zhang wrote:
> Hi,
> 
> On Mon, 2 Jul 2018 14:51:03 +0300 Andy Shevchenko wrote:
> 
> > On Mon, 2018-07-02 at 13:18 +0300, Andy Shevchenko wrote:
> > > On Mon, 2018-07-02 at 18:04 +0800, Jisheng Zhang wrote:  
> > > > For Synopsys DesignWare 8250 uart which version >= 4.00a,
> > > > there's a
> > > > valid divisor latch fraction register. The fractional divisor
> > > > width
> > > > is
> > > > 4bits ~ 6bits.
> > > >   
> > > 
> > > There are several serial IPs that have fractional divider built-
> > > in.
> > > None
> > > is using any specific hooks. Why do you need in your case, esp.
> > > taking
> > > into consideration that we have a custom ->set_termios()
> > > callback?  
> > 
> > Okay, I see that in 8250 we have hooks embedded into 8250_port.c
> > which
> > is not the best solution.
> > 
> > For example it prevents better splitting Exar code.
> > So, we would need these hooks, but better to integrate them in the
> > same
> > way like it's done for the rest of 8250 ones, i.e.
> > - rename existing to have a "do" word
> > - create new functions which would be a replacement that choose
> > between
> > "do" variant and custom one
> > - not sure if we need to export "do" variants (at least for now)
> 
> So you mean add the support as following:
> 
> 1.rename current serial8250_set_divisor as serial8250_do_set_divisor
> 

Yes

> 2.add a new serial8250_set_divisor which will be as simple as

Yes and no. 

> 
> static void serial8250_set_divisor(struct uart_port *port, ...)
> {
> 	struct uart_8250_port *up = up_to_u8250p(port);
> 
> 	if (up->set_divisor)

port->

> 		up->set_divisor(...);

port->

> 	else
> 		serial8250_do_set_divisor(...);
> }
> 
> could you please confirm?

Yes.

> 
> Another issue is I'm not sure which struct to add the hook,
> struct uart_port or struct uart_8250_port? Currently, it seems that
> only
> uart_8250_port needs this hook,

Define "needs". 8250 _uses_ it, the rest which I easy grepped would be
able to use it if we provide such a possibility.

lantiq.c is one example (currently they don't use it), or
drivers/tty/serial/digicolor-usart.c limits baud rate choice b/c of
absence of a common way.

>  sure, adding the hook to struct uart_port
> is fine either. Could you please kindly give some suggestions?

See above. Thanks for doing this!

> 
> Thanks,
> Jisheng

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
