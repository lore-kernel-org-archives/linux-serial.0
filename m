From: =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>
Subject: Re: [PATCHv2 09/11] Bluetooth: add nokia driver
Date: Thu, 23 Mar 2017 08:50:42 +0100
Message-ID: <07cf4c22-b798-6e77-cca0-548e32e9de3f@gmail.com>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-10-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170321223216.11733-10-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Pavel Machek <pavel@ucw.cz>, Tony Lindgren <tony@atomide.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, frederic.danis.oss@gmail.com
List-Id: linux-serial@vger.kernel.org

Hello Sebastian,

Le 21/03/2017 à 23:32, Sebastian Reichel a écrit :
> This adds a driver for the Nokia H4+ protocol, which is used
> at least on the Nokia N9, N900 & N950.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---
> Changes since PATCHv1:
>   * replace __u8 and uint8_t with u8
>   * replace __u16 and uint16_t with u16
>   * drop BT_BAUDRATE_DIVIDER and use btdev->sysclk_speed * 10 instead
>   * fix wording of a sentence
>   * fix error path of negotation & alive package receive functions
>   * replaced nokia_wait_for_cts with newly introduced serdev function
>   * use "nokia,h4p-bluetooth" as compatible string
> ---
>   drivers/bluetooth/Kconfig     |  12 +
>   drivers/bluetooth/Makefile    |   2 +
>   drivers/bluetooth/hci_nokia.c | 819 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 833 insertions(+)
>   create mode 100644 drivers/bluetooth/hci_nokia.c
>
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index c2c14a12713b..2e3e4d3547ad 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -86,6 +86,18 @@ config BT_HCIUART_H4
>   
>   	  Say Y here to compile support for HCI UART (H4) protocol.
>   
> +config BT_HCIUART_NOKIA
> +	tristate "UART Nokia H4+ protocol support"
> +	depends on BT_HCIUART
> +	depends on SERIAL_DEV_BUS
> +	depends on PM
> +	help
> +	  Nokia H4+ is serial protocol for communication between Bluetooth
> +	  device and host. This protocol is required for Bluetooth devices
> +	  with UART interface in Nokia devices.
> +
> +	  Say Y here to compile support for Nokia's H4+ protocol.
> +
>   config BT_HCIUART_BCSP
>   	bool "BCSP protocol support"
>   	depends on BT_HCIUART
> diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
> index fd571689eed6..a7f237320f4b 100644
> --- a/drivers/bluetooth/Makefile
> +++ b/drivers/bluetooth/Makefile
> @@ -25,6 +25,8 @@ obj-$(CONFIG_BT_BCM)		+= btbcm.o
>   obj-$(CONFIG_BT_RTL)		+= btrtl.o
>   obj-$(CONFIG_BT_QCA)		+= btqca.o
>   
> +obj-$(CONFIG_BT_HCIUART_NOKIA)	+= hci_nokia.o
> +
>   btmrvl-y			:= btmrvl_main.o
>   btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o

This does not build as module with following error:
ERROR: "hci_uart_tx_wakeup" [drivers/bluetooth/hci_nokia.ko] undefined!
ERROR: "hci_uart_register_device" [drivers/bluetooth/hci_nokia.ko] 
undefined!

Should not hci_nokia be part of the hci_uart module?

Regards,

Fred
