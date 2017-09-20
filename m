From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH v2 8/9] atmel_flexcom: Support backup mode
Date: Wed, 20 Sep 2017 11:18:29 +0200
Message-ID: <20170920091829.wftbjshog3ixvpmu@piout.net>
References: <20170915140411.31716-1-romain.izard.pro@gmail.com>
 <20170915140411.31716-9-romain.izard.pro@gmail.com>
 <53aa7783-0ecf-1e68-1bf9-c470ba2f79eb@microchip.com>
 <20170919152504.nhp5i734u75gb5gq@dell>
 <CAGkQfmM08UqpLoMegRGQwmamN=Z74fem9VWT5yGcSjkYdS5c=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pwm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGkQfmM08UqpLoMegRGQwmamN=Z74fem9VWT5yGcSjkYdS5c=Q@mail.gmail.com>
Sender: linux-pwm-owner@vger.kernel.org
To: Romain Izard <romain.izard.pro@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Wenyou Yang <wenyou.yang@atmel.com>, Josh Wu <rainyfeeling@outlook.com>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, Thierry Reding <thierry.reding@gmail.com>, Richard Genoud <richard.genoud@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-clk@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>linux-mtd <lin>
List-Id: linux-serial@vger.kernel.org

On 20/09/2017 at 10:30:31 +0200, Romain Izard wrote:
> 2017-09-19 17:25 GMT+02:00 Lee Jones <lee.jones@linaro.org>:
> > On Tue, 19 Sep 2017, Nicolas Ferre wrote:
> >
> >> On 15/09/2017 at 16:04, Romain Izard wrote:
> >> > The controller used by a flexcom module is configured at boot, and left
> >> > alone after this. As the configuration will be lost after backup mode,
> >> > restore the state of the flexcom driver on resume.
> >> >
> >> > Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
> >>
> >> Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >> On sama5d2 Xplained board (i2c0 from flexcom 4).
> >> and obviously:
> >> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> >>
> >> Thanks Romain!
> >>
> >> Regards,
> >>
> >> > ---
> >> >  drivers/mfd/atmel-flexcom.c | 65 ++++++++++++++++++++++++++++++++++-----------
> >> >  1 file changed, 50 insertions(+), 15 deletions(-)
> >
> > This is the first time I've seen this patch.  Why's that?
> >
> 
> As the patchset covers many subsystems, get_maintainers.pl provided a
> very long list of both developpers and mailing lists (28). I thought it
> was a good idea to shorten it a little. Bad idea. Sorry.
> 

I think the correct way of handling that would have been to send each
patch to the proper subsystem as there are no dependency here.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
