From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: serial_core: Spelling correction
Date: Thu, 21 Mar 2019 06:20:58 +0100
Message-ID: <7222c039-5400-3767-e831-dc46d23cbb92@suse.cz>
References: <20190321035901.GA12851@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321035901.GA12851@hari-Inspiron-1545>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: hariprasadk <hari121920@gmail.com>, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 21. 03. 19, 4:59, hariprasadk wrote:
> fix warning reported by checkpatch tool
> 
> Signed-off-by: hariprasadk <hari1219@gmail.com>

Please use your real name as per
Documentation/process/submitting-patches.rst.

> ---
>  drivers/tty/serial/serial_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index 351843f..69f4871 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -1514,7 +1514,7 @@ static void uart_set_termios(struct tty_struct *tty,
>  	}
>  
>  	uart_change_speed(tty, state, old_termios);
> -	/* reload cflag from termios; port driver may have overriden flags */
> +	/* reload cflag from termios; port driver may have overridden flags */
>  	cflag = tty->termios.c_cflag;
>  
>  	/* Handle transition to B0 status */
> 

Otherwose looks good to me.

thanks,
-- 
js
suse labs
