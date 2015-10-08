From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] serial: atmel: fix compiler warning on address cast
Date: Thu, 8 Oct 2015 16:01:21 +0100
Message-ID: <20151008150120.GF32532@n2100.arm.linux.org.uk>
References: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
 <20151008090148.GE3485@piout.net>
 <20151008093749.GB32532@n2100.arm.linux.org.uk>
 <20151008103835.GF3485@piout.net>
 <56168292.5030207@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56168292.5030207@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 08, 2015 at 03:49:54PM +0100, Andre Przywara wrote:
> Hi,
> 
> On 08/10/15 11:38, Alexandre Belloni wrote:
> > On 08/10/2015 at 10:37:49 +0100, Russell King - ARM Linux wrote :
> >> On Thu, Oct 08, 2015 at 11:01:48AM +0200, Alexandre Belloni wrote:
> >>> On 05/10/2015 at 18:00:52 +0100, Andre Przywara wrote :
> >>>> Turning on KVM and LPAE support on top of a multi_v7_defconfig will
> >>>> produce a compiler warning in the Atmel serial driver:
> >>>> drivers/tty/serial/atmel_serial.c: In function 'atmel_verify_port':
> >>>> drivers/tty/serial/atmel_serial.c:2299:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >>>>   if ((void *)port->mapbase != ser->iomem_base)
> >>>>       ^
> >>>>
> >>>> Fix that by using the cast on the right hand side instead, as similar
> >>>> code already does in other drivers.
> >>>>
> >>>> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> >>> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>
> >> Hmm, this actually points at a problem, and the cast screems out about it.
> >> Think about it, can you guess what it is?
> 
> Russell, I'd really appreciate if we wouldn't have to play
> "guess-what-I-am-thinking" here. Can't you just say what's bothering you?

Actually, I think it's fine - the interface is just another one of the
weird cases we have in the kernel.

However, for the record, things get typed a certain way for a reason.
Virtual addresses that can be dereferenced are generally pointer like.
Physical addresses are generally integers.

Casting between the two generally indicates a bug, and whenever you see
a cast between the two, it should have special attention paid to it to
make sure that it really is correct.

There are a few famous places in the kernel where casting between an
unsigned long and a virtual address is pretty standard, but they're
the exception to the rule (eg, the argument to a timer, get_free_page()).
This is another example.

Sorry for creating confusion.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
