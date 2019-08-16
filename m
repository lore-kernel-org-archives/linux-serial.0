From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Date: Fri, 16 Aug 2019 14:26:44 +0300
Message-ID: <20190816112644.GF30120@smile.fi.intel.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, jay.dolan@accesio.com, hslester96@gmail.com, je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com, heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Fri, Aug 16, 2019 at 01:27:29PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
> IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
> only support IO.

We have 8250_fintek.
Isn't it a right place to add these?

-- 
With Best Regards,
Andy Shevchenko
