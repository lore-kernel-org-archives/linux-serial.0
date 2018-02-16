From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Fri, 16 Feb 2018 09:43:16 +0100
Message-ID: <6A7B0B8A-71AD-4FC6-AE2F-B959B3C4BA00@holtmann.org>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Hans de Goede <hdegoede@redhat.com>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, matadeen@qti.qualcomm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-serial@vger.kernel.org

Hi Brian,

>>> On Mon, Jan 08, 2018 at 10:44:16AM +0100, Hans de Goede wrote:
>>>> Commit 7d06d5895c15 ("Revert "Bluetooth: btusb: fix QCA...suspend/resume"")
>>>> removed the setting of the BTUSB_RESET_RESUME quirk for QCA Rome devices,
>>>> instead favoring adding USB_QUIRK_RESET_RESUME quirks in usb/core/quirks.c.
>>>> 
>>>> This was done because the DIY BTUSB_RESET_RESUME reset-resume handling
>>>> has several issues (see the original commit message). An added advantage
>>>> of moving over to the USB-core reset-resume handling is that it also
>>>> disables autosuspend for these devices, which is similarly broken on these.
>>> 
>>> Wait, is autosuspend actually broken for all QCA Rome chipsets? I don't
>>> think so -- I'm using one now.
>> 
>> And have you manually enabled USB autosuspend for it, or are you
>> running something which might have done so, e.g. powertop --auto-tune ?
>> 
>> Because if you did not do that then you're already not using autosuspend
>> for your QCA devices and this patch will change nothing.
> 
> I use a set of udev rules that manually whitelist devices for
> autosuspend. You can see it here:
> 
> https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> 
> You'll find at least one Rome chip in there.
> 
>>> Thus, this is a poor solution, which
>>> negatively affects my systems. However, I see that this patch was
>>> applied regardless...
>> 
>> Note that there already is a quirk to handle broken suspend/resume
>> behavior on ALL QCA devices in older kernels. Also note that the
> 
> Yes, and the quirk was broken, and I made sure it got reverted when it
> broke my devices ;)
> 
>> patches series which this commit builds on top of was already
>> setting USB_QUIRK_RESET_RESUME for some devices in
>> usb/core/quirks.c.
>> 
>> All my commit does is instead of duplicating all the QCA USB-ids in
>> usb/core/quirks.c, move the setting of USB_QUIRK_RESET_RESUME
>> to btusb.c so that we don't need to duplicate the USB-id tables.
> 
> I was slightly more OK with marking specific IDs as broken, because
> those IDs didn't happen to be ones that I knew were currently working.
> Now you're breaking my systems again. But this time, it's more subtle
> because bluetooth will still work, but we just suck more power leaving
> our USB port active all the time.
> 
>> The result of the combination of these patches is that the custom
>> DIY reset on resume handling btusb.c was doing is now replaced
>> by setting the standard USB-core USB_QUIRK_RESET_RESUME quirk.
>> 
>> As a (desirable) side effect this also disables USB autosuspend
>> for QCA devices since the USB-core does not allow USB autosuspend
>> on devices with the USB_QUIRK_RESET_RESUME quirk. Testing has shown
>> this to be necessary on at least some QCA devices and given that
>> these devices tend to loose there firmware on a suspend, it seems
>> sensible to not allow autosuspend on them.
> 
> But you're not accurately targeting the "some". AFAICT, you're wasting
> power on my system.
> 
>>> What justifications was found for this anyway? AIUI, this is a platform
>>> bug, and not entirely a chipset bug.
>> 
>> No this is believed to be a chipset issue, hence also the quirk in
>> older kernels to always reset these devices after a normal suspend/resume.
> 
> I have Qualcomm telling me this is a platform issue. I haven't noticed
> problems with autosuspend nor system suspend/resume on my platform. Do
> you have any more detail on this issue? Have you consulsted QCA folks?
> 
> Unfortunately, Greg is already queueing this patch up to all the -stable
> trees, so I'm going to have to revert it yet again in Chromium
> kernels...

if this is a platform issue, then doing this based on VID:PID pairs is wrong no matter what. Then again, if we have really dedicated VID:PID combination for certain platforms, we could also just whitelist them in the driver. The btusb.c already contains an extra blacklist check. It is easy to add another USB ID table for a QCA whitelist.

Regards

Marcel

