From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 04/11] soc: mediatek: add MT6765 scpsys support
Date: Fri, 20 Jul 2018 11:46:09 -0600
Message-ID: <20180720174609.GA679@rob-hp-laptop>
References: <1531817552-17221-1-git-send-email-mars.cheng@mediatek.com>
 <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1531817552-17221-5-git-send-email-mars.cheng@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mars Cheng <mars.cheng@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org, wsd_upstream@mediatek.com, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 17, 2018 at 04:52:25PM +0800, Mars Cheng wrote:
> This adds scpsys support for MT6765
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c        |   88 ++++++++++++++++++++++++++++++
>  include/dt-bindings/power/mt6765-power.h |   14 +++++

This file goes in the binding patch.

>  2 files changed, 102 insertions(+)
>  create mode 100644 include/dt-bindings/power/mt6765-power.h
