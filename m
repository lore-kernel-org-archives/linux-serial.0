From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v8 3/3] printk: fix double printing with earlycon
Date: Tue, 4 Apr 2017 13:12:02 +0200
Message-ID: <20170404111202.GK29537@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170320100302.8656-1-aleksey.makarov@linaro.org>
 <20170327141432.GH2846@pathway.suse.cz>
 <4b561f81-67af-f6a3-76c9-d0d8499c52bd@linaro.org>
 <20170328020404.GA10573@jagdpanzerIV.localdomain>
 <20170328125657.GJ2846@pathway.suse.cz>
 <20170330055546.GD513@jagdpanzerIV.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170330055546.GD513@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Thu 2017-03-30 14:55:46, Sergey Senozhatsky wrote:
> On (03/28/17 14:56), Petr Mladek wrote:
> [..]
> > > > Is it better?  If not, I will send a version with console_cmdline_last.
> > > 
> > > personally I'm fine with the nested loop. the latest version
> > > 	"for (last = MAX_CMDLINECONSOLES - 1; last >= 0;..."
> > > 
> > > is even easier to read.
> > 
> > The number of elements is bumped on a single location, so there
> > is not much to synchronize. The old approach was fine because
> > the for cycles were needed anyway, they started on the 0th element,
> > and NULL ended arrays are rather common practice.
> > 
> > But we are searching the array from the end now. Also we use the
> > for cycle just to get the number here. This is not a common
> > practice and it makes the code more complicated and strange from
> > my point of view.
> 
> I'm fine with either way :)

Alekesey, any chance to use the global variable to count used or point
to the last element?

I know that you have already spent a lot of time with it. It was great
work. But the current solution of the cycle looks weird to me.

Best Regards,
Petr
