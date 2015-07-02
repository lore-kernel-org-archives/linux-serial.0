From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC v2 1/3] tty: serial core: provide method to search
 uart by phandle
Date: Thu, 2 Jul 2015 14:08:31 -0500
Message-ID: <CAL_JsqLeLeeeX=7nPVe7sFm+GUfAwDGoX925QWuZLB2iYZMXvA@mail.gmail.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com>
 <1435520786-31867-2-git-send-email-marek@goldelico.com> <CAL_JsqK10SLjtDQ7e=kMMrNz5aTQ7Tgzq+zmX+qhxkOUbiLUew@mail.gmail.com>
 <C73186C5-51E8-4EFB-B8FB-520C0A9B0D13@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C73186C5-51E8-4EFB-B8FB-520C0A9B0D13@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, Neil Brown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 1, 2015 at 2:07 PM, Dr. H. Nikolaus Schaller
<hns@goldelico.com> wrote:
> Hi,
>
> Am 01.07.2015 um 20:16 schrieb Rob Herring <robherring2@gmail.com>:
>
>> On Sun, Jun 28, 2015 at 2:46 PM, Marek Belisko <marek@goldelico.com>=
 wrote:
>>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>>
>>> 1. add registered uart_ports to a search list
>>> 2. provide a function to search an uart_port by phandle. This copie=
s the
>>>   mechanism how devm_usb_get_phy_by_phandle() works
>>
>> How does this relate to Neil's tty/uart slaves series?
>
> we had questioned the approach of interpreting uarts as a degenerated=
 single-client
> bus and therefore handling uart slave devices by subnodes.
>
> Rather than having a =E2=80=9EUART n is connected to device=E2=80=9C =
subnode, we think that a
> =E2=80=9Ethis device is connected to UART n=E2=80=9C phandle is the m=
ost elegant and flexible
> way to implement it. Like it is for PHY relations within the USB subs=
ystem.

PHYs are typically a bit different in that they already have
parent/child relationship with MMIO registers which is the primary
hierarchy in DT.

There's no reason we can't support both cases, but I'm not yet
convinced we have a need yet for both. The parent/child approach is
simpler to deal with probe ordering issues as the children can be
enumerated when the parent has completed enumeration. We should use
the DT hierarchy when possible rather than just sticking everything at
the top level.

> After a long theoretical discussion we were asked to submit code to b=
etter allow
> to compare both approaches.

What discussion? I don't recall seeing anything related to the binding =
part.

I've not looked closely at the kernel implementations which I guess
are where the major differences are. It would be helpful to have some
summary comparing the options. The only clue I had that you had looked
at Neil's version is he is cc'ed here.

>
> Here it is.
>
> So common is the problem that we want to solve. Different is the solu=
tion.
>
> Both implementations are tested to work on the GTA04 hardware.
>
>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>>> ---
>>> Documentation/serial/slaves.txt  |  36 ++++++++++++++
>>
>> You need to split this into DT binding and whatever kernel specific
>> documentation you want. My comment below apply to what goes in the
>> binding doc.
>
> This driver does not define any specific bindings for the slave devic=
e, therefore
> we have not provided a bindings document. It is up to the slave drive=
r to provide
> one.

Then where is the property "uart" documented? That is a specific
binding like clock or gpio bindings. Bindings for uart slaves is
something that should be defined generically. That is not something
that should be or has any benefit of being defined per device.

> This driver just provides means that a slave driver can interact with=
 the tty/serial
> driver.
>
> Bindings for a specific slave device are defined in our
> [PATCH RFC v2 3/3] misc: Add w2g0004 gps receiver driver
> ../devicetree/bindings/misc/wi2wi,w2sg0004.txt

Right, and that needs to refer to a common binding doc. Simply put, I
will reject describing any UART devices in DT until that happens.

>>> drivers/tty/serial/serial_core.c | 103 ++++++++++++++++++++++++++++=
+++++++++++
>>> include/linux/serial_core.h      |  10 ++++
>>> 3 files changed, 149 insertions(+)
>>> create mode 100644 Documentation/serial/slaves.txt
>>>
>>> diff --git a/Documentation/serial/slaves.txt b/Documentation/serial=
/slaves.txt
>>> new file mode 100644
>>> index 0000000..6f8d44d
>>> --- /dev/null
>>> +++ b/Documentation/serial/slaves.txt
>>> @@ -0,0 +1,36 @@
>>> +UART slave device support
>>> +
>>> +A remote device connected to a RS232 interface is usually power co=
ntrolled by the DTR line.
>>> +The DTR line is managed automatically by the UART driver for open(=
) and close() syscalls
>>> +and on demand by tcsetattr().
>>> +
>>> +With embedded devices, the serial peripheral might be directly and=
 always connected to the UART
