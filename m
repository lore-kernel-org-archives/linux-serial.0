Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 334C1C77B73
	for <linux-serial@archiver.kernel.org>; Thu, 20 Apr 2023 11:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjDTLpO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:45:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbjDTLo7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Apr 2023 07:44:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B401FFD;
        Thu, 20 Apr 2023 04:44:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0D9A64888;
        Thu, 20 Apr 2023 11:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10AD6C433D2;
        Thu, 20 Apr 2023 11:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681991097;
        bh=mxT4Z21/XVsyNYG6RT6Fgz7Gjc9mu3RGm/K/+qrP4qE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=INPO/Bq4JZwK7ru0J9qGurRlPrlYIm8CkO9DiFRNATMuJ5gRR39lB2HL0bhGm5p2Y
         jmoVXt8jSDr2UhTghxUi7oEfk3eKNGMlHtOrPZ+b7pxHCPpVWDqpd3t+RZVWJmejdB
         /hX7TjiXMiNlk9UvTmdrDfVY5bf+3tOeRtlBtUag=
Date:   Thu, 20 Apr 2023 13:44:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>
Cc:     linux-serial@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        stable@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] serial: max310x: fix IO data corruption in batched
 operations
Message-ID: <ZEEltx415gdhy5Ck@kroah.com>
References: <79db8e82aadb0e174bc82b9996423c3503c8fb37.1680732084.git.jan.kundrat@cesnet.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <79db8e82aadb0e174bc82b9996423c3503c8fb37.1680732084.git.jan.kundrat@cesnet.cz>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 05, 2023 at 10:14:23PM +0200, Jan Kundrát wrote:
> After upgrading from 5.16 to 6.1, our board with a MAX14830 started
> producing lots of garbage data over UART. Bisection pointed out commit
> 285e76fc049c as the culprit. That patch tried to replace hand-written
> code which I added in 2b4bac48c1084 ("serial: max310x: Use batched reads
> when reasonably safe") with the generic regmap infrastructure for
> batched operations.
> 
> Unfortunately, the `regmap_raw_read` and `regmap_raw_write` which were
> used are actually functions which perform IO over *multiple* registers.
> That's not what is needed for accessing these Tx/Rx FIFOs; the
> appropriate functions are the `_noinc_` versions, not the `_raw_` ones.
> 
> Fix this regression by using `regmap_noinc_read()` and
> `regmap_noinc_write()` along with the necessary `regmap_config` setup;
> with this patch in place, our board communicates happily again. Since
> our board uses SPI for talking to this chip, the I2C part is completely
> untested.
> 
> Fixes: 285e76fc049c serial: max310x: use regmap methods for SPI batch operations

Nit, please use the style that the documentation asks for here, which
should look like:

Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch operations")

otherwise our tools complain :(
I'll go fix this up by hand...

greg k-h
