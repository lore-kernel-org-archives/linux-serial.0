From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Wed, 18 Jul 2018 23:47:52 -0700
Message-ID: <20180719064752.GJ99251@atomide.com>
References: <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
 <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
 <20180517193008.GV25808@atomide.com>
 <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
 <20180523175859.GO98604@atomide.com>
 <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180718 15:17]:
> On Wed, 2018-05-23 at 10:58 -0700, Tony Lindgren wrote:
> > 
> > OK yeah console.idle sounds good to me. We should default to a
> > safe option.
> 
> I'll see what we can do here.

Like we discussed offline I think if we allow detaching and attaching
kernel console from userspace we can get rid of irqsafe completely :)
And in that case no need for console.idle or anything like that.

Then if kernel console is attached, we can keep console uart enabled.
If detached, it can do runtime PM if hardware supports it.

Not sure if we need some separate new /sys entry for that, maybe
we already have that with the loglevel in /proc/sys/kernel/printk?

Regards,

Tony
