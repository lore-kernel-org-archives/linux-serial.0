From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC v3 1/9] arm: fiq: arbitrary mappings from IRQ to FIQ virqs
Date: Thu, 5 Jun 2014 12:51:16 +0100
Message-ID: <20140605115116.GE23430@n2100.arm.linux.org.uk>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1401961994-18033-2-git-send-email-daniel.thompson@linaro.org>
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

On Thu, Jun 05, 2014 at 10:53:06AM +0100, Daniel Thompson wrote:
>  static int fiq_def_op(void *ref, int relinquish)
>  {
> -	if (!relinquish)
> +	if (!relinquish) {
> +		unsigned offset = FIQ_OFFSET;
> +		no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
>  		set_fiq_handler(&no_fiq_insn, sizeof(no_fiq_insn));
> +	}
...
>  void __init init_FIQ(int start)
>  {
> -	unsigned offset = FIQ_OFFSET;
> -	no_fiq_insn = *(unsigned long *)(0xffff0000 + offset);
>  	fiq_start = start;
>  }

This is wrong - when the default handler is "reinstalled", this change has
the effect that we read the first instruction of the existing handler, and
then write that same instruction back, rather than replacing the first
instruction with the value that was there at boot.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
