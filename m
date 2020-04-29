Return-Path: <SRS0=H8bb=6N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B546C83003
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 11:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 105982074A
	for <linux-serial@archiver.kernel.org>; Wed, 29 Apr 2020 11:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fIb8uPmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgD2LcT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726556AbgD2LcS (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Apr 2020 07:32:18 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EA3C03C1AD;
        Wed, 29 Apr 2020 04:32:18 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k12so1489280qtm.4;
        Wed, 29 Apr 2020 04:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TN8Zd1ovr5Y9BIds5efwwQrWI/OoatX8UM2U2pugr28=;
        b=fIb8uPmC7LFx407+LbeeHnYbvSHQtjF9vnz94PIwVwVZDJNPzaG/dBejgW3ehEd8w7
         uUtyVU/3pRfmPXZlCrHRj4rt1Kv+WbluYZXxCJ3kRBUC8I3REHwq6RvSQmyYXGIOGygH
         AJUp458zCPtLy0h2Zs8xuHGdlcOtC/GcvV83qTEwtf4p26CzLAMlKdT/T/VHFI8xTM+m
         K29DmIuZvweUUJIRm+u6bJdcDklh9m+gPIUJnPhXETEcl/B6zNLx/0i0WCl4P/ci2yG6
         j1vIHmtawEOOvFxG0NkwQsalj3bITQKosMRU5kcFFJ7OlEelVGO0Q3b2RThaDy8mcLEV
         Q3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TN8Zd1ovr5Y9BIds5efwwQrWI/OoatX8UM2U2pugr28=;
        b=I/Hsa0aUSXhpzk0fxyTmLto64UPovBlQp9C93TlN3mg58ksKOc+2kZJY0zHDDwo9R9
         U/4ylf2FZV9NqFkERMTBIgpcyr0ybuYjK6CdVDtLW2hluYwPhJnaPMYasWDF5mDc+6Kp
         5jW4ki3NEfhi/lUZLJy+Usuqon+hYFyQ+iHqjRqJP/i/IWDDCDpzGMz1CaTpOKwHPSsL
         4Txnmp1ckI5Mm/CH+IWqKr4g67NL39Oa4pE7fg4x5eNwNTIqOGX8oZ+1XJjqAW25WsSt
         RqlEz30hTuWx7WpkyJ8czkXi9o/cBXSYlfmuYGWBwDZ3+51MOroS38pv+h1j/hd4l+LK
         1/cw==
X-Gm-Message-State: AGi0PubN+FsGEID8udwtM4eEXd1Jtae3lN9zzguA6jLKK0wyji7YVgTq
        M+j+qTwGGUI3as94VhwnWXE=
X-Google-Smtp-Source: APiQypKCa4PTP6G9UvwU/CMzNX267N/00FQqAzAdRG+V6IYPHso19QLnZmCbPHdXiRnrp9SI2urHyA==
X-Received: by 2002:ac8:37e6:: with SMTP id e35mr33836338qtc.19.1588159937031;
        Wed, 29 Apr 2020 04:32:17 -0700 (PDT)
Received: from errol.ini.cmu.edu (pool-71-112-157-130.pitbpa.fios.verizon.net. [71.112.157.130])
        by smtp.gmail.com with ESMTPSA id z26sm15734754qkg.39.2020.04.29.04.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:32:16 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:32:09 -0400
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Mateusz Holenko <mholenko@antmicro.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Stafford Horne <shorne@gmail.com>,
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/5] drivers/soc/litex: add LiteX SoC Controller driver
Message-ID: <20200429113209.GB23743@errol.ini.cmu.edu>
References: <20200425133939.3508912-0-mholenko@antmicro.com>
 <20200425133939.3508912-3-mholenko@antmicro.com>
 <CAPk366REVxz7qRfJ0dJOVPRey6+01q1JRvqANDNffYV8Lvh73g@mail.gmail.com>
 <55e1e941457cd596c4273e9c55dc2cfc9027c5ba.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e1e941457cd596c4273e9c55dc2cfc9027c5ba.camel@kernel.crashing.org>
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Ben,

