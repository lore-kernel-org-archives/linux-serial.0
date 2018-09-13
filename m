From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH] tty: max3100: Fix oops while 'cat
 /proc/tty/driver/ttyMAX'
Date: Thu, 13 Sep 2018 07:33:46 +0200
Message-ID: <c2c4a6e5-2c5b-7c7c-1390-146186e7e1b3@suse.cz>
References: <201809131038370132780@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201809131038370132780@zte.com.cn>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: chen.lin5@zte.com.cn, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/13/2018, 04:38 AM, chen.lin5@zte.com.cn wrote:
> Before wq 's->workqueue' be initialized in function 'max3100_startup',
> 
> 'cat /proc/tty/driver/ttyMAX' will cause oops.
> 
> 
> Oops: Kernel access of bad area, sig: 11 [#1]
> 
> ...
> 
> NIP [c0049070] __queue_work+0x24/0x268
> 
> LR [c0049308] queue_work_on+0x54/0x70
> 
> Call Trace:
> 
> [db44dba0] [c0049308] queue_work_on+0x54/0x70
> 
> [db44dbb0] [c036befc] max3100_get_mctrl+0x18/0x40
> 
> [db44dbc0] [c03614a4] uart_proc_show+0xfc/0x448
> 
> [db44dc40] [c0111aa8] seq_read+0x198/0x514
> 
> [db44dc90] [c01436e4] proc_reg_read+0x58/0x94
> 
> [db44dca0] [c00ee804] do_iter_read+0x190/0x1e0
> 
> [db44dcc0] [c00f0040] vfs_readv+0x58/0x7c
> 
> [db44dd40] [c011a2f4] default_file_splice_read+0x160/0x27c
> 
> [db44de30] [c0119f74] splice_direct_to_actor+0xec/0x23c
> 
> [db44de80] [c011a158] do_splice_direct+0x94/0xd0
> 
> [db44dec0] [c00eeee8] do_sendfile+0x1e0/0x380
> 
> [db44df10] [c00f0424] sys_sendfile64+0xc0/0xd4
> 
> [db44df40] [c000e260] ret_from_syscall+0x0/0x3c
> 
> 
> Signed-off-by: Chen Lin <chen.lin5@zte.com.cn>
> 
> ---
> 
>  drivers/tty/serial/max3100.c | 3 ++-
> 
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
> 
> index 371569a..0429c2d 100644
> 
> --- a/drivers/tty/serial/max3100.c
> 
> +++ b/drivers/tty/serial/max3100.c
> 
> @@ -391,7 +391,8 @@ static unsigned int max3100_get_mctrl(struct
> uart_port *port)
> 
>         dev_dbg(&s->spi->dev, "%s\n", __func__);
> 
> 
>         /* may not be truly up-to-date */
> 
> -       max3100_dowork(s);
> 
> +       if (s->workqueue)
> 
> +               max3100_dowork(s);

This does not look right in the sense of races (shutdown can kill the
workqueue right after the if. Or even before the if, as s->workqueue =
NULL is only after destroy_workqueue in max3100_shutdown).

If get_mctrl needs the queue, it shall not be created and destroyed ad hoc.

>         /* always assert DCD and DSR since these lines are not wired */
> 
>         return (s->cts ? TIOCM_CTS : 0) | TIOCM_DSR | TIOCM_CAR;
> 
>  }

thanks,
-- 
js
suse labs
