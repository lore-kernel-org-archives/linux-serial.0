From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 2/2] Bluetooth: hci_bcm: Close serdev on failure to set
 power on bcm_open()
Date: Mon, 22 Jan 2018 03:20:41 +0100
Message-ID: <52263D7A-47F4-482C-98AA-74094CBCD768@holtmann.org>
References: <20180121214645.15004-1-hdegoede@redhat.com>
 <20180121214645.15004-2-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180121214645.15004-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Commit 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> introduced error checking for the bcm_gpio_set_power() call in bcm_open()
> but the error-path it introduces does not properly call
> serdev_device_close() to undo the earlier serdev_device_open(), this
> commit fixes this.
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Fixes: 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)

can I get this as 1/2 so I can apply it right away.

Regards

Marcel


