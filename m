From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Thu, 05 Jan 2017 11:01:52 +0200
Message-ID: <1483606912.9552.226.camel@linux.intel.com>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
         <20170105052515.GA3280@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170105052515.GA3280@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 2017-01-04 at 21:25 -0800, Christoph Hellwig wrote:
> On Wed, Jan 04, 2017 at 08:36:51PM +0100, Jan Kiszka wrote:
> > No one seems to do this magically in the background, so we have to
> > do
> > the job in the exit handler that corresponds to the board setup
> > handler.
> > 
> > Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel
> > Quark")
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Looks good.   I already pointed out to Andy that we need this anyway.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

No, we don't.

Jan already pointed out how it works right now.

That's why I'm asking to fix documentation.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
