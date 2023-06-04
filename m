Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F45FC7EE23
	for <linux-serial@archiver.kernel.org>; Sun,  4 Jun 2023 17:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjFDRpK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 4 Jun 2023 13:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFDRpJ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 4 Jun 2023 13:45:09 -0400
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C8DDA;
        Sun,  4 Jun 2023 10:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8tuReGumGx5Wv85MrtWjYRVw7RQeKVwg++eJQNKhbh8=; b=C959Vz1t371iA3KcP2+7GkI3oH
        u7gxBzjQ0nkjAq+cyEyTSetir1R7BxSDkkRO7VncSemw3rzL9nr2D8LvB8ffjEgDKiJgoyMsnWuZ0
        B5y299xuFhNeUD66r6OD76xDOK6ozzdE6IKI7UOHTiOo3+4PrzEU0wuLIv5KsyCzaTDA=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:37774 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1q5rmn-00067x-Cm; Sun, 04 Jun 2023 13:45:01 -0400
Date:   Sun, 4 Jun 2023 13:44:59 -0400
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org
Message-Id: <20230604134459.3c3844012e9714fa2a61e642@hugovil.com>
In-Reply-To: <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
References: <20230602152626.284324-1-hugo@hugovil.com>
        <20230602152626.284324-6-hugo@hugovil.com>
        <2023060454-cotton-paramount-e33e@gregkh>
        <CAHp75Ve6W-hcB4YAeKukgv-uOEzBY7Tx5Sdf3doTRYKzNPcVGw@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
Subject: Re: [PATCH v7 5/9] serial: sc16is7xx: fix regression with GPIO
 configuration
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 4 Jun 2023 14:57:31 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jun 4, 2023 at 10:47 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jun 02, 2023 at 11:26:21AM -0400, Hugo Villeneuve wrote:
> 
> ...
> 
> > > +static u8 sc16is7xx_setup_mctrl_ports(struct device *dev)
> >
> > This returns what, mctrl?  If so, please document that, it doesn't look
> > obvious.
> 
> Good suggestion. Because I also stumbled over the returned type.
> 
> >  And as the kernel test robot reported, you do nothing with the
> > return value so why compute it?
> 
> It seems that the entire function and respective call has to be moved
> under #ifdef CONFIG_GPIOLIB.

Hi,
it cannot. See my explanations in response to Greg's comments.

Hugo.
