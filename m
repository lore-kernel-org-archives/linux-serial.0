From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] serial: samsung: Fix compile error with
 SERIAL_SAMSUNG_DEBUG
Date: Sat, 14 Jun 2014 13:33:56 -0700
Message-ID: <1402778036.2756.24.camel@joe-AO725>
References: <1402776434-31613-1-git-send-email-cengelma@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402776434-31613-1-git-send-email-cengelma@gmx.at>
Sender: linux-kernel-owner@vger.kernel.org
To: Christian Engelmayer <cengelma@gmx.at>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Jingoo Han <jg1.han@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Greg?  Can you please apply this soon?

Thanks.

On Sat, 2014-06-14 at 22:07 +0200, Christian Engelmayer wrote:
> Commit e4ac92d (serial: samsung: Neaten dbg uses) contains a typo in the
> changed dbg() function regarding the name of the used character buffer.
> This breaks the build if actually compiled with CONFIG_SERIAL_SAMSUNG_DEBUG.
> 
> Signed-off-by: Christian Engelmayer <cengelma@gmx.at>
> ---
> Compile tested. Applies against branch tty-next in tree
> git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
> ---
>  drivers/tty/serial/samsung.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index 3293377..c1d3ebd 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -66,7 +66,7 @@ static void dbg(const char *fmt, ...)
>  	char buff[256];
>  
>  	va_start(va, fmt);
> -	vscnprintf(buff, sizeof(buf), fmt, va);
> +	vscnprintf(buff, sizeof(buff), fmt, va);
>  	va_end(va);
>  
>  	printascii(buff);
