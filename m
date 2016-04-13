From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Subject: Re: [PATCH v1 12/12] serial: 8250_lpss: enable DMA on Intel Quark
 UART
Date: Wed, 13 Apr 2016 16:24:49 +0100
Message-ID: <1460561089.19152.165.camel@nexus-software.ie>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460061433-63750-13-git-send-email-andriy.shevchenko@linux.intel.com>
	 <1460388795.19152.38.camel@nexus-software.ie>
	 <CAHp75Vc3P=D47VtQ2JhbcMfx3xam0Bqp9gUW79jt32ThKzVULw@mail.gmail.com>
	 <1460478320.19152.92.camel@nexus-software.ie>
	 <1460479824.6620.121.camel@linux.intel.com>
	 <1460546565.19152.148.camel@nexus-software.ie>
	 <1460549027.6620.131.camel@linux.intel.com>
	 <1460558093.19152.151.camel@nexus-software.ie>
	 <1460558891.6620.147.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460558891.6620.147.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2016-04-13 at 17:48 +0300, Andy Shevchenko wrote:
> Wait, you mean flow control between DMA controller and UART FIFO, or
> I
> misread you?

Yup.

It's a while since I read the spec and talked to the relevant people
but... I have this memory that the FIFO fill signal and DMA block were
'wired up' @ the AHB level. That would be how the UART and DMA block
would flow-control each other for descriptor chaining at any rate and
so one assumes that its active at the block-to-fifo layer.

Meh I don't have the UART EAS anymore to comment in detail.. 

I think the right thing to do is to be safe (so I'll ACK your series)
and then run an experiment to push the burst size upwards. If you have
the EAS handy though it might be worthwhile working out when the DMA
block will flow-control w/r to the FIFO fill level - I *think* (but
can't prove since I don't have the EAS anymore) that it's safe to push
that value higher.

---
bod
