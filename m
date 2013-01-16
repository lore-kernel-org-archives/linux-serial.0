From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] tty: Fix ptmx open without closed slave.
Date: Tue, 15 Jan 2013 23:04:02 -0800
Message-ID: <20130116070402.GA2527@kroah.com>
References: <50D20EB5.30900@ilyx.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:36695 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751969Ab3APHDI (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 02:03:08 -0500
Content-Disposition: inline
In-Reply-To: <50D20EB5.30900@ilyx.ru>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Ilya Zykov <ilya@ilyx.ru>
Cc: Alan Cox <alan@linux.intel.com>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org

On Wed, Dec 19, 2012 at 11:00:05PM +0400, Ilya Zykov wrote:
> When we are opening ptmx, we have closed pts, by description.
> Now only if we open and after close all pts' descriptions, pty_close() sets
> this bit correctly
> 
> Signed-off-by: Ilya Zykov <ilya@ilyx.ru>

Ok, I have a ton of patches from you, lots of different threads, patches
with the same subject, and I don't know what one Alan agreed to.

So, can you please resend what Alan and you agree should be applied to
the tree?

totally confused,

greg k-h
