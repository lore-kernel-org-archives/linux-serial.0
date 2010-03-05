From: Erwin Authried <eauth@softsys.co.at>
Subject: Re: [spi-devel-general] [PATCH v6] serial: spi: add spi-uart
 driver for Maxim 3110
Date: Fri, 05 Mar 2010 08:44:50 +0100
Message-ID: <1267775090.1941.31.camel@affe>
References: <20100304152524.56055828@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from viefep15-int.chello.at ([62.179.121.35]:55772 "EHLO
	viefep15-int.chello.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160Ab0CEIAe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Mar 2010 03:00:34 -0500
In-Reply-To: <20100304152524.56055828@feng-i7>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@lxorguk.ukuu.org.uk>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, linux-serial@vger.kernel.org

Am Donnerstag, den 04.03.2010, 15:25 +0800 schrieb Feng Tang:
> Hi All,
> 
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.
> 
> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c &
> dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
> provides a console.
> 
> change log:
>  since v5:
>         * Make the spi data buffer DMA safe, thanks to Mssakazu Mokuno, 
>           David Brownell and Grant Likely for pointing the bug out
>  since v4:
>         * Add explanation why not using DMA
>         * Fix a bug in max3110_read_multi()
>  since v3:
>         * Remove the Designware controller related stuff
>         * Remove some initialization code which should be done in the platform
>           setup code
>         * Add a missing change for drivers/serial/Makefile
>  since v2:
>         * Address comments from Andrew Morton
>         * Use test/set_bit to avoid race condition for SMP/preempt case
>         * Fix bug related with endian order
>  since v1:
>         * Address comments from Alan Cox
>         * Use a "use_irq" module parameter to runtime check whether
>           to use IRQ mode
>         * Add the suspend/resume implementation
> 
> Thanks!
> Feng

Hi,

the only thing that I still don't like is the way of sending characters.
Basically, the spi rate is set to the actual baud rate when characters
are transmitted to the uart, and multiple characters are sent without
looking at the status of the uart.

The spi rate and the uart clock aren't synchronized, what happens if the
spi rate is slightly higher than the MAX3100's baud rate clock?
In addition, if there are other devices on the spi bus, the bus will be
occupied unnecessarily long, especially when low baudrates are used.

One other small cosmetic thing:
in serial_m3110_tx_empty(), TIOCSER_TEMT should be returned instead of
1.

-Erwin



