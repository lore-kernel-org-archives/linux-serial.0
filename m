From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Need to remove ch35x wch driver which already running
Date: Fri, 16 Nov 2012 11:23:58 +0000
Message-ID: <20121116112358.5318a1f5@pyramind.ukuu.org.uk>
References: <loom.20121116T085450-158@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:55662 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2KPLSp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 06:18:45 -0500
In-Reply-To: <loom.20121116T085450-158@post.gmane.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Lokesh <v.lokesh@live.com>
Cc: linux-serial@vger.kernel.org

On Fri, 16 Nov 2012 07:59:22 +0000 (UTC)
Lokesh <v.lokesh@live.com> wrote:

> HI
> 
> I have a pci base serial card i.e wch35x card. for 3.0.5, the driver does not
> exisits. Iam redeveloping for the same from scratch. But due mis detection, the
> pci card claims a driver named "serial".

Actually that is the right driver for the wch35x cards and that would be
why it has bound to them. There are some mods in later kernels to make
the wch work better, but it is the right driver.

If you want to play with it for some reason and write your own driver to
learn stuff then the easiest thing to do is probably add it temporarily
to the blacklist in 8250_pci.c
