From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 3/9] serial: atmel: Use common rs485 device tree parsing
 function
Date: Fri, 23 Jun 2017 13:13:40 +0200
Message-ID: <20170623111340.4osgybelqy5fzloz@pengutronix.de>
References: <20170621102130.21024-1-u.kleine-koenig@pengutronix.de>
 <20170621102130.21024-4-u.kleine-koenig@pengutronix.de>
 <8ab92dee-d9ba-0f7d-389c-e35a0f7f304c@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <8ab92dee-d9ba-0f7d-389c-e35a0f7f304c@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Richard Genoud <richard.genoud@gmail.com>
Cc: kernel@pengutronix.de, devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 23, 2017 at 11:49:38AM +0200, Richard Genoud wrote:
> On 21/06/2017 12:21, Uwe Kleine-K=F6nig wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> > =

> > We just got a common helper for parsing the rs485 specific
> > device tree properties. Use it and drop the open coded parser.
> > =

> > Note that the common function is more strict, so some device trees
> > needed fixing in the previous commit.
> > =

> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> > Cc: Richard Genoud <richard.genoud@gmail.com>
> > =

> >  drivers/tty/serial/atmel_serial.c | 17 +----------------
> >  1 file changed, 1 insertion(+), 16 deletions(-)
> > =

> > diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atm=
el_serial.c
> > index b753d2020068..a6b0c0087e2d 100644
> > --- a/drivers/tty/serial/atmel_serial.c
> > +++ b/drivers/tty/serial/atmel_serial.c
> > @@ -1706,22 +1706,7 @@ static void atmel_init_rs485(struct uart_port *p=
ort,
> >  	struct atmel_uart_data *pdata =3D dev_get_platdata(&pdev->dev);
> >  =

> >  	if (np) {
> > -		struct serial_rs485 *rs485conf =3D &port->rs485;
> > -		u32 rs485_delay[2];
> > -		/* rs485 properties */
> > -		if (of_property_read_u32_array(np, "rs485-rts-delay",
> > -					rs485_delay, 2) =3D=3D 0) {
> > -			rs485conf->delay_rts_before_send =3D rs485_delay[0];
> > -			rs485conf->delay_rts_after_send =3D rs485_delay[1];
> > -			rs485conf->flags =3D 0;
> > -		}
> > -
> > -		if (of_get_property(np, "rs485-rx-during-tx", NULL))
> > -			rs485conf->flags |=3D SER_RS485_RX_DURING_TX;
> > -
> > -		if (of_get_property(np, "linux,rs485-enabled-at-boot-time",
> > -								NULL))
> > -			rs485conf->flags |=3D SER_RS485_ENABLED;
> > +		of_get_rs485_mode(np, &port->rs485);
> >  	} else if (pdata) {
> >  		port->rs485 =3D pdata->rs485;
> >  	} else {
> > =

> I don't kown if the serie will make it to 4.12, but as you may have
> noticed, this patch will break with tty-next.

I'm pretty sure it won't make it into 4.12 given we're already at -rc6.
And there is a v2 that should apply on top of tty-next. (I have it on
4.12-rc6 + the two patches by Alexandre Belloni.)

> In fact, you could get rid of atmel_init_rs485() and just replace it
> with of_get_rs485_mode() :)

As mentioned in the v2 thread I plan to do this for v3.

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
