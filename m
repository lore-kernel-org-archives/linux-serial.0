From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file
Date: Mon, 18 Feb 2019 10:33:42 -0600
Message-ID: <20190218163342.GA12014@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Erin Lo <erin.lo@mediatek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org, srv_heupstream <srv_heupstream@mediatek.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com, mars.cheng@mediatek.com, eddie.huang@mediatek.com, linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Feb 15, 2019 at 02:02:37PM +0800, Erin Lo wrote:
> This patch adds pinctrl file for mt8183.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
>  1 file changed, 1120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> new file mode 100644
> index 0000000..768e41e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> @@ -0,0 +1,1120 @@
> +// SPDX-License-Identifier: GPL-2.0

Run checkpatch. It will tell you that this should be /* */ comments.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
