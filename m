From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 3/3] tty: implement led triggers
Date: Tue, 8 May 2018 12:08:51 +0200
Message-ID: <20180508100851.GY2285@localhost>
References: <20180508100543.12559-1-u.kleine-koenig@pengutronix.de>
 <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180508100543.12559-4-u.kleine-koenig@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Johan Hovold <johan@kernel.org>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>, linux-serial@vger.kernel.org, linux-leds@vger.kernel.org, linux-can@vger.kernel.org, kernel@pengutronix.de, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Mathieu Poirier <mathieu.poirier@linaro.org>, linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 08, 2018 at 12:05:43PM +0200, Uwe Kleine-König wrote:
> The rx trigger fires when data is pushed to the ldisc by the driver. This
> is a bit later than the actual receiving of data but has the nice benefit
> that it doesn't need adaption for each driver and isn't in the hot path.
> 
> Similarly the tx trigger fires when data was copied from userspace and is
> given to the ldisc.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx25-logitech-baby.dts | 192 ++++++++++++++++++++++

Looks like you included more than intended in this patch.

>  drivers/tty/Kconfig                       |   7 +
>  drivers/tty/tty_buffer.c                  |   2 +
>  drivers/tty/tty_io.c                      |   3 +
>  drivers/tty/tty_port.c                    |  32 +++-
>  include/linux/tty.h                       |  22 +++
>  6 files changed, 256 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx25-logitech-baby.dts

Johan
