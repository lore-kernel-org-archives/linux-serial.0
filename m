From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: [PATCH] Fix compile error in 8250_au1x00.c
Date: Wed, 8 Feb 2006 21:36:47 +0000
Message-ID: <20060208213647.GB8587@flint.arm.linux.org.uk>
References: <20060207211500.GC5227@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:18705 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S965143AbWBHVgz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 8 Feb 2006 16:36:55 -0500
Content-Disposition: inline
In-Reply-To: <20060207211500.GC5227@cosmic.amd.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org

On Tue, Feb 07, 2006 at 02:15:00PM -0700, Jordan Crouse wrote:
> The DB1550 actually doesn't have a UART2.  Remove it from the list.

Applied, thanks.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
