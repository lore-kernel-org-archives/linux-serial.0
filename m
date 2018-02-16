From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Fri, 16 Feb 2018 13:10:20 +0100
Message-ID: <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Brian Norris <briannorris@chromium.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, matadeen@qti.qualcomm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-serial@vger.kernel.org

Hi,

On 16-02-18 12:45, Marcel Holtmann wrote:
> Hi Hans,
> 
>>>>>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>>>>>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>>>>>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>>>>>
>>>>>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>>>>>> has several issues (see the original commit message). An added advantage
>>>>>> of moving over to the USB-core reset-resume handling is that it also
>>>>>> disables autosuspend for these devices, which is similarly broken on these.
>>>>>
>>>>> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
>>>>> think so -- I'm using one now.
>>>>
>>>> And have you manually enabled USB autosuspend for it, or are you
>>>> running something which might have done so, e.g. powertop --auto-tune ?
>>>>
>>>> Because if you did not do that then you're already not using autosuspend
>>>> for your QCA devices and this patch will change nothing.
>>> I use a set of udev rules that manually whitelist devices for
>>> autosuspend. You can see it here:
>>> https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
>>> You'll find at least one Rome chip in there.
>>>
>>>>> Thus, this is a poor solution, which
>>>>> negatively affects my systems. However, I see that this patch was
>>>>> applied regardless...
>>>>
>>>> Note that there already is a quirk to handle broken suspend/resume
>>>> behavior on ALL QCA devices in older kernels. Also note that the
>>> Yes, and the quirk was broken, and I made sure it got reverted when it
>>> broke my devices ;)
>>
>> Note that the revert for this:
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7d06d5895c15
>>
>> Says: "This commit causes a regression on some QCA ROME chips. The USB device reset happens
>> in btusb_open(), hence firmware loading gets interrupted."
>>
>> And says:
>>
>> "If we really want to reset the USB device, we need to do it before btusb_open(). Let's
>> handle it in drivers/usb/core/quirks.c."
>>
>> It does not mention that the quirk is not necessary on some devices only
>> that the implementation of it we had before had issues.
>>
>> And the original commit of the quirk:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/drivers/bluetooth/btusb.c?id=fd865802c66bc451dc515ed89360f84376ce1a56
>>
>> Says: "There's been numerous reported instances where BTUSB_QCA_ROME
>> bluetooth controllers stop functioning upon resume from suspend."
>>
>> So it may be platform specific but it is not just limited to 1 or
>> 2 platforms I think.
>>
>> Note I'm not saying that I don't believe you that the quirk is not
>> necessary on your devices.
>>
>>>> patches series which this commit builds on top of was already
>>>> setting USB_QUIRK_RESET_RESUME for some devices in
>>>> usb/core/quirks.c.
>>>>
>>>> All my commit does is instead of duplicating all the QCA USB-ids in
>>>> usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
>>>> to btusb.c so that we don't need to duplicate the USB-id tables.
>>> I was slightly more OK with marking specific IDs as broken, because
>>> those IDs didn't happen to be ones that I knew were currently working.
>>> Now you're breaking my systems again. But this time, it's more subtle
>>> because bluetooth will still work, but we just suck more power leaving
>>> our USB port active all the time.
>>
>> I see, sorry about that. Ok, so we are going to need to make the
>> reset-on-resume quirking more fine grained. I can see 3 ways to do this:
>>
>> 1) Make it a separate per usb-id BTUSB_RESET_RESUME flag in the
>> usb_device_id table inside btusb.c (I still believe duplicating most
>> ids to usb/core/quirks.c is a bad idea).
>>
>> 2) Use dmi based whitelisting to opt out of reset-resume behavior on
>> QCA btusb devices.
>>
>> 3) Use dmi based blacklisting which enables reset-resume behavior.
>>
>> In retrospect I guess 3 would have been best, but if we do that now
>> it will cause regressions.
>>
>> I guess we should go with 1. adding the BTUSB_RESET_RESUME to all the
>> QCA usb-ids except for the ones where you know things work and which
>> only seem to be used in working devices (based on you not having
>> objections against the additions of the quirk for some ids to
>> drivers/usb/core/quirks.c).
>>
>> And if then those usb-ids do turn out to have broken suspend on
>> on some devices too I guess we need to move to 2.
> 
> actually if this is really platform related as Qualcomm is indicating, then we should just go with 3) and the two platforms that previously added quirks to usb/core/quirks.c and blacklist these. I am all for figuring out what is going on here. So lets blacklist these and see how this goes. Maybe there are only two bad platforms out there and we are making too much fuzz about this. Before we added quirks in the USB core these platforms were just plain broken as well. So not much different situation than before. We need to push the DMI blacklisting back into -stable as well and that means any impact of a 3rd broken platform briefly working and then be broken again is slim and also fixable via -stable.

Ok, I've asked the reporter of:

https://bugzilla.redhat.com/show_bug.cgi?id=1514836

Which is how I got involved in this to provide DMI data and
I will whip up a patch for his machine and ask him to test
and once that is done submit upstream. This is the only machine
I'm aware of though and looking at the history of this I think
there will be others.

> I addition we can add a module option to btusb.ko that allows us to force this flag to be set. That way testing this is easy on a vendor kernel. A bunch of the btusb quirks (and also core quirks) can be tested via module options or debugfs.

Yes a module option for this is a good idea.

Regards,

Hans


