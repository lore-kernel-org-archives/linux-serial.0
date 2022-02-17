Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9ECC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 17 Feb 2022 16:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbiBQQWi (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 17 Feb 2022 11:22:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242680AbiBQQWh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 Feb 2022 11:22:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3358E162032
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 08:22:19 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id i6so89043pfc.9
        for <linux-serial@vger.kernel.org>; Thu, 17 Feb 2022 08:22:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7xlrl9elM1qetAzeAOSNskPv8W23aPLNt6zInyIdm50=;
        b=w7SMc3R1fI7qa+IHIfDsUjvRQbsv+GH4vWzV2Vr4aGDmOnjNv9NgNYe08/K1XqfKU+
         PYRBRrU+jlnvrb7aZ627g7Z3Js5twNC3pq8YzjfYIIHcMDnOVqGHdU0JneUkdTr30TFf
         IsasmebdnajMuWl94HTPWYxb9eaMG+Zyo6E0eWsLWl2WXCChdNZRlkD19i760V6jW7Qp
         3JNT0lioiOMoq2EDBPs9JDvC7iOtGx4P+4rATFOOPigmwu+9nUUW8ZvA1zqXnoTPoE5x
         9ipfirZLG0/SEZQMR/40uY0tPJDm+ggCI3Ik6E/ablZZnf7/hm6A7XbvNt+Groh1IeVT
         rInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7xlrl9elM1qetAzeAOSNskPv8W23aPLNt6zInyIdm50=;
        b=D13bmkLeVU5Erds1llNsxZNeaeVRu92NScSs2KH4rkJAvQ0b/87kaIEf5fd8f4y8xT
         6B+1fkO3QpKJgqwsy2GFGwidbNOqx8NG5Cv2ufiszDkdSJx/F4MnBX6pqpvm16prRjU7
         mukDNkcgyaOhCm/lWslY7xnRdYFrGzV4aKmKpDkl2IVbx1fekXfAC7zHoMWY0XlxHFvU
         8bRlpjRJOP/PzPb8SEc8X2/mVHnvk+sttj5mJo/APFDuKKGtGve8KsVMAkZ69pLRVbq7
         VApu8Z7/uNoguSHEs0W57yny8ze8j6xKpXb8T0DA7WtRW+pWk2QdVbl6BuzGPCQXzhG9
         51/Q==
X-Gm-Message-State: AOAM532NYbMpFOOTDYEMBT77/INHwV6lfklqVyHgJLQF5JwdRt5gCATS
        R5AkY1EL/hSDv+KkGHtFgjfRgz7iI6l9aQiwD1eTWKe0xHE=
X-Google-Smtp-Source: ABdhPJxi+glvreoGdGLbL3g+lsngHfQbV9GM+RnOiWmV7ag0TFGlFKkV8e6uuuKFvlBxOX5gnVs45jIEADyWK/l8M/s=
X-Received: by 2002:a63:83c8:0:b0:36c:9413:8969 with SMTP id
 h191-20020a6383c8000000b0036c94138969mr3018371pge.115.1645114938453; Thu, 17
 Feb 2022 08:22:18 -0800 (PST)
MIME-Version: 1.0
References: <20220214213020.685-1-tharvey@gateworks.com> <9d5cff18-5493-f6dd-4bd6-9bafa2a503a7@camlingroup.com>
 <CAJ+vNU0sWGsQa=YwLE9Ng34-DhJF=YR3oTV+q--KcgTMCjBa2w@mail.gmail.com> <378824ab-3cc9-dcf5-b9ea-5e49b57792a6@camlingroup.com>
In-Reply-To: <378824ab-3cc9-dcf5-b9ea-5e49b57792a6@camlingroup.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Thu, 17 Feb 2022 08:22:07 -0800
Message-ID: <CAJ+vNU2JbRm2SPQTPC7J-E0PGc0tuzd-9-=MFsRSWKEu8ti9aA@mail.gmail.com>
Subject: Re: [PATCH] serial: imx: leave IRTS disabled if using modem-control CTS
To:     =?UTF-8?Q?Tomasz_Mo=C5=84?= <tomasz.mon@camlingroup.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Feb 15, 2022 at 9:45 PM Tomasz Mo=C5=84 <tomasz.mon@camlingroup.com=
> wrote:
>
> On 15.02.2022 18:26, Tim Harvey wrote:
> > On Mon, Feb 14, 2022 at 10:03 PM Tomasz Mo=C5=84 <tomasz.mon@camlingrou=
p.com> wrote:
> >> This hardware flow control sounds quite limited. Once CTS becomes
> >> inactive, the transmitter will still output all characters from TxFIFO=
.
> >> Transmitting whole TxFIFO already sounds quite bad, but that's the bes=
t
> >> case scenario where gpio interrupt is handled right away without any
> >> delay (so more than TxFIFO characters can actually be transmitted).
> >>
> >> Does the internal RTS default to inactive when it's not pinmuxed to th=
e
> >> actual pin? If so, then controlling UCR2_IRTS based on CTS gpio could
> >> halt the transmission when the TxFIFO is not empty.
> >>> I agree that the increased latency makes using a GPIO for CTS
> > (software controlled) not as good as one pinmuxed into the UART block
> > directly (hardware controlled) but without this patch GPIO for CTS
> > does not work at all because the internal RTS defaults to inactive
> > when its not pinmuxed. For many applications the latency is not an
> > issue.
>
> I think I didn't write the message clear enough. I agree, that the GPIO
> handling time is something the user has to accept. Usually this part
> alone is not that bad though, as many receivers are capable of receiving
> more than one character after deasserting their RTS output (transmitter
> CTS input).
>
> The general expectation is that the transmitter will output maximum one
> more character *after* CTS GPIO change is handled by software. This is
> not the case with current version of the patch.
>
> With current version of the patch, after CTS GPIO handler finishes, the
> UART will continue to transmit up to 32 characters if not using DMA.
> When DMA is active it is much worse, as it will keep transmitting all
> data already submitted to dmaengine.
>
> As the internal RTS defaults to inactive when its not pinmuxed, the
> software is able to freeze the TxFIFO (and thus DMA if enabled). To
> freeze TxFIFO when using CTS GPIO, the software has to clear IRTS bit in
> UCR2 register. Setting IRTS will thaw the TxFIFO.
>

Tomasz,

Ok - I understand what you are saying. Yes, I should be able to use
IRTS to freeze/thaw the transmitter based on it being inactive when
not pinmuxed. I will work on a v2.

Thanks for the explanation!

Best Regards,

Tim
