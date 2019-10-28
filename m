Return-Path: <SRS0=1MuI=YV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D05CA9EC0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6161D208C0
	for <linux-serial@archiver.kernel.org>; Mon, 28 Oct 2019 11:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4ki89K3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfJ1LLf (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 28 Oct 2019 07:11:35 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36050 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfJ1LLe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 28 Oct 2019 07:11:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id w18so9429100wrt.3
        for <linux-serial@vger.kernel.org>; Mon, 28 Oct 2019 04:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4w2tPwBsH2mwuAIAbeDYVpOgt866Ft8uIGr8J9UoV4Y=;
        b=R4ki89K3RZzV4Fv5ljxVpbtFdeGjAsl7K0ZA/L8WPSsanYJETQ80SupEnjQv3MnMIz
         5r3Mk4Ljo0EEW9v77mvl21EUpLPcB5MFrjusLgPa3TvsyB5oXx87tNU+MtKHNpNKnja1
         qNQzP5yuE4yTCdp3WOYacdYFvdIfJZZTNDQYKmj4vDJfO1SOpxtCx45AK85RgPpg8bxw
         4rxePbexQQYqHR83vtcRwUTkkAaddsAXS2JBP+OrgWdiX7eHCd1OuYCkKUsUchBqG2bz
         KaMWdYpmmnt4JJA/acOIIh2Cq+gZZ6NRnm2rlui1TjBxBawAScAB+yN060j4vPwqTRiz
         ml7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4w2tPwBsH2mwuAIAbeDYVpOgt866Ft8uIGr8J9UoV4Y=;
        b=lItuOMwL1jlQbhCU2gXd9z1LVuT+8AQkqYVifJpDi3KtPy1+CQm3SQPZFyBiZnYwTn
         XsHsAG7xozCG/E7jxJQ/TZn2q1E9ZjKx9ee2KfqxYZptphlfoqUN/hlFPbaVYcJJobuS
         5xq+EvJkvYlIXMnsX6cmw9T00vmfWa5rfGLKZWBfZYPHtYhEthejZmUMYpXLyoiJaxQW
         Jikk+i/NQXSnwGmfTb9xVRRl0I3LWkP47LZgtgzDF2OBoyHbkbIJ+5lxDI4LU2o5azer
         OJytExxU0Mv2jfqP0HeOAPAdgxbQHGhUUXbRLtit8mhJg47nRWQ9xE4xxOMFPX+CSDQT
         zvuw==
X-Gm-Message-State: APjAAAWKOjr27byXRHCD8aBvf5horOFcL/cMUu4mrGa6+nlY9VEk38mX
        GjvHMjqht3fXPW5vWEdlK05Kq4o9Fy2dGw2xrcU=
X-Google-Smtp-Source: APXvYqxnwRwYjN1FVJK/3db5EeHrJ8SN1y9sYtmv18POb49LyTlhw8SLu4hlzBhZrhe3An+jNGFoM6O9MEqsFj+Ya9k=
X-Received: by 2002:adf:ecc7:: with SMTP id s7mr14384999wro.305.1572261091467;
 Mon, 28 Oct 2019 04:11:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAEXMXLRBpQcSq3SrvL4LkG8_7S0CWJFGqRCnjywjbUEPZg9XxQ@mail.gmail.com>
 <CAEXMXLSty8v1K_yaxoAnoMEny=XYn2ngUdCPi_0uTqy5NTViAQ@mail.gmail.com>
 <CAGm1_ksE038XOzqXHw6iSAxq8mCegM8Ej8cdPvP5Tu_EBouSLQ@mail.gmail.com>
 <CAEXMXLSCW33wCho-7damt-aem0Z76xypr-AHY0zmR5T8PwLS7A@mail.gmail.com>
 <CAEXMXLSkNXPYQtzLtnxTzeVAL5MvafsG1yUZHjn8Stg-UZyT=g@mail.gmail.com>
 <CAGm1_ksD6UDdW-3B4KkkoP1QYhp307YMyzf-GPx1Vu1oCFka+A@mail.gmail.com> <CAGm1_ksb7tG3xux1yery5qya7UAGYyMBz0xbVgG6pKxaR2Nf3A@mail.gmail.com>
In-Reply-To: <CAGm1_ksb7tG3xux1yery5qya7UAGYyMBz0xbVgG6pKxaR2Nf3A@mail.gmail.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Mon, 28 Oct 2019 12:11:19 +0100
Message-ID: <CAEXMXLTJbTRfiASo6Dk=0Lp1iBc4Svv4dw1L+FNi3itoo9e+eQ@mail.gmail.com>
Subject: Re: Regression since 4a96895f74c9633b51427fd080ab70fa62b65bc4
To:     Yegor Yefremov <yegorslists@googlemail.com>
Cc:     linux-serial@vger.kernel.org, Stefan Roese <sr@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Giulio Benetti <giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Oct 28, 2019 at 12:09 PM Yegor Yefremov
<yegorslists@googlemail.com> wrote:
> could you already try at least 5.4-rc4 and test whether the hardware
> flow control is fixed for am335x and your application?

I did test last week. 5.4-rc4 is working fine for me.

Thanks,
Nuno
