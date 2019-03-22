From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] tty: serial_core: Spelling correction
Date: Thu, 21 Mar 2019 22:28:59 -0500
Message-ID: <918f4d7f-e066-b926-b73b-331843a3a388@embeddedor.com>
References: <20190322030159.GA6551@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322030159.GA6551@hari-Inspiron-1545>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 3/21/19 10:01 PM, Hariprasad Kelam wrote:
> fix spelling mistake "overriden" -> "overridden"
> This fix resolves warning reported by checkpatch tool
> 

Whenever you receive feedback on a patch, you need to version
the patches that you re-send. Also, you should mention what has
changed, so people know what to review.

I encourage you take a look at this:

https://kernelnewbies.org/Outreachyfirstpatch

Thanks
--
Gustavo

"If you receive feedback on a patch, and were asked to update the patch,
you need to version the patches that you re-send. A new version number
lets reviewers know you made changes to the patch, and they should review
it again."

> Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
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
