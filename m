From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 0/4] pch_uart: Cleanups, board quirks, and user uartclk
 parameter
Date: Wed, 22 Feb 2012 08:58:30 +0000
Message-ID: <20120222085830.1ed8c25e@pyramind.ukuu.org.uk>
References: <cover.1329875301.git.dvhart@linux.intel.com>
	<CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANKRQni9E6NO39MFSak6MjQ0DtmQeviGo966Ex9ZUvai56wCjg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Cc: Darren Hart <dvhart@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Feng Tang <feng.tang@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

> > assume a 192 MHz clock on all boards. The problem with this approac=
h is
> > that the CLKCFG register may have been set to something other than =
the
> > 192MHz configuration by the firmware.

So you can use the early PCI hooks or even bash the register directly i=
n
your early bootup code. You won't be the only early boot console that
does this sort of thing. There are even people bitbanging PCI I=B2C
interfaces at boot time for such purpose.

> So, I think default uart_clock 192MHz setting is better than Darren's=
 opinion.

It's certainly easier to maintain, but it would be good to know if the
setting can be written or retrieved directly in the early console setup
using the early PCI ops or similar.

Alan

Alan
