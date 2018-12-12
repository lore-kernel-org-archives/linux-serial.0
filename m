From: Dmitry Safonov <dima@arista.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Wed, 12 Dec 2018 14:54:20 +0000
Message-ID: <137479ad-d38e-7d26-dae4-a4e721d69928@arista.com>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181212034252.GD431@jagdpanzerIV>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
List-Id: linux-serial@vger.kernel.org

Hi Sergey,

On 12/12/18 3:42 AM, Sergey Senozhatsky wrote:
[..]
> 
> db->lock -> console_sem -> uart_port->lock
> 
>    obj_hash[i].lock
>    /* db->lock */
>     __debug_object_init()
>       debug_print_object()
>        printk()
>         spin_lock_irqsave(uart->port_lock)
> 
> BTW, there is a patch from Waiman which moves debug_print_object()
> out of db->lock scope [1].

Thanks much for pointing this, didn't know about that and started to
write something like that yesterday :)

>>>> [   87.239071] -> #0 (&obj_hash[i].lock){-.-.}:
>>>> [   87.239904]        __lock_acquire+0x1f78/0x22d1
>>>> [   87.240556]        lock_acquire+0x28c/0x2e7
>>>> [   87.241173]        _raw_spin_lock_irqsave+0x35/0x49
>>>> [   87.241882]        debug_check_no_obj_freed+0xb4/0x302
>>>> [   87.242620]        free_unref_page_prepare+0x33a/0x483
>>>> [   87.243368]        free_unref_page+0x48/0x80
>>>> [   87.243991]        __free_pages+0x2e/0x40
>>>> [   87.244611]        free_pages+0x54/0x5a
>>>> [   87.245188]        uart_shutdown+0x3df/0x4e2
>>>> [   87.245817]        uart_hangup+0x123/0x280
>>>> [   87.246406]        __tty_hangup+0x4da/0x50f
>>>> [   87.247025]        tty_vhangup_session+0xe/0x10
>>>> [   87.247680]        disassociate_ctty+0xeb/0x5c5
>>>> [   87.248349]        do_exit+0xc97/0x1daf
>>>> [   87.248920]        __x64_sys_exit_group+0x0/0x3e
>>>> [   87.249587]        __wake_up_parent+0x0/0x52
>>>> [   87.250211]        do_syscall_64+0x5e8/0x881
>>>> [   87.250839]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
> 
> But I think what really makes lockdep nervous is this thing:
> 
> 	uart_shutdown()
> 	 uart_port_lock()  //  spin_lock_irqsave(uart_port->lock)
> 	  free_page()
> 	   debug_check_no_obj_freed()
> 	    db->lock
> 	     debug_print_object()
> 	      printk()
> 	       spin_lock_irqsave(uart_port->lock)
> 
> 
> Lockdep complains about:   uart_port->lock -> db->lock
> 
> It knows that we already have the reverse chain: db->lock -> uart_port->lock
> From
> 	db->lock -> debug_print_object() -> printk() -> console_sem -> uart_port->lock
> 
> 
>>>> [   87.255156]        CPU0                    CPU1
>>>> [   87.255813]        ----                    ----
>>>> [   87.256460]   lock(&port_lock_key);
>>>> [   87.256973]                                lock(console_owner);
>>>> [   87.257829]                                lock(&port_lock_key);
>>>> [   87.258680]   lock(&obj_hash[i].lock);
> 
> 
> So it's like
> 
> 	CPU0					CPU1
> 
> 	uart_shutdown()				db->lock
> 	 uart_port->lock			 debug_print_object()
> 	  free_page()				  printk
> 	   debug_check_no_obj_freed		   uart_port->lock
> 	    db->lock
> 
> 
> In this particular case we probably can just move free_page()
> out of uart_port lock scope. Note that free_page()->MM can printk()
> on its own.
> 
> 
> Something like this (not tested):

Looks good to me.
Probably, it's worth to update comment about freeing just to make sure
no one will "refactor"/"simplify" it some day.

Does it make sense to add this to your patch?

--->8---
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -205,10 +205,11 @@ static int uart_port_startup(struct tty_struct
*tty, struct uar>
        if (!state->xmit.buf) {
                state->xmit.buf = (unsigned char *) page;
                uart_circ_clear(&state->xmit);
+               uart_port_unlock(uport, flags);
        } else {
+               uart_port_unlock(uport, flags);
                free_page(page);
        }
-       uart_port_unlock(uport, flags);

        retval = uport->ops->startup(uport);
        if (retval == 0) {
-- 

Thanks,
          Dima
