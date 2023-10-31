Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289C6C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 31 Oct 2023 02:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjJaCAv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Oct 2023 22:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJaCAu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Oct 2023 22:00:50 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7194E6
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso4109864a12.3
        for <linux-serial@vger.kernel.org>; Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1698717647; x=1699322447; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ysFHtwfLEtis2HEwrxQHDKnfNsPImE2g/7GGtzNp+Cs=;
        b=RA0zuQurBpzYYfjoncjl1kshFj3iAGNIw3NKTxySaBBPtVj/wd5SKoIIAEqT071n2g
         u8J8MlnD8DYzzR4sOIQPxbwdVqRqjyN1CPa2FTv+5p0A6cWkQqe9e5/wx7ZoTZre/dws
         n6YeCGYiyXr0yQYwjly+z4aEl4jxOH/7s1dtkQ7y7hoyy7/7jUM0j5ddNVd+B/zJadk+
         sb1a++EwzSH11of0XYBZmkazOmcCqjL4Exyyk7ZJHvpsCehjyowvTW8DWITyYOvg6fUw
         sr5RJmpYKdB0yuSm6ixVX0ixxlNR3G2v9EyVqHnquwekNJ0sboVSZB30lCkWvcA1EI//
         Nziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717647; x=1699322447;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ysFHtwfLEtis2HEwrxQHDKnfNsPImE2g/7GGtzNp+Cs=;
        b=RxajGvLxLLdfZLcYRAsZ5Q3FemRt/3sEROdJJN+5VG1M8b+IXAQaNpdQPIJq3e7GWy
         Y3nWxMwiV9RJWEqujKRJzfDlLSyRHnaqFw0acBn/lJigcA8s/nVlof2advF+5jADqaIm
         Gfsww1lneZQkIu9LUBJW2uhcHi2KSkyfOXGjDVSFtGyzSyZB5/BOGblVWBEDSeNsLNXz
         kUDDOrMcqxdGJ+j7+aU+oaJKYT1rBovo9i91Tl+PZOo3dBOe6Nt7fu87O5Q4DdpIld9p
         EAlx185OGCrqogly4oOdPh5OLFC1v72aWLaxRAxms3nqEA7EbIw/08asG4BJ/MbVqsGc
         Ap1g==
X-Gm-Message-State: AOJu0YxBZCTfaco7TATYMn1xQmr3UCFoKESVJolvilA8WJc/QI6B2FPv
        hb6uYau6ichMKMgpIpcMSTVNPQ==
X-Google-Smtp-Source: AGHT+IEf0KaLXQATJy7Y+aQfRDpTBjnOxd6k1XM+fNDmCwu9+0PAZyGarOs4HgtrLS/PIbK2VfXdgQ==
X-Received: by 2002:a05:6a20:a220:b0:17b:e0a3:f6f4 with SMTP id u32-20020a056a20a22000b0017be0a3f6f4mr9170362pzk.25.1698717647083;
        Mon, 30 Oct 2023 19:00:47 -0700 (PDT)
Received: from sunil-laptop ([106.51.188.78])
        by smtp.gmail.com with ESMTPSA id b17-20020a056a000a9100b006934e7ceb79sm159585pfl.32.2023.10.30.19.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:00:46 -0700 (PDT)
Date:   Tue, 31 Oct 2023 07:30:35 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-serial@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anup Patel <anup@brainfault.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Atish Kumar Patra <atishp@rivosinc.com>,
        Haibo Xu <haibo1.xu@intel.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [RFC PATCH v2 11/21] PCI: MSI: Add helper function to set system
 wide MSI support
Message-ID: <ZUBfw2vrzc+GyAny@sunil-laptop>
References: <20231025202344.581132-1-sunilvl@ventanamicro.com>
 <20231025202344.581132-12-sunilvl@ventanamicro.com>
 <87a5s0yyje.ffs@tglx>
 <ZT/t0UY5rbudhjfH@sunil-laptop>
 <874ji7zz7a.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ji7zz7a.ffs@tglx>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 30, 2023 at 08:29:13PM +0100, Thomas Gleixner wrote:
> On Mon, Oct 30 2023 at 23:24, Sunil V. L. wrote:
> > On Mon, Oct 30, 2023 at 03:28:53PM +0100, Thomas Gleixner wrote:
> > Just noting related discussion :
> > https://www.spinics.net/lists/linux-serial/msg57616.html
> >
> > The MSI controller on RISC-V (IMSIC) is optional for the platform. So,
> > when by default pci_msi_enable = 1 and the MSI controller is not
> > discovered, we get stack trace like below.
> 
> <SNIP>
> 
> > So, what I did was, by default call pci_no_msi() to disable MSI and then
> > call pci_set_msi() to enable when MSI controller is probed.
> 
> Your taste sensors should have gone out of range ...
> 
> > But I think Bjorn's suggestion to depend on PCI_BUS_FLAGS_NO_MSI may be
> > better idea. In that case, we need to set bridge->msi_domain to true in
> > pci_create_root_bus(). Let me know what do you prefer or if I am
> > completely missing something here.
> 
> That's definitely more sensible, but as I said in the other thread, Marc
> is the one who did the PCI core/bridge setup magic and he is definitely
> in a better position to answer that bridge->msi_domain question.
> 
Thanks!. It looks like Marc introduced bridge->msi_domain in [1] for
exactly the same problem we have with RISC-V + ACPI. Let me remove this
hack and do similar to pci_host_common_probe() in next revision unless I
get objections to that approach.

Sorry, somehow my script didn't copy Marc in the series. Will make sure
I copy him explicitly in next revision.

[1] - https://lore.kernel.org/all/20210330151145.997953-12-maz@kernel.org/

Thanks!
Sunil
