From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Thu, 30 Jul 2015 09:43:34 -0400
Message-ID: <55BA2A06.1080109@hurleysoftware.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <alpine.DEB.2.11.1507291230590.3825@nanos> <55B8BE39.6080500@hurleysoftware.com> <alpine.DEB.2.11.1507291351530.3825@nanos> <55B8D26A.7000402@hurleysoftware.com> <alpine.DEB.2.11.1507291534350.3825@nanos> <55B980E6.70800@cp.jp.nec.com> <alpine.DEB.2.11.1507301207070.3825@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507301207070.3825@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On 07/30/2015 06:12 AM, Thomas Gleixner wrote:
> On Thu, 30 Jul 2015, Taichi Kageyama wrote:
>> On 2015/07/29 22:35, Thomas Gleixner wrote:
>> I know your code is sample (console.h is required), 
>> but it is conflict with [patch v2 1/3].
>> I think serial8250_console_write should not touch ctrl reg during autoconfig_irq. 
>> To resolve the real problem, I think keeping only [patch v2 1/3] is best(opt1).
>> What do you think?
>>
>> opt1. keep [patch v2 1/3]
>>     + Don't touch other legacy drivers using autoprobe.
>>        Each driver can use console_lock to fix this problem if it happens.
> 
> No, we already know that autoprobing and console access can cause
> this, so we fix it at the core code and be done with it.
>  
> Can you please test Peters patch and confirm that is solves it.

Honestly, I'm not too sure this is the way to go.

Messing around with irqsoff tracer for 30 mins turned up:
3.664ms in intel_unmap_page
  - iotlb flush, spinlock contention on iova_rbtree_lock
1.726ms in intel_map_page()
  - iommu core @ __alloc_and_insert_iova_range()
1.859ms in syslog_print_all()
  - which is holding the logbuf_lock so that's pretty bad anyway
387us in nouveau @ nv50_vm_flush()
  - gpu tlb flush

I have irqsoff trace reports for all of these if anyone is interested.

Looks like lockdep would need to be off as well because I saw but
failed to capture a save_trace() in the 300us range.

I think this is just the tip of the iceberg for irqsoff.

I'm not saying these don't need fixing as well, but there's no way
irq probe will ever be reliable with this approach.

Going back to the RFC idea of pinning the irq affinity to the cpu
actually doing the probing (which is in a known context), what about
that is broken on UP? Just the implementation or is it the fundamental
concept?

Regards,
Peter Hurley
