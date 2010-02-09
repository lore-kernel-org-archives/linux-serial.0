From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH v2] serial: spi: add spi-uart driver for Maxim 3110
Date: Mon, 8 Feb 2010 16:20:10 -0800
Message-ID: <20100208162010.b1f69728.akpm@linux-foundation.org>
References: <20091229222006.1ddb28a4@feng-desktop>
	<20100208165946.0e4dde83@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:32816 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750842Ab0BIAUY (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 8 Feb 2010 19:20:24 -0500
In-Reply-To: <20100208165946.0e4dde83@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>, Greg KH <greg@kroah.com>

On Mon, 8 Feb 2010 16:59:46 +0800
Feng Tang <feng.tang@intel.com> wrote:

> Hi All,
> 
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.
> 
> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
> provides a console.
> 
> change since v1:
> 	* Address comments from Alan Cox
> 	* Use a "use_irq" module parameter to runtime check whether
> 	  to use IRQ mode
> 	* Add the suspend/resume implementation
> 
> Thanks!
> Feng
> 
> >From 6d14c5d68cdae8d48b6d8a00b6653022f2b100d0 Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang@intel.com>
> Date: Mon, 8 Feb 2010 16:02:59 +0800
> Subject: [PATCH] serial: spi: add spi-uart driver for Maxim 3110
> 
> This is the driver for Max3110 SPI-UART device, which connect
> to host with SPI interface. It supports baud rates from 300 to
> 230400, and supports both polling and IRQ mode, as well as
> providing a console for system use
> 
> Its datasheet could be found here:
> http://datasheets.maxim-ic.com/en/ds/MAX3110E-MAX3111E.pdf
> 

I wonder if this is an "spi" subsystem thing or a "serial" subsystem
thing.  It looks more like a serial driver to me.

> ---
>  drivers/serial/Kconfig      |   12 +
>  drivers/serial/max3110.c    |  848 +++++++++++++++++++++++++++++++++++++++++++
>  drivers/serial/max3110.h    |   59 +++
>  include/linux/serial_core.h |    3 +


> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index 9ff47db..f7daf2f 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
>
> ...
>
> +static int use_irq = 1;
> +module_param(use_irq, int, 0444);
> +MODULE_PARM_DESC(use_irq, "Whether using Max3110's IRQ capability");
> +
> +static void receive_chars(struct uart_max3110 *max,
> +				unsigned char *str, int len);
> +static int max3110_read_multi(struct uart_max3110 *max, int len, u8 *buf);
> +static void max3110_con_receive(struct uart_max3110 *max);
> +
> +int max3110_write_then_read(struct uart_max3110 *max,
> +		const u8 *txbuf, u8 *rxbuf, unsigned len, int always_fast)

The driver has a number of identifiers which have global scope,
apparently unnecessarily.  Please review all such identifiers, see if
they can be made static.

> +{
> +	struct spi_device *spi = max->spi;
> +	struct spi_message	message;
> +	struct spi_transfer	x;
> +	int ret;
> +
> +	spi_message_init(&message);
> +	memset(&x, 0, sizeof x);
> +	x.len = len;
> +	x.tx_buf = txbuf;
> +	x.rx_buf = rxbuf;
> +	spi_message_add_tail(&x, &message);
> +
> +	if (always_fast)
> +		x.speed_hz = spi->max_speed_hz;
> +	else if (max->baud)
> +		x.speed_hz = max->baud;
> +
> +	/* Do the i/o */
> +	ret = spi_sync(spi, &message);
> +	return ret;
> +}
> +
> +/* Write a u16 to the device, and return one u16 read back */
> +int max3110_out(struct uart_max3110 *max, const u16 out)

Another.

> +{
> +	u16 tmp;
> +	int ret;
> +
> +	ret = max3110_write_then_read(max, (u8 *)&out, (u8 *)&tmp, 2, 1);

Something nasty is happening here.  Modifying a u16 via a u8* is to
assume a certain endianness, surely.  Will the driver break when used
on other-endian architectures?

> +	if (ret)
> +		return ret;
> +
> +	/* If some valid data is read back */
> +	if (tmp & MAX3110_READ_DATA_AVAILABLE) {
> +		tmp &= 0xff;
> +		receive_chars(max, (unsigned char *)&tmp, 1);
> +	}
> +
> +	return ret;
> +}
> +
> +#define MAX_READ_LEN	20
> +/*
> + * This is usually used to read data from SPIC RX FIFO, which doesn't
> + * need any delay like flushing character out.
> + * Returns how many valide bytes are read back
> + */
> +static int max3110_read_multi(struct uart_max3110 *max, int len, u8 *buf)
> +{
> +	u16 out[MAX_READ_LEN], in[MAX_READ_LEN];
> +	u8 *pbuf, valid_str[MAX_READ_LEN];
> +	int i, j, bytelen;
> +
> +	bytelen = len * 2;
> +	memset(out, 0, bytelen);
> +	memset(in, 0, bytelen);
> +
> +	if (max3110_write_then_read(max, (u8 *)out, (u8 *)in, bytelen, 1))
> +		return 0;
>

max3110_write_then_read() can return an error code (from spi_async()). 
But here that error code simply gets lost.  It should be reported to
higher-level code somehow?

> +	/* If caller doesn't provide a buffer, then handle received char */
> +	pbuf = buf ? buf : valid_str;
> +
> +	for (i = 0, j = 0; i < len; i++) {
> +		if (in[i] & MAX3110_READ_DATA_AVAILABLE)
> +			pbuf[j++] = (u8)(in[i] & 0xff);
> +	}
> +
> +	if (j && (pbuf == valid_str))
> +		receive_chars(max, valid_str, j);
> +
> +	return j;
> +}
> +
> +static void serial_m3110_con_putchar(struct uart_port *port, int ch)
> +{
> +	struct uart_max3110 *max =
> +		container_of(port, struct uart_max3110, port);
> +	struct circ_buf *xmit = &max->con_xmit;
> +
> +	if (uart_circ_chars_free(xmit)) {
> +		xmit->buf[xmit->head] = (char)ch;
> +		xmit->head = (xmit->head + 1) & (PAGE_SIZE - 1);
> +	}
> +
> +	if (!atomic_read(&max->con_tx_need)) {
> +		atomic_set(&max->con_tx_need, 1);

This manipulation of con_tx_need looks racy on SMP or preempt.

> +		wake_up_process(max->main_thread);
> +	}
> +}
> +
>
> ...
>
> +#define WORDS_PER_XFER	128
> +static inline void send_circ_buf(struct uart_max3110 *max,
> +				struct circ_buf *xmit)

I suggest that the `inline' be removed.  Modern gcc will take care of
this, if it is of benefit.

> +{
> +	int len, left = 0;
> +	u16 obuf[WORDS_PER_XFER], ibuf[WORDS_PER_XFER];
> +	u8 valid_str[WORDS_PER_XFER];
> +	int i, j;
> +
> +	while (!uart_circ_empty(xmit)) {
> +		left = uart_circ_chars_pending(xmit);
> +		while (left) {
> +			len = (left >= WORDS_PER_XFER) ? WORDS_PER_XFER : left;

Use

			len = min(left, WORDS_PER_XFER);

> +
> +			memset(obuf, 0, len * 2);
> +			memset(ibuf, 0, len * 2);

Using

			memset(obuf, 0, sizeof(obuf));

would remove the assumptions that a) obuf is of type u16 and b) that
sizeof(u16)==2.


> +			for (i = 0; i < len; i++) {
> +				obuf[i] = (u8)xmit->buf[xmit->tail] | WD_TAG;
> +				xmit->tail = (xmit->tail + 1) &
> +						(UART_XMIT_SIZE - 1);

Could this driver use include/linux/kfifo.h, rather than open-coding it?

> +			}
> +			max3110_write_then_read(max, (u8 *)obuf,
> +						(u8 *)ibuf, len * 2, 0);

Error codes are ignored.

> +			for (i = 0, j = 0; i < len; i++) {
> +				if (ibuf[i] & MAX3110_READ_DATA_AVAILABLE)
> +					valid_str[j++] = (u8)(ibuf[i] & 0xff);
> +			}
> +
> +			if (j)
> +				receive_chars(max, valid_str, j);
> +
> +			max->port.icount.tx += len;
> +			left -= len;
> +		}
> +	}
> +}
> +
>
> ...
>
> +static void max3110_con_receive(struct uart_max3110 *max)
> +{
> +	int loop = 1, num, total = 0;
> +	u8 recv_buf[512], *pbuf;
> +
> +	pbuf = recv_buf;
> +	do {
> +		/* 3110 RX buffer is 8 words */
> +		num = max3110_read_multi(max, 8, pbuf);
> +
> +		if (num) {
> +			loop = 5;
> +			pbuf += num;
> +			total += num;
> +
> +			if (total >= 500) {
> +				receive_chars(max, recv_buf, total);
> +				pbuf = recv_buf;
> +				total = 0;
> +			}
> +		}

hm, what do all the magic numbers do?  Some comments explaining them
would be good.

> +	} while (--loop);
> +
> +	if (total)
> +		receive_chars(max, recv_buf, total);
> +}
> +
> +static int max3110_main_thread(void *_max)
> +{
> +	struct uart_max3110 *max = _max;
> +	wait_queue_head_t *wq = &max->wq;
> +	int ret = 0;
> +	struct circ_buf *xmit = &max->con_xmit;
> +
> +	init_waitqueue_head(wq);
> +	pr_info(PR_FMT "start main thread\n");
> +
> +	do {
> +		wait_event_interruptible(*wq, (atomic_read(&max->irq_pending) ||
> +					       atomic_read(&max->con_tx_need) ||
> +					     atomic_read(&max->uart_tx_need)) ||
> +					     kthread_should_stop());
> +		max->mthread_up = 1;
> +
> +		if (use_irq && atomic_read(&max->irq_pending)) {
> +			max3110_con_receive(max);
> +			atomic_set(&max->irq_pending, 0);
> +		}

The manipulation of irq_pending looks racy.  Perhaps something list
test_and_clear_bit() would fix that.


> +		/* First handle console output */
> +		if (atomic_read(&max->con_tx_need)) {
> +			send_circ_buf(max, xmit);
> +			atomic_set(&max->con_tx_need, 0);
> +		}

Ditto.

> +		/* Handle uart output */
> +		if (atomic_read(&max->uart_tx_need)) {
> +			transmit_char(max);
> +			atomic_set(&max->uart_tx_need, 0);
> +		}

Ditto.

> +		max->mthread_up = 0;
> +	} while (!kthread_should_stop());
> +
> +	return ret;
> +}
> +
> +irqreturn_t static serial_m3110_irq(int irq, void *dev_id)

`static irqreturn_t' would be more typical.

> +{
> +	struct uart_max3110 *max = dev_id;
> +
> +	/* max3110's irq is a falling edge, not level triggered,
> +	 * so no need to disable the irq */
> +	if (!atomic_read(&max->irq_pending)) {
> +		atomic_inc(&max->irq_pending);

racy?

> +		wake_up_process(max->main_thread);
> +	}
> +	return IRQ_HANDLED;
> +}
> +
> +/* If don't use RX IRQ, then need a thread to polling read */
> +static int max3110_read_thread(void *_max)
> +{
> +	struct uart_max3110 *max = _max;
> +
> +	pr_info(PR_FMT "start read thread\n");
> +	do {
> +		if (!max->mthread_up)
> +			max3110_con_receive(max);
> +
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(HZ / 20);

Use schedule_timeout_interruptible()

> +	} while (!kthread_should_stop());
> +
> +	return 0;
> +}
> +
> +static int serial_m3110_startup(struct uart_port *port)
> +{
> +	struct uart_max3110 *max =
> +		container_of(port, struct uart_max3110, port);
> +	u16 config = 0;
> +	int ret = 0;
> +
> +	if (port->line != 0)
> +		pr_err(PR_FMT "uart port startup failed\n");
> +
> +	/* Firstly disable all IRQ and config it to 115200, 8n1 */
> +	config = WC_TAG | WC_FIFO_ENABLE
> +			| WC_1_STOPBITS
> +			| WC_8BIT_WORD
> +			| WC_BAUD_DR2;
> +	ret = max3110_out(max, config);
> +
> +	/* As we use thread to handle tx/rx, need set low latency */
> +	port->state->port.tty->low_latency = 1;
> +
> +	if (use_irq) {
> +		ret = request_irq(max->irq, serial_m3110_irq,
> +					IRQ_TYPE_EDGE_FALLING, "max3110", max);
> +		if (ret)
> +			return ret;
> +
> +		/* Enable RX IRQ only */
> +		config |= WC_RXA_IRQ_ENABLE;
> +		max3110_out(max, config);
> +	} else {
> +		/* if IRQ is disabled, start a read thread for input data */
> +		max->read_thread =
> +			kthread_run(max3110_read_thread, max, "max3110_read");

Check for kthread_run() failure?

> +	}
> +
> +	max->cur_conf = config;
> +	return 0;
> +}
> +
>
> ...
>
> +static int serial_m3110_probe(struct spi_device *spi)

Should this be __init or __devinit?

> +{
> +	struct uart_max3110 *max;
> +	int ret;
> +	unsigned char *buffer;
> +
> +	max = kzalloc(sizeof(*max), GFP_KERNEL);
> +	if (!max)
> +		return -ENOMEM;
> +
> +	/* set spi info */
> +	spi->mode = SPI_MODE_0;
> +	spi->bits_per_word = 16;
> +#ifdef CONFIG_MAX3110_DESIGNWARE
> +	spi->controller_data = &spi_uart;
> +#endif
> +	spi_setup(spi);
> +
> +	max->clock = MAX3110_HIGH_CLK;
> +	max->port.type = PORT_MAX3110;
> +	max->port.fifosize = 2;		/* only have 16b buffer */
> +	max->port.ops = &serial_m3110_ops;
> +	max->port.line = 0;
> +	max->port.dev = &spi->dev;
> +	max->port.uartclk = 115200;
> +
> +	max->spi = spi;
> +	max->name = spi->modalias;	/* use spi name as the name */
> +	max->irq = (u16)spi->irq;
> +
> +	spin_lock_init(&max->lock);
> +
> +	max->word_7bits = 0;
> +	max->parity = 0;
> +	max->baud = 0;
> +
> +	max->cur_conf = 0;
> +	atomic_set(&max->irq_pending, 0);
> +
> +	buffer = (unsigned char *)__get_free_page(GFP_KERNEL);
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto err_get_page;
> +	}
> +	max->con_xmit.buf = (unsigned char *)buffer;
> +	max->con_xmit.head = max->con_xmit.tail = 0;
> +
> +	max->main_thread = kthread_run(max3110_main_thread,
> +					max, "max3110_main");
> +	if (IS_ERR(max->main_thread)) {
> +		ret = PTR_ERR(max->main_thread);
> +		goto err_kthread;
> +	}
> +
> +	pmax = max;
> +	/* Give membase a psudo value to pass serial_core's check */
> +	max->port.membase = (void *)0xff110000;
> +	uart_add_one_port(&serial_m3110_reg, &max->port);
> +
> +	return 0;
> +
> +err_kthread:
> +	free_page((unsigned long)buffer);
> +err_get_page:
> +	pmax = NULL;
> +	kfree(max);
> +	return ret;
> +}
> +
>
> ...
>
> +static struct spi_driver uart_max3110_driver = {
> +	.driver = {
> +			.name	= "spi_max3111",
> +			.bus	= &spi_bus_type,
> +			.owner	= THIS_MODULE,
> +	},
> +	.probe		= serial_m3110_probe,
> +	.remove		= __devexit_p(max3110_remove),
> +	.suspend	= serial_m3110_suspend,
> +	.resume		= serial_m3110_resume,
> +};
> +
> +int __init serial_m3110_init(void)

static?

> +{
> +	int ret = 0;
> +
> +	ret = uart_register_driver(&serial_m3110_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = spi_register_driver(&uart_max3110_driver);
> +	if (ret)
> +		uart_unregister_driver(&serial_m3110_reg);
> +
> +	return ret;
> +}
> +
> +void __exit serial_m3110_exit(void)

static?

> +{
> +	spi_unregister_driver(&uart_max3110_driver);
> +	uart_unregister_driver(&serial_m3110_reg);
> +}
> +
>
> ...
>

