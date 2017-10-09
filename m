From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 2/2] serdev: Update drivers/bluetooth/Kconfig for ACPI
 serdev support
Date: Mon, 9 Oct 2017 10:06:06 +0200
Message-ID: <20171009080606.GO2618@localhost>
References: <dc9cecc0-d9ef-109f-5f05-cf77ab16e60e@gmail.com>
 <427a95f6-feda-e93e-9a0f-a05b7b339ee6@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <427a95f6-feda-e93e-9a0f-a05b7b339ee6-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Marcel Holtmann <marcel-kz+m5ild9QBg9hUCZPvPmw@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, gustavo-THi1TnShQwVAfugRpC6u6w@public.gmane.org, johan.hedberg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, frederic.danis.oss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, loic.poulain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Greg Kroah-Hartman <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Oct 09, 2017 at 11:43:31AM +1100, Ian W MORRISON wrote:
> ACPI and DT both need SERIAL_DEV_CTRL_TTYPORT to work properly
> since SERIAL_DEV_CTRL_TTYPORT is the only controller implemented for
> serdev. This is only possible if serdev support is compiled in as the code
> hooks into TTY. Otherwise PM will silently break as the corresponding
> platform devices would no longer be registered and as the tty class
> device is also gone and hciattach (btattach) will also fail.
> 
> This patch set addresses this by making BT_HCIUART_BCM dependent on
> SERIAL_DEV_CTRL_TTYPORT which in turn is dependent on SERIAL_DEV_BUS
> and ensures that if SERIAL_DEV_BUS is selected is the code is build it.

Ok, so you didn't even bother to write two distinct commit messages for
your two patches, and my comments to the first patch apply also here.

> Signed-off-by: Ian W MORRISON <ianwmorrison-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index fae5a74dc737..8d432ee9f4bd 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -171,6 +171,7 @@ config BT_HCIUART_BCM
>  	depends on BT_HCIUART_SERDEV
>  	select BT_HCIUART_H4
>  	select BT_BCM
> +	select SERIAL_DEV_CTRL_TTYPORT

I think

	depends on (!ACPI || SERIAL_DEV_CTRL_TTYPORT)

or just

	depends on SERIAL_DEV_CTRL_TTYPORT

is what we want here, but that's still being discussed.

[ In general, select should be avoided as you could end up with options
enabled without their dependencies also being enabled. In this case,
we're fine as BT_HCIUART_BCM as depends on SERIAL_DEV_BUS via
BT_HCIUART_SERDEV, and your first patch ruled out SERIAL_DEV_BUS=y, but
that's not obvious. ]

>  	help
>  	  The Broadcom protocol support enables Bluetooth HCI over serial
>  	  port interface for Broadcom Bluetooth controllers.

Johan
