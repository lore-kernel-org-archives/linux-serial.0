From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] serial: ifx6x60: Add module parameters to manage the
 modem status through sysfs.
Date: Fri, 2 Nov 2012 11:29:45 +0000
Message-ID: <20121102112945.535bfea7@pyramind.ukuu.org.uk>
References: <1351872943.4332.37.camel@chenjun-workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:35963 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752520Ab2KBLYk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 2 Nov 2012 07:24:40 -0400
In-Reply-To: <1351872943.4332.37.camel@chenjun-workstation>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jun Chen <jun.d.chen@intel.com>
Cc: alan@linux.intel.com, linux-serial@vger.kernel.org, russ.gorby@intel.com, chuansheng.liu@intel.com, chao.bi@intel.com

> +	if (reset_request == IFX_COLD_RESET_REQ) {
> +		/*  Need to add these action for modem cold reset:
> +		* - Set the RESET_BB_N to low (better SIM protection)
> +		* - Set the EXT1P35VREN field to low  during 20ms (V1P35CNT_W  register)
> +		* - set the EXT1P35VREN field to high during 10ms (V1P35CNT_W  register)
> +		*/

You seem to have submitted an unfinished version ?

Also can you explain the locking on your new reset_ongoing variable and
hangup_reasons variable ? What stops the sysfs code being run in parallel
with the other bits or even twice at once.

Looking at it I get the impression that

a) the variable should be in the device structure not a static global
b) it is write only which seems pointless
c) you probably want a mutex around the actual reset processes so that
reset is single threaded in each case.
d) that mutex probably belongs in the device structure
 

The hangup reasons in this patch also appears to be write only ?

Alan
