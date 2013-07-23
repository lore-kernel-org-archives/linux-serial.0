From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] ARM: S3C24XX: Add missing clkdev entries for
	s3c2440 UART
Date: Tue, 23 Jul 2013 09:57:17 +0200
Message-ID: <201307230957.17329.jbe@pengutronix.de>
References: <1374435765-6747-1-git-send-email-sylvester.nawrocki@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <oselas-bounces+gcepoc-oselas=m.gmane.org-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org>
In-Reply-To: <1374435765-6747-1-git-send-email-sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <http://metis.pengutronix.de/cgi-bin/mailman/options/oselas>,
	<mailto:oselas-request-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://metis.pengutronix.de/pipermail/oselas>
List-Post: <mailto:oselas-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org>
List-Help: <mailto:oselas-request-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org?subject=help>
List-Subscribe: <http://metis.pengutronix.de/cgi-bin/mailman/listinfo/oselas>,
	<mailto:oselas-request-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org?subject=subscribe>
Sender: oselas-bounces-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org
Errors-To: oselas-bounces+gcepoc-oselas=m.gmane.org-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, oselas-/6JGXy0y6WNX4V3MAk3apN53zsg1cpMQ@public.gmane.org, Chander Kashyap <chander.kashyap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

On Sunday 21 July 2013 21:42:45 Sylwester Nawrocki wrote:
> This patch restores serial port operation which has been broken since
> commit 60e93575476f90a72146b51283f514da655410a7
> serial: samsung: enable clock before clearing pending interrupts during
> init
>
> That commit only uncovered the real issue which was missing clkdev
> entries for the "uart" clocks on S3C2440. It went unnoticed so far
> because return value of clk API calls were not being checked at all
> in the samsung serial port driver.
>
> This patch should be backported to at least 3.10 stable kernel, since
> the serial port has not been working on s3c2440 since 3.10-rc5.
>
> Cc: Chander Kashyap <chander.kashyap-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> Signed-off-by: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> [on S3C2440 SoC based Mini2440 board]
> Tested-by: Sylwester Nawrocki <sylvester.nawrocki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> [...]

Tested-by: Juergen Beisert <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

=2D-=20
Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0| Juergen Beisert =A0 =A0 =A0 =A0 =A0 =A0 |
Linux Solutions for Science and Industry =A0 =A0 =A0| Phone: +49-5121-20691=
7-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany =A0 =A0| Fax: =A0 +49-5121-20691=
7-5555 |
Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 =A0 =A0| http://www.pe=
ngutronix.de/ =A0|
