From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/3] UART slave device bus
Date: Thu, 18 Aug 2016 18:08:24 -0500
Message-ID: <CAL_Jsq+OfT1AXaEKOgZ4oVfpVZhu=55dYoHTG7D_prpnTqpeOg@mail.gmail.com>
References: <20160818011445.22726-1-robh@kernel.org> <20160818202900.hyvm4hfxedifuefn@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160818202900.hyvm4hfxedifuefn@earth>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcel Holtmann <marcel@holtmann.org>, Jiri Slaby <jslaby@suse.com>, Pavel Machek <pavel@ucw.cz>, Peter Hurley <peter@hurleysoftware.com>, NeilBrown <neil@brown.name>, "Dr . H . Nikolaus Schaller" <hns@goldelico.com>, Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Thu, Aug 18, 2016 at 3:29 PM, Sebastian Reichel <sre@kernel.org> wrote:
> Hi Rob,
>
> Thanks for going forward and implementing this. I also started,
> but was far from a functional state.
>
> On Wed, Aug 17, 2016 at 08:14:42PM -0500, Rob Herring wrote:
>> Currently, devices attached via a UART are not well supported in
>> the kernel. The problem is the device support is done in tty line
>> disciplines, various platform drivers to handle some sideband, and
>> in userspace with utilities such as hciattach.
>>
>> There have been several attempts to improve support, but they suffer from
>> still being tied into the tty layer and/or abusing the platform bus. This
>> is a prototype to show creating a proper UART bus for UART devices. It is
>> tied into the serial core (really struct uart_port) below the tty layer
>> in order to use existing serial drivers.
>>
>> This is functional with minimal testing using the loopback driver and
>> pl011 (w/o DMA) UART under QEMU (modified to add a DT node for the slave
>> device). It still needs lots of work and polish.
>>
>> TODOs:
>> - Figure out the port locking. mutex plus spinlock plus refcounting? I'm
>>   hoping all that complexity is from the tty layer and not needed here.
>> - Split out the controller for uart_ports into separate driver. Do we see
>>   a need for controller drivers that are not standard serial drivers?
>> - Implement/test the removal paths
>> - Fix the receive callbacks for more than character at a time (i.e. DMA)
>> - Need better receive buffering than just a simple circular buffer or
>>   perhaps a different receive interface (e.g. direct to client buffer)?
>> - Test with other UART drivers
>> - Convert a real driver/line discipline over to UART bus.
>>
>> Before I spend more time on this, I'm looking mainly for feedback on the
>> general direction and structure (the interface with the existing serial
>> drivers in particular).
>
> I had a look at the uart_dev API:
>
> int uart_dev_config(struct uart_device *udev, int baud, int parity, int bits, int flow);
> int uart_dev_connect(struct uart_device *udev);
>
>   The flow control configuration should be done separately. e.g.:
>   uart_dev_flow_control(struct uart_device *udev, bool enable);

No objection, but out of curiosity, why?

> int uart_dev_tx(struct uart_device *udev, u8 *buf, size_t count);
> int uart_dev_rx(struct uart_device *udev, u8 *buf, size_t count);
>
>   UART communication does not have to be host-initiated, so this
>   API requires polling. Either some function similar to poll in
>   userspace is needed, or it should be implemented as callback.

What's the userspace need? I'm assuming the only immediate consumers
are in-kernel.

Rob
