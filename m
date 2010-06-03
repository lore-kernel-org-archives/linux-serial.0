From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial: add support for various Titan PCI cards
Date: Thu, 3 Jun 2010 10:35:58 -0700
Message-ID: <20100603173558.GB9307@kroah.com>
References: <4C0675CE.4090305@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:58928 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757086Ab0FCRxG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 3 Jun 2010 13:53:06 -0400
Content-Disposition: inline
In-Reply-To: <4C0675CE.4090305@visionsystems.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Yegor Yefremov <yegor_sub1@visionsystems.de>
Cc: linux-serial@vger.kernel.org, gregkh@suse.de

On Wed, Jun 02, 2010 at 05:16:30PM +0200, Yegor Yefremov wrote:
> Index: b/include/linux/pci_ids.h

If you look at the top of this file, it says we are not adding new
entries to it except for ids that are in more than one file.

So, care to redo this patch without touching this file?  I'll be glad to
take it that way.

thanks,

greg k-h
