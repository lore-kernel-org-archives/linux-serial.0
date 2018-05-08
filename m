From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
Date: Tue, 8 May 2018 12:51:31 +0200
Message-ID: <20180508105131.agz7u3q42gy7mrxy@pengutronix.de>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
 <20180508100851.GY2285@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508100851.GY2285@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Mathieu Poirier <mathieu.poirier@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-can@vger.kernel.org, Jacek Anaszewski <jacek.anaszewski@gmail.com>, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, kernel@pengutronix.de, linux-leds@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 08, 2018 at 12:08:51PM +0200, Johan Hovold wrote:
> On Tue, May 08, 2018 at 12:05:43PM +0200, Uwe Kleine-König wrote:
> > The rx trigger fires when data is pushed to the ldisc by the driver. This
> > is a bit later than the actual receiving of data but has the nice benefit
> > that it doesn't need adaption for each driver and isn't in the hot path.
> > 
> > Similarly the tx trigger fires when data was copied from userspace and is
> > given to the ldisc.
> > 
> > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > ---
> >  arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++
> 
> Looks like you included more than intended in this patch.

Right, this doesn't belong here. Feel free to assume I didn't include it
in the patch and comment the rest :-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
