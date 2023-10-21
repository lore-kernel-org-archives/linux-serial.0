Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F437C001E0
	for <linux-serial@archiver.kernel.org>; Sat, 21 Oct 2023 16:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbjJUQbu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 21 Oct 2023 12:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQbt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 21 Oct 2023 12:31:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011A106;
        Sat, 21 Oct 2023 09:31:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B978C433C7;
        Sat, 21 Oct 2023 16:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697905904;
        bh=rTA5sZ9q9X5Hxck7m90IWAvQSDM7S3h6sRpwDRfaZzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkE7oMELbts3Jg/R3W7KD6aW4WT94p3wCp/Y3xfovaJiw6UxCxCTqNCo07zqzRt8C
         K2sdbbm0+11ivn3DG4ovmaRj2sGCKdahlAdMRVhfO7QCqd60wLUxcC6LXXN56edwST
         5tZCn726R9c8oc0HjOnP4vOIAeut4/FDGab2CoY0=
Date:   Sat, 21 Oct 2023 18:31:42 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH v3 0/6] tty: serial: 8250: Changes of MOXA PCIe boards in
 8250_pci.c
Message-ID: <2023102122-oblivion-unpiloted-90f1@gregkh>
References: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018091739.10125-1-crescentcy.hsieh@moxa.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Oct 18, 2023 at 05:17:33PM +0800, Crescent CY Hsieh wrote:
> These patch series do some changes to MOXA PCIe boards in 8250_pci.c,
> including:
> 
> - Modify MOXA enum name within 8250_pci.c
> - Cleanup MOXA configurations within 8250_pci.c
> - Relocate macros within 8250_pci.c
> - Add support for MOXA Mini PCIe boards
> - Fix MOXA RS422/RS485 boards not function by default
> - Add support for MOXA PCIe boards to switch between different serial
>   interfaces
> 
> Each patch depends on previous one.

I've applied the first 4 to my tree now, plaese fix up the last two and
send them as a new patch series for review.

thanks,

greg k-h
