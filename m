From: Baruch Siach <baruch@tkos.co.il>
Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-uart
 driver for Maxim 3110
Date: Tue, 29 Dec 2009 16:59:53 +0200
Message-ID: <20091229145953.GC27213@jasper.tkos.co.il>
References: <20091229222006.1ddb28a4@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tango.tkos.co.il ([62.219.50.35]:45348 "EHLO tango.tkos.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752383AbZL2Pqr (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 29 Dec 2009 10:46:47 -0500
Content-Disposition: inline
In-Reply-To: <20091229222006.1ddb28a4@feng-desktop>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Feng Tang <feng.tang@intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>, David Brownell <dbrownell@users.sourceforge.net>, Grant Likely <grant.likely@secretlab.ca>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, Andrew Morton <akpm@linux-foundation.org>

Hi Feng,

On Tue, Dec 29, 2009 at 10:20:06PM +0800, Feng Tang wrote:
> Here is a driver for Maxim 3110 SPI-UART device, please help to review.

Is this 3110 device so significantly different from the MAX3100 driver that's 
already in the mainline kernel (drivers/serial/max3100.c), to require a whole 
new driver? 

> It has been validated with Designware SPI controller (drivers/spi: dw_spi.c 
> & dw_spi_pci.c). It supports polling and IRQ mode, supports batch read, and
> provides a console.

baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
