Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C469C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 09:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EE2661B64
	for <linux-serial@archiver.kernel.org>; Thu, 18 Nov 2021 09:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245303AbhKRJyd (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 18 Nov 2021 04:54:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245299AbhKRJxj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 18 Nov 2021 04:53:39 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0718CC0613B9;
        Thu, 18 Nov 2021 01:50:39 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y13so24195799edd.13;
        Thu, 18 Nov 2021 01:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8wOguc8jx2+q919i1GFzyRAMCGVpMY2PeY61WajjZBI=;
        b=lc29rqRvkyvhBlEAEQG34JDjGOwLbumrsoN0AIETvysYRFyOGhqB38Fa4L0fV4CxWD
         EuVlDa7cDRRRy1KQ7R2UU1SlZcu7s7RdUB8NWXfrdt0wlf1j9qLYglwuZUJXOxVR+EiK
         /GtktosIg5FCqRuwqZu8WdImD6XMizse5V+V7Zd0ycRW0Q+6PzXxINh+XVIIrj9CH0i9
         G5cmLm4BL7qREwniY5MIWyECjGUuI9emSrQHpZ5F+Ri2pDsrN/i2q5PF064CtUwMdlmU
         gVCjJSjI5nnLtF+j5u4jswwICthVHtd980JHdKuC3PoTBU1DMHXhjlwK7wCpU8rdd73k
         9NMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8wOguc8jx2+q919i1GFzyRAMCGVpMY2PeY61WajjZBI=;
        b=G7kPPLMeEBWS6udwX/Mv6v2akjPxqKmJaUf+aThEw7T589qJ8Zfzaj0Yan2EUStRiE
         y5xyfv1SszStmqIML70jq5n9KfktU4QDkaaAZvx9g1E/tbUPUVt38Q+dun0sSFUd7/cr
         O6KCHGwtXpHUhcjp4fQnqDzGbH4wYrVq8/YW94bhMUYgNXJdMeEJqcybFSDp+cyh5awi
         0a5PkwkIjuwS93t/QS5Ke+vDnmVI9p2UF9KA1+b7o96XQL0iQwDS/OvqizmxrR0j+S9x
         VOp+aq7fpkw3D6lHlDud786pSaCuJ6CtDmp4KZdOvxlpKhDaJbX/t1DjyDF2qjTDR79B
         JnKg==
X-Gm-Message-State: AOAM531WetUsQgiCI5FG/T2PfPDmzo4TmYupzfvDXixjES82cnnBB1jM
        5cBf8L1f5+VRKL97OpIGoQ3PwGS0FIdgPHED9HgtDhmNuXY=
X-Google-Smtp-Source: ABdhPJyHHD0nbXQv7yaiIuWjk0bmwPGBDvhDqTpeH9/ZsyZgt1g/xanFSvzGy4lfGNdSHrTRWrw3j+7pidaLGckkYRY=
X-Received: by 2002:a17:906:489b:: with SMTP id v27mr31007057ejq.567.1637229037593;
 Thu, 18 Nov 2021 01:50:37 -0800 (PST)
MIME-Version: 1.0
References: <20211117145750.43911-1-andriy.shevchenko@linux.intel.com>
 <20211117145750.43911-2-andriy.shevchenko@linux.intel.com> <36a3c24a-59c1-2537-14ef-c750aaa55ea9@accesio.com>
In-Reply-To: <36a3c24a-59c1-2537-14ef-c750aaa55ea9@accesio.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Nov 2021 11:50:01 +0200
Message-ID: <CAHp75VfDPuPbvRsfKX2+0NT0K36-+xzDA2QscXD5Wcta1Q5zuQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] serial: 8250_pci: Split out Pericom driver
To:     Jay Dolan <jay.dolan@accesio.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Nov 18, 2021 at 4:39 AM Jay Dolan <jay.dolan@accesio.com> wrote:
> On 11/17/21 6:57 AM, Andy Shevchenko wrote:

Thanks for looking into it. My answer below.

...

> > +     for (i = 0; i < nr && i < maxnr; i++) {
> > +             unsigned int offset = (i == 3 && nr == 4) ? 0x38 : i * 0x8;
> I'm told this works for PCIe ACCES PIDS, but the PCI PIDs don't have the
> fourth port at the wrong address. I didn't know this until just now.

For the sake of context I left below PCI IDs, all of them have PCIE
prefix. Moreover, the patch should not change this logic (see
different setup functions in the original code). So if it wasn't
working it is not working anyway. Besides that, what does the above
mean? The ID can't be the same for two different hardware.

> I've never had reason to try and tell if a pci_dev is PCI or PCIe. Can
> we query capabilities?

This is confusing me. What does all this imply?

> It may also be possible to tell by the size of
> one of the BARs.

This is already done by calculating maxnr.

> I've requested a four port PCI card and should have it
> tomorrow.

I'm looking forward to seeing any test results.

> I'm currently building the previous patch set for testing.

Noted, thanks!

...

> > +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7951) },
> > +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7952) },
> > +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7954) },
> > +     { PCI_VDEVICE(PERICOM, PCI_DEVICE_ID_PERICOM_PI7C9X7958) },
> > +
> > +     /*
> > +      * ACCES I/O Products quad
> > +      * (Only 7954 has an offset jump for port 4)
> > +      */
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SDB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2S) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SDB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4S) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM422_8) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM485_8) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_2DB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_2) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_4DB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM232_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM232_8) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_2SMDB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_2SM) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SM) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_4SMDB) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_COM_4SM) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_COM_8SM) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_1) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_2) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_2) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM422_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM485_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2S) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4S) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_2) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_2) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM232_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_MPCIE_ICM232_4) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_2SM) },
> > +     { PCI_VDEVICE(ACCESSIO, PCI_DEVICE_ID_ACCESSIO_PCIE_ICM_4SM) },

-- 
With Best Regards,
Andy Shevchenko
