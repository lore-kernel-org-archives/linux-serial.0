From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH 03/15] dmaengine: dw: rename masters to reflect actual
 topology
Date: Sun, 24 Jan 2016 21:09:59 +0100
Message-ID: <20160124200959.GA15633@samfundet.no>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-4-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453663322-14474-4-git-send-email-mans@mansr.com>
Sender: linux-ide-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org, linux-ide@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Around Sun 24 Jan 2016 19:21:50 +0000 or thereabout, Mans Rullgard wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> The source and destination masters are reflecting buses or their layers to
> where the different devices can be connected. The patch changes the master
> names to reflect which one is related to which independently on the transfer
> direction.
> 
> The outcome of the change is that the memory data width is now always limited
> by a data width of the master which is dedicated to communicate to memory.
> 
> The patch will not break anything since all current users have the same data
> width for all masters. Though it would be nice to revisit avr32 plaforms to
> check what is the actual hardware topology is used there. It seems that it has
> one bus and two masters on it as stated by Table 8-2, that's why everything
> works independently on the master in use. The purpose of the sequential patch
> is to fix the driver for configuration of more that one bus.

Not entirely sure what you want to have confirmed here. There are multiple
masters and slaves on the HMATRIX internal bus on AVR32, and the DMA
controller supports up to three simultaneous configurations.

Sounds good to support configuration of more than one bus. I thought we
always did support that? Perhaps it was a non-standard avr32 implementation.

> The change is done in the assumption that src_master and dst_master are
> reflecting a connection to the memory and peripheral correspondently on all
> platforms except 460ex.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mans Rullgard <mans@mansr.com>

For the avr32 related stuff:

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

> ---
>  Documentation/devicetree/bindings/dma/snps-dma.txt |  4 ++--
>  arch/avr32/mach-at32ap/at32ap700x.c                | 16 ++++++++--------
>  drivers/ata/sata_dwc_460ex.c                       |  4 ++--
>  drivers/dma/dw/core.c                              | 15 +++++++--------
>  drivers/dma/dw/platform.c                          | 12 ++++++------
>  drivers/dma/dw/regs.h                              |  4 ++--
>  drivers/spi/spi-pxa2xx-pci.c                       |  8 ++++----
>  drivers/tty/serial/8250/8250_pci.c                 |  8 ++++----
>  include/linux/platform_data/dma-dw.h               |  8 ++++----
>  9 files changed, 39 insertions(+), 40 deletions(-)

<snipp diff>

-- 
Best regards, Hans-Christian Egtvedt
