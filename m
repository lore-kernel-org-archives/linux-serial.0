From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Mon, 22 Aug 2016 17:00:40 -0500
Message-ID: <CAL_JsqJTbAri_7j5DWA2s1psyXMHu83MFXvEwB7tJGkwSwfU9g@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com>
 <2775954.hrE2UdODgU@wuerfel> <CAL_Jsq+tft4zsoOeE0WvMR3W9hAXEKzz35CgFtNJ6+P82uy-3A@mail.gmail.com>
 <20160822180254.5c95af7c@lxorguk.ukuu.org.uk> <CAL_JsqLe74GYN+j5muoCcnEX=BRu8cCvacRG0Xz7i+AEwxbDZg@mail.gmail.com>
 <20160822200026.4i32vakhzipv7asl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160822200026.4i32vakhzipv7asl@earth>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: One Thousand Gnomes <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Peter Hurley <peter-WaGBZJeGNqdsbIuE7sb01tBPR1lH4CV8@public.gmane.org>, NeilBrown <neil-+NVA1uvv1dVBDLzU/O5InQ@public.gmane.org>, "Dr . H . Nikolaus Schaller" <hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 22, 2016 at 3:00 PM, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> Hi,
>
> On Mon, Aug 22, 2016 at 12:30:27PM -0500, Rob Herring wrote:
>> On Mon, Aug 22, 2016 at 12:02 PM, One Thousand Gnomes
>> <gnomes-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org> wrote:
>> >> > I think there are two other valuable features provided by serio:
>> >> >
>> >> > - an existing set of drivers written to the API
>> >> > - the implementation of the tty_ldisc
>> >>
>> >> True, though I'd expect little of the data flow part of it to be reused.
>> >
>> > Then your design is broken.
>>
>> I'm talking about serio, not my design which I already said the
>> receive side at least needs work.
>>
>> The serio API for rx and tx is a single character at a time. I thought
>> we agreed that's not sufficient for things like BT.
>>
>> >> - a child of the uart node
>> >> - a reg property containing the line number if the parent has multiple
>> >> uarts (I'd expect this to rarely be used).
>> >
>> > That surprises me as for current x86 platforms it would be the norm,
>> > except that we use ACPI.
>>
>> Exactly, we're talking DT bindings here. Each port will be a separate
>> node otherwise things like serial aliases and stdout-path won't work
>> correctly. Compatible strings for 8250 uarts are for a single port.
>> But if you had h/w such that it has common and per port registers then
>> it may be a single node. I'm not aware of any example offhand (maybe
>> PPC CPM). But it doesn't matter as reg can handle this case just fine
>> if we need to.
>
> I would expect, that your imaginary example h/w also has one node
> per port using a mfd style h/w description:
>
> multi-uart-device {
>     uart1 {
>         child { };
>     };
>     uart2 {
>         child { };
>     };
> };

Yes, that is certainly possible too.

>> >> - baudrate and other line configuration (though I would expect the
>> >> slave driver to know all this and set it w/o DT. Also, we already have
>> >> a way to set baudrate in the parent node at least.)
>
> I'm not sure if every slave driver knows this. Maybe some generic
> slave drivers will come up, once we have the infrastructure. So
> it could be useful to have the settings as optional properties.
> OTOH it can also be done once it is needed.

Yes, you could have devices that do autobaud detect and don't care
other than some max baudrate which could be limited by either the host
or device. Then you have others that are fixed or start at a fixed
baud and then switch.

As for generic slaves, no doubt they will come up and I will be
nak'ing the generic slave bindings. The "generic slave" is already
supported via tty devices in userspace IMO.

Rob
