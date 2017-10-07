From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v2 1/9] Bluetooth: hci_uart_set_flow_control: Fix NULL
 deref when using serdev
Date: Sat, 7 Oct 2017 16:36:45 +0200
Message-ID: <20171007143645.GG2618@localhost>
References: <20171004184343.7855-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171004184343.7855-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan <gustavo@padovan.org>, Johan Hedberg <johan.hedberg@gmail.com>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis <frederic.danis.oss@gmail.com>, Sebastian Reichel <sre@kernel.org>, robh@kernel.org, linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Oct 04, 2017 at 08:43:35PM +0200, Hans de Goede wrote:
> Fix a NULL pointer deref (hu->tty) when calling hci_uart_set_flow_control
> on hci_uart-s using serdev.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Also set RTS (Suggested-by: Sebastian Reichel <sre@kernel.org>)
> ---
>  drivers/bluetooth/hci_ldisc.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index a746627e784e..eec95019f15c 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -41,6 +41,7 @@
>  #include <linux/ioctl.h>
>  #include <linux/skbuff.h>
>  #include <linux/firmware.h>
> +#include <linux/serdev.h>

I know this is already merged, but do we really want to add a dependency
on serdev from hci_ldisc.c?

There is already a helper function host_set_baudrate() in hci_bcm to
handle another case like this. If more drivers will need to support
both then these could be moved to a common header, but we should at
least try to be consistent here.

>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
> @@ -298,6 +299,12 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable)
>  	unsigned int set = 0;
>  	unsigned int clear = 0;
>  
> +	if (hu->serdev) {
> +		serdev_device_set_flow_control(hu->serdev, !enable);
> +		serdev_device_set_rts(hu->serdev, !enable);

The order here may matter; in the non-serdev case, rts is raised before
enabling flow control.

> +		return;
> +	}
> +
>  	if (enable) {
>  		/* Disable hardware flow control */
>  		ktermios = tty->termios;

Johan
