From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 4/4] n_gsm: clean up printks
Date: Thu, 4 Nov 2010 09:04:11 -0700
Message-ID: <20101104160411.GA3770@kroah.com>
References: <20101104151623.21790.64456.stgit@localhost.localdomain> <20101104151714.21790.4269.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58787 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab0KDQHZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 12:07:25 -0400
Content-Disposition: inline
In-Reply-To: <20101104151714.21790.4269.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

On Thu, Nov 04, 2010 at 03:17:27PM +0000, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> [Original From Ken Mills but I redid it using pr_ helpers instead]
> 
> Also fix up coding style, there are two warnings left but that is where
> the CodingStyle tools blow up because they cannot handle
> 
> 	if (blah) {
> 		foo
> 	} else switch (x) {
> 		case 1:
> 		}
> 
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/char/n_gsm.c |  154 ++++++++++++++++++++++++++------------------------
>  1 files changed, 81 insertions(+), 73 deletions(-)

This is for .38, right?

thanks,

greg k-h
