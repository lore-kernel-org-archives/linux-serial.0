Return-Path: <SRS0=m7Km=3K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99FAC2D0CE
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 22:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EE2924655
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jan 2020 22:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579645345;
	bh=d97/IBZtg9IT3MppVd9usNpNw3epuKqXkUTb86TDSD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=F5Ug74ImVv3f2JolbCuTlx08Lue2hw+B1J39Ru7dSPzVv8JzEXICQFaWzvsnqU2rg
	 /y5fli1bzs/7fc78rjL3MvX3NZkyK4GkoiSIr4VdUIMsPKAZAO5SNNvkyKFgGq24w5
	 zbsna2KyZrrNNvgsUM+8MFQzl3odRYmbeHymxbPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbgAUWWV (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:22:21 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34747 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbgAUWWV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jan 2020 17:22:21 -0500
Received: by mail-oi1-f195.google.com with SMTP id l136so4229441oig.1;
        Tue, 21 Jan 2020 14:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qQ3ESJiwe24A1xRRFdOQ68BgNu0jHa+2w0EJEUQi0CQ=;
        b=eEpHeoG0e8ktLhNa1jtFubcJGrUpTDQDhtJZLV26rOaTa0kEEjuigzqAgHhO0AS4RP
         Ai9AhDYgaeyeljOfRD3QXXOVYvgRpRNiitPYF0Lml1avoxJvz2aEYutnbG9rsXid37Uq
         nRMEXTUhDdjHAcG3dhE9DRYxj8cUo2r0TjH+lM3SWkaadPfTkRlciHV+fxROhshFHQrW
         HBKT7z87ALcqghsbRJPRO9awsbA4fIwCu6nnRSuy+H+kyO1+xmdB4E3gbQjmzzMME9Ik
         sikglUHgT9Bhm69TPL/3pVfnHnPKxI2ynPm2IH5uZRGbxEtboayieJ9jjIuZe6lCEyDF
         y9Hg==
X-Gm-Message-State: APjAAAVC0KLq8ZyEgM37WGvVVfawf0Wy92df9t7uXbsrRcccYM1f/Xtr
        dTE/hU7bwI/MeELYZBDpJg==
X-Google-Smtp-Source: APXvYqxtTBp1m0NoVYXgYISnqaA0oCc25esO/7iHUU9wqcKpSAWyGjQXwz90q4B5a30iOmY5CpuOCw==
X-Received: by 2002:a05:6808:1c6:: with SMTP id x6mr4687242oic.49.1579645340281;
        Tue, 21 Jan 2020 14:22:20 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m185sm12426354oia.26.2020.01.21.14.22.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 14:22:19 -0800 (PST)
Received: (nullmailer pid 11864 invoked by uid 1000);
        Tue, 21 Jan 2020 22:22:18 -0000
Date:   Tue, 21 Jan 2020 16:22:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, mark.rutland@arm.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        erwan.leray@st.com
Subject: Re: [PATCH 2/2] dt-bindings: serial: Convert STM32 UART to
 json-schema
Message-ID: <20200121222218.GA9196@bogus>
References: <20200114123329.3792-1-benjamin.gaignard@st.com>
 <20200114123329.3792-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114123329.3792-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 14, 2020 at 01:33:29PM +0100, Benjamin Gaignard wrote:
> Convert STM32 UART bindings to json-schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 80 ++++++++++++++++++++++
>  .../devicetree/bindings/serial/st,stm32-usart.txt  | 57 ---------------
>  2 files changed, 80 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt

Looks fine. Will pick up when you respin patch 1.

Rob
