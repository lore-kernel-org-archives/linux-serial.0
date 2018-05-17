From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Thu, 17 May 2018 10:04:52 -0700
Message-ID: <20180517170452.GK98604@atomide.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de>
 <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de>
 <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180517135621.GJ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Andy Shevchenko <andy.shevchenko@gmail.com>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [180517 06:56]:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180516 13:12]:
> > On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
> > > But since I am on it. You have to enable runtime-PM for the UART. So
> > > what is the problem if you simply don't enable it for the UART which
> > > used as the kernel console?
> > 
> > How do I know at the ->probe() time that device in question is going to
> > be kernel console? Maybe I missed simple way of it.
> 
> Hmm parse the kernel cmdline maybe? :)
> 
> BTW, kernel already has earlycon doing exactly what you're trying to do.

And if earlycon does not do the job, maybe just set up some
kernel command line parameter like "noidle" that makes serial
probe call pm_runtime_forbid().

Regards,

Tony
