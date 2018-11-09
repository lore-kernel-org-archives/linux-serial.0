From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] tty: serial: add driver for the SiFive UART
Date: Fri, 9 Nov 2018 09:00:13 -0800
Message-ID: <20181109170013.GB13927@kroah.com>
References: <20181018234352.26788-1-paul.walmsley@sifive.com>
 <20181018234352.26788-3-paul.walmsley@sifive.com>
 <20181109165951.GA13927@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181109165951.GA13927@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Walmsley <paul.walmsley@sifive.com>
Cc: linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Palmer Dabbelt <palmer@sifive.com>, Wesley Terpstra <wesley@sifive.com>, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 09, 2018 at 08:59:51AM -0800, Greg Kroah-Hartman wrote:
> On Thu, Oct 18, 2018 at 04:43:54PM -0700, Paul Walmsley wrote:
> > Add a serial driver for the SiFive UART, found on SiFive FU540 devices
> > (among others).
> > 
> > The underlying serial IP block is relatively basic, and currently does
> > not support serial break detection.  Further information on the IP
> > block can be found in the documentation and Chisel sources:
> > 
> > https://static.dev.sifive.com/FU540-C000-v1.0.pdf
> > 
> > https://github.com/sifive/sifive-blocks/tree/master/src/main/scala/devices/uart
> > 
> > This driver was written in collaboration with Wesley Terpstra
> > <wesley@sifive.com>.
> > 
> > Boot-tested on a SiFive HiFive Unleashed A00 board.
> > 
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.com>
> > Cc: Palmer Dabbelt <palmer@sifive.com>
> > Cc: Wesley Terpstra <wesley@sifive.com>
> > Cc: linux-serial@vger.kernel.org
> > Cc: linux-riscv@lists.infradead.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Paul Walmsley <paul.walmsley@sifive.com>
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> >  drivers/tty/serial/Kconfig       |   24 +
> >  drivers/tty/serial/Makefile      |    1 +
> >  drivers/tty/serial/sifive.c      | 1070 ++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |    3 +
> >  4 files changed, 1098 insertions(+)
> >  create mode 100644 drivers/tty/serial/sifive.c
> 
> Seems like the 0-day bot did not like this driver, can you fix up those
> build errors and resend?

Nevermind, you did, sorry about that...
