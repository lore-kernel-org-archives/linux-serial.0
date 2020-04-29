Return-Path: <SRS0=H8bb=6N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0B8C83001
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 03:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 503C72068E
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 03:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgD2DWW (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:22:22 -0400
Received: from kernel.crashing.org ([76.164.61.194]:49566 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgD2DWW (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 28 Apr 2020 23:22:22 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Tue, 28 Apr 2020 23:22:21 EDT
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 03T3LD4u008600
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 28 Apr 2020 22:21:16 -0500
Message-ID: <55e1e941457cd596c4273e9c55dc2cfc9027c5ba.camel@kernel.crashing.org>
Subject: Re: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller
 driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>,
        Karol Gugala <kgugala@antmicro.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Filip Kokosinski <fkokosinski@antmicro.com>,
        Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Joel Stanley <joel@jms.id.au>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Maxime Ripard <mripard@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Icenowy Zheng <icenowy@aosc.io>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, "Gabriel L. Somlo" <gsomlo@gmail.com>
Date:   Wed, 29 Apr 2020 13:21:11 +1000
In-Reply-To: <CAPk366REVxz7qRfJ0dJOVPRey6+01q1JRvqANDNffYV8Lvh73g@mail.gmail.com>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
         <20200425133939.3508912-3-mholenko@antmicro.com>
         <CAPk366REVxz7qRfJ0dJOVPRey6+01q1JRvqANDNffYV8Lvh73g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 2020-04-27 at 11:13 +0200, Mateusz Holenko wrote:
> As Gabriel Somlo <gsomlo@gmail.com> suggested to me, I could still use
> readl/writel/ioread/iowrite() standard functions providing memory
> barriers *and* have values in CPU native endianness by using the
> following constructs:
> 
> `le32_to_cpu(readl(addr))`
> 
> and
> 
> `writel(cpu_to_le32(value), addr)`
> 
> as le32_to_cpu/cpu_to_le32():
> - does nothing on LE CPUs and
> - reorders bytes on BE CPUs which in turn reverts swapping made by
> readl() resulting in returning the original value.

It's a bit sad... I don't understand why you need this. The HW has a
fied endian has you have mentioned earlier (and that is a good design).

The fact that you are trying to shove things into a "smaller pipe" than
the actual register shouldn't affect at what address the MSB and LSB
reside. And readl/writel (or ioread32/iowrite32) will always be LE as
well, so will match the HW layout. Thus I don't see why you need to
play swapping games here.

This however would be avoided completely if the HW was a tiny bit
smarter and would do the multi-beat access for you which shouldn't be
terribly hard to implement.

That said, it would be even clearer if you just open coded the 2 or 3
useful cases: 32/8, 32/16 and 32/32. The loop with calculated shifts
(and no masks) makes the code hard to understand.

Cheers,
Ben.

