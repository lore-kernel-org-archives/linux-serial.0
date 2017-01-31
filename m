From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/5] Serial slave device bus
Date: Tue, 31 Jan 2017 09:45:40 -0600
Message-ID: <CAL_JsqLw7XceDh81=doxDf++=AoUXubcCNd9HXurrMpaV6Sn+w@mail.gmail.com>
References: <20170125202343.30923-1-robh@kernel.org> <20170131030241.kehmuuxsbnbk5nnt@earth>
 <20170131054415.eiboj4ivumanxgso@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170131054415.eiboj4ivumanxgso@earth>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Jan 30, 2017 at 11:44 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Tue, Jan 31, 2017 at 04:02:41AM +0100, Sebastian Reichel wrote:
>> On Wed, Jan 25, 2017 at 02:23:38PM -0600, Rob Herring wrote:
>> > Here's V3 of the serdev bus support with all the review feedback so far
>> > incorporated. Greg applied the first 4 patches already. I also found a
>> > problem in the tty_port_wakeup changes and have fixed that.
>> >
>> > I've added serdev support to the BT hci_ll.c driver as it turns out it works
>> > on newer TI chips too, but just needed firmware loading. That avoids the
>> > impossible mess of cleaning up the TI-ST driver, and it's in a much closer
>> > state to being ready for upstream. I've sent that out separately.
>> >
>> > Changelog is in individual patches. Previous versions are here[1][2]. This
>> > series and the mentioned drivers can be found here[3].
>> >
>> > Rob
>> >
>> > [1] http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1304151.html
>> > [2] http://www.mail-archive.com/linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg1311650.html
>> > [3] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git serial-bus-v4
>>
>> I rebased my nokia bluetooth driver on top of [3]. It's not yet
>> working, but everything added by this patchset (and
>> "bluetooth: hci_uart: add serdev driver support library") seems
>> to work as expected, so for the whole series:
>>
>> Tested-By: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

Thanks.

> FWIW, I got bluetooth on top of your patchset working on N950. N900
> is not yet tested and probably does not yet work (it's more picky
> about flow control and usage of the wakeup gpios). You can find a
> branch with the additional patches @ [4]. I had to add serdev
> functions to wait for TX buffer depletion and checking CTS. Apart
> from that flow control only worked correctly when also taking care
> of RTS (like hci_uart_set_flow_control does).

I'd originally copied hci_uart_set_flow_control, but then realized
that it didn't really do what I wanted. What I have now is turn on or
off h/w control (i.e. off is no RTS/CTS signals connected). What
hci_uart_set_flow_control does is enable h/w flow control
(enable=false) or force assert RTS (enable=true). I guess it didn't
help that I used the same _set_flow_control naming with different
behavior. I did expect we'd also need something for RTS control, but
figured we'd add it as needed and wanted to come up with something a
bit clearer as to the function (i.e. serdev_device_pause_rx or
serdev_device_assert_rts).

> I noticed, that you did not yet write any DT bindings for your
> bluetooth slaves. Did you already decide for a location?

Marvell BT is already in bindings/net/.

Rob

>
> [4] git://git.kernel.org/pub/scm/linux/kernel/git/sre/linux-n900.git serial-bus-v4-nokia-bt
>
> -- Sebastian
