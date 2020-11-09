Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05015C56201
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 22:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A134206D8
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 22:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEmtYTJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgKIWBj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgKIWBj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Nov 2020 17:01:39 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87F2C0613CF;
        Mon,  9 Nov 2020 14:01:38 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id y7so9439947pfq.11;
        Mon, 09 Nov 2020 14:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eceKQNp/PXO+GKV32uPeY50G6djMb7eH06458jQE6nc=;
        b=MEmtYTJe5EthRgz45SeaZctUXcGB08ngJcnuyUCvB/tYrMVWDYDoykYmtGj7cw/ndT
         PmtjhOl7ZUBxxk6p2dDTSFRZVDgIFAK54ULAhVJWI6In6nOVhK5bOXMUzAiumx2KavLw
         b5VPNuDeAGgjaMVX32tDSiXqU0lhoBQwWKmjSNLq8Lij3GODP75w2ewGUwfnM+ObMk/m
         91CH7vJkBKh78kMK+V/Up/VEYJGGwyOTCMEY6Kzq4aw5H6JDWjGLlvt0QoGNkG0VN/7v
         5oTKRVGh1M0f++nvigbMRqlKbaCUckoVgytsiqMQK1H2VUln+zWWsqfCP1zoksnQKIXp
         +aow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eceKQNp/PXO+GKV32uPeY50G6djMb7eH06458jQE6nc=;
        b=sWax0SoiVFcSuaFl58uDEHih7E7Tczcci2kJ9ZylfQM8zpSwOTXZi3YXW0itGAO+7W
         chi2Oqiu7nlpebfFsKC2yuuQd8vG3Q3f6h+HkBmoIQLiy1MabeN82imze3Dz55YvUdh2
         IsUPFS5K276Fh8CUIC2YMhP2IinZxkMLjyAezp7t9ksgysx34UxbnYP9RbNMBGXW7N06
         R7be3Dvyahg8lHsMcFYuwV/oiWQW6p9Edpf1o2ijxG6GkriXfQ40NI2CLMYh/UnppoaK
         5PxhgGwcCgVEM+Fhc3gdP6PfYPsqXP+Ot5Z/oX4lnoAG8qZeQ0DRa63W6a6kg9jBwGto
         6e0Q==
X-Gm-Message-State: AOAM531swQ3WSebeuwTxViM7NjMfDXX+fUjhG5+3C6qPgcfAufwDrdyA
        ua7oJPCb+XleQcz42d8Lw+U=
X-Google-Smtp-Source: ABdhPJxak2tvsqTZAixFvx501RyuCdk7VlyNej07ymXkzeRDST0OvhZuka6L7HiEcoFcMvWLMjFivw==
X-Received: by 2002:a17:90b:397:: with SMTP id ga23mr1290351pjb.151.1604959298318;
        Mon, 09 Nov 2020 14:01:38 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
        by smtp.gmail.com with ESMTPSA id j15sm11746751pfn.43.2020.11.09.14.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 14:01:35 -0800 (PST)
Date:   Tue, 10 Nov 2020 07:01:33 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Mateusz Holenko <mholenko@antmicro.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
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
        linux-kernel@vger.kernel.org,
        "Gabriel L. Somlo" <gsomlo@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v12 0/5] LiteX SoC controller and LiteUART serial driver
