From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] serial/imx: only parse for iomem resources once
Date: Thu, 22 Apr 2010 16:33:43 +0200
Message-ID: <20100422143343.GB32348@pengutronix.de>
References: <1271838838.643120.804272014834.1.gpush@pororo>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54512 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755278Ab0DVOdq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Apr 2010 10:33:46 -0400
Content-Disposition: inline
In-Reply-To: <1271838838.643120.804272014834.1.gpush@pororo>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: Sascha Hauer <kernel@pengutronix.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Wed, Apr 21, 2010 at 04:33:58PM +0800, Jeremy Kerr wrote:
> Currently, the iomem resources are parsed in serial_imx_probe, then
> again in imx_request_port and imx_release_port.
>=20
> This change uses the imx_port data to retrieve the start and size of =
the
> memory region, rather than re-parsing the resources through
> platform_get_resource.
>=20
> Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>
What are the effects for this regarding run time?  How often are
request_port and release_port called?  I wonder if it's worth to save
the value.  Or what else than run time is your concern?

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
