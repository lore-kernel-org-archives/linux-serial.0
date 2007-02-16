From: Marc St-Jean <Marc_St-Jean@pmc-sierra.com>
Subject: Re: [PATCH] serial driver PMC MSP71xx, kernel linux-mips.git mast
	er
Date: Fri, 16 Feb 2007 08:30:28 -0800
Message-ID: <45D5DC24.7090506@pmc-sierra.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mother.pmc-sierra.com ([216.241.224.12]:46650 "HELO
	mother.pmc-sierra.bc.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S932468AbXBPQag (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Feb 2007 11:30:36 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Marc St-Jean <stjeanma@pmc-sierra.com>, linux-kernel@vger.kernel.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org

Andrew Morton wrote:
> On Thu, 15 Feb 2007 13:26:29 -0600
> Marc St-Jean <stjeanma@pmc-sierra.com> wrote:
> 
>  > +                     status = *(volatile u32 *)up->port.private_data;
> 
> It distresses me that this patch uses a variable which this patch
> doesn't initialise anywhere.  It isn't complete.
> 
> The sub-driver code whch sets up this field shuld be included in the
> patch, no?
> 

OK, I'll re-post with the platform file which initializes the variable.
That file however will reference other files in the platform which has
not been posted yet. I thought it was better to post the driver-only code.

Marc
