From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 2/2] printk/console: Enhance the check for consoles using
 init memory
Date: Fri, 21 Jul 2017 16:32:53 +0200
Message-ID: <20170721143253.GA26877@pathway.suse.cz>
References: <1500036673-7122-1-git-send-email-pmladek@suse.com>
 <1500036673-7122-3-git-send-email-pmladek@suse.com>
 <20170714220626.GB10437@tigerII.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170714220626.GB10437@tigerII.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Matt Redfearn <matt.redfearn@imgtec.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, "David S. Miller" <davem@davemloft.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, "Fabio M. Di Nitto" <fdinitto@redhat.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Sat 2017-07-15 07:06:26, Sergey Senozhatsky wrote:
> On (07/14/17 14:51), Petr Mladek wrote:
> [..]
> > diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> > index f35d3ac3b8c7..1ebe1525ef64 100644
> > --- a/kernel/printk/printk.c
> > +++ b/kernel/printk/printk.c
> > @@ -2659,8 +2659,16 @@ static int __init printk_late_init(void)
> >  	int ret;
> >  
> >  	for_each_console(con) {
> > -		if ((con->flags & CON_BOOT) &&
> > -		    init_section_intersects(con, sizeof(*con))) {
> > +		if (!(con->flags & CON_BOOT))
> > +			continue;
> > +
> > +		/* Check addresses that might be used for enabled consoles. */
> > +		if (init_section_intersects(con, sizeof(*con)) ||
> > +		    init_section_contains(con->write, 0) ||
> > +		    init_section_contains(con->read, 0) ||
> > +		    init_section_contains(con->device, 0) ||
> > +		    init_section_contains(con->unblank, 0) ||
> > +		    init_section_contains(con->data, 0)) {
> 
> sort of a problem here is that the next time anyone adds a new ->foo()
> callback to struct console, that person also needs to remember to update
> printk_late_init().

I am not super happy with this as well. Any hint how to do it better
or more secure is welcome. But I do not see a beter solution at the moment.

Note that there are only 3 commits in the git history that change this
structure. Neither of them invalidates this check!

Just for record. The commits are:

  + c7cef0a84912cab3 ("console: Add extensible console matching")
      + Mar 9 2015
      + replaced .early_setup with .match

  + 18a8bd949d6adb31 ("serial: convert early_uart to earlycon
    for 8250")
	+ Jul 15 2007 (10 years ago)!
	+ added .early_setup

  + 6ae9200f2cab7b32 ("enlarge console.name")
	+ May 8 2007
	+ resized .name[8] -> .name[16]


> a completely crazy idea,
> can we have a dedicated "console init" section which we will not offload
> if we see keep_bootcon?

I though about this as well. But this will not avoid the above
problem. We still would need to make sure that the consoles
use the special section. Or do I miss anything?

Also note that only few early consoles actually use the init section
and are affected by this problem. Well, I did only a rough grepping.
It is not perfect but it might give a picture:

# struct console location

$> git grep "struct console.*{" | grep early | wc -l
23
$> git grep "struct console.*{" | grep early | grep init | wc -l
5

# write() function location of statically defined struct consoles

$> for func in `git grep -A 6 "struct console.*{" | grep write |
        cut -d= -f2 | cut -d',' -f1 | grep -v void` ;do 
    git grep "void.*$func(struct " ; done | grep early | wc -l
83

$> for func in `git grep -A 6 "struct console.*{" | grep write | 
        cut -d= -f2 | cut -d',' -f1 | grep -v void` ;
   do git grep "void.*$func(struct " ; done | grep early | grep init | wc -l
12

# write method location of struct consoles defined by OF_EARLYCON_DECLARE()

$> for func in `git grep 'con->write =' | cut -d= -f2 | cut -d';' -f1`
     ; do git grep "void.*$func(struct " ; done | grep early wc -l
26

$> for func in `git grep 'con->write =' | cut -d= -f2 | cut -d';' -f1`
     ; do git grep "void.*$func(struct " ; done | grep early | 
       grep init | wc -l
7


It means that less than 25% of early consoles are located in the init
code. I am not sure if it is worth introducing a new section.

Instead it would make sense to move all these consoles into the normal
section. But it is not strictly needed if the normal console is
registered using an init call (always in time). In this case, it is "enough"
to mention the real console as the last one on the command line.


> or... even crazier... disable bootmem offloading (do not offload init
> section) at all if we see keep_bootcon? keep_bootcon is a purely debugging
> option which people enable when things are bad and unclear, no one should
> be using it otherwise, so may be that idea can be a way to go.

I have talked about this with my colleagues. They told me that it
would be pity. The keep_bootcon option might be useful to debug
problems related to freeing the init memory.

In addition, it will not help to avoid the controversal check above.
We need to remove early icons also when the preferred console is
registered too late because of a deferred probe. Or when the preferred
console is not registred at all from some reasons. I mean that problematic
early consoles might need to be forcibly removed even without
keep_bootcon option.

I still vote for the proposed patch even though it is not perfect.
IMHO, "The perfect is the enemy of the good" fits here.

Best Regards,
Petr
