From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V1 1/1] serial: 8250_pci: Add F81504A series Support
Date: Thu, 22 Aug 2019 14:15:11 -0700
Message-ID: <20190822211511.GA11893@kroah.com>
References: <1565933249-23076-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <20190816112644.GF30120@smile.fi.intel.com>
 <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8e052919-b012-ff3f-f108-380d1ce5f7e7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, jslaby@suse.com, jay.dolan@accesio.com, hslester96@gmail.com, je.yen.tam@ni.com, lkp@intel.com, kai.heng.feng@canonical.com, heikki.krogerus@linux.intel.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, peter_hong@fintek.com.tw, "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Aug 19, 2019 at 08:49:50AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Hi,
> 
> Andy Shevchenko 於 2019/8/16 下午 07:26 寫道:
> > On Fri, Aug 16, 2019 at 01:27:29PM +0800, Ji-Ze Hong (Peter Hong) wrote:
> > > Fintek F81504A/508A/512A is PCIE to 4/8/12 UARTs device. It's support
> > > IO/MMIO/PCIE conf to access all functions. The old F81504/508/512 is
> > > only support IO.
> > 
> > We have 8250_fintek.
> > Isn't it a right place to add these?
> > 
> 
> The 8250_fintek implements PNP device with id PNP0501.
> Should I also implements PCIe device in this file?

Does it use the same logic?  If so, that makes sense, but if you can not
share anything, then no, it does not make sense.

thanks,

greg k-h
