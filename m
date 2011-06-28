From: Stephen Warren <swarren@nvidia.com>
Subject: RE: [PATCH] tty/serial: Fix XSCALE serial ports, e.g. ce4100
Date: Tue, 28 Jun 2011 10:22:18 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049D2EC52C@HQMAIL01.nvidia.com>
References: <1308325507-17711-1-git-send-email-swarren@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:12281 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759564Ab1F1RWi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 28 Jun 2011 13:22:38 -0400
In-Reply-To: <1308325507-17711-1-git-send-email-swarren@nvidia.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "gregkh@suse.de" <gregkh@suse.de>, "alan@linux.intel.com" <alan@linux.intel.com>, "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Stephen Warren wrote at Friday, June 17, 2011 9:45 AM:
> Commit 4539c24fe4f92c09ee668ef959d3e8180df619b9 "tty/serial: Add
> explicit PORT_TEGRA type" introduced separate flags describing the need
> for IER bits UUE and RTOIE. Both bits are required for the XSCALE port
> type. While that patch updated uart_config[] as required, the auto-probing
> code wasn't updated to set the RTOIE flag when an XSCALE port type was
> detected. This caused such ports to stop working. This patch rectifies
> that.

Alan, Greg,

Does this patch look OK? Seems like it should go into 3.0, but I don't see
it ack'd or committed anywhere yet.

Thanks.

> Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  drivers/tty/serial/8250.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
> index f11df87..f1422a6 100644
> --- a/drivers/tty/serial/8250.c
> +++ b/drivers/tty/serial/8250.c
> @@ -1107,7 +1107,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
>  			 */
>  			DEBUG_AUTOCONF("Xscale ");
>  			up->port.type = PORT_XSCALE;
> -			up->capabilities |= UART_CAP_UUE;
> +			up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
>  			return;
>  		}
>  	} else {
> --
> 1.7.0.4

-- 
nvpublic

