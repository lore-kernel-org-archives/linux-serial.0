From: Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] serial: Fix wakeup init logic to speed up startup
Date: Thu, 19 Jan 2012 15:57:10 -0800
Message-ID: <CAPnjgZ1_6BM9Xrtn0S2Rp1_YsjcUYi3iyKpH62LyhkR_T63ojg@mail.gmail.com>
References: <1327001336-28703-1-git-send-email-sjg@chromium.org>
	<201201200046.59766.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:52460 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753909Ab2ASX5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 19 Jan 2012 18:57:11 -0500
Received: by obcva7 with SMTP id va7so15132obc.19
        for <linux-serial@vger.kernel.org>; Thu, 19 Jan 2012 15:57:11 -0800 (PST)
In-Reply-To: <201201200046.59766.rjw@sisk.pl>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, linux-serial@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>

Hi Rafael,

On Thu, Jan 19, 2012 at 3:46 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, January 19, 2012, Simon Glass wrote:
>> The synchronize_rcu() call resulting from making every serial driver
>> wake-up capable (commit b3b708fa) slows boot down on my Tegra2x syst=
em
>> (with CONFIG_PREEMPT disabled).
>>
>> But this is avoidable since it is the device_set_wakeup_enable() and=
 then
>> subsequence disable which causes the delay. We might as well just ma=
ke
>> the device wakeup capable but not actually enable it for wakeup unti=
l
>> needed.
>>
>> Effectively the current code does this:
>>
>> =A0 =A0 =A0 device_set_wakeup_capable(dev, 1);
>> =A0 =A0 =A0 device_set_wakeup_enable(dev, 1);
>> =A0 =A0 =A0 device_set_wakeup_enable(dev, 0);
>>
>> We can just drop the last two lines.
>>
>> Before this change my boot log says:
>> [ =A0 =A00.227062] Serial: 8250/16550 driver, 4 ports, IRQ sharing d=
isabled
>> [ =A0 =A00.702928] serial8250.0: ttyS0 at MMIO 0x70006040 (irq =3D 6=
9) is a Tegra
>>
>> after:
>> [ =A0 =A00.227264] Serial: 8250/16550 driver, 4 ports, IRQ sharing d=
isabled
>> [ =A0 =A00.227983] serial8250.0: ttyS0 at MMIO 0x70006040 (irq =3D 6=
9) is a Tegra
>>
>> for saving of 450ms.
>>
>> Suggested-by: Rafael J. Wysocki <rjw@sisk.pl>
>> Signed-off-by: Simon Glass <sjg@chromium.org>
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
>
> Thanks!

Thanks for your help with this.

Regards,
Simon

>
>> ---
>> =A0drivers/tty/serial/serial_core.c | =A0 =A06 +++---
>> =A01 files changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/s=
erial_core.c
>> index c7bf31a..1305618 100644
>> --- a/drivers/tty/serial/serial_core.c
>> +++ b/drivers/tty/serial/serial_core.c
>> @@ -2348,11 +2348,11 @@ int uart_add_one_port(struct uart_driver *dr=
v, struct uart_port *uport)
>> =A0 =A0 =A0 =A0*/
>> =A0 =A0 =A0 tty_dev =3D tty_register_device(drv->tty_driver, uport->=
line, uport->dev);
>> =A0 =A0 =A0 if (likely(!IS_ERR(tty_dev))) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 device_init_wakeup(tty_dev, 1);
>> - =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_enable(tty_dev, 0);
>> - =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 device_set_wakeup_capable(tty_dev, 1);
>> + =A0 =A0 } else {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "Cannot register tty dev=
ice on line %d\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0uport->line);
>> + =A0 =A0 }
>>
>> =A0 =A0 =A0 /*
>> =A0 =A0 =A0 =A0* Ensure UPF_DEAD is not set.
>>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
