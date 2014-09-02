From: Rob Herring <robherring2@gmail.com>
Subject: Re: [RFC PATCH 1/1] drivers: introduce ARM SBSA generic UART driver
Date: Mon, 1 Sep 2014 22:06:24 -0500
Message-ID: <CAL_JsqJbAWRhduzMwdQMh8sDdVqTWVK2Ej9LQjx4gp2ifwxe6Q@mail.gmail.com>
References: <1409328803-1953-1-git-send-email-andre.przywara@arm.com> <1409328803-1953-2-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vc0-f169.google.com ([209.85.220.169]:43790 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925AbaIBDGs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 1 Sep 2014 23:06:48 -0400
In-Reply-To: <1409328803-1953-2-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Russell King <linux@arm.linux.org.uk>, linux@vger.kernel.org

On Fri, Aug 29, 2014 at 11:13 AM, Andre Przywara <andre.przywara@arm.com> wrote:
> The ARM Server Base System Architecture (SBSA) describes a generic
> UART which all compliant level 1 systems should implement. This is
> actually a PL011 subset, so a full PL011 implementation will satisfy
> this requirement.
> However if a system does not have a PL011, a very stripped down
> implementation complying to the SBSA defined specification will
> suffice. The Linux PL011 driver is not guaranteed to drive this
> limited device (and indeed the fast model implentation hangs the
> kernel if driven by the PL011 driver).
> So introduce a new driver just implementing the part specified by the
> SBSA (which lacks DMA, the modem control signals and many of the
> registers including baud rate control). This driver has been derived
> by the actual PL011 one, removing all unnecessary code.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  .../devicetree/bindings/serial/arm_sbsa_uart.txt   |    6 +
>  drivers/tty/serial/Kconfig                         |   28 +
>  drivers/tty/serial/Makefile                        |    1 +
>  drivers/tty/serial/sbsa_uart.c                     |  793 ++++++++++++++++++++
>  include/uapi/linux/serial_core.h                   |    1 +

Sorry, but I think this is all wrong. We've now just duplicated some
subset of the pl011 driver leaving out the parts like setting baudrate
which can never be added since those things could be different for
every vendor.

The original intent of the SBSA uart was to provide a common early
debug uart. It was not to have a full fledged driver. I think the SBSA
has failed in this area and created the potential to create a mess of
serial drivers different for every vendor. Reality will hopefully not
be that extreme and most vendors will just use the pl011 and create
their value add somewhere besides the uart. For the purpose of debug
output, we already support that as the pl011 earlycon only touches
SBSA compatible registers.

>  5 files changed, 829 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
>  create mode 100644 drivers/tty/serial/sbsa_uart.c
>
> diff --git a/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> new file mode 100644
> index 0000000..8e2c5d6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/arm_sbsa_uart.txt
> @@ -0,0 +1,6 @@
> +* ARM SBSA defined generic UART
> +
> +Required properties:
> +- compatible: must be "arm,sbsa-uart"

This alone is not okay. There is no such implementation of hardware.
The DT must specify the implementation such as pl011.

Rob
