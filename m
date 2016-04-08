From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 06/12] serial: 8250_dma: stop ongoing RX DMA on exception
Date: Fri, 8 Apr 2016 11:07:39 +0300
Message-ID: <CAHp75VdYEEwBx+G=2D_q5M1DpUWsyHn9JZbYhb4GQeJNJwv9yw@mail.gmail.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1460061433-63750-7-git-send-email-andriy.shevchenko@linux.intel.com>
	<5706F325.6090001@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5706F325.6090001@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Apr 8, 2016 at 2:54 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 04/07/2016 01:37 PM, Andy Shevchenko wrote:
>> If we get an exeption interrupt. i.e. UART_IIR_RLSI, stop any ongoing RX DMA
>> transfer otherwise it might generates more spurious interrupts and make port
>> unavailable anymore.
>
> Then how to know which rx byte the error is for if dma continues anyway?
> What if there are multiple error bytes?

And how should it work?
We get an interrupt during DMA, if we don't stop DMA it will be racy
with direct readings.

>
>
>> As has been seen on Intel Broxton system:
>
> This system shouldn't be setup for UART DMA imo.

Same approach is done in 8250_omap.

-- 
With Best Regards,
Andy Shevchenko
