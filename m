From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V2 4/9] Documentation: DT: Add entries for bcm63xx UART
Date: Mon, 20 Oct 2014 23:25:10 +0200
Message-ID: <2100909.UrHPDWWSai@wuerfel>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com> <1413838448-29464-5-git-send-email-cernekee@gmail.com> <6216923.cK1phqtEXn@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:65133 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751192AbaJTVZV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 20 Oct 2014 17:25:21 -0400
In-Reply-To: <6216923.cK1phqtEXn@wuerfel>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org, grant.likely@linaro.org, geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org, linux-serial@vger.kernel.org, devicetree@vger.kernel.org

On Monday 20 October 2014 23:20:08 Arnd Bergmann wrote:
> 
> In this example, the clock output name of the clock provider is
> the same as the clock input of the consumer, that is almost always
> a bug and would not be a good example at all.
> 
> 

Ah, found the bug: the MIPS code is written to ignore the device
and just look up a global clock name:

struct clk *clk_get(struct device *dev, const char *id)
{
        if (!strcmp(id, "enet0"))
                return &clk_enet0;
        if (!strcmp(id, "enet1"))
                return &clk_enet1;
        if (!strcmp(id, "enetsw"))
                return &clk_enetsw;
        if (!strcmp(id, "ephy"))
                return &clk_ephy;
        if (!strcmp(id, "usbh"))
                return &clk_usbh;
        if (!strcmp(id, "usbd"))
                return &clk_usbd;
        if (!strcmp(id, "spi"))
                return &clk_spi;
        if (!strcmp(id, "hsspi"))
                return &clk_hsspi;
        if (!strcmp(id, "xtm"))
                return &clk_xtm;
        if (!strcmp(id, "periph"))
                return &clk_periph;
        if ((BCMCPU_IS_3368() || BCMCPU_IS_6358()) && !strcmp(id, "pcm"))
                return &clk_pcm;
        if ((BCMCPU_IS_6362() || BCMCPU_IS_6368()) && !strcmp(id, "ipsec"))
                return &clk_ipsec;
        if ((BCMCPU_IS_6328() || BCMCPU_IS_6362()) && !strcmp(id, "pcie"))
                return &clk_pcie;
        return ERR_PTR(-ENOENT);
}

This should be changed to use the drivers/clk/clkdev.c lookup code if
you want to share drivers between architectures.

In particular, the "enet0"/"enet1" clock name makes no sense -- the
clock input name should be independent of the instance, aside from
the question of which output of the provider it is wired up to.

	Arnd
