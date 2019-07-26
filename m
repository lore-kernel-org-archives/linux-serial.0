From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5] serial/8250: Add support for NI-Serial PXI/PXIe+485
 devices
Date: Fri, 26 Jul 2019 09:16:00 +0200
Message-ID: <20190726071600.GA12610@kroah.com>
References: <20190726024046.5873-1-je.yen.tam@ni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190726024046.5873-1-je.yen.tam@ni.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeyentam <je.yen.tam@ni.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Fri, Jul 26, 2019 at 10:40:46AM +0800, jeyentam wrote:
> Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> 
> Signed-off-by: jeyentam <je.yen.tam@ni.com>

You messed up the From: and signed-off-by: lines this time :(

v4 had it "correct", please fix up and send v6.

thanks,

greg k-h
