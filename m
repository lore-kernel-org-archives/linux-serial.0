From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 2/2] serial: pl011: delete reset callback
Date: Fri, 7 Sep 2012 09:08:30 +0100
Message-ID: <20120907080829.GA6173@gmail.com>
References: <1347004968-15329-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37813 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088Ab2IGIIg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 7 Sep 2012 04:08:36 -0400
Received: by eekc1 with SMTP id c1so1035498eek.19
        for <linux-serial@vger.kernel.org>; Fri, 07 Sep 2012 01:08:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1347004968-15329-1-git-send-email-linus.walleij@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@stericsson.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Anmar Oueja <anmar.oueja@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, "Rajanikanth H.V" <rajanikanth.hv@stericsson.com>

On Fri, Sep 07, 2012 at 10:02:48AM +0200, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>=20
> Since commit 4fd0690bb0c3955983560bb2767ee82e2b197f9b
> "serial: pl011: implement workaround for CTS clear event issue"
> the PL011 UART is no longer at risk to hang up, so get rid
> of the callback altogether.
>=20
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Rajanikanth H.V <rajanikanth.hv@stericsson.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Didn't you send these already? Have they changed since?

--=20
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
