From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH 0/2] serial: 8250: add support for MediaTek BTIF
 controller
Date: Wed, 02 Aug 2017 20:14:23 +0300
Message-ID: <1501694063.29303.361.camel@linux.intel.com>
References: <cover.1501692369.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1501692369.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com, robh+dt@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, jan.kiszka@siemens.com, heikki.krogerus@linux.intel.com, hpeter@gmail.com, vigneshr@ti.com, matthias.bgg@gmail.com
Cc: devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, 2017-08-03 at 01:05 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> This patchset introduces the support for MediaTek BTIF controller.
> 
> MediaTek BTIF controller is the serial interface similar to UART but
> it
> works only as the digital device which is mainly used to communicate
> with
> the connectivity module also called CONNSYS inside the SoC which could
> be
> mostly found on those MediaTek SoCs with Bluetooth feature.
> 
> And the controller is made as being compatible with the 8250 register
> layout so it tends to be integrated with existing 8250 core driver and
> have no requirement for the modem configuration additionally such as
> the
> baud rate calculation and assignment.


Why it requires a separate driver?

8250_of is for DT enabled drivers.

> 
> Sean Wang (2):
>   dt-bindings: serial: Add MediaTek BTIF controller bindings
>   tty: serial: 8250: Add MediaTek BTIF controller on MT7622 and MT7623
>     SoC
> 
>  .../devicetree/bindings/serial/mtk-btif.txt        |  26 +++
>  drivers/tty/serial/8250/8250_btif.c                | 224
> +++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig                    |   9 +
>  drivers/tty/serial/8250/Makefile                   |   1 +
>  4 files changed, 260 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/mtk-
> btif.txt
>  create mode 100644 drivers/tty/serial/8250/8250_btif.c
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
