From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Wed, 12 Dec 2018 10:07:51 +0100
Message-ID: <20181212090751.GU5289@hirez.programming.kicks-ass.net>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212034252.GD431@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 12, 2018 at 12:42:52PM +0900, Sergey Senozhatsky wrote:
> Something like this (not tested):
> 
> ---
> 
>  drivers/tty/serial/serial_core.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
> index c439a5a1e6c0..64050f506348 100644
> --- a/drivers/tty/serial/serial_core.c
> +++ b/drivers/tty/serial/serial_core.c
> @@ -268,6 +268,7 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	struct uart_port *uport = uart_port_check(state);
>  	struct tty_port *port = &state->port;
>  	unsigned long flags = 0;
> +	char *xmit_buf = NULL;
>  
>  	/*
>  	 * Set the TTY IO error marker
> @@ -297,15 +298,16 @@ static void uart_shutdown(struct tty_struct *tty, struct uart_state *state)
>  	 */
>  	tty_port_set_suspended(port, 0);
>  
> +	uart_port_lock(state, flags);
> +	xmit_buf = state->xmit.buf;
> +	state->xmit.buf = NULL;
> +	uart_port_unlock(uport, flags);
> +
>  	/*
>  	 * Free the transmit buffer page.
>  	 */
> -	uart_port_lock(state, flags);
> -	if (state->xmit.buf) {
> -		free_page((unsigned long)state->xmit.buf);
> -		state->xmit.buf = NULL;
> -	}
> -	uart_port_unlock(uport, flags);
> +	if (xmit_buf)
> +		free_page((unsigned long)xmit_buf);
>  }

That looks sensible anyhow. One should strive to not do alloc or free
under locks as much as possible anyway.
