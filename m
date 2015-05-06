From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Wed, 06 May 2015 18:12:51 +0200
Message-ID: <554A3D83.8040707@linutronix.de>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>	<1418116296-12082-12-git-send-email-jiada_wang@mentor.com>	<20150409120057.GA12596@breakpoint.cc>	<552B72DF.7060006@mentor.com>	<20150413080637.GA1537@breakpoint.cc>	<5530CFEF.9080807@mentor.com> <CAH=tA9G2sPaV5uoWrW0FwHd4FUtPL-A8=jgp3p6Y9ijxDLgdTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH=tA9G2sPaV5uoWrW0FwHd4FUtPL-A8=jgp3p6Y9ijxDLgdTw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <nicolae.rosia@gmail.com>, jiwang <jiada_wang@mentor.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

On 05/06/2015 06:08 PM, Nicolae Rosia wrote:
> Hi,
> I believe I'm also affected by this BUG. I'm receiving lots of 0 and 1
> (ASCII, as presented by cat /dev/ttymxcX) and RX buffer is
> overflowing.
> 
>> the firmware only supports imx6 series, AFAIK,
>> I checked with Freescale imx6 support team, due to
>> licensing issue, I am not entitled to upstream FSL SDMA firmware.
>> so seems currently disable SDMA support for uart is our only option
>> at the moment.
>>
> 
> Have you submited a patch for this issue?
> How do I disable SDMA?

I reverted this patch. I am going to send a revert to Greg tomorrow
including why this is done and CC stable. I haven't yet received a
working SDMA firmware nor a hint where it is.

> Best regards,
> Nicolae Rosia

Sebastian
