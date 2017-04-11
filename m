From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Tue, 11 Apr 2017 10:54:26 +0900
Message-ID: <20170411015426.GB3836@jagdpanzerIV.localdomain>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170410142214.GA3452@pathway.suse.cz>
 <0514db53-4f8b-fa08-f461-902de85777ee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0514db53-4f8b-fa08-f461-902de85777ee@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On (04/10/17 21:00), Aleksey Makarov wrote:
> On 04/10/2017 05:22 PM, Petr Mladek wrote:
> > On Wed 2017-04-05 23:20:00, Aleksey Makarov wrote:
[..]
> > > To fix that, introduce an invariant "The last non-braille console
> > > is always the preferred one" on the entries of the console_cmdline
> > > array.  Then traverse it in reverse order to be sure that if
> > > the console is preferred then it will be the first matching entry.
> > > Introduce variable console_cmdline_cnt that keeps the number
> > > of elements of the console_cmdline array (Petr Mladek).  It helps
> > > to get rid of the loop that searches for the end of this array.
> > > 
> > > Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> > > Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> > 
> > This version looks fine to me. Just a small nitpick below.
> > Anyway:
> > 
> > Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thank you for review.  Can you (or anybody else) ACK it?
> I am going to resend the whole series without those empty lines.
> May I add your Acked-by:?

Acked-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

feel free to resend. I know some setups that have repeating (double)
lines on the serial console, I'll ask people to test the patches.

	-ss
