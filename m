From: Rob Herring <robherring2@gmail.com>
Subject: Re: [PATCH RFC v2 1/3] tty: serial core: provide method to search
 uart by phandle
Date: Wed, 1 Jul 2015 13:16:47 -0500
Message-ID: <CAL_JsqK10SLjtDQ7e=kMMrNz5aTQ7Tgzq+zmX+qhxkOUbiLUew@mail.gmail.com>
References: <1435520786-31867-1-git-send-email-marek@goldelico.com> <1435520786-31867-2-git-send-email-marek@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435520786-31867-2-git-send-email-marek@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Belisko <marek@goldelico.com>
Cc: Jiri Slaby <jslaby@suse.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Peter Hurley <peter@hurleysoftware.com>, Mark Rutland <mark.rutland@arm.com>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Sebastian Reichel <sre@kernel.org>, Neil Brown <neil@brown.name>, Grant Likely <grant.likely@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-serial@vger.kernel.org

On Sun, Jun 28, 2015 at 2:46 PM, Marek Belisko <marek@goldelico.com> wrote:
> From: "H. Nikolaus Schaller" <hns@goldelico.com>
>
> 1. add registered uart_ports to a search list
> 2. provide a function to search an uart_port by phandle. This copies the
>    mechanism how devm_usb_get_phy_by_phandle() works

How does this relate to Neil's tty/uart slaves series?

> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Marek Belisko <marek@goldelico.com>
> ---
>  Documentation/serial/slaves.txt  |  36 ++++++++++++++

You need to split this into DT binding and whatever kernel specific
documentation you want. My comment below apply to what goes in the
binding doc.

>  drivers/tty/serial/serial_core.c | 103 +++++++++++++++++++++++++++++++++++++++
>  include/linux/serial_core.h      |  10 ++++
>  3 files changed, 149 insertions(+)
>  create mode 100644 Documentation/serial/slaves.txt
>
> diff --git a/Documentation/serial/slaves.txt b/Documentation/serial/slaves.txt
> new file mode 100644
> index 0000000..6f8d44d
> --- /dev/null
> +++ b/Documentation/serial/slaves.txt
> @@ -0,0 +1,36 @@
> +UART slave device support
> +
> +A remote device connected to a RS232 interface is usually power controlled by the DTR line.
> +The DTR line is managed automatically by the UART driver for open() and close() syscalls
> +and on demand by tcsetattr().
> +
> +With embedded devices, the serial peripheral might be directly and always connected to the UART
> +and there might be no physical DTR line involved. Power control (on/off) has to be done by some
> +chip specific device driver (which we call "UART slave") through some mechanisms (I2C, GPIOs etc.)
> +not related to the serial interface. Some devices do not explicitly tell their power state except
> +by sending or not sending data to the UART. In such a case the device driver must be able to monitor
> +data activity. The role of the device driver is to encapsulate such power control in a single place.
> +
> +This patch series allows to support such drivers by providing:
> +* a mechanism that a slave driver can identify the UART instance it is connected to
> +* a mechanism that UART slave drivers can register to be notified
> +* notfications for DTR (and other modem control) state changes

This has nothing to do with the binding really, but is rather a Linux
driver feature.

> +* notifications that the UART has received some data from the UART
> +
> +A slave device simply adds a phandle reference to the UART it is connected to, e.g.

By default I think this should be a sub-node of the uart. There are
more complicated cases of combo devices which we may need to support
with phandles, but by default we should use sub-nodes to describe
connections.

> +
> +       gps {
> +               compatible = "wi2wi,w2sg0004";
> +               uart = <&uart1>;

What if you have a device with 2 uart connections? Do you have 2 items
in the list or do multiple "<name>-uart" entries? The former is
probably sufficient and easier to parse.

> +       };
> +
> +The slave driver calls devm_serial_get_uart_by_phandle() to identify the uart driver.
> +This API follows the concept of devm_usb_get_phy_by_phandle().
> +
> +A slave device driver registers itself with serial_register_slave() to receive notifications.
> +Notification handler callbacks can be registered by serial_register_mctrl_notification() and
> +serial_register_rx_notification(). If an UART has registered a NULL slave or a NULL handler,
> +no notifications are sent.
> +
> +RX notification handlers can define a ktermios during setup and the handler function can modify
> +or decide to throw away each character that is passed upwards.

All these 3 paragraphs should not be in the binding doc.

Rob
