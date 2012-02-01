From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] qcserial: several fixes
Date: Wed, 1 Feb 2012 12:43:41 -0800
Message-ID: <20120201204341.GA28366@kroah.com>
References: <20120201203950.GA14586@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:35373 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754472Ab2BAUoA (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 1 Feb 2012 15:44:00 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 437CB20E86
	for <linux-serial@vger.kernel.org>; Wed,  1 Feb 2012 15:43:59 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20120201203950.GA14586@google.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: ttuttle <ttuttle@chromium.org>
Cc: linux-serial@vger.kernel.org, linux-usb@vger.kernel.org

On Wed, Feb 01, 2012 at 03:39:50PM -0500, ttuttle wrote:
> 1. Remove the unused "debug" parameter.
> 2. Add several new serial devices.
> 3. Disable autosuspend, as it has been flaky.
> 4. Log if we find too many altsettings.
> 
> Signed-off-by: ttuttle <ttuttle@chromium.org>

Can you split this up into 4 different patches, as you are doing 4
different things?

Remember, one patch per "thing you do".

Also, I need a "real" name in the signed-off-by area, odds are "ttuttle"
is not your "full" name, right?

thanks,

greg k-h
