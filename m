From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/8] n_gsm.c: Implement 3GPP27.010 DLC start-up procedure
 in MUX
Date: Thu, 16 Aug 2012 11:57:44 -0700
Message-ID: <20120816185744.GA2978@kroah.com>
References: <20120813124254.6125.70371.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65322 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2HPS5s (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Aug 2012 14:57:48 -0400
Received: by pbbrr13 with SMTP id rr13so1991062pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 16 Aug 2012 11:57:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120813124254.6125.70371.stgit@localhost.localdomain>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-serial@vger.kernel.org

On Mon, Aug 13, 2012 at 01:43:15PM +0100, Alan Cox wrote:
> From: xiaojin <jin.xiao@intel.com>
> 
> In 3GPP27.010 5.8.1, it defined:
> The TE multiplexer initiates the establishment of the multiplexer control channel by sending a SABM frame on DLCI 0 using the procedures of clause 5.4.1.
> Once the multiplexer channel is established other DLCs may be established using the procedures of clause 5.4.1.
> This patch implement 5.8.1 in MUX level, it make sure DLC0 is the first channel to be setup.
> 
> [or for those not familiar with the specification: it was possible to try
>  and open a data connection while the control channel was not yet fully
>  open, which is a spec violation and confuses some modems]
> 
> Signed-off-by: xiaojin <jin.xiao@intel.com>
> Tested-by: Yin, Fengwei <fengwei.yin@intel.com>
> [tweaked the order we check things and error code]
> Signed-off-by: Alan Cox <alan@linux.intel.com>
> Cc: The Horsebox <stable@kernel.org>

In the future, it's <stable@vger.kernel.org>, I can catch these
addresses, but it's not as automated.

thanks,

greg k-h
