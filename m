From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 3/4] tty: serial: 8250: omap: convert to using cyclic
 transfers
Date: Fri, 22 Jan 2016 08:31:21 -0800
Message-ID: <56A25959.4060802@hurleysoftware.com>
References: <87zivxq57d.fsf@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87zivxq57d.fsf@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: John Ogness <john.ogness@linutronix.de>, gregkh@linuxfoundation.org, vinod.koul@intel.com
Cc: dan.j.williams@intel.com, bigeasy@linutronix.de, tony@atomide.com, nsekhar@ti.com, peter.ujfalusi@ti.com, dmaengine@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi John,

On 01/22/2016 02:27 AM, John Ogness wrote:
> Note that an ugly device-tree lookup hack is implemented in order
> to detect if the sDMA engine is being used. This is necessary
> because the sDMA driver does not implement pause/resume correctly
> and therefore requires slightly different logic for the UART
> driver.

No, this is not acceptable.

Please work with Vinod to refine the dma_get_slave_caps() interface
so that dmaengine drivers that don't provide the _documented_ pause/resume
support can be identified generically.

Regards,
Peter Hurley
