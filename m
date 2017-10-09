From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the
 serdev driver
Date: Mon, 9 Oct 2017 16:02:24 +0200
Message-ID: <ebd6e9dc-9c25-a2ea-619f-bd1cdf45b6a3@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
 <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
 <1389d64c-17aa-c6a1-d56f-6c2fe877f247@redhat.com>
 <17592E57-3A4B-4386-B809-9EA928D38FDD@holtmann.org>
 <20171007142631.GF2618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171007142631.GF2618@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 07-10-17 16:26, Johan Hovold wrote:
> On Thu, Oct 05, 2017 at 05:15:05PM +0200, Marcel Holtmann wrote:
>> Hi Hans,
>>
>>>>> Make the serdev driver use struct bcm_device as its driver data and share
>>>>> all the pm / GPIO / IRQ related code paths with the platform driver.
>>>>>
>>>>> After this commit the 2 drivers are in essence the same and the serdev
>>>>> driver interface can be used for all ACPI enumerated HCI UARTs.
>>>>>
>>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>>> ---
>>>>> drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
>>>>> 1 file changed, 68 insertions(+), 50 deletions(-)
>>>> all 9 patches have been applied to bluetooth-next tree.
>>>
>>> Excellent, thank you!
> 
> Nice work here, Hans, allowing serdev to coexist with the
> platform-device hacks until the transition is complete and those hacks
> can finally be removed.
> 
>>> So I guess this means we can also move forward with getting
>>> the 2 patches from Frédéric Danis merged ? There is a bit
>>> of a bisect-ability problem there, if the acpi pull-req
>>> gets merged first then uart attached bcm bt will stop
>>> working until the bluetooth subsys is also merged.
>>>
>>> But I don't think this will impact a lot of users
>>> (also given the need for a manual btattach so far),
>>> so I don't think this is a big problem... ?
>>
>> I wonder if we should just do this as all-in-one change for 4.15
>> kernel. We surely can get the ACPI changes into 4.15 and the Bluetooth
>> changes as well. Then it should just work.
> 
> However, there are of course a couple of caveats. Once Frederic's ACPI
> patches land, there will be no more platform child devices. Unless
> serdev support is then compiled in, this means that PM will break
> (silently). And if serdev is enabled, of course the tty class device is
> gone and hciattach (btattach) will fail, but I guess everyone is aware
> of that issue by now.
> 
> Should BT_HCIUART_BCM start depending on SERIAL_DEV_CTRL_TTYPORT (when
> ACPI is enabled) to avoid such silent breakage once ACPI-support is
> merged?

It seems that this was answered already in further discussions and
your recent patch to add a default y to SERIAL_DEV_CTRL_TTYPORT fixes
this, right ?

Regards,

Hans
