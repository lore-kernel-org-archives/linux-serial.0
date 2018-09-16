From: Jiri Slaby <jslaby@suse.cz>
Subject: =?UTF-8?B?UmU6IOetlOWkjTogUmU6IOetlOWkjTogUmU6IFtQQVRDSF0gdHR5OiBt?=
 =?UTF-8?Q?ax3100:_Fix_oops_while_'cat/proc/tty/driver/ttyMAX'?=
Date: Sun, 16 Sep 2018 10:09:51 +0200
Message-ID: <3fa25b44-d5e4-9b40-6a7d-e2ea4a35dca7@suse.cz>
References: <201809151014546700030@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201809151014546700030@zte.com.cn>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: chen.lin5@zte.com.cn
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 09/15/2018, 04:14 AM, chen.lin5@zte.com.cn wrote:
> yes, creation and destroy of the workqueue is not locked, I think
> maybe there is some
> 
> remainder work to do in destroy-wq, so I cannot sure if there is
> any usage about lock destroy-wq.
> 
> 
> What you worried of the races is about this  ?  
> 
>    --> when max3100_shutdown,  destroy_workqueue is doing, s->workqueue
> is not NULL, at this moment, get_mctrl is executed, destroying wq is
> queued again.
> 
> bu this cannot happen, becasue s->force_end_work = 1
> before destroy_workqueue  , so max3100_dowork do nothing.

Oh, so this relies on flush_workqueue or destroy_workqueue to be a
barrier (so that the assignment to end_work is not reordered), correct?

> static void max3100_shutdown(struct uart_port *port)
> 
> {
> 
> ...
> 
> s->force_end_work = 1;
> 
> 
> if (s->poll_time > 0)
> 
> del_timer_sync(&s->timer);
> 
> 
> if (s->workqueue) {
> 
> flush_workqueue(s->workqueue);
> 
> destroy_workqueue(s->workqueue);
> 
> s->workqueue = NULL;
> 
> }
> 
> 
> 
> static void max3100_dowork(struct max3100_port *s)
> 
> {
> 
> if (!s->force_end_work && !freezing(current) && !s->suspending)
> 
> queue_work(s->workqueue, &s->work);
> 
> }

Also, on the first open:
        s->force_end_work = 0;
        s->parity = 0;
        s->rts = 0;

        sprintf(b, "max3100-%d", s->minor);
        s->workqueue = create_freezable_workqueue(b);
        if (!s->workqueue) {
                dev_warn(&s->spi->dev, "cannot create workqueue\n");
                return -EBUSY;
        }

Here, s->force_end_work is 0, s->workqueue is non-NULL, but s->work is
garbage until:

        INIT_WORK(&s->work, max3100_work);


INIT_WORK should be in max3100_probe as far as I can see (or at least
before create_freezable_workqueue), right? But those variable
assignments also rely on some implicit barrier which is not there.

thanks,
-- 
js
suse labs
