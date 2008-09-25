From: chri <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH RESEND] max3100 driver
Date: Thu, 25 Sep 2008 09:07:54 +0200
Message-ID: <cabda6420809250007tb132ff8r8c6e5c7d821db664@mail.gmail.com>
References: <12219154581088-git-send-email-chripell@gmail.com>
	<200809242156.29505.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809242156.29505.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-serial@vger.kernel.org

On Thu, Sep 25, 2008 at 6:56 AM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
>
> Small suggestion:  next time you resend this, make sure
> that $SUBJECT mentions it's a UART driver.  Maybe even that
> it's a SPI UART driver.  That should help get more comments.
>

OK!

>
> This is a bit picky, but it's the first thing I noticed when
> scanning the patch ... wierd comment layout!  Either indent
> those all, or (better) convert to kerneldoc style.

I will have a look at kerneldoc and do the change. I'm waiting for a
minor number in "Low-density serial ports" before resending the
modifications asked by Andrew and Alan, so I will do this too. I just
trusted M-q in emacs for the comment layout.

>
> Potentially less picky:  probe() doesn't lock max3100s[],
> neither does remove(), and in fact there seems to be no
> lock for that table.  Which suggests trouble in cases like

I (wrongly!) was assuming that probing of devices is serialized. I
will add the lock.

>
> And is that workqueue single threaded?
>

it's freezeabe and (looking at include/linux/workqueue.) it implies
that it's single-threaded. This is important because I don't do
locking since I presume all the I/O to the MAX3100 is done in just one
workqueue. When I do I/O in other places (suspend for example) I
assume that the worqueue is friezed so not running.

Best regards and thanks for the review,

-- 
Christian Pellegrin, see http://www.evolware.org/chri/
"Real Programmers don't play tennis, or any other sport which requires
you to change clothes. Mountain climbing is OK, and Real Programmers
wear their climbing boots to work in case a mountain should suddenly
spring up in the middle of the computer room."

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
