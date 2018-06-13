From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 3/4] serial: 8250: Handle case port doesn't have TEMT
 interrupt using em485.
Date: Wed, 13 Jun 2018 17:59:38 +0100
Message-ID: <20180613175915.279d03e2@alans-desktop>
References: <CAJs94EZqdQAQG+inWvj89FCQtv06LxhY_J4YgNmK8mtvgDTchQ@mail.gmail.com>
        <20180606095156.72628-1-giulio.benetti@micronovasrl.com>
        <20180606095156.72628-2-giulio.benetti@micronovasrl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180606095156.72628-2-giulio.benetti@micronovasrl.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: matwey.kornilov@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Stefan Potyra <Stefan.Potyra@elektrobit.com>, Philipp Zabel <p.zabel@pengutronix.de>, Ed Blake <ed.blake@sondrel.com>, Joshua Scott <joshua.scott@alliedtelesis.co.nz>, Vignesh R <vigneshr@ti.com>, Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>, Aaron Sierra <asierra@xes-inc.com>, Phil Elwell <phil@raspberrypi.org>, Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>, Sean Wang <sean.wang@mediatek.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

> +		} else {
> +			while ((lsr & BOTH_EMPTY) != BOTH_EMPTY) {
> +				lsr = serial_in(p, UART_LSR);
> +				cpu_relax();
> +			}
> +		}

This still needs a timeout in case some kind of hardware flow control line
is asserted and therefore the byte is staying put.

Alan
