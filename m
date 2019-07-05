From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Date: Fri, 5 Jul 2019 11:04:22 +0200
Message-ID: <20190705090422.GA32289@kroah.com>
References: <20190705083349.44047-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190705083349.44047-1-je.yen.tam@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeyentam <je.yen.tam@ni.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 05, 2019 at 01:33:49AM -0700, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> ---
>  drivers/tty/serial/8250/8250_pci.c | 298 ++++++++++++++++++++++++++++-
>  1 file changed, 294 insertions(+), 4 deletions(-)

What changed from the previous versions?

Always put that below the --- line.

Please fix up and send a v4 with that information.

thanks,

greg k-h
