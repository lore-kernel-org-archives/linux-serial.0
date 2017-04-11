From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Tue, 11 Apr 2017 09:43:25 +0200
Message-ID: <20170411074325.GC3452@pathway.suse.cz>
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
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon 2017-04-10 21:00:35, Aleksey Makarov wrote:
> 
> 
> On 04/10/2017 05:22 PM, Petr Mladek wrote:
> >On Wed 2017-04-05 23:20:00, Aleksey Makarov wrote:
> >>If a console was specified by ACPI SPCR table _and_ command line
> >>parameters like "console=ttyAMA0" _and_ "earlycon" were specified,
> >>then log messages appear twice.
> >>
> >>The root cause is that the code traverses the list of specified
> >>consoles (the `console_cmdline` array) and stops at the first match.
> >>But it may happen that the same console is referred by the elements
> >>of this array twice:
> >>
> >>	pl011,mmio,0x87e024000000,115200 -- from SPCR
> >>	ttyAMA0 -- from command line
> >>
> >>but in this case `preferred_console` points to the second entry and
> >>the flag CON_CONSDEV is not set, so bootconsole is not deregistered.
> >>
> >>To fix that, introduce an invariant "The last non-braille console
> >>is always the preferred one" on the entries of the console_cmdline
> >>array.  Then traverse it in reverse order to be sure that if
> >>the console is preferred then it will be the first matching entry.
> >>Introduce variable console_cmdline_cnt that keeps the number
> >>of elements of the console_cmdline array (Petr Mladek).  It helps
> >>to get rid of the loop that searches for the end of this array.
> >>
> >>Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> >>Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> >
> >This version looks fine to me. Just a small nitpick below.
> >Anyway:
> >
> >Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Thank you for review.  Can you (or anybody else) ACK it?
> I am going to resend the whole series without those empty lines.
> May I add your Acked-by:?

Sure. Feel free to use:

Acked-by: Petr Mladek <pmladek@suse.com>

The meaning of the tags is a bit unclear. Acked-by means that
the maintainer agrees with the idea. But it does not necessarily
means that she reviewed the code in details. I agree with the idea
and did the review, so I used the Reviewed-by tag.

Also you do not need to resend the patchset just because the two
empty lines. Sergey agrees. I will wait day or two and push
all three patches into the printk.git if nobody complains
in the meantime. I could remove the two empty lines when doing so.

Thanks a lot for the fix and patience.

Best Regards,
Petr
