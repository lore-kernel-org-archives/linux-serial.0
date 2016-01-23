From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/4] tty: serial: 8250: omap: convert to using cyclic
 transfers
Date: Sat, 23 Jan 2016 13:24:30 -0800
Message-ID: <56A3EF8E.6020204@hurleysoftware.com>
References: <87zivxq57d.fsf@linutronix.de>
 <56A25959.4060802@hurleysoftware.com> <56A3DF17.2070908@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56A3DF17.2070908@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: dan.j.williams@intel.com, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 01/23/2016 12:14 PM, Sebastian Andrzej Siewior wrote:
> On 01/22/2016 05:31 PM, Peter Hurley wrote:
>> Hi John,
>>
>> On 01/22/2016 02:27 AM, John Ogness wrote:
>>> Note that an ugly device-tree lookup hack is implemented in order
>>> to detect if the sDMA engine is being used. This is necessary
>>> because the sDMA driver does not implement pause/resume correctly
>>> and therefore requires slightly different logic for the UART
>>> driver.
>>
>> No, this is not acceptable.
>>
>> Please work with Vinod to refine the dma_get_slave_caps() interface
>> so that dmaengine drivers that don't provide the _documented_ pause/resume
>> support can be identified generically.
> 
> But we could implement the pause/resume bits correctly wait until it is
> merge and post this and rely on the fact that it works (including error
> checking). RMK requested that he wants the UART driver fixed before
> touching the DMA driver and this has been done in meantime. So we could
> go ahead and add the missing pieces to SDMA.

There is zero chance of backporting this.
Let's move forward and fix the problem.

At a minimum, the reason this code needs to know which DMA slave driver
is because the sDMA driver lies about pause support. Rather than continuing
to hide this broken behavior behind the dmaengine API, expose a method
of generically determining what the slave driver actually does.
It's the only sane choice.

Regards,
Peter Hurley

FWIW, I'm not convinced about cyclic transfers. But doing a complete review
of that is a bit off.
