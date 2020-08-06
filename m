Return-Path: <SRS0=RtBO=BQ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 299E1C433E1
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACED206B5
	for <linux-serial@archiver.kernel.org>; Thu,  6 Aug 2020 17:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596734802;
	bh=IpyzccZXD84HyOjPRB4hn5BMWrTd+yAJGDzT+33yIz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R7WO9tkkQP75ZpCyc281Qi2oOdDAjw+GcJW9vMcmpsxm8kCIeZffCtfrsNIOBJh6d
	 h8eVGBzBcWjvj632sR6RVAny4qXjso2nnt3BB/S0GAcNdy+0RhEkoaaru+p3PMPX/n
	 nkkIX5IlFYDFOL3XcJP9RzWCAYpnpdl/du1Jr7A0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgHFR0F (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:26:05 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:46178 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgHFRCD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:03 -0400
Received: by mail-il1-f194.google.com with SMTP id c6so5935116ilo.13;
        Thu, 06 Aug 2020 10:02:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4a+UH2c0ravXsXQYiIiU2PDrCAbSISRiJ7nu8uzSR8k=;
        b=doauD29SYFYkF9x+c3jO2UjCMUlaICRp/oouYVKaPh+q19dbCjvxdeGLU04JMRUahV
         Fc580rgI1RKdFryyT1UJjcEuVa+nfa2tcaKCGAVYRCaTzuDT+4B4Hqget+0858QftfE2
         G+Vy0a6eIIrxp4COtbr87KvTZ7ScrG0rMHy2pvWjCpok1UbCElsEn8cW/Mj9XMrW9Swf
         xXiRwJPyU5dMN8CfmF6rbQwMNg2uOWGMFTp7GiPAfQk7JlDTw4dIT/pRqtVrB3cZIbZE
         G40YJvxZmzp1c6juuwMSmn8PsC04Rk3e5m/S6MpQrFbKyaNVZOtrR+ElZiqmePH+qCvQ
         hTMg==
X-Gm-Message-State: AOAM532lFn9QL21xxfWmse8KOzpjEj8yvIjKrk09m8wOfOieY0OZQP2S
        KWPV59w+3eBbe5o9/AM7QGK13SY=
X-Google-Smtp-Source: ABdhPJzRteBDaWzy4duYfRNpOT2CWnniOjFmm0VIz9MvqlHlamjAWGnsZtm0dzKTfwRZ3h3p7UE8Sg==
X-Received: by 2002:a92:4f:: with SMTP id 76mr10864122ila.291.1596722950017;
        Thu, 06 Aug 2020 07:09:10 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id q200sm3812334iod.5.2020.08.06.07.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 07:09:09 -0700 (PDT)
Received: (nullmailer pid 771383 invoked by uid 1000);
        Thu, 06 Aug 2020 14:09:06 -0000
Date:   Thu, 6 Aug 2020 08:09:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     galak@codeaurora.org, festevam@gmail.com,
        linux-serial@vger.kernel.org, s.hauer@pengutronix.de,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Linux-imx@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        gregkh@linuxfoundation.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: serial: Convert MXS auart to json-schema
Message-ID: <20200806140906.GA770620@bogus>
References: <1596603259-5367-1-git-send-email-Anson.Huang@nxp.com>
 <1596603259-5367-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596603259-5367-2-git-send-email-Anson.Huang@nxp.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 05 Aug 2020 12:54:18 +0800, Anson Huang wrote:
> Convert the MXS auart binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/serial/fsl-mxs-auart.txt   | 53 ------------
>  .../devicetree/bindings/serial/fsl-mxs-auart.yaml  | 93 ++++++++++++++++++++++
>  2 files changed, 93 insertions(+), 53 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/fsl-mxs-auart.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml: serial@8006a000: clocks: [[4294967295, 45]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml: serial@8006a000: compatible: Additional items are not allowed ('fsl,imx23-auart' was unexpected)
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml: serial@8006a000: compatible: ['fsl,imx28-auart', 'fsl,imx23-auart'] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml: serial@8006a000: 'dmas' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx28-clock.example.dt.yaml: serial@8006a000: 'dma-names' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml: serial@8006c000: clocks: [[4294967295, 32]] is too short
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml: serial@8006c000: 'dmas' is a required property
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/imx23-clock.example.dt.yaml: serial@8006c000: 'dma-names' is a required property


See https://patchwork.ozlabs.org/patch/1341077

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

