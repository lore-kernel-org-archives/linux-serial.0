From: Shreyas Bethur <shreyas.bethur@ni.com>
Subject: Re: [PATCH v2] tty: Prevent hw state corruption in exclusive mode reopen
Date: Wed, 7 Jan 2015 16:55:01 -0600
Message-ID: <OFE11B8E2C.C7D29A8E-ON86257DC6.007DA974-86257DC6.007DE311@ni.com>
References: <1419942873-6779-1-git-send-email-peter@hurleysoftware.com> <1419953965-16494-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419953965-16494-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Peter Hurley <peter@hurleysoftware.com> wrote on 12/30/2014 09:39:25 AM:

> From: Peter Hurley <peter@hurleysoftware.com>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
> Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, 
> linux-serial@vger.kernel.org, Shreyas Bethur 
> <shreyas.bethur@ni.com>, Peter Hurley <peter@hurleysoftware.com>
> Date: 12/30/2014 09:39 AM
> Subject: [PATCH v2] tty: Prevent hw state corruption in exclusive mode 
reopen
> 
> Exclusive mode ttys (TTY_EXCLUSIVE) do not allow further reopens;
> fail the condition before associating the file pointer and calling
> the driver open() method.
> 
> Prevents DTR programming when the tty is already in exclusive mode.
> 
> Reported-by: Shreyas Bethur <shreyas.bethur@ni.com>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/tty/tty_io.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> index 4f35b43..51f066a 100644
> --- a/drivers/tty/tty_io.c
> +++ b/drivers/tty/tty_io.c
> @@ -1464,6 +1464,9 @@ static int tty_reopen(struct tty_struct *tty)
>         driver->subtype == PTY_TYPE_MASTER)
>        return -EIO;
> 
> +   if (test_bit(TTY_EXCLUSIVE, &tty->flags) && !capable(CAP_SYS_ADMIN))
> +      return -EBUSY;
> +
>     tty->count++;
> 
>     WARN_ON(!tty->ldisc);
> @@ -2106,10 +2109,6 @@ retry_open:
>        retval = -ENODEV;
>     filp->f_flags = saved_flags;
> 
> -   if (!retval && test_bit(TTY_EXCLUSIVE, &tty->flags) &&
> -                  !capable(CAP_SYS_ADMIN))
> -      retval = -EBUSY;
> -
>     if (retval) {
>  #ifdef TTY_DEBUG_HANGUP
>        printk(KERN_DEBUG "%s: error %d in opening %s...\n", __func__,
> -- 
> 2.2.1
> 

Acked-by: Shreyas Bethur <shreyas.bethur@ni.com>
