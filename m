Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4276CEE4993
	for <linux-serial@archiver.kernel.org>; Tue, 22 Aug 2023 13:04:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjHVNEo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Aug 2023 09:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbjHVNEo (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Aug 2023 09:04:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D04CC6;
        Tue, 22 Aug 2023 06:04:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7306963972;
        Tue, 22 Aug 2023 13:04:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323E6C433C8;
        Tue, 22 Aug 2023 13:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692709481;
        bh=ub/bcX26vqv0SnRwA1OEt2iuTCjmwdGk2R/p505yXBI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKOsintoj3EMdxyaWS3nbeMYnPM9ait5IenzIaBMygu/XgKuThIFoMk6IvZgTO58j
         ETf/HjwhmLTaJr/QLUMonuU0wWrXIOdV5ujDY1/Du7bvyMLEFJJ0Taj4etdBEvr5aH
         d4eJICXAFtYwsUZq+oThKE4iP1hXngSkEaw2JA4U=
Date:   Tue, 22 Aug 2023 15:04:38 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 8/9] tty: n_gsm: add DLCI specific rx/tx statistics
Message-ID: <2023082253-heftiness-arena-ed06@gregkh>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
 <20230817093231.2317-8-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817093231.2317-8-daniel.starke@siemens.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Aug 17, 2023 at 11:32:30AM +0200, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> Add counters for the number of data bytes received/transmitted per DLCI in
> for preparation for an upcoming patch which will expose these values to the
> user.

As you don't do anything with this data here, let's just wait until you
actually do as it's not part of this patch series.

So when your resend, please drop this.

thanks,

greg k-h
