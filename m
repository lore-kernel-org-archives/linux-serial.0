From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL deref
 when using serdev
Date: Wed, 4 Oct 2017 20:42:23 +0200
Message-ID: <4cfac353-cd8d-a78e-812b-833720e96451@redhat.com>
References: <20171002152356.4714-1-hdegoede@redhat.com>
 <20171002152356.4714-2-hdegoede@redhat.com>
 <20171002223415.jmbi4zw7edyuxccl@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171002223415.jmbi4zw7edyuxccl@earth>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 03-10-17 00:34, Sebastian Reichel wrote:
> Hi,
> 
> On Mon, Oct 02, 2017 at 05:23:48PM +0200, Hans de Goede wrote:
>> Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
>> on hci_uart-s using serdev.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   drivers/bluetooth/hci_ldisc.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index a746627e784e..d02f6d029093 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/ioctl.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/firmware.h>
>> +#include <linux/serdev.h>
>>   
>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> @@ -298,6 +299,11 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>>   	unsigned int set = 0;
>>   	unsigned int clear = 0;
>>   
>> +	if (hu->serdev) {
>> +		serdev_device_set_flow_control(hu->serdev, !enable);
>> +		return;
>> +	}
> 
> I think this should also control rts, so that the behaviour is the
> same for serdev and ldisc implementation:
> 
> serdev_device_set_rts(serdev, enable);

Good point, fixed for v2 of this set (which I will send out right
after this mail).

Regards,

Hans
