From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Tue, 13 Feb 2018 12:25:55 +0100
Message-ID: <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

On 13-02-18 03:24, Brian Norris wrote:
> Hi,
> 
> On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>
>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>> has several issues (see the original commit message). An added advantage
>> of moving over to the USB-core reset-resume handling is that it also
>> disables autosuspend for these devices, which is similarly broken on these.
> 
> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
> think so -- I'm using one now.

And have you manually enabled USB autosuspend for it, or are you
running something which might have done so, e.g. powertop --auto-tune ?

Because if you did not do that then you're already not using autosuspend
for your QCA devices and this patch will change nothing.

> Thus, this is a poor solution, which
> negatively affects my systems. However, I see that this patch was
> applied regardless...

Note that there already is a quirk to handle broken suspend/resume
behavior on ALL QCA devices in older kernels. Also note that the
patches series which this commit builds on top of was already
setting USB_QUIRK_RESET_RESUME for some devices in
usb/core/quirks.c.

All my commit does is instead of duplicating all the QCA USB-ids in
usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
to btusb.c so that we don't need to duplicate the USB-id tables.

The result of the combination of these patches is that the custom
DIY reset on resume handling btusb.c was doing is now replaced
by setting the standard USB-core USB_QUIRK_RESET_RESUME quirk.

As a (desirable) side effect this also disables USB autosuspend
for QCA devices since the USB-core does not allow USB autosuspend
on devices with the USB_QUIRK_RESET_RESUME quirk. Testing has shown
this to be necessary on at least some QCA devices and given that
these devices tend to loose there firmware on a suspend, it seems
sensible to not allow autosuspend on them.

 > What justifications was found for this anyway? AIUI, this is a platform
 > bug, and not entirely a chipset bug.

No this is believed to be a chipset issue, hence also the quirk in
older kernels to always reset these devices after a normal suspend/resume.

Regards,

Hans




> 
> Brian
> 
>> But there are 2 issues with this approach:
>> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>>     devices.
>> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>>     added to usb/core/quirks.c and if we fix the Realtek case the same way
>>     we need to add an additional 14 entries. So in essence we need to
>>     duplicate a large part of the usb_device_id table in btusb.c in
>>     usb/core/quirks.c and manually keep them in sync.
>>
>> This commit instead restores setting a reset-resume quirk for QCA devices
>> in the btusb.c code, avoiding the duplicate usb_device_id table problem.
>>
>> This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
>> code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
>> usb_device.
>>
>> This commit also moves the BTUSB_REALTEK case over to directly setting the
>> USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
>> BTUSB_RESET_RESUME code.
>>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>> Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> Cc: stable@vger.kernel.org
>> Cc: Leif Liddy <leif.linux@gmail.com>
>> Cc: Matthias Kaehlcke <mka@chromium.org>
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Daniel Drake <drake@endlessm.com>
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> Note:
>> 1) Once this has been merged, the 2 commits adding QCA device entries to
>> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
>> 2) I don't have any of the affected devices, please test
>> ---
>>   drivers/bluetooth/btusb.c | 22 ++++++++++------------
>>   1 file changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index 4764100a5888..c4689f03220f 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -23,6 +23,7 @@
>>   
>>   #include <linux/module.h>
>>   #include <linux/usb.h>
>> +#include <linux/usb/quirks.h>
>>   #include <linux/firmware.h>
>>   #include <linux/of_device.h>
>>   #include <linux/of_irq.h>
>> @@ -388,9 +389,8 @@ static const struct usb_device_id blacklist_table[] = {
>>   #define BTUSB_FIRMWARE_LOADED	7
>>   #define BTUSB_FIRMWARE_FAILED	8
>>   #define BTUSB_BOOTING		9
>> -#define BTUSB_RESET_RESUME	10
>> -#define BTUSB_DIAG_RUNNING	11
>> -#define BTUSB_OOB_WAKE_ENABLED	12
>> +#define BTUSB_DIAG_RUNNING	10
>> +#define BTUSB_OOB_WAKE_ENABLED	11
>>   
>>   struct btusb_data {
>>   	struct hci_dev       *hdev;
>> @@ -3118,6 +3118,12 @@ static int btusb_probe(struct usb_interface *intf,
>>   	if (id->driver_info & BTUSB_QCA_ROME) {
>>   		data->setup_on_usb = btusb_setup_qca;
>>   		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
>> +
>> +		/* QCA Rome devices lose their updated firmware over suspend,
>> +		 * but the USB hub doesn't notice any status change.
>> +		 * explicitly request a device reset on resume.
>> +		 */
>> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>   	}
>>   
>>   #ifdef CONFIG_BT_HCIBTUSB_RTL
>> @@ -3128,7 +3134,7 @@ static int btusb_probe(struct usb_interface *intf,
>>   		 * but the USB hub doesn't notice any status change.
>>   		 * Explicitly request a device reset on resume.
>>   		 */
>> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
>> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>>   	}
>>   #endif
>>   
>> @@ -3297,14 +3303,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>   		enable_irq(data->oob_wake_irq);
>>   	}
>>   
>> -	/* Optionally request a device reset on resume, but only when
>> -	 * wakeups are disabled. If wakeups are enabled we assume the
>> -	 * device will stay powered up throughout suspend.
>> -	 */
>> -	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
>> -	    !device_may_wakeup(&data->udev->dev))
>> -		data->udev->reset_resume = 1;
>> -
>>   	return 0;
>>   }
>>   
>> -- 
>> 2.14.3
>>
