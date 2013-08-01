From: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 14/35] serial: use dev_get_platdata()
Date: Wed, 31 Jul 2013 17:55:29 -0700
Message-ID: <20130801005529.GA23602@kroah.com>
References: <003f01ce8cfb$c334cb20$499e6160$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:41696 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab3HAHaI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 1 Aug 2013 03:30:08 -0400
Content-Disposition: inline
In-Reply-To: <003f01ce8cfb$c334cb20$499e6160$@samsung.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Jiri Slaby' <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Tue, Jul 30, 2013 at 05:06:57PM +0900, Jingoo Han wrote:
> Use the wrapper function for retrieving the platform data instead of
> accessing dev->platform_data directly.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>

This didn't fully apply to my tree, so I took all of the chunks that
did.  Care to resend just the one driver that I missed as an add-on
patch?

thanks,

greg k-h
