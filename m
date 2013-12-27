From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 03/15] serial: sh-sci: Restrict non-COMPILE_TEST
 compilation
Date: Fri, 27 Dec 2013 11:17:59 +0900
Message-ID: <20131227021759.GE9184@verge.net.au>
References: <1385515117-23664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20131128073711.GF24146@verge.net.au>
 <1644962.Fmr1aLVkXP@avalon>
 <3378064.llLXVomVIb@avalon>
 <20131224142640.GB16032@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:37948 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011Ab3L0CSC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Dec 2013 21:18:02 -0500
Content-Disposition: inline
In-Reply-To: <20131224142640.GB16032@verge.net.au>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

On Tue, Dec 24, 2013 at 11:26:41PM +0900, Simon Horman wrote:
> On Tue, Dec 24, 2013 at 01:03:10PM +0100, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Wednesday 11 December 2013 13:44:54 Laurent Pinchart wrote:
> > > Hi Simon,
> > > 
> > > Could you please add this patch to your tree with the "[PATCH 00/47] sh-sci
> > > updates for v3.14" series ?
> > 
> > I've updated all my pending branches to your latest devel tag and this patch 
> > is missing. Could you please pick it up ?
> 
> Sure, will do.

I have now done so. But I'm not sure that it will make it into v3.14.
If not it might be best to send it back to Greg for v3.15. I can handle that.
