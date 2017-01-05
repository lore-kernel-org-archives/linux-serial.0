From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] serial: 8250_lpss: Release Quark MSI vectors on exit
Date: Wed, 4 Jan 2017 21:25:15 -0800
Message-ID: <20170105052515.GA3280@infradead.org>
References: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0250c46e-da6c-71f3-50ae-b7c17fd0bd2c@siemens.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-serial@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 04, 2017 at 08:36:51PM +0100, Jan Kiszka wrote:
> No one seems to do this magically in the background, so we have to do
> the job in the exit handler that corresponds to the board setup handler.
> 
> Fixes: 60a9244a5d14 ("serial: 8250_lpss: enable MSI for Intel Quark")
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Looks good.   I already pointed out to Andy that we need this anyway.

Reviewed-by: Christoph Hellwig <hch@lst.de>
