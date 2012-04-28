From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] usb: cp210x: Added support for GPIO (CP2103/4/5)
Date: Sat, 28 Apr 2012 19:05:02 +0100
Message-ID: <20120428190502.32eaf294@pyramind.ukuu.org.uk>
References: <1335632134-2488-1-git-send-email-preston.fick@silabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1335632134-2488-1-git-send-email-preston.fick@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preston Fick <pffick@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, preston.fick@silabs.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


>   */
> @@ -424,8 +430,8 @@ static int cp210x_open(struct tty_struct *tty, struct usb_serial_port *port)
>  
>  	dbg("%s - port %d", __func__, port->number);
>  
> -	result = cp210x_set_config_single(port, CP210X_IFC_ENABLE,
> -								UART_ENABLE);
> +	result = cp210x_set_config(port, REQTYPE_HOST_TO_INTERFACE,
> +				CP210X_IFC_ENABLE, UART_ENABLE, NULL, 0);

These kind of unrelated changes make review hard. Why are they there ?

> +	case IOCTL_GPIOGET:
> +		if ((port_priv->bPartNumber == CP2103_PARTNUM) ||


All the part specific stuff in ifs rapidly gets unmaintainable. Better to
set up a port_priv->get_gpio/set_gpio.

>  /*
>   * cp210x_get_termios
>   * Reads the baud rate, data bits, parity, stop bits and flow control mode
> @@ -490,14 +565,16 @@ static void cp210x_get_termios_port(struct usb_serial_port *port,
>  
>  	dbg("%s - port %d", __func__, port->number);
>  
> -	cp210x_get_config(port, CP210X_GET_BAUDRATE, &baud, 4);
> +	cp210x_get_config(port, REQTYPE_INTERFACE_TO_HOST,
> +			CP210X_GET_BAUDRATE, 0, &baud, 4);


And again it disturbs all the rest of the code for no apparent good
reason.

  
The large number of changes all over the code for a single localised
feature change ought to be flagging up that it's not being done in a
clean way.

The other question is whether having some custom gpio poking interface is
actually a good idea. I suspect probably not. The kernel gpio layer can
help a bit but doesn't really solve the problem as there is no way to tie
a gpio to a port. Given how many devices seem to have gpios these days I
wonder if we need a gpio setting interface via termiox.

We could also the agree how that maps onto the extra gpio lines used with
SIM card readers and the like so we can standardise that.

Alan
