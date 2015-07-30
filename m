From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Thu, 30 Jul 2015 19:43:49 -0400
Message-ID: <55BAB6B5.2090908@hurleysoftware.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <alpine.DEB.2.11.1507291230590.3825@nanos> <55B8BE39.6080500@hurleysoftware.com> <alpine.DEB.2.11.1507291351530.3825@nanos> <55B8D26A.7000402@hurleysoftware.com> <alpine.DEB.2.11.1507291534350.3825@nanos> <55B980E6.70800@cp.jp.nec.com> <alpine.DEB.2.11.1507301207070.3825@nanos> <55BA2A06.1080109@hurleysoftware.com> <alpine.DEB.2.11.1507302204440.3825@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507302204440.3825@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Taichi Kageyama <t-kageyama@cp.jp.nec.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On 07/30/2015 06:12 PM, Thomas Gleixner wrote:
> On Thu, 30 Jul 2015, Peter Hurley wrote:
>> Honestly, I'm not too sure this is the way to go.
>>
>> Messing around with irqsoff tracer for 30 mins turned up:
>> 3.664ms in intel_unmap_page
>>   - iotlb flush, spinlock contention on iova_rbtree_lock
>> 1.726ms in intel_map_page()
>>   - iommu core @ __alloc_and_insert_iova_range()
>> 1.859ms in syslog_print_all()
>>   - which is holding the logbuf_lock so that's pretty bad anyway
>> 387us in nouveau @ nv50_vm_flush()
>>   - gpu tlb flush
>>
>> I have irqsoff trace reports for all of these if anyone is interested.
>>
>> Looks like lockdep would need to be off as well because I saw but
>> failed to capture a save_trace() in the 300us range.
>>
>> I think this is just the tip of the iceberg for irqsoff.
> 
> I agree.
>  
>> I'm not saying these don't need fixing as well, but there's no way
>> irq probe will ever be reliable with this approach.
> 
> irq probe is a known to be unreliable heuristic endavour anyway and it
> cannot ever become truly reliable, except you put a gazillion of
> restrictions to the system state on it.

Yep, totally agree. As you note below, this functionality is completely
disabled on every known distro kernel.


>> Going back to the RFC idea of pinning the irq affinity to the cpu
>> actually doing the probing (which is in a known context), what about
>> that is broken on UP? Just the implementation or is it the fundamental
>> concept?
> 
> First of all, there is no guarantee that you can affine these
> interrupts at all. We have interrupt controllers which cannot set the
> affinity and they deliver to cpus in a round robin scheme or whatever
> hardware designers thought would be clever.
> 
> Second, what prevents the following scenario on UP or the affine core:
> 
> 	probe_start()
> 	interrupt
> 	  looong running handler (usb is an obvious candidate)
> 	     printk()
> 
> That will swallow your uart state and ruin detection as well.

Yeah, ok, so fundamentally broken concept to pin the irqs for probing.
Thanks for clarifying that.


> So for the problem at hand, we really need to prevent that something
> is fiddling with the uart in the first place and the most obvious way
> is to serialize against printk.

I'm ok with just the original patch 1 (which I reviewed some time ago).


> We can debate whether the autoprobe code is the right place or not, we
> can actually stick it into the 8250 driver and be done with it
> because:
> 
> If you look at the actual autoprobe users aside of 8250. That's really
> all ancient ISA hardware and hardly interesting. So all we really care
> about are the 8250 serial ports.
> 
> Now lets look at the 8250 serial ports. I just checked the random
> collection of machines I have access to:
> 
>  In 100% of all cases ttyS0 is on irq4 and ttyS1 is on irq3
> 
>  All of the machines have even a correct PNP entry of the irq resource
>  for the serial ports. And there is pretty old crap in that lot.
> 
> So the real question is: Why would we autoprobe in the first place?
> 
> Debian, Fedora, OpenSuse, SLES have:
> 
>    # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> 
> and so do my kernels.
> 
> I just built one with that option enabled for the fun of it and it
> still uses the PNP information. No autoprobing.
> 
> So why are you interested in that serial irq autoprobe crap at all?

Agree, but I guess the hardware in question is non-PNP serial-over-LAN.
It's Taichi's hardware so he can be more specific. Also, this problem
would not apply to 8250 ports @ the ISA addresses (3f8,irq 4 & 2f8,irq 3)
because those are predefined on the platform.

Taichi's original proposal was to add module parameters for the serial
driver, which I am dead set against, having just struggled to deal with
ancient module parameters while splitting the 8250 driver.

I also noted in reviewing that proposal that user-space tools (setserial)
can reset the irq to a known value after driver load. Ubuntu, for one,
runs setserial as part of boot (to restore serial hardware to known-working
configuration).

Regards,
Peter Hurley
