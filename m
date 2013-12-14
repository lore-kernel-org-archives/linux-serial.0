From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Date: Sat, 14 Dec 2013 10:00:45 +0900
Message-ID: <20131214010045.GD12584@verge.net.au>
References: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1516614.DSSr7jaai1@avalon>
 <20131203184346.GB23280@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46875 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752363Ab3LNBAs (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 13 Dec 2013 20:00:48 -0500
Content-Disposition: inline
In-Reply-To: <20131203184346.GB23280@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, linux-sh@vger.kernel.org, linux-serial@vger.kernel.org

On Tue, Dec 03, 2013 at 10:43:46AM -0800, Greg Kroah-Hartman wrote:
> On Mon, Dec 02, 2013 at 02:36:32PM +0100, Laurent Pinchart wrote:
> > Hi Greg,
> > 
> > On Thursday 28 November 2013 18:11:44 Laurent Pinchart wrote:
> > > Hello,
> > > 
> > > This patch set prepares the driver to CCF migration by replacing
> > > clk_enable() and clk_disable() by clk_prepare_enable() and
> > > clk_disable_unprepare() respectively (2/2). In order to do so it first
> > > ensures that the clk_enable() and clk_disable() calls will only take place
> > > from non-atomic context (1/2).
> > > 
> > > Greg, these patches are dependencies for a bunch of ARM patches that will go
> > > through Simon's tree. Would you be fine if Simon merged all sh-sci patches
> > > through his tree for v3.14 ?
> > 
> > Ping ?
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, I will (finally) queue these up.
