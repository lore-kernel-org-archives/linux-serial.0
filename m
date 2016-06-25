From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [patch V4 27/31] serial: use parity32 in max3100
Date: Sat, 25 Jun 2016 10:25:00 -0700
Message-ID: <20160625172500.GA18790@kroah.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
 <1462958587-25987-1-git-send-email-zengzhaoxiu@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462958587-25987-1-git-send-email-zengzhaoxiu@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zengzhaoxiu@163.com
Cc: linux-kernel@vger.kernel.org, Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, May 11, 2016 at 05:23:07PM +0800, zengzhaoxiu@163.com wrote:
> From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> 
> Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/max3100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> index 5c4c280..a0cc84a 100644
> --- a/drivers/tty/serial/max3100.c
> +++ b/drivers/tty/serial/max3100.c
> @@ -155,7 +155,7 @@ static int max3100_do_parity(struct max3100_port *s, u16 c)
>  	else
>  		c &= 0xff;
>  
> -	parity = parity ^ (hweight8(c) & 1);
> +	parity ^= parity8(c);

Your subject does not match the patch, and there is no changelog text so
I can't take it :(

Please fix up.

greg k-h
