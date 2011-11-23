From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] serial/mxs-auart: only wake up tty layer once
Date: Wed, 23 Nov 2011 12:41:33 +0100
Message-ID: <20111123114133.GM19986@pengutronix.de>
References: <1321968177-16039-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1321968177-16039-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111123114033.62639253@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:36909 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753454Ab1KWLlg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 23 Nov 2011 06:41:36 -0500
Content-Disposition: inline
In-Reply-To: <20111123114033.62639253@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: kernel@pengutronix.de, linux-serial@vger.kernel.org

On Wed, Nov 23, 2011 at 11:40:33AM +0000, Alan Cox wrote:
> On Tue, 22 Nov 2011 14:22:56 +0100
> Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > There is no need to call uart_write_wakeup after each character sen=
d.
> > Once at the end of the write sequence is enough.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
>=20
> Both parts
>=20
> Acked-by: Alan Cox <alan@linux.intel.com>
That means they should go via Sascha and/or Shawn?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
