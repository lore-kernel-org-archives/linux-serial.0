From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/7] tty: core: Add tty_debug() for printk(KERN_DEBUG)
 messages
Date: Sun, 12 Jul 2015 21:30:38 -0700
Message-ID: <1436761838.2711.93.camel@perches.com>
References: <1436755753-7746-1-git-send-email-peter@hurleysoftware.com>
	 <1436755753-7746-3-git-send-email-peter@hurleysoftware.com>
	 <1436759238.2711.86.camel@perches.com>
	 <55A33DC1.9030505@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55A33DC1.9030505@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 2015-07-13 at 00:25 -0400, Peter Hurley wrote:
> On 07/12/2015 11:47 PM, Joe Perches wrote:
> > On Sun, 2015-07-12 at 22:49 -0400, Peter Hurley wrote:
> >> Introduce tty_debug() macro to output uniform debug information for
> >> tty core debug messages (function name and tty name).
> > []
> >> diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
> > []
> >> @@ -768,7 +768,7 @@ static void do_tty_hangup(struct work_struct *work)
> >>  void tty_hangup(struct tty_struct *tty)
> >>  {
> >>  #ifdef TTY_DEBUG_HANGUP
> >> -	printk(KERN_DEBUG "%s hangup...\n", tty_name(tty));
> >> +	tty_debug(tty, "\n");
> > 
> > Why drop the "hangup..." ?
> 
> tty_debug() prints the function name; in this case, tty_hangup().

maybe that #ifdef/#endif block could/should be removed
and the function tracer used to track this instead.

cheers, Joe
