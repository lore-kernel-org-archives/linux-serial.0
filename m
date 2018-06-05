From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 1/2] serial: 8250: enable SERIAL_MCTRL_GPIO by default.
Date: Tue, 05 Jun 2018 13:00:42 +0300
Message-ID: <2b2a81ce166f16ab88a4733caed2544c8128ae6b.camel@linux.intel.com>
References: <20180601141158.93817-1-giulio.benetti@micronovasrl.com>
         <b850a3cf565a24414d3290f6699f5a040bf61223.camel@linux.intel.com>
         <7f4d688c-095a-d056-1edd-430bfc4e00da@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7f4d688c-095a-d056-1edd-430bfc4e00da@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>, Matthias Brugger <mbrugger@suse.com>, Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>, Ed Blake <ed.blake@sondrel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Yegor Yefremov <yegorslists@googlemail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, 2018-06-04 at 20:57 +0200, Giulio Benetti wrote:
> Il 04/06/2018 13:49, Andy Shevchenko ha scritto:
> > On Fri, 2018-06-01 at 16:11 +0200, Giulio Benetti wrote:
> > > It can be useful to override 8250 mctrl lines with gpios, for rts
> > > on
> > > rs485 for example, when rts is not mapped correctly to HW RTS pin.
> > > 
> > > Enable SERIAL_MCTRL_GPIO by default.
> > > 
> > 
> > Unfortunately NAK, see
> > 
> > commit 5db4f7f80d165fc9725f356e99feec409e446baa
> > Author: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Date:   Tue Aug 16 15:06:54 2016 +0300
> > 
> >      Revert "tty/serial/8250: use mctrl_gpio helpers"
> > 
> > for the details.
> > 
> > I would love to see a solution that will satisfy everyone, though I
> > have
> > only means to test proposals for now.
> 
> Thanks for pointing me that.
> I would try to solve serial breakage on intel with already extisting 
> patches dropping this one.
> I'm going to try.
> 
> I can't understand if it's enough using qemu x86 to reproduce the bug.
> If so I'm going to debug and check what makes driver to fail.

You need to provide an ACPI table with UART contains GpioInt() or
GpioIo() resource in it.

Where GPIO number is a number of pin related to UART's RxD.


> Do you think it makes sense? Would it be accepted after bug fixing?

I can test on our hardware. Can't say about the rest, though.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
