From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCHv2 1/2] amba pl011: workaround for uart registers lockup
Date: Tue, 17 May 2011 19:30:15 +0100
Message-ID: <20110517183015.GA15422@flint.arm.linux.org.uk>
References: <20110516172958.GA13011@kroah.com> <1305609617-9524-1-git-send-email-shreshthakumar.sahu@stericsson.com> <20110517182356.GA17703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:40476 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756067Ab1EQSag (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 May 2011 14:30:36 -0400
Content-Disposition: inline
In-Reply-To: <20110517182356.GA17703@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linus.walleij@stericsson.com, alan@linux.intel.com

On Tue, May 17, 2011 at 11:23:56AM -0700, Greg KH wrote:
> Why?  You don't use these callbacks in this driver, so why add them?

Did you look at the second patch?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
