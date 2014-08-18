From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v7] 8250-core based serial driver for OMAP + DMA
Date: Mon, 18 Aug 2014 11:15:17 -0400
Message-ID: <53F21885.605@hurleysoftware.com>
References: <1408124563-31541-1-git-send-email-bigeasy@linutronix.de> <20140815181704.GH17769@csclub.uwaterloo.ca> <53EE5BF8.3010007@linutronix.de> <20140815202826.GC9239@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20140815202826.GC9239@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Vinod Koul <vinod.koul@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-serial@vger.kernel.org

On 08/15/2014 04:28 PM, Tony Lindgren wrote:
> * Sebastian Andrzej Siewior <bigeasy@linutronix.de> [140815 12:16]:
>> On 08/15/2014 08:17 PM, Lennart Sorensen wrote:
>>
>>> Are you saying that with the new driver you have to respond to the RX
>>> irq faster than before to avoid overflows?  It is not quite clear.
>>
>> Yes. The irq fires 46 bytes giving you 16 bytes buffer before overflow
>> vs 63 bytes buffer the old one had.
>>
>>> I do think 40000 interrupts to handle 40000 bytes of date does seem a
>>> tad inefficient, so dropping to 854 looks a lot nicer.  Was the omap
>>> driver not using the fifo trigger levels at all?
>>
>> It configured the trigger levels to 1 for RX and 16 for TX.
> 
> Hmm that weird RX trigger level is a workaround for lost characters.
> 
> See commit 0ba5f66836 (tty: serial: OMAP: use a 1-byte RX FIFO
> threshold in PIO mode :)

That commit looks like it should have been specific to the silicon
exhibiting the rx timeout bug.

Regards,
Peter Hurley

