From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: Someting's busted with serial in 2.6.11 latest
Date: Thu, 10 Mar 2005 19:53:26 +0000
Message-ID: <20050310195326.A1044@flint.arm.linux.org.uk>
References: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33803 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262907AbVCJTxa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 10 Mar 2005 14:53:30 -0500
Content-Disposition: inline
In-Reply-To: <20050309155049.4e7cb1f4@dxpl.pdx.osdl.net>; from shemminger@osdl.org on Wed, Mar 09, 2005 at 03:50:49PM -0800
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Mar 09, 2005 at 03:50:49PM -0800, Stephen Hemminger wrote:
> Some checkin since 2.6.11 has caused the serial driver to
> drop characters.  Console output is chopped and messages are garbled.
> Even the shell prompt gets truncated.

There was a problem with 2.6.11-bk1 which should now be resolved.

Is this still true of the latest bk kernel?  Also, seeing the kernel
messages may provide some hint.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
