From: Greg KH <greg@kroah.com>
Subject: Re: [PATCHv2 1/2] amba pl011: workaround for uart registers lockup
Date: Tue, 17 May 2011 11:23:56 -0700
Message-ID: <20110517182356.GA17703@kroah.com>
References: <20110516172958.GA13011@kroah.com>
 <1305609617-9524-1-git-send-email-shreshthakumar.sahu@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34472 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756074Ab1EQSYG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 17 May 2011 14:24:06 -0400
Content-Disposition: inline
In-Reply-To: <1305609617-9524-1-git-send-email-shreshthakumar.sahu@stericsson.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Shreshtha Kumar SAHU <shreshthakumar.sahu@stericsson.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, rmk+kernel@arm.linux.org.uk, linus.walleij@stericsson.com, alan@linux.intel.com

On Tue, May 17, 2011 at 10:50:17AM +0530, Shreshtha Kumar SAHU wrote:
> From: Shreshtha Kumar Sahu <shreshthakumar.sahu@stericsson.com>
> 
> This workaround aims to break the deadlock situation
> which raises during continuous transfer of data for long
> duration over uart with hardware flow control. It is
> observed that CTS interrupt cannot be cleared in uart
> interrupt register (ICR). Hence further transfer over
> uart gets blocked.
> 
> It is seen that during such deadlock condition ICR
> don't get cleared even on multiple write. This leads
> pass_counter to decrease and finally reach zero. This
> can be taken as trigger point to run this UART_BT_WA.
> 
> Workaround backups the register configuration, does soft
> reset of UART using BIT-0 of PRCC_K_SOFTRST_SET/CLEAR
> registers and restores the registers.
> 
> This patch also provides support for uart init and exit
> function calls if present.

Why?  You don't use these callbacks in this driver, so why add them?

confused,

greg k-h
