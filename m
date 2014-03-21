From: Stanislav Meduna <stano@meduna.org>
Subject: Re: mxs-auart gives data from previous run after close and reopen
Date: Fri, 21 Mar 2014 09:21:41 +0100
Message-ID: <532BF695.3030900@meduna.org>
References: <5323625B.4010203@meduna.org> <532B985A.7060505@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.meduna.org ([92.240.244.38]:41025 "EHLO meduna.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755017AbaCUIVz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Mar 2014 04:21:55 -0400
In-Reply-To: <532B985A.7060505@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: linux-serial@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>

On 21.03.2014 02:39, Peter Hurley wrote:

> Does disabling the fifo on shutdown clear the fifo?

I did not try this, but if my theory is correct, it would
not help, as all this does is reducing the FIFO length
to one character. So you'd still get up to two characters:
one in the "FIFO" - it could get there a microsecond after
you disable the FIFO before you gate the clock - and one
being received into the shift register (garbled by shutting
down the clock in the middle of the reception that was
resumed when clock was resumed on startup). Note that one
can get preempted here, so the instructions next to each
other can be milliseconds apart in reality.

IMHO we need a soft-reset here.

Regards
-- 
                                     Stano

