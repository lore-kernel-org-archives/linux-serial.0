From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v2] serial: atmel: Use atmel_port consistently
Date: Tue, 26 Jan 2016 12:17:59 +0100
Message-ID: <56A755E7.2000302@atmel.com>
References: <1452817319-9309-1-git-send-email-kyle.roeschley@ni.com>
 <1453806246-13405-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453806246-13405-1-git-send-email-nicolas.ferre@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org
Cc: Jaeden Amero <jaeden.amero@ni.com>, kyle.roeschley@ni.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

Le 26/01/2016 12:04, Nicolas Ferre a =E9crit :
> From: Jaeden Amero <jaeden.amero@ni.com>
>=20
> In all functions other than atmel_serial_probe_fifos,
> atmel_serial_probe, and atmel_console_init, the name "port" is used t=
o
> refer to an instance of struct uart_port. In many of these functions,
> "atmel_port" is used to refer to an instance of struct atmel_uart_por=
t.
>=20
> We make the use of the name "port" consistent by making
> atmel_serial_probe_fifos, atmel_serial_probe, and atmel_console_init
> use "atmel_port" to refer to an instance of struct atmel_uart_port
> instead of the previous name of "port".
>=20
> Signed-off-by: Jaeden Amero <jaeden.amero@ni.com>
> Signed-off-by: Kyle Roeschley <kyle.roeschley@ni.com>
> Acked-by: Karthik Manamcheri <karthik.manamcheri@ni.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
> v2: - fix typo in variable

Okay, let's face it: this patch is outdated.

