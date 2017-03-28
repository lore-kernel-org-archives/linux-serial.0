From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Tue, 28 Mar 2017 14:56:57 +0200
Message-ID: <20170328125657.GJ2846@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
 <20170327141432.GH2846@pathway.suse.cz>
 <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
 <20170328020404.GA10573@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170328020404.GA10573@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Tue 2017-03-28 11:04:04, Sergey Senozhatsky wrote:
> On (03/27/17 19:28), Aleksey Makarov wrote:
> [..]
> > > > +			/*
> > > > +			 * Maintain an invariant that will help to find if
> > > > +			 * the matching console is preferred, see
> > > > +			 * register_console():
> > > > +			 *
> > > > +			 * The last non-braille console is always
> > > > +			 * the preferred one.
> > > > +			 */
> > > > +			for (last = MAX_CMDLINECONSOLES - 1;
> > > > +			     last >= 0 && !console_cmdline[last].name[0];
> > > > +			     last--)
> > > > +				;
> > > 
> > > This is a rather non-trivial code to find the last element.
> > > I might make sense to count it in a global variable.
> > > Then we might remove the check for console_cmdline[i].name[0]
> > > also in the other for cycles and make them better readable.
> > 
> > Having an additional variable console_cmdline_last pointing to the last element
> > would require maintaining consistency between this variable and
> > contents of console_cmdline.  For the code we have it is not hard, but when code
> > is changed we need to check this.  Also there exists preferred_console that
> > has almost the same meaning but it points not to the last element, but to the
> > last non-braille element.  Also we need to have a special value (-1) for this
> > variable for empty array. So I personally would instead try to rewrite this:
> > 
> > 	for (last = MAX_CMDLINECONSOLES - 1; last >= 0; last--)
> > 		if (console_cmdline[last].name[0])
> > 			break;
> > 
> > Is it better?  If not, I will send a version with console_cmdline_last.
> 
> personally I'm fine with the nested loop. the latest version
> 	"for (last = MAX_CMDLINECONSOLES - 1; last >= 0;..."
> 
> is even easier to read.

The number of elements is bumped on a single location, so there
is not much to synchronize. The old approach was fine because
the for cycles were needed anyway, they started on the 0th element,
and NULL ended arrays are rather common practice.

But we are searching the array from the end now. Also we use the
for cycle just to get the number here. This is not a common
practice and it makes the code more complicated and strange from
my point of view.

If you do not like -1, you could use console_cmdline_cnt and
start with 0. I would actually do so because it is a common
approach and easy to understand.

> 
> so we do not just iterate console_cmdline anymore, but also modify it.
> this, probably, has impact on the following scenario
> 
> CPU0						CPU1
> 
> add_preferred_console()			add_preferred_console()
>   __add_preferred_console()		  __add_preferred_console()
>       swap(i1, last)			    swap(i2, last)
> 
> 	temp1 = i1
> 	i1 = last				temp2 = i2
> 	last = temp1				i2 = last
> 						last = temp2
> 
> so both i1 and i2 will point to 'last' now, IOW, we will have two
> identical entries in console_cmdline, while i1 or i2 will be lost.
> 
> 
> neither add_preferred_console() nor __add_preferred_console() have any
> serialization. and I assume that we can call add_preferred_console()
> concurrently, can't we?

Very good point!

Well, if this race exists, it was racy even before. Of course,
the old race was only when new entry was added. It would
be more visible now because also shuffling would be racy.

OK, most add_preferred_console() calls are in functions
that are defined as console_initcall(). They seem to
be defined only when the respective drivers are built in.
It seems that these initcalls are serialized, see console_init().

add_preferred_console() is used also in uart_add_one_port():

   -> uart_add_one_port()
    -> of_console_check()
     -> add_preferred_console()

But there the calls are synchronized as well via
port_mutex.

Finally, __add_preferred_console() is called also from
console_setup(). It is called via do_early_param()
even before the console_initcall() functions. It is
serialized as well.

If I did not miss anything, it would seem that
__add_preferred_console() are called synchronously
and only during boot by design.

Best Regards,
Petr
