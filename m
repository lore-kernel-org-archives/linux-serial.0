From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH V2 1/2] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Date: Wed, 3 Jul 2019 16:47:44 +0200
Message-ID: <20190703144744.GB24961@kroah.com>
References: <20190703072435.34152-1-je.yen.tam@ni.com>
 <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <63697b10-98a7-86b7-2513-3eb793ed03c5@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: jeyentam <je.yen.tam@ni.com>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Jul 03, 2019 at 03:27:11PM +0200, Enrico Weigelt, metux IT consult wrote:
> >  /* UART Port Control Register */> -#define NI8430_PORTCON	0x0f> -#define NI8430_PORTCON_TXVR_ENABLE	(1 << 3)
> Can we have that renaming as a separate patch, to ease review ?
> 
> And what about introducing a config sym for the new device specific
> stuff ? These devices seem to be pretty rare - never seen them in
> embeded world, where we do need to care of kernel size.

No, that's not the way this driver works, sorry.

greg k-h
