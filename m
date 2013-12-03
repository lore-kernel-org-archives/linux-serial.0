From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 0/2] serial: sh-sci: Prepare for CCF migration
Date: Tue, 3 Dec 2013 10:43:46 -0800
Message-ID: <20131203184346.GB23280@kroah.com>
References: <1385658706-20093-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1516614.DSSr7jaai1@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1516614.DSSr7jaai1@avalon>
Sender: linux-sh-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-sh@vger.kernel.org, linux-serial@vger.kernel.org, Simon Horman <horms@verge.net.au>
List-Id: linux-serial@vger.kernel.org

On Mon, Dec 02, 2013 at 02:36:32PM +0100, Laurent Pinchart wrote:
> Hi Greg,
> 
> On Thursday 28 November 2013 18:11:44 Laurent Pinchart wrote:
> > Hello,
> > 
> > This patch set prepares the driver to CCF migration by replacing
> > clk_enable() and clk_disable() by clk_prepare_enable() and
> > clk_disable_unprepare() respectively (2/2). In order to do so it first
> > ensures that the clk_enable() and clk_disable() calls will only take place
> > from non-atomic context (1/2).
> > 
> > Greg, these patches are dependencies for a bunch of ARM patches that will go
> > through Simon's tree. Would you be fine if Simon merged all sh-sci patches
> > through his tree for v3.14 ?
> 
> Ping ?

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
