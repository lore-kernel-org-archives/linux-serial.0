From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [RFC v3 4/9] irqchip: gic: Introduce shadow irqs for FIQ
Date: Fri, 06 Jun 2014 10:23:01 +0100
Message-ID: <53918875.8070205@linaro.org>
References: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1401961994-18033-5-git-send-email-daniel.thompson@linaro.org>
 <20140606074614.GU5961@tbergstrom-lnx.Nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140606074614.GU5961@tbergstrom-lnx.Nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Peter De Schrijver <pdeschrijver@nvidia.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, "kernel@stlinux.com" <kernel@stlinux.com>, "kgdb-bugreport@lists.sourceforge.net" <kgdb-bugreport@lists.sourceforge.net>, Linus Walleij <linus.walleij@linaro.org>, Sricharan R <r.sricharan@ti.com>, Colin Cross <ccross@android.com>, Jiri Slaby <jslaby@suse.cz>, Dirk Behme <dirk.behme@de.bosch.com>, Russell King <linux@arm.linux.org.uk>, Nicolas Pitre <nico@linaro.org>, "patches@linaro.org" <patches@linaro.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, "David A. Long" <dave.long@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "kernel-team@android.com" <kernel-team@android.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Jason Cooper <jas>
List-Id: linux-serial@vger.kernel.org

On 06/06/14 08:46, Peter De Schrijver wrote:
>> @@ -1037,17 +1076,28 @@ void __init gic_init_bases(unsigned int gic_nr, int irq_start,
>>  			irq_base = irq_start;
>>  		}
>>  
>> -		gic->domain = irq_domain_add_legacy(node, gic_irqs, irq_base,
>> -					hwirq_base, &gic_irq_domain_ops, gic);
>> +		gic->domain =
>> +		    irq_domain_add_legacy(node, 2 * gic_irqs, irq_base,
>> +					  hwirq_base, &gic_irq_domain_ops, gic);
>>  	} else {
>> -		gic->domain = irq_domain_add_linear(node, nr_routable_irqs,
>> -						    &gic_irq_domain_ops,
>> -						    gic);
>> +		gic->domain = irq_domain_add_linear(node, 2 * nr_routable_irqs,
>> +						    &gic_irq_domain_ops, gic);
>>  	}
>>  
>>  	if (WARN_ON(!gic->domain))
>>  		return;
>>  
>> +#ifdef CONFIG_FIQ
>> +	/* FIQ can only be supported on platforms without an extended irq_eoi
>> +	 * method (otherwise we take a lock during irq_eoi handling).
>> +	 */
>> +	if (!gic_arch_extn.irq_eoi)
>> +		fiq_add_mapping(
>> +		    irq_linear_revmap(gic->domain, hwirq_base),
>> +		    irq_linear_revmap(gic->domain, hwirq_base + gic_irqs),
>> +		    gic_irqs);
>> +#endif
> 
> This is rather unfortunate. On Tegra for example we don't need a lock for the
> irq_eoi because the eoi ack can be handled with a single write to the
> appropriate irq ack register.

I believe that Tegra is the only platform that uses this hook so should
be safe to remove the locks from gic_irq_eoi().

Certainly looking back at the code history and the mailing list
discussions around this code[1] I cannot see any reasoning about the
locks that I have missed.

Any objections to just nuking the locks?


Daniel.


[1]
http://thread.gmane.org/gmane.linux.ports.arm.kernel/107474
http://thread.gmane.org/gmane.linux.ports.arm.kernel/108361
http://thread.gmane.org/gmane.linux.ports.arm.kernel/109690
