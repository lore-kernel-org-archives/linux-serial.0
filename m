From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: [RFC][PATCH] serial: spi: add spi-uart
	driver for Maxim 3110
Date: Tue, 29 Dec 2009 15:02:13 +0000
Message-ID: <20091229150213.3c50b7b3@lxorguk.ukuu.org.uk>
References: <20091229222006.1ddb28a4@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091229222006.1ddb28a4@feng-desktop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

> As a RFC, the driver doesn't have a valid UART port type yet, but borrow
> PORT_PXA. I would apply one if there is no main objection for it.

Please just add a new uart type for it.

> +config MAX3110_DESIGNWARE
> +	boolean "Enable Max3110 to work with Designware controller"
> +	default y
> +	depends on SERIAL_MAX3110
> +
> +config MAX3110_IRQ
> +	boolean "Enable IRQ for Max3110"
> +	default n
> +	depends on SERIAL_MAX3110
> +

These should be runtime


> +int max3110_write_then_read(struct uart_max3110 *max,
> +		const u8 *txbuf, u8 *rxbuf, unsigned len, int always_fast)
> +{
> +	struct spi_device *spi = max->spi;
> +	struct spi_message	message;
> +	struct spi_transfer	x;
> +	int ret;
> +
> +	if (!txbuf || !rxbuf)
> +		return -EINVAL;

How can the above occur - it seems no user triggered event can cause it
and almost all the paths then lose the error before userspace gets it
(and silently).


> +	if (len > MAX_READ_LEN) {
> +		pr_err(PR_FMT "read len %d is too large\n", len);
> +		return 0;
> +	}

Ditto


> +	while (len) {
> +		usable = tty_buffer_request_room(tty, len);
> +		if (usable) {
> +			tty_insert_flip_string(tty, str, usable);
> +			str += usable;
> +			port->icount.rx += usable;
> +			tty_flip_buffer_push(tty);

You really only want to push once. tty_insert_flip_string also knows
about multiple blocks so all of this can be a single

	tty_insert_flip_string(tty, str, len);
	tty_flip_buffer_push(tty);


>
> +static void
> +serial_m3110_set_termios(struct uart_port *port, struct ktermios *termios,
> +		       struct ktermios *old)
> +{
> +	struct uart_max3110 *max =
> +		container_of(port, struct uart_max3110, port);
> +	unsigned char cval;
> +	unsigned int baud, parity = 0;
> +	int clk_div = -1;
> +	u16 new_conf = max->cur_conf;
> +
> +	switch (termios->c_cflag & CSIZE) {
> +	case CS7:
> +		cval = UART_LCR_WLEN7;
> +		new_conf |= WC_7BIT_WORD;
> +		break;
> +	default:
> +	case CS8:
> +		cval = UART_LCR_WLEN8;
> +		new_conf |= WC_8BIT_WORD;

If you can only do CS8 when asked for other values you need to update the
termios struct to report that

		termios->c_cflag &= ~CSIZE;
		termios->c_flag |= CS8;

> +	if (!(termios->c_cflag & PARODD))
> +		parity |= UART_LCR_EPAR;
> +	max->parity = parity;
> +
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	new_conf |= WC_TAG;
> +	if (new_conf != max->cur_conf) {
> +		max3110_out(max, new_conf);
> +		max->cur_conf = new_conf;
> +		max->baud = baud;
> +	}

And as you don't support it

	termios->c_cflag &= ~CMSPAR;


I'll take a more serious look over it in the new year when I'm back at
work.


------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