On Wed, Apr 29, 2020 at 01:21:11PM +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2020-04-27 at 11:13 +0200, Mateusz Holenko wrote:
> > As Gabriel Somlo <gsomlo@gmail.com> suggested to me, I could still use
> > readl/writel/ioread/iowrite() standard functions providing memory
> > barriers *and* have values in CPU native endianness by using the
> > following constructs:
> > 
> > `le32_to_cpu(readl(addr))`
> > 
> > and
> > 
> > `writel(cpu_to_le32(value), addr)`
> > 
> > as le32_to_cpu/cpu_to_le32():
> > - does nothing on LE CPUs and
> > - reorders bytes on BE CPUs which in turn reverts swapping made by
> > readl() resulting in returning the original value.
> 
> It's a bit sad... I don't understand why you need this. The HW has a
> fied endian has you have mentioned earlier (and that is a good design).
> 
> The fact that you are trying to shove things into a "smaller pipe" than
> the actual register shouldn't affect at what address the MSB and LSB
> reside. And readl/writel (or ioread32/iowrite32) will always be LE as
> well, so will match the HW layout. Thus I don't see why you need to
> play swapping games here.
> 
> This however would be avoided completely if the HW was a tiny bit
> smarter and would do the multi-beat access for you which shouldn't be
> terribly hard to implement.
> 
> That said, it would be even clearer if you just open coded the 2 or 3
> useful cases: 32/8, 32/16 and 32/32. The loop with calculated shifts
> (and no masks) makes the code hard to understand.

A "compound" LiteX MMIO register of 32 bits total, starting at address
0x80000004, containing value 0x12345678, is spread across 4 8-bit
subregisters aligned at ulong in the MMIO space like this on LE:

0x82000000  00 00 00 00 12 00 00 00 34 00 00 00 56 00 00 00  ........4...V...
                        ^^^^^^^^^^^ ^^^^^^^^^^^ ^^^^^^^^^^^
0x82000010  78 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  x...............
            ^^^^^^^^^^^

and like this on BE:

0x82000000  00 00 00 00 00 00 00 12 00 00 00 34 00 00 00 56  ...........4...V
                        ^^^^^^^^^^^ ^^^^^^^^^^^ ^^^^^^^^^^^
0x82000010  00 00 00 78 00 00 00 00 00 00 00 00 00 00 00 00  ...x............
            ^^^^^^^^^^^

LiteX can be optionally built to use larger than 8-bit subregisters,
here's an example with 16-bit subregisters (also aligned at ulong),
for the same "compound" register:

on LE:
0x82000000  00 00 00 00 34 12 00 00 78 56 00 00 00 00 00 00  ....4...xV......
                        ^^^^^^^^^^^ ^^^^^^^^^^^

and on BE:
0x82000000  00 00 00 00 00 00 12 34 00 00 56 78 00 00 00 00  .......4..Vx....
                        ^^^^^^^^^^^ ^^^^^^^^^^^

Essentially (back to the more common 8-bit subregister size), a compound
register foo = 0x12345678 is stored as

	ulong foo[4] = {0x12, 0x34, 0x56, 0x78};

in the CPU's native endianness, aligned at the CPU's native word width
(hence "ulong").

With 16-bit subregisters that would then be:

	ulong foo[2] = {0x1234, 0x5678};

Trouble with readl() and writel() is that they convert everything to LE
internally, which on BE would get us something different *within* each
subregister (i.e., 0x12000000 instead of 0x12, or 0x34120000 instead of
0x1234).

The cleanest way (IMHO) to accomplish an endian-agnostic readl() (that
preserves both barriers AND native endianness) is to undo the internal
__le32_to_cpu() using:

	cpu_to_le32(readl(addr))

This keeps us away from using any '__' internals directly (e.g.,
__raw_readl()), or open-coding our own `litex_readl()`, e.g.:

	static inline u32 litex_readl(const volatile void __iomem *addr)
	{
		u32 val;
		__io_br();
		val = __raw_readl(addr)); /* No le32 byteswap here! */
		__io_ar(val);
		return val;
	}

... which is something that was strongly advised against in earlier
revisions of this series.

Cheers,
--Gabriel
