From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v1 12/12] serial: 8250_lpss: enable DMA on Intel Quark UART
Date: Mon, 11 Apr 2016 18:51:12 +0300
Message-ID: <CAHp75Vc3P=D47VtQ2JhbcMfx3xam0Bqp9gUW79jt32ThKzVULw@mail.gmail.com>
References: <1460061433-63750-1-git-send-email-andriy.shevchenko@linux.intel.com>
	<1460061433-63750-13-git-send-email-andriy.shevchenko@linux.intel.com>
	<1460388795.19152.38.camel@nexus-software.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1460388795.19152.38.camel@nexus-software.ie>
Sender: linux-kernel-owner@vger.kernel.org
To: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Puustinen, Ismo" <ismo.puustinen@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 11, 2016 at 6:33 PM, Bryan O'Donoghue
<pure.logic@nexus-software.ie> wrote:
> On Thu, 2016-04-07 at 23:37 +0300, Andy Shevchenko wrote:
>
> Preface. I tried this on Galileo and it appears to work. I'll do some
> throughput testing to verify but, initially the results are positive :)

I submitted (and pushed into my branch) a bit changed version (see my v2).

>> +       lpss->dma_maxburst = 8;
>
> Are these dwords ? If those are bytes then the maxburst value looks
> small. In the BSP the max burst is 32 bytes.

max_burst is in items of given size (here is 32 bytes for memory and 8
bytes for UART). I took this value from Quark BSP, but I'll be happy
to adjust to more optimal values.

-- 
With Best Regards,
Andy Shevchenko
