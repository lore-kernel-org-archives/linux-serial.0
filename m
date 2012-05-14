From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RESEND PATCH V2 10/17] SERIAL: MIPS: lantiq: implement OF
 support
Date: Mon, 14 May 2012 18:51:55 +0100
Message-ID: <20120514185155.284bd51c@pyramind.ukuu.org.uk>
References: <1337017363-14424-1-git-send-email-blogic@openwrt.org>
	<1337017363-14424-10-git-send-email-blogic@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:43690 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754991Ab2ENRtH (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 14 May 2012 13:49:07 -0400
In-Reply-To: <1337017363-14424-10-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: John Crispin <blogic@openwrt.org>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org

On Mon, 14 May 2012 19:42:36 +0200
John Crispin <blogic@openwrt.org> wrote:

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

Doesn't really touch the tty parts of the logic so fine by me