Message-ID: <20201109220133.GA961977@lianli.shorne-pla.net>
References: <20201013164454.2002023-0-mholenko@antmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013164454.2002023-0-mholenko@antmicro.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Oct 13, 2020 at 04:45:09PM +0200, Mateusz Holenko wrote:
> This patchset introduces support for LiteX SoC Controller
> and LiteUART - serial device from LiteX SoC builder
> (https://github.com/enjoy-digital/litex).
> 
> In the following patchset I will add
> a new mor1kx-based (OpenRISC) platform that
> uses this device.
> 
> Later I plan to extend this platform by
> adding support for more devices from LiteX suite.
> 
> Changes in v12:
>     - fixed descriptions in yaml files
>     - simplified probe implementations
>     - introduced litex_{read,write}{8,16,32,64}() fast accessors
>     - added formal documentation of litex_get_reg()/litex_set_reg()
>     - fixed possible memory leaks
>     - removed spin locks from CSR accessors
> 
> Changes in v11:
>     - added Reviewed-by tag
>     - reformatted some comments
>     - switched to WARN instead of BUG on CSR validation fail
> 
> Changes in v10:
>     - added casting to avoid sparse warnings in the SoC Controller's driver
> 
> Changes in v9:
>     - fixed the `reg` node notation in the DT example
>     - added exporting of the `litex_set_reg`/`litex_get_reg` symbols
> 
> Changes in v8:
>     - fixed help messages in LiteUART's KConfig
>     - removed dependency between LiteUART and LiteX SoC drivers
>     - removed `litex_check_accessors()` helper function
>     - added crashing (BUG) on the failed LiteX CSR access test
> 
> Changes in v7:
>     - added missing include directive in UART's driver
> 
> Changes in v6:
>     - changed accessors in SoC Controller's driver
>     - reworked UART driver
> 
> Changes in v5:
>     - added Reviewed-by tag
>     - removed custom accessors from SoC Controller's driver
>     - fixed error checking in SoC Controller's driver
> 
> Changes in v4:
>     - fixed copyright headers
>     - fixed SoC Controller's yaml 
>     - simplified SoC Controller's driver
> 
> Changes in v3:
>     - added Acked-by and Reviewed-by tags
>     - introduced LiteX SoC Controller driver
>     - removed endianness detection (handled now by LiteX SoC Controller driver)
>     - modified litex.h header
>     - DTS aliases for LiteUART made optional
>     - renamed SERIAL_LITEUART_NR_PORTS to SERIAL_LITEUART_MAX_PORTS
>     - changed PORT_LITEUART from 122 to 123
> 
> Changes in v2:
>     - binding description rewritten to a yaml schema file
>     - added litex.h header with common register access functions
> 
> Filip Kokosinski (3):
>   dt-bindings: vendor: add vendor prefix for LiteX
>   dt-bindings: serial: document LiteUART bindings
>   drivers/tty/serial: add LiteUART driver
> 
> Pawel Czarnecki (2):
>   dt-bindings: soc: document LiteX SoC Controller bindings
>   drivers/soc/litex: add LiteX SoC Controller driver
> 
>  .../bindings/serial/litex,liteuart.yaml       |  38 ++
>  .../soc/litex/litex,soc-controller.yaml       |  39 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  MAINTAINERS                                   |   9 +
>  drivers/soc/Kconfig                           |   1 +
>  drivers/soc/Makefile                          |   1 +
>  drivers/soc/litex/Kconfig                     |  19 +
>  drivers/soc/litex/Makefile                    |   3 +
>  drivers/soc/litex/litex_soc_ctrl.c            | 176 ++++++++
>  drivers/tty/serial/Kconfig                    |  32 ++
>  drivers/tty/serial/Makefile                   |   1 +
>  drivers/tty/serial/liteuart.c                 | 404 ++++++++++++++++++
>  include/linux/litex.h                         | 103 +++++
>  13 files changed, 831 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/litex,liteuart.yaml
>  create mode 100644 Documentation/devicetree/bindings/soc/litex/litex,soc-controller.yaml
>  create mode 100644 drivers/soc/litex/Kconfig
>  create mode 100644 drivers/soc/litex/Makefile
>  create mode 100644 drivers/soc/litex/litex_soc_ctrl.c
>  create mode 100644 drivers/tty/serial/liteuart.c
>  create mode 100644 include/linux/litex.h
(CCing Linus)

Hello,

As it looks like we have all required signoffs and no issues with the latest v12
series I have queued this in the OpenRISC 5.11 queue (where we are one of the
first users in our platform).

I am CCing Linus in case he has any concerns with these merging through the
OpenRISC queue.

In the LiteX ecosystem RISC-V and lm32 (lattice micro 32 soft core) FPGA SoC's
are also used which take advantage of these drivers.  There will be more to come
in the future, probably the next being LiteETH (ethernet).

-Stafford
