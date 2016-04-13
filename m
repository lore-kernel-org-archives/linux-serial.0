From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 12/12] serial: 8250_lpss: enable DMA on Intel Quark
 UART
Date: Wed, 13 Apr 2016 17:48:11 +0300
Message-ID: <1460558891.6620.147.camel@linux.intel.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460061433-63750-13-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460388795.19152.38.camel@nexus-software.ie>
	 <CAHp75Vc3P=D47VtQ2JhbcMfx3xam0Bqp9gUW79jt32ThKzVULw@mail.gmail.com>
	 <1460478320.19152.92.camel@nexus-software.ie>
	 <1460479824.6620.121.camel@linux.intel.com>
	 <1460546565.19152.148.camel@nexus-software.ie>
	 <1460549027.6620.131.camel@linux.intel.com>
	 <1460558093.19152.151.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460558093.19152.151.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-13 at 15:34 +0100, Bryan O'Donoghue wrote:
> On Wed, 2016-04-13 at 15:03 +0300, Andy Shevchenko wrote:
> > 
> > Because a probability of FIFO overrun.
> > 
> > There is a big chapter ("Peripheral Burst Transaction Requests") in
> > dw_apb_dmac_db.pdf covering this.
> I thought there was flow control between the controller and the FIFO
> here ? I don't have the spec SoC spec for the UART to hand but, if
> memory serves...

Wait, you mean flow control between DMA controller and UART FIFO, or I
misread you?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
