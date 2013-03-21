From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_dw: add support for clk api
Date: Thu, 21 Mar 2013 10:47:07 +0200
Message-ID: <20130321084707.GB2862@xps8300>
References: <1363689316-7847-2-git-send-email-maxime.ripard@free-electrons.com>
 <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:57032 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752057Ab3CUIrN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 21 Mar 2013 04:47:13 -0400
Content-Disposition: inline
In-Reply-To: <1363690369-8067-1-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, kevin@allwinnertech.com, sunny@allwinnertech.com, shuge@allwinnertech.com, linux-serial@vger.kernel.org, Emilio =?iso-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org

On Tue, Mar 19, 2013 at 11:52:49AM +0100, Maxime Ripard wrote:
> From: Emilio L=F3pez <emilio@elopez.com.ar>
>=20
> This commit implements support for using the clk api; this lets us us=
e
> the "clocks" property with device tree, instead of having to use
> clock-frequency.
>=20
> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>

=46WIW,

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

--=20
heikki
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
