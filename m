From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH] tty: serial_core: Spelling correction
Date: Thu, 21 Mar 2019 19:56:02 -0500
Message-ID: <eb1c40a0-8c71-99a8-e654-de2b62ca6c4b@embeddedor.com>
References: <20190322003827.GA30643@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322003827.GA30643@hari-Inspiron-1545>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>, gregkh@linuxfoundation.org, jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org



On 3/21/19 7:38 PM, Hariprasad Kelam wrote:
> fix warning reported by checkpatch tool
> 

It is much better if you explicitly mention what exactly you are fixing,
e.g. fix spelling mistake "overriden" -> "overridden"

It makes it easier for people to review your changes and give you
feedback.

Cultivate this practice and people will appreciate it. :)

Thanks
--
Gustavo

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
