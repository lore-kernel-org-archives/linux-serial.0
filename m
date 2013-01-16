From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [tty:tty-next 30/41] drivers/staging/sb105x/sb_pci_mp.c:2129:2:
 warning: passing argument 1 of 'tty_flip_buffer_push' from incompatible
 pointer type
Date: Wed, 16 Jan 2013 07:41:07 -0800
Message-ID: <20130116154107.GC1329@kroah.com>
References: <50f65045.xf8AiUb4vjF7e0Fu%fengguang.wu@intel.com>
 <20130116153010.GA5946@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:50884 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752791Ab3APPkG (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 10:40:06 -0500
Content-Disposition: inline
In-Reply-To: <20130116153010.GA5946@localhost>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Fengguang Wu <fengguang.wu@intel.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org

On Wed, Jan 16, 2013 at 11:30:10PM +0800, Fengguang Wu wrote:
> 
> Hi Jiri,
> 
> FYI, there are new compile warnings show up in
> 
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-next
> head:   496c907740ff083499f5449d2907af442e79ceb0
> commit: 2e124b4a390ca85325fae75764bef92f0547fa25 [30/41] TTY: switch tty_flip_buffer_push
> config: make ARCH=x86_64 allmodconfig

Thanks, I've marked the driver BROKEN for now to stop it from breaking
the build.

greg k-h
