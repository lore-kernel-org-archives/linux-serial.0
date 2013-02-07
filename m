From: Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH v3 07/23] tty: Strengthen no-subsequent-use guarantee
 of tty_ldisc_halt()
Date: Thu, 07 Feb 2013 16:38:02 +0100
Message-ID: <5113CA5A.8070307@suse.cz>
References: <1355509370-5883-1-git-send-email-peter@hurleysoftware.com> <1360095638-6624-1-git-send-email-peter@hurleysoftware.com> <1360095638-6624-8-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1360095638-6624-8-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, Sasha Levin <levinsasha928@gmail.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Ilya Zykov <ilya@ilyx.ru>, Dave Jones <davej@redhat.com>
List-Id: linux-serial@vger.kernel.org

On 02/05/2013 09:20 PM, Peter Hurley wrote:
> @@ -688,9 +702,9 @@ int tty_set_ldisc(struct tty_struct *tty, int ldisc)
>  	 *	parallel to the change and re-referencing the tty.
>  	 */
>  
> -	work = tty_ldisc_halt(tty);
> +	retval = tty_ldisc_halt(tty, &work, 5 * HZ);
>  	if (o_tty)
> -		o_work = tty_ldisc_halt(o_tty);
> +		tty_ldisc_halt(o_tty, &o_work, 0);

Zero in there will cause the other end's work not to be cancelled and
TTY_LDISC_HALTED unset if there are two or more readers on the slave,
right? So there should be something like:
if (timeout)
  retval = tty_ldisc_wait_idle(tty, timeout);
  ...

in tty_ldisc_halt.

-- 
js
suse labs
