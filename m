Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF42C433ED
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA4261263
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 12:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbhDZMQr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 08:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbhDZMQq (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 08:16:46 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E466FC061756;
        Mon, 26 Apr 2021 05:16:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id d15so12528625ljo.12;
        Mon, 26 Apr 2021 05:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9Aur93L6w9/5uDCnG3cRoYh62EILBVncupYganBLwm4=;
        b=F3R6RPhYXVICKhct7f8L96mfQbCFMH5Xzp/fVam33NSBaDWvJD+d0YWpQkW64nV7gx
         I8YkEbPUD2hS7QNQ6Ch6MW+36MsV7PrRZzWq87+3IgW/zXUo4uXvK03HQ3khUp9jUx0/
         V3XCQbKE3uTSqPaFhOKIPXQo+PBgR/I8xosUNJGhj42qrcVyd98eSU6VHA25jHJjhOQx
         Tmsc5uI5JNwkC8C9x4iee0bkrjgN2Pge1ffq+vBFtjye1n5Vs/21lKDJ0uGIPCkfIPdS
         H+4MSJc+HkoePpTSIAewg5PUVaoKjgj7Et02DmK6eLo92K5TKHvuX4VV3VSaGXWOmMwH
         XIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9Aur93L6w9/5uDCnG3cRoYh62EILBVncupYganBLwm4=;
        b=CrAiuL0IXUB75roBhyYuBc6qWw0K+/FcPezldRJh0f79zk27TnwJOmeZxdGUIx6Q1t
         uLB9XAq68/Q1p/wnEEuv47tO27miC06d/UQuNab2Y1hnnrQMQ8rjkNtKbSyOIY5B4aQo
         Mao2t01ukQDEuPdYJcdQzmiFoDMKMxDfm6E4ESj0Lw7EQgytGdGgQcXg3+XjTSwcX6Oa
         QruOHhGO+b4HhvZ9dBRnOj9iguLQeasplRvQHm2UBvu6+H9oMRNA8NfIgdzPC+wjPDZO
         NpmrwLr5u3uHC4LZQMfbmb0AtvY8cMx/TLchJJy3lAXEhgv6G78N6wcqscHfVnTGW9nQ
         lkPg==
X-Gm-Message-State: AOAM5334+U071ljhhJdiJHwZaE7fDVn6vhC/C9T5Yx4w3V752X218LjK
        ASgHaSCguKDkW3RHpglSg8i3pqisQVEhJ+CU1Pk9KmVU1GM=
X-Google-Smtp-Source: ABdhPJyM6O4Gkw7A9l0U0LeD/osYPrsps4xfL835FgFR952mtEfN2e5JtSFum+QMXZGWCCNluUtWFEFxBywsoo05KbY=
X-Received: by 2002:a2e:990b:: with SMTP id v11mr12700046lji.53.1619439363473;
 Mon, 26 Apr 2021 05:16:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210426074935.11131-1-sherry.sun@nxp.com> <20210426074935.11131-3-sherry.sun@nxp.com>
 <YIZ1NvISshNHtX/Z@kroah.com> <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
 <CAOMZO5Bmv2CVZeJbwLhZcH7pb7Tb9FhCrPSjhkbaJO8vYtRHLw@mail.gmail.com> <AM0PR04MB49472A690A93C06CE27FFC4692429@AM0PR04MB4947.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB49472A690A93C06CE27FFC4692429@AM0PR04MB4947.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 26 Apr 2021 09:15:51 -0300
Message-ID: <CAOMZO5DXLoy-PRQW0sYXf+eDOZ1=XqKsC-hcNWMKLg9K2oGQQg@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Apr 26, 2021 at 9:09 AM Sherry Sun <sherry.sun@nxp.com> wrote:

> Thanks for your reply.
> I guess you mean the of_match_table will not be NULL since it contains co=
mpatible, right?
> But for the lpuart data -- struct lpuart_soc_data, won=E2=80=99t it meet =
the NULL case? such as { .compatible =3D "fsl,imx8qxp-lpuart",  }.
> Here of_device_id won=E2=80=99t be NULL, but lpuart_soc_data Is NULL.

In linux-next we have:

static const struct of_device_id lpuart_dt_ids[] =3D {
{ .compatible =3D "fsl,vf610-lpuart", .data =3D &vf_data, },
{ .compatible =3D "fsl,ls1021a-lpuart", .data =3D &ls1021a_data, },
{ .compatible =3D "fsl,ls1028a-lpuart", .data =3D &ls1028a_data, },
{ .compatible =3D "fsl,imx7ulp-lpuart", .data =3D &imx7ulp_data, },
{ .compatible =3D "fsl,imx8qxp-lpuart", .data =3D &imx8qxp_data, },
{ /* sentinel */ }
};

All compatible entries have a .data field populated.

How sdata can be NULL?
