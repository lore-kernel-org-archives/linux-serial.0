From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [GIT PULL] TTY/Serial patches for 4.1-rc1
Date: Wed, 22 Apr 2015 12:23:00 +0530
Message-ID: <20150422065300.GI2738@intel.com>
References: <20150421101032.GA4733@kroah.com>
 <CA+55aFzeqhQ=oDMoOmw_Mr6rzKRLCWC8bL1LtyXv96f-+_AtXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFzeqhQ=oDMoOmw_Mr6rzKRLCWC8bL1LtyXv96f-+_AtXA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Apr 21, 2015 at 09:41:22AM -0700, Linus Torvalds wrote:
> On Tue, Apr 21, 2015 at 3:10 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > TTY/Serial patches for 4.1-rc1
> >
> > Here's the big tty/serial driver update for 4.1-rc1.
> 
> This causes Kconfig annoyances:
> 
>   High Speed UART DMA support (HSU_DMA) [N/m/y] (NEW)
>   High Speed UART DMA PCI driver (HSU_DMA_PCI) [N/m/y/?] (NEW)
> 
> I _just_ said "no, I don't want High Speed UART DMA support", so why
> did it then ask me "do you want the High Speed UART DMA PCI driver"?
> 
> And no, there wasn't even a help-fext for that first question (and the
> second one I couldn't be arsed about, at that point I just went "well,
> f*ck you too").
> 
> So at the very least, the wording doesn't make sense. Or maybe that
> PCI driver question should depend on the previous one? And can we
> please make sure that there are help text entries for new config
> options?
> 
> I pulled it, but please people, make sure this gets fixed. Our config
> phase is probably _the_ most painful part of trying to get new people
> involved in compiling their own kernels, so we should consider good
> Kconfig language a priority. Lack of help-texts, and questions that
> are annoying and make no sense are *not* helpful.

Agree, sorry about this.

This HSU_DMA shouldn't even be a user selectable symbol, they should be
selected the HSU_PCI driver (which has a help text) and this already done by
HSU_PCI

Linus,
Please apply this for fixing it. I have noticed few other places as well, will add
them on my dmaengine pull request and send.

Thanks
~Vinod

--><8----------><8----------------

From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 22 Apr 2015 12:17:46 +0530
Subject: [PATCH] dmaengine: hsu: don't prompt for hsu_core part

HSU_DMA is selected by the HSU_DMA_PCI driver, this should be user selected
so remove the user prompt for this

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 drivers/dma/hsu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/hsu/Kconfig b/drivers/dma/hsu/Kconfig
index 7e98eff7440e..2810dca70612 100644
--- a/drivers/dma/hsu/Kconfig
+++ b/drivers/dma/hsu/Kconfig
@@ -1,6 +1,6 @@
 # DMA engine configuration for hsu
 config HSU_DMA
-	tristate "High Speed UART DMA support"
+	tristate
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 
-- 
1.7.9.5
