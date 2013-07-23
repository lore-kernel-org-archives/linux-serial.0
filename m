From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v5] linux,stdout-path helper
Date: Tue, 23 Jul 2013 16:17:27 +0200
Message-ID: <20130723141727.GA6807@pengutronix.de>
References: <20121121155312.GX4398@game.jcrosoft.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57726 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932972Ab3GWORf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Jul 2013 10:17:35 -0400
Content-Disposition: inline
In-Reply-To: <20121121155312.GX4398@game.jcrosoft.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org

On Wed, Nov 21, 2012 at 04:53:12PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> The following adds a helper for matching the linux,stdout-path property
> in the chosen node and makes use of it in the i.MX serial and Atmel serial driver.

Seems this got stuck. Jean-Christophe, will you update this series? I
could really make use of this.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
