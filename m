From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/4] pch_uart: Add Fish River Island II uart clock quirks
Date: Fri, 24 Feb 2012 13:53:15 -0800
Message-ID: <20120224215315.GC25330@kroah.com>
References: <26a433d1bdb5805cac69efb20d3e32dbf790339b.1329875301.git.dvhart@linux.intel.com>
 <4982ca7a73cfe208a2a5ff0a7e0da54b99ca2d2e.1329875301.git.dvhart@linux.intel.com>
 <20120222085250.193096c9@pyramind.ukuu.org.uk>
 <4F44B95E.3030307@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:58009 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756791Ab2BXVzt (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 24 Feb 2012 16:55:49 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so2943247dae.19
        for <linux-serial@vger.kernel.org>; Fri, 24 Feb 2012 13:55:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <4F44B95E.3030307@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tomoya MORINAGA <tomoya.rohm@gmail.com>, Feng Tang <feng.tang@intel.com>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Wed, Feb 22, 2012 at 01:46:06AM -0800, Darren Hart wrote:
> 
> 
> On 02/22/2012 12:52 AM, Alan Cox wrote:
> >> +	/* Setup UART clock, checking for board specific clocks. */
> >> +	uartclk = DEFAULT_UARTCLK;
> >> +
> >> +	board_name = dmi_get_system_info(DMI_BOARD_NAME);
> >> +	if (board_name && strstr(board_name, "CM-iTC"))
> >> +		uartclk = CMITC_UARTCLK;
> >> +
> >> +	board_name = dmi_get_system_info(DMI_PRODUCT_NAME);
> >> +	if (board_name && strstr(board_name, "Fish River Island II"))
> >> +		uartclk = FRI2_UARTCLK;
> >> +
> >> +	port->uartclk = uartclk;
> > 
> > This is confusing, you load product name into a variable called
> > board_name ?? perhaps "name" would be clearer ?
> 
> OK, done.

"Done" where?  Is there a newer patch series I should be looking at
here to apply?  I'm guessing I can ignore this one, right?

consider it ignored :)

greg k-h
