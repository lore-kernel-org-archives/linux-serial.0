From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Sun, 2 Aug 2015 11:52:53 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1508021150520.3825@nanos>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <alpine.DEB.2.11.1507291230590.3825@nanos> <55B8BE39.6080500@hurleysoftware.com> <alpine.DEB.2.11.1507291351530.3825@nanos> <55B8D26A.7000402@hurleysoftware.com> <alpine.DEB.2.11.1507291534350.3825@nanos>
 <55B980E6.70800@cp.jp.nec.com> <alpine.DEB.2.11.1507301207070.3825@nanos> <55BA2A06.1080109@hurleysoftware.com> <alpine.DEB.2.11.1507302204440.3825@nanos> <55BAB6B5.2090908@hurleysoftware.com> <55BB1D82.909@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55BB1D82.909@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 31 Jul 2015, Taichi Kageyama wrote:
> On 2015/07/31 8:43, Peter Hurley wrote:
> >> If you look at the actual autoprobe users aside of 8250. That's really
> >> all ancient ISA hardware and hardly interesting. So all we really care
> >> about are the 8250 serial ports.
> 
> In this case, I think [patch v2 1/3] is enough.
> console_lock is required in autoconfig_irq() to resolve other race conditions
> before calling probe_irq_on().

Fine with me.
 
> >> So why are you interested in that serial irq autoprobe crap at all?
> > 
> Because RHEL6 uses CONFIG_SERIAL_8250_DETECT_IRQ=y unfortunately.

Doh!
 
> I already got the following console solutions after discussion with Peter.
>  - Force set irq before any APs and getty open /dev/console. 
>    Users have to know valid irq#.
>  - Fix FW to define PNP
>  - CONFIG_SERIAL_8250_DETECT_IRQ=n

Ack!

Thanks,

	tglx
