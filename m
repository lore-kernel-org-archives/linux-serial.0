From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 1/2] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Date: Tue, 18 Dec 2018 19:12:33 -0800
Message-ID: <46c746fc-b400-ec6e-d6b1-899c3d594b19@infradead.org>
References: <1545186022-3712-1-git-send-email-long.cheng@mediatek.com>
 <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1545186022-3712-2-git-send-email-long.cheng@mediatek.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Long Cheng <long.cheng@mediatek.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>
Cc: devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>, srv_heupstream@mediatek.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org, YT Shen <yt.shen@mediatek.com>, dmaengine@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, Matthias Brugger <matthias.bgg@gmail.com>, Yingjoe Chen <yingjoe.chen@mediatek.com>, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Hi,
A few small corrections...

On 12/18/18 6:20 PM, Long Cheng wrote:
> diff --git a/drivers/dma/mediatek/Kconfig b/drivers/dma/mediatek/Kconfig
> index 27bac0b..2c082c9 100644
> --- a/drivers/dma/mediatek/Kconfig
> +++ b/drivers/dma/mediatek/Kconfig
> @@ -1,4 +1,15 @@
>  
> +config DMA_MTK_UART
> +	tristate "MediaTek SoCs APDMA support for UART"
> +	depends on OF && SERIAL_8250_MT6577
> +	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
> +	help
> +	  Support for the UART DMA engine found on MediaTek MTK SoCs.
> +	  when SERIAL_8250_MT6577 is enabled, and if you want to using DMA,

	  When                                                to use DMA,

> +	  you can enable the config. the DMA engine just only be used

	                             The DMA engine can only be used

> +	  with MediaTek SoCs.
> +


cheers,
-- 
~Randy