>>> +and there might be no physical DTR line involved. Power control (o=
n/off) has to be done by some
>>> +chip specific device driver (which we call "UART slave") through s=
ome mechanisms (I2C, GPIOs etc.)
>>> +not related to the serial interface. Some devices do not explicitl=
y tell their power state except
>>> +by sending or not sending data to the UART. In such a case the dev=
ice driver must be able to monitor
>>> +data activity. The role of the device driver is to encapsulate suc=
h power control in a single place.
>>> +
>>> +This patch series allows to support such drivers by providing:
>>> +* a mechanism that a slave driver can identify the UART instance i=
t is connected to
>>> +* a mechanism that UART slave drivers can register to be notified
>>> +* notfications for DTR (and other modem control) state changes
>>
>> This has nothing to do with the binding really, but is rather a Linu=
x
>> driver feature.
>
> Yes, we want to describe the linux driver features here.
>
>>
>>> +* notifications that the UART has received some data from the UART
>>> +
>>> +A slave device simply adds a phandle reference to the UART it is c=
onnected to, e.g.
>>
>> By default I think this should be a sub-node of the uart.
>
> We want to show with this implementation that uart-subnodes would be =
the wrong
> way to go.
>
>> There are
>> more complicated cases of combo devices which we may need to support
>> with phandles, but by default we should use sub-nodes to describe
>> connections.
>
> There can be serial devices which are power-controlled by I2C and the=
n
> we would have a problem to describe the connection as both I2C and UA=
RT
> subnodes.

Sure, and I would agree that under I2C is the right place in that case.

However, that does not appear to be the case for the device you care ab=
out.

> For us the "main interface=E2=80=9C of a chip is the one that allows =
to turn the device
> on and off. And not the one that carries data provided by/to user spa=
ce (=E2=80=9Epayload=E2=80=9C).

=46or nearly everything else in DT, that is not the case.

>
> This is rarely the serial data stream. Hence describing the subdevice=
 by a
> subnode of the uart is describing something different from what we ne=
ed.
>
>>
>>> +
>>> +       gps {
>>> +               compatible =3D "wi2wi,w2sg0004";
>>> +               uart =3D <&uart1>;
>>
>> What if you have a device with 2 uart connections? Do you have 2 ite=
ms
>> in the list or do multiple "<name>-uart" entries? The former is
>> probably sufficient and easier to parse.
>
> It is up to the subdevice driver how it is implemented. So view this =
as an example
> that has only one uart connection.
>
> For two uart connections you can choose either of your proposals sinc=
e the translatori
> function has both a phandle node name and an index.

Yes, either will work and we have examples of both styles in DT. We
just have to pick one and document that is my point. We should not
leave it up to each device.

>> devm_serial_get_uart_by_phandle(struct device *dev,
>> +             const char *phandle, u8 index)
>
>
> You can call this function twice as:
>
>> uart1 =3D devm_serial_get_uart_by_phandle(dev, =E2=80=9Euart=E2=80=9C=
, 0)
>> uart2 =3D devm_serial_get_uart_by_phandle(dev, =E2=80=9Euart=E2=80=9C=
, 1)
>
> or
>
>> uart1 =3D devm_serial_get_uart_by_phandle(dev, =E2=80=9Euart1=E2=80=9C=
, 0)
>> uart2 =3D devm_serial_get_uart_by_phandle(dev, =E2=80=9Euart2=E2=80=9C=
, 0)
>
> whatever better fits. But this is up to the device driver where it IM=
HO belongs to.
>
> Our serial core driver does not predefine anything. It just provides =
a mechanism
> that a driver can translate phandles into struct uart.
>
> What we should do is to mark this DT fragment in this driver document=
ation as
> an example to avoid misinterpretations.
>
>>
>>> +       };
>>> +
>>> +The slave driver calls devm_serial_get_uart_by_phandle() to identi=
fy the uart driver.
>>> +This API follows the concept of devm_usb_get_phy_by_phandle().
>>> +
>>> +A slave device driver registers itself with serial_register_slave(=
) to receive notifications.
>>> +Notification handler callbacks can be registered by serial_registe=
r_mctrl_notification() and
>>> +serial_register_rx_notification(). If an UART has registered a NUL=
L slave or a NULL handler,
>>> +no notifications are sent.
>>> +
>>> +RX notification handlers can define a ktermios during setup and th=
e handler function can modify
>>> +or decide to throw away each character that is passed upwards.
>>
>> All these 3 paragraphs should not be in the binding doc.
>
> Maybe you have compared too much with Neil=E2=80=99s implementation.
>
> This is not a binding doc, but a description/documentation of our pro=
posed extension
> of the serial core driver.

As I've mentioned, you need a binding doc. You can have this part too,
just not in the binding doc.

Rob
