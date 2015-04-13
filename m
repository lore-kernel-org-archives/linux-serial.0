From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Mon, 13 Apr 2015 10:06:37 +0200
Message-ID: <20150413080637.GA1537@breakpoint.cc>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
 <1418116296-12082-12-git-send-email-jiada_wang@mentor.com>
 <20150409120057.GA12596@breakpoint.cc>
 <552B72DF.7060006@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552B72DF.7060006@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com, bigeasy@linutronix.de
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 13, 2015 at 04:40:15PM +0900, jiwang wrote:
> Hi Sebastian
Hi Jiada,

> >My question is how was this tested. Before your patch none of my boards
> >were using DMA because RTS/CTS is not in use and this was a key
> >requirement. Now SDMA goes crazy. Is there a SDMA firmware required for
> >this to work?
> We tested the patch set with our modified kernel tree,
> and I find upstream kernel is not building SDMA firmware,
> I will submit another patch to add it.

Please make sure it is tagged stable. There is no hint that this is required
and as of it now, it breaks v4.0.
One question, where do you have the firmware from? I picked the one from FSL's
v3.10 SDK and I ended up with FIFO-overflows so it was clearly the wrong one
(and the built-in SDMA firmware does not work as expected as you mentioned).

Is this firmware only required the imx6 series or also for older versions like
imx5?

> Thanks,
> Jiada

Sebastian
