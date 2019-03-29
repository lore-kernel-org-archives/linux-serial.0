From: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH v2] tty/serial: Add a serial port simulator
Date: Fri, 29 Mar 2019 17:13:49 -0500
Message-ID: <20190329221349.GG31733@minyard.net>
References: <20190305171231.22133-1-minyard@acm.org>
 <20190327154439.GA18500@kroah.com>
Reply-To: cminyard@mvista.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190327154439.GA18500@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: minyard@acm.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Mar 28, 2019 at 12:44:39AM +0900, Greg Kroah-Hartman wrote:
> On Tue, Mar 05, 2019 at 11:12:31AM -0600, minyard@acm.org wrote:
> > From: Corey Minyard <cminyard@mvista.com>
> > 
> > This creates simulated serial ports, both as echo devices and pipe
> > devices.  The driver reasonably approximates the serial port speed
> > and simulates some modem control lines.  It allows error injection
> > and direct control of modem control lines.
> 
> I like this, thanks for doing it!

Hopefully this is useful for others.  I guess you could test the
kernel serial code with it, too.

> 
> Minor nits below:

Deleted and made the changes I agreed with or understood.  Other
comment below...

> > +
> > +#define circ_sbuf_space(buf) CIRC_SPACE((buf)->head, (buf)->tail, \
> > +					SERIALSIM_XBUFSIZE)
> > +#define circ_sbuf_empty(buf) ((buf)->head == (buf)->tail)
> > +#define circ_sbuf_next(idx) (((idx) + 1) % SERIALSIM_XBUFSIZE)
> 
> Don't we have a ring buffer (or 3) structure already?  Did you create
> another one?

I'm using circ_buf, same as the main serial code, these are just helpers.
Is there something else I can use?  The only ring buffer I saw that was
named that was for tracing, and that really wouldn't work.

> 
> > +static void serialsim_thread_delay(void)
> > +{
> > +#ifdef CONFIG_HIGH_RES_TIMERS
> > +	ktime_t timeout;
> > +
> > +	timeout = ns_to_ktime(1000000000 / SERIALSIM_WAKES_PER_SEC);
> > +	set_current_state(TASK_INTERRUPTIBLE);
> > +	schedule_hrtimeout(&timeout, HRTIMER_MODE_REL);
> > +#else
> > +	schedule_timeout_interruptible(1);
> > +#endif
> > +}
> 
> Why do you care about hires timers here?  Why not always just sleep to
> slow things down?

It makes things smoother, otherwise you get no data for a while then
big bursts of data at higher speeds.

> 
> > +
> > +static int serialsim_thread(void *data)
> > +{
> > +	struct serialsim_intf *intf = data;
> > +	struct serialsim_intf *ointf = intf->ointf;
> > +	struct uart_port *port = &intf->port;
> > +	struct uart_port *oport = &ointf->port;
> > +	struct circ_buf *tbuf = &intf->buf;
> > +	unsigned int residual = 0;
> > +
> > +	while (!kthread_should_stop()) {
> 
> Aren't we trying to get away from creating new kthreads?
> 
> Can you just use a workqueue entry?

The purpose of this is to wait short periods of time and copy characters
from one serial port to the other.  I'm not sure how a work queue would
do that.  I could drive it from timers, would that be better?  I don't
need something that runs in thread context.

Either way, it's not a terribly efficient mechanism, but that wasn't
a big concern for this, I don't think.

> 
> > +static unsigned int nr_echo_ports = 4;
> > +module_param(nr_echo_ports, uint, 0444);
> > +MODULE_PARM_DESC(nr_echo_ports,
> > +		 "The number of echo ports to create.  Defaults to 4");
> > +
> > +static unsigned int nr_pipe_ports = 4;
> > +module_param(nr_pipe_ports, uint, 0444);
> > +MODULE_PARM_DESC(nr_pipe_ports,
> > +		 "The number of pipe ports to create.  Defaults to 4");
> 
> No way to just do this with configfs and not worry about module params?

I'll look.  Module parameters seem a lot simpler, though.  I could also
just make it not configurable.

> 
> > +static char *gettok(char **s)
> > +{
> > +	char *t = skip_spaces(*s);
> > +	char *p = t;
> > +
> > +	while (*p && !isspace(*p))
> > +		p++;
> > +	if (*p)
> > +		*p++ = '\0';
> > +	*s = p;
> > +
> > +	return t;
> > +}
> 
> We don't have this already in the tree?

There is strsep(), but there's no way to do isspace() on it.  I don't
see a set of space characters anyplace.

> 
> > +static bool tokeq(const char *t, const char *m)
> > +{
> > +	return strcmp(t, m) == 0;
> > +}
> 
> same here.

There is sysfs_streq(), but it's not quite the same.  I didn't see
anything else.

> 
> > +
> > +static unsigned int parse_modem_line(char op, unsigned int flag,
> > +				     unsigned int *mctrl)
> > +{
> > +	if (op == '+')
> > +		*mctrl |= flag;
> > +	else
> > +		*mctrl &= ~flag;
> > +	return flag;
> > +}
> > +
> > +static void serialsim_ctrl_append(char **val, int *left, char *n, bool enabled)
> > +{
> > +	int count;
> > +
> > +	count = snprintf(*val, *left, " %c%s", enabled ? '+' : '-', n);
> > +	*left -= count;
> > +	*val += count;
> > +}
> 
> sysfs files really should only be "one value per file", so this api is
> troubling :(

Yeah, it is.  I wanted something that was easy for scripts to parse.
More on this below...

> 
> This worries me, parsing sysfs files is ripe for problems.  configfs
> might be better here.

Maybe so, but wouldn't you still have to do parsing?

I could separate these out into individual items (dtr, dsr, etc.).  You
wouldn't be able to get an atomic view of the modem lines, though.

On the whole sysfs thing, I'm not currently using the sysfs interface
for my testing, but I thought I would use it from scripts.  It would
still be better for scripts, but perhaps it's better to just pull the
whole sysfs part.

> 
> > +
> > +static DEVICE_ATTR(ctrl, 0660, serialsim_ctrl_read, serialsim_ctrl_write);
> 
> DEVICE_ATTR_RW()?

Doesn't take show or store functions.

> > +
> > +#define TIOCSERSREMNULLMODEM	0x54e4
> > +#define TIOCSERSREMMCTRL	0x54e5
> > +#define TIOCSERSREMERR		0x54e6
> > +#ifdef TCGETS2
> > +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios2)
> > +#else
> > +#define TIOCSERGREMTERMIOS	_IOR('T', 0xe7, struct termios)
> > +#endif
> > +#define TIOCSERGREMNULLMODEM	_IOR('T', 0xe8, int)
> > +#define TIOCSERGREMMCTRL	_IOR('T', 0xe9, unsigned int)
> > +#define TIOCSERGREMERR		_IOR('T', 0xea, unsigned int)
> > +#define TIOCSERGREMRS485	_IOR('T', 0xeb, struct serial_rs485)
> 
> Wait, don't we have ioctls for these things in the tty layer already?
> WHy add new ones?

These are for getting and setting the remote end's modem control 
lines.  I'm not sure how I could do that with the same ioctls.

-corey
