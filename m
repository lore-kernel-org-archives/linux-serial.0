From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC v3 3/9] irqchip: gic: Provide support for interrupt grouping
Date: Thu, 5 Jun 2014 15:50:12 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1406051545380.25775@knanqh.ubzr>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-4-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1401961994-18033-4-git-send-email-daniel.thompson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, kgdb-bugreport@lists.sourceforge.net, Linus Walleij <linus.walleij@linaro.org>, Sricharan R <r.sricharan@ti.com>, Colin Cross <ccross@android.com>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, patches@linaro.org, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Jason Cooper <jason@lakedaemon.net>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg
List-Id: linux-serial@vger.kernel.org

On Thu, 5 Jun 2014, Daniel Thompson wrote:

> diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> index 57d165e..aa8efe4 100644
> --- a/drivers/irqchip/irq-gic.c
> +++ b/drivers/irqchip/irq-gic.c
> @@ -408,13 +408,27 @@ static void __init gic_dist_init(struct gic_chip_data *gic)
>  		writel_relaxed(0xa0a0a0a0, base + GIC_DIST_PRI + i * 4 / 4);
>  
>  	/*
> +	 * Set all global interrupts to be group 1.
> +	 *
> +	 * If grouping is not available (not implemented or prohibited by
> +	 * security mode) these registers a read-as-zero/write-ignored.
> +	 */
> +	for (i = 32; i < gic_irqs; i += 32)
> +		writel_relaxed(0xffffffff, base + GIC_DIST_IGROUP + i * 4 / 32);
> +
> +	/*
>  	 * Disable all interrupts.  Leave the PPI and SGIs alone
>  	 * as these enables are banked registers.
>  	 */
>  	for (i = 32; i < gic_irqs; i += 32)
>  		writel_relaxed(0xffffffff, base + GIC_DIST_ENABLE_CLEAR + i * 4 / 32);
>  
> -	writel_relaxed(1, base + GIC_DIST_CTRL);
> +	/*
> +	 * Set EnableGrp1/EnableGrp0 (bit 1 and 0) or EnableGrp (bit 0 only,
> +	 * bit 1 ignored)
> +	 */
> +	writel_relaxed(GIC_DIST_CTRL_ENABLE_GRP0_BIT |
> +		       GIC_DIST_CTRL_ENABLE_GRP1_BIT, base + GIC_DIST_CTRL);

Could there be more meaningful defines than GIC_DIST_CTRL_ENABLE_GRP0_BIT
and GIC_DIST_CTRL_ENABLE_GRP1_BIT for those bits?  Otherwise the code 
would look just as clear and possibly cleaner by simply using 0x3.


Nicolas
