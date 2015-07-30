From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Thu, 30 Jul 2015 12:12:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507301207070.3825@nanos>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <alpine.DEB.2.11.1507291230590.3825@nanos> <55B8BE39.6080500@hurleysoftware.com> <alpine.DEB.2.11.1507291351530.3825@nanos> <55B8D26A.7000402@hurleysoftware.com> <alpine.DEB.2.11.1507291534350.3825@nanos>
 <55B980E6.70800@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55B980E6.70800@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: Peter Hurley <peter@hurleysoftware.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Peter Zijlstra <peterz@infradead.org>
List-Id: linux-serial@vger.kernel.org

On Thu, 30 Jul 2015, Taichi Kageyama wrote:
> On 2015/07/29 22:35, Thomas Gleixner wrote:
> I know your code is sample (console.h is required), 
> but it is conflict with [patch v2 1/3].
> I think serial8250_console_write should not touch ctrl reg during autoconfig_irq. 
> To resolve the real problem, I think keeping only [patch v2 1/3] is best(opt1).
> What do you think?
> 
> opt1. keep [patch v2 1/3]
>     + Don't touch other legacy drivers using autoprobe.
>        Each driver can use console_lock to fix this problem if it happens.

No, we already know that autoprobing and console access can cause
this, so we fix it at the core code and be done with it.
 
Can you please test Peters patch and confirm that is solves it.

Thanks,

	tglx
