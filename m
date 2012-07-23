From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 03/25] serial/imx: make imx_port.devdata member point to
 const data
Date: Mon, 23 Jul 2012 08:31:50 -0700
Message-ID: <20120723153150.GB19571@kroah.com>
References: <1343034810-3386-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53721 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753337Ab2GWPbz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 23 Jul 2012 11:31:55 -0400
Received: by pbbrp8 with SMTP id rp8so11040704pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 23 Jul 2012 08:31:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1343034810-3386-4-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Grant Likely <grant.likely@secretlab.ca>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <rob.herring@calxeda.com>, Alan Cox <alan@linux.intel.com>, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On Mon, Jul 23, 2012 at 11:13:08AM +0200, Uwe Kleine-K=F6nig wrote:
> This prepares *of_device_id.data becoming const. Without this change =
the
> following warning would occur:
>=20
> 	drivers/tty/serial/imx.c: In function 'serial_imx_probe_dt':
> 	drivers/tty/serial/imx.c:1430:17: warning: assignment discards 'cons=
t' qualifier from pointer target type [enabled by default]
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
