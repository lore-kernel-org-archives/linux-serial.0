From: Greg KH <greg@kroah.com>
Subject: Re: [RFC PATCH 0/6] Rework tty helpers to avoid need for file
 pointers
Date: Mon, 14 Feb 2011 16:58:03 -0800
Message-ID: <20110215005803.GA26879@kroah.com>
References: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:48256 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750800Ab1BOA6q (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 Feb 2011 19:58:46 -0500
Content-Disposition: inline
In-Reply-To: <20110214162438.10571.8203.stgit@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Feb 14, 2011 at 04:25:51PM +0000, Alan Cox wrote:
> (and then use this to fix the holes in hci_ath)
> 
> The cleanup wants doing anyway but we have a reason for needing to do it.

This all looks great, thanks for doing this work.  I'll queue it up in a
few days, unless there are any objections?

thanks,

greg k-h
