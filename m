From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] tty: serial: 8250_mtk: Add earlycon
Date: Thu, 18 Dec 2014 10:12:33 +0100
Message-ID: <1822504.xkcBG8sz41@wuerfel>
References: <1418891601-53769-1-git-send-email-eddie.huang@mediatek.com> <1418891601-53769-2-git-send-email-eddie.huang@mediatek.com> <CABuKBe+dki5ab8PexMhq36AJFCBk_dBifV86F8FKsF_es1cmJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CABuKBe+dki5ab8PexMhq36AJFCBk_dBifV86F8FKsF_es1cmJA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Eddie Huang <eddie.huang@mediatek.com>, Mark Rutland <mark.rutland@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, srv_heupstream <srv_heupstream@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Jiri Slaby <jslaby@suse.cz>, Alan Cox <alan@linux.intel.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Yingjoe Chen <yingjoe.chen@mediatek.com>, YH Chen =?utf-8?B?KOmZs+aYseixqik=?= <yh.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Thursday 18 December 2014 09:48:31 Matthias Brugger wrote:
> > +static void __init mtk8250_serial_putc(struct uart_port *port, int c)
> > +{
> > +       while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) !=
> > +               BOTH_EMPTY)
> > +               ;
> 
> Please delete newline before the semicolon.
> 

No, that newline is best kept in there for clarity. An even better way
to write this would be using cpu_relax():

	while ((readl(port->membase + (UART_LSR << 2)) & BOTH_EMPTY) != BOTH_EMPTY)
		cpu_relax();

which the kernel convention for doing busy-loops.

	Arnd
