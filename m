From: Pavel Machek <pavel@ucw.cz>
Subject: Re: n_tty.c driver patch (semantic and performance correction) (all recent versions)
Date: Wed, 26 Jun 2002 03:07:05 +0200
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20020626010705.GA103@elf.ucw.cz>
References: <200206152101.24615.rwhite@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200206152101.24615.rwhite@pobox.com>
List-Id: linux-serial@vger.kernel.org
To: Robert White <rwhite@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

Hi!

> (Wow, that was a lot of text for this little thing... 8-)

Yep.

> --- drivers/char/n_tty.c.orig	Tue Jan 29 18:26:54 2002
> +++ drivers/char/n_tty.c	Thu Jan 31 02:28:51 2002
> @@ -18,11 +18,35 @@
>   * This file may be redistributed under the terms of the GNU General Public
>   * License.
>   *
> + * 2002/01/29	Fixed & Extended VMIN handling.
> + *		Patch By:  Robert White <rwhite@pobox.com>
> + *		Problem:  Where VTIME == 0 and VMIN > nr durring read,
> + *		   read would block for characters it couldn't possibly return.
> + *		   Reading variable sized blocks required multiple syscalls
> + *		   (termio set followed by read) or reliance on timeout.
> + *		   or multiple reads of fragments. For large reads n_tty
> + *		   was not capible of returning more than 255 bytes (bad
> + *		   for performance of any serial protocols. c.f. Z-MODEM etc)
> + *		Fix: if VMIN > nr, use nr to set minimum instead. (adjust down)
> + *		Extension: if VMIN == 255, always set minimum to nr (up OR down)
> + *		(Fix and Extension apply to each read call, VMIN itself is not adjusted)
> + *		Consider: (w/8 or 1500 chars from device to be delivered respectively)
> + *		VMIN=30, VTIME=0, read(fd,buf,8);
> + *		  Old: read never returns, New: returns immed on 8th char
> + *		VMIN=30, VTIME=200, read(fd,buf,8);
> + *		  Old: return in 20 seconds, New: returns immed on 8th char
> + *		VMIN=255, VTIME=0, read(fd,buf,1500); 
> + *		  Old: 5 reads of ~255 then deadlock, New: 1 read to complete
> + *		VMIN=255, VTIME>0, read(fd,buf,1500);
> + *		  Old: 5 reads then timout for remainder, New: 1 read
> + *			or more depending timeout occurences)
> + *
>   * Reduced memory usage for older ARM systems  - Russell King
>   *
>   * 2000/01/20   Fixed SMP locking on put_tty_queue using bits of 
>   *		the patch by Andrew J. Kroll <ag784@freenet.buffalo.edu>
>   *		who actually finally proved there really was a race.
> + *		
>   */
>  
>  #include <linux/types.h>
> @@ -974,6 +998,11 @@
>  	if (!tty->icanon) {
>  		time = (HZ / 10) * TIME_CHAR(tty);
>  		minimum = MIN_CHAR(tty);
> +		/* Added rwhite@pobox.com Jan 29, 2002 */
> +		if ((minimum == 255) || (minimum > nr))	{
> +			minimum = nr;
> +		}
> +		/* End Addition */
>  		if (minimum) {
>  			if (time)
>  				tty->minimum_to_wake = 1;

Kill comments who added it. Imagine if everyone done that.

> @@ -1021,6 +1050,16 @@
>  		if (((minimum - (b - buf)) < tty->minimum_to_wake) &&
>  		    ((minimum - (b - buf)) >= 1))
>  			tty->minimum_to_wake = (minimum - (b - buf));
> +
> +		/* Added rwhite@pobox.com Jan 29, 2002 */
> +		// minimum and therefore minimum_to_wake could be much larger
> +		// than the actual buffer here, so...
> +		if (tty->minimum_to_wake >= TTY_FLIPBUF_SIZE)	{
> +			// Flow Control would deadlock at  (N_TTY_BUF_SIZE - 
> TTY_THRESHOLD_THROTTLE)
> +			// using TTY_FLIPBUF_SIZE-1 is safe and likely linear/streaming.
> +			tty->minimum_to_wake = TTY_FLIPBUF_SIZE - 1;
> +		}
> +		/* End Addition */

No C++ comments, please.
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
