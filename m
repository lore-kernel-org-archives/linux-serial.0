From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 1/8] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
Date: Wed, 24 Jul 2019 14:45:18 -0600
Message-ID: <20190724204518.GA6997@bogus>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-2-git-send-email-macpaul.lin@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1562924653-10056-2-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Macpaul Lin <macpaul.lin@mediatek.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Ryder Lee <ryder.lee@mediatek.com>, Stephen Boyd <sboyd@kernel.org>, Sean Wang <sean.wang@mediatek.com>, Mars Cheng <mars.cheng@mediatek.com>, Owen Chen <owen.chen@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>, Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 12, 2019 at 05:43:37PM +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, audsys, camsys,
> imgsys, infracfg, mipi0a, topckgen, vcodecsys
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt |  1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt |  1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt |  1 +
>  .../arm/mediatek/mediatek,infracfg.txt        |  1 +
>  .../bindings/arm/mediatek/mediatek,mipi0a.txt | 28 +++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  1 +
>  .../arm/mediatek/mediatek,pericfg.txt         |  1 +
>  .../arm/mediatek/mediatek,topckgen.txt        |  1 +
>  .../arm/mediatek/mediatek,vcodecsys.txt       | 27 ++++++++++++++++++
>  10 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> index 161e63a6c254..5f2757e0f844 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-apmixedsys"
>  	- "mediatek,mt2712-apmixedsys", "syscon"
> +	- "mediatek,mt6765-apmixedsys", "syscon"
>  	- "mediatek,mt6797-apmixedsys"
>  	- "mediatek,mt7622-apmixedsys"
>  	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> index f3cef1a6d95c..243db5275438 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> @@ -7,6 +7,7 @@ Required Properties:
>  
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-audsys", "syscon"
> +	- "mediatek,mt6765-audsys", "syscon"
>  	- "mediatek,mt7622-audsys", "syscon"
>  	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
>  	- "mediatek,mt8183-audiosys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> index d8930f64aa98..17acc4c5402c 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> @@ -6,6 +6,7 @@ The MediaTek camsys controller provides various clocks to the system.
>  Required Properties:
>  
>  - compatible: Should be one of:
> +	- "mediatek,mt6765-camsys", "syscon"
>  	- "mediatek,mt8183-camsys", "syscon"
>  - #clock-cells: Must be 1
>  
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> index e3bc4a1e7a6e..4e7b617acfb6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-imgsys", "syscon"
>  	- "mediatek,mt2712-imgsys", "syscon"
> +	- "mediatek,mt6765-imgsys", "syscon"
>  	- "mediatek,mt6797-imgsys", "syscon"
>  	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
>  	- "mediatek,mt8173-imgsys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> index a90913988d7e..6a6ffb61dd29 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-infracfg", "syscon"
>  	- "mediatek,mt2712-infracfg", "syscon"
> +	- "mediatek,mt6765-infracfg", "syscon"
>  	- "mediatek,mt6797-infracfg", "syscon"
>  	- "mediatek,mt7622-infracfg", "syscon"
>  	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> new file mode 100644
> index 000000000000..49313055e574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> @@ -0,0 +1,28 @@
> +Mediatek mipi0a (mipi_rx_ana_csi0a) controller
> +============================
> +
> +The Mediatek mipi0a controller provides various clocks
> +to the system.

Is that all it does?

> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-mipi0a", "syscon"
> +- #clock-cells: Must be 1
> +
> +The mipi0a controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +The mipi0a controller also uses the common power domain from
> +Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +The available power doamins are defined in dt-bindings/power/mt*-power.h.
> +
> +Example:
> +
> +mipi0a: mipi0a@11c10000 {

if so, then clock-controller@...

Same question on the next one.

> +	compatible = "mediatek,mt6765-mipi0a", "syscon";
> +	reg = <0 0x11c10000 0 0x1000>;
> +	power-domains = <&scpsys MT6765_POWER_DOMAIN_CAM>;
> +	#clock-cells = <1>;
> +};
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 545eab717c96..0c7b1698b98e 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-mmsys", "syscon"
>  	- "mediatek,mt2712-mmsys", "syscon"
> +	- "mediatek,mt6765-mmsys", "syscon"
>  	- "mediatek,mt6797-mmsys", "syscon"
>  	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
>  	- "mediatek,mt8173-mmsys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> index 4c7e478117a0..b49b40741be1 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-pericfg", "syscon"
>  	- "mediatek,mt2712-pericfg", "syscon"
> +	- "mediatek,mt6765-pericfg", "syscon"
>  	- "mediatek,mt7622-pericfg", "syscon"
>  	- "mediatek,mt7623-pericfg", "mediatek,mt2701-pericfg", "syscon"
>  	- "mediatek,mt7629-pericfg", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> index a023b8338960..21ad416bfeec 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-topckgen"
>  	- "mediatek,mt2712-topckgen", "syscon"
> +	- "mediatek,mt6765-topckgen", "syscon"
>  	- "mediatek,mt6797-topckgen"
>  	- "mediatek,mt7622-topckgen"
>  	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> new file mode 100644
> index 000000000000..83f7f8634943
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> @@ -0,0 +1,27 @@
> +Mediatek vcodecsys controller
> +============================
> +
> +The Mediatek vcodecsys controller provides various clocks to the system.
> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-vcodecsys", "syscon"
> +- #clock-cells: Must be 1
> +
> +The vcodecsys controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +The vcodecsys controller also uses the common power domain from
> +Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +The available power doamins are defined in dt-bindings/power/mt*-power.h.
> +
> +Example:
> +
> +venc_gcon: venc_gcon@17000000 {
> +	compatible = "mediatek,mt6765-vcodecsys", "syscon";
> +	reg = <0 0x17000000 0 0x10000>;
> +	power-domains = <&scpsys MT6765_POWER_DOMAIN_VCODEC>;
> +	#clock-cells = <1>;
> +};
> -- 
> 2.18.0
> 
