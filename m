From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv2] cpm_uart: Support uart_wait_until_sent()
Date: Wed, 2 Jul 2008 11:13:52 -0500
Message-ID: <FF9F9674-03B4-4FD1-9B01-8DC0972F6899@kernel.crashing.org>
References: <200806261355.09334.laurentp@cse-semaphore.com> <4768A00D-3C8B-4AF2-A2E1-DE9C9BD055E4@kernel.crashing.org> <200807021058.45619.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v924)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:39702 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754432AbYGBQOA (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Jul 2008 12:14:00 -0400
In-Reply-To: <200807021058.45619.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org


On Jul 2, 2008, at 3:58 AM, Laurent Pinchart wrote:

> Set port->fifosize to the software FIFO size, and update the port  
> timeout
> when the baud rate is modified. SCC ports have an optional 32 byte  
> hardware
> FIFO which is currently not taken into account, as there is no  
> documented way
> to check when the FIFO becomes empty.
>
> Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
> ---
> drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
> 1 files changed, 6 insertions(+), 0 deletions(-)

applied.

- k
