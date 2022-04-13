Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0706DC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 13 Apr 2022 21:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiDMVyw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 13 Apr 2022 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbiDMVyw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 13 Apr 2022 17:54:52 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE7C26542
        for <linux-serial@vger.kernel.org>; Wed, 13 Apr 2022 14:52:29 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id n8so3095318plh.1
        for <linux-serial@vger.kernel.org>; Wed, 13 Apr 2022 14:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5II3n/+h3pivxbaF4Zlsk6J/11Tk5zgxZni781mRMks=;
        b=vfNOMQF23PUUYhslMTsPc88fGqI/w/7RwE3Y+rQbjASYPl1JRZYkjCyiqvR+MlNzjz
         fs2BJzp2MtxsYq0rjo9jR3eolql9ISfdEKQYRfPMxgEdaE4ykzR81x9JJxc3ZmQVfTy/
         +Kl+ROe0ehO9bvmvKH6Z7EmRt1BzTnkuD+jte2bv9VSUZ3h/KYJMKSG8njJfZtK2WdeG
         z8+4B2CWJ+qjrPf8He1vdE9f0rTayzBgPLWqKP4Iem19hdierTtX1G45FwqOcebVuZhw
         NvMGsTlw3Ihv93OUD9UtUxgKAeb4QgFul2h4JTVPIdfoJ6c+uU1bWQvj2Au486LKCU1+
         Eqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5II3n/+h3pivxbaF4Zlsk6J/11Tk5zgxZni781mRMks=;
        b=F1mHI7vN6Bvnc5dSrlE3gZKw0OYh2AVEx9zXpOP/ttKsPupXTipb3M1LMVXHK5/N53
         3wQZLDMI62dpwI8B2VzL1tl4ZdMrJBs4rPeD3OuphkAreUUD1l4TQSu7ujiiStQjhI1x
         7hJ6/WqjOaOnJd1cEIFhqv0a3HgwV7nKrINFtl8DF89anqzN4G2Uy0HIXuNcRLm+cDm0
         C/Sap09T5yncGuT//rInp5g5lv7raPzawXxrXi2YLclXGc+eM3kmmvqQzssY1Xtm+Qoa
         kQjMUwIgJo+UwbhSqjCdQc+/vfYtGvBE2QnSupFqyk+lq1GTnRT2AQboltrCLFVm6OCB
         /1SQ==
X-Gm-Message-State: AOAM531v31MtyawAKDHshEMXcG5MuYc5Do/adwH9Q3gJkKI66QDpeP9F
        vY6kJls6O28WCwd5FOj0JzCAUt1R2UyAkg==
X-Google-Smtp-Source: ABdhPJzH9INoE7i/6xgm6BLOYIKln7WffJZnT0GLl47dO+VUcGZI8dfFW0KpRsmGzjOhjaom6Cr93Q==
X-Received: by 2002:a17:902:7006:b0:156:3cbe:6b04 with SMTP id y6-20020a170902700600b001563cbe6b04mr43467020plk.68.1649886748497;
        Wed, 13 Apr 2022 14:52:28 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id k6-20020a056a00134600b004faba67f9d4sm37928pfu.197.2022.04.13.14.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:52:27 -0700 (PDT)
Date:   Wed, 13 Apr 2022 14:52:27 -0700 (PDT)
X-Google-Original-Date: Wed, 13 Apr 2022 14:52:19 PDT (-0700)
Subject:     Re: [PATCH 00/12] Initial support for Nuclei DemoSoC w/ UX600
In-Reply-To: <mhng-b11934a9-100f-457b-a35e-46bdcd7f43f4@palmer-ri-x1c9>
CC:     robh+dt@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     icenowy@nucleisys.com
Message-ID: <mhng-aeb81250-47b1-4189-a668-695c410d2450@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 21 Mar 2022 17:05:45 PDT (-0700), Palmer Dabbelt wrote:
> On Tue, 22 Feb 2022 08:56:42 PST (-0800), Palmer Dabbelt wrote:
>> On Sat, 19 Feb 2022 06:45:43 PST (-0800), icenowy@nucleisys.com wrote:
>>> 在 2022-01-27星期四的 23:16 +0800，Icenowy Zheng写道：
>>>> This patchset adds support for Nuclei DemoSoC (which is an evaluation
>>>> platform made with Nuclei CPU cores and mainly peripherals in
>>>> original
>>>> Hummingbird E203 project, running on FPGA) with UX600 CPU cores.
>>>>
>>>> Most patches are for DT bindings, the remaining ones are adding a
>>>> Kconfig option and some DTS/DTSI files. The last one is a workaround
>>>> for
>>>> a severe bug in currently released versions of UX600, which is found
>>>> in 5.17 kernel, in which Sv48 support is added to Linux.
>>>>
>>>> Two non-technical patches are in this patchset too, for MAINTAINERS
>>>> and .mailmap items.
>>>
>>> Ping, could any RISC-V maintainers review these patches, especially the
>>> SATP workaround one?
>>
>> Sorry, I remember having written this but I guess it got lost.  IIRC my
>> main worry here was that, at least as far as I can tell, DemoSOC is an
>> FPGA development board.  If this is actually in production somewhere
>> then it's a different story, but IIUC the general rule is not to accept
>> code for development hardware that can be updated.
>>
>> Assuming DemoSOC can be updated, I'd also argue that we should have some
>> sort of version attached to it in DT entries.  Without some versioning
>> we'll end up lost when trying to later determine what we're actually
>> running on.
>>
>> As far as the errata goes: it looks fine to me, but I'd like to see some
>> sort of description of what the errata actually is (ie, some
>> documentation from the manufacturer).  I know that's not always
>> possible, but without some desciption of what the bug is it gets tricky
>> to mainain this sort of stuff.  For example: we've got sv57 patches
>> now, so how do I know what to do with them on this target?
>
> Just following up on this one.  Not sure if I missed it, but I can't
> find a reply.

