From: Marc Zyngier <marc.zyngier@arm.com>
Subject: Re: [patch 1/5] genirq: Delay deactivation in free_irq()
Date: Fri, 28 Jun 2019 08:42:06 +0100
Message-ID: <0bb6aae3-744b-7752-04ec-9a0e68fb86e6@arm.com>
References: <20190625111353.863718167@linutronix.de>
 <20190625112405.573914765@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625112405.573914765@linutronix.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org, Robert Hodaszi <Robert.Hodaszi@digi.com>, Vadim Pasternak <vadimp@mellanox.com>, Ido Schimmel <idosch@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Thomas,

On 25/06/2019 12:13, Thomas Gleixner wrote:
> When interrupts are shutdown, they are immediately deactivated in the
> irqdomain hierarchy. While this looks obviously correct there is a subtle
> issue:
> 
> There might be an interrupt in flight when free_irq() is invoking the
> shutdown. This is properly handled at the irq descriptor / primary handler
> level, but the deactivation might completely disable resources which are
> required to acknowledge the interrupt.
> 
> Split the shutdown code and deactivate the interrupt after synchronization
> in free_irq(). Fixup all other usage sites where this is not an issue to
> invoke the combined shutdown_and_deactivate() function instead.
> 
> This still might be an issue if the interrupt in flight servicing is
> delayed on a remote CPU beyond the invocation of synchronize_irq(), but
> that cannot be handled at that level and needs to be handled in the
> synchronize_irq() context.
> 
> Fixes: f8264e34965a ("irqdomain: Introduce new interfaces to support hierarchy irqdomains")
> Reported-by: Robert Hodaszi <Robert.Hodaszi@digi.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/irq/autoprobe.c  |    6 +++---
>  kernel/irq/chip.c       |    6 ++++++
>  kernel/irq/cpuhotplug.c |    2 +-
>  kernel/irq/internals.h  |    1 +
>  kernel/irq/manage.c     |   12 +++++++++++-
>  5 files changed, 22 insertions(+), 5 deletions(-)
> 
> --- a/kernel/irq/autoprobe.c
> +++ b/kernel/irq/autoprobe.c
> @@ -90,7 +90,7 @@ unsigned long probe_irq_on(void)
>  			/* It triggered already - consider it spurious. */
>  			if (!(desc->istate & IRQS_WAITING)) {
>  				desc->istate &= ~IRQS_AUTODETECT;
> -				irq_shutdown(desc);
> +				irq_shutdown_and_deactivate(desc);
>  			} else
>  				if (i < 32)
>  					mask |= 1 << i;
> @@ -127,7 +127,7 @@ unsigned int probe_irq_mask(unsigned lon
>  				mask |= 1 << i;
>  
>  			desc->istate &= ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> @@ -169,7 +169,7 @@ int probe_irq_off(unsigned long val)
>  				nr_of_irqs++;
>  			}
>  			desc->istate &= ~IRQS_AUTODETECT;
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  		}
>  		raw_spin_unlock_irq(&desc->lock);
>  	}
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -314,6 +314,12 @@ void irq_shutdown(struct irq_desc *desc)
>  		}
>  		irq_state_clr_started(desc);
>  	}
> +}
> +
> +
> +void irq_shutdown_and_deactivate(struct irq_desc *desc)
> +{
> +	irq_shutdown(desc);
>  	/*
>  	 * This must be called even if the interrupt was never started up,
>  	 * because the activation can happen before the interrupt is
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -116,7 +116,7 @@ static bool migrate_one_irq(struct irq_d
>  		 */
>  		if (irqd_affinity_is_managed(d)) {
>  			irqd_set_managed_shutdown(d);
> -			irq_shutdown(desc);
> +			irq_shutdown_and_deactivate(desc);
>  			return false;
>  		}
>  		affinity = cpu_online_mask;
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -82,6 +82,7 @@ extern int irq_activate_and_startup(stru
>  extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
>  
>  extern void irq_shutdown(struct irq_desc *desc);
> +extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
>  extern void irq_enable(struct irq_desc *desc);
>  extern void irq_disable(struct irq_desc *desc);
>  extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/random.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/slab.h>
>  #include <linux/sched.h>
>  #include <linux/sched/rt.h>
> @@ -1699,6 +1700,7 @@ static struct irqaction *__free_irq(stru
>  	/* If this was the last handler, shut down the IRQ line: */
>  	if (!desc->action) {
>  		irq_settings_clr_disable_unlazy(desc);
> +		/* Only shutdown. Deactivate after synchronize_irq() */

synchronize_hardirq()

>  		irq_shutdown(desc);
>  	}
>  
> @@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(stru
>  		 * require it to deallocate resources over the slow bus.
>  		 */
>  		chip_bus_lock(desc);
> +		/*
> +		 * There is no interrupt on the fly anymore. Deactivate it
> +		 * completely.
> +		 */
> +		raw_spin_lock_irqsave(&desc->lock, flags);
> +		irq_domain_deactivate_irq(&desc->irq_data);
> +		raw_spin_unlock_irqrestore(&desc->lock, flags);
> +
>  		irq_release_resources(desc);
>  		chip_bus_sync_unlock(desc);
>  		irq_remove_timings(desc);
> @@ -1855,7 +1865,7 @@ static const void *__cleanup_nmi(unsigne
>  	}
>  
>  	irq_settings_clr_disable_unlazy(desc);
> -	irq_shutdown(desc);
> +	irq_shutdown_and_deactivate(desc);
>  
>  	irq_release_resources(desc);
The patch makes complete sense, so this comment is only a nit, feel free 
to ignore me: I find it a bit odd that irq_shutdown() doesn't do the 
full thing anymore, given that it is the "canonical" function, and that 
__free_irq is the only one that has special needs. Suggestion below.

Irrespective of which version you prefer:

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 29d6c7d070b4..aeab853fcc10 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -301,7 +301,7 @@ int irq_activate_and_startup(struct irq_desc *desc, bool resend)
 
 static void __irq_disable(struct irq_desc *desc, bool mask);
 
-void irq_shutdown(struct irq_desc *desc)
+void __irq_shutdown(struct irq_desc *desc)
 {
 	if (irqd_is_started(&desc->irq_data)) {
 		desc->depth = 1;
@@ -314,6 +314,11 @@ void irq_shutdown(struct irq_desc *desc)
 		}
 		irq_state_clr_started(desc);
 	}
+}
+
+void irq_shutdown(struct irq_desc *desc)
+{
+	__irq_shutdown(desc);
 	/*
 	 * This must be called even if the interrupt was never started up,
 	 * because the activation can happen before the interrupt is
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 70c3053bc1f6..107f7d342e3d 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -81,6 +81,7 @@ extern int irq_activate(struct irq_desc *desc);
 extern int irq_activate_and_startup(struct irq_desc *desc, bool resend);
 extern int irq_startup(struct irq_desc *desc, bool resend, bool force);
 
+extern void __irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_enable(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 78f3ddeb7fe4..f19e3589989e 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/random.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
 #include <linux/sched/rt.h>
@@ -1699,7 +1700,8 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	/* If this was the last handler, shut down the IRQ line: */
 	if (!desc->action) {
 		irq_settings_clr_disable_unlazy(desc);
-		irq_shutdown(desc);
+		/* Only shutdown. Deactivate after synchronize_hardirq() */
+		__irq_shutdown(desc);
 	}
 
 #ifdef CONFIG_SMP
@@ -1768,6 +1770,14 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 		 * require it to deallocate resources over the slow bus.
 		 */
 		chip_bus_lock(desc);
+		/*
+		 * There is no interrupt on the fly anymore. Deactivate it
+		 * completely.
+		 */
+		raw_spin_lock_irqsave(&desc->lock, flags);
+		irq_domain_deactivate_irq(&desc->irq_data);
+		raw_spin_unlock_irqrestore(&desc->lock, flags);
+
 		irq_release_resources(desc);
 		chip_bus_sync_unlock(desc);
 		irq_remove_timings(desc);

-- 
Jazz is not dead. It just smells funny...
