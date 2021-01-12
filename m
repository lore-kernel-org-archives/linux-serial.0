Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1F1C433E6
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D4F3224BD
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jan 2021 10:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404939AbhALKXo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jan 2021 05:23:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:49204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbhALKXn (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jan 2021 05:23:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E2A8224BD;
        Tue, 12 Jan 2021 10:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610446983;
        bh=sZ83tp3PCWrezXxnJ9F+Y/33Czn075FuyrVU0k6CVFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vSm3spjITRpP9whrZzotRPbJT/X/LjPI6w3tx2Osaz0GFVUZUOX56I6vUOaY24WPn
         4zpRrPxcZbOsnC+WrzQ5jGmfKngz4O2YQUou6v412Dq+eMeTO2TyixzBAOr7Rl+T6t
         SX3l9RvpUz6mGN3hlj+957ys9s0L7wHNvz9f739k=
Date:   Tue, 12 Jan 2021 11:24:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan LE RAY <erwan.leray@foss.st.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>
Subject: Re: [PATCH v2 2/8] serial: stm32: fix code cleaning warnings and
 checks
Message-ID: <X/14zOkg/NpFjyR/@kroah.com>
References: <20210106162203.28854-1-erwan.leray@foss.st.com>
 <20210106162203.28854-3-erwan.leray@foss.st.com>
 <72c81157-4bd1-6a3e-2415-92a2fb29ab6d@kernel.org>
 <667eb6bd-b612-fd78-0b09-d61eff72d139@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <667eb6bd-b612-fd78-0b09-d61eff72d139@foss.st.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 12, 2021 at 11:02:43AM +0100, Erwan LE RAY wrote:
> Hello Greg,
> 
> As the V2 is already in your tty-next branch, how do want me to proceed to
> deliver the fix for Jiri remark ?
> Do you expect a V3 or a new fix ?

Patches on top of that tree please, I can't drop something in a public
tree.

thanks,

greg k-h
