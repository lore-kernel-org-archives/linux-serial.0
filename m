Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A63AC4332F
	for <linux-serial@archiver.kernel.org>; Thu, 15 Dec 2022 22:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiLOW7I (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 15 Dec 2022 17:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiLOW7G (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 15 Dec 2022 17:59:06 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33935D694
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 14:59:05 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 65so601601pfx.9
        for <linux-serial@vger.kernel.org>; Thu, 15 Dec 2022 14:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2SB2sSya4Ddi5efQAnNuIrIFLGDqqdhqUT8BFS9F+3E=;
        b=cBNXcmDiSF2Tcdw4zjSW2LXkaVS11MIMy7RD4iWbACYkUVNDPCEclS405sc6NArBVV
         PvbOrjkRWRQSxgd2tuRJ8Gw8iTvfgT3YBtAUBt+LxFyTbKpPCFCgYSw9s1jF5loQAMHo
         hfD62eRbp09JCj8XGkztGEwB2iUWjY7VPYC9KSyoteaDe4dJqBuwYG58c76RDNjX5Qvz
         EjHVBjhXhjLFtC70yKVQVrMe5yeulPuuqN9IuedKFNRb6eASpWCG011p0YVm37GBQxWg
         pw8deVPMa+BlUH4h90ZLtqFOxulJSXKgjjX1Zgg31+OL4EDBCVPV5TH5v1k9OkpYvalE
         UYLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2SB2sSya4Ddi5efQAnNuIrIFLGDqqdhqUT8BFS9F+3E=;
        b=f5QDBmcdQcsM/f9CwbpbBWuSTeLEShR3nF7g/AU4ZCyozmatMS/RKPPhY0ZPloBCi1
         WpBw1gKgh4WbwiLaSQdimObbRZZ62gYj7Oe5mA3U01zqgAVJX87JQ3P3Z3ciAKH3hZ3Z
         PSoajig4AtCjoN2JPW449gyNNtLsDmlRL9wDylnVRTTznnaG3SxGMu7DKM5F4ZQ1aVBn
         qEkhgYjMadhD1VTWbVuSiOmZeYw3HHy1K77jQmQK+PTtk/K3I/FVolpf5FQPs2V3/Sqt
         pr2R8mRaYY6qieVIWWd46jyuVPZ0/nVYbdiCelTzD5Wj/2WN7xea9598+rejHsXJaEJh
         QMsg==
X-Gm-Message-State: ANoB5pk2aww4Y6+YzE1cH7xyeFepyeXk0RK9vu3i5bP377N82HhrILiN
        GQkeWAr0uAO6pE6D1yfdCUFiUWolpVk1/ue9jAU=
X-Google-Smtp-Source: AA0mqf4zi3RU0lsoZrwjaRLM4TlXsshV5pbS4x0oEa2cj9ILbjBhUVt3/kDG4IAmSeLZuBs+DJkdc3G8LzQ39ZUuj3Y=
X-Received: by 2002:a63:b54:0:b0:434:911a:301 with SMTP id a20-20020a630b54000000b00434911a0301mr72047301pgl.50.1671145145190;
 Thu, 15 Dec 2022 14:59:05 -0800 (PST)
MIME-Version: 1.0
References: <87bko4e65y.fsf@osv.gnss.ru> <CAOMZO5DFth_0wzBb8HHeHoNGkT1rexb7xvakvfiNgdY=cHJSfg@mail.gmail.com>
In-Reply-To: <CAOMZO5DFth_0wzBb8HHeHoNGkT1rexb7xvakvfiNgdY=cHJSfg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 15 Dec 2022 19:58:47 -0300
Message-ID: <CAOMZO5CPuYxtDFpGYq0HA3DzYyPvouOz1aB3nhzHaJ73cFWW=g@mail.gmail.com>
Subject: Re: serial: imx: sudden rx flood: hardware bug?
To:     Sergey Organov <sorganov@gmail.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        =?UTF-8?Q?Tomasz_Mo=C5=84_=3Ctomasz=2Emon=40camlingroup=2Ecom=3E?= 
        <k.drobinski@camlintechnologies.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Dec 15, 2022 at 6:38 PM Fabio Estevam <festevam@gmail.com> wrote:

> +       if (!imx_uart_is_imx1(sport)) {
> +               u32 ucr3 = imx_uart_readl(sport, UCR3);
> +               ucr3 |= UCR3_ADNIMP;
> +               imx_uart_writel(sport, ucr2, UCR3);

Sorry, here I meant:
imx_uart_writel(sport, ucr3, UCR3);
