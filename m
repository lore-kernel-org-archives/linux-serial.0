From: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v1] dmaengine: idma64: Use actual device for DMA transfers
Date: Thu, 21 Mar 2019 19:48:54 +0530
Message-ID: <20190321141854.GA5348@vkoul-mobl>
References: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190318153930.25641-1-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: dmaengine@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 18-03-19, 18:39, Andy Shevchenko wrote:
> Intel IOMMU, when enabled, tries to find the domain of the device,
> assuming it's a PCI one, during DMA operations, such as mapping or
> unmapping. Since we are splitting the actual PCI device to couple of
> children via MFD framework (see drivers/mfd/intel-lpss.c for details),
> the DMA device appears to be a platform one, and thus not an actual one
> that performs DMA. In a such situation IOMMU can't find or allocate
> a proper domain for its operations. As a result, all DMA operations are
> failed.
> 
> In order to fix this, supply parent of the platform device
> to the DMA engine framework and fix filter functions accordingly.
> 
> We may rely on the fact that parent is a real PCI device, because no
> other configuration is present in the wild.

Applied, thanks

-- 
~Vinod
