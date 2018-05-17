From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 0/3] console, serial8250: Disable PM and DMA ops
Date: Thu, 17 May 2018 19:38:59 +0300
Message-ID: <CAHp75VfqAK6+dPWWkQXjy0V-AFSGLSDJ9CmnUv=ba0F66TDTVg@mail.gmail.com>
References: <20180515183409.78046-1-andriy.shevchenko@linux.intel.com>
 <ca78895ac7ac84ec1c7f2f33024237af329ffd7a.camel@linux.intel.com>
 <20180516100842.xuma7b3e727w7bpz@linutronix.de> <CAHp75Vc2bJQHiWYcdKK+7wwMw2fSWxMauxP-dMRUAUdKnet7WQ@mail.gmail.com>
 <20180516104734.357oevogppu5bsg4@linutronix.de> <ed9879ef42a70d2609f60f73834cabb7e3df9e2f.camel@linux.intel.com>
 <20180517135621.GJ98604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180517135621.GJ98604@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-serial@vger.kernel.org

On Thu, May 17, 2018 at 4:56 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180516 13:12]:
>> On Wed, 2018-05-16 at 12:47 +0200, Sebastian Andrzej Siewior wrote:
>> > But since I am on it. You have to enable runtime-PM for the UART. So
>> > what is the problem if you simply don't enable it for the UART which
>> > used as the kernel console?
>>
>> How do I know at the ->probe() time that device in question is going to
>> be kernel console? Maybe I missed simple way of it.
>
> Hmm parse the kernel cmdline maybe? :)
>
> BTW, kernel already has earlycon doing exactly what you're trying to do.

I'm sorry, I didn't follow. What exactly earlycon does?

The problem is in 8250 driver. The issue with runtime PM used in atomic context.
So, I can, of course just remove callbacks from the console ->write().
Though it will prevent to use kernel console anyway.

-- 
With Best Regards,
Andy Shevchenko
