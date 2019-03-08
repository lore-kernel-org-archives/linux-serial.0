From: Petr Mladek <pmladek@suse.com>
Subject: Re: [RFC PATCH v1 19/25] printk: introduce emergency messages
Date: Fri, 8 Mar 2019 11:31:27 +0100
Message-ID: <20190308103127.txsgv3d6lqlf6pad@pathway.suse.cz>
References: <20190212143003.48446-1-john.ogness@linutronix.de>
 <20190212143003.48446-20-john.ogness@linutronix.de>
 <20190307073029.GA489@jagdpanzerIV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190307073029.GA489@jagdpanzerIV>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: John Ogness <john.ogness@linutronix.de>, linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, Daniel Wang <wonderfly@google.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.com>, Peter Feiner <pfeiner@google.com>, linux-serial@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2019-03-07 16:30:29, Sergey Senozhatsky wrote:
> On (02/12/19 15:29), John Ogness wrote:
> [..]
> > +static bool console_can_emergency(int level)
> > +{
> > +	struct console *con;
> > +
> > +	for_each_console(con) {
> > +		if (!(con->flags & CON_ENABLED))
> > +			continue;
> > +		if (con->write_atomic && level < emergency_console_loglevel)
> > +			return true;
> > +		if (con->write && (con->flags & CON_BOOT))
> > +			return true;
> > +	}
> > +	return false;
> > +}
> > +
> > +static void call_emergency_console_drivers(int level, const char *text,
> > +					   size_t text_len)
> > +{
> > +	struct console *con;
> > +
> > +	for_each_console(con) {
> > +		if (!(con->flags & CON_ENABLED))
> > +			continue;
> > +		if (con->write_atomic && level < emergency_console_loglevel) {
> > +			con->write_atomic(con, text, text_len);
> > +			continue;
> > +		}
> > +		if (con->write && (con->flags & CON_BOOT)) {
> > +			con->write(con, text, text_len);
> > +			continue;
> > +		}
> > +	}
> > +}
> > +
> > +static void printk_emergency(char *buffer, int level, u64 ts_nsec, u16 cpu,
> > +			     char *text, u16 text_len)
> > +{
> > +	struct printk_log msg;
> > +	size_t prefix_len;
> > +
> > +	if (!console_can_emergency(level))
> > +		return;
> > +
> > +	msg.level = level;
> > +	msg.ts_nsec = ts_nsec;
> > +	msg.cpu = cpu;
> > +	msg.facility = 0;
> > +
> > +	/* "text" must have PREFIX_MAX preceding bytes available */
> > +
> > +	prefix_len = print_prefix(&msg,
> > +				  console_msg_format & MSG_FORMAT_SYSLOG,
> > +				  printk_time, buffer);
> > +	/* move the prefix forward to the beginning of the message text */
> > +	text -= prefix_len;
> > +	memmove(text, buffer, prefix_len);
> > +	text_len += prefix_len;
> > +
> > +	text[text_len++] = '\n';
> > +
> > +	call_emergency_console_drivers(level, text, text_len);
> 
> So this iterates the console list and calls consoles' callbacks, but what
> prevents console driver to be rmmod-ed under us?
> 
> 	CPU0						CPU1
> 
> 	printk_emergency()				rmmod netcon
> 	 call_emergency_console_drivers()		
> 	  con_foo->flags & CON_ENABLED == 1
> 							unregister_console(con_foo)
> 							con_foo->flags &= ~CON_ENABLED
> 							__exit // con_foo gone ?
> 	  con_foo->write()
> 
> We use console_lock()/console_trylock() in order to protect the list and
> console drivers; but this brings scheduler to the picture, with all its
> locks.

Great catch!

I think that it is doable to guard the list using RCU.

Best Regards,
Petr
