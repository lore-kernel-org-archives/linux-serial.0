From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [serial8250_interrupt] RIP: 0010:arch_local_irq_restore+0x2/0x8
Date: Tue, 21 Nov 2017 23:14:24 +0200
Message-ID: <1511298864.25007.370.camel@linux.intel.com>
References: <20171121090529.p3bcdz5y5bs5mqk2@wfg-t540p.sh.intel.com>
         <20171121123357.bw5raz3vqkob2vgz@wfg-t540p.sh.intel.com>
         <20171121133120.43fe5ak2gct56nmp@wfg-t540p.sh.intel.com>
         <1511275154.25007.349.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1511275154.25007.349.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>, linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Linus Torvalds <torvalds@linux-foundation.org>, Sean Young <sean@mess.org>, Matthias Brugger <mbrugger@suse.com>, linux-kernel@vger.kernel.org, lkp@01.org
List-Id: linux-serial@vger.kernel.org

On Tue, 2017-11-21 at 16:39 +0200, Andy Shevchenko wrote:
> On Tue, 2017-11-21 at 21:31 +0800, Fengguang Wu wrote:
> > On Tue, Nov 21, 2017 at 08:33:57PM +0800, Fengguang Wu wrote:

>>> FYI this happens in mainline kernel 4.14.0-02748-gabc36be.
> > > It shows up since v4.13 .
> > 
> > Sorry it actually also shows up in 4.10:

>> [   21.020567] irq 3: nobody cared (try booting with the "irqpoll"
> > option)

> > [   21.039171]  uart_start+0x73/0xe0

> > [   21.044977]  vfs_write+0xc8/0x1e0

> > [   21.054662] Disabling IRQ #3

Another question who and why initiates a write to ttyS1 (console seems
on ttyS0).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
