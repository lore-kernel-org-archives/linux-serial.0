From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 1/1] serial: imx - Add dma buffer confugration via
 sysfs
Date: Mon, 15 Oct 2018 16:01:18 +0200
Message-ID: <20181015140118.GA16234@kroah.com>
References: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1539249903-6316-1-git-send-email-fabien.lahoudere@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Thu, Oct 11, 2018 at 11:25:03AM +0200, Fabien Lahoudere wrote:
> In order to optimize serial communication on imx53 and imx6, we may
> need to tweak DMA period and buffer length per period.

Why can you not just automatically determine this information?  What is
userspace going to know that the kernel can not just learn now?

Having tunables is nice, but it is even better to not need them at all.

thanks,

greg k-h
