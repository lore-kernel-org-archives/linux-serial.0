From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v2 01/10] arm: fiq: Allow EOI to be communicated to the intc
Date: Fri, 23 May 2014 16:00:23 +0100
Message-ID: <20140523150022.GW3693@n2100.arm.linux.org.uk>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1400853478-5824-2-git-send-email-daniel.thompson@linaro.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, kernel@stlinux.com, Catalin Marinas <catalin.marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Nicolas Pitre <nico@linaro.org>, Fabio Estevam <festevam@gmail.com>, patches@linaro.org, Anton Vorontsov <anton.vorontsov@linaro.org>, Kumar Gala <galak@codeaurora.org>, "David A. Long" <dave.long@linaro.org>, linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, kernel-team@android.com, devicetree@vger.kernel.org, linaro-kernel@lists.linaro.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Rob Herring <robh+dt@kernel.org>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundati>
List-Id: linux-serial@vger.kernel.org

On Fri, May 23, 2014 at 02:57:49PM +0100, Daniel Thompson wrote:
> +void eoi_fiq(int fiq)
> +{
> +	struct irq_data *irq_data = irq_get_irq_data(fiq + fiq_start);
> +	struct irq_chip *chip = irq_data_get_irq_chip(irq_data);
> +
> +	if (chip->irq_eoi)
> +			chip->irq_eoi(irq_data);
> +}

So what if the IRQ chip takes a spinlock?  You can't take spinlocks in
FIQ context...  Who checks for that kind of stuff - just hoping that
the IRQ driver doesn't take a spinlock sounds real fragile.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
