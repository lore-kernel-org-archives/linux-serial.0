From: Michael Brunner <mibru@gmx.de>
Subject: Re: [PATCH] pch_uart: Add Kontron COMe-mTT10 uart clock quirk
Date: Thu, 22 Mar 2012 22:31:12 +0100
Message-ID: <20120322223112.291e0c59@mail.gmx.de>
References: <20120322211903.6776ab18@mail.gmx.de>
	<4F6B8E1B.9080802@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout-de.gmx.net ([213.165.64.23]:53653 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1031012Ab2CVVbP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Mar 2012 17:31:15 -0400
In-Reply-To: <4F6B8E1B.9080802@linux.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Darren Hart <dvhart@linux.intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

> These boards should already be supported by the following BIOS check.
> As the DMI_BOARD_NAME was changing, it was Kontron's recommendation
> to use the FRI2 prefix in the DMI_BIOS_VERSION.
> 
> 
> >  	cmp = dmi_get_system_info(DMI_BIOS_VERSION);
> >  	if (cmp && strnstr(cmp, "FRI2", 4))
> 
> Is this not working for you? If not, what is the DMI_BIOS_VERSION
> reported by your board?
>
> And for clarification, we are talking about this right:
> http://us.kontron.com/products/systems+and+platforms/m2m/m2m+smart+services+developer+kit.html

My changes refer to the embedded module with the project code NTC1:
<http://us.kontron.com/products/computeronmodules/com+express/com+express+mini/comemtt10.html>

So unfortunately the FRI2 checks won't work for this.

Michael
