From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] serial: lpc32xx: Fix fallout from tty_port conversion
Date: Sun, 20 Jan 2013 11:19:25 +0100
Message-ID: <50FBC4AD.4020008@suse.cz>
References: <1358493951-5349-1-git-send-email-thierry.reding@avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ea0-f181.google.com ([209.85.215.181]:62756 "EHLO
	mail-ea0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751249Ab3ATKTX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 20 Jan 2013 05:19:23 -0500
In-Reply-To: <1358493951-5349-1-git-send-email-thierry.reding@avionic-design.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Thierry Reding <thierry.reding@avionic-design.de>
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2013 08:25 AM, Thierry Reding wrote:
> A duplicate definition of the port variable was introduced in the
> interrupt handler, which causes the build to break. The fix is to
> rename the variable to tport, which is already properly used in
> subsequent code.
> 
> Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
> ---
>  drivers/tty/serial/lpc32xx_hs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
> index c01b58f..dffea6b 100644
> --- a/drivers/tty/serial/lpc32xx_hs.c
> +++ b/drivers/tty/serial/lpc32xx_hs.c
> @@ -322,7 +322,7 @@ exit_tx:
>  static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
>  {
>  	struct uart_port *port = dev_id;
> -	struct tty_port *port = &port->state->port;
> +	struct tty_port *tport = &port->state->port;

Oh, yeah, these arch-dependent drivers... This one is arm, tty-build
script has been updated here. Thanks for spotting and fixing.

-- 
js
suse labs
