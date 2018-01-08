From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Mon, 8 Jan 2018 18:49:06 +0100
Message-ID: <3934266e-5504-1eb1-f9b3-a2d9e5e45d4d@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180108094416.4789-1-hdegoede@redhat.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Brian Norris <briannorris@chromium.org>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-serial@vger.kernel.org

Hi,

On 08-01-18 10:44, Hans de Goede wrote:
> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
> 
> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
> has several issues (see the original commit message). An added advantage
> of moving over to the USB-core reset-resume handling is that it also
> disables autosuspend for these devices, which is similarly broken on these.
> 
> But there are 2 issues with this approach:
> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>     devices.
> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>     added to usb/core/quirks.c and if we fix the Realtek case the same way
>     we need to add an additional 14 entries. So in essence we need to
>     duplicate a large part of the usb_device_id table in btusb.c in
>     usb/core/quirks.c and manually keep them in sync.
> 
> This commit instead restores setting a reset-resume quirk for QCA devices
> in the btusb.c code, avoiding the duplicate usb_device_id table problem.
> 
> This commit avoids the problems with the original DIY BTUSB_RESET_RESUME
> code by simply setting the USB_QUIRK_RESET_RESUME quirk directly on the
> usb_device.
> 
> This commit also moves the BTUSB_REALTEK case over to directly setting the
> USB_QUIRK_RESET_RESUME on the usb_device and removes the now unused
> BTUSB_RESET_RESUME code.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> Fixes: 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
> Cc: stable@vger.kernel.org
> Cc: Leif Liddy <leif.linux@gmail.com>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Daniel Drake <drake@endlessm.com>
> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Note:
> 1) Once this has been merged, the 2 commits adding QCA device entries to
> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
> 2) I don't have any of the affected devices, please test

I've asked the reporter of:
https://bugzilla.redhat.com/show_bug.cgi?id=1514836

To test a kernel with this patch added and he confirms that this fixes
the autosuspend related issues he was seeing, so this is no longer untested.

Regards,

Hans



> ---
>   drivers/bluetooth/btusb.c | 22 ++++++++++------------
>   1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 4764100a5888..c4689f03220f 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -23,6 +23,7 @@
>   
>   #include <linux/module.h>
>   #include <linux/usb.h>
> +#include <linux/usb/quirks.h>
>   #include <linux/firmware.h>
>   #include <linux/of_device.h>
>   #include <linux/of_irq.h>
> @@ -388,9 +389,8 @@ static const struct usb_device_id blacklist_table[] = {
>   #define BTUSB_FIRMWARE_LOADED	7
>   #define BTUSB_FIRMWARE_FAILED	8
>   #define BTUSB_BOOTING		9
> -#define BTUSB_RESET_RESUME	10
> -#define BTUSB_DIAG_RUNNING	11
> -#define BTUSB_OOB_WAKE_ENABLED	12
> +#define BTUSB_DIAG_RUNNING	10
> +#define BTUSB_OOB_WAKE_ENABLED	11
>   
>   struct btusb_data {
>   	struct hci_dev       *hdev;
> @@ -3118,6 +3118,12 @@ static int btusb_probe(struct usb_interface *intf,
>   	if (id->driver_info & BTUSB_QCA_ROME) {
>   		data->setup_on_usb = btusb_setup_qca;
>   		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
> +
> +		/* QCA Rome devices lose their updated firmware over suspend,
> +		 * but the USB hub doesn't notice any status change.
> +		 * explicitly request a device reset on resume.
> +		 */
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>   	}
>   
>   #ifdef CONFIG_BT_HCIBTUSB_RTL
> @@ -3128,7 +3134,7 @@ static int btusb_probe(struct usb_interface *intf,
>   		 * but the USB hub doesn't notice any status change.
>   		 * Explicitly request a device reset on resume.
>   		 */
> -		set_bit(BTUSB_RESET_RESUME, &data->flags);
> +		interface_to_usbdev(intf)->quirks |= USB_QUIRK_RESET_RESUME;
>   	}
>   #endif
>   
> @@ -3297,14 +3303,6 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   		enable_irq(data->oob_wake_irq);
>   	}
>   
> -	/* Optionally request a device reset on resume, but only when
> -	 * wakeups are disabled. If wakeups are enabled we assume the
> -	 * device will stay powered up throughout suspend.
> -	 */
> -	if (test_bit(BTUSB_RESET_RESUME, &data->flags) &&
> -	    !device_may_wakeup(&data->udev->dev))
> -		data->udev->reset_resume = 1;
> -
>   	return 0;
>   }
>   
> 
