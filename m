Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C69BC64ED6
	for <linux-serial@archiver.kernel.org>; Wed,  1 Mar 2023 11:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjCALZQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 1 Mar 2023 06:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjCALZQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 1 Mar 2023 06:25:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE2D303F9;
        Wed,  1 Mar 2023 03:25:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E01E9612AC;
        Wed,  1 Mar 2023 11:25:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65E7C433EF;
        Wed,  1 Mar 2023 11:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677669914;
        bh=cIMXIDnozHaqowec1O1TRtHHff4QSszc20HOrjHA07M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x331yujoMN3cX5voi+Sm+TFyUoH14ZKkTnrTJqMx2FO+XZIUdU/kLoI/qIkNQbzKK
         8DOuXijfIs8IER40p3uZNBVqs8xudq+pkuxMVgtz+r3PeLGzqedh9kTDBcNr3yUwkH
         /iMSFeYLemKHIVZr6uUPivV3p5uXICZ2ERCzz4fA=
Date:   Wed, 1 Mar 2023 12:25:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, deller@gmx.de,
        geert+renesas@glider.be, phil.edworthy@renesas.com,
        matthew.gerlach@linux.intel.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty-next] serial: 8250_pci1xxxx: Disable
 SERIAL_8250_PCI1XXXX config by default
Message-ID: <Y/82Ehzj2+FgIRh3@kroah.com>
References: <20230301100930.3519883-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301100930.3519883-1-kumaravel.thiagarajan@microchip.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Mar 01, 2023 at 03:39:30PM +0530, Kumaravel Thiagarajan wrote:
> Disable SERIAL_8250_PCI1XXXX config by default

Why?

Please read the kernel documentation for how to write a good changelog
text.

> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>

What commit id does this fix?

thanks,

greg k-h
