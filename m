From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH RESEND] max3100 driver
Date: Wed, 24 Sep 2008 21:56:29 -0700
Message-ID: <200809242156.29505.david-b@pacbell.net>
References: <12219154581088-git-send-email-chripell@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <12219154581088-git-send-email-chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Christian Pellegrin <chripell-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Christian Pellegrin <chripell-VaTbYqLCNhc@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org
List-Id: linux-serial@vger.kernel.org

You got this working ... congrats!  :)

Small suggestion:  next time you resend this, make sure
that $SUBJECT mentions it's a UART driver.  Maybe even that
it's a SPI UART driver.  That should help get more comments.


On Saturday 20 September 2008, Christian Pellegrin wrote:
> +struct plat_max3100 {
> +/* force MAX3100 in loopback */
> +=A0=A0=A0=A0=A0=A0=A0int loopback;
> +/* 0 for 3.6864 Mhz, 1 for 1.8432 =A0*/
> +=A0=A0=A0=A0=A0=A0=A0int crystal;
> +/* for archs like PXA with only edge irqs */
> +=A0=A0=A0=A0=A0=A0=A0int only_edge_irq;
> +/* MAX3100 has a shutdown pin. This is a hook
> + =A0 called on suspend and resume to activate it.*/
> +=A0=A0=A0=A0=A0=A0=A0void (*max3100_hw_suspend) (int suspend);
> +/* poll time for ctr signals in ms, 0 disables (so no hw flow
> + * ctrl is possible) =A0*/
> +=A0=A0=A0=A0=A0=A0=A0int poll_time;
> +};

This is a bit picky, but it's the first thing I noticed when
scanning the patch ... wierd comment layout!  Either indent
those all, or (better) convert to kerneldoc style.

Potentially less picky:  probe() doesn't lock max3100s[],
neither does remove(), and in fact there seems to be no
lock for that table.  Which suggests trouble in cases like
concurrent I/O (including open) and driver remove().  You
should probably just allocate a mutex to help control that
table, like most other drivers.

And is that workqueue single threaded?


I just skimmed the rest of the driver.  Seems to be
fairly straightforward -- at least the non-TTY bits.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
