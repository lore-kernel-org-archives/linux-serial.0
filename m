From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Adding a serial device
Date: Tue, 24 Sep 2013 06:44:52 -0700
Message-ID: <20130924134452.GB7246@kroah.com>
References: <loom.20130924T092704-635@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:33244 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3IXNny (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 24 Sep 2013 09:43:54 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130924T092704-635@post.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Federico Natali <federico.natali@selex-es.com>
Cc: linux-serial@vger.kernel.org

On Tue, Sep 24, 2013 at 08:49:48AM +0000, Federico Natali wrote:
> 
> Hi to everyone, 
> 
> I'm quite new at kernel hacking and I'm having problems trying to make a 
> serial device work on a custom board.
> 
> I hope this is the right place for asking support, if not I'd be grateful 
> if could you point me to the right place.
> 
> My situation is as follows:
> 
> I'm working on a custom board based on the ARM SoC DM8168 by Texas 
> Instruments and I'm using a Linux distribution from TI based on 2.6.37 
> kernel

As you are stuck on a really old, and obsolete kernel, that was provided
by a vendor, there's almost nothing we can do here to help with this.  I
suggest you contact the vendor as they are the best ones to help out,
especially as you are paying for support from them for this codebase.

Best of luck,

greg k-h
