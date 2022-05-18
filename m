Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FCC433F5
	for <linux-serial@archiver.kernel.org>; Wed, 18 May 2022 08:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233478AbiERIsc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 18 May 2022 04:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiERIsb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 May 2022 04:48:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812CBD4
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 01:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05EEE616BD
        for <linux-serial@vger.kernel.org>; Wed, 18 May 2022 08:48:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8BEC385A5;
        Wed, 18 May 2022 08:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652863709;
        bh=nRvtvrj+2DMf70W37VXnwc0I7AQ40UFlLAPK2/p2z80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HK+g6SJrXuIPO4+LsVbD4W1E+z/kzBIO28X/cHWRbPdr4cvv6HWQIu0w1oAX3Zr9S
         KLVYBTOBZWFFJo7ExxV6ecMfc2EwKCoqe6UHKOxJQVjGvdFAYlZKaVeXr+6vlXFVG5
         EPEZro6uydGtarmm696jO2zXXtDri7VQG04SHWNI=
Date:   Wed, 18 May 2022 10:48:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linuxkernel <linuxkernel@firebladeautomationsystems.uk>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Using Serdev is it Possible to Pull RX Low
Message-ID: <YoSy2vnS68wkLpcO@kroah.com>
References: <341d8439-4466-7182-745d-ba613301e009@firebladeautomationsystems.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <341d8439-4466-7182-745d-ba613301e009@firebladeautomationsystems.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, May 17, 2022 at 07:42:46PM +0100, linuxkernel wrote:
> hello
> 
> I, looking at writing a kernel driver for the Texas instruments
> TPS92662A/TPS92663A
> 
> which uses a "UART bus" e.g
> 
> |-----------| |-----------| |-----------| |-----------| | | | TPS92662A | |
> TPS92662A | | TPS92663A | | UART | | -Q1 | | -Q1 | | -Q1 | | | | | | | | |
> |-----------| |-----------| |-----------| |-----------| | | | | | | | | | |
> | | -------------------------------------------------------------------
> and control communications by specific sequencing.
> configuring this appears to require being able to pull RX Low
> > The MCU unit can reset the device UART and protocol state machine at any
> > time by holding the RX input low for a period of at least 12 bit times
> > (16 × 12 CLK periods).
> practically i can always pull RX low via other means, but if the UART can do
> this it would be better and be more generic.

How can your UART do that in a generic way?

thanks,

greg k-h
