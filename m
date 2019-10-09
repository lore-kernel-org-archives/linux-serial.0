From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: Serial 8250 DMA Broken on OMAP3630
Date: Wed, 9 Oct 2019 19:13:00 +0530
Message-ID: <3d5b3a12-a21c-f464-e7d1-252ccd768ff8@ti.com>
References: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHCN7x+oXNA6WRiq1OnDdcgDTJrm-QyazyYLw-ow0vPMMmrVbQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Ford <aford173@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Douglas Anderson <dianders@chromium.org>, Tony Lindgren <tony@atomide.com>, Yegor Yefremov <yegorslists@googlemail.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Adam,

On 06/10/19 10:34 PM, Adam Ford wrote:
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

Mainline omap-serial does not support DMA (evident from lack of
dmaengine API calls) and therefore is not a regression. So OMAP3 UART
DMA was never tested at least with 8250 driver.
I am not sure enabling UART DMA on OMAP3 would be a trivial job. We need
analyse of whether all erratas workarounds are implemented and see if
there any difference wrt DMA integration itself. Do we know if UART DMA
ever worked on OMAP3 previously?

> adam
> 

-- 
Regards
Vignesh
