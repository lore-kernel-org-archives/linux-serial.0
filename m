From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: /proc/stat btime accuracy problem
Date: Tue, 7 Jun 2011 22:16:58 -0600
Message-ID: <BANLkTik259Z-0qRaPMn3FsJ0QWyo07s5nQ@mail.gmail.com>
References: <BANLkTiniq6GVMJPO_-efKrWHQg9V9Dod9g@mail.gmail.com>
 <1306967733.11492.11.camel@work-vm> <BANLkTi=yEMDLEo99WZm2Bt4pi_pog5igww@mail.gmail.com>
 <1306972711.11492.23.camel@work-vm> <BANLkTimuPrqN1euyOqAGm2m4Ea1PdbrzDQ@mail.gmail.com>
 <1306975745.11492.30.camel@work-vm> <BANLkTikR4HNnFsYm2ymm1+FTbeeXtvH51g@mail.gmail.com>
 <BANLkTimGfwqvhOKXCGqJUvMU7jozqQT8=g@mail.gmail.com> <1307469017.3163.37.camel@work-vm>
 <1307495037.3163.76.camel@work-vm>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.67]:31785 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751144Ab1FHERV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Jun 2011 00:17:21 -0400
Received: from hpaq2.eem.corp.google.com (hpaq2.eem.corp.google.com [172.25.149.2])
	by smtp-out.google.com with ESMTP id p584HKMh018231
	for <linux-serial@vger.kernel.org>; Tue, 7 Jun 2011 21:17:20 -0700
Received: from yie13 (yie13.prod.google.com [10.243.66.13])
	by hpaq2.eem.corp.google.com with ESMTP id p584HIWf027714
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 7 Jun 2011 21:17:19 -0700
Received: by yie13 with SMTP id 13so74025yie.27
        for <linux-serial@vger.kernel.org>; Tue, 07 Jun 2011 21:17:18 -0700 (PDT)
In-Reply-To: <1307495037.3163.76.camel@work-vm>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Tue, Jun 7, 2011 at 7:03 PM, john stultz <johnstul@us.ibm.com> wrote=
:
> On Tue, 2011-06-07 at 10:50 -0700, john stultz wrote:
>> Maybe to get this back on coarse, could you provide some additional
>> details about the machine where you're seeing this? Is there one
>> specific driver that is putting out tons of output over the serial
>> console? Or is there anything unique about the serial port or its
>> settings (is it configured at 300 baud :)? What is the /proc/interru=
pts
>> count after boot on one of these systems?
>
> Sorry, I just remembered you already provided some of these details
> below:
>
> On Thu, 2011-06-02 at 00:34 -0600, Bjorn Helgaas wrote:
>> Linux version 3.0.0-smp-DEV ...
>> =A0 BH now =A0 rtc 1306992452 (start_kernel, before setup_arch)
>> =A0 =A0 =A0 Printk 230K of numa=3Dfake debug stuff (more than seems =
strictly
>> =A0 =A0 =A0 necessary to me, but there it is). =A0All this data goes=
 into the log
>> =A0 =A0 =A0 buffer, not to the UART, because the console hasn't been
>> =A0 =A0 =A0 initialized yet.
> [snip]
>> console [ttyS0] enabled
>> =A0 =A0 =A0 Now ttyS0 is enabled, so we dump the log buffer to the U=
ART. =A0I think
>> =A0 =A0 =A0 this happens in console_unlock(), with interrupts disabl=
ed for the whole
>> =A0 =A0 =A0 buffer.
>>
>> =A0 BH now =A0 rtc 1306992481 xt 1306992459 wtm -1306992457
>> =A0 clocksource_register jiffies
>> =A0 =A0 =A0 This RTC read is in clocksource_register(); note that xt=
ime is now
>> =A0 =A0 =A0 22 seconds behind the RTC. =A0The UART is running at 115=
200 baud,
>> =A0 =A0 =A0 and 230K/(115200/10) =3D about 20 seconds, so this sort =
of matches
>> =A0 =A0 =A0 the time I expect it to take to dump the buffer.
>
>
> Ok. So having the 230k data backlog at console_unlock() seems to be p=
art of the issue.
>
> Maybe something like the following could help? By only holding irqs o=
ff for 1k chunks?
>
> thanks
> -john
>
>
> diff --git a/kernel/printk.c b/kernel/printk.c
> index 3518539..9703b22 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -1243,6 +1243,7 @@ void console_unlock(void)
> =A0 =A0 =A0 =A0unsigned long flags;
> =A0 =A0 =A0 =A0unsigned _con_start, _log_end;
> =A0 =A0 =A0 =A0unsigned wake_klogd =3D 0;
> + =A0 =A0 =A0 unsigned chunk_size, length;
>
> =A0 =A0 =A0 =A0if (console_suspended) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0up(&console_sem);
> @@ -1251,14 +1252,18 @@ void console_unlock(void)
>
> =A0 =A0 =A0 =A0console_may_schedule =3D 0;
>
> + =A0 =A0 =A0 chunk_size =3D min(LOG_BUF_MASK, 1024); /* 1k chunks */
> +
> =A0 =A0 =A0 =A0for ( ; ; ) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_lock_irqsave(&logbuf_lock, flags)=
;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wake_klogd |=3D log_start - log_end;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (con_start =3D=3D log_end)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break; =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0/* Nothing to print */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D (log_end - con_start) & LOG_=
BUF_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 length =3D min(length , chunk_size);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0_con_start =3D con_start;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 _log_end =3D log_end;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_start =3D log_end; =A0 =A0 =A0 =A0 =
=A0 =A0/* Flush */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 _log_end =3D (con_start + length) & LOG=
_BUF_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 con_start =3D _log_end; =A0 =A0 =A0 =A0=
 =A0 /* Flush */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock(&logbuf_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stop_critical_timings(); =A0 =A0 =A0 =A0=
/* don't trace print latency */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0call_console_drivers(_con_start, _log_=
end);

That's a much better attempt than the disastrous one I made.  But it
didn't help at all, and I think I know one reason: if we reenable
interrupts every 1K, and I have 230K to dump, that's 230 additional
ticks we might get.  But with HZ=3D1000, that's only a quarter second o=
f
wallclock time.

Even at 115200 baud, I think we can only print about 10 characters/ms.
 It doesn't seem reasonable to me to try to flush in chunks anywhere
near that small.

But something else must still be going on, because even when I *did*
turn the chunk size down to 100 or 10 or even 4 characters, we still
didn't recover any of that missing wallclock time.  I tried to verify
that interrupts were actually enabled by the local_irq_restore(), and
they were, but maybe there's still a priority issue or something.

I wonder if we could do something with the TSC, e.g., capture it
early, then use it in getboottime() to compute the delta back from the
current time.  Machines without a stable TSC would use the present
system.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
