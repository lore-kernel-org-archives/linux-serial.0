Return-Path: <SRS0=3mQv=5I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E167C54FD1
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E7442073C
	for <linux-serial@archiver.kernel.org>; Mon, 23 Mar 2020 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584993007;
	bh=DBUGYNMli+b+uV3NamoWPc9K2HPz/ws+6gKUkNUTaS8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rh2RbtEf6KFiNUEV+Otkqxj0RvEnGtaPPLFW0WHHmeKhEEU0Y/bTAlxfOPxLIZ6Ef
	 6vNm0BHP+heDEqnCGHkad6cgfhg0QWQnrWL3TL2+a2LpG9P1f7LI+qlImA52M3DDGx
	 rLV8p6mery9Mrym+9SufYMBCtlg4ZoFLJhpvvhzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgCWTuE (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:50:04 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:35541 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCWTuE (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Mar 2020 15:50:04 -0400
Received: by mail-il1-f194.google.com with SMTP id 7so1128350ill.2;
        Mon, 23 Mar 2020 12:50:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=OjC6r2usuImBDLu/35CLd+c7UkFmIFG+06FkAS9qKVg=;
        b=Zolz3XoqNSScFkogN6i1/SNo1bDXQUnOU67VOoSZpj1teQcbeKyrMVneeHOiEBOApH
         0MqPucuWEpw1ncRJjqyAE3WGFtLI2n/pGkuzSzLV9X/TJ8+aXI90UPSwWmf9uBxk6x6F
         ddJmNbJ4AXwvT8OuKpmboVrsKa45qKEmZTSXYhvULrRnCNXGMnG9eBpvSjDO+ZDu1dWZ
         /xMz2Xf7VX1SuwRAouBGf+xrplcJYPL8aC1fb6Nwa0+GQlVTKwiSBta+H1drfV9cqh/7
         DmT9HeW9DUTLkBsS/lquf0hsoK9Lt46QPzzX+7TBs8qLHCZhk5XLe+KzK7jhYwxj1NUc
         4qSg==
X-Gm-Message-State: ANhLgQ1NPxw+DrpjMI/bylzPYg7KrA5BQbK+PFQsCg/8G9vd4nAU4cC0
        JWvv12CHP6/as9u1IQOk4Q==
X-Google-Smtp-Source: ADFU+vu/MHCQinxeMPLh3FyJXqUbP8NrFB6mE2fqpJvLKhVTVJRcYgL95OftLKo2ne7u4RCE9iSYrw==
X-Received: by 2002:a92:7b10:: with SMTP id w16mr22320500ilc.93.1584993003863;
        Mon, 23 Mar 2020 12:50:03 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id v24sm1199217iob.0.2020.03.23.12.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:50:03 -0700 (PDT)
Received: (nullmailer pid 29486 invoked by uid 1000);
        Mon, 23 Mar 2020 19:50:02 -0000
Date:   Mon, 23 Mar 2020 13:50:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Wells Lu =?utf-8?B?5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Dvorkin Dmitry <dvorkin@tibbo.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [RFC 05/11] dt-bindings: serial: Add Sunplus SP7021 UART
Message-ID: <20200323195002.GA27190@bogus>
References: <20200308163230.4002-1-afaerber@suse.de>
 <20200308163230.4002-6-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200308163230.4002-6-afaerber@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Mar 08, 2020 at 05:32:23PM +0100, Andreas Färber wrote:
> The Sunplus Plus1 (aka Pentagram) SP7021 SoC has five UARTs.
> 
> Cc: Wells Lu 呂芳騰 <wells.lu@sunplus.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>
> ---
>  .../bindings/serial/sunplus,pentagram-uart.yaml    | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
> 
> diff --git a/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml b/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
> new file mode 100644
> index 000000000000..9d1641232a4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/serial/sunplus,pentagram-uart.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/serial/sunplus,pentagram-uart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus Pentagram SoC UART Serial Interface
> +
> +maintainers:
> +  - Andreas Färber <afaerber@suse.de>
> +

Soon this will need to reference serial.yaml which is getting added to 
5.7.

> +properties:
> +  compatible:
> +    const: sunplus,sp7021-uart
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +...
> -- 
> 2.16.4
> 
