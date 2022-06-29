Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD61C433EF
	for <linux-serial@archiver.kernel.org>; Wed, 29 Jun 2022 06:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiF2GJI (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 29 Jun 2022 02:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiF2GIf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 29 Jun 2022 02:08:35 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B811E3C5;
        Tue, 28 Jun 2022 23:08:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9A1E0CE2303;
        Wed, 29 Jun 2022 06:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49F0C34114;
        Wed, 29 Jun 2022 06:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656482910;
        bh=vJY9q7y2S/D/f1k4JQ1UNKjNcETLJ7Ea5lvJFwixXcM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t+n+4qZ8lVWLh0wsCMRqutBzJ3k8I0W8IaAYmRwFM0J6WXFwdIkM8Oy6j72kkB5uJ
         7hII79WIDEVmACHyzWjlXxpMCZChGpCQf4bnwcAeyS1Pa3WUqz8iW7RQzrVDC7qadP
         9RP4J1KYG+HrtyKj2/y0LecLOIsT5drXFKhEXMuk=
Date:   Wed, 29 Jun 2022 08:08:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-serial@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        jirislaby@kernel.org, miquel.raynal@bootlin.com,
        phil.edworthy@renesas.com, kernel@esmil.dk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Revert "serial: 8250: dw: Move the USR register to
 pdata"
Message-ID: <YrvsW7RmHRr5zbS3@kroah.com>
References: <20220629000232.3440704-1-jeremy.linton@arm.com>
 <20220629000232.3440704-2-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629000232.3440704-2-jeremy.linton@arm.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jun 28, 2022 at 07:02:31PM -0500, Jeremy Linton wrote:
> pdata is only setup by DT machines, leaving ACPI machines
> with null pdata. Since I don't know the exact mapping of
> ACPI ID's to dw 8250 variations I can't add pdata to them
> without possibly breaking something. As such the simplest
> fix here is probably just to revert this commit.
> 
> This reverts commit ffd381445eac2aa624e49bab5a811451e8351008.
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>

Didn't checkpatch complain that you need a blank line before your
signed-off-by line?

thanks,

greg k-h
