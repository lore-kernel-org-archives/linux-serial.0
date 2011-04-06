From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Add new ASYNC_SPD_WARP13?
Date: Wed, 6 Apr 2011 20:14:57 +0100
Message-ID: <20110406201457.1a5402ba@lxorguk.ukuu.org.uk>
References: <ini5hh$7s3$1@dough.gmane.org>
	<20110406175350.64bd2f23@lxorguk.ukuu.org.uk>
	<ini6in$gno$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:45372 "EHLO
	www.etchedpixels.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751879Ab1DFTOQ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Apr 2011 15:14:16 -0400
In-Reply-To: <ini6in$gno$1@dough.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Edwards <grant.b.edwards@gmail.com>
Cc: linux-serial@vger.kernel.org

> I could tell them to go the SPD_CUST route to get 921600, but I was
> hoping to provide an option that would support 921600 the same way
> that 57600, 230400, and 460800 are supported.

And no doubt in time other speeds as well.

ASYNC_SPD_xxx is legacy, it remains simply because we provided it as a
historic interface to some drivers and we don't want to break stuff

So please use SPD_CUST if you must do this.

Alan
