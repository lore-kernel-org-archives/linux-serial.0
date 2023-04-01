Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A928C761AF
	for <linux-serial@archiver.kernel.org>; Sat,  1 Apr 2023 03:31:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjDADbc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 31 Mar 2023 23:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjDADbb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 31 Mar 2023 23:31:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E29E053;
        Fri, 31 Mar 2023 20:31:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C637562D66;
        Sat,  1 Apr 2023 03:31:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5F8C433A0;
        Sat,  1 Apr 2023 03:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680319889;
        bh=Q7c4c+RY22KeWJ/6uXRisSnChQKt8LeWKraYLrFdG44=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=lpLjgFFhbpZegkAbU50XIUAWnA6183iLf9IWaR0Ns2TTx0If7l+GDWiC7/rMIIgVs
         qxF8+XF8zVAk6bDb+tqok1VyIPRQ6cXq7GlfR2ayuC2q4wCnQfxTvPHQ41ohMCPgnH
         YByuXDCG7phn0nl9c7NveWt5hOuPDmjv3uRqcVzgUEyFezAw4VxeCp+py4YSKRrdWb
         8aW/GBXul9LF3osj3WhGQnpnn0rAkOTu6cnQ9Y/9qS9d/Q444rr/rCA4oBjSymiqpR
         +qcc+LajJ+bsNP+cOgByb+Y+9IYZoyiTN8lgBpA7SUJdDpkwmAoOIbbUpIPvA8A1wD
         xmgO2QTYSr5Xg==
Received: by mail-ed1-f50.google.com with SMTP id ek18so97262136edb.6;
        Fri, 31 Mar 2023 20:31:29 -0700 (PDT)
X-Gm-Message-State: AAQBX9eOB5nnut/M7RVEtnoGVGy2j91gw81Errb3DO0p0invcTcLd4EE
        /OQUX3ze0LQmt1Ev6Kkp+BO5mLzgR2Wxhxqz+cM=
X-Google-Smtp-Source: AKy350a73nHShUqaxQ4pOVyv2riRCY11tklTbXjhohiW8sHVhKSoq36mJRcY1c6SaoSyODpJyWQSekcJERUzox94eUI=
X-Received: by 2002:a50:d543:0:b0:4ad:7439:cec7 with SMTP id
 f3-20020a50d543000000b004ad7439cec7mr14379125edj.7.1680319887322; Fri, 31 Mar
 2023 20:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144727.1545699-1-robh@kernel.org>
In-Reply-To: <20230310144727.1545699-1-robh@kernel.org>
From:   Timur Tabi <timur@kernel.org>
Date:   Fri, 31 Mar 2023 22:30:50 -0500
X-Gmail-Original-Message-ID: <CAOZdJXUo=o1k+TeToiZT=EbSC=NKZ5B+AsONpH5G1CkZJtVp=w@mail.gmail.com>
Message-ID: <CAOZdJXUo=o1k+TeToiZT=EbSC=NKZ5B+AsONpH5G1CkZJtVp=w@mail.gmail.com>
Subject: Re: [PATCH] serial: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 10, 2023 at 8:48=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties.
> Convert reading boolean properties to to of_property_read_bool().
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/tty/serial/imx.c       | 14 +++++---------
>  drivers/tty/serial/mxs-auart.c |  4 ++--
>  drivers/tty/serial/ucc_uart.c  |  2 +-

ucc_uart.c portion:

Acked-by: Timur Tabi <timur@kernel.org>
