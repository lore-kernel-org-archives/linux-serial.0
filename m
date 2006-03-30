From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: ioremap_nocache() in setup_port() ok?
Date: Thu, 30 Mar 2006 08:57:52 +0100
Message-ID: <20060330075752.GA19700@flint.arm.linux.org.uk>
References: <20060330075410.GB1722@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43279 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751103AbWC3H6D (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 30 Mar 2006 02:58:03 -0500
Content-Disposition: inline
In-Reply-To: <20060330075410.GB1722@colo.lackof.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Grundler <grundler@parisc-linux.org>
Cc: linux-serial@vger.kernel.org

On Thu, Mar 30, 2006 at 12:54:10AM -0700, Grant Grundler wrote:
> Am I correct that serial also wants _nocache() for MMIO space?

Don't know - I've always taken ioremap_nocache() as a mis-understanding
of what ioremap() itself is supposed to do.  Indeed, if you look at
IO-mapping.txt, ioremap_nocache() is not mentioned, and it's pretty
clear that ioremap() is what is intended to be used to map MMIO.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
