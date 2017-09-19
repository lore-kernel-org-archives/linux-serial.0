From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 8/9] atmel_flexcom: Support backup mode
Date: Tue, 19 Sep 2017 16:25:04 +0100
Message-ID: <20170919152504.nhp5i734u75gb5gq@dell>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-9-romain.izard.pro@gmail.com>
 <53aa7783-0ecf-1e68-1bf9-c470ba2f79eb@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <53aa7783-0ecf-1e68-1bf9-c470ba2f79eb@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Romain Izard <romain.izard.pro@gmail.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, 19 Sep 2017, Nicolas Ferre wrote:

> On 15/09/2017 at 16:04, Romain Izard wrote:
> > The controller used by a flexcom module is configured at boot, and left
> > alone after this. As the configuration will be lost after backup mode,
> > restore the state of the flexcom driver on resume.
> > 
> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> 
> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> On sama5d2 Xplained board (i2c0 from flexcom 4).
> and obviously:
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Thanks Romain!
> 
> Regards,
> 
> > ---
> >  drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
> >  1 file changed, 50 insertions(+), 15 deletions(-)

This is the first time I've seen this patch.  Why's that?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
