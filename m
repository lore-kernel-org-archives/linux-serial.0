Return-Path: <SRS0=jM0J=7V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A50C433DF
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FCED206A4
	for <linux-serial@archiver.kernel.org>; Mon,  8 Jun 2020 15:51:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vP7pw5kt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730336AbgFHPvg (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 8 Jun 2020 11:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730326AbgFHPvg (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 8 Jun 2020 11:51:36 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E6E5C08C5C2;
        Mon,  8 Jun 2020 08:51:35 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z9so21094472ljh.13;
        Mon, 08 Jun 2020 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=11CKmyRNW5Oq497UrHzsLRutqSfI3PndTJkmpjfHIrk=;
        b=vP7pw5ktVHCRc/yUU4LgDQt32+2h4R5mXztJMsQGrJWsUBNj9eUc4g6LxZ/DUTOTqF
         iZ0a9QBF7/GqdYeTsRLND953RGfDC2HNTlzTrZEm394eEqodV9qH137e6cYkyindV2H9
         PX+MuTC0iMY/+nE9rsoy6yYA00J0Qkfh3aJo7sg3/soQMxOYSQUr4VNc+8hZrRy/SfLV
         x8ZxKZ0JRxFafOSMcbCtJg+NZ2uIAwSkKTm37oj27kYoSsc8b16nkwS3PyI4md6HS65Q
         Tfi2oDA9ibnq+fYH2zYAHRNuoYmR7SgdioQEq2tUWpCL4iX/5B0AHR3mPSbFvPQxOXKN
         3MVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=11CKmyRNW5Oq497UrHzsLRutqSfI3PndTJkmpjfHIrk=;
        b=CYi2C3j2S8Sct4zBCkmjh8+mzr4uziEEdqOZD8ZQ6eEc/x/VCME2PbwrSC9f/tqIQ4
         KFUazgCpVskbQBL6tKPqU/U8hFPPBGbCw4hhdsIWUVuK+5b+k28na9oLT6hY66Ki0Qfu
         swMT/sfk/3mDQy28rjxTq1PIaLY0IujJIJptvABau55jssKI4rVVdi/E5f/wWJbgqK/K
         8YYb3fUyk0sg47BlS3KQF9X/AEQrtJ//PTDrShndDtXlxA7pY5wpUDBE6LBZCwUC1Oxv
         urqU4ZaAPd+dLnH3eyzjqBDYFGga5/npJ0feIyUy33rexr3pUFOQgumq1ojWgnX0AN83
         ZWhA==
X-Gm-Message-State: AOAM5319jwU2CyIOat7BAccg5892meLN2n7uGUiPpfrx0cSTvBRLNPKF
        03dg8TnPhSa7DfcRjzk/D6MEjOq3TV6wn/O0ZQkiSUpR0n0=
X-Google-Smtp-Source: ABdhPJzZett5LjDcKZXE+Kl7sTdWmXeTjGjx4y9ppn3HQnIvQIcVdMQKhr31bqQPF8p07FiaERsjdSCpI3pRjwhGESo=
X-Received: by 2002:a2e:9e87:: with SMTP id f7mr8139499ljk.44.1591631493481;
 Mon, 08 Jun 2020 08:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200608151012.7296-1-frieder.schrempf@kontron.de>
In-Reply-To: <20200608151012.7296-1-frieder.schrempf@kontron.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 8 Jun 2020 12:51:20 -0300
Message-ID: <CAOMZO5BHF6ftHVgzKQ29o_G7Y+O6nrbDH1+J5+BYaONz==WebQ@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: Fix handling of TC irq in combination with DMA
To:     Schrempf Frieder <frieder.schrempf@kontron.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jun 8, 2020 at 12:12 PM Schrempf Frieder
<frieder.schrempf@kontron.de> wrote:

>         if (port->rs485.flags & SER_RS485_ENABLED) {
>                 temp = readl(port->membase + UCR2);
> +

This looks like an unrelated change.
