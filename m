From: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_bcm: For serdev case close serdev
 on failure to set power
Date: Mon, 22 Jan 2018 13:02:13 +0100
Message-ID: <6C1ACEC1-1A7E-44CC-9DB8-843CE5C41BA2@holtmann.org>
References: <20180122115325.28960-1-hdegoede@redhat.com>
 <20180122115325.28960-2-hdegoede@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180122115325.28960-2-hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Gustavo F. Padovan" <gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org>, Johan Hedberg <johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Hi Hans,

> Commit 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> introduced error checking for the bcm_gpio_set_power() call in bcm_open()
> but the error-path it introduces unsets dev->hu, which is correct for
> platform_device instantiated bcm_dev-s but not for serdev instantiated
> devs. For serdev instantiated devs serdev_device_close() should be called
> instead (and dev->hu should be left set).
> 
> Cc: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> Fixes: 8bfa7e1e03ac ("Bluetooth: hci_bcm: Handle errors properly")
> Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> drivers/bluetooth/hci_bcm.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
