From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial:ifx6x60:Delete SPI timer when shut down port
Date: Mon, 26 Nov 2012 15:45:53 -0800
Message-ID: <20121126234553.GA14899@kroah.com>
References: <1353634413.22077.15.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:39179 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754842Ab2KZXpz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 26 Nov 2012 18:45:55 -0500
Content-Disposition: inline
In-Reply-To: <1353634413.22077.15.camel@bichao>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: chao bi <chao.bi@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, richardx.r.gorby@intel.com, jun.d.chen@intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Nov 23, 2012 at 09:33:33AM +0800, chao bi wrote:
> 
> When shut down SPI port, it's possible that MRDY has been asserted and a SPI
> timer was activated waiting for SRDY assert, in the case, it needs to delete
> this timer.

This doesn't apply without fuzz, so I don't know what tree you are
working against here.

Please redo it against the latest version of the tty-next tree.

greg k-h
