From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 1/2] serdev: Add ACPI support
Date: Tue, 10 Oct 2017 18:36:30 +0200
Message-ID: <20171010163630.GO4269@localhost>
References: <1507107090-15992-1-git-send-email-frederic.danis.oss@gmail.com>
 <1507107090-15992-2-git-send-email-frederic.danis.oss@gmail.com>
 <20171007151255.GH2618@localhost>
 <BC1C29B8-C76B-499D-B8BE-365B5D3A0065@holtmann.org>
 <20171010081528.GJ4269@localhost>
 <3F3CFF22-4FCE-4283-8A41-73A9A7944494@holtmann.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3F3CFF22-4FCE-4283-8A41-73A9A7944494@holtmann.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hovold <johan@kernel.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, robh@kernel.org, sre@kernel.org, loic.poulain@gmail.com, lukas@wunner.de, hdegoede@redhat.com, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Oct 10, 2017 at 10:22:19AM +0200, Marcel Holtmann wrote:

> > Some of the above are minor nits that can be addressed by a follow-up
> > patch indeed, but the handling of nodes with no child devices needs to
> > be correct (or you could end up breaking normal serial-port support).
> 
> that sounds good to me as well. Lets get this feature into the ACPI
> tree since I am going to push Hans’ patches into bluetooth-next as
> soon as he re-submits the missing ID change. That hopefully gives us
> then fully serdev support for ACPI and DT when it comes to Broadcom
> Bluetooth controllers.

But with Hans's work these devices should continue to function using the
platform-device hacks until the ACPI patch eventually lands in Linus's
tree (via the acpi tree).

> Next step is to convert the Intel driver to also use ACPI based serdev
> :)
> 
> And for the brave, I think there are Realtek based systems using ACPI
> as well.
> 
> What I was wondering the other day is if we need a lsserdev tool or
> some integration in lshw to be able to debug what serdev devices and
> ID are present. The lsusb and /sys/kernel/debug/usb/devices is just
> super powerful and easy when it comes to figuring out what people have
> in their system. Maybe /sys/kernel/debug/serdev/devices could be
> helpful as well. Just thinking out loud here.

Yeah, maybe. Since you'd typically only have small number of serdev
devices (say, max 4), using /sys/bus/serial/devices directly should not
be too bad meanwhile. Not that much common information we can expose
either, at least not in comparison to USB. But I'll keep it mind. :)

Johan
