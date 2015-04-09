From: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Thu, 9 Apr 2015 14:00:57 +0200
Message-ID: <20150409120057.GA12596@breakpoint.cc>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
 <1418116296-12082-12-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1418116296-12082-12-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

On 2014-12-09 18:11:32 [+0900], Jiada Wang wrote:
> From: Anton Bondarenko <anton_bondarenko@mentor.com>
> 
> DMA mode for UART can be used even w/o HW flow control with RTS/CTS.
> So it need to be initialized and enabled earlier.
> 
> Signed-off-by: Anton Bondarenko <anton_bondarenko@mentor.com>
> Signed-off-by: Jiada Wang <jiada_wang@mentor.com>

How was this tested? I read you used the Sambe IMX6Q. I have here the
Wandboard which is IMX6D and a PBAB01 which is IMX6Q. Both have the same
issue with this patch, that is once DMA is enabled I receive the data in
question plus one extra byte which is 0x00.
That extra byte was not part of transaction. After that, the SDMA driver
is handling interrupts like crazing and feeding one byte data (usually
0x00 but sometimes 0x02 not sure if this new or whatever was there
before) to the core. Those one byte transaction are bogus of course.

My question is how was this tested. Before your patch none of my boards
were using DMA because RTS/CTS is not in use and this was a key
requirement. Now SDMA goes crazy. Is there a SDMA firmware required for
this to work?

Sebastian
