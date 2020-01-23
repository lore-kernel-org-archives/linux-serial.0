Return-Path: <SRS0=uJPQ=3M=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F47C2D0DB
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F4020704
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jan 2020 14:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579790613;
	bh=JcgtoUqsESmD3A/2bsSCDPMCrO/wp97Z1NQPgshb+po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LSIdC/yYqw/s/JCh0EmWnZanMy3up12/2oEjjSAO/2sQMexct5YuAb0sw+/By5vEo
	 Z0KTXee43W0pdUejXv19LHwuY+iMHHMwnbGwszP2AJJ5rM/V6hY9FI9nmhEABeIXUN
	 JSCJ0x9vxjMlmKOk4Znri0uKoesPWYtFjSoYlus4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgAWOn2 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jan 2020 09:43:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42844 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgAWOn2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jan 2020 09:43:28 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so3072570oin.9;
        Thu, 23 Jan 2020 06:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7SayZJgIXHjCdU3TAFI8Ocs5cvmGh8wgxSjfDXiqUmU=;
        b=cxSDvpbUKLOtBOI3fGsin6p2Q1mBdA9arjtDLfwIuwW3GiBSM+SDY4OwZvljpg5H8n
         QuuKr24wIPsoqYa0t5sX+gVoonfx0slv1/6bWbbu2ktRh+BznRTyx6PLan0BaTReLvS8
         +pjgOgzHaflBREHkRQKtI2FP70hF18tj2esYrIRam9KNyU5DOlXqZTxJy10pXSqhYTlo
         g05JsHpg7srKGRoQua+mhC8VcuagSmXtBJUPcDFltTwKIQfSKZ5QD8U/nx2A7XOXxLJp
         dUPgiHaRWNf1Z7B7dCeV0pG5/QV44Fsm+KNHZzKNJZ9d9iWLevSHS51Lh1n0tUsSeWIs
         Of9w==
X-Gm-Message-State: APjAAAWF44DtPLu43ev6DdfGEQfoUzFIi/fodDW0cZFdOvyEpDqh6Go9
        Th7EWnqonW48lLVmvEJKLw==
X-Google-Smtp-Source: APXvYqzGbdY9oCHH7SiwtERsp5ylmchXaof2S8Eo3kpOm01m82P1WOVc0ecY+Jf3C0L3OyPvAH5Kzg==
X-Received: by 2002:aca:1c1a:: with SMTP id c26mr10845348oic.75.1579790607604;
        Thu, 23 Jan 2020 06:43:27 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id s6sm849207otd.72.2020.01.23.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 06:43:26 -0800 (PST)
Received: (nullmailer pid 12444 invoked by uid 1000);
        Thu, 23 Jan 2020 14:43:26 -0000
Date:   Thu, 23 Jan 2020 08:43:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        mark.rutland@arm.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, fabrice.gasnier@st.com,
        erwan.leray@st.com, Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: serial: Convert STM32 UART to
 json-schema
Message-ID: <20200123144326.GA12392@bogus>
References: <20200122095558.22553-1-benjamin.gaignard@st.com>
 <20200122095558.22553-3-benjamin.gaignard@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122095558.22553-3-benjamin.gaignard@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 22 Jan 2020 10:55:58 +0100, Benjamin Gaignard wrote:
> Convert STM32 UART bindings to json-schema.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  .../devicetree/bindings/serial/st,stm32-uart.yaml  | 80 ++++++++++++++++++++++
>  .../devicetree/bindings/serial/st,stm32-usart.txt  | 57 ---------------
>  2 files changed, 80 insertions(+), 57 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/serial/st,stm32-uart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> 

Applied, thanks.

Rob
