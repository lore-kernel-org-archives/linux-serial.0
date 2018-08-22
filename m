From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] serial: mxs-auart: Fix potential infinite loop
Date: Wed, 22 Aug 2018 08:41:31 +0200
Message-ID: <20180822064131.2qy3ntri7rdypmfo@pengutronix.de>
References: <20180806164346.9986-1-vasilyev@ispras.ru>
 <20180807105905.18264-1-vasilyev@ispras.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180807105905.18264-1-vasilyev@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
To: Anton Vasilyev <vasilyev@ispras.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
List-Id: linux-serial@vger.kernel.org

On Tue, Aug 07, 2018 at 01:59:05PM +0300, Anton Vasilyev wrote:
> On the error path of mxs_auart_request_gpio_irq() is performed
> backward iterating with index i of enum type. Underline enum type
> may be unsigned char. In this case check (--i >= 0) will be always
> true and error handling goes into infinite loop.
> 
> The patch changes the check so that it is valid for signed and unsigned
> types.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> ---
> v2: mistype in patch as result of combination of different fixes.
> Change comment and leave enum type.
> ---
>  drivers/tty/serial/mxs-auart.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
> index 76aa289652f7..27235a526cce 100644
> --- a/drivers/tty/serial/mxs-auart.c
> +++ b/drivers/tty/serial/mxs-auart.c
> @@ -1634,8 +1634,9 @@ static int mxs_auart_request_gpio_irq(struct mxs_auart_port *s)
>  
>  	/*
>  	 * If something went wrong, rollback.
> +	 * Be careful: i may be unsigned.
>  	 */
> -	while (err && (--i >= 0))
> +	while (err && (i-- > 0))
>  		if (irq[i] >= 0)
>  			free_irq(irq[i], s);

I wouldn't have added the comment, but the code change is correct.

Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
