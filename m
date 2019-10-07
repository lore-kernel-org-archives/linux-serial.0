From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Date: Mon, 7 Oct 2019 11:17:26 +0300
Message-ID: <20191007081726.GK32742@smile.fi.intel.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vignesh R <vigneshr@ti.com>, Douglas Anderson <dianders@chromium.org>, Tony Lindgren <tony@atomide.com>, Yegor Yefremov <yegorslists@googlemail.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Sun, Oct 06, 2019 at 12:04:47PM -0500, Adam Ford wrote:

I think the best one who may shed a light is bigeasy@ (Cc'ed).

> Has anyone else had any issues using the CONFIG_SERIAL_8250_DMA on the OMAP?
> 
> I can use the DMA on the legacy, omap-serial driver, but when I enable
> the DMA on the 8250-omap driver, I get missing frames in Bluetooth.
> 
> The older driver seems to have an ISR that seems to address a variety
> of items compared to the very tiny ISR for 8250-omap.c.
> 
> I am not exactly sure where to start, but if someone has any
> suggestions on how I can troubleshoot, please let me know.  As of now,
> I have to disable CONFIG_SERIAL_8250_DMA to get the Bluetooth
> connected to UART2 operational on a DM3730 at 3,000,000 baud, but it
> appears to work just fine after some patches I just submitted for
> handling RTS/CTS.  The legacy omap-serial driver works fine with DMA.
> 
> adam

-- 
With Best Regards,
Andy Shevchenko
