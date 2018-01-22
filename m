From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 03:24:18 +0100
Message-ID: <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
References: <20180121214645.15004-1-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180121214645.15004-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Now that ACPI and DT devices are both enumerated as serdevs, we can
> remove platform_device support and the bcm_device_list lookup hack.
> 
> This also removes any races between suspend/resume and hci-uart binding,
> also making the suspend/resume code a lot simpler.
> 
> This commit leaves manually binding to an uart using btattach supported
> (without irq/gpio and thus suspend/resume support, as before).
> 
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 260 +++++---------------------------------------
> 1 file changed, 28 insertions(+), 232 deletions(-)

so I was under the assumption platforms like Intel Edison still only do platform data. See commit 212d71833315c65644efc46223db61dee7b3c68e. Has that changed?

Regards

Marcel

