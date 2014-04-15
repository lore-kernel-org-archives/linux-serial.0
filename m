From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Question regarding serial_core.h port type
Date: Tue, 15 Apr 2014 08:22:31 -0700
Message-ID: <20140415152231.GB7311@kroah.com>
References: <20140415140956.GA25718@jtlinux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:59928 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754668AbaDOPT3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 15 Apr 2014 11:19:29 -0400
Content-Disposition: inline
In-Reply-To: <20140415140956.GA25718@jtlinux>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Johannes Thumshirn <johannes.thumshirn@men.de>
Cc: linux-serial@vger.kernel.org

On Tue, Apr 15, 2014 at 04:09:56PM +0200, Johannes Thumshirn wrote:
> Hi,
> 
> I have a question regarding the port type constants in serial_core.h. Is there
> any "official" assignment scheme, or is it ok to just grab/append an unused
> number?

You can get a new number when you submit a patch with your driver.

> Or is it even possible/allowed to reuse an existing number from the list?

No, please don't do that.

thanks,

greg k-h
