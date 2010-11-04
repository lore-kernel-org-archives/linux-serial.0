From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 3/4] n_gsm: Fix support for legacy encoding
Date: Thu, 4 Nov 2010 09:04:49 -0700
Message-ID: <20101104160449.GC3770@kroah.com>
References: <20101104151623.21790.64456.stgit@localhost.localdomain> <20101104151653.21790.70657.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58794 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750759Ab0KDQHh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Nov 2010 12:07:37 -0400
Content-Disposition: inline
In-Reply-To: <20101104151653.21790.70657.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@linux-foundation.org, linux-serial@vger.kernel.org

On Thu, Nov 04, 2010 at 03:17:03PM +0000, Alan Cox wrote:
> From: Alan Cox <alan@linux.intel.com>
> 
> The mux supports several encoding schemes. Encoding 0 is a "not
> recommended" mode still sometimes used. This has now been tested with
> hardware that supports this mode, and found wanting.
> 
> Fix the FCS handling in this mode and correct the state machine.
> 
> Signed-off-by: Ken Mills <ken.k.mills@intel.com>
> Signed-off-by: Alan Cox <alan@linux.intel.com>

.38, right?

thanks,

greg k-h
