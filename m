From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 10/10] Bluetooth: add nokia driver
Date: Wed, 8 Mar 2017 08:26:33 -0600
Message-ID: <CAL_JsqJwqoTkFGKGx4g5Fvq=R1SnQ=bB0z0=UxNA2uGTJ6ngOA@mail.gmail.com>
References: <20170304115833.3538-1-sre@kernel.org> <20170304115833.3538-11-sre@kernel.org>
 <CAL_Jsq+PvqS_tU6wRzpcsdESYxOOU_JJqsacEc9qLDs2PB2VLw@mail.gmail.com> <20170307210837.w5fdwc2sy3xmzci7@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307210837.w5fdwc2sy3xmzci7@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 7, 2017 at 3:08 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Rob,
>
> On Tue, Mar 07, 2017 at 10:30:51AM -0600, Rob Herring wrote:
>> On Sat, Mar 4, 2017 at 5:58 AM, Sebastian Reichel <sre@kernel.org> wrote:
>> > This adds a driver for the Nokia H4+ protocol, which is used
>> > at least on the Nokia N9, N900 & N950.
>> >
>> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
>> > ---
>> >  .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
>>
>> This should be separate and before the dts files.
>>
>> >  drivers/bluetooth/Kconfig                          |  12 +
>> >  drivers/bluetooth/Makefile                         |   2 +
>> >  drivers/bluetooth/hci_nokia.c                      | 839 +++++++++++++++++++++
>> >  4 files changed, 904 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> >  create mode 100644 drivers/bluetooth/hci_nokia.c
>> >
>> > diff --git a/Documentation/devicetree/bindings/net/nokia-bluetooth.txt b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > new file mode 100644
>> > index 000000000000..6c80a92f31e2
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/net/nokia-bluetooth.txt
>> > @@ -0,0 +1,51 @@
>> > +Nokia Bluetooth Chips
>> > +---------------------
>> > +
>> > +Nokia phones often come with UART connected bluetooth chips from different
>> > +vendors and modified device API. Those devices speak a protocol named H4+
>> > +by Nokia, which is similar to the H4 protocol from the Bluetooth standard.
>> > +In addition to the H4 protocol it specifies two more UART status lines for
>> > +wakeup of UART transceivers to improve power management and a few new packet
>> > +types used to negotiate uart speed.
>> > +
>> > +Required properties:
>> > +
>> > + - compatible: should be one of the following:
>> > +   * "nokia,brcm,bcm2048"
>> > +   * "nokia,ti,wl1271-bluetooth"
>>
>> Drop the chip vendors' prefix here. I don't really want to start a
>> pattern of 2 vendor prefixes.
>
> Right, I think we discussed this before, but I don't remember the
> result. How about
>
> - compatible: should contain "nokia,h4p-bluetooth" as well as one of the following:
>  * "brcm,bcm2048-nokia"
>  * "ti,wl1271-blueooth-nokia"

Sure, that's fine (other than the typo).

> For the driver it should be enough to know "nokia,h4p-bluetooth"
> actually. The device identifies itself in the negotiation reply.
>
>> > + - reset-gpios: GPIO specifier, used to reset the BT module
>>
>> Need to state active state.
>
> ok. Any suggestion about the wording? The BT chips use usually
> active low reset pin. The driver handles all GPIOs as active
> high with the DT binding translating this transparently.

Just having "active low" in there is enough.

Personally I find the GPIO translating confusing...

Rob
