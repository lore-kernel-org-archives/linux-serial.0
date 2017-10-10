From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: avoid silent hci_bcm ACPI PM regression
Date: Tue, 10 Oct 2017 10:07:30 +0200
Message-ID: <CDEAF8ED-56B1-48BB-B9B3-D11EBBA8D04B@holtmann.org>
References: <20171010080152.18444-1-johan@kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171010080152.18444-1-johan@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Rob Herring <robh@kernel.org>, Loic Poulain <loic.poulain@gmail.com>, Lukas Wunner <lukas@wunner.de>, Hans de Goede <hdegoede@redhat.com>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Johan,

> The hci_bcm platform-device hack which was used to implement
> power management for ACPI devices is being replaced by a
> serial-device-bus implementation.
> 
> Unfortunately, when the corresponding change to the ACPI code lands (a
> change that will stop enumerating and registering the serial-device-node
> child as a platform device) PM will break silently unless serdev
> TTY-port controller support has been enabled. Specifically, hciattach
> (btattach) would still succeed, but power management would no longer
> work.
> 
> Although this is strictly a runtime dependency, let's make the driver
> depend on SERIAL_DEV_CTRL_TTYPORT, which is the particular serdev
> controller implementation used by the ACPI devices currently managed by
> this driver, to avoid breaking PM without anyone noticing.
> 
> Note that the driver already has a (build-time) dependency on the serdev
> bus code.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

