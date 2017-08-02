From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 0/2] serial: 8250: add support for MediaTek BTIF
 controller
Date: Thu, 3 Aug 2017 01:37:50 +0800
Message-ID: <1501695470.25246.7.camel@mtkswgap22>
References: <cover.1501692369.git.sean.wang@mediatek.com>
         <1501694063.29303.361.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1501694063.29303.361.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, jslaby-IBi9RG/b67k@public.gmane.org, jan.kiszka-kv7WeFo6aLtBDgjK7y7TUQ@public.gmane.org, heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, hpeter-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, vigneshr-l0cyMroinI0@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-08-02 at 20:14 +0300, Andy Shevchenko wrote:
> On Thu, 2017-08-03 at 01:05 +0800, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > This patchset introduces the support for MediaTek BTIF controller.
> > 
> > MediaTek BTIF controller is the serial interface similar to UART but
> > it
> > works only as the digital device which is mainly used to communicate
> > with
> > the connectivity module also called CONNSYS inside the SoC which could
> > be
> > mostly found on those MediaTek SoCs with Bluetooth feature.
> > 
> > And the controller is made as being compatible with the 8250 register
> > layout so it tends to be integrated with existing 8250 core driver and
> > have no requirement for the modem configuration additionally such as
> > the
> > baud rate calculation and assignment.
> 
> 
> Why it requires a separate driver?
> 
> 8250_of is for DT enabled drivers.
> 

Hi, Andy

thanks for your information

the hardware is not completely identical to 8250 device, 
it has extra registers belonged to platform control such as internal
loopback, dma disable/enable, sleep/wakeup setup and so on, so I create
it as a separate driver.

	Sean

> > 
> > Sean Wang (2):
> >   dt-bindings: serial: Add MediaTek BTIF controller bindings
> >   tty: serial: 8250: Add MediaTek BTIF controller on MT7622 and MT7623
> >     SoC
> > 
> >  .../devicetree/bindings/serial/mtk-btif.txt        |  26 +++
> >  drivers/tty/serial/8250/8250_btif.c                | 224
> > +++++++++++++++++++++
> >  drivers/tty/serial/8250/Kconfig                    |   9 +
> >  drivers/tty/serial/8250/Makefile                   |   1 +
> >  4 files changed, 260 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/serial/mtk-
> > btif.txt
> >  create mode 100644 drivers/tty/serial/8250/8250_btif.c
> > 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
