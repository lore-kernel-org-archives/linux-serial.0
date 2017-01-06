From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/9] dt/bindings: Add a serial/UART attached device binding
Date: Fri, 06 Jan 2017 20:21:34 +0100
Message-ID: <3363597.IVJfReRkL0@wuerfel>
References: <20170106162635.19677-1-robh@kernel.org> <20170106162635.19677-7-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170106162635.19677-7-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Peter Hurley <peter@hurleysoftware.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Loic Poulain <loic.poulain@intel.com>, Pavel Machek <pavel@ucw.cz>, NeilBrown <neil@brown.name>, Linus Walleij <linus.walleij@linaro.org>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Friday, January 6, 2017 10:26:32 AM CET Rob Herring wrote:
> +Optional Properties:
> +
> +- reg          : A single cell representing the port/line number of the
> +                 host UART. Only used if the host UART is a single node
> +                 with multiple ports.
> +

If there is a 'reg' property in the child, I guess we should also
document a #address-cells/#size-cells value for the parent.

Can you give an example of a multi-port serial device we support?
I was expecting that we already need a device node per port anyway,
to make the console work.

	Arnd
