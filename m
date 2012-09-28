From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty/8250_early: Prevent rounding error in uartclk to
 baud ratio
Date: Fri, 28 Sep 2012 14:03:28 +0100
Message-ID: <20120928140328.4ff68806@bob.linux.org.uk>
References: <1348834748-31565-1-git-send-email-abrodkin@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1187 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756148Ab2I1NB7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 28 Sep 2012 09:01:59 -0400
In-Reply-To: <1348834748-31565-1-git-send-email-abrodkin@synopsys.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Cc: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Vineet.Gupta1@synopsys.com

On Fri, 28 Sep 2012 16:19:08 +0400
Alexey Brodkin <Alexey.Brodkin@synopsys.com> wrote:

> Modify divisor to select the nearest baud rate divider rather than the
> lowest. It minimizes baud rate errors especially on low UART clock
> frequencies.
> 
> For example, if uartclk is 33000000 and baud is 115200 the ratio is
> about 17.9 The current code selects 17 (5% error) but should select 18
> (0.5% error).
> 
> On the same lines as following:
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc3/2.6.9-rc3-mm2/broken-out/serial-pick-nearest-baud-rate-divider.patch
> 
> Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>

Seems sensible to me.

Acked-by: Alan Cox <alan@linux.intel.com>
