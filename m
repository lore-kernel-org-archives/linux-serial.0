From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 00/11] BKL pruning and serial bug fixing
Date: Thu, 20 May 2010 10:56:36 -0700
Message-ID: <20100520175636.GB17077@kroah.com>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:38500 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755175Ab0ETSAS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 May 2010 14:00:18 -0400
Content-Disposition: inline
In-Reply-To: <20100519120111.16717.71992.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

On Wed, May 19, 2010 at 01:01:42PM +0100, Alan Cox wrote:
> BKL elemination using the existing locks

Hm, have all of these patches been in -next before now?  Do you think
these are ready to go into .35?

thanks,

greg k-h
