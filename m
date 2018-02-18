From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH] Bluetooth: btusb: Restore QCA Rome suspend/resume fix
 with a "rewritten" version
Date: Sun, 18 Feb 2018 16:13:13 +0800
Message-ID: <AC3BE596-68BD-4D15-B06A-B529F9559C13@canonical.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <345b0de8-1a23-d2f8-bc56-507eadf7faa7@redhat.com>
 <6B37F6AC-1103-4FCF-A5DC-4BA236A7B11B@holtmann.org>
 <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1a08612e-2531-3711-ec0f-a867e86d0009@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Brian Norris <briannorris@chromium.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, stable <stable@vger.kernel.org>, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>, matadeen@qti.qualcomm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>
List-Id: linux-serial@vger.kernel.org



> On 16 Feb 2018, at 8:10 PM, Hans de Goede <hdegoede@redhat.com> wrote:
> 
> 
> Ok, I've asked the reporter of:
> 
> https://bugzilla.redhat.com/show_bug.cgi?id=1514836
> 
> Which is how I got involved in this to provide DMI data and
> I will whip up a patch for his machine and ask him to test
> and once that is done submit upstream. This is the only machine
> I'm aware of though and looking at the history of this I think
> there will be others.

I have one machine needs the quirk. I’ll also send a patch to
match its DMI.

Kai-Heng

> 
>> I addition we can add a module option to btusb.ko that allows us to force this flag to be set. That way testing this is easy on a vendor kernel. A bunch of the btusb quirks (and also core quirks) can be tested via module options or debugfs.
> 
> Yes a module option for this is a good idea.
> 
> Regards,
> 
> Hans
> 
> 

