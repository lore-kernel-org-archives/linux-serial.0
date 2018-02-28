From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Bluetooth: btusb: Remove Yoga 920 from the
 btusb_needs_reset_resume_table
Date: Thu, 1 Mar 2018 00:45:42 +0800
Message-ID: <D7B95CCB-5AF4-4034-8813-1F0CFBC378F7@canonical.com>
References: <20180228105750.6491-1-hdegoede@redhat.com>
 <20180228105750.6491-2-hdegoede@redhat.com>
 <CA+ASDXNwiWXdhyRZMiMXkVazqGxr8pLfmTpo1hD2CbCBmNrzLg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <CA+ASDXNwiWXdhyRZMiMXkVazqGxr8pLfmTpo1hD2CbCBmNrzLg@mail.gmail.com>
Sender: stable-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>
List-Id: linux-serial@vger.kernel.org

Brian Norris <briannorris@chromium.org> wrote:

> + Leif
>
> On Wed, Feb 28, 2018 at 2:57 AM, Hans de Goede <hdegoede@redhat.com> wrote:
>> Commit 55a9c95d70ab ("Bluetooth: btusb: Use DMI matching for QCA
>> reset_resume quirking"), added the Lenovo Yoga 920 to the
>> btusb_needs_reset_resume_table.
>>
>> Testing has shown that this is a false positive and the problems where
>> caused by issues with the initial fix: commit fd865802c66b ("Bluetooth:
>> btusb: fix QCA Rome suspend/resume"), which has already been reverted.
>>
>> So the QCA Rome BT in the Yoga 920 does not need a reset-resume quirk at
>> all and this commit removes it from the btusb_needs_reset_resume_table.
>>
>> Note that after this commit the btusb_needs_reset_resume_table is now
>> empty. It is kept around on purpose, since this whole series of commits
>> started for a reason and there are actually broken platforms around,
>> which need to be added to it.
>
> This is hilarious.
>

The platform at my hand still needs the quirk though, so the table is quite  
useful.
I’ll send a patch soon.

> I think we need to go back to the author(s) of commit fd865802c66b and
> find proper details about said "numerous reported instances" of
> problems... Anyway:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>
>
>> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1514836
>> Fixes: 55a9c95d70ab ("Bluetooth: btusb: Use DMI matching for QCA ...")
>> Cc: stable@vger.kernel.org
>> Cc: Brian Norris <briannorris@chromium.org>
>> Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
>> Tested-by: Kevin Fenzi <kevin@scrye.com>
>> Suggested-by: Brian Norris <briannorris@chromium.org>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  drivers/bluetooth/btusb.c | 7 -------
>>  1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index a4b62f0a93cc..418550eb1522 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -386,13 +386,6 @@ static const struct usb_device_id blacklist_table[]  
>> = {
>>   * the module itself. So we use a DMI list to match known broken platforms.
>>   */
>>  static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
>> -       {
>> -               /* Lenovo Yoga 920 (QCA Rome device 0cf3:e300) */
>> -               .matches = {
>> -                       DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
>> -                       DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo YOGA 920"),
>> -               },
>> -       },
>>         {}
>>  };
>>
>> —

>> 2.14.3
