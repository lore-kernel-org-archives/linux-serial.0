From: Greg Ungerer <gerg@snapgear.com>
Subject: Re: [PATCH 09/76] 68328serial: remove unsed m68k_serial->tqueue_hangup
Date: Thu, 17 Mar 2011 08:41:22 +1000
Message-ID: <4D813C92.1060303@snapgear.com>
References: <20110316205746.GA2938@kroah.com> <1300309966-5745-1-git-send-email-gregkh@suse.de> <1300309966-5745-9-git-send-email-gregkh@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from sncsmrelay2.nai.com ([67.97.80.206]:46301 "EHLO
	sncsmrelay2.nai.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab1CPWqh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 18:46:37 -0400
In-Reply-To: <1300309966-5745-9-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@suse.de>
Cc: linux-serial@vger.kernel.org, Tejun Heo <tj@kernel.org>

On 17/03/11 07:11, Greg Kroah-Hartman wrote:
> From: Tejun Heo<tj@kernel.org>
>
> m68k_serial->tqueue_hangup is unused.  Remove it.
>
> Signed-off-by: Tejun Heo<tj@kernel.org>
> Cc: Greg Ungerer<gerg@uclinux.org>

Acked-by: Greg Ungerer <gerg@uclinux.org>


> Signed-off-by: Greg Kroah-Hartman<gregkh@suse.de>
> ---
>   drivers/tty/serial/68328serial.c |   23 -----------------------
>   drivers/tty/serial/68328serial.h |    1 -
>   2 files changed, 0 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/tty/serial/68328serial.c b/drivers/tty/serial/68328serial.c
> index be0ebce..a9d9985 100644
> --- a/drivers/tty/serial/68328serial.c
> +++ b/drivers/tty/serial/68328serial.c
> @@ -393,28 +393,6 @@ static void do_softint(struct work_struct *work)
>   #endif
>   }
>
> -/*
> - * This routine is called from the scheduler tqueue when the interrupt
> - * routine has signalled that a hangup has occurred.  The path of
> - * hangup processing is:
> - *
> - * 	serial interrupt routine ->  (scheduler tqueue) ->
> - * 	do_serial_hangup() ->  tty->hangup() ->  rs_hangup()
> - *
> - */
> -static void do_serial_hangup(struct work_struct *work)
> -{
> -	struct m68k_serial	*info = container_of(work, struct m68k_serial, tqueue_hangup);
> -	struct tty_struct	*tty;
> -	
> -	tty = info->port.tty;
> -	if (!tty)
> -		return;
> -
> -	tty_hangup(tty);
> -}
> -
> -
>   static int startup(struct m68k_serial * info)
>   {
>   	m68328_uart *uart =&uart_addr[info->line];
> @@ -1348,7 +1326,6 @@ rs68328_init(void)
>   	    info->count = 0;
>   	    info->blocked_open = 0;
>   	    INIT_WORK(&info->tqueue, do_softint);
> -	    INIT_WORK(&info->tqueue_hangup, do_serial_hangup);
>   	    init_waitqueue_head(&info->open_wait);
>   	    init_waitqueue_head(&info->close_wait);
>   	    info->line = i;
> diff --git a/drivers/tty/serial/68328serial.h b/drivers/tty/serial/68328serial.h
> index 664ceb0..8c9c3c0 100644
> --- a/drivers/tty/serial/68328serial.h
> +++ b/drivers/tty/serial/68328serial.h
> @@ -159,7 +159,6 @@ struct m68k_serial {
>   	int			xmit_tail;
>   	int			xmit_cnt;
>   	struct work_struct	tqueue;
> -	struct work_struct	tqueue_hangup;
>   	wait_queue_head_t	open_wait;
>   	wait_queue_head_t	close_wait;
>   };


-- 
------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
8 Gardner Close                             FAX:         +61 7 3217 5323
Milton, QLD, 4064, Australia                WEB: http://www.SnapGear.com
