From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 0/2] Avoid crashes by early (boot) consoles using init
 memory
Date: Fri, 14 Jul 2017 16:37:52 +0200
Message-ID: <20170714143751.GB32632@pathway.suse.cz>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <956ce40c-1640-387a-0ec9-9045c7d8af4b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <956ce40c-1640-387a-0ec9-9045c7d8af4b@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Fabio M. Di Nitto" <fdinitto@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri 2017-07-14 14:57:45, Fabio M. Di Nitto wrote:
> Hi Petr,
> 
> On 7/14/2017 2:51 PM, Petr Mladek wrote:
> > Some early consoles have code and data in the init section. It makes some
> > sense but this might cause problems when they are not replaced by
> > the real console in time. The two patches fix the safequard and
> > help to avoid the problems.
> > 
> > I though about removing keep_bootcon option completely. But it is useful
> > at least for now.
> 
> Let´s just keep in mind that keep_bootcon was introduced only to debug
> issues (read crashes or hangs) that could happen between disabling
> bootconsole and enabling the real console. It shouldn´t be used for
> anything else really.

This was my initial replay as well. But then I realized that
it was a bad idea to use a freed code and data to debug any other
issue. It would just create crazy issues on its own.

I tried to google 'keep_bootcon'. It found several links to strange
crashes related to this option. Maybe I was not patient enough but
I did not find any page where this option was suggested and helped.

I still think that the option makes some sense but only when
it does not cause more breakages on its own.

> If the new code can replace keep_bootcon, by all mean, go for it :-)

keep_bootcon stays usable for most early consoles. We print a warning
when an unusable console is disabled too early. Also there is a
comment how to fix it.

Best Regards,
Petr
