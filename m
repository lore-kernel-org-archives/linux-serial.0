From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Tue, 28 Mar 2017 11:04:04 +0900
Message-ID: <20170328020404.GA10573@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
 <20170327141432.GH2846@pathway.suse.cz>
 <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (03/27/17 19:28), Aleksey Makarov wrote:
[..]
> > > +			/*
> > > +			 * Maintain an invariant that will help to find if
> > > +			 * the matching console is preferred, see
> > > +			 * register_console():
> > > +			 *
> > > +			 * The last non-braille console is always
> > > +			 * the preferred one.
> > > +			 */
> > > +			for (last = MAX_CMDLINECONSOLES - 1;
> > > +			     last >= 0 && !console_cmdline[last].name[0];
> > > +			     last--)
> > > +				;
> > 
> > This is a rather non-trivial code to find the last element.
> > I might make sense to count it in a global variable.
> > Then we might remove the check for console_cmdline[i].name[0]
> > also in the other for cycles and make them better readable.
> 
> Having an additional variable console_cmdline_last pointing to the last element
> would require maintaining consistency between this variable and
> contents of console_cmdline.  For the code we have it is not hard, but when code
> is changed we need to check this.  Also there exists preferred_console that
> has almost the same meaning but it points not to the last element, but to the
> last non-braille element.  Also we need to have a special value (-1) for this
> variable for empty array. So I personally would instead try to rewrite this:
> 
> 	for (last = MAX_CMDLINECONSOLES - 1; last >= 0; last--)
> 		if (console_cmdline[last].name[0])
> 			break;
> 
> Is it better?  If not, I will send a version with console_cmdline_last.

personally I'm fine with the nested loop. the latest version
	"for (last = MAX_CMDLINECONSOLES - 1; last >= 0;..."

is even easier to read.


so we do not just iterate console_cmdline anymore, but also modify it.
this, probably, has impact on the following scenario

CPU0						CPU1

add_preferred_console()			add_preferred_console()
  __add_preferred_console()		  __add_preferred_console()
      swap(i1, last)			    swap(i2, last)

	temp1 = i1
	i1 = last				temp2 = i2
	last = temp1				i2 = last
						last = temp2

so both i1 and i2 will point to 'last' now, IOW, we will have two
identical entries in console_cmdline, while i1 or i2 will be lost.


neither add_preferred_console() nor __add_preferred_console() have any
serialization. and I assume that we can call add_preferred_console()
concurrently, can't we?

	-ss
