From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to
 the serdev driver
Date: Mon, 9 Oct 2017 16:22:28 +0200
Message-ID: <20171009142228.GD4269@localhost>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
 <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
 <1389d64c-17aa-c6a1-d56f-6c2fe877f247@redhat.com>
 <17592E57-3A4B-4386-B809-9EA928D38FDD@holtmann.org>
 <20171007142631.GF2618@localhost>
 <ebd6e9dc-9c25-a2ea-619f-bd1cdf45b6a3@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ebd6e9dc-9c25-a2ea-619f-bd1cdf45b6a3@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Johan Hovold <johan@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 09, 2017 at 04:02:24PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 07-10-17 16:26, Johan Hovold wrote:

> > However, there are of course a couple of caveats. Once Frederic's ACPI
> > patches land, there will be no more platform child devices. Unless
> > serdev support is then compiled in, this means that PM will break
> > (silently). And if serdev is enabled, of course the tty class device is
> > gone and hciattach (btattach) will fail, but I guess everyone is aware
> > of that issue by now.
> > 
> > Should BT_HCIUART_BCM start depending on SERIAL_DEV_CTRL_TTYPORT (when
> > ACPI is enabled) to avoid such silent breakage once ACPI-support is
> > merged?
> 
> It seems that this was answered already in further discussions and
> your recent patch to add a default y to SERIAL_DEV_CTRL_TTYPORT fixes
> this, right ?

Only partially, as the serdev bus code could still be built as a module,
which would prevent SERIAL_DEV_CTRL_TTYPORT from being selected.

We could consider having BT_HCIUART_BCM depend on
SERIAL_DEV_CTRL_TTYPORT (or !ACPI || SERIAL_DEV_CTRL_TTYPORT) just to
avoid any hard-to-detect regressions.

Johan
