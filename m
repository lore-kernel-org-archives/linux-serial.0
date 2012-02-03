From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Patch] tty: fix a build failure on sparc
Date: Fri, 3 Feb 2012 07:53:49 -0800
Message-ID: <20120203155349.GC20638@kroah.com>
References: <1328246540-5824-1-git-send-email-xiyou.wangcong@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:46094 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755309Ab2BCPyq (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Feb 2012 10:54:46 -0500
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0364E211F2
	for <linux-serial@vger.kernel.org>; Fri,  3 Feb 2012 10:54:46 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <1328246540-5824-1-git-send-email-xiyou.wangcong@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Paul Gortmaker <paul.gortmaker@windriver.com>, Alan Cox <alan@linux.intel.com>, Jamie Iles <jamie@jamieiles.com>, Stephen Warren <swarren@nvidia.com>, linux-serial@vger.kernel.org

On Fri, Feb 03, 2012 at 01:22:10PM +0800, Cong Wang wrote:
> On sparc, there is a build failure:
> 
> drivers/tty/serial/8250/8250.c:48:21: error: suncore.h: No such file or directory
> drivers/tty/serial/8250/8250.c:3275: error: implicit declaration of function 'sunserial_register_minors'
> drivers/tty/serial/8250/8250.c:3305: error: implicit declaration of function 'sunserial_unregister_minors'
> 
> this is due to commit 9bef3d4197379a995fa80f81950bbbf8d32e9e8b
> (serial: group all the 8250 related code together) moved these files
> into 8250/ subdirectory, but forgot to change the reference
> to drivers/tty/serial/suncore.h.

Ah, thanks, I'll go queue this up, sorry for the problem.

greg k-h
