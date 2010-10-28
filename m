From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] ifx6x60: SPI protocol driver for Infineon 6x60 modem
Date: Thu, 28 Oct 2010 14:35:02 -0400
Message-ID: <AANLkTi=rPb9z5h3Zaq0vNJdqcGPjrsWpkCNbZRqsjvjP@mail.gmail.com>
References: <20101026131325.4506.1135.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58779 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761242Ab0J1SfD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Oct 2010 14:35:03 -0400
Received: by qyk12 with SMTP id 12so5768437qyk.19
        for <linux-serial@vger.kernel.org>; Thu, 28 Oct 2010 11:35:02 -0700 (PDT)
In-Reply-To: <20101026131325.4506.1135.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-serial@vger.kernel.org, spi-devel-general@lists.sourceforge.net

2010/10/26 Alan Cox <alan@lxorguk.ukuu.org.uk>:

Sorry for just reviewing the structs at this point but I hope it
helps out...

> diff --git a/drivers/serial/ifx6x60.h b/drivers/serial/ifx6x60.h
> new file mode 100644
> index 0000000..deb7b8d
> --- /dev/null
> +++ b/drivers/serial/ifx6x60.h
> (...)
> +struct ifx_spi_device {
> + =A0 =A0 =A0 /* Our SPI device */
> + =A0 =A0 =A0 struct spi_device *spi_dev;
> +
> + =A0 =A0 =A0 /* Port specific data */
> + =A0 =A0 =A0 struct kfifo tx_fifo;
> + =A0 =A0 =A0 spinlock_t fifo_lock;
> + =A0 =A0 =A0 unsigned long signal_state;
> +
> + =A0 =A0 =A0 /* TTY Layer logic */
> + =A0 =A0 =A0 struct tty_port tty_port;
> + =A0 =A0 =A0 struct device *tty_dev;
> + =A0 =A0 =A0 int minor;
> +
> + =A0 =A0 =A0 /* Low level I/O work */
> + =A0 =A0 =A0 struct tasklet_struct io_work_tasklet;
> + =A0 =A0 =A0 unsigned long flags;
> + =A0 =A0 =A0 dma_addr_t rx_dma;
> + =A0 =A0 =A0 dma_addr_t tx_dma;
> +
> + =A0 =A0 =A0 int is_6160; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0/* Modem type */

Should this be a bool? It is suspiciously named much
like something boolean.

> +
> + =A0 =A0 =A0 spinlock_t write_lock;
> + =A0 =A0 =A0 int write_pending;

This should be a bool.

> + =A0 =A0 =A0 spinlock_t power_lock;
> + =A0 =A0 =A0 unsigned char power_status;

This piece of comments from the ifx_spi_power_state_clear
kerneldoc:
"+ *     ifx_spi_power_state_clear       -       clear power bit"
Actually indicates that this is also a bool, albeit using some
opaque "val" to set/clear it. The code handling this flag really
needs an overhaul or I'm not reading it right.

> + =A0 =A0 =A0 unsigned char *rx_buffer;
> + =A0 =A0 =A0 unsigned char *tx_buffer;
> + =A0 =A0 =A0 dma_addr_t rx_bus;
> + =A0 =A0 =A0 dma_addr_t tx_bus;
> + =A0 =A0 =A0 unsigned char spi_more;
> + =A0 =A0 =A0 unsigned char spi_slave_cts;
> +
> + =A0 =A0 =A0 struct timer_list spi_timer;
> +
> + =A0 =A0 =A0 struct spi_message spi_msg;
> + =A0 =A0 =A0 struct spi_transfer spi_xfer;
> +
> + =A0 =A0 =A0 struct {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* gpio lines */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short srdy; =A0 =A0 =A0 =A0 =A0=
 =A0/* slave-ready gpio */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short mrdy; =A0 =A0 =A0 =A0 =A0=
 =A0/* master-ready gpio */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short reset; =A0 =A0 =A0 =A0 =A0=
 /* modem-reset gpio */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short po; =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* modem-on gpio */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned short reset_out; =A0 =A0 =A0 /=
* modem-in-reset gpio */

Is there something wrong about using u16 for these?
If it's to fit the gpio function it ought to be unsigned int
I believe.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* state/stats */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int unack_srdy_int_nb;

I don't get that comment above. This seems to be some
interrupt counter, this whole struct may need some kerneldoc.

> + =A0 =A0 =A0 } gpio;
> +
> + =A0 =A0 =A0 /* modem reset */
> + =A0 =A0 =A0 unsigned long mdm_reset_state;
> +#define MR_START =A0 =A0 =A0 0
> +#define MR_INPROGRESS =A01
> +#define MR_COMPLETE =A0 =A02
> + =A0 =A0 =A0 wait_queue_head_t mdm_reset_wait;
> +};
> +
> +#endif /* _IFX6X60_H */
> diff --git a/include/linux/spi/ifx_modem.h b/include/linux/spi/ifx_mo=
dem.h
> new file mode 100644
> index 0000000..a68f3b1
> --- /dev/null
> +++ b/include/linux/spi/ifx_modem.h
> @@ -0,0 +1,14 @@
> +#ifndef LINUX_IFX_MODEM_H
> +#define LINUX_IFX_MODEM_H
> +

/**
 * Insert some kerneldoc of struct fields here, I think
 * it'd be nice.
 */

> +struct ifx_modem_platform_data {
> + =A0 =A0 =A0 unsigned short rst_out; /* modem reset out */
> + =A0 =A0 =A0 unsigned short pwr_on; =A0/* power on */
> + =A0 =A0 =A0 unsigned short rst_pmu; /* reset modem */
> + =A0 =A0 =A0 unsigned short tx_pwr; =A0/* modem power threshold */
> + =A0 =A0 =A0 unsigned short srdy; =A0 =A0/* SRDY */
> + =A0 =A0 =A0 unsigned short mrdy; =A0 =A0/* MRDY */

If these are GPIO pins they should be unsigned int I believe.

> + =A0 =A0 =A0 unsigned short is_6160; /* Modem type */

=2E. is this bool?

> +};
> +
> +#endif

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
