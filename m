From: Yegor Yefremov <yegorslists@googlemail.com>
Subject: Re: [PATCH 1/3 v6] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
Date: Fri, 14 Jun 2019 11:38:31 +0200
Message-ID: <CAGm1_ktOJEzW9bkkUaVe2ioUBAV4hNoSbQSg+EUHz2sr4ppF+g@mail.gmail.com>
References: <20190613154542.32438-1-sr@denx.de> <20190613170802.GE9224@smile.fi.intel.com>
 <CAGm1_ksNqh0ZVO+aHsdcS6XQHt3hfqWE3a=3waKWEp8Oc8HWcQ@mail.gmail.com> <0bf6629c-cedf-e1dd-b42b-989c6711d390@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0bf6629c-cedf-e1dd-b42b-989c6711d390@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Jun 14, 2019 at 11:29 AM Stefan Roese <sr@denx.de> wrote:
>
> On 14.06.19 11:04, Yegor Yefremov wrote:
> > On Thu, Jun 13, 2019 at 7:08 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> On Thu, Jun 13, 2019 at 05:45:40PM +0200, Stefan Roese wrote:
> >>> This patch adds a check for the GPIOs property existence, before the
> >>> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> >>> support is added (2nd patch in this patch series) on x86 platforms using
> >>> ACPI.
> >>>
> >>> Here Mika's comments from 2016-08-09:
> >>>
> >>> "
> >>> I noticed that with v4.8-rc1 serial console of some of our Broxton
> >>> systems does not work properly anymore. I'm able to see output but input
> >>> does not work.
> >>>
> >>> I bisected it down to commit 4ef03d328769eddbfeca1f1c958fdb181a69c341
> >>> ("tty/serial/8250: use mctrl_gpio helpers").
> >>>
> >>> The reason why it fails is that in ACPI we do not have names for GPIOs
> >>> (except when _DSD is used) so we use the "idx" to index into _CRS GPIO
> >>> resources. Now mctrl_gpio_init_noauto() goes through a list of GPIOs
> >>> calling devm_gpiod_get_index_optional() passing "idx" of 0 for each. The
> >>> UART device in Broxton has following (simplified) ACPI description:
> >>>
> >>>      Device (URT4)
> >>>      {
> >>>          ...
> >>>          Name (_CRS, ResourceTemplate () {
> >>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> >>>              {
> >>>                  0x003A
> >>>              }
> >>>              GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
> >>>                      "\\_SB.GPO0", 0x00, ResourceConsumer)
> >>>              {
> >>>                  0x003D
> >>>              }
> >>>          })
> >>>
> >>> In this case it finds the first GPIO (0x003A which happens to be RX pin
> >>> for that UART), turns it into GPIO which then breaks input for the UART
> >>> device. This also breaks systems with bluetooth connected to UART (those
> >>> typically have some GPIOs in their _CRS).
> >>>
> >>> Any ideas how to fix this?
> >>>
> >>> We cannot just drop the _CRS index lookup fallback because that would
> >>> break many existing machines out there so maybe we can limit this to
> >>> only DT enabled machines. Or alternatively probe if the property first
> >>> exists before trying to acquire the GPIOs (using
> >>> device_property_present()).
> >>> "
> >>>
> >>> This patch implements the fix suggested by Mika in his statement above.
> >>>
> >>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > I cannot compile the driver without adding #include <linux/property.h>
> > to drivers/tty/serial/serial_mctrl_gpio.c.
> >
> > My platform is AM335X (OMAP3). I've tried the patches both against the
> > main repo and also tty-next.
> >
> > Other than that everything is working.
>
> Thanks for reporting. I'll wait a bit for other review comments and
> tests (thanks Andy) and will then send v7 with this header included
> (and compile tested on OMAP3) later next week.
>
> BTW: Could you please add a Tested-by-tag with the next version?

Will do.
