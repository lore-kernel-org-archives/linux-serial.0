From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v1 12/12] serial: 8250_lpss: enable DMA on Intel Quark
 UART
Date: Wed, 13 Apr 2016 12:22:45 +0100
Message-ID: <1460546565.19152.148.camel@nexus-software.ie>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460061433-63750-13-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460388795.19152.38.camel@nexus-software.ie>
	 <CAHp75Vc3P=D47VtQ2JhbcMfx3xam0Bqp9gUW79jt32ThKzVULw@mail.gmail.com>
	 <1460478320.19152.92.camel@nexus-software.ie>
	 <1460479824.6620.121.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460479824.6620.121.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, 2016-04-12 at 19:50 +0300, Andy Shevchenko wrote:
> > I haven't read your V2 yet but on this, I'd suggest raising the
> burst
> > size to 32 bytes for UART (no higher) we found during bringup that
> > larger sizes "fall-over and die" but, anything up to 32 bytes is OK
> -
> > and therefore you should be able to reduce the number of
> > bursts/interrupts etc.
> 
> It can't be more that FIFO size and recommendation as far as I know
> is
> FIFO/2, which is exactly 8 bytes.

Why not ?

We went as high as 32 bytes previously in the BSP with no obvious
errors.

At 8 bytes or 1/2 of the FIFO size I'd ask the question is DMA even
worth it i.e. does it take more time to setup and execute a DMA
transaction @ 1/2 FIFO size than just writing straight into the FIFO ?

---
bod
