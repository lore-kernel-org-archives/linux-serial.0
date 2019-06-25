From: Christoph Hellwig <hch@lst.de>
Subject: DMA coherency in drivers/tty/serial/mpsc.c
Date: Tue, 25 Jun 2019 14:26:41 +0200
Message-ID: <20190625122641.GA4421@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Greer <mgreer@animalcreek.com>, Paul Gortmaker <paul.gortmaker@windriver.com>, Dale Farnsworth <dale@farnsworth.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-serial@vger.kernel.org

Hi Paul, Dale and Mark (I hope this reaches the right Mark),

I've started auditing all users of DMA_ATTR_NON_CONSISTENT ot prepare
for major API improvements in that area.

One of the odd users is the mpsc ѕerial driver, which allocates DMA
memory with the above flag, and then actually properly calls
dma_cache_sync.  So far, so good.  But it turns out it also has
"#if defined(CONFIG_PPC32) && !defined(CONFIG_NOT_COHERENT_CACHE)"
ifdef blocks next to the dma_cache_sync calls that perform cache
maintainance for platforms that according to the ifdef claim to
be cache coherent.  According to the Kconfig the driver can
only build if the MV64X60 symbol is set, which is a ppc embedded 6xx
SOC, which appears to be configurable as either cache coherent, or
not.  But according to the code in the driver at least this device
always is not cache coherent.

It seems like we need to always mark that platform as potentially
not coherent, and then use the per-device flag to mark all device
except for this one as coherent.  Or did I miss anything?  Maybe
all this is actually dead code and can go away?
