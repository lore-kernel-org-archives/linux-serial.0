From: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Subject: Re: [PATCH v4] serial: spi: add spi-uart driver for Maxim 3110
Date: Fri, 26 Feb 2010 18:59:38 +0900
Message-ID: <201002260959.o1Q9xIVA021953@imail.sm.sony.co.jp>
References: <20100224131130.61530b62@feng-i7> <20100226114729.679bb933@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ms6.sony.co.jp ([211.125.136.204]:38973 "EHLO ms6.sony.co.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933383Ab0BZKZV (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 26 Feb 2010 05:25:21 -0500
In-Reply-To: <20100226114729.679bb933@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg KH <greg@kroah.com>, David Brownell <dbrownell@users.sourceforge.net>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

Hi,

On Fri, 26 Feb 2010 11:47:29 +0800
Feng Tang <feng.tang@intel.com> wrote:

> Hi All,
> 
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.

<snip>

> +/*
> + * This is usually used to read data from SPIC RX FIFO, which doesn't
> + * need any delay like flushing character out.
> + *
> + * Return how many valide bytes are read back
> + */
> +static int max3110_read_multi(struct uart_max3110 *max, u8 *buf)
> +{
> +	u16 obuf[M3110_RX_FIFO_DEPTH], ibuf[M3110_RX_FIFO_DEPTH];

Doing I/O on stack is guaranteed safe for spi functions?

> +	u8 *pbuf, valid_str[M3110_RX_FIFO_DEPTH];
> +	int i, j;
> +
> +	memset(obuf, 0, sizeof(obuf));
> +	memset(obuf, 0, sizeof(ibuf));

memset(ibuf, 0, sizeof(ibuf))?

> +
> +	if (max3110_write_then_read(max, obuf, ibuf,
> +				M3110_RX_FIFO_DEPTH * 2, 1))
> +		return 0;
> +
> +	/* If caller doesn't provide a buffer, then handle received char */
> +	pbuf = buf ? buf : valid_str;
> +
> +	for (i = 0, j = 0; i < M3110_RX_FIFO_DEPTH; i++) {
> +		if (ibuf[i] & MAX3110_READ_DATA_AVAILABLE)
> +			pbuf[j++] = ibuf[i] & 0xff;
> +	}
> +
> +	if (j && (pbuf == valid_str))
> +		receive_chars(max, valid_str, j);
> +
> +	return j;

-- 
Masakazu Mokuno

