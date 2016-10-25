From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/6] UART slave devices using serio
Date: Tue, 25 Oct 2016 17:02:23 -0500
Message-ID: <CAL_JsqJQqkyz99SY=RcQ22ZzsQSuCjFkjEPLdEqLmJU-usBf-g@mail.gmail.com>
References: <20160824232437.9446-1-robh@kernel.org> <20161025215521.5a5uxjpujmoatgor@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161025215521.5a5uxjpujmoatgor@earth>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Alan Cox <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Loic Poulain <loic.poulain-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 25, 2016 at 4:55 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Wed, Aug 24, 2016 at 06:24:30PM -0500, Rob Herring wrote:
>> This is a new approach to supporting UART slave devices using the
>> existing serio bus. After Arnd's proding, I took another look at serio
>> and decided extending it does make sense. Using serio primarily requires
>> adding DT based device matching and supporting buffer based write and
>> receive.
>>
>> Currently, I'm using the existing serio serport ldisc for testing. This
>> requires using inputattach to open the tty and set the ldisc which in
>> turn registers a serio port with the serio core:
>>
>> inputattach -bare /dev/ttyAMA1
>>
>> Once a tty_port based serio port driver is in place, this step will not
>> be needed. Supporting cases like a USB UART will also work if the USB
>> UART is described in DT. If not described in DT, I'm not sure if the
>> existing serio manual binding is sufficient (Need to figure out how that
>> works). Slave drivers also need other ways to specify additional data
>> using module params perhaps. Getting DT overlays to work for
>> non-discoverable devices behind discoverable buses (i.e. detached from
>> a base DT) is another option, but that's not yet supported in general.
>>
>> I've done all the serio changes in place, but ultimately I think at
>> least the core of serio should be moved out of drivers/input/. I don't
>> think it belongs under drivers/tty/ or drivers/tty/serial/, so
>> drivers/serio/?
>>
>> BT is working under QEMU to the point a slave driver can bind to a
>> serio port device via DT, register as a BT device, start sending out
>> initial packets and receive data (typed at a terminal). Now I need to
>> find a real device.
>
> I had a more detailed look at the series during the last two weeks.
> For me the approach looks ok and it should work for the nokia bluetooth
> use case. Actually my work on that driver is more or less stalled until
> this is solved, so it would be nice to get this forward. Whose feedback
> is this waiting from? I guess

I think it is mainly waiting for me to spend more time on it and get
the tty port part done. I could use help especially for converting the
BT part properly.

>  * Alan & Greg for the serial parts
>  * Marcel for the bluetooth parts
>  * Dmitry for the serio parts
>
> Maybe you can try to find some minutes at the Kernel Summit to talk
> about this?

Still waiting for my invite...

But I will be at Plumbers if folks want to discuss this.

Rob
