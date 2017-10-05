From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the
 serdev driver
Date: Thu, 5 Oct 2017 19:53:43 +0200
Message-ID: <2487535c-18b4-c689-3c67-d1261b21feee@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
 <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
 <1389d64c-17aa-c6a1-d56f-6c2fe877f247@redhat.com>
 <17592E57-3A4B-4386-B809-9EA928D38FDD@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <17592E57-3A4B-4386-B809-9EA928D38FDD-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "bluez mailin list (linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org)" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 05-10-17 17:15, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>> Make the serdev driver use struct bcm_device as its driver data and share
>>>> all the pm / GPIO / IRQ related code paths with the platform driver.
>>>>
>>>> After this commit the 2 drivers are in essence the same and the serdev
>>>> driver interface can be used for all ACPI enumerated HCI UARTs.
>>>>
>>>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>>>> ---
>>>> drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
>>>> 1 file changed, 68 insertions(+), 50 deletions(-)
>>> all 9 patches have been applied to bluetooth-next tree.
>>
>> Excellent, thank you!
>>
>> So I guess this means we can also move forward with getting
>> the 2 patches from Frédéric Danis merged ? There is a bit
>> of a bisect-ability problem there, if the acpi pull-req
>> gets merged first then uart attached bcm bt will stop
>> working until the bluetooth subsys is also merged.
>>
>> But I don't think this will impact a lot of users
>> (also given the need for a manual btattach so far),
>> so I don't think this is a big problem... ?
> 
> I wonder if we should just do this as all-in-one change for 4.15 kernel. We surely can get the ACPI changes into 4.15 and the Bluetooth changes as well. Then it should just work.
> 
> So I am leaning to just adding the revert patch into the bluetooth-next tree and then just add the ACPI PnP ID for the GPD device in the same pull request. And if the ACPI changes make it then nobody will know the difference that we switched from USB to UART.

Yes that should work fine.

Regards,

Hans
