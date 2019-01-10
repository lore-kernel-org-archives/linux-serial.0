From: Long Cheng <long.cheng@mediatek.com>
Subject: Re: [PATCH v9 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Thu, 10 Jan 2019 16:50:25 +0800
Message-ID: <1547110225.3831.24.camel@mhfsdcap03>
References: <1546395178-8880-1-git-send-email-long.cheng@mediatek.com>
         <1546395178-8880-2-git-send-email-long.cheng@mediatek.com>
         <CANMq1KB=yuEJxUdi8M9deDhAv24WZ-4h+26cFq7AzBi8uyd88Q@mail.gmail.com>
         <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d60c25c2-efe4-9294-dc7e-98f0333bff76@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Nicolas Boichat <drinkcat@chromium.org>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, linux-mediatek@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhen
List-Id: linux-serial@vger.kernel.org

On Wed, 2019-01-02 at 18:03 -0800, Randy Dunlap wrote:
> Hi,
> 
> While you are making changes, here are a few more:
> 

hi

OK, thanks for your comments.

> 
> On 1/2/19 5:39 PM, Nicolas Boichat wrote:
> > diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> > index 27bac0b..1a523c87 100644
> > --- a/drivers/dma/mediatek/Kconfig
> > +++ b/drivers/dma/mediatek/Kconfig
> > @@ -1,4 +1,15 @@
> > 
> > +config DMA_MTK_UART
> > +       tristate "MediaTek SoCs APDMA support for UART"
> > +       depends on OF && SERIAL_8250_MT6577
> > +       select DMA_ENGINE
> > +       select DMA_VIRTUAL_CHANNELS
> > +       help
> > +         Support for the UART DMA engine found on MediaTek MTK SoCs.
> > +         when SERIAL_8250_MT6577 is enabled, and if you want to use DMA,
> 
> 	    When
> 
> > +         you can enable the config. the DMA engine can only be used
> 
> 	                               The
> 
> > +         with MediaTek SoCs.
> > +
> 

above, i will modify.

> Also, use tabs to indent instead of spaces.
> The lines (tristate, depends, select, and help) should be indented with one tab.
> The help text lines should be indented with one tab + 2 spaces.
> 

in my patch, i already do this. So don't need modify.

> >  config MTK_HSDMA
> >         tristate "MediaTek High-Speed DMA controller support"
> >         depends on ARCH_MEDIATEK || COMPILE_TEST
> 
> 
> thanks,
