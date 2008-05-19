From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.6 patch] drivers/serial/: remove CVS keywords
Date: Mon, 19 May 2008 23:00:13 +0100
Message-ID: <20080519230013.60bbe5bc@core>
References: <20080519215922.GV17716@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:59988 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759570AbYESWMG (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 19 May 2008 18:12:06 -0400
In-Reply-To: <20080519215922.GV17716@cs181133002.pp.htv.fi>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 20 May 2008 00:59:22 +0300
Adrian Bunk <bunk@kernel.org> wrote:

> This patch removes CVS keywords that weren't updated for a long time in 
> comments, printk's and MODULE_DESCRIPTION's (no printk's or 
> MODULE_DESCRIPTION's are completely removed).
> 
> While doing this I also found and fixed a missing \n in a printk
> in m32r_sio.c
> 
> Signed-off-by: Adrian Bunk <bunk@kernel.org>

Acked-by: Alan Cox <alan@redhat.com>

Again will run via the big serial/tty rework tree.
