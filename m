From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 04/12] gpio-sch: Fix resource leak
Date: Tue, 26 Jun 2012 19:25:23 -0700
Message-ID: <20120627022523.GA3380@kroah.com>
References: <20120622153600.1405.15575.stgit@localhost.localdomain>
 <20120622154040.1405.28472.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:39936 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751159Ab2F0CZZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 26 Jun 2012 22:25:25 -0400
Content-Disposition: inline
In-Reply-To: <20120622154040.1405.28472.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Fri, Jun 22, 2012 at 04:42:40PM +0100, Alan Cox wrote:
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> ---
> 
>  drivers/gpio/gpio-sch.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Is this a serial driver?  I can't take this :(

greg k-h
