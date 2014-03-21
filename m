From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2] tty: serial: sc16is7xx
Date: Fri, 21 Mar 2014 10:26:09 +0200
Message-ID: <20140321082609.GA3801@xps8300>
References: <1395324333-21221-1-git-send-email-jon@ringle.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:9560 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaCUI0Q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 04:26:16 -0400
Content-Disposition: inline
In-Reply-To: <1395324333-21221-1-git-send-email-jon@ringle.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: jon@ringle.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, shc_work@mail.ru, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, Jon Ringle <jringle@gridpoint.com>

Hi,

On Thu, Mar 20, 2014 at 10:05:33AM -0400, jon@ringle.org wrote:
> From: Jon Ringle <jringle@gridpoint.com>
>=20
> The SC16IS7xx is a slave I2C-bus/SPI interface to a single-channel
> high performance UART. The SC16IS7xx=E2=80=99s internal register set =
is
> backward-compatible with the widely used and widely popular 16C450.

So couldn't this be just a probe driver for 8250?

> +/* SC16IS7XX register definitions */
> +#define SC16IS7XX_RHR_REG		(0x00) /* RX FIFO */
> +#define SC16IS7XX_THR_REG		(0x00) /* TX FIFO */
> +#define SC16IS7XX_IER_REG		(0x01) /* Interrupt enable */
> +#define SC16IS7XX_IIR_REG		(0x02) /* Interrupt Identification */
> +#define SC16IS7XX_FCR_REG		(0x02) /* FIFO control */
> +#define SC16IS7XX_LCR_REG		(0x03) /* Line Control */
> +#define SC16IS7XX_MCR_REG		(0x04) /* Modem Control */
> +#define SC16IS7XX_LSR_REG		(0x05) /* Line Status */
> +#define SC16IS7XX_MSR_REG		(0x06) /* Modem Status */
> +#define SC16IS7XX_SPR_REG		(0x07) /* Scratch Pad */

At least there should not be any need to redefine those register or
their bits. Just include serial_reg.h.

Thanks,

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
