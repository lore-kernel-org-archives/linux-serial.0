From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Fri, 17 Apr 2015 12:31:42 +0200
Message-ID: <5530E10E.8060808@linutronix.de>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com> <1418116296-12082-12-git-send-email-jiada_wang@mentor.com> <20150409120057.GA12596@breakpoint.cc> <552B72DF.7060006@mentor.com> <20150413080637.GA1537@breakpoint.cc> <5530CFEF.9080807@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5530CFEF.9080807@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>, Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com
List-Id: linux-serial@vger.kernel.org

On 04/17/2015 11:18 AM, jiwang wrote:
> Hello Sebastian

Hallo Jiada,

>> Please make sure it is tagged stable. There is no hint that this is
>> required
>> and as of it now, it breaks v4.0.
> Due to missing of SDMA firmware, uart sdma mode is broken,
> but it is uncovered by this commit on your environment.
> 
>> One question, where do you have the firmware from? I picked the one
>> from FSL's
>> v3.10 SDK and I ended up with FIFO-overflows so it was clearly the
>> wrong one
>> (and the built-in SDMA firmware does not work as expected as you
>> mentioned).
> I got sdma firmware from FSL kernel tree.

Can you post a link please?

>> Is this firmware only required the imx6 series or also for older
>> versions like
>> imx5?
> the firmware only supports imx6 series, AFAIK,

What I meant is if imx5 (and earlier) have a working DMA without the
SDMA firmware which seems to be required for IMX6.

> I checked with Freescale imx6 support team, due to
> licensing issue, I am not entitled to upstream FSL SDMA firmware.
> so seems currently disable SDMA support for uart is our only option
> at the moment.
Disable it please, add a hint in the source so one knows _why_ it has
been disabled and push it stable. In future you would need some kind of
a hint from the sdma driver to let the uart know that the proper
firmware is in place.

Is it okay to send a patch against the linux-firmware tree?
	https://git.kernel.org/cgit/linux/kernel/git/firmware/linux-firmware.git/

> 
> Thanks,
> Jiada

Sebastian
