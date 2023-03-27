Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD52C7619A
	for <linux-serial@archiver.kernel.org>; Mon, 27 Mar 2023 08:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232509AbjC0IIW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 27 Mar 2023 04:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjC0IIV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 27 Mar 2023 04:08:21 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34440A3
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 01:08:20 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id y35so5453582ljq.4
        for <linux-serial@vger.kernel.org>; Mon, 27 Mar 2023 01:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679904498; x=1682496498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WhkiKbYWviarc2tDVjRo8U/7X+7Rwvhw898wgrGlMLw=;
        b=f2B7ncHXZgIem9nNYaS2qScK7neBcsEGylnl51F7KHfq2ig3gYFW92q2I98pTxXQBT
         OopJb9DJcWUkGm/RgJ8lf8bMF85n/pegIJADU19kKaA1teA+qcISAQWSz3mFne0vj77a
         bnfghPufBrSzdWuWEq2t/rAp98oL1rqG4A8iRh2x9O/Hy5L+EeE39D9mnrH14tvBLvRb
         MkmC+X/Ls2MXr57GDKhq2VBWVsK8FzYHT913/sJpUJa6m+YaLEAZiZeXu23uhi0Lpnrv
         E2kzhdG2h5+S64XD367xQoYnouS2Q4Q/GLbe7EFUYBkMiqFv3rXhrpEQYmSLSIbKGjTs
         jjtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679904498; x=1682496498;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WhkiKbYWviarc2tDVjRo8U/7X+7Rwvhw898wgrGlMLw=;
        b=m0dmDtFngcx55htZ3YxpjSUkX4Zb2ZPSdyOagNmFFF37xV5ECtRxoKJC5rGQElhOK8
         GcefuFKMm0lr3LyX8OEa5swFRrnf8DFEoXKGXtEnsNL4q+GzuCPXrVG+eQ6HxVAYTq8U
         CXMl+/6L6wCc8Gbhc9nFSFfJRTsDMLJFba+ZRiTI5bZqlKyVExM4SBqqC2E05Rbi1zTL
         b4Stg95zGsdZr5zmujSV3NGUa7s1Oq0qtM/43IZEKhZYbqk5yTuNZ2cw5xse78sH1pda
         CSFP/sNZd6N7kCLHn50AzKoE+Q4Nom0iRawXXtkgps2985C+V4ZFNbtcAjjpw5Lk1ErK
         RC+g==
X-Gm-Message-State: AAQBX9fKEfAsGxkC2CzWxggBS3MEfYh1BgvDs/G/TnCxf6z2GzBQBwIk
        df5reEvjgZBSBLz0bS7OEIE=
X-Google-Smtp-Source: AKy350aO/3DJhxQfJPRjSfc6f/W/g8bVhMzKyF8/1DUs9fhdf3nSlIqBS4EMaOB8p7j546mOmYonoQ==
X-Received: by 2002:a2e:9b0a:0:b0:29f:69f7:e4f8 with SMTP id u10-20020a2e9b0a000000b0029f69f7e4f8mr3494408lji.42.1679904498345;
        Mon, 27 Mar 2023 01:08:18 -0700 (PDT)
Received: from [10.241.138.38] ([80.82.20.2])
        by smtp.gmail.com with ESMTPSA id d16-20020a2eb050000000b0029aa0b6b41asm4382732ljl.115.2023.03.27.01.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 01:08:17 -0700 (PDT)
Message-ID: <880126f0563aba70f713ce91981de027d86593b3.camel@gmail.com>
Subject: Re: Regression: serial: imx: overrun errors on debug UART
From:   Tomasz =?UTF-8?Q?Mo=C5=84?= <desowin@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Fabio Estevam <festevam@gmail.com>,
        Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Stefan Wahren <stefan.wahren@chargebyte.com>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sergey Organov <sorganov@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tomasz =?UTF-8?Q?Mo=C5=84?= <tomasz.mon@camlingroup.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 27 Mar 2023 10:07:29 +0200
In-Reply-To: <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com>
References: <2c29454b-9369-4360-8eb4-c151f59460cb@i2se.com>
         <d660e3cf-5686-d989-3b59-efe83ec9d590@linux.intel.com>
         <CAOMZO5A+GujiQY-UT3Q-8o0AKujJb_4kY+5L4x1e07ovGfo31w@mail.gmail.com>
         <9e22f237-f3ee-0415-9e6b-89a137769b8f@i2se.com>
         <5d59dec6-9f6f-7b20-1221-f57c94b29cca@i2se.com>
         <20230325151100.mskydt3hwbnspqp4@pengutronix.de>
         <07d37e3e-dfe2-9e6e-a981-8d3c6a9fc5f5@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sat, 2023-03-25 at 18:05 +0100, Stefan Wahren wrote:
> Am 25.03.23 um 16:11 schrieb Uwe Kleine-K=C3=B6nig:
> > So on an UP system the problem should occur also on a non-console port?
>=20
> This is less likely, because UART applications usually need some kind of=
=20
> flow control (either from hardware or protocol side). For a non-console=
=20
> application the receiver usually wait until the end and then starts to=
=20
> transmit.
>=20
> Sure you can flood the UART with characters and it's only a question of=
=20
> time until the RX FIFO is full and data get lost. But i think we should=
=20
> focus on the real use case and don't try find the perfect solution. At=
=20
> the end it's always a compromise between latency and throughput.

If you enable DMA on the UART then you are extremely unlikely to hit
overflow. To some degree the DMA can be seen as "extended" RX FIFO.

Unfortunately DMA cannot be used for imx console UART.

> > That makes me wonder if the error doesn't relate to the UART being a
> > console port, but the UART being used without DMA?! (So the patch above
> > fixes the problem for you because on the console port no DMA is used?)
>=20
> As i said the issue only occured on the console. My problem is that the=
=20
> other UARTs on Tarragon are used for RS485 which means they are just=20
> half duplex.
>=20
> According to these lines in imx.c DMA is never used for console:
>=20
>    /* Can we enable the DMA support? */
>    if (!uart_console(port) && imx_uart_dma_init(sport) =3D=3D 0)
>      dma_is_inited =3D 1;
>=20
> At the end the patch above only restores the old console behavior, but=
=20
> keep Tomasz Mo=C5=84's optimization for non-console (which was indented f=
or).

Setting RXTL to 1 is essentially making the irq raised a bit earlier,
i.e. when the RX FIFO can hold 31 more characters. With RXTL set to 8
and data burst, the irq is raised when RX FIFO can hold 24 more
characters. Therefore with RXTL set to 1 (instead of 8) the maximum
acceptable RX interrupt latency (i.e. before you losing incoming
characters) is 7 characters time longer.

Best Regards,
Tomasz Mo=C5=84
