From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] serial: sccnxp: Allows the driver to be compiled as a
 module
Date: Fri, 5 Oct 2012 09:37:15 -0700
Message-ID: <20121005163715.GA15740@kroah.com>
References: <1348996759-2449-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41675 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751745Ab2JEQhT (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Oct 2012 12:37:19 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so1956804pad.19
        for <linux-serial@vger.kernel.org>; Fri, 05 Oct 2012 09:37:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1348996759-2449-1-git-send-email-shc_work@mail.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

On Sun, Sep 30, 2012 at 01:19:19PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Thanks for this fix, but as it breaks the build when you do this, it's
kind of sad that you haven't tested it out :(

I'll go fix up that build breakage when the driver is being built by a
module and push the fixes to Linus.

thanks,

greg k-h
