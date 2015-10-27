From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 06/15] serial/men_z135_uart: Deinline men_z135_reg_clr,
 save 176 bytes
Date: Tue, 27 Oct 2015 14:55:22 -0400
Message-ID: <562FC89A.50703@hurleysoftware.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
 <1445968007-12616-7-git-send-email-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-7-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/27/2015 01:46 PM, Denys Vlasenko wrote:
> This function compiles to 98 bytes of machine code.

This looks ok because these function are heavyweight.

You'll want to add men_z135_reg_set() to this patch
as well, and please cc the driver author:

	Johannes Thumshirn <johannes.thumshirn@men.de>

Regards,
Peter Hurley


> Signed-off-by: Denys Vlasenko <dvlasenk@redhat.com>
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> CC: Peter Hurley <peter@hurleysoftware.com>
> CC: Jiri Slaby <jslaby@suse.com>
> CC: linux-serial@vger.kernel.org
> ---
>  drivers/tty/serial/men_z135_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
> index b90e7b3..2b5b66f 100644
> --- a/drivers/tty/serial/men_z135_uart.c
> +++ b/drivers/tty/serial/men_z135_uart.c
> @@ -159,7 +159,7 @@ static inline void men_z135_reg_set(struct men_z135_port *uart,
>   * @addr: Register address
>   * @val: value to clear
>   */
> -static inline void men_z135_reg_clr(struct men_z135_port *uart,
> +static void men_z135_reg_clr(struct men_z135_port *uart,
>  				u32 addr, u32 val)
>  {
>  	struct uart_port *port = &uart->port;
> 
