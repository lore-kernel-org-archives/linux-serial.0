From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the
 serdev driver
Date: Thu, 5 Oct 2017 12:45:09 +0200
Message-ID: <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171004184343.7855-9-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Make the serdev driver use struct bcm_device as its driver data and share
> all the pm / GPIO / IRQ related code paths with the platform driver.
> 
> After this commit the 2 drivers are in essence the same and the serdev
> driver interface can be used for all ACPI enumerated HCI UARTs.
> 
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
> 1 file changed, 68 insertions(+), 50 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel
