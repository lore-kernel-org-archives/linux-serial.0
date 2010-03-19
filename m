From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/3] max3100: moved to threaded interrupt
Date: Fri, 19 Mar 2010 11:58:20 -0600
Message-ID: <fa686aa41003191058o20e1c9cakb9684275bee78ca4@mail.gmail.com>
References: <cabda6421003190139h344bc172h3556fca78e4b25cb@mail.gmail.com>
	<1268987973-22719-1-git-send-email-chripell@fsfe.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:36307 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751841Ab0CSR6l convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Mar 2010 13:58:41 -0400
Received: by gyg8 with SMTP id 8so1656412gyg.19
        for <linux-serial@vger.kernel.org>; Fri, 19 Mar 2010 10:58:40 -0700 (PDT)
In-Reply-To: <1268987973-22719-1-git-send-email-chripell@fsfe.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Christian Pellegrin <chripell@fsfe.org>
Cc: feng.tang@intel.com, akpm@linux-foundation.org, greg@kroah.com, david-b@pacbell.net, alan@lxorguk.ukuu.org.uk, spi-devel-general@lists.sourceforge.net, linux-serial@vger.kernel.org

On Fri, Mar 19, 2010 at 2:39 AM, Christian Pellegrin <chripell@fsfe.org=
> wrote:
> The driver was reworked to use threaded interrupts instead of workque=
us.
> This is a major boost in performance because the former are scheduled=
 as
> SCHED_FIFO processes. As a side effect suspend/resume code was greatl=
y
> simplified.
>
> Signed-off-by: Christian Pellegrin <chripell@fsfe.org>

On a quick parse, it seems mostly okay.  I haven't dug into the driver
execution flow though.  A few minor comments below.

> ---
> =A0drivers/serial/max3100.c | =A0102 ++++++++++++++------------------=
-------------
> =A01 files changed, 32 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/serial/max3100.c b/drivers/serial/max3100.c
> index 3c30c56..0c972c6 100644
> --- a/drivers/serial/max3100.c
> +++ b/drivers/serial/max3100.c
> @@ -45,7 +45,9 @@
> =A0#include <linux/serial_core.h>
> =A0#include <linux/serial.h>
> =A0#include <linux/spi/spi.h>
> -#include <linux/freezer.h>
> +#include <linux/kthread.h>
> +#include <linux/interrupt.h>
> +#include <linux/bitops.h>
>
> =A0#include <linux/serial_max3100.h>
>
> @@ -113,18 +115,15 @@ struct max3100_port {
>
> =A0 =A0 =A0 =A0int irq; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* irq assigne=
d to the max3100 */
>
> + =A0 =A0 =A0 /* the workqueue is needed because we cannot schedule
> + =A0 =A0 =A0 =A0 =A0a threaded interrupt during PM
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 struct work_struct resume_work;
> +
> =A0 =A0 =A0 =A0int minor; =A0 =A0 =A0 =A0 =A0 =A0 =A0/* minor number =
*/
> =A0 =A0 =A0 =A0int crystal; =A0 =A0 =A0 =A0 =A0 =A0/* 1 if 3.6864Mhz =
crystal 0 for 1.8432 */
> =A0 =A0 =A0 =A0int loopback; =A0 =A0 =A0 =A0 =A0 /* 1 if we are in lo=
opback mode */
>
> - =A0 =A0 =A0 /* for handling irqs: need workqueue since we do spi_sy=
nc */
> - =A0 =A0 =A0 struct workqueue_struct *workqueue;
> - =A0 =A0 =A0 struct work_struct work;
> - =A0 =A0 =A0 /* set to 1 to make the workhandler exit as soon as pos=
sible */
> - =A0 =A0 =A0 int =A0force_end_work;
> - =A0 =A0 =A0 /* need to know we are suspending to avoid deadlock on =
workqueue */
> - =A0 =A0 =A0 int suspending;
> -
> =A0 =A0 =A0 =A0/* hook for suspending MAX3100 via dedicated pin */
> =A0 =A0 =A0 =A0void (*max3100_hw_suspend) (int suspend);
>
> @@ -171,13 +170,12 @@ static void max3100_calc_parity(struct max3100_=
port *s, u16 *c)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*c |=3D max3100_do_parity(s, *c) << 8;
> =A0}
>
> -static void max3100_work(struct work_struct *w);
> -
> -static void max3100_dowork(struct max3100_port *s)
> +static void max3100_resume_work(struct work_struct *w)
> =A0{
> - =A0 =A0 =A0 if (!s->force_end_work && !work_pending(&s->work) &&
> - =A0 =A0 =A0 =A0 =A0 !freezing(current) && !s->suspending)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_work(s->workqueue, &s->work);
> + =A0 =A0 =A0 struct max3100_port *s =3D container_of(w, struct max31=
00_port,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 resume_work);

container_of is used a lot.  Maybe consider a follow-on patch to
create a to_max3100_port() static inline.

> +
> + =A0 =A0 =A0 raise_threaded_irq(s->irq);
> =A0}
>
> =A0static void max3100_timeout(unsigned long data)
> @@ -185,7 +183,7 @@ static void max3100_timeout(unsigned long data)
> =A0 =A0 =A0 =A0struct max3100_port *s =3D (struct max3100_port *)data=
;
>
> =A0 =A0 =A0 =A0if (s->port.state) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 max3100_dowork(s);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 raise_threaded_irq(s->irq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mod_timer(&s->timer, jiffies + s->poll=
_time);
> =A0 =A0 =A0 =A0}
> =A0}
> @@ -255,9 +253,9 @@ static int max3100_handlerx(struct max3100_port *=
s, u16 rx)
> =A0 =A0 =A0 =A0return ret;
> =A0}
>
> -static void max3100_work(struct work_struct *w)
> +static irqreturn_t max3100_ist(int irq, void *dev_id)

'ist'?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
