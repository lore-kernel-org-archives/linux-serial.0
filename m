From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] 8250/16?50: Add support for Broadcom TruManage
 redirected serial port
Date: Tue, 11 Dec 2012 20:45:22 -0800
Message-ID: <20121212044522.GA7224@kroah.com>
References: <156984479488CD49A184F5CAB4AF934606FF55F8@IRVEXCHMB14.corp.ad.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-da0-f54.google.com ([209.85.210.54]:46321 "EHLO
	mail-da0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab2LLGY1 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 12 Dec 2012 01:24:27 -0500
Received: by mail-da0-f54.google.com with SMTP id n2so119953dad.13
        for <linux-serial@vger.kernel.org>; Tue, 11 Dec 2012 22:24:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <156984479488CD49A184F5CAB4AF934606FF55F8@IRVEXCHMB14.corp.ad.broadcom.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Hurd <shurd@broadcom.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Dec 12, 2012 at 01:11:47AM +0000, Stephen Hurd wrote:
> It appears that the modification to include/uapi/linux/serial_core.h is excluded by the dontdiff filters.  I've attached an updated patch including it.

Care to resend the whole thing, I need it with the signed-off-by: line.

Also, base64 attachments really don't work well, if at all.  You might
be forced to use Outlook, but Exchange can send patches if you configure
it properly.  Please talk to your Broadcom coworkers for how to do this
properly, they know how to do it.

thanks,

greg k-h
