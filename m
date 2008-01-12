From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] serial: remove "too much work for irq" printk
Date: Sat, 12 Jan 2008 20:21:47 +0000
Message-ID: <20080112202147.GA2730@infradead.org>
References: <20080112201543.GB12775@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:33251 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762610AbYALUVv (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 12 Jan 2008 15:21:51 -0500
Content-Disposition: inline
In-Reply-To: <20080112201543.GB12775@kvack.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: akpm@osdl.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Jan 12, 2008 at 03:15:43PM -0500, Benjamin LaHaise wrote:
> When using kvm with a serial console, the serial driver will print out 
> "too much work for irq4" on any heavy activity (ie vi on a file repainting 
> the terminal).  This message is entirely spurious, as output continues to 
> work fine.  Remove the message as it corrupts screen output and is far too 
> easy to trigger.

Yeah, this message has been annoying me too.  Thanks for sending the
patch.

