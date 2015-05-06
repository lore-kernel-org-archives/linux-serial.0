From: Nicolae Rosia <nicolae.rosia@gmail.com>
Subject: Re: [PATCH v1 11/15] serial: imx: initialized DMA w/o HW flow enabled
Date: Wed, 6 May 2015 19:08:13 +0300
Message-ID: <CAH=tA9G2sPaV5uoWrW0FwHd4FUtPL-A8=jgp3p6Y9ijxDLgdTw@mail.gmail.com>
References: <1418116296-12082-1-git-send-email-jiada_wang@mentor.com>
	<1418116296-12082-12-git-send-email-jiada_wang@mentor.com>
	<20150409120057.GA12596@breakpoint.cc>
	<552B72DF.7060006@mentor.com>
	<20150413080637.GA1537@breakpoint.cc>
	<5530CFEF.9080807@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5530CFEF.9080807@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jiwang <jiada_wang@mentor.com>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, anton_bondarenko@mentor.com, dirk.behme@de.bosch.com, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-serial@vger.kernel.org

Hi,
I believe I'm also affected by this BUG. I'm receiving lots of 0 and 1
(ASCII, as presented by cat /dev/ttymxcX) and RX buffer is
overflowing.

> the firmware only supports imx6 series, AFAIK,
> I checked with Freescale imx6 support team, due to
> licensing issue, I am not entitled to upstream FSL SDMA firmware.
> so seems currently disable SDMA support for uart is our only option
> at the moment.
>

Have you submited a patch for this issue?
How do I disable SDMA?

Best regards,
Nicolae Rosia
