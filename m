From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Wed, 06 May 2015 19:30:07 +0200
Message-ID: <554A4F9F.9000604@linutronix.de>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>	<1418116296-12082-12-git-send-email-jiada_wang@mentor.com>	<20150409120057.GA12596@breakpoint.cc>	<552B72DF.7060006@mentor.com>	<20150413080637.GA1537@breakpoint.cc>	<5530CFEF.9080807@mentor.com>	<CAH=tA9G2sPaV5uoWrW0FwHd4FUtPL-A8=jgp3p6Y9ijxDLgdTw@mail.gmail.com>	<554A3D83.8040707@linutronix.de> <CAH=tA9E7N+rfnbuQ6cWRoVz6wCXzNwxBusgv-kzJf3OYqMQyfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAH=tA9E7N+rfnbuQ6cWRoVz6wCXzNwxBusgv-kzJf3OYqMQyfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolae Rosia <nicolae.rosia@gmail.com>
Cc: jiwang <jiada_wang@mentor.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

On 05/06/2015 06:46 PM, Nicolae Rosia wrote:
> Hi,

Hi,

>> I reverted this patch. I am going to send a revert to Greg tomorrow
>> including why this is done and CC stable. I haven't yet received a
>> working SDMA firmware nor a hint where it is.
> You reverted this patch and it works again?
> I believe it is this one [1], but I will be only able to test tomorrow.

Okay, please inform about your results. I think I had that one and the
result was no UART communication at all and a lot overrun errors.

> [1] http://git.freescale.com/git/cgit.cgi/imx/linux-2.6-imx.git/tree/firmware/imx/sdma?h=imx_3.14.28_1.0.0_ga
> 
> Best regards,
> Nicolae Rosia
> 
Sebastian
