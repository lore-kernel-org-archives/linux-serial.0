From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 8/9] serdev: add a tty port controller driver
Date: Fri, 13 Jan 2017 17:55:07 +0200
Message-ID: <1484322907.2133.113.camel@linux.intel.com>
References: <20170106162635.19677-1-robh@kernel.org>
         <20170106162635.19677-9-robh@kernel.org>
         <1483798314.26691.3.camel@linux.intel.com>
         <CAL_JsqJtJaadieC2PSe6YV9pvvv8TXTM-hSDR5MZR+n-aRWo1g@mail.gmail.com>
         <1484319863.2133.110.camel@linux.intel.com>
         <CAL_JsqKjKz2=vWTBmzp9E3HrzJRszpq2hV4gsxcvnkTgRLH1QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAL_JsqKjKz2=vWTBmzp9E3HrzJRszpq2hV4gsxcvnkTgRLH1QQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Fri, 2017-01-13 at 09:28 -0600, Rob Herring wrote:
> On Fri, Jan 13, 2017 at 9:04 AM, Andy Shevchenko
> <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > On Thu, 2017-01-12 at 10:01 -0600, Rob Herring wrote:
> > > On Sat, Jan 7, 2017 at 8:11 AM, Andy Shevchenko
> > > <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> > > > On Fri, 2017-01-06 at 10:26 -0600, Rob Herring wrote:

> > > Yes, otherwise the bus can be built as a module and this driver
> > > can
> > > still be enabled breaking the build. I could drop supporting
> > > building
> > > the bus as a module because as long as this is the only controller
> > > driver, it all has to be built-in.
> > 
> > Would
> > 
> > if SERIAL_DEV_BUS=y
> > 
> > work for you?
> 
> Yes, until we add a driver that doesn't have to be built-in. What
> about "depends on SERIAL_DEV_BUS != m"? That would be a bit more clear
> what the reason is.

Ah, good point.

Yes, it would also work. My concern was here is not add confusing 
'depend on MENU_OPTION'.

-- 
Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Intel Finland Oy
