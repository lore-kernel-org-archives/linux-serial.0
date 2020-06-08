Return-Path: <SRS0=jM0J=7V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60565C433E1
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 07:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF8F206A4
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 07:39:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=antmicro.com header.i=@antmicro.com header.b="n7l0SgK9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728993AbgFHHjU (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728995AbgFHHjT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Jun 2020 03:39:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B152BC08C5C5
        for <linux-serial@vger.kernel.org>; Mon,  8 Jun 2020 00:39:19 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id o5so17466811iow.8
        for <linux-serial@vger.kernel.org>; Mon, 08 Jun 2020 00:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=antmicro.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LcwxlrO/OObtBQp//yDfIfqp8ggk2aG49WGm1nxOKD8=;
        b=n7l0SgK9ly7tIWiC0hISkTN3Hg2xfxISuMCU9sxOQu/SbdAa1fPI6m9kQUgTIvoFM7
         C+6iVxxUFAKeWiJsobiB8zgjj1c/oomV2+G/06e3svaycDfPnY29rAtSTIOBsnG+Bl2Y
         F9gm0DmjVJY857Uzj+uzTUGFtSZRQjxFkrhc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LcwxlrO/OObtBQp//yDfIfqp8ggk2aG49WGm1nxOKD8=;
        b=RzcUnwuN3ZUPlMsIjNKP/jL/0Mdl0jlOTScFfxKeeKBO3F8oOCiyzwQNwo/C+TDCxz
         K9AjqOv3hi8SZyxZLqM6fU6IBmq69KqDhDvTNBe/e7ZmX1yHEceZqkteO3WGbNQPDHhi
         tppF3kY25LeeSDU3ST3FM+ozlZeYb2UJqnZFyaU+iMmsMJkJ/0dg/6bdZrnl/k5aLJxg
         IS6E3OArEsYNXp+xZwU6MYJY9LcMF5j7Q+WMGNYfwc5BwlokK0qV6i2UUYgQneLESI0f
         nZ3gnYEniBMI9tcf67FcIcb9TUU7JKQnz9WMSKi677PR1S2Ap4czUJrzK9MAH9TKtDNH
         OnaA==
X-Gm-Message-State: AOAM533+5v7waJDi+MQYnCuNAitAEF2aOxueW/C5ZQ3bUQMDCxI9G1+9
        N/7Ox8yvaUelpYzaxuVCr5D7d7uVMXFO6AlC995GkA==
X-Google-Smtp-Source: ABdhPJzv9bSNg0c3Lb6MGeHJNsgYaaWNOKBk8ind/PzQbkI7YxOFtQHBnXFLW0ow5/C/vDqq7sQ+aZCfb1kkxDZK50U=
X-Received: by 2002:a6b:b9d5:: with SMTP id j204mr20788375iof.38.1591601958860;
 Mon, 08 Jun 2020 00:39:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200604121142.2964437-0-mholenko@antmicro.com>
 <20200604121142.2964437-5-mholenko@antmicro.com> <418aa34e-af6c-3a3c-8d22-e7a122963b8f@infradead.org>
In-Reply-To: <418aa34e-af6c-3a3c-8d22-e7a122963b8f@infradead.org>
From:   Mateusz Holenko <mholenko@antmicro.com>
Date:   Mon, 8 Jun 2020 09:39:08 +0200
Message-ID: <CAPk366SL_MPV6Y4oYvkM=cPA9n36cWd3Km9ffeHYaZ9hpC9FqA@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] drivers/tty/serial: add LiteUART driver
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        devicetree <devicetree@vger.kernel.org>,
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gabriel L. Somlo" <gsomlo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Randy,

On Thu, Jun 4, 2020 at 5:14 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 6/4/20 3:14 AM, Mateusz Holenko wrote:
> > +config SERIAL_LITEUART
> > +     tristate "LiteUART serial port support"
> > +     depends on HAS_IOMEM
> > +     depends on OF || COMPILE_TEST
> > +     depends on LITEX_SOC_CONTROLLER
> > +     select SERIAL_CORE
> > +     help
> > +       This driver is for the FPGA-based LiteUART serial controller from LiteX
> > +       SoC builder.
> > +
> > +       Say 'Y' here if you wish to use the LiteUART serial controller.
> > +       Otherwise, say 'N'.
>
> That last paragraph seems to say that Y and N are the only choices here.
> It can also be set to M ...

You are correct, we'll update the help message to make it clear.

> --
> ~Randy
>

Thanks for your comment!

Best,
Mateusz

--
Mateusz Holenko
Antmicro Ltd | www.antmicro.com
Roosevelta 22, 60-829 Poznan, Poland
