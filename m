Return-Path: <SRS0=U7OZ=5Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1676C43331
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 21:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C0E2080C
	for <linux-serial@archiver.kernel.org>; Tue, 31 Mar 2020 21:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585689949;
	bh=RsGh+Out5a1UL2we2Ieb++/a9uqs4S4+bJkYZDOZCEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=emHLqPM4fjKGrtumuQE+fcVCW4h7HXUQUoVjgl56Nto3rmb2vGR4DjBwDLFBy56Ut
	 MmiKsdWcO++kHWqm/OjOjdftrRHIeo+Cno6xWq1tVQjuw8rT8SVcsYd5x2yjiv2v18
	 CG0+1A9GiBE0psWef8U75tnNXrSyhVW788x7rdqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgCaVZt (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 31 Mar 2020 17:25:49 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:44324 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727852AbgCaVZt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 31 Mar 2020 17:25:49 -0400
Received: by mail-il1-f193.google.com with SMTP id j69so20927097ila.11;
        Tue, 31 Mar 2020 14:25:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O8cQUDKoQ2xLSL5sEjGS0UtcsD45xq3tZcjivm7B7y4=;
        b=f1j6pLwBxGrp4sTT/l5qvHzlsqkMeEEXkev89xRkLyBSS1wbF4ObG+/29ftkr8HdSY
         QI9WuUz0DeSPZ/8MWs8QPKNpw4KnEqXSBRicXvvYwCuTVqK3sqmxAFh+P/BAQI7BQVjZ
         Tb528Iu7B2JXH5JR44K3xjDR72bVFAy8aJiSFk2f6QITnHXO53PwVVqgbJs4/BTpl0MA
         f7vHe6f5J0V2gVsJJ/L9VGbAW3lD7nksc0wpzllcX0MXj4CQy5YAe/02u3oFFJENkwZQ
         EwNU89SriGsR1WL+FYaQsgh55OIlRc9CXmrAaqrfGRttaPiyrbazk7/rJfiYWrAmHL2t
         CM6A==
X-Gm-Message-State: ANhLgQ3ccEgHuQ8GfLjJqHNJCaojWcf3kPb8vFsHfy7DCYUzhM3cCxum
        8kxFJh32T5C3zXko2N7Vvg==
X-Google-Smtp-Source: ADFU+vvxE9yYrt38JAe+CV6k+uiJTzkM7PcVVpZNonpeVMZ/bY+3FG9RZQmn+QGwEje/HBGK6Yvs4Q==
X-Received: by 2002:a92:3b1b:: with SMTP id i27mr19136167ila.230.1585689948423;
        Tue, 31 Mar 2020 14:25:48 -0700 (PDT)
Received: from rob-hp-laptop ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id y71sm23304ilk.23.2020.03.31.14.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 14:25:47 -0700 (PDT)
Received: (nullmailer pid 23286 invoked by uid 1000);
        Tue, 31 Mar 2020 21:25:46 -0000
Date:   Tue, 31 Mar 2020 15:25:46 -0600
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH] dt-bindings: serial: Document serialN aliases
Message-ID: <20200331212546.GA23210@bogus>
References: <20200325095442.11191-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325095442.11191-1-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, 25 Mar 2020 10:54:42 +0100, Geert Uytterhoeven wrote:
> Document the format of aliases referring to UARTs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  Documentation/devicetree/bindings/serial/serial.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Applied, thanks.

Rob
