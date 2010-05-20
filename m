From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH 00/11] BKL pruning and serial bug fixing
Date: Thu, 20 May 2010 19:06:05 +0100
Message-ID: <20100520190605.141a70ad@linux.intel.com>
References: <20100519120111.16717.71992.stgit@localhost.localdomain>
	<20100520175636.GB17077@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:8878 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab0ETSs4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 20 May 2010 14:48:56 -0400
In-Reply-To: <20100520175636.GB17077@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-serial@vger.kernel.org

On Thu, 20 May 2010 10:56:36 -0700
Greg KH <greg@kroah.com> wrote:

> On Wed, May 19, 2010 at 01:01:42PM +0100, Alan Cox wrote:
> > BKL elemination using the existing locks
> 
> Hm, have all of these patches been in -next before now?  Do you think
> these are ready to go into .35?

Sorry - you asked for them to be re-sent with the BKL removal fixes from
Arnd which is for .36. They aren't needed for .35 and don't really fix
anything that would be worth backporting either.

Not .35 material.

Alan

