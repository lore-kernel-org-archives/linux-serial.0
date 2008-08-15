From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH] serial: imx: add console polling routines for kgdboc
Date: Fri, 15 Aug 2008 08:31:04 +0200
Message-ID: <20080815063104.GA8841@pengutronix.de>
References: <48A29AFB.9070502@tripeaks.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from metis.extern.pengutronix.de ([83.236.181.26]:34212 "EHLO
	metis.extern.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751317AbYHOGYj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 15 Aug 2008 02:24:39 -0400
Content-Disposition: inline
In-Reply-To: <48A29AFB.9070502@tripeaks.co.jp>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Atsuo Igarashi <atsuo_igarashi@tripeaks.co.jp>
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk, kernel@pengutronix.de

On Wed, Aug 13, 2008 at 05:27:39PM +0900, Atsuo Igarashi wrote:
> Add console polling routines for the imx uart with kgdboc.

Thanks very much. I've never tried kgdb, so I cannot say if this patch
does the right thing, but it looks like it does ;)
I added it to our git tree.

Sascha


-- 
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
