From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH tty-next 21/22] serial: core: Remove superfluous ldisc
 flush from uart_close()
Date: Fri, 11 Jul 2014 12:15:49 -0400
Message-ID: <53C00DB5.600@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com> <1402924639-5164-22-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:47880 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754807AbaGKQPz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jul 2014 12:15:55 -0400
In-Reply-To: <1402924639-5164-22-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>

On 06/16/2014 09:17 AM, Peter Hurley wrote:
> The tty_ldisc_flush() after port hardware shutdown is unnecessary;
> the ldisc flush was just performed before the hardware shutdown
> in tty_port_close_start() and the ldisc will be released when
> uart_close() returns (because the last port close implies the
> last tty close).
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>   drivers/tty/serial/serial_core.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 212ee07..15212d7 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1351,9 +1351,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
>
>   	mutex_lock(&port->mutex);
>   	uart_shutdown(tty, state);
> -
> -	tty_ldisc_flush(tty);
> -

This isn't exactly correct. There is a small window of time between the
ldisc flush being performed in tty_port_close_start() and the
subsequent stop_rx() in uart_close(). This might allow for data to be
received, and a racing tty reopen to receive that stale data. Unlikely, but
possible.

>   	tty_port_tty_set(port, NULL);
>   	tty->closing = 0;
>   	spin_lock_irqsave(&port->lock, flags);
>

