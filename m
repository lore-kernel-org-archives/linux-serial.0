From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 1/3] dmaengine: hsu: Export hsu_dma_get_status()
Date: Thu, 30 Jun 2016 10:04:00 +0530
Message-ID: <20160630043359.GO14945@localhost>
References: <1465969453-16198-1-git-send-email-kim.tatt.chuah@intel.com>
 <1465969453-16198-2-git-send-email-kim.tatt.chuah@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1465969453-16198-2-git-send-email-kim.tatt.chuah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuah Kim Tatt <kim.tatt.chuah@intel.com>
Cc: gregkh@linuxfoundation.org, heikki.krogerus@linux.intel.com, andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com, linux-kernel@vger.kernel.org, jui.nee.tan@intel.com, peter@hurleysoftware.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jun 15, 2016 at 01:44:11PM +0800, Chuah Kim Tatt wrote:
> From: "Chuah, Kim Tatt" <kim.tatt.chuah@intel.com>
> 
> To allow other code to safely read DMA Channel Status Register (where
> the register attribute for Channel Error, Descriptor Time Out &
> Descriptor Done fields are read-clear), export hsu_dma_get_status().
> hsu_dma_irq() is renamed to hsu_dma_do_irq() and requires Status
> Register value to be passed in.

Acked-by: Vinod Koul <vinod.koul@intel.com>

-- 
~Vinod
