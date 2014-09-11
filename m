From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/9] ARM: meson: serial: add MesonX SoC on-chip uart
 driver
Date: Thu, 11 Sep 2014 14:25:34 -0700
Message-ID: <20140911212534.GA17251@kroah.com>
References: <1410466300-19168-1-git-send-email-carlo@caione.org>
 <1410466300-19168-4-git-send-email-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43453 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752126AbaIKVZe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 11 Sep 2014 17:25:34 -0400
Content-Disposition: inline
In-Reply-To: <1410466300-19168-4-git-send-email-carlo@caione.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux@arm.linux.org.uk, robh+dt@kernel.org, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, daniel.lezcano@linaro.org, tglx@linutronix.de, jslaby@suse.cz, grant.likely@linaro.org, b.galvani@gmail.com, maxime.ripard@free-electrons.com, afaerber@suse.de, matthias.bgg@gmail.com

On Thu, Sep 11, 2014 at 10:11:34PM +0200, Carlo Caione wrote:
> The SoC has four fully functional UARTs which use the same programming
> model. They are named UART_A, UART_B, UART_C and UART_AO (Always-On)
> which cannot be powered off.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  drivers/tty/serial/Kconfig       |  18 ++
>  drivers/tty/serial/Makefile      |   1 +
>  drivers/tty/serial/meson_uart.c  | 634 +++++++++++++++++++++++++++++++++++++++
>  include/uapi/linux/serial_core.h |   3 +
>  4 files changed, 656 insertions(+)
>  create mode 100644 drivers/tty/serial/meson_uart.c

I've already taken this patch, why resend it?

confused,

greg k-h
