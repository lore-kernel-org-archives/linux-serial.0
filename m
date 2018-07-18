From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Wed, 18 Jul 2018 18:14:03 +0300
Message-ID: <c10bb604a6bf416e2092ae64a2cb9bb4658ea0eb.camel@linux.intel.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
         <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
         <20180516100842.xuma7b3e727w7bpz@linutronix.de>
         <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
         <20180516104734.357oevogppu5bsg4@linutronix.de>
         <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
         <20180517135621.GJ98604@atomide.com>
         <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
         <20180517193008.GV25808@atomide.com>
         <CAHp75Ve56pyEC41XZ9i9yxBNberQe=ee2miQL0v9T4vRtkWPBQ@mail.gmail.com>
         <20180523175859.GO98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180523175859.GO98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Wed, 2018-05-23 at 10:58 -0700, Tony Lindgren wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> [180522 21:42]:
> > On Thu, May 17, 2018 at 10:30 PM, Tony Lindgren <tony@atomide.com>
> > wrote:
> > > So how about add some "noidle" kernel command line parameter for
> > > console
> > > that calls
> > > pm_runtime_forbid() and then you have the UART permanently
> > > on.
> > 
> > IIUC _forbid() can be overwritten via sysfs.
> > And I would prefer to do other way around, something like
> > console.idle
> > and put default for OMAP to yes and no for everything else.
> 
> OK yeah console.idle sounds good to me. We should default to a
> safe option.

I'll see what we can do here.

> > > Hmm I guess you could make also serial8250_rpm_get() do nothing
> > > based on that.
> > 
> > Have you seen entire series which I keep here:
> > https://bitbucket.org/andy-shev/linux/branch/topic/uart/rpm?
> > Among other things it gets rid of those specific callbacks entirely.
> 
> Well I was not Cc:ed on it, I browsed it in some archive and it
> seemed unsafe to me. But if you figured out a way to do it
> conditionally
> based on console.idle
>  without causing regressions.

I restored that branch with some updated patches. It's far from done and
doesn't have any new stuff (yet) regrading to this discussion.

> > > I do agree the serial runtime PM has an issue if it depends on
> > > pm_runtime_irq_safe() being set.
> > 
> > It's more than an issue. The  so called "support" of RPM for UART is
> > _based on the hack_.
> > I would love to NAK that in the first place if I would have known of
> > it in time.
> 
> Hmm well it seems that you too have been patching the 8250_rpm
> functions for years and then now what after multiple years you
> hit this issue? :)

Nope, I hit it as soon as I tried.

I can't find easily the discussion (hmm... yes, I was so pissed off that
time, I put a bit of harsh in that) I had with Sebastian few years back,
but at least I reported about an issue.

> > > > So, I can, of course just remove callbacks from the console
> > > > ->write().
> > > > Though it will prevent to use kernel console anyway.
> > > 
> > > Please et's not start breaking things, we already see a constant
> > > flow of regressions on weekly basis.
> > 
> > Now we are stick with a hack and the case based on that is against
> > fixing things.
> > This is how it looks from my side.
> 
> Sorry yeah I agree there are issues, but let's fix it properly

Agree.

>  with
> no regressions.

...though I think a word "regression" is inappropriate here. Regression
is what the support did in the first place. Pity I didn't know about it
at that time.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
