From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH v1 06/12] serial: 8250_dma: stop ongoing RX DMA on
 exception
Date: Fri, 8 Apr 2016 16:20:58 -0700
Message-ID: <57083CDA.4090709@hurleysoftware.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1460061433-63750-7-git-send-email-andriy.shevchenko@linux.intel.com>
 <5706F325.6090001@hurleysoftware.com>
 <CAHp75VdYEEwBx+G=2D_q5M1DpUWsyHn9JZbYhb4GQeJNJwv9yw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VdYEEwBx+G=2D_q5M1DpUWsyHn9JZbYhb4GQeJNJwv9yw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 04/08/2016 01:07 AM, Andy Shevchenko wrote:
> On Fri, Apr 8, 2016 at 2:54 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
>>> If we get an exeption interrupt. i.e. UART_IIR_RLSI, stop any ongoing RX DMA
>>> transfer otherwise it might generates more spurious interrupts and make port
>>> unavailable anymore.
>>
>> Then how to know which rx byte the error is for if dma continues anyway?
>> What if there are multiple error bytes?
> 
> And how should it work?
> We get an interrupt during DMA, if we don't stop DMA it will be racy
> with direct readings.

It makes sense to me that the ongoing DMA needs paused, flushed & terminated,
but the UART should have already aborted the DMA at the first error byte,
so it doesn't make sense to me that the DMA hardware went sideways.

Have you verified that the actual byte in error is reported as the frame/parity
byte and that error-free data is unmangled? Like with a data pattern and a logic
analyzer?


>>
>>
>>> As has been seen on Intel Broxton system:
>>
>> This system shouldn't be setup for UART DMA imo.
> 
> Same approach is done in 8250_omap.

Well, omap8250 has totally different (and possibly unnecessary) rx dma flow.

During the development of the omap8250 driver, it was discovered that the
normal 8250 rx dma flow didn't work reliably on OMAP; ie., the rx dma wouldn't
start once rx uart interrupt had already happened.

*So omap8250 sets up rx dma before any data has been received*
That's the dma that is cancelled when an RLSI interrupt is received;
on OMAP the residue is always 0.

Well, it turns out that the omap8250 rx dma flow *may* be limited to only
1 specific design, the am335x, which has a bunch of other dma issues, with
both tx and rx dma. So all that omap8250 dma handling might be going
away anyway.

IOW, omap8250 is a terrible dma model; do not use.
[Granted the current model needs some work as well; eg., using ping-pong
dma buffers to weather dmaengine descriptor completion latency).

Regards,
Peter Hurley
