From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 02/12] usb: fix sillies in the metro USB driver
Date: Sun, 24 Jun 2012 23:49:22 +0200
Message-ID: <4FE78B62.4090106@suse.cz>
References: <20120622153600.1405.15575.stgit@localhost.localdomain> <20120622153655.1405.21453.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120622153655.1405.21453.stgit@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>
List-Id: linux-serial@vger.kernel.org

On 06/22/2012 05:38 PM, Alan Cox wrote:
> Bits noticed doing the termios conversion
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/usb/serial/metro-usb.c |    8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/serial/metro-usb.c b/drivers/usb/serial/metro-usb.c
> index 81423f7..bad5f0c 100644
> --- a/drivers/usb/serial/metro-usb.c
> +++ b/drivers/usb/serial/metro-usb.c
> @@ -130,20 +130,14 @@ static void metrousb_read_int_callback(struct urb *urb)
...
>  	if (tty && urb->actual_length) {
>  		/* Loop through the data copying each byte to the tty layer. */
>  		tty_insert_flip_string(tty, data, urb->actual_length);
>  
>  		/* Force the data to the tty layer. */
>  		tty_flip_buffer_push(tty);
> +		tty_kref_put(tty);
>  	}
> -	tty_kref_put(tty);

This doesn't seem right. (Depends on whether tty is non-null iff
urb->actual_length is non-zero.)

thanks,
-- 
js
suse labs
