From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [v2] serial_core:recognize invalid pointer from userspace
Date: Wed, 9 Mar 2016 19:34:35 -0800
Message-ID: <20160310033435.GA28983@kroah.com>
References: <1457579843-29676-1-git-send-email-lu.jiang@windriver.com>
 <1457579843-29676-2-git-send-email-lu.jiang@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1457579843-29676-2-git-send-email-lu.jiang@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Lu <lu.jiang@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 10, 2016 at 11:17:23AM +0800, Jiang Lu wrote:
> compat_ioctl use 0xffffffff as a magic number to mark invalid pointer
> for iomem_base in serial_struct when truncating a 64bit pointer into
> 32bit.
> 
> Serial driver need recognize this invalid pointer when parsing
> serial_struct from userspace.
> 
> Signed-off-by: Jiang Lu <lu.jiang@windriver.com>
> ---
>  drivers/tty/serial/serial_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index a5d545e..d293536 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -745,6 +745,9 @@ static int uart_set_info(struct tty_struct *tty, struct tty_port *port,
>  	 * allocations, we should treat type changes the same as
>  	 * IO port changes.
>  	 */
> +	if ((unsigned long)new_info->iomem_base == 0xffffffff)
> +		new_info->iomem_base = (void *)(unsigned long)uport->mapbase;

This looks really odd to me, why do we care about userspace issues here?
Shouldn't the compat ioctl code have handled this already all for us?

And why set it to mapbase?  Just to keep it from being changed?

this worries me...

greg k-h
