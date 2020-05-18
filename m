Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85F2C433E2
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 907A2207D3
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589826591;
	bh=BsDr7nxkF4zF7gMBv5mX7My/9Qowd6V2zS7U7dRAsHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ye7prxLmgd/oMOxwlS8jSvnPSaZCmAeCmjBFKmI5j7XdWsY/Mj5SpefimkM/C2uh1
	 bVAhllArzH1JJNYtcCSZVdB25jvbodnEUXa0VcPtpP5u4qQwB3yP+bbxQP2GZqUSOw
	 FRdnpkkHT+JSQWARDxh0/cu3usnQVplknM7TRlys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgERS3u (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 14:29:50 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:38676 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgERS3l (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 14:29:41 -0400
Received: by mail-il1-f194.google.com with SMTP id j2so10878121ilr.5;
        Mon, 18 May 2020 11:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H9QUmqRboTMq2btI6W1PlOxGwrrB/TVm3hT9RDAxdio=;
        b=dv/RyRgTjIqZKFw4/wVffVjI4wcgG6Tee3JUpGSOClDB8QnVwGVR8NqYWLlhLtwjEb
         Gu9nqMn2IXRrLq0M3Ol9/b0DQq1JuqwA7BWDu8nEW617EA2/kuIF4VW1631VzpFLN/15
         x86g7/YZFNyvLil9lx5mpbP7rGqKqmm4uDczvdtiW08XqOebfPOTD8tyCX3NHBCAA5lS
         ENe3BLYLrPCQfMWDAleQ3vThc09IokJaXhUa0bmFUUTDgAhr4sQ28T8mAFI4gXqpDa7p
         sK8w05oqVMwOFkBw1lq6ccLD68+4Q773TN/cIl1G/9Ep4EsCNxA3gsn8IcM5noRUNKW3
         WFxQ==
X-Gm-Message-State: AOAM530c4M2mGZb/S6AGqYDJoADu1tehptIOHdVLHW9w6z/0kZhQTXyc
        LS7cK5qoZHgvkn1jx+mKqQ==
X-Google-Smtp-Source: ABdhPJzxd7rr3zApzsbN80hNAQP6arGxepHH572CYOWpC/bwGTqxizgZRmX7IJW1q0n5+KM61tXsVA==
X-Received: by 2002:a92:b743:: with SMTP id c3mr14630153ilm.92.1589826579249;
        Mon, 18 May 2020 11:29:39 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l9sm4203595iop.22.2020.05.18.11.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 11:29:38 -0700 (PDT)
Received: (nullmailer pid 7054 invoked by uid 1000);
        Mon, 18 May 2020 18:29:37 -0000
Date:   Mon, 18 May 2020 12:29:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v1] dt-bindings: serial: qca,ar9330-uart: Convert to
 json-schema
Message-ID: <20200518182937.GA6974@bogus>
References: <20200510051522.6191-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200510051522.6191-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, 10 May 2020 07:15:22 +0200, Oleksij Rempel wrote:
> Convert the Qualcomm Atheros AR9330 High-Speed UART
> Device Tree binding documentation to json-schema.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  .../bindings/serial/qca,ar9330-uart.txt       | 31 ------------
>  .../bindings/serial/qca,ar9330-uart.yaml      | 50 +++++++++++++++++++
>  2 files changed, 50 insertions(+), 31 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/serial/qca,ar9330-uart.txt
>  create mode 100644 Documentation/devicetree/bindings/serial/qca,ar9330-uart.yaml
> 

Applied, thanks!
