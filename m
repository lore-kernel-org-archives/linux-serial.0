From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: prepare for 9bit data
Date: Thu, 26 Sep 2013 15:47:55 -0700
Message-ID: <20130926224755.GA15399@kroah.com>
References: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:35438 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754523Ab3IZWr4 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Sep 2013 18:47:56 -0400
Content-Disposition: inline
In-Reply-To: <1379938052-6026-1-git-send-email-jiri.prchal@aksignal.cz>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jiri Prchal <jiri.prchal@aksignal.cz>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, nicolas.ferre@atmel.com

On Mon, Sep 23, 2013 at 02:07:32PM +0200, Jiri Prchal wrote:
> This patch adds 9bit data possibility for serial_core. Please confirm that I did it right way at right place. I'll make atmel_serial driver for 9bit data later.

Please wrap your lines properly.

I'd rather wait to add this type of patch _after_ you have tested it and
verified that your driver works, and take that patch at the same time.

Otherwise, this is just added cruft that no one is using, and I'd have
to remove it :)

thanks,

greg k-h
