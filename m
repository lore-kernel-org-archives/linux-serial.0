From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH -next] tty: of_serial: fix return value check in
 of_platform_serial_setup()
Date: Thu, 15 Nov 2012 17:22:32 -0800
Message-ID: <20121116012232.GB12364@kroah.com>
References: <CAPgLHd--dWeXNH_QVU34afv5Q1ju2MZJcwLKwyRr89+RvOTOBw@mail.gmail.com>
 <20121115120811.B9EB63E0B12@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37649 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab2KPBWg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 15 Nov 2012 20:22:36 -0500
Received: by mail-pb0-f46.google.com with SMTP id wy7so1558597pbc.19
        for <linux-serial@vger.kernel.org>; Thu, 15 Nov 2012 17:22:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20121115120811.B9EB63E0B12@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, alan@linux.intel.com, rob.herring@calxeda.com, seth.heasley@intel.com, stable@kernel.org, yongjun_wei@trendmicro.com.cn, linux-serial@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

On Thu, Nov 15, 2012 at 12:08:11PM +0000, Grant Likely wrote:
> On Thu, 1 Nov 2012 13:27:34 +0800, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> > 
> > In case of error, the function clk_get() returns ERR_PTR()
> > and never returns NULL. The NULL test in the return value
> > check should be replaced with IS_ERR().
> > 
> > dpatch engine is used to auto generate this patch.
> > (https://github.com/weiyj/dpatch)
> > 
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Looks correct to me.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 
> Alan, which tree should this go through?

My tty tree, I'll take it.

thanks,

greg k-h
