From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: Remove platform_device support
Date: Mon, 22 Jan 2018 09:23:24 +0100
Message-ID: <769dd32b-425e-3002-50b5-0d3c707706d4@redhat.com>
References: <20180121214645.15004-1-hdegoede@redhat.com>
 <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <0EA71635-F2C7-4908-B4DE-F87328A148D0@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
List-Id: linux-serial@vger.kernel.org

Hi,

On 22-01-18 03:24, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Now that ACPI and DT devices are both enumerated as serdevs, we can
>> remove platform_device support and the bcm_device_list lookup hack.
>>
>> This also removes any races between suspend/resume and hci-uart binding,
>> also making the suspend/resume code a lot simpler.
>>
>> This commit leaves manually binding to an uart using btattach supported
>> (without irq/gpio and thus suspend/resume support, as before).
>>
>> Cc: Lukas Wunner <lukas@wunner.de>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/hci_bcm.c | 260 +++++---------------------------------------
>> 1 file changed, 28 insertions(+), 232 deletions(-)
> 
> so I was under the assumption platforms like Intel Edison still only do platform data. See commit 212d71833315c65644efc46223db61dee7b3c68e. Has that changed?

Ugh, I was not aware of that and the whole code to match the tty with
the platform_device on btattach is such a mess and I was actually quite
happy to be able to delete this.

Andy, I see that you added support for bcm bluetooth over a tty using
platform_data instead of ACPI enumeration. Can you change the code
instantiating the device to instead instantiate a serdev, so that we
kill the platform device support in hci_bcm.c and so that users don't
need to do a btattach, but instead the kernel will do the attach itself
and things will just work ?

Regards,

Hans
