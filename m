From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RESEND PATCH V2 10/17] SERIAL: MIPS: lantiq: implement OF
 support
Date: Mon, 14 May 2012 12:32:32 -0700
Message-ID: <20120514193232.GA5741@kroah.com>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
 <1337017363-14424-10-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:56947 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756803Ab2ENTcg (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 May 2012 15:32:36 -0400
Received: by pbbrp8 with SMTP id rp8so6516806pbb.19
        for <linux-serial@vger.kernel.org>; Mon, 14 May 2012 12:32:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1337017363-14424-10-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, May 14, 2012 at 07:42:36PM +0200, John Crispin wrote:
> Add devicetree and handling for our new clkdev clocks. The patch is rather
> straightforward. .of_match_table is set and the 3 irqs are now loaded from the
> devicetree.
> 
> This series converts the lantiq target to clkdev amongst other things. The
> driver needs to handle two clocks now. The fpi bus clock used to derive the
> divider and the clock gate needed on some socs to make the secondary port work.
> 
> Signed-off-by: John Crispin <blogic@openwrt.org>
> Cc: Alan Cox <alan@linux.intel.com>
> Cc: linux-serial@vger.kernel.org
> ---
> This patch is part of a series moving the mips/lantiq target to OF and clkdev
> support. The patch, once Acked, should go upstream via Ralf's MIPS tree.

Fine with me as well, if you need it:
  Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

