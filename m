From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 4/8] clk: mediatek: add mt6765 clock IDs
Date: Wed, 24 Jul 2019 14:46:21 -0600
Message-ID: <20190724204621.GA13063@bogus>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1562924653-10056-5-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Sean Wang <sean.wang@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>, Owen Chen <owen.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org, Macpaul Lin <macpaul.lin@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Fri, 12 Jul 2019 17:43:40 +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> Add MT6765 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, mcucfg and subsystem clocks.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  include/dt-bindings/clock/mt6765-clk.h | 313 +++++++++++++++++++++++++
>  1 file changed, 313 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt6765-clk.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
