From: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH RFC v2 1/3] tty: serial core: provide method to search uart by phandle
Date: Wed, 1 Jul 2015 21:07:38 +0200
Message-ID: <C73186C5-51E8-4EFB-B8FB-520C0A9B0D13@goldelico.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com> <1435520786-31867-2-git-send-email-marek@goldelico.com> <CAL_JsqK10SLjtDQ7e=kMMrNz5aTQ7Tgzq+zmX+qhxkOUbiLUew@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqK10SLjtDQ7e=kMMrNz5aTQ7Tgzq+zmX+qhxkOUbiLUew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robherring2@gmail.com>
Cc: Marek Belisko <marek@goldelico.com>, Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, Neil Brown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Am 01.07.2015 um 20:16 schrieb Rob Herring <robherring2@gmail.com>:

> On Sun, Jun 28, 2015 at 2:46 PM, Marek Belisko <marek@goldelico.com> =
wrote:
>> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>>=20
>> 1. add registered uart_ports to a search list
>> 2. provide a function to search an uart_port by phandle. This copies=
 the
>>   mechanism how devm_usb_get_phy_by_phandle() works
>=20
> How does this relate to Neil's tty/uart slaves series?

we had questioned the approach of interpreting uarts as a degenerated s=
ingle-client
bus and therefore handling uart slave devices by subnodes.

Rather than having a =84UART n is connected to device=93 subnode, we th=
ink that a
=84this device is connected to UART n=93 phandle is the most elegant an=
d flexible
way to implement it. Like it is for PHY relations within the USB subsys=
tem.

After a long theoretical discussion we were asked to submit code to bet=
ter allow
to compare both approaches.

Here it is.

So common is the problem that we want to solve. Different is the soluti=
on.

Both implementations are tested to work on the GTA04 hardware.

>=20
>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>> Signed-off-by: Marek Belisko <marek@goldelico.com>
>> ---
>> Documentation/serial/slaves.txt  |  36 ++++++++++++++
>=20
> You need to split this into DT binding and whatever kernel specific
> documentation you want. My comment below apply to what goes in the
> binding doc.

This driver does not define any specific bindings for the slave device,=
 therefore
we have not provided a bindings document. It is up to the slave driver =
to provide
one.

This driver just provides means that a slave driver can interact with t=
he tty/serial
driver.

Bindings for a specific slave device are defined in our
[PATCH RFC v2 3/3] misc: Add w2g0004 gps receiver driver
=2E./devicetree/bindings/misc/wi2wi,w2sg0004.txt

>=20
>> drivers/tty/serial/serial_core.c | 103 +++++++++++++++++++++++++++++=
++++++++++
>> include/linux/serial_core.h      |  10 ++++
>> 3 files changed, 149 insertions(+)
>> create mode 100644 Documentation/serial/slaves.txt
>>=20
>> diff --git a/Documentation/serial/slaves.txt b/Documentation/serial/=
slaves.txt
>> new file mode 100644
>> index 0000000..6f8d44d
>> --- /dev/null
>> +++ b/Documentation/serial/slaves.txt
>> @@ -0,0 +1,36 @@
>> +UART slave device support
>> +
>> +A remote device connected to a RS232 interface is usually power con=
trolled by the DTR line.
>> +The DTR line is managed automatically by the UART driver for open()=
 and close() syscalls
>> +and on demand by tcsetattr().
>> +
>> +With embedded devices, the serial peripheral might be directly and =
always connected to the UART
>> +and there might be no physical DTR line involved. Power control (on=
/off) has to be done by some
>> +chip specific device driver (which we call "UART slave") through so=
me mechanisms (I2C, GPIOs etc.)
>> +not related to the serial interface. Some devices do not explicitly=
 tell their power state except
>> +by sending or not sending data to the UART. In such a case the devi=
ce driver must be able to monitor
>> +data activity. The role of the device driver is to encapsulate such=
 power control in a single place.
>> +
>> +This patch series allows to support such drivers by providing:
>> +* a mechanism that a slave driver can identify the UART instance it=
 is connected to
>> +* a mechanism that UART slave drivers can register to be notified
>> +* notfications for DTR (and other modem control) state changes
>=20
> This has nothing to do with the binding really, but is rather a Linux
> driver feature.

Yes, we want to describe the linux driver features here.

>=20
>> +* notifications that the UART has received some data from the UART
>> +
>> +A slave device simply adds a phandle reference to the UART it is co=
nnected to, e.g.
>=20
> By default I think this should be a sub-node of the uart.

We want to show with this implementation that uart-subnodes would be th=
e wrong
way to go.

> There are
> more complicated cases of combo devices which we may need to support
> with phandles, but by default we should use sub-nodes to describe
> connections.

There can be serial devices which are power-controlled by I2C and then
we would have a problem to describe the connection as both I2C and UART
subnodes.

=46or us the "main interface=93 of a chip is the one that allows to tur=
n the device
on and off. And not the one that carries data provided by/to user space=
 (=84payload=93).

This is rarely the serial data stream. Hence describing the subdevice b=
y a
subnode of the uart is describing something different from what we need=
=2E

>=20
>> +
>> +       gps {
>> +               compatible =3D "wi2wi,w2sg0004";
>> +               uart =3D <&uart1>;
>=20
> What if you have a device with 2 uart connections? Do you have 2 item=
s
> in the list or do multiple "<name>-uart" entries? The former is
> probably sufficient and easier to parse.

It is up to the subdevice driver how it is implemented. So view this as=
 an example
that has only one uart connection.

=46or two uart connections you can choose either of your proposals sinc=
e the translator
function has both a phandle node name and an index.

> devm_serial_get_uart_by_phandle(struct device *dev,
> +		const char *phandle, u8 index)


You can call this function twice as:

> uart1 =3D devm_serial_get_uart_by_phandle(dev, =84uart=93, 0)
> uart2 =3D devm_serial_get_uart_by_phandle(dev, =84uart=93, 1)

or=20

> uart1 =3D devm_serial_get_uart_by_phandle(dev, =84uart1=93, 0)
> uart2 =3D devm_serial_get_uart_by_phandle(dev, =84uart2=93, 0)

whatever better fits. But this is up to the device driver where it IMHO=
 belongs to.

Our serial core driver does not predefine anything. It just provides a =
mechanism
that a driver can translate phandles into struct uart.

What we should do is to mark this DT fragment in this driver documentat=
ion as
an example to avoid misinterpretations.

>=20
>> +       };
>> +
>> +The slave driver calls devm_serial_get_uart_by_phandle() to identif=
y the uart driver.
>> +This API follows the concept of devm_usb_get_phy_by_phandle().
>> +
>> +A slave device driver registers itself with serial_register_slave()=
 to receive notifications.
>> +Notification handler callbacks can be registered by serial_register=
_mctrl_notification() and
>> +serial_register_rx_notification(). If an UART has registered a NULL=
 slave or a NULL handler,
>> +no notifications are sent.
>> +
>> +RX notification handlers can define a ktermios during setup and the=
 handler function can modify
>> +or decide to throw away each character that is passed upwards.
>=20
> All these 3 paragraphs should not be in the binding doc.

Maybe you have compared too much with Neil=92s implementation.

This is not a binding doc, but a description/documentation of our propo=
sed extension
of the serial core driver.

BR and thanks,
Nikolaus
