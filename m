From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: mxs-auart: fix build failure due to broken goto
 statement
Date: Tue, 10 Mar 2015 20:45:27 +0100
Message-ID: <20150310194527.GF952@pengutronix.de>
References: <1426010277-5910-1-git-send-email-hofrat@osadl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426010277-5910-1-git-send-email-hofrat@osadl.org>
Sender: linux-next-owner@vger.kernel.org
To: Nicholas Mc Guire <hofrat@osadl.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Janusz Uzycki <j.uzycki@elproma.com.pl>, linux-serial@vger.kernel.org, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hello,

On Tue, Mar 10, 2015 at 01:57:57PM -0400, Nicholas Mc Guire wrote:
> fix mxs-auart build failure. got -> goto and wrong jump target.
>=20
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
=46abio was bit quicker than you. He sent the same patch just before yo=
u
with Message-Id: 1425997464-3422-1-git-send-email-fabio.estevam@freesca=
le.com.

I failed to find a working archive though.

Thanks anyhow,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
