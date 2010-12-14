From: Nick Pelly <npelly@google.com>
Subject: Re: [PATCH v2] This driver supports UART-DM HW on MSM platforms. It
 uses the on chip DMA to drive data transfers and has optional support for
 UART power management independent of Linux suspend/resume and wakeup from Rx.
Date: Tue, 14 Dec 2010 13:08:28 -0800
Message-ID: <AANLkTinVpJ-p648gOuRWyV2kp4U-HTu2rtirBnzOAJnK@mail.gmail.com>
References: <1292307586-6548-1-git-send-email-mrana@codeaurora.org> <20101214171404.GB3832@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:41029 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758723Ab0LNVJC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 14 Dec 2010 16:09:02 -0500
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id oBEL90Pc029343
	for <linux-serial@vger.kernel.org>; Tue, 14 Dec 2010 13:09:00 -0800
Received: from iwn2 (iwn2.prod.google.com [10.241.68.66])
	by wpaz5.hot.corp.google.com with ESMTP id oBEL8W6c010918
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 14 Dec 2010 13:08:58 -0800
Received: by iwn2 with SMTP id 2so1273972iwn.21
        for <linux-serial@vger.kernel.org>; Tue, 14 Dec 2010 13:08:58 -0800 (PST)
In-Reply-To: <20101214171404.GB3832@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Mayank Rana <mrana@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, Sankalp Bose <sankalpb@codeaurora.org>

On Tue, Dec 14, 2010 at 9:14 AM, Greg KH <greg@kroah.com> wrote:
>
> That's some subject: are you sure that should really be the subject?
>
> On Tue, Dec 14, 2010 at 11:49:46AM +0530, Mayank Rana wrote:
> > The driver was originally developed by Google. It is functionally
> > equivalent to the version available at:
> > http://android.git.kernel.org/?p=3Dkernel/experimental.git
> > the differences being:
> > 1) Remove wakelocks and change unsupported DMA API.
> > 2) Replace clock selection register codes by macros.
> > 3) Fix checkpatch errors and add inline documentation.
> > 4) Add runtime PM hooks for active power state transitions.
> >
> > CC: Nick Pelly <npelly@google.com>
> > Signed-off-by: Sankalp Bose <sankalpb@codeaurora.org>
> > Signed-off-by: Mayank Rana <mrana@codeaurora.org>
>
> <snip>
>
> I don't see the previous review comments I made addressed here, what
> happened?
>
> Specifically, you need to sort out the ownership of this file (who wr=
ote
> the thing, why you are submitting something written by someone else
> without their approval, etc.) and the like.

Glad someone is trying to get the patch upstream, but I think Mayank
has taken it a step backwards from the version on Android open source.

Removing the wakelock's are fine since they are somewhat
controversial, and not core to the driver.

But adding all the boilerplate comments on each function? They add no v=
alue.

As far as authorship, I took the original Qualcomm driver and re-wrote
it. There is probably not a lot of code the same. The original driver
was very useful for regression testing though.

>
> > --- /dev/null
> > +++ b/drivers/serial/msm_serial_hs.c
> > @@ -0,0 +1,1680 @@
> > +/* drivers/serial/msm_serial_hs.c
> > + *
> > + * MSM 7k/8k High speed uart driver
> > + *
> > + * Copyright (c) 2007-2010, Code Aurora Forum. All rights reserved=
=2E
> > + * Copyright (c) 2008 Google Inc.
> > + * Modified: Nick Pelly <npelly@google.com>
> > + *
> > + * All source code in this file is licensed under the following li=
cense
> > + * except where indicated.
>
> Is anything indicated? =A0If not, drop it please.
>
> > + *
> > + * This program is free software; you can redistribute it and/or
> > + * modify it under the terms of the GNU General Public License
> > + * version 2 as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > + * See the GNU General Public License for more details.
> > + *
> > + * You should have received a copy of the GNU General Public Licen=
se
> > + * along with this program; if not, you can find it at http://www.=
fsf.org
>
> These last two paragraphs can be deleted, they are useless.
>
> > + */
> > +
> > +/*
> > + * MSM 7k/8k High speed uart driver
> > + *
> > + * Has optional support for uart power management independent of l=
inux
> > + * suspend/resume:
> > + *
> > + * RX wakeup.
> > + * UART wakeup can be triggered by RX activity (using a wakeup GPI=
O on the
> > + * UART RX pin). This should only be used if there is not a wakeup
> > + * GPIO on the UART CTS, and the first RX byte is known (for examp=
le, with the
> > + * Bluetooth Texas Instruments HCILL protocol), since the first RX=
 byte will
> > + * always be lost. RTS will be asserted even while the UART is off=
 in this mode
> > + * of operation. See msm_serial_hs_platform_data.rx_wakeup_irq.
> > + */
> > +
> > +#include <linux/module.h>
> > +
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/slab.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/irq.h>
> > +#include <linux/io.h>
> > +#include <linux/ioport.h>
> > +#include <linux/kernel.h>
> > +#include <linux/timer.h>
> > +#include <linux/clk.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/wait.h>
> > +#include <linux/workqueue.h>
> > +
> > +#include <linux/atomic.h>
> > +#include <asm/irq.h>
> > +#include <asm/system.h>
> > +
> > +#include <mach/hardware.h>
> > +#include <mach/dma.h>
> > +#include <linux/platform_data/msm_serial_hs.h>
> > +
> > +#include "msm_serial_hs_hwreg.h"
>
> Why do you need this .h file at all? =A0Just roll it into this .c fil=
e
> please.
>
> > +/**
> > + * msm_hs_request_clock_off - request to (i.e. asynchronously) tur=
n off uart
> > + * clock once pending TX is flushed and Rx DMA command is terminat=
ed.
> > + * @uport: uart_port structure for the device instance.
> > + *
> > + * This functions puts the device into a partially active low powe=
r mode. It
> > + * waits to complete all pending tx transactions, flushes ongoing =
Rx DMA
> > + * command and terminates UART side Rx transaction, puts UART HW i=
n non DMA
> > + * mode and then clocks off the device. A client calls this when n=
o UART
> > + * data is expected. msm_request_clock_on() must be called before =
any further
> > + * UART can be sent or received.
> > + */
> > +void msm_hs_request_clock_off(struct uart_port *uport)
> > +{
> > + =A0 =A0 unsigned long flags;
> > +
> > + =A0 =A0 spin_lock_irqsave(&uport->lock, flags);
> > + =A0 =A0 msm_hs_request_clock_off_locked(uport);
> > + =A0 =A0 spin_unlock_irqrestore(&uport->lock, flags);
> > +}
> > +EXPORT_SYMBOL(msm_hs_request_clock_off);
>
> EXPORT_SYMBOL_GPL?
>
> And why is this function exported at all anyway? =A0Who is going to c=
all
> it?
>
> Same goes for the other exported function.
>
>
> thanks,
>
> greg k-h
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
