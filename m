From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Wed, 12 Dec 2018 12:42:52 +0900
Message-ID: <20181212034252.GD431@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Safonov <dima@arista.com>
Cc: Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Peter Zijlstra <peterz@infradead.org>, Waiman Long <longman@redhat.com>
List-Id: linux-serial@vger.kernel.org

Hi,

Cc-ing Peter, Waiman


Hmm, so, how it looks to me

On (12/11/18 20:59), Dmitry Safonov wrote:
> >> [   87.218483] -> #2 (&port_lock_key){-.-.}:
> >> [   87.219282]        lock_acquire+0x28c/0x2e7
> >> [   87.219901]        _raw_spin_lock_irqsave+0x35/0x49
> >> [   87.220601]        serial8250_console_write+0x110/0x5b5
> >> [   87.221354]        univ8250_console_write+0x5f/0x64
> >> [   87.222056]        console_unlock+0x61c/0x7cf
> >> [   87.222680]        register_console+0x63a/0x7b0
> >> [   87.223345]        univ8250_console_init+0x1e/0x28
> >> [   87.224041]        console_init+0x3be/0x57e
> >> [   87.224641]        start_kernel+0x441/0x6c6
> >> [   87.225246]        x86_64_start_reservations+0x29/0x2b
> >> [   87.225979]        x86_64_start_kernel+0x6f/0x72
> >> [   87.226637]        secondary_startup_64+0xa4/0xb0

console_sem -> uart_port->lock

> >> [   87.227314] -> #1 (console_owner){-...}:
> >> [   87.228127]        lock_acquire+0x28c/0x2e7
> >> [   87.228728]        console_unlock+0x424/0x7cf
> >> [   87.229363]        vprintk_emit+0x22d/0x252
> >> [   87.229969]        vprintk_default+0x18/0x1a
> >> [   87.230576]        vprintk_func+0xa9/0xab
> >> [   87.231156]        printk+0x97/0xbe
> >> [   87.231659]        __debug_object_init+0x8db/0x92d
> >> [   87.232349]        debug_object_init+0x14/0x17
> >> [   87.232987]        __init_work+0x1b/0x1d
> >> [   87.233551]        rhashtable_init+0x53b/0x602
> >> [   87.234192]        rhltable_init+0xe/0x41
> >> [   87.234772]        test_insert_dup+0xac/0xa94
> >> [   87.235467]        test_rht_init+0x387/0x79c
> >> [   87.236222]        do_one_initcall+0x23c/0x4af
> >> [   87.236869]        kernel_init_freeable+0x5ec/0x69f
> >> [   87.237855]        kernel_init+0xc/0x100
> >> [   87.238470]        ret_from_fork+0x3a/0x50

db->lock -> console_sem -> uart_port->lock

   obj_hash[i].lock
   /* db->lock */
    __debug_object_init()
      debug_print_object()
       printk()
        spin_lock_irqsave(uart->port_lock)

BTW, there is a patch from Waiman which moves debug_print_object()
out of db->lock scope [1].

> >> [   87.239071] -> #0 (&obj_hash[i].lock){-.-.}:
> >> [   87.239904]        __lock_acquire+0x1f78/0x22d1
> >> [   87.240556]        lock_acquire+0x28c/0x2e7
> >> [   87.241173]        _raw_spin_lock_irqsave+0x35/0x49
> >> [   87.241882]        debug_check_no_obj_freed+0xb4/0x302
> >> [   87.242620]        free_unref_page_prepare+0x33a/0x483
> >> [   87.243368]        free_unref_page+0x48/0x80
> >> [   87.243991]        __free_pages+0x2e/0x40
> >> [   87.244611]        free_pages+0x54/0x5a
> >> [   87.245188]        uart_shutdown+0x3df/0x4e2
> >> [   87.245817]        uart_hangup+0x123/0x280
> >> [   87.246406]        __tty_hangup+0x4da/0x50f
> >> [   87.247025]        tty_vhangup_session+0xe/0x10
> >> [   87.247680]        disassociate_ctty+0xeb/0x5c5
> >> [   87.248349]        do_exit+0xc97/0x1daf
> >> [   87.248920]        __x64_sys_exit_group+0x0/0x3e
> >> [   87.249587]        __wake_up_parent+0x0/0x52
> >> [   87.250211]        do_syscall_64+0x5e8/0x881
> >> [   87.250839]        entry_SYSCALL_64_after_hwframe+0x49/0xbe

But I think what really makes lockdep nervous is this thing:

	uart_shutdown()
	 uart_port_lock()  //  spin_lock_irqsave(uart_port->lock)
	  free_page()
	   debug_check_no_obj_freed()
	    db->lock
	     debug_print_object()
	      printk()
	       spin_lock_irqsave(uart_port->lock)


Lockdep complains about:   uart_port->lock -> db->lock

It knows that we already have the reverse chain: db->lock -> uart_port->lock
From
	db->lock -> debug_print_object() -> printk() -> console_sem -> uart_port->lock


> >> [   87.255156]        CPU0                    CPU1
> >> [   87.255813]        ----                    ----
> >> [   87.256460]   lock(&port_lock_key);
> >> [   87.256973]                                lock(console_owner);
> >> [   87.257829]                                lock(&port_lock_key);
> >> [   87.258680]   lock(&obj_hash[i].lock);


So it's like

	CPU0					CPU1

	uart_shutdown()				db->lock
	 uart_port->lock			 debug_print_object()
	  free_page()				  printk
	   debug_check_no_obj_freed		   uart_port->lock
	    db->lock


In this particular case we probably can just move free_page()
out of uart_port lock scope. Note that free_page()->MM can printk()
on its own.


Something like this (not tested):

---

 drivers/tty/serial/serial_core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c439a5a1e6c0..64050f506348 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -268,6 +268,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	struct uart_port *uport = uart_port_check(state);
 	struct tty_port *port = &state->port;
 	unsigned long flags = 0;
+	char *xmit_buf = NULL;
 
 	/*
 	 * Set the TTY IO error marker
@@ -297,15 +298,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
 	 */
 	tty_port_set_suspended(port, 0);
 
+	uart_port_lock(state, flags);
+	xmit_buf = state->xmit.buf;
+	state->xmit.buf = NULL;
+	uart_port_unlock(uport, flags);
+
 	/*
 	 * Free the transmit buffer page.
 	 */
-	uart_port_lock(state, flags);
-	if (state->xmit.buf) {
-		free_page((unsigned long)state->xmit.buf);
-		state->xmit.buf = NULL;
-	}
-	uart_port_unlock(uport, flags);
+	if (xmit_buf)
+		free_page((unsigned long)xmit_buf);
 }
 
 /**

---

Can send a formal patch, if it works for you guys.

[1] https://lore.kernel.org/lkml/1542653726-5655-8-git-send-email-longman@redhat.com/T/#u

	-ss
