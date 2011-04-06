From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 17:53:50 +0100
Message-ID: <20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
References: <ini5hh$7s3$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:57116 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755291Ab1DFQxJ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 12:53:09 -0400
In-Reply-To: <ini5hh$7s3$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

On Wed, 6 Apr 2011 16:48:49 +0000 (UTC)
Grant Edwards <grant.b.edwards@gmail.com> wrote:

> I'm working on a driver for a serial board that supports 921600 bps,
> and it would be awfully nice if there was a way to specify that using
> the ASYNC_SPD_xxxxx mechanism.  Is there any reason why this wouldn't
> work?

The ASYNC_SPD_xxxx mechanism is obsolete. Just set the baud rate to
921600, the kernel has supported arbitary baud rates for some time.

