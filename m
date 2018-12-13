From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [LKP] [tty] c96cf923a9:
 WARNING:possible_circular_locking_dependency_detected
Date: Thu, 13 Dec 2018 14:38:34 +0900
Message-ID: <20181213053834.GH4860@jagdpanzerIV>
References: <20181211091154.GL23332@shao2-debian>
 <b8a5b151-9eaa-b098-f24f-b17c1886f456@suse.cz>
 <2780774e-b397-dcc2-6950-cccb527d5014@arista.com>
 <20181212034252.GD431@jagdpanzerIV>
 <20181212090751.GU5289@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181212090751.GU5289@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Dmitry Safonov <dima@arista.com>, Jiri Slaby <jslaby@suse.cz>, kernel test robot <rong.a.chen@intel.com>, lkp@01.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikulas Patocka <mpatocka@redhat.com>, LKML <linux-kernel@vger.kernel.org>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Waiman Long <longman@redhat.com>
List-Id: linux-serial@vger.kernel.org

On (12/12/18 10:07), Peter Zijlstra wrote:
> > +	uart_port_lock(state, flags);
> > +	xmit_buf = state->xmit.buf;
> > +	state->xmit.buf = NULL;
> > +	uart_port_unlock(uport, flags);
> > +
> >  	/*
> >  	 * Free the transmit buffer page.
> >  	 */
> > -	uart_port_lock(state, flags);
> > -	if (state->xmit.buf) {
> > -		free_page((unsigned long)state->xmit.buf);
> > -		state->xmit.buf = NULL;
> > -	}
> > -	uart_port_unlock(uport, flags);
> > +	if (xmit_buf)
> > +		free_page((unsigned long)xmit_buf);
> >  }
> 
> That looks sensible anyhow. One should strive to not do alloc or free
> under locks as much as possible anyway.

Right, good point.

	-ss
