From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH tty-next] serial: sirf: Fix compilation failure
Date: Thu, 29 May 2014 11:25:24 -0700
Message-ID: <20140529182524.GA22969@kroah.com>
References: <1396010535-2654-1-git-send-email-daniel.thompson@linaro.org>
 <1401358423-31532-1-git-send-email-daniel.thompson@linaro.org>
 <CAGsJ_4ypSdP-i35BaQaciPo-g=+8Z5-T2MV5zgDP98BMciGbGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42847 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751157AbaE2SVr (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 29 May 2014 14:21:47 -0400
Content-Disposition: inline
In-Reply-To: <CAGsJ_4ypSdP-i35BaQaciPo-g=+8Z5-T2MV5zgDP98BMciGbGw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Barry Song <baohua@kernel.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>, LKML <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, patches@linaro.org, linaro-kernel@lists.linaro.org, Jiri Slaby <jslaby@suse.cz>, Qipan Li <Qipan.Li@csr.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, May 29, 2014 at 08:14:02PM +0800, Barry Song wrote:
> 2014-05-29 18:13 GMT+08:00 Daniel Thompson <daniel.thompson@linaro.org>:
> > After 07d410e0) serial: sirf: fix spinlock deadlock issue it is no longer
> > possiblet to compile this driver. The rename of one of the spinlocks is
> > faulty. After looking at the original patch I believe this is the correct
> > fix.
> >
> > Compile tested using ARM's multi_v7_defconfig
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jiri Slaby <jslaby@suse.cz>
> > Cc: Barry Song <baohua@kernel.org>
> > Cc: Qipan Li <Qipan.Li@csr.com>
> > Cc: linux-serial@vger.kernel.org
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Qipan prepared a same patch to fix this.

Why didn't he send it?

