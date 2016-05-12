From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/1] dmaengine: slave means at least one of DMA_SLAVE,
 DMA_CYCLIC
Date: Thu, 12 May 2016 11:15:28 +0530
Message-ID: <20160512054528.GX2274@localhost>
References: <1462902214-64706-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1462902214-64706-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, May 10, 2016 at 08:43:34PM +0300, Andy Shevchenko wrote:
> When check for capabilities recognize slave support by either DMA_SLAVE or
> DMA_CYCLIC bit set. If we don't do that the user can't get a normally worked
> DMA support for engines that doesn't have one of the mentioned bits set.

Applied, thanks

-- 
~Vinod
