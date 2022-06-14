Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E64C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 14 Jun 2022 12:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiFNMVY (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 14 Jun 2022 08:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiFNMVY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 14 Jun 2022 08:21:24 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF72442EE2;
        Tue, 14 Jun 2022 05:21:23 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h5so11094700wrb.0;
        Tue, 14 Jun 2022 05:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyzNzaJXP91l5FIyZDK4PPDuE0Ei4eLyZwjrp3SBn90=;
        b=n+PhOQb9QpANLPQynTA6HfmtZ390POiHnkSYtPee5PfkFYuNnJYz+kYB4lpva+2Zca
         41jHCZ7diMJjKAPF38BpaJqUx8q+xhwY99uggRE/OAjUHhZYcluxK9I907Nq/0XHegvu
         FTjO+6vE4aB7iUPuDAAiXxt83LsYzcDUCTdWHeaXYBh31hdPJtc23WOxJAOlAdC7KyFz
         WQzG2h/5+kCwm/L2FIxY0NbLZQc0Sh7fr94v96kjI/AsSrTpQq8VBDfH6qJdeGQo2Geq
         N7Im13I87a4+sa/hBJ/Wt0uaSwVdLouvurfNiqZLXdjH6dTaRo9F/g7zNReDZQNX7CxP
         Kl5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyzNzaJXP91l5FIyZDK4PPDuE0Ei4eLyZwjrp3SBn90=;
        b=td5gPdqp27LeXiurszKlLRryxAIE0X3TQRixnbzf46Ey4XIDyRmVJherFyMSihkcLC
         yKm+s4CF2S43IYoozq/+pEY15GYIXO1YQNyieFeNwTWnerHshM5l8zc9puOgKufVFuHC
         +OfJS7h4uaheH9R79pLZxKgysYYJqtbKMukO63EMyWRuatEaOcNugMRVXKzDHa0Wip/N
         39ErXNKXkDufQYDCIxgT5bAg3JLpsqo71TSUSXF0siz5T+2ehH7Hzh6aHnZ8r9CdiRlS
         L/kGlR/sKebc6S6hLEXgkCbSGMrCvJOoLsnFSZ+VlKuGjnT2OFPNgSAAI49DnHE5po9B
         T0WQ==
X-Gm-Message-State: AJIora/mwLSSaHGioxB8Y0e7hU3Pvfaqgo9tXc2mZbSeeoTJ2P4qof9u
        B41U4RH0vTDdcOr2OtMnnd/PdFSBk5OBkc6f7021JWV8ssE=
X-Google-Smtp-Source: AGRyM1uatepoZ71SN30wRVMaE20HdgRu9qjgCggfiz/JwP1rRsEawuOSVzmgQzSz5M2S3mMACWKBYmIupLNWDQp/ql8=
X-Received: by 2002:adf:fb82:0:b0:219:af0c:489a with SMTP id
 a2-20020adffb82000000b00219af0c489amr4598120wrr.212.1655209282368; Tue, 14
 Jun 2022 05:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org> <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
 <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
 <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
In-Reply-To: <CAL_JsqLV3De0O2WDq=w_CQbvAiJVvQ-=V9XuC1tJyZNLyneDZw@mail.gmail.com>
From:   Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
Date:   Tue, 14 Jun 2022 17:51:11 +0530
Message-ID: <CAKfKVtGrdh-iQP7YKUBe37HVeZcU-UV3A3BHKjcnggBFR94eNA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
To:     Rob Herring <robh@kernel.org>
Cc:     Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Srinivas Goud <sgoud@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

> >
 <snip>

>
> No, I don't know what the differences are in your h/w. You have ID
> registers, but changed the IP and didn't change the ID registers? How
> has the IP changed?
>

The IP is not changed and the ID registers are not updated.
The limitation is coming from the AXI  port that the IP is connected to.
The axi port is allowing only the 32 bit access.
The same information will be updated in the Versal TRM.




> Rob
