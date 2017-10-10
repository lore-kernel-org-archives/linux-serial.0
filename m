From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Revert "Bluetooth: btusb: Add workaround for Broadcom
 devices without product id"
Date: Tue, 10 Oct 2017 10:16:21 +0200
Message-ID: <F29370B8-8E56-424C-A321-A4A64EC55340@holtmann.org>
References: <20171005074251.7274-1-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171005074251.7274-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Commit 9834e586fa ("Bluetooth: btusb: Add workaround for Broadcom devices
> without product id") was added to deal with the BT part of the BCM4356A2
> on GPD pocket laptops having an usb vid:pid of 0000:0000.
> 
> After another commit to add support for the BCM UART connected BT ACPI-id
> BCM2E7E used on the GPD win, it turns out that the BT on the GPD pocket is
> connected via both USB and UART. Adding support for the BCM2E7E ACPI-id
> causes it to switch to UART mode.
> 
> The Windows shipped with the device is using it in UART mode and the
> presence of the BCM2E7E ACPI-id combined with the 0 USB vid:pid also
> indicates that the BT part was never meant to be used in USB mode.
> 
> But not only is there no need to support the USB mode, supporting it
> actually is troublesome, because with the workaround to support the all 0
> USB vid:pid, BT will just work for end users, until we add support for
> the ACPI-id, after which users need to have userspace doing a btattach,
> which may be considered a regression.
> 
> To avoid this regression when switching things over to UART mode as
> intended by the ACPI tables all along, this commit reverts the commit
> adding the workaround to support the all 0 USB vid:pid.
> 
> This reverts commit 9834e586fa ("Bluetooth: btusb: Add workaround for
> Broadcom devices without product id").
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/btusb.c | 18 ------------------
> 1 file changed, 18 deletions(-)

can you send a series of patches, that first reverts this patch and then a patch adds the BCM2E7E id to the hci_bcm driver so that it will start working again.

Regards

Marcel

