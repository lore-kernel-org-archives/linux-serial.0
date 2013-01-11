From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] serial/arc-uart: switch to devicetree based probing
Date: Fri, 11 Jan 2013 11:33:43 +0000
Message-ID: <201301111133.43507.arnd@arndb.de>
References: <1357885223-19243-1-git-send-email-vgupta@synopsys.com> <1357885223-19243-5-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:55490 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409Ab3AKLd4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 11 Jan 2013 06:33:56 -0500
In-Reply-To: <1357885223-19243-5-git-send-email-vgupta@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree-discuss@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>

On Friday 11 January 2013, Vineet Gupta wrote:
> * DT binding for arc-uart
> * With alll the bits in place we can now use DT probing.
> 
> Note that there's a bit of kludge right now because earlyprintk portion
> of driver can't use the DT infrastrcuture to get resoures/plat_data.
> This requires some infrastructre changes to of_flat_ framework
> 
> Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-serial@vger.kernel.org
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: devicetree-discuss@lists.ozlabs.org
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Rob Landley <rob@landley.net>
> Cc: linux-serial@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>

Quick question about the name though: is this UART only used
on ARC, or is it something that synopsys licenses to other
parties as well? If the latter is true, we might want to 
add a more generic "compatible" value for those that use
it on another architecture.

	Arnd
