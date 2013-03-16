From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/6] serial: 8250_dw: add support for clk api
Date: Sat, 16 Mar 2013 00:29:52 +0000
Message-ID: <20130316002952.GA4977@n2100.arm.linux.org.uk>
References: <1363377988-4966-1-git-send-email-maxime.ripard@free-electrons.com>
 <1363377988-4966-2-git-send-email-maxime.ripard@free-electrons.com>
 <20130315223917.GZ4977@n2100.arm.linux.org.uk>
 <BLU0-SMTP4156A39670AA58651B05028AEE0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <BLU0-SMTP4156A39670AA58651B05028AEE0@phx.gbl>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, sunny@allwinnertech.com, shuge@allwinnertech.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Jiri Slaby <jslaby@suse.cz>, kevin@allwinnertech.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On Fri, Mar 15, 2013 at 09:15:11PM -0300, Emilio L=F3pez wrote:
> Hello Russell,
> =

> El 15/03/13 19:39, Russell King - ARM Linux escribi=F3:
> > On Fri, Mar 15, 2013 at 09:06:23PM +0100, Maxime Ripard wrote:
> >> +	/* clock got configured through clk api, all done */
> >> +	if (p->uartclk)
> > =

> > 	if (IS_ERR(p->uartclk))
> > =

> =

> Isn't IS_ERR for pointers? p->uartclk is an unsigned int

Right, sorry, ignore that.

> >> +		return 0;
> >> +
> >> +	/* try to find out clock frequency from DT as fallback */
> >>  	if (of_property_read_u32(np, "clock-frequency", &val)) {
> >> -		dev_err(p->dev, "no clock-frequency property set\n");
> >> +		dev_err(p->dev, "clk or clock-frequency not defined\n");
> >>  		return -EINVAL;
> >>  	}
> >>  	p->uartclk =3D val;
> >> @@ -294,9 +301,21 @@ static int dw8250_probe(struct platform_device *p=
dev)
> >>  	if (!uart.port.membase)
> >>  		return -ENOMEM;
> >>  =

> >> +	data =3D devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> >> +	if (!data)
> >> +		return -ENOMEM;
> >> +
> >> +	data->clk =3D devm_clk_get(&pdev->dev, NULL);
> >> +	if (IS_ERR(data->clk))
> >> +		data->clk =3D NULL;
> >> +	else
> >> +		clk_prepare_enable(data->clk);
> > =

> > 	if (!IS_ERR(data->clk))
> > 		clk_prepare_enable(data->clk);
> > =

> =

> See below
> =

> >> +
> >>  	uart.port.iotype =3D UPIO_MEM;
> >>  	uart.port.serial_in =3D dw8250_serial_in;
> >>  	uart.port.serial_out =3D dw8250_serial_out;
> >> +	uart.port.private_data =3D data;
> >> +	uart.port.uartclk =3D clk_get_rate(data->clk);
> > =

> > What if data->clk is invalid?
> > =

> > 	if (!IS_ERR(data->clk)
> > 		uart.port.uartclk =3D clk_get_rate(data->clk);
> > =

> =

> I'm not sure if it is coincidental or the way it is supposed to be, but
> when using the common clock framework, if you pass a NULL to
> clk_get_rate, the function explicitly checks for it and returns 0. I
> relied on that behaviour when implementing this; see the if..else block
> above. Is this not always the case on other clock drivers?

That's something that the common clock framework decided to do.  It's
not a defined part of the API though, so drivers shouldn't rely on
this behaviour meaning anything special.
