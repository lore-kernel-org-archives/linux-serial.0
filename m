From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH V5] tty/serial: add support for Xilinx PS UART
Date: Fri, 29 Apr 2011 16:37:19 -0700
Message-ID: <20110429233719.GA25417@kroah.com>
References: <fd084891-aef0-4a0d-afac-168819ead5f2@VA3EHSMHS026.ehs.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:54108 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759084Ab1D3AHq (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 29 Apr 2011 20:07:46 -0400
Content-Disposition: inline
In-Reply-To: <fd084891-aef0-4a0d-afac-168819ead5f2@VA3EHSMHS026.ehs.local>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: johnlinn@comcast.net
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, alan@lxorguk.ukuu.org.uk, michal.simek@petalogix.com, joe@perches.com, grant.likely@secretlab.ca, John Linn <john.linn@xilinx.com>

On Fri, Apr 29, 2011 at 03:59:06PM -0600, johnlinn@comcast.net wrote:
> From: John Linn <john.linn@xilinx.com>
> 
> The Xilinx PS Uart is used on the new ARM based SoC. This
> UART is not compatible with others such that a seperate
> driver is required.
> 
> Signed-off-by: John Linn <john.linn@xilinx.com>

That's fine, but:

> 
> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
>

That means I can't apply this patch :(

{sigh}

Please fix this, as it does not allow you to participate in kernel
development efforts.

greg k-h
