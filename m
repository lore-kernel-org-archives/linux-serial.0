From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] serial: sh_sci: remove HAVE_CLK build dependecy
Date: Thu, 6 Feb 2014 17:28:02 +0900
Message-ID: <20140206082802.GA4152@verge.net.au>
References: <2f1dd25b19bf588948fbebc734eebe5d61ca7007.1391628518.git.baruch@tkos.co.il>
 <20140206064056.GB17591@verge.net.au>
 <20140206071821.GC4125@tarshish>
 <20140206072557.GA24865@verge.net.au>
 <20140206073801.GD4125@tarshish>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:47306 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932100AbaBFI2F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Feb 2014 03:28:05 -0500
Content-Disposition: inline
In-Reply-To: <20140206073801.GD4125@tarshish>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Baruch Siach <baruch@tkos.co.il>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-sh@vger.kernel.org

On Thu, Feb 06, 2014 at 09:38:01AM +0200, Baruch Siach wrote:
> Hi Simon,
> 
> On Thu, Feb 06, 2014 at 04:25:57PM +0900, Simon Horman wrote:
> > On Thu, Feb 06, 2014 at 09:18:21AM +0200, Baruch Siach wrote:
> > > On Thu, Feb 06, 2014 at 03:40:56PM +0900, Simon Horman wrote:
> > > > On Wed, Feb 05, 2014 at 09:28:38PM +0200, Baruch Siach wrote:
> > > > > Since 93abe8e4 (clk: add non CONFIG_HAVE_CLK routines) code using clk.h
> > > > > like this driver needs not depend on HAVE_CLK.
> > > > > 
> > > > > Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> > > > 
> > > > Acked-by: Simon Horman <horms+renesas@verge.net.au>
> > > 
> > > Thanks. This patch conflicts with another sh_sci patch you have just posted 
> > > (http://article.gmane.org/gmane.linux.serial/13640). How would you like this 
> > > to be handled?
> > 
> > Indeed it does, sorry for not noticing that.
> > 
> > Perhaps it would be best to drop the patch that I posted?
> 
> Why drop? There is no logical conflict between the patches, only textual. So 
> we just need to serialize them to solve the conflict, and have them go via the 
> same tree.

Ok. Could you rebase and repost your patch on top of the patches that
I posted earlier. The reason that I suggest this is that the patches
I posted have been around publicly for some time, albeit not merged by Greg.
