From: Rickard Andersson <rickard.andersson@stericsson.com>
Subject: Re: [PATCH 2/2] TTY: serial, add pm function
Date: Tue, 11 Dec 2012 18:06:00 +0100
Message-ID: <50C767F8.3080003@stericsson.com>
References: <1355142858-11046-1-git-send-email-rickard.andersson@stericsson.com> <1355142858-11046-2-git-send-email-rickard.andersson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:38934 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984Ab2LKRdn (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 11 Dec 2012 12:33:43 -0500
In-Reply-To: <1355142858-11046-2-git-send-email-rickard.andersson@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Rickard ANDERSSON <rickard.andersson@stericsson.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, Linus WALLEIJ <linus.walleij@stericsson.com>, "alan@linux.intel.com" <alan@linux.intel.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>

On 12/10/2012 01:34 PM, Rickard ANDERSSON wrote:
> Add power management function to tty driver interface
> and add implementation for serial core.
>
> Signed-off-by: Rickard Andersson<rickard.andersson@stericsson.com>
> ---
>   drivers/tty/serial/serial_core.c | 10 ++++++++++
>   include/linux/tty_driver.h       |  8 ++++++++
>   2 files changed, 18 insertions(+)
>
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index b2fc8d7..3597dc8 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1114,6 +1114,15 @@ static int uart_get_icount(struct tty_struct *tty,
>   	return 0;
>   }
>
> +static int uart_pm(struct tty_struct *tty, enum tty_pm_state state)
> +{
> +	struct uart_state *ustate = tty->driver_data;
> +
> +	uart_change_pm(ustate, state);
I just realized that I should hold "port->mutex" while calling 
uart_change_pm(..).

I am waiting for further comments on the patch set.

BR
Rickard

