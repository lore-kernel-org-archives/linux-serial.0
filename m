From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Tue, 23 Aug 2016 16:04:55 -0500
Message-ID: <CAL_JsqJb0UXgZh_NZ0WtJz+nRPvZf8uViS8poDXWneC7zYsx=w@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <12886761.WF058qtZp8@wuerfel>
 <CAL_JsqL1s9QTc+xVXafcHmyiH+6Yy0Ded+JbeYhTtYNxLtWREg@mail.gmail.com> <2775954.hrE2UdODgU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2775954.hrE2UdODgU@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Sebastian Reichel <sre@kernel.org>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

+Dmitry to get his opinion on using serio.

On Mon, Aug 22, 2016 at 10:24 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday, August 22, 2016 8:38:23 AM CEST Rob Herring wrote:
>> On Mon, Aug 22, 2016 at 7:37 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday, August 17, 2016 8:14:42 PM CEST Rob Herring wrote:
>> >>
>> >> Before I spend more time on this, I'm looking mainly for feedback on the
>> >> general direction and structure (the interface with the existing serial
>> >> drivers in particular).
>> >
>> > Aside from the things that have already been mentioned in the discussion,
>> > I wonder how this should relate to the drivers/input/serio framework.
>>
>> As I mentioned, I did investigate that route.
>
> Ok, sorry for missing that.
>
>> > My impression is that there is some overlap in what you want
>> > to do here, and what serio does today as a line discipline on top
>> > of a tty line discipline (and on top of other non-uart serial
>> > connections), so we should look into whether the two can be unified
>> > or not. Here is what I found so far:
>> >
>> > For all I can tell, serio is only used for drivers/input/ but could
>> > easily be extended to other subsystems. It currently uses its own
>> > binary ID matching between drivers and devices through user space
>> > interfaces, though adding a DT binding for it would appear to be
>> > a good idea regardless.
>> >
>> > It also has a bus_type already, and with some operations defined on
>> > it. In particular, it has an "interrupt" method that is used to
>> > notify the client driver when a byte is available (and pass
>> > that byte along with it). This seems to be a useful addition to
>> > what you have. Since it is based on sending single characters
>> > both ways, transferring large amounts of data would be slower,
>> > but the interface is somewhat simpler. In principle, both
>> > character based and buffer based interfaces could coexist here
>> > as they do in some other interfaces (e.g. smbus).
>>
>> Given that about the only things it really provided are the bus_type
>> and associated boilerplate without much of a client interface, it
>> seemed to me that creating a new subsystem first made more sense. Then
>> we can convert serio to use the new subsystem.
>
> One possible downside of merging later is that we end up having to
> support the existing user space ABI for serio that may not fit well
> within whatever we come up with independently.
>
> I think there are two other valuable features provided by serio:
>
> - an existing set of drivers written to the API
> - the implementation of the tty_ldisc

I've looked at serio a bit more and was able to add in DT matching to
it. It's a bit hacky to make it work with the ldisc as it gets the DT
node from serio->dev.parent->parent (the parent is the tty and
grandparent is the uart dev) and still requires inputattach to open
the tty and set the ldisc. Otherwise, the mode for inputattach doesn't
matter. So I plan to continue down this path.

One thing I'm left wondering is serio essentially implements it's own
async probing with connect()/disconnect(). Seems like it was because
PS/2 port probing and resuming are slow. Is this still necessary or
could be converted to use driver core async probing? That would make
serio drivers look a bit more "normal".

Rob
