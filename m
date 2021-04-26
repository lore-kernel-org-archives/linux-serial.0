Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86A4C433B4
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 691E661027
	for <linux-serial@archiver.kernel.org>; Mon, 26 Apr 2021 11:57:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbhDZL6e (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Apr 2021 07:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhDZL6e (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Apr 2021 07:58:34 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5026AC061574;
        Mon, 26 Apr 2021 04:57:51 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z13so6848571lft.1;
        Mon, 26 Apr 2021 04:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YBKtnrfj870BpoCUOQjiddIh7BY+km8BeX1vkFj0/xI=;
        b=cJ9ZWmarhUhMg1ePPcEAr0KgjhmQctpIGQQm4MOJfCv2ab64ezHhOFOFviKOZi3T8c
         eufBi1WOYutCMn+pTxJiwg/oxyZR8yzbbq9WkYnmSwVCCw4q5JMVhUQTOCUiHqnNOX+Y
         K5t/FXd7UkjnhYeTs6CCPN8bTjRltQnn8ffNW9pKF/Zlj3GkpeczbsVMzN7zstgojKF5
         HjfHa7qf7t7VPGiSpFWCBi5mzao5Jmh7engnEOS5/zZtzPPEcqy5G6tBkSg5aRA7Surx
         t7a2EQMPcq9Nu6ifZtSewfzT+3wCFwgrbalOyicfSCZ2UkqSzbDc5J2W+NjnDC/mTyMJ
         k6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YBKtnrfj870BpoCUOQjiddIh7BY+km8BeX1vkFj0/xI=;
        b=HKmxslB/PmAE9GXARQ4vq/4nDHGSQBlSRp+5LFHLXDEpCznr21y0yuDiHKJOdIkxcD
         eQvhzh5OtYD6TXZuU2xSMI+81X1LqjXchwAc7CxgSEYWRCoiU/lD/rU0NBbs/cm1TcUY
         +A0t2F08mdNlWekGKu1gAOvraoz0GE9YOUDtKMMbp+zetDo7LWMqxkwBFUEv/iuHUBf1
         kt3eOIs2u90r4tFg7zzG5rMsJ5O12cK/92egBw0bOvUxTMfPtwItyI9JVzjsL9IAOMl9
         lBRQuz37yr8tBiaS+XYfsAlN5h8aMHk5zLiNWAUXtC143NotyiJkWi+yMl2YAi0BaqNU
         i4Jw==
X-Gm-Message-State: AOAM5309pyCQm9KMVCJEj+fo84ATRcGqdLBcLCtU8auYRKwhyvNlJzbR
        v/2yIH70qVhXs1iBS2h1Mz9ovopNAZIROWF78XKGNivOQCw=
X-Google-Smtp-Source: ABdhPJxYyCjyQ3QznO2LDzV1L7kVJnkLq69SknOB4w8dEIbkxurpH7brtrtdohewRvCPbZohZzbGTHvrEUDGqamIHYs=
X-Received: by 2002:a19:50d:: with SMTP id 13mr12270824lff.443.1619438269845;
 Mon, 26 Apr 2021 04:57:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210426074935.11131-1-sherry.sun@nxp.com> <20210426074935.11131-3-sherry.sun@nxp.com>
 <YIZ1NvISshNHtX/Z@kroah.com> <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB4947DAD4EAA84FEAA5A2B28A92429@AM0PR04MB4947.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 26 Apr 2021 08:57:38 -0300
Message-ID: <CAOMZO5Bmv2CVZeJbwLhZcH7pb7Tb9FhCrPSjhkbaJO8vYtRHLw@mail.gmail.com>
Subject: Re: [PATCH 2/2] tty: serial: fsl_lpuart: fix the potential bug of
 dereference null return value
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Sherry,

On Mon, Apr 26, 2021 at 8:39 AM Sherry Sun <sherry.sun@nxp.com> wrote:

> > > +   if (!sdata)
> > > +           return -ENODEV;
> >
> > How can sdata be NULL?
>
> Is it possible that a case forgot to set sdata? Then the value will be NULL, such as { .compatible = "fsl,imx8qxp-lpuart",  }.
> So I added the patch to avoid the kernel crash when run to sdata->reg_off directly. But I am not sure does it make sense.

sdata comes directly from of_device_get_match_data().

This driver only runs on DT platforms and the only way of being probed
is when a compatible string matches, so it is not possible that sdata
can be NULL.
