From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Tue, 9 Jan 2018 09:48:55 +0100
Message-ID: <61d91b1b-b46a-11db-b2aa-bc419dd68e30@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <28EBA1CE-4DFF-4828-BF00-99BC2B487484@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <28EBA1CE-4DFF-4828-BF00-99BC2B487484-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Content-Language: en-US
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Cc: "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "open list:BLUETOOTH DRIVERS" <linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Leif Liddy <leif.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On 08-01-18 21:46, Marcel Holtmann wrote:
> Hi Hans,
> 
>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>
>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>> has several issues (see the original commit message). An added advantage
>> of moving over to the USB-core reset-resume handling is that it also
>> disables autosuspend for these devices, which is similarly broken on these.
>>
>> But there are 2 issues with this approach:
>> 1) It leaves the broken DIY BTUSB_RESET_RESUME code in place for Realtek
>>    devices.
>> 2) Sofar only 2 of the 10 QCA devices known to the btusb code have been
>>    added to usb/core/quirks.c and if we fix the Realtek case the same way
>>    we need to add an additional 14 entries. So in essence we need to
>>    duplicate a large part of the usb_device_id table in btusb.c in
>>    usb/core/quirks.c and manually keep them in sync.
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
>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> Cc: Leif Liddy <leif.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Cc: Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Cc: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Cc: Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
>> Cc: Kai-Heng Feng <kai.heng.feng-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
>> ---
>> Note:
>> 1) Once this has been merged, the 2 commits adding QCA device entries to
>> drivers/usb/core/quirks.c should be reverted or dropped from bluetooth-next.
>> 2) I don't have any of the affected devices, please test
>> ---
>> drivers/bluetooth/btusb.c | 22 ++++++++++------------
>> 1 file changed, 10 insertions(+), 12 deletions(-)
> 
> patch has been applied to bluetooth-next tree.

I see that you've also dropped the 2 commits adding QCA device entries to
drivers/usb/core/quirks.c, great. Thank you.

Regards,

Hans
