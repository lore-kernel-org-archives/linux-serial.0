From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: ifx6x60: ifx_spi_write don't need to do
 mrdy_assert when fifo is not empty.
Date: Sat, 17 Nov 2012 19:30:12 -0800
Message-ID: <20121118033012.GA2394@kroah.com>
References: <1353064117.24092.4.camel@chenjun-workstation>
 <20121116123834.GA9327@kroah.com>
 <9E44E06DBBA23A489DED933DBC291A850FD7A645@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:33275 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752550Ab2KRD3T (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 17 Nov 2012 22:29:19 -0500
Content-Disposition: inline
In-Reply-To: <9E44E06DBBA23A489DED933DBC291A850FD7A645@SHSMSX102.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Chen, Jun D" <jun.d.chen@intel.com>
Cc: Alan Cox <alan@linux.intel.com>, "Bi, Chao" <chao.bi@intel.com>, serial <linux-serial@vger.kernel.org>, "Gorby, Russ" <russ.gorby@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Wu, Fengguang" <fengguang.wu@intel.com>


http://daringfireball.net/2007/07/on_top

On Sun, Nov 18, 2012 at 03:14:28AM +0000, Chen, Jun D wrote:
> Hi,
>    I make this patch on your tty-next tree,  Do I need to make it on the branch 3.7-rc6 against?

No, my tty-next branch.  But something is odd, it didn't apply at all.
Please try again.

thanks,

greg k-h
