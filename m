From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Wed, 18 Jul 2018 17:50:55 +0300
Message-ID: <9bc02408588716c4ddb5a2ffb7d915019433fedc.camel@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
         <20180516100842.xuma7b3e727w7bpz@linutronix.de>
         <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
         <20180516104734.357oevogppu5bsg4@linutronix.de>
         <20180517134820.GI98604@atomide.com>
         <CAHp75Veb+zBfh=44qmMevvrfCSRYhfUMJUMArsDBtgM-F_FknQ@mail.gmail.com>
         <20180517194834.GW25808@atomide.com>
         <CAHp75Vf7L3zsSgaj1vfoyNKdPo0w6Nu+mW5HuM97SKAK-1y2Pg@mail.gmail.com>
         <20180523180052.GP98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523180052.GP98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-05-23 at 11:00 -0700, Tony Lindgren wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:54]:
> > On Thu, May 17, 2018 at 10:48 PM, Tony Lindgren <tony@atomide.com>
> > wrote:
> > > * Andy Shevchenko <andy.shevchenko@gmail.com> [180517 16:38]:
> > > > On Thu, May 17, 2018 at 4:48 PM, Tony Lindgren <tony@atomide.com
> > > > > wrote:
> > > > > * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [180516
> > > > > 10:49]:
> > > > > The idea breaking PM seems silly to me considering that we've
> > > > > had
> > > > > it working for years already.
> > > > 
> > > > Same question  / note. World is much more complex than just
> > > > being OMAP.
> > > 
> > > Sorry but you are making assumptions about hardware being powered
> > > on
> > > all the time.
> > 
> > Nope, other way around. The so called "support" _prevents_ our
> > hardware to go to sleep.
> 
> Hmm sorry now I'm all confused what issues you're having.
> 
> I thought you said earlier the issue was that you wanted to keep
> the console enabled all the time and never idle?

Yes, for kernel console.
To be clear, if user supplies "console=ttySx" it keeps powered on
always. But if there is no such parameter, we are fine with RPM.

Letting kernel console do power management on the systems without
irq_safe hack is dangerous in terms of loosing important data (crash, or
some other stuff which needs atomic context: kgdb?).

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
