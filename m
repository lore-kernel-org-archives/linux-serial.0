Return-Path: <SRS0=tOPF=XZ=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4526CC388F3
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 23:06:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F2E2168B
	for <linux-serial@archiver.kernel.org>; Mon, 30 Sep 2019 23:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569884805;
	bh=9Hy+NYzTLxWtRLKIzH9yyoXyrvpEUHVT1hqu/iE1Zxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ilvksHPobwDp0+Htjpml8mmOTEhZ/ezCx1KZ18SSSetbl8WbAtdnTdrVYHlxpAw2L
	 yTipz55r97nQtupw+3SresRYu0pcIJZF77Kxw5Osvf/XT3+EE42SFtXLweDjwrXGQG
	 xs46YfufXn4pVHZebK6LpvkvFz2v4rXstLnfwL54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbfI3XGo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:06:44 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37980 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfI3XGo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 30 Sep 2019 19:06:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id e11so9891238otl.5;
        Mon, 30 Sep 2019 16:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TLweXOijwFdWK7zNbWqDh8rchrcqU7bnczWWmbnZWEc=;
        b=THurTXQ9o7QVgCqQcOvbZq4p1SR495WtDjpQMQzWVaPA6sqYNC4Z7MmSi++XQEBGoT
         N3AsRk5s9aXRmsJYgjJpHfl6IiUaU6A4M1OpcjKxc1Wer/UYcSxPtqhafJcUoF50CZq8
         Flq0cB7pQ0ivw+6vQNT6JAq9HwUHe/98B1vE6x1HItm/P2NsXdwERWLfTViDjbLE0++G
         Gg3+GT4dOiORLPV0P4KuEmN0lnWqw0B9r2UiIUjlODxvPsBw8yT45db3Sz8zPmrMPRGW
         h4KRZ2JbuwFvnR66xa5qGy9E75N41YtWdMXoVkGeW5TqQfXdP/74PJFewX8doGCxEAo+
         3UjA==
X-Gm-Message-State: APjAAAXxF7IPY0h1kuXFamTdc6ot7AO/kMgjc1gm7t1F7pAImxhOF438
        a45+O7sz046FIewe1ewkFDS0tS0=
X-Google-Smtp-Source: APXvYqy9IdRxqr9jkjAfdLo8ZvulzWBwkEmpIj0mqCLCs+9tviGNsGq8m1QktiGsU7PZ7bH2zqbA7w==
X-Received: by 2002:a05:6830:1e2d:: with SMTP id t13mr3153803otr.357.1569884801924;
        Mon, 30 Sep 2019 16:06:41 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n27sm4030641otr.32.2019.09.30.16.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:06:41 -0700 (PDT)
Date:   Mon, 30 Sep 2019 18:06:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Biju Das <biju.das@bp.renesas.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Biju Das <biju.das@bp.renesas.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: serial: sh-sci: Document r8a774b1 bindings
Message-ID: <20190930230639.GA28632@bogus>
References: <1568724324-26995-1-git-send-email-biju.das@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568724324-26995-1-git-send-email-biju.das@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, 17 Sep 2019 13:45:24 +0100, Biju Das wrote:
> RZ/G2N (R8A774B1) SoC also has the R-Car Gen3 compatible SCIF and
> HSCIF ports, so document the SoC specific bindings.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/serial/renesas,sci-serial.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
