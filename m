From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 7/7] serial: imx: add support for half duplex rs485
Date: Thu, 19 Feb 2015 10:37:52 +0100
Message-ID: <20150219093752.GO19388@pengutronix.de>
References: <1424292068-28197-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1424292068-28197-7-git-send-email-u.kleine-koenig@pengutronix.de>
 <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CAFeThoCahCMGniG59k4Le3E-4P+TEi_7dxUagKWzc20WAvkMuA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?iso-8859-1?Q?aur=E9lien?= bouin <a.bouin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello Aur=E9lien,

On Thu, Feb 19, 2015 at 10:15:10AM +0100, aur=E9lien bouin wrote:
> 2015-02-18 21:41 GMT+01:00 Uwe Kleine-K=F6nig <u.kleine-koenig@pengutroni=
x.de>:
> > The transmitter is expected to be controlled by the UART's RTS pin.
> =

> You definately can be more open in using the last patch I have sent
> the 11th of februrary using rs485.padding[0] that give in parameter
> the GPIO to use for transmit pin
you have a link? Without having seen that patch this can well be a
separate patch. And (also without having seen the patch) I wonder why
the information which gpio to use doesn't come from the device tree but
is supplied by userspace. I thought about expanding mctrl-gpio for that,
but as there are a few conflicting patches to mctrl-gpio out I wanted to
wait until the dust settles.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
