From: Brian Norris <briannorris@chromium.org>
Subject: Re: udev USB autosupend whitelist (was Re: [PATCH] Bluetooth: btusb:
 Restore QCA Rome suspend/resume fix with a "rewritten" version)
Date: Fri, 16 Feb 2018 08:49:25 -0800
Message-ID: <20180216164924.GA72213@rodete-desktop-imager.corp.google.com>
References: <20180108094416.4789-1-hdegoede@redhat.com>
 <20180213022455.GA151190@rodete-desktop-imager.corp.google.com>
 <8cd918fd-bf6f-70ac-e561-e7deffa695f0@redhat.com>
 <20180216022721.GA69988@rodete-desktop-imager.corp.google.com>
 <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0a13d0f3-8e0d-74df-df9c-2bf0622a9fb6@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org, stable@vger.kernel.org, Leif Liddy <leif.linux@gmail.com>, Matthias Kaehlcke <mka@chromium.org>, Daniel Drake <drake@endlessm.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, matadeen@qti.qualcomm.com, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Benson Leung <bleung@chromium.org>
List-Id: linux-serial@vger.kernel.org

+ Benson (and there are probably others that know better answers)

Hi,

On Fri, Feb 16, 2018 at 09:26:37AM +0100, Hans de Goede wrote:
> Going a bit off-topic here, so changed the subject.
> I will reply on topic in another mail.
> 
> On 16-02-18 03:27, Brian Norris wrote:
> > I use a set of udev rules that manually whitelist devices for
> > autosuspend. You can see it here:
> > 
> > https://chromium.googlesource.com/chromiumos/platform2/+/43728a93f6de137006c6b92fbb2a7cc4f353c9bf/power_manager/udev/gen_autosuspend_rules.py#83
> > 
> > You'll find at least one Rome chip in there.
> 
> Oh, that is a very interesting link for the work I've been doing to
> improve Linux power-consumption in general:
> 
> https://fedoraproject.org/wiki/Changes/ImprovedLaptopBatteryLife
> 
> I was actually planning on at least doing such a list for WWAN modems,
> for btusb my approach has been to just enable it everywhere
> (except for QCA devices as I got bugreports for those).
> 
> Note that I plan to eventually submit this whitelist to the
> udev rules which are part of systemd upstream, so if chromeos
> is using systemd too, this is something to be aware of for you.

Chrome OS does not currently use systemd, but thanks for the heads up.

> Question, is the white-listing of the root and rate-limiting
> hubs really necessary? I thought these have this enabled by default?

This list is old and maintained by several of my team, originating from
quite a ways back (i.e., much older kernels). It's quite possible that
some of it is redundant today.

> Also any caveats here I should be aware of?

That it's only maintained for the express purpose of Chrome{device}s?
There's no guarantee that there aren't platform issues with other
systems, for instance :)

I'm not really aware of any particular caveats otherwise.

Brian
