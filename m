From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL
 deref when using serdev
Date: Mon, 9 Oct 2017 20:01:53 +0200
Message-ID: <1C21B27B-2ADD-47E9-8E70-A33BFB0B19E4@holtmann.org>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171007143645.GG2618@localhost>
 <ce49b622-212a-0e6c-2c05-9cfe3db4bd47@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <ce49b622-212a-0e6c-2c05-9cfe3db4bd47@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johan Hovold <johan@kernel.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Hans,

>>> Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
>>> on hci_uart-s using serdev.
>>> 
>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>> ---
>>> Changes in v2:
>>> -Also set RTS (Suggested-by: Sebastian Reichel <sre@kernel.org>)
>>> ---
>>>  drivers/bluetooth/hci_ldisc.c | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>> 
>>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>>> index a746627e784e..eec95019f15c 100644
>>> --- a/drivers/bluetooth/hci_ldisc.c
>>> +++ b/drivers/bluetooth/hci_ldisc.c
>>> @@ -41,6 +41,7 @@
>>>  #include <linux/ioctl.h>
>>>  #include <linux/skbuff.h>
>>>  #include <linux/firmware.h>
>>> +#include <linux/serdev.h>
>> I know this is already merged, but do we really want to add a dependency
>> on serdev from hci_ldisc.c?
>> There is already a helper function host_set_baudrate() in hci_bcm to
>> handle another case like this. If more drivers will need to support
>> both then these could be moved to a common header, but we should at
>> least try to be consistent here.
> 
> That is a valiud question, Marcel do you want me to do a follow
> up series which:
> 
> 1) Reverts this commit; and
> 2) Add a host_set_flow_control helper to hci_bcm.c ?

don’t bother with a revert, lets just improve this with follow up patches.

Regards

Marcel

