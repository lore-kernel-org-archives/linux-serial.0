From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Wed, 29 Jul 2015 12:32:59 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1507291230590.3825@nanos>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "peter@hurleysoftware.com" <peter@hurleysoftware.com>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

On Wed, 29 Jul 2015, Taichi Kageyama wrote:
> - Keep interrupt disabled on the CPU which is used to detect 
>   an interrupt during the timeout of autoconfig_irq().
>      + Kick printk() on the CPU which detects interrupt 
>        from a console serial port.

This is wrong to begin with. How is that supposed to work on an UP
machine? Not at all.

So no, fix the code which has interrupts disabled accross autoprobing
and do not try to apply bandaids somewhere else.

Thanks,

	tglx
