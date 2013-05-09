From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH] serial: 8250_dw: set clock rate
Date: Thu, 9 May 2013 13:58:09 +0100
Message-ID: <518B9D61.4090406@imgtec.com>
References: <1368095356-21081-1-git-send-email-james.hogan@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:52700 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751260Ab3EIM6M (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 9 May 2013 08:58:12 -0400
In-Reply-To: <1368095356-21081-1-git-send-email-james.hogan@imgtec.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: James Hogan <james.hogan@imgtec.com>, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Jiri Slaby <jslaby@suse.cz>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, Bill Pemberton <wfp5p@virginia.edu>

On 09/05/13 11:29, James Hogan wrote:
> If the uart clock provided to the 8250_dw driver is adjustable it may
> not be set to the desired rate. Therefore if both a uart clock and a
> clock frequency is specified (e.g. via device tree), try and update the
> clock to match the frequency.
> 
> Unfortunately if the resulting frequency is rounded down (which is the
> default behaviour of the generic clk-divider), the 8250 core won't allow
> the highest baud rate to be used, so if an explicit frequency is
> specified we always report that to the 8250 core.

Hi,

Sorry, please ignore this patch.

I've realised that a larger (e.g. non-divided) source clock can just be
provided directly to the uart and it appears to have enough of an
internal divider for the driver to do the right thing without changing
the input clock rate, although of course that clock rate still needs
setting somewhere. I'm not sure why we didn't do this all along as it
gives a closer frequency anyway.

Thanks
James

