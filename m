From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] serial: mctrl_gpio: Check if GPIO property exisits
 before requesting it
Date: Fri, 24 May 2019 09:56:19 +0200
Message-ID: <20190524075619.GB31438@kroah.com>
References: <20190522121117.14347-1-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522121117.14347-1-sr@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Roese <sr@denx.de>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Yegor Yefremov <yegorslists@googlemail.com>, Giulio Benetti <giulio.benetti@micronovasrl.com>
List-Id: linux-serial@vger.kernel.org

On Wed, May 22, 2019 at 02:11:16PM +0200, Stefan Roese wrote:
> This patch adds a check for the GPIOs property existence, before the
> GPIO is requested. This fixes an issue seen when the 8250 mctrl_gpio
> support is added (2nd patch in this patch series) on x86 platforms using
> ACPI. Please find a details problem description here:
> 
> https://lkml.org/lkml/2016/8/9/357

Can you change this to a lore.kernel.org link instead?

Actually, just put the information in here, no one should ever have to
search somewhere else to determine what happened in a changelog entry.

thanks,

greg k-h
