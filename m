From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/6] serdev multiplexing support
Date: Mon, 28 Aug 2017 14:55:41 +0200
Message-ID: <20170828125541.GA10125@kroah.com>
References: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1502889748-31499-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Cc: linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, magnus.damm@gmail.com, laurent.pinchart@ideasonboard.com, wsa@the-dreams.de, robh@kernel.org, peda@axentia.se, geert@linux-m68k.org, linux-i2c@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wed, Aug 16, 2017 at 03:22:22PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> Here's a new version of serdev multiplexing support. Thanks to everybody who
> commented; I think I have included all non-optional suggestions. :)
> Changes are manifold, please refer to the changelog below.
> 
> This version drops "mux: include compiler.h from mux/consumer.h",
> which is on its way upstream by now.
> 
> CU
> Uli

Rob, any thoughts on this series?

thanks,

greg k-h