Checking up on this one more time, I still can't find any replies.  It's 
at the top of my queue, but I'm going to drop it until the questions get 
resolved.

>
>>
>>>
>>>>
>>>> Icenowy Zheng (12):
>>>>   dt-bindings: vendor-prefixes: add Nuclei
>>>>   RISC-V: add Nuclei SoC Kconfig option
>>>>   dt-bindings: riscv: add compatible strings for Nuclei UX600 series
>>>>   dt-bindings: timer: add compatible for Nuclei UX600 CLINT-compat
>>>> timer
>>>>   dt-bindings: interrupt-controller: add compatible string for UX600
>>>>     PLIC
>>>>   dt-bindings: serial: add compatible string for Nuclei DemoSoC UART
>>>>   dt-bindings: spi: add compatible string for Nuclei DemoSoC SPI
>>>>   dt-bindings: riscv: add binding for Nuclei platform boards
>>>>   riscv: dts: add device tree for Nuclei DemoSoC w/ UX600 on DDR200T
>>>>   RISC-V: workaround Nuclei UX600 cores with broken SATP CSR
>>>>   MAINTAINERS: add myself as Nuclei SoCs/CPUs supporter
>>>>   mailmap: add Icenowy Zheng's Nuclei mail addresses
>>>>
>>>>  .mailmap                                      |  1 +
>>>>  .../sifive,plic-1.0.0.yaml                    |  1 +
>>>>  .../devicetree/bindings/riscv/cpus.yaml       |  7 ++
>>>>  .../devicetree/bindings/riscv/nuclei.yaml     | 27 ++++++++
>>>>  .../bindings/serial/sifive-serial.yaml        |  1 +
>>>>  .../devicetree/bindings/spi/spi-sifive.yaml   |  1 +
>>>>  .../bindings/timer/sifive,clint.yaml          |  1 +
>>>>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>>>>  MAINTAINERS                                   |  7 ++
>>>>  arch/riscv/Kconfig.socs                       |  6 ++
>>>>  arch/riscv/boot/dts/Makefile                  |  1 +
>>>>  arch/riscv/boot/dts/nuclei/Makefile           |  2 +
>>>>  .../dts/nuclei/nuclei-demosoc-ddr200t.dtsi    | 41 ++++++++++++
>>>>  .../nuclei/nuclei-demosoc-ux600-ddr200t.dts   | 13 ++++
>>>>  .../boot/dts/nuclei/nuclei-demosoc-ux600.dtsi | 49 ++++++++++++++
>>>>  .../riscv/boot/dts/nuclei/nuclei-demosoc.dtsi | 67
>>>> +++++++++++++++++++
>>>>  arch/riscv/include/asm/vendorid_list.h        |  1 +
>>>>  arch/riscv/mm/init.c                          | 17 +++++
>>>>  18 files changed, 245 insertions(+)
>>>>  create mode 100644
>>>> Documentation/devicetree/bindings/riscv/nuclei.yaml
>>>>  create mode 100644 arch/riscv/boot/dts/nuclei/Makefile
>>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>>>> ddr200t.dtsi
>>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-ux600-
>>>> ddr200t.dts
>>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc-
>>>> ux600.dtsi
>>>>  create mode 100644 arch/riscv/boot/dts/nuclei/nuclei-demosoc.dtsi
>>>>
