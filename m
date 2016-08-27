From: Michal Suchanek <hramrach@gmail.com>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Sat, 27 Aug 2016 14:01:54 +0200
Message-ID: <CAOMqctRMOhV6Y28T231CD4Ja8f1D2TmfWSdaeU1V2-mPZ83keg@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth>
 <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
 <20160819052125.ze5zilppwoe3f2lx@earth> <ACEF800E-8DB3-4345-ADE2-15C99F3659D5@goldelico.com>
 <efcd1fe0-52f8-ba84-1310-9f4c24ad35bc@rempel-privat.de> <53A846F1-33E5-48C3-B3A6-DB251661CDD5@goldelico.com>
 <20160820143405.04303834@lxorguk.ukuu.org.uk> <B4DF8974-1C6B-432E-AD1A-1E6067B9C158@goldelico.com>
 <20160822203947.ksxwnvzhc3tpnnx7@earth> <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <EA228ADD-F03A-49C0-9A0B-E768D7A7A466@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Sebastian Reichel <sre@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Oleksij Rempel <linux@rempel-privat.de>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 22 August 2016 at 23:23, H. Nikolaus Schaller <hns@goldelico.com> wrote:
> Hi Sebastian,
>
>> Am 22.08.2016 um 22:39 schrieb Sebastian Reichel <sre@kernel.org>:
>>
>> Hi,
>>
>> On Sun, Aug 21, 2016 at 09:50:57AM +0200, H. Nikolaus Schaller wrote:
>>>> Am 20.08.2016 um 15:34 schrieb One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>:
>>>>> What it is not about are UART/RS232 converters connected through USB or virtual
>>>>> serial ports created for WWAN modems (e.g. /dev/ttyACM, /dev/ttyHSO). Or BT devices
>>>>> connected through USB (even if they also run HCI protocol).
>>>>
>>>> It actually has to be about both because you will find the exact same
>>>> device wired via USB SSIC/HSIC to a USB UART or via a classic UART. Not is
>>>> it just about embedded boards.
>>>
>>> Not necessarily.
>>>
>>> We often have two interface options for exactly the sam sensor chips. They can be connected
>>> either through SPI or I2C. Which means that there is a core driver for the chip and two different
>>> transport glue components (see e.g. iio/accel/bmc150).
>>>
>>> This does not require I2C to be able to handle SPI or vice versa or provide a common API.
>>
>> I don't understand this comparison. I2C and SPI are different
>> protocols,
>
> Yes, they are different on protocol level, but on both you transfer blocks of data from/to a slave device
> which usually can be addressed. And for some chips they are just two slightly alternative serial interfaces.
>
>> while native UART and USB-connected UART are both UART.
>
> I see what you mean, but kernel divides between directly connected UART and USB-connected UART.
>
> drivers/usb/serial/ vs. drivers/tty/serial/
>
> to implement two different groups of UARTs. Although on user space level they are harmonized again.
> This is why I compare with i2c and spi. But each such comparison is not perfect.
>
> Anyways, to me it looks as if everybody wants to make the solution work for usb-uarts as well
> (although I still would like to see a real world use-case).

I use a NFC reader attached to a PL2303 UART. It's a proof of concept
solution but if I needed a finished
product all it takes is to put the two pieces of PCB into a box with
the USB connector sticking out.
Or glue the PCB on the inside of a plastic part of a PC case.

Thanks

Michal
