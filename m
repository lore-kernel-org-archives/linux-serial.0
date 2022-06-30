Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF82C43334
	for <linux-serial@archiver.kernel.org>; Thu, 30 Jun 2022 21:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236705AbiF3V53 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237370AbiF3V5V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jun 2022 17:57:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8A57200
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 14:57:20 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id k7so261834ils.8
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 14:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uzqzvWO6xI/qzQaupX8bR5RZnWn3d58v4IG2QCKmwHU=;
        b=cp8cJwDcdlIbomiWQnFrZ0zwWFTVLazFVXI9gdwCIChyn9hDeQcQuW3vUFX9EAWT7k
         2TW+xOpgM3F6JLXd8gFEF3LngmCK9kVVELiF/EIxzxrTe+J79hoEpjvda8fH4zpMMADe
         Qvnp9rK6AUyKhgRRM5RG2QgH2ibAgpc3/0lLY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uzqzvWO6xI/qzQaupX8bR5RZnWn3d58v4IG2QCKmwHU=;
        b=dv0jd/5V16ozVi0EwozR5sND8z8KWflDq0E1gR2lEZVsQJ3c1fUnU9vRvq5G7Cr8nK
         TmcTTx5FyeOAhGk/5ZbvT1TgMbCotg/Fhsmr1f29hqfoPAIKZTeS10VjdsVw8MCsnO9D
         Wl2CQORc3giHdhKQOICnim6VahP1hXaEnT1IWl823QUcXezOIVp2Ot+hSdiwiEmABozD
         KgqiLaeMuEglGAyCnJcoFN36bdRwdTUW8xY9L5FAWX673/P6c7Qlb0fMgzykG55BKliW
         NZCNv2KzO1aI+KvCMF6whAm6QqkrHCZAyr/I0JoRBk/RHEZh6n1FOHnH/syWcwZyu2Jf
         rMHA==
X-Gm-Message-State: AJIora/Qp5/P3F/r+0vPhpHIKETayWDrCH1FTp3rT9uxj/iH+MSjv52g
        VNIoVb3wXY1PDUI6RnG0hqCF2r/h3FSjXIHpfkU=
X-Google-Smtp-Source: AGRyM1vh8ZW8pVCfPk1IbGfqllvn+/30t5sIEVlH+sZx34noAKbxrTKTgtMLRAESAuO+joIV43m24A==
X-Received: by 2002:a05:6e02:1201:b0:2d9:2555:15ff with SMTP id a1-20020a056e02120100b002d9255515ffmr6416240ilq.127.1656626239989;
        Thu, 30 Jun 2022 14:57:19 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id w5-20020a92ad05000000b002dae5883ddesm158240ilh.2.2022.06.30.14.57.17
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jun 2022 14:57:18 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id m13so575925ioj.0
        for <linux-serial@vger.kernel.org>; Thu, 30 Jun 2022 14:57:17 -0700 (PDT)
X-Received: by 2002:a6b:b74e:0:b0:675:594e:140d with SMTP id
 h75-20020a6bb74e000000b00675594e140dmr5851331iof.154.1656626237471; Thu, 30
 Jun 2022 14:57:17 -0700 (PDT)
MIME-Version: 1.0
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <Yr26oSKOhIBMaKsS@kroah.com> <BL0PR02MB45646DE7D61E648321E9FBB5FABA9@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB45646DE7D61E648321E9FBB5FABA9@BL0PR02MB4564.namprd02.prod.outlook.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Jun 2022 14:57:03 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UAqNMbsed2QX0iK6hpZzh-k3VJ4PvzXxXSTD-uTtURJA@mail.gmail.com>
Message-ID: <CAD=FV=UAqNMbsed2QX0iK6hpZzh-k3VJ4PvzXxXSTD-uTtURJA@mail.gmail.com>
Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "mka@chromium.org" <mka@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On Thu, Jun 30, 2022 at 10:19 AM Vijaya Krishna Nivarthi (Temp) (QUIC)
<quic_vnivarth@quicinc.com> wrote:
>
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Thursday, June 30, 2022 8:31 PM
> > To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> > Cc: agross@kernel.org; bjorn.andersson@linaro.org;
> > konrad.dybcio@somainline.org; jirislaby@kernel.org; linux-arm-
> > msm@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> > kernel@vger.kernel.org; Mukesh Savaliya (QUIC)
> > <quic_msavaliy@quicinc.com>; dianders@chromium.org;
> > mka@chromium.org; swboyd@chromium.org
> > Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
> > otherwise could return a sub-optimal clock rate.
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary
> > of any links or attachments, and do not enable macros.
> >
> > On Wed, Jun 29, 2022 at 03:30:41PM +0530, Vijaya Krishna Nivarthi wrote:
> > > In the logic around call to clk_round_rate(), for some corner
> > > conditions,
> > > get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> > > exact clock rate was not found lowest clock was being returned.
> > >
> > > Search for suitable clock rate in 2 steps
> > > a) exact match or within 2% tolerance
> > > b) within 5% tolerance
> > > This also takes care of corner conditions.
> > >
> > > Reported-by: kernel test robot <lkp@intel.com>
> >
> > Did the test robot really report the original issue, or just the v2 change?
> >
> > thanks,
> >
> > greg k-h
>
> Test robot raised error for v1 patch and (I think) it got addressed in v2 with call to div_u64.
> V2 doesn't have this error but other warnings which I am addressing along with other feedback.
> Below is the error raised for v1.

I think the adding of the "Reported-by" only really makes sense if the
commit landed and then you fixed the robot-reported bug in a separate
commit. If it reported problems in v1 and you fix them in v2 you
shouldn't add the tag.

-Doug
