From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [GIT PATCH] Serial updates
Date: Thu, 23 Jun 2005 22:27:28 +0100
Message-ID: <20050623222728.C12573@flint.arm.linux.org.uk>
References: <20050623193304.GA15536@dyn-67.arm.linux.org.uk> <42BB2027.3090800@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262711AbVFWV2q@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <42BB2027.3090800@didntduck.org>; from bgerst@didntduck.org on Thu, Jun 23, 2005 at 04:48:39PM -0400
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Jun 23, 2005 at 04:48:39PM -0400, Brian Gerst wrote:
> Russell King wrote:
> > +
> > +		if (up->capabilities & UART_BUG_TXEN) {
> 
> Shouldn't this be up->bugs?

Whoops, thanks for spotting that, Brian.  Fixed in all places.
(Guess who forgot to update one of the patches...)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
