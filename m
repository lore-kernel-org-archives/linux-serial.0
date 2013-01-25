From: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/2] serial: ralink: adds support for the serial core
 found on ralink wisoc
Date: Fri, 25 Jan 2013 15:40:56 +0400
Message-ID: <51026F48.1060106@mvista.com>
References: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:54201 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754372Ab3AYLlQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jan 2013 06:41:16 -0500
Received: by mail-lb0-f173.google.com with SMTP id gf7so547093lbb.32
        for <linux-serial@vger.kernel.org>; Fri, 25 Jan 2013 03:41:14 -0800 (PST)
In-Reply-To: <1359111008-9998-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org, linux-mips@linux-mips.org

Hello.

On 25-01-2013 14:50, John Crispin wrote:

> The MIPS based Ralink WiSoC platform has 1 or more 8250 compatible serial cores.
> To make them work we require the same quirks that are used by AU1x00.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   drivers/tty/serial/8250/8250.c  |    6 +++---
>   drivers/tty/serial/8250/Kconfig |    8 ++++++++
>   include/linux/serial_core.h     |    2 +-
>   3 files changed, 12 insertions(+), 4 deletions(-)

> diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
> index f932043..b727779 100644
> --- a/drivers/tty/serial/8250/8250.c
> +++ b/drivers/tty/serial/8250/8250.c
> @@ -324,9 +324,9 @@ static void default_serial_dl_write(struct uart_8250_port *up, int value)
>   	serial_out(up, UART_DLM, value >> 8 & 0xff);
>   }
>
> -#ifdef CONFIG_MIPS_ALCHEMY
> +#if defined(CONFIG_MIPS_ALCHEMY) || defined(CONFIG_SERIAL_8250_RT288X)
>
> -/* Au1x00 UART hardware has a weird register layout */
> +/* Au1x00 RT288x UART hardware has a weird register layout */
             ^
    You need either comma or slash or "and" between those...

WBR, Sergei

