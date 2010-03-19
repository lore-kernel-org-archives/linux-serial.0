From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/3] max3100: added raise_threaded_irq
Date: Fri, 19 Mar 2010 11:48:34 -0600
Message-ID: <fa686aa41003191048s5c4c85ablc4588725a3d615ad@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	<1268987934-22690-1-git-send-email-chripell@fsfe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:52809 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013Ab0CSRsz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 13:48:55 -0400
In-Reply-To: <1268987934-22690-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Pellegrin <chripell@fsfe.org>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Fri, Mar 19, 2010 at 2:38 AM, Christian Pellegrin <chripell@fsfe.org=
> wrote:
> raise_threaded_irq schedules the execution of an interrupt thread
>
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>

You should cc: Thomas and Ingo and lkml (which I just did) on patches
to the threaded interrupt code.

g.

> ---
> =A0include/linux/interrupt.h | =A0 =A03 +++
> =A0kernel/irq/manage.c =A0 =A0 =A0 | =A0 27 +++++++++++++++++++++++++=
++
> =A02 files changed, 30 insertions(+), 0 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index 75f3f00..14c0c13 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -144,6 +144,9 @@ request_threaded_irq(unsigned int irq, irq_handle=
r_t handler,
> =A0static inline void exit_irq_thread(void) { }
> =A0#endif
>
> +extern int raise_threaded_irq(unsigned int irq);
> +
> +
> =A0extern void free_irq(unsigned int, void *);
>
> =A0struct device;
> diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
> index eb6078c..a7d21e0 100644
> --- a/kernel/irq/manage.c
> +++ b/kernel/irq/manage.c
> @@ -1088,3 +1088,30 @@ int request_threaded_irq(unsigned int irq, irq=
_handler_t handler,
> =A0 =A0 =A0 =A0return retval;
> =A0}
> =A0EXPORT_SYMBOL(request_threaded_irq);
> +
> +/**
> + * =A0 =A0 raise_threaded_irq - triggers a threded interrupt
> + * =A0 =A0 @irq: Interrupt line to trigger
> + */
> +int raise_threaded_irq(unsigned int irq)
> +{
> + =A0 =A0 =A0 struct irq_desc *desc =3D irq_to_desc(irq);
> + =A0 =A0 =A0 struct irqaction *action;
> +
> + =A0 =A0 =A0 if (!desc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 action =3D desc->action;
> + =A0 =A0 =A0 if (!action)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOENT;
> + =A0 =A0 =A0 if (unlikely(!action->thread_fn))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 if (likely(!test_bit(IRQTF_DIED,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&action->thr=
ead_flags))) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(IRQTF_RUNTHREAD, &action->threa=
d_flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 wake_up_process(action->thread);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ECHILD;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 return 0;
> +}
> +EXPORT_SYMBOL(raise_threaded_irq);
> --
> 1.5.6.5
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
