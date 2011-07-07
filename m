From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] n_gsm: fix the wrong FCS handling
Date: Thu, 7 Jul 2011 07:55:25 -0700
Message-ID: <20110707145525.GA29223@kroah.com>
References: <20110707141618.2695.14222.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:43335 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756715Ab1GGO7R (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 7 Jul 2011 10:59:17 -0400
Content-Disposition: inline
In-Reply-To: <20110707141618.2695.14222.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: stable@kernel.org, linux-serial@vger.kernel.org

On Thu, Jul 07, 2011 at 03:16:48PM +0100, Alan Cox wrote:
> From: \"Du, Alek\" <alek.du@intel.com>

I don't think git would like those \ characters, would it?

> FCS could be GSM0_SOF, so will break state machine...
> 
> [This byte isn't quoted in any way so a SOF here doesn't imply an error
>  occurred.]
> 
> Signed-off-by: Alek Du <alek.du@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> 
> [Trivial but best backported once its in 3.1rc I think]

So should I mark it for stable for 3.0?

thanks,

greg k-h
