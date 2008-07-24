From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCHv2] cpm_uart: Fix break generation
Date: Thu, 24 Jul 2008 10:14:57 -0500
Message-ID: <EFAF51F5-D2A4-4A8F-AB94-0A746B67E190@kernel.crashing.org>
References: <200806261338.19358.laurentp@cse-semaphore.com> <200807241621.58719.laurentp@cse-semaphore.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from gate.crashing.org ([63.228.1.57]:59631 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716AbYGXPPI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 24 Jul 2008 11:15:08 -0400
In-Reply-To: <200807241621.58719.laurentp@cse-semaphore.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org, scottwood@freescale.com


On Jul 24, 2008, at 9:21 AM, Laurent Pinchart wrote:

> When generating a break condition on a serial port, the CPM must be  
> told
> beforehand how long the break should be. Unfortunately, this  
> information is
> not available through the current serial break handling API. This  
> patch works
> around the problem by requesting a 32767 characters break followed  
> by a 0
> characters break after the requested duration. The CPM will stop the  
> first
> break when the second one is requested. This might not work with  
> future CPM
> revisions.

What do you mean by future CPM revision?  Do you mean QE?

- k
