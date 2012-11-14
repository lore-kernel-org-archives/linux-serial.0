From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/3] OF: Add helper for matching against linux,stdout-path
Date: Wed, 14 Nov 2012 12:43:51 -0800
Message-ID: <20121114204351.GA5743@kroah.com>
References: <1351849734-9836-1-git-send-email-s.hauer@pengutronix.de>
 <1351849734-9836-2-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1351849734-9836-2-git-send-email-s.hauer@pengutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>, Grant Likely <grant.likely@secretlab.ca>, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-serial@vger.kernel.org

On Fri, Nov 02, 2012 at 10:48:52AM +0100, Sascha Hauer wrote:
> devicetrees may have a linux,stdout-path property in the chosen
> node describing the console device. This adds a helper function
> to match a device against this property so a driver can call
> add_preferred_console for a matching device.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/of/Kconfig        |    3 +++
>  drivers/of/Makefile       |    1 +
>  drivers/of/of_stdout.c    |   27 +++++++++++++++++++++++++++
>  include/linux/of_stdout.h |   24 ++++++++++++++++++++++++
>  4 files changed, 55 insertions(+)
>  create mode 100644 drivers/of/of_stdout.c
>  create mode 100644 include/linux/of_stdout.h

I need an ACK from the OF maintainers before I can take this through the
tty tree.

thanks,

greg k-h
