Return-Path: <SRS0=mq3J=B4=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A3C433E1
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CADF2080C
	for <linux-serial@archiver.kernel.org>; Tue, 18 Aug 2020 15:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597766120;
	bh=QsAnR15xgsS1haXlCWGGeYsem3J3X5lBZUNurZU99dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EBtZ5Us1ddtvwuPvq5JU6ykd4KI7RFse+DxxPHFGitSsdLebvcLFS/7Rj8lEmIGiU
	 YYg3K/LqYyuQvSAYePHQnd2UYu0PUWfjDHwutlEdx39tROzaJwHGi8M5vnSUsK3cYK
	 5v6NQyZ81xXoOnp8OCXcHp5jHRWCcdQeT3Yt5RCw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHRPzS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 18 Aug 2020 11:55:18 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:38675 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728351AbgHRPw0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 18 Aug 2020 11:52:26 -0400
Received: by mail-il1-f195.google.com with SMTP id 77so18007787ilc.5;
        Tue, 18 Aug 2020 08:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=INrr6/zrEHQooP2zq2cHYbWwtP13T97p5GMii88VP+c=;
        b=Wew8fEmx70eG3fpvTUjI0srDF3AOOWtyUoBp+iEfuO11ejWoM9pLuVepcfZ38pXicU
         84J5jwCgnVPMSfpfvCPHHCL6a2L7uxYHaq+ZzxDBlm4Zv0EqSOItGL4Y+hYs/mVWMMJ7
         ZNfjk5NmKFMSllsywWAwd8YXzPe07B5CwB2MGHNCLvNMzvtvWyCjVloC+Fsb1yoI09c7
         yehbhdRy4UsOgdSJyulY49i10yJF/E6KPNkz5ZeUAayYUlUiP4R179Jx80ANExihVgBb
         VxTLtHiLiyCexjp/nIkS0E0KFvSjNUp48q0Oq9ySZjp7zOeUiKrFb9lh2+R/WXu7FSSP
         GDUQ==
X-Gm-Message-State: AOAM530EMEaY45qiO1NfN/7axKlbjIkrMjTRIMQ9RJjtunLsZ8o8t3bp
        MLG9z89H8PlPuqFEKTml4w==
X-Google-Smtp-Source: ABdhPJx2x6OCoI4sP3a4qc4u+s1xgHoZzcUeF366wUarpkv/L7lbjx0P0ELnzplm23RuPhRA4B4YSA==
X-Received: by 2002:a92:ae06:: with SMTP id s6mr17633149ilh.64.1597765945303;
        Tue, 18 Aug 2020 08:52:25 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id 3sm2647273ily.31.2020.08.18.08.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 08:52:24 -0700 (PDT)
Received: (nullmailer pid 3528032 invoked by uid 1000);
        Tue, 18 Aug 2020 15:52:21 -0000
Date:   Tue, 18 Aug 2020 09:52:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     kernel@pengutronix.de, mturquette@baylibre.com, festevam@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, sboyd@kernel.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com,
        robh+dt@kernel.org, fugang.duan@nxp.com,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        gregkh@linuxfoundation.org, shawnguo@kernel.org
Subject: Re: [PATCH V3 3/5] dt-bindings: serial: Convert i.MX uart to
 json-schema
Message-ID: <20200818155221.GA3527986@bogus>
References: <1597721685-9280-1-git-send-email-Anson.Huang@nxp.com>
 <1597721685-9280-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597721685-9280-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 18 Aug 2020 11:34:43 +0800, Anson Huang wrote:
> Convert the i.MX uart binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> no change.
> ---
>  .../devicetree/bindings/serial/fsl-imx-uart.txt    | 40 ----------
>  .../devicetree/bindings/serial/fsl-imx-uart.yaml   | 92 ++++++++++++++++++++++
>  2 files changed, 92 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl-imx-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-imx-uart.yaml
> 

Applied, thanks!
