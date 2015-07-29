From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [RFC PATCH v2 0/3] genirq, serial: 8250: Workaround to avoid
 irq=0 for console
Date: Wed, 29 Jul 2015 07:51:21 -0400
Message-ID: <55B8BE39.6080500@hurleysoftware.com>
References: <1438157443-19447-1-git-send-email-t-kageyama@cp.jp.nec.com> <alpine.DEB.2.11.1507291230590.3825@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1507291230590.3825@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>, Taichi Kageyama <t-kageyama@cp.jp.nec.com>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, "prarit@redhat.com" <prarit@redhat.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
List-Id: linux-serial@vger.kernel.org

On 07/29/2015 06:32 AM, Thomas Gleixner wrote:
> On Wed, 29 Jul 2015, Taichi Kageyama wrote:
>> - Keep interrupt disabled on the CPU which is used to detect 
>>   an interrupt during the timeout of autoconfig_irq().
>>      + Kick printk() on the CPU which detects interrupt 
>>        from a console serial port.
> 
> This is wrong to begin with. How is that supposed to work on an UP
> machine? Not at all.
> 
> So no, fix the code which has interrupts disabled accross autoprobing
> and do not try to apply bandaids somewhere else.

Like printk() from some unrelated driver?
