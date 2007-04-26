From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/8] serial 8250: move push calls out of lock
Date: Thu, 26 Apr 2007 21:35:17 +0100
Message-ID: <20070426213517.3d55558e@the-village.bc.nu>
References: <20070426184620.GA25521@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:35855 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1031508AbXDZUbf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 26 Apr 2007 16:31:35 -0400
In-Reply-To: <20070426184620.GA25521@localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: minyard@acm.org
Cc: linux-serial@vger.kernel.org

On Thu, 26 Apr 2007 13:46:20 -0500
Corey Minyard <minyard@acm.org> wrote:

> Ok, again trying this out with a new approach.
> 
> Subject: serial 8250: move push calls out of lock
> 
> Due to previous changes in the 8250 driver, the call to
> tty_flip_buffer_push is now done with interrupts disabled.  Not really
> a huge deal, but sub-optimal.

This is actually a very good idea as it means you don't have to deal with
the problems with low_latency causing re-entry into the driver under the
lock so its conceptually much easier to follow the locking


Acked-by: Alan Cox <alan@redhat.com>
