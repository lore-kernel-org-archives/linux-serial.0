From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v4 05/10] clk: mediatek: Add dt-bindings for MT8183 clocks
Date: Tue, 31 Jul 2018 13:24:26 -0600
Message-ID: <20180731192426.GA8792@rob-hp-laptop>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jul 31, 2018 at 01:38:02PM +0800, Erin Lo wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Add MT8183 clock dt-bindings, include topckgen, apmixedsys,
> infracfg and subsystem clocks.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8183-clk.h | 413 +++++++++++++++++++++++++++++++++
>  1 file changed, 413 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8183-clk.h
> 
> diff --git a/include/dt-bindings/clock/mt8183-clk.h b/include/dt-bindings/clock/mt8183-clk.h
> new file mode 100644
> index 0000000..bacad53
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8183-clk.h
> @@ -0,0 +1,413 @@
> +/* SPDX-License-Identifier: GPL-2.0

This should be a separate comment from the copyright. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