So this v2 still fails to compile. Before hiding in a deep hole, I
recompile this driver, test it and send a v3. Here again, sorry for the
noise :-(

Bye,


>  drivers/tty/serial/atmel_serial.c | 81 ++++++++++++++++++++---------=
----------
>  1 file changed, 41 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/a=
tmel_serial.c
> index 1c0884d8ef32..555111955b75 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -2478,13 +2478,13 @@ static int __init atmel_console_init(void)
>  		struct atmel_uart_data *pdata =3D
>  			dev_get_platdata(&atmel_default_console_device->dev);
>  		int id =3D pdata->num;
> -		struct atmel_uart_port *port =3D &atmel_ports[id];
> +		struct atmel_uart_port *atmel_port =3D &atmel_ports[id];
> =20
> -		port->backup_imr =3D 0;
> -		port->uart.line =3D id;
> +		atmel_port->backup_imr =3D 0;
> +		atmel_port->uart.line =3D id;
> =20
>  		add_preferred_console(ATMEL_DEVICENAME, id, NULL);
> -		ret =3D atmel_init_port(port, atmel_default_console_device);
> +		ret =3D atmel_init_port(atmel_port, atmel_default_console_device);
>  		if (ret)
>  			return ret;
>  		register_console(&atmel_console);
> @@ -2599,23 +2599,23 @@ static int atmel_serial_resume(struct platfor=
m_device *pdev)
>  #define atmel_serial_resume NULL
>  #endif
> =20
> -static void atmel_serial_probe_fifos(struct atmel_uart_port *port,
> +static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_p=
ort,
>  				     struct platform_device *pdev)
>  {
> -	port->fifo_size =3D 0;
> -	port->rts_low =3D 0;
> -	port->rts_high =3D 0;
> +	atmel_port->fifo_size =3D 0;
> +	atmel_port->rts_low =3D 0;
> +	atmel_port->rts_high =3D 0;
> =20
>  	if (of_property_read_u32(pdev->dev.of_node,
>  				 "atmel,fifo-size",
> -				 &port->fifo_size))
> +				 &atmel_port->fifo_size))
>  		return;
> =20
> -	if (!port->fifo_size)
> +	if (!atmel_port->fifo_size)
>  		return;
> =20
> -	if (port->fifo_size < ATMEL_MIN_FIFO_SIZE) {
> -		port->fifo_size =3D 0;
> +	if (atmel_port->fifo_size < ATMEL_MIN_FIFO_SIZE) {
> +		atmel_port->fifo_size =3D 0;
>  		dev_err(&pdev->dev, "Invalid FIFO size\n");
>  		return;
>  	}
> @@ -2628,22 +2628,22 @@ static void atmel_serial_probe_fifos(struct a=
tmel_uart_port *port,
>  	 * Threshold to a reasonably high value respecting this 16 data
>  	 * empirical rule when possible.
>  	 */
> -	port->rts_high =3D max_t(int, port->fifo_size >> 1,
> -			       port->fifo_size - ATMEL_RTS_HIGH_OFFSET);
> -	port->rts_low  =3D max_t(int, port->fifo_size >> 2,
> -			       port->fifo_size - ATMEL_RTS_LOW_OFFSET);
> +	atmel_port->rts_high =3D max_t(int, atmel_port->fifo_size >> 1,
> +			       atmel_port->fifo_size - ATMEL_RTS_HIGH_OFFSET);
> +	atmel_port->rts_low  =3D max_t(int, atmel_port->fifo_size >> 2,
> +			       atmel_port->fifo_size - ATMEL_RTS_LOW_OFFSET);
> =20
>  	dev_info(&pdev->dev, "Using FIFO (%u data)\n",
> -		 port->fifo_size);
> +		 atmel_port->fifo_size);
>  	dev_dbg(&pdev->dev, "RTS High Threshold : %2u data\n",
> -		port->rts_high);
> +		atmel_port->rts_high);
>  	dev_dbg(&pdev->dev, "RTS Low Threshold  : %2u data\n",
> -		port->rts_low);
> +		atmel_port->rts_low);
>  }
> =20
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
> -	struct atmel_uart_port *port;
> +	struct atmel_uart_port *atmel_port;
>  	struct device_node *np =3D pdev->dev.of_node;
>  	struct atmel_uart_data *pdata =3D dev_get_platdata(&pdev->dev);
>  	void *data;
> @@ -2674,14 +2674,14 @@ static int atmel_serial_probe(struct platform=
_device *pdev)
>  		goto err;
>  	}
> =20
> -	port =3D &atmel_ports[ret];
> -	port->backup_imr =3D 0;
> -	port->uart.line =3D ret;
> -	atmel_serial_probe_fifos(port, pdev);
> +	atmel_port =3D &atmel_ports[ret];
> +	atmel_port->backup_imr =3D 0;
> +	atmel_port->uart.line =3D ret;
> +	atmel_serial_probe_fifos(atmel_port, pdev);
> =20
> -	spin_lock_init(&port->lock_suspended);
> +	spin_lock_init(&atmel_port->lock_suspended);
> =20
> -	ret =3D atmel_init_port(port, pdev);
> +	ret =3D atmel_init_port(atmel_port, pdev);
>  	if (ret)
>  		goto err_clear_bit;
> =20
> @@ -2691,34 +2691,34 @@ static int atmel_serial_probe(struct platform=
_device *pdev)
>  		goto err_clear_bit;
>  	}
> =20
> -	if (!atmel_use_pdc_rx(&port->uart)) {
> +	if (!atmel_use_pdc_rx(&atmel_port->uart)) {
>  		ret =3D -ENOMEM;
>  		data =3D kmalloc(sizeof(struct atmel_uart_char)
>  				* ATMEL_SERIAL_RINGSIZE, GFP_KERNEL);
>  		if (!data)
>  			goto err_alloc_ring;
> -		port->rx_ring.buf =3D data;
> +		atmel_port->rx_ring.buf =3D data;
>  	}
> =20
> -	rs485_enabled =3D port->uart.rs485.flags & SER_RS485_ENABLED;
> +	rs485_enabled =3D atmel_port->uart.rs485.flags & SER_RS485_ENABLED;
> =20
> -	ret =3D uart_add_one_port(&atmel_uart, &port->uart);
> +	ret =3D uart_add_one_port(&atmel_uart, &atmel_port->uart);
>  	if (ret)
>  		goto err_add_port;
> =20
>  #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
> -	if (atmel_is_console_port(&port->uart)
> +	if (atmel_is_console_port(&atmel_port->uart)
>  			&& ATMEL_CONSOLE_DEVICE->flags & CON_ENABLED) {
>  		/*
>  		 * The serial core enabled the clock for us, so undo
>  		 * the clk_prepare_enable() in atmel_console_setup()
>  		 */
> -		clk_disable_unprepare(port->clk);
> +		clk_disable_unprepare(atmel_port->clk);
>  	}
>  #endif
> =20
>  	device_init_wakeup(&pdev->dev, 1);
> -	platform_set_drvdata(pdev, port);
> +	platform_set_drvdata(pdev, atmel_port);
> =20
>  	/*
>  	 * The peripheral clock has been disabled by atmel_init_port():
> @@ -2727,9 +2727,10 @@ static int atmel_serial_probe(struct platform_=
device *pdev)
>  	clk_prepare_enable(port->clk);
> =20
>  	if (rs485_enabled) {
> -		atmel_uart_writel(&port->uart, ATMEL_US_MR,
> +		atmel_uart_writel(&atmel_port->uart, ATMEL_US_MR,
>  				  ATMEL_US_USMODE_NORMAL);
> -		atmel_uart_writel(&port->uart, ATMEL_US_CR, ATMEL_US_RTSEN);
> +		atmel_uart_writel(&atmel_port->uart, ATMEL_US_CR,
> +				  ATMEL_US_RTSEN);
>  	}
> =20
>  	/*
> @@ -2746,12 +2747,12 @@ static int atmel_serial_probe(struct platform=
_device *pdev)
>  	return 0;
> =20
>  err_add_port:
> -	kfree(port->rx_ring.buf);
> -	port->rx_ring.buf =3D NULL;
> +	kfree(atmel_port->rx_ring.buf);
> +	atmel_port->rx_ring.buf =3D NULL;
>  err_alloc_ring:
> -	if (!atmel_is_console_port(&port->uart)) {
> -		clk_put(port->clk);
> -		port->clk =3D NULL;
> +	if (!atmel_is_console_port(&atmel_port->uart)) {
> +		clk_put(atmel_port->clk);
> +		atmel_port->clk =3D NULL;
>  	}
>  err_clear_bit:
>  	clear_bit(port->uart.line, atmel_ports_in_use);
>=20


--=20
Nicolas Ferre
