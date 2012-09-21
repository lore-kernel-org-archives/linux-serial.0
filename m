From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC 1/3] ARM: move serial_sa1100.h header file to
 linux/platform_data
Date: Fri, 21 Sep 2012 16:05:21 -0700
Message-ID: <20120921230521.GD4918@kroah.com>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
 <E1TEzeZ-00077r-L1@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53105 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754506Ab2IVAKe (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 20:10:34 -0400
Received: by pbbrr4 with SMTP id rr4so3651011pbb.19
        for <linux-serial@vger.kernel.org>; Fri, 21 Sep 2012 17:10:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <E1TEzeZ-00077r-L1@rmk-PC.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, Kristoffer Ericson <kristoffer.ericson@gmail.com>, Alan Cox <alan@linux.intel.com>

On Fri, Sep 21, 2012 at 10:36:07AM +0100, Russell King wrote:
> This is really driver platform data, so move it to the appropriate
> directory.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
