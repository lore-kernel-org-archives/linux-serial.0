From: David Brownell <david-b@pacbell.net>
Subject: Re: [spi-devel-general] [RFC][PATCH] serial: spi: add spi-uart driver for Maxim 3110
Date: Wed, 24 Feb 2010 20:47:13 -0800
Message-ID: <201002242047.14308.david-b@pacbell.net>
References: <20091229222006.1ddb28a4@feng-desktop> <73BDC2BA3DA0BD47BAAEE12383D407EF303E943D@shzsmsx502.ccr.corp.intel.com> <1262112228.28396.93.camel@justakiss.home.at>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:28235 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755781Ab0BYHAR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 25 Feb 2010 02:00:17 -0500
In-Reply-To: <1262112228.28396.93.camel@justakiss.home.at>
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Erwin Authried <eauth@softsys.co.at>
Cc: "Tang, Feng" <feng.tang@intel.com>, Baruch Siach <baruch@tkos.co.il>, Greg Kroah-Hartman <gregkh@suse.de>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, spi-devel-list <spi-devel-general@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>, "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>

On Tuesday 29 December 2009, Erwin Authried wrote:
> I think there's no need for a MAX3100 **and** a MAX3110 driver, this is
> just confusing. The MAX3110 driver is identical to the MAX3100 from the
> software view, it is simply a MAX3100 with transceivers added to the
> chip. If there's any improvement, that should be merged into the
> existing MAX3100 driver.

Assuming that's true ... who will resolve the issue?

