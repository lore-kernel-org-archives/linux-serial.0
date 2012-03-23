From: Darren Hart <dvhart@linux.intel.com>
Subject: Re: [PATCHv2] pch_uart: Add Kontron COMe-mTT10 uart clock quirk
Date: Fri, 23 Mar 2012 07:25:14 -0700
Message-ID: <4F6C87CA.3010203@linux.intel.com>
References: <20120322211903.6776ab18@mail.gmx.de> <4F6B8E1B.9080802@linux.intel.com> <20120322223112.291e0c59@mail.gmx.de> <4F6B9E7B.9090005@linux.intel.com> <20120323110637.63aa2f64@hyperion>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:16358 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458Ab2CWO0A (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 23 Mar 2012 10:26:00 -0400
In-Reply-To: <20120323110637.63aa2f64@hyperion>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Brunner <mibru@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org



On 03/23/2012 03:06 AM, Michael Brunner wrote:
> Add UART clock quirk for the Kontron COMe-mTT10 module.
>
> The board has previously been called nanoETXexpress-TT, therefore this
> is also checked.
>
> As suggested by Darren Hart the comparison in this patch version is
> placed after the FRI2 checks to ensure it will also work with possible
> upcoming changes to the FRI2 firmware.
>
> This patch follows the patchset submitted by Darren Hart at
> commit a46f5533ecfc7bbdd646d84fdab8656031a715c6.
>
> Signed-off-by: Michael Brunner <mibru@gmx.de>
> ---
>  drivers/tty/serial/pch_uart.c |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
> index 332f2eb..dd69c95 100644
> --- a/drivers/tty/serial/pch_uart.c
> +++ b/drivers/tty/serial/pch_uart.c
> @@ -210,6 +210,7 @@ enum {
>  #define CMITC_UARTCLK   192000000 /* 192.0000 MHz */
>  #define FRI2_64_UARTCLK  64000000 /*  64.0000 MHz */
>  #define FRI2_48_UARTCLK  48000000 /*  48.0000 MHz */
> +#define NTC1_UARTCLK     64000000 /*  64.0000 MHz */
>
>  struct pch_uart_buffer {
>  	unsigned char *buf;
> @@ -388,6 +389,12 @@ static int pch_uart_get_uartclk(void)
>  	if (cmp && strstr(cmp, "Fish River Island II"))
>  		return FRI2_48_UARTCLK;
>
> +	/* Kontron COMe-mTT10 (nanoETXexpress-TT) */
> +	cmp = dmi_get_system_info(DMI_BOARD_NAME);
> +	if (cmp && (strstr(cmp, "COMe-mTT") ||
> +		    strstr(cmp, "nanoETXexpress-TT")))
> +		return NTC1_UARTCLK;
> +

I don't know the cost of a dmi_get_system_info() call, since we already
grabbed BOARD_NAME, would it make sense to reuse that value by using a
dedicated cmp string?

...

Hrm, just appears to be an array lookup...

	return dmi_ident[field];

No real loss there.

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
Yocto Project - Linux Kernel
