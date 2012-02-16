From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH] serial/sirf: fixup for changes to pin control
Date: Thu, 16 Feb 2012 11:48:45 -0800
Message-ID: <20120216194845.GB5480@kroah.com>
References: <1329417828-6005-1-git-send-email-linus.walleij@linaro.org>
 <74CDBE0F657A3D45AFBB94109FB122FF1790EC8791@HQMAIL01.nvidia.com>
 <CACRpkdavPdK13cJ-mdDXwbz3jNCSCzaa8LTdMDXOy4mi+pmdmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39490 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751525Ab2BPTvV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Feb 2012 14:51:21 -0500
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id D941E21413
	for <linux-serial@vger.kernel.org>; Thu, 16 Feb 2012 14:51:20 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CACRpkdavPdK13cJ-mdDXwbz3jNCSCzaa8LTdMDXOy4mi+pmdmw@mail.gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Stephen Warren <swarren@nvidia.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Shawn Guo <shawn.guo@freescale.com>, Thomas Abraham <thomas.abraham@linaro.org>, Dong Aisheng <dong.aisheng@linaro.org>, Rajendra Nayak <rajendra.nayak@linaro.org>, Haojian Zhuang <haojian.zhuang@marvell.com>, Barry Song <21cnbao@gmail.com>, Tony Lindgren <tony@atomide.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, Feb 16, 2012 at 08:39:39PM +0100, Linus Walleij wrote:
> On Thu, Feb 16, 2012 at 8:01 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> > Should this patch be put into the pinctrl tree since that's where the
> > API changed, perhaps even squashed into the original commit to avoid
> > git bisect breakage, unless your branch needs to be stable?
> 
> Hm yeah I will for sure put it into the pinctrl tree.

Great, please feel free to add:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

