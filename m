From: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [PATCH] serial 8250: tighten test for using backup timer
Date: Tue, 05 Aug 2008 14:06:43 -0600
Message-ID: <1217966803.17091.72.camel@2710p.home>
References: <1205945437.6881.13.camel@lappy>
	 <87a5b0800808050444t49480549t758f954c40139c4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:8355 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758395AbYHEUGr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Aug 2008 16:06:47 -0400
In-Reply-To: <87a5b0800808050444t49480549t758f954c40139c4a@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Thomas Koeller <thomas@koeller.dyndns.org>

Hi Will,

On Tue, 2008-08-05 at 12:44 +0100, Will Newton wrote:
> Hi,
> 
> Sorry to not have picked up on this earlier, but this change seems to
> break an old DesignWare UART I have in an SoC here. It has a number of
> known issues, one of which is it does not appropriately reassert THRE.
> 
> What seems to happen is that the first time the port is opened the
> code tests for incorrect reassertion of THRE and correctly sets up the
> backup timer. The port is closed and subsequently reopened and this
> time around the new logic prevents the backup timer from being
> enabled. I'm not 100% sure of the details of the bug that is being
> worked around here, but it appears that the second time the port is
> opened it is not possible to detect the bug because the previous THRE
> condition has already been acknowledged.
> 
> The attached patch fixes the problem for me and attempts to preserve
> the new behaviour at the same time. Comments?

It would be nice if there was a simple procedure we could do on the UART
to reset it to a state so the test works repeatedly.  However, with all
the buggy UARTs out there, that could end up disturbing someone else.

This change works for me, though it is using up a bit in the bugs field;
not that we seem to be allocating them at any great rate.  I think it
would be worthy of a comment in the code to understand why this new
block exists outside the test so we don't need to refer back to the
commit changeset.

Acked-by: Alex Williamson <alex.williamson@hp.com>

Thanks, Alex

-- 
Alex Williamson                             HP Open Source & Linux Org.

