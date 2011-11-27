From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH v2 0/4] OMAP serial device tree support
Date: Sat, 26 Nov 2011 19:36:42 -0800
Message-ID: <20111127033642.GA28378@kroah.com>
References: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1321969456-24266-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, tony@atomide.com, khilman@ti.com, govindraj.raja@ti.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, robherring2@gmail.com
List-Id: linux-serial@vger.kernel.org

On Tue, Nov 22, 2011 at 07:14:12PM +0530, Rajendra Nayak wrote:
> v2 is based on the latest omap-serial runtime patches, which
> can be found here[1]
> 
> The series passes minimal data that allows serial console
> boot, with UART's initialised from device tree.
> However some of low power support for UART and remote
> wakeup needs more work.
> Boot tested on OMAP4 panda and OMAP4 sdp boards.
> 
> Patches can be found here..
> git://gitorious.org/omap-pm/linux.git for-dt/serial

What tree are these going to go through, some device tree one, or do you
want me to take the serial driver patches?

thanks,

greg k-h
