From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: Need to disable MSR interrupts in 8250 driver. Request for guidance...
Date: Mon, 03 Jan 2011 15:56:45 -0800
Message-ID: <87pqsda6de.fsf@ti.com>
References: <4D21D9EE.7070503@criticallink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:65182 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab1ACX4u (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 3 Jan 2011 18:56:50 -0500
Received: by gxk9 with SMTP id 9so2767698gxk.19
        for <linux-serial@vger.kernel.org>; Mon, 03 Jan 2011 15:56:49 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Michael Williamson <michael.williamson@criticallink.com>
Cc: linux-serial@vger.kernel.org, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, Greg Kroah-Hartman <gregkh@suse.de>

Michael Williamson <michael.williamson@criticallink.com> writes:

> I am working on platform from the davinci architecture that uses the 8520 UART
> driver.  However, there are some configurations that do not have a valid
> CTS input pin (it is a multi-purpose pin on a SoC part, and it may be configured
> for other functions).  These configurations can cause a pile of "false" 
> MSR interrupts.  If, in 8250.c, I set the UART_BUG_NOMSR flag as part of
> the up->bugs information, the problem clears up.

[...]

> Should I create a new port type, add a new UPF_ flag in the flags field, figure 
> out how to pass bugs information via platform data, or continue along the
> work-around path?  

I added Greg KH to Cc as he's maintaining the 8250 core now.

IMO, adding UPF_ flag(s) to indicate this bug seems like the right way
to go to me.

Kevin



