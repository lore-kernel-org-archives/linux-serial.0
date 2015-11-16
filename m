From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Mon, 16 Nov 2015 13:16:25 +0100
Message-ID: <20151116121625.GD22022@pengutronix.de>
References: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Nov 12, 2015 at 10:58:48AM +0100, Marcus Folkesson wrote:
> clk_prepare/unprapare APIs are not allowed in atomic context, so
> move prepare/unprepare to probe/remove and use clk_enable/disable
> instead.
>=20
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>

Do you see a problem? I don't claim your patch is wrong, I just wonder
why nobody else noticed it earlier (including me).

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
