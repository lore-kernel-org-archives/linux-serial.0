From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v4] ARM/serial: at91: switch atmel serial to use gpiolib
Date: Mon, 3 Feb 2014 10:06:21 +0100
Message-ID: <20140203090621.GX26766@pengutronix.de>
References: <1383816355-2956-1-git-send-email-linus.walleij@linaro.org>
 <CACRpkdZNe0L+yZnqrY51Oeg+k5NHXebJAiqxi+p5Scy-BQ2+1w@mail.gmail.com>
 <52EBBB84.9050705@gmail.com>
 <20140131231618.GC11138@quad.lixom.net>
 <CACRpkdbHNo1bLxKaCCuOBiRq+JEpEPXdmQpr4BKAiORcb2snfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdbHNo1bLxKaCCuOBiRq+JEpEPXdmQpr4BKAiORcb2snfw@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Olof Johansson <olof@lixom.net>, Richard Genoud <richard.genoud@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "arm@kernel.org" <arm@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Andrew Victor <linux@maxim.org.za>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Feb 03, 2014 at 09:34:31AM +0100, Linus Walleij wrote:
> On Sat, Feb 1, 2014 at 12:16 AM, Olof Johansson <olof@lixom.net> wrot=
e:
> > On Fri, Jan 31, 2014 at 04:04:36PM +0100, Richard Genoud wrote:
>=20
> >> I can't find this patch in linux-next, did I missed something ?
> >
> > Yeah, looks like we dropped the ball on it. We'll queue it up for 3=
=2E15 as soon
> > as -rc1 is out.
>=20
> OK it's out now ;-)
I included it in my drop-<mach/timex.h> series that I wish to go into
3.15, too. The patch is the first in my series, commit 354e57f3a0a2. If
you want to take this patch but not my series, please still take this
one to prevent it going in twice.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
