From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v2 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL
 deref when using serdev
Date: Mon, 9 Oct 2017 16:06:02 +0200
Message-ID: <ce49b622-212a-0e6c-2c05-9cfe3db4bd47@redhat.com>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171007143645.GG2618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171007143645.GG2618@localhost>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?= <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 07-10-17 16:36, Johan Hovold wrote:
> On Wed, Oct 04, 2017 at 08:43:35PM +0200, Hans de Goede wrote:
>> Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
>> on hci_uart-s using serdev.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Changes in v2:
>> -Also set RTS (Suggested-by: Sebastian Reichel <sre@kernel.org>)
>> ---
>>   drivers/bluetooth/hci_ldisc.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
>> index a746627e784e..eec95019f15c 100644
>> --- a/drivers/bluetooth/hci_ldisc.c
>> +++ b/drivers/bluetooth/hci_ldisc.c
>> @@ -41,6 +41,7 @@
>>   #include <linux/ioctl.h>
>>   #include <linux/skbuff.h>
>>   #include <linux/firmware.h>
>> +#include <linux/serdev.h>
> 
> I know this is already merged, but do we really want to add a dependency
> on serdev from hci_ldisc.c?
> 
> There is already a helper function host_set_baudrate() in hci_bcm to
> handle another case like this. If more drivers will need to support
> both then these could be moved to a common header, but we should at
> least try to be consistent here.

That is a valiud question, Marcel do you want me to do a follow
up series which:

1) Reverts this commit; and
2) Add a host_set_flow_control helper to hci_bcm.c ?

>>   #include <net/bluetooth/bluetooth.h>
>>   #include <net/bluetooth/hci_core.h>
>> @@ -298,6 +299,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>>   	unsigned int set = 0;
>>   	unsigned int clear = 0;
>>   
>> +	if (hu->serdev) {
>> +		serdev_device_set_flow_control(hu->serdev, !enable);
>> +		serdev_device_set_rts(hu->serdev, !enable);
> 
> The order here may matter; in the non-serdev case, rts is raised before
> enabling flow control.

AFAIK it should not matter, if RTS is not set before enabling, then CTS
may not be set by the other side yet and the hw flow-control will
wait for CTS to get raised.

Regards,

Hans





> 
>> +		return;
>> +	}
>> +
>>   	if (enable) {
>>   		/* Disable hardware flow control */
>>   		ktermios = tty->termios;
> 
> Johan
> 
