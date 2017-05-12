From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v9 3/3] printk: fix double printing with earlycon
Date: Fri, 12 May 2017 15:46:55 +0200
Message-ID: <20170512134655.GD31170@pathway.suse.cz>
References: <20170315102854.1763-1-aleksey.makarov@linaro.org>
 <20170405202006.18234-1-aleksey.makarov@linaro.org>
 <20170509082915.GA13236@bistromath.localdomain>
 <20170511082433.GA421@jagdpanzerIV.localdomain>
 <20170511084158.GB421@jagdpanzerIV.localdomain>
 <20170512125729.GO3452@pathway.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170512125729.GO3452@pathway.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Aleksey Makarov <aleksey.makarov@linaro.org>, Sabrina Dubroca <sd@queasysnail.net>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Jiri Slaby <jslaby@suse.com>, Robin Murphy <robin.murphy@arm.com>, Steven Rostedt <rostedt@goodmis.org>, "Nair, Jayachandran" <Jayachandran.Nair@cavium.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri 2017-05-12 14:57:29, Petr Mladek wrote:
> On Thu 2017-05-11 17:41:58, Sergey Senozhatsky wrote:
> > On (05/11/17 17:24), Sergey Senozhatsky wrote:
> > > On (05/09/17 10:29), Sabrina Dubroca wrote:
> > > [..]
> > > > That's caused a change of behavior in my qemu setup, with this cmdline
> > > > 
> > > >     root=/dev/sda1 console=ttyS1 console=ttyS0
> > > > 
> > > > Before, the kernel logs appeared on ttyS1, and I logged in with ttyS0
> > > > (with my setup, ttyS1 is a file and ttyS0 is unix socket). Now, the
> > > > kernel logs go to ttyS0. I need to swap the two console= parameters to
> > > > restore behavior.

Do you actually need to define console=ttyS0 on the cmdline?

IMHO, if register_console() was called for the unix socket, it
would make logs appear on both ttyS0 and ttyS1. It seems
that register_console() is called only for the console that
stores logs into the file.


> > > > adding
> > > > console=tty0 anywhere on that cmdline makes the logs appear on both
> > > > tty0 and one ttyS* (but only one of them, and the ordering of the
> > > > ttyS* matters).

I guess that it worked this way before. I mean that the logs appeared
on both tty0 and one of ttyS*. The only difference should be that
the patch changed the selected ttyS*. So this is still the same problem.


> Hmm, I have no idea how to fix this. This is the case where
> a registered console matches more entries from the command line.
> The fix that caused this regression fixed exactly this situation
> and we wanted to make the preferred console first.
> 
> I am not sure if we broke some backward compatibility or actually made
> it more predictable in the long term.

I think that we actually fixed a very old bug. The last mentioned
console= should be the preferred one and the logs are finally
printed there. Or do I miss anything?

Best Regards,
Petr
