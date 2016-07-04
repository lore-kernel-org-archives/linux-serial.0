From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: add rx and tx led trigger
Date: Mon, 4 Jul 2016 17:50:09 +0200
Message-ID: <20160704155009.GJ16643@pengutronix.de>
References: <1467646452-21243-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <13559901.NSWqUx1Nl6@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <13559901.NSWqUx1Nl6@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Mon, Jul 04, 2016 at 05:43:03PM +0200, Arnd Bergmann wrote:
> On Monday, July 4, 2016 5:34:12 PM CEST Uwe Kleine-K=F6nig wrote:
> > Add support for two led triggers per UART instance that blink on
> > transmission and reception of data respectively.
> > =

> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/tty/serial/imx.c | 57 ++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 57 insertions(+)
> =

> What is specific to this driver here? Could this be done in the
> core tty code instead?

The core doesn't notice when the driver starts to push out characters.

I also have a patch in my queue that adds support for rts delaying in
rs485 mode. While the delay between start_tx being called and the first
char leaving the hardware might not be big enough to care in rs232 mode,
with a big delay_rts_before_send it might matter.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
