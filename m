From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v3 05/23] tty: Remove unnecessary re-test of ldisc ref
 count
Date: Thu, 07 Feb 2013 10:59:37 -0500
Message-ID: <1360252777.4102.42.camel@thor.lan>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com>
	 <1360095638-6624-1-git-send-email-peter@hurleysoftware.com>
	 <1360095638-6624-6-git-send-email-peter@hurleysoftware.com>
	 <5113C566.2060403@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:40666 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756622Ab3BGP7q (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Feb 2013 10:59:46 -0500
In-Reply-To: <5113C566.2060403@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>

On Thu, 2013-02-07 at 16:16 +0100, Jiri Slaby wrote:
> On 02/05/2013 09:20 PM, Peter Hurley wrote:
> > +	char cur_n[TASK_COMM_LEN], tty_n[64];
> > +	long timeout = 3 * HZ;
> > +
> > +	if (tty->ldisc) {	/* Not yet closed */
> > +		tty_unlock(tty);
> > +
> > +		while (tty_ldisc_wait_idle(tty, timeout) == -EBUSY) {
> > +			timeout = MAX_SCHEDULE_TIMEOUT;
> > +			printk_ratelimited(KERN_WARNING
> > +				"%s: waiting (%s) for %s took too long, but we keep waiting...\n",
> > +				__func__, get_task_comm(cur_n, current),
> > +				tty_name(tty, tty_n));
> >  		}
> > -		break;
> > +		/* must reacquire both locks and preserve lock order */
> > +		mutex_unlock(&tty->ldisc_mutex);
> > +		tty_lock(tty);
> > +		mutex_lock(&tty->ldisc_mutex);
> >  	}
> >  	return !!(tty->ldisc);
                   ^^^^^^^^^^^^
               still want me to fix this though?

> >  }
> 
> Ok, so you do it here. So we can silently ignore the comment on 04/23...


