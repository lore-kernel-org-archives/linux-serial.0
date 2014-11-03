From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 1/1] tty: Do not set modem lines when reopening ports
Date: Mon, 03 Nov 2014 18:13:13 -0500
Message-ID: <54580C09.7080901@hurleysoftware.com>
References: <OF6C85CA04.9FBB77C4-ON86257D82.007014C2-86257D82.0070E996@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout32.mail01.mtsvc.net ([216.70.64.70]:37073 "EHLO
	n23.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751243AbaKCXNP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Nov 2014 18:13:15 -0500
In-Reply-To: <OF6C85CA04.9FBB77C4-ON86257D82.007014C2-86257D82.0070E996@ni.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shreyas Bethur <shreyas.bethur@ni.com>, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, jslaby@suse.cz

Hi Shreyas,

On 10/31/2014 04:33 PM, Shreyas Bethur wrote:
> When tty port is opened, we will raise the DTR and RTS lines. But for
> second and subsequent opens, we should not modify these lines because the
> first session might be actively using these lines. We don't want a second
> open to interfere with the first session.
> 
> Signed-off-by: Shreyas Bethur <shreyas.bethur@ni.com>
> ---
> To give some background for this patch, we have a product that uses the
> DTR line on the serial port for synchronization with other devices. While
> the synchronization application is using the DTR line, if another process
> opens the same port, then DTR line is raised, and thus interferes with the
> synchronization application. So, if a port is open, subsequent opens
> should not modify any modem lines.

Would you please expand on your use-case?

Regards,
Peter Hurley

> This patch is my attempt to fix this issue. Please review my fix, and let
> me know what you folks think.
> ---
>  drivers/tty/tty_port.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 1b93357..8a6c80a 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -363,6 +363,7 @@ int tty_port_block_til_ready(struct tty_port *port,
>         int do_clocal = 0, retval;
>         unsigned long flags;
>         DEFINE_WAIT(wait);
> +       bool port_first_open = true;
> 
>         /* block if port is in the process of being closed */
>         if (port->flags & ASYNC_CLOSING) {
> @@ -381,8 +382,15 @@ int tty_port_block_til_ready(struct tty_port *port,
>                 return 0;
>         }
>         if (filp->f_flags & O_NONBLOCK) {
> -               /* Indicate we are open */
> -               if (tty->termios.c_cflag & CBAUD)
> +               /* The port lock protects the port counts */
> +               spin_lock_irqsave(&port->lock, flags);
> +               if (port->count > 1)
> +                       port_first_open = false;
> +               spin_unlock_irqrestore(&port->lock, flags);
> +
> +               /* Indicate we are open. Raise DTR and RTS only if opening 
> the
> +                  port for the first time */
> +               if ((tty->termios.c_cflag & CBAUD) && port_first_open)
>                         tty_port_raise_dtr_rts(port);
>                 port->flags |= ASYNC_NORMAL_ACTIVE;
>                 return 0;
> 

