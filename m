From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/4] dt-bindings: dma: uart: rename binding
Date: Mon, 29 Apr 2019 07:48:27 -0500
Message-ID: <20190429124827.GA13816@bogus>
References: <1556336193-15198-1-git-send-email-long.cheng@mediatek.com>
 <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1556336193-15198-4-git-send-email-long.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Long Cheng <long.cheng@mediatek.com>
Cc: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat <drinkcat@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, srv_heupstream@mediatek.com, Yingjoe Chen <yingjoe.chen@mediatek.com>, YT Shen <yt.shen@mediatek.com>, Zhenbao Liu <zhenb>
List-Id: linux-serial@vger.kernel.org

On Sat, 27 Apr 2019 11:36:32 +0800, Long Cheng wrote:
> The filename matches mtk-uart-apdma.c.
> So using "mtk-uart-apdma.txt" should be better.
> And add some property.
> 
> Signed-off-by: Long Cheng <long.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 ------------
>  .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   55 ++++++++++++++++++++
>  2 files changed, 55 insertions(+), 33 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
> 

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
