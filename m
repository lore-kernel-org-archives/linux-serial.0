From: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Subject: Re: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via
 sysfs
Date: Wed, 17 Oct 2018 10:20:25 +0200
Message-ID: <1539764425.3694.1.camel@collabora.com>
References: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
         <20181015140118.GA16234@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015140118.GA16234@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Greg,

On Mon, 2018-10-15 at 16:01 +0200, Greg KH wrote:
> On Thu, Oct 11, 2018 at 11:25:03AM +0200, Fabien Lahoudere wrote:
> > In order to optimize serial communication on imx53 and imx6, we may
> > need to tweak DMA period and buffer length per period.
> 
> Why can you not just automatically determine this information?  What is
> userspace going to know that the kernel can not just learn now?
> 
> Having tunables is nice, but it is even better to not need them at all.

I agree that it is better to let the kernel do the configuration.
However in our case we use several serial communication for different device
and one of them need to tweak that configuration to get small data with a better
period. However having this parameter for all serial port implies a bigger number
of interrupts for others too.

> 
> thanks,
> 
> greg k-h
-- 
Fabien
