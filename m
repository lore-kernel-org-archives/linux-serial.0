Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CE7C433F5
	for <linux-serial@archiver.kernel.org>; Thu, 19 May 2022 07:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiESHCr (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 19 May 2022 03:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbiESHCp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 19 May 2022 03:02:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B23B19C
        for <linux-serial@vger.kernel.org>; Thu, 19 May 2022 00:02:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 363C361A8A
        for <linux-serial@vger.kernel.org>; Thu, 19 May 2022 07:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10922C34100;
        Thu, 19 May 2022 07:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652943763;
        bh=15fHYFqNeavE+taYo/yl6z6a68MOaZGBw4pYrJkVNCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8cdPBj+jNwJhxgverQhcm2TNMcW6WvjV+U9X50vdrDlrtH88bIca54BWS+EoK/gK
         SXxNyV/mvT6TcrzL79lsYVcXfyjUe2FuQaCr682dVPQ9kPg1CHuw6i+3BSrIoSpUSl
         E1xNDkbnCzaKEucpsyg8+hzguf5a4G2wTse2pxqk=
Date:   Thu, 19 May 2022 09:02:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     christopher tyerman <linuxkernel@firebladeautomationsystems.uk>
Cc:     linux-serial@vger.kernel.org
Subject: Re: Using Serdev is it Possible to Pull RX Low
Message-ID: <YoXrj6r+rhpSpZXt@kroah.com>
References: <341d8439-4466-7182-745d-ba613301e009@firebladeautomationsystems.uk>
 <YoSy2vnS68wkLpcO@kroah.com>
 <e92ad3ac-3d52-7f77-8839-74ef81a74154@firebladeautomationsystems.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e92ad3ac-3d52-7f77-8839-74ef81a74154@firebladeautomationsystems.uk>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, May 18, 2022 at 07:11:38PM +0100, christopher tyerman wrote:
> On 18/05/2022 09:48, Greg KH wrote:> On Tue, May 17, 2022 at 07:42:46PM
> +0100, linuxkernel wrote:
> >> hello I, looking at writing a kernel driver for the Texas instruments
> >> TPS92662A/TPS92663A which uses a "UART bus" e.g
> >> |-----------|    |-----------|    |-----------|     |-----------|
> >> |           |    | TPS92662A |    | TPS92662A |     | TPS92663A |
> >> |   UART    |    | -Q1       |    | -Q1       |     | -Q1 	   |
> >> |           |    |           |    |           |     |           |
> >> |-----------|    |-----------|    |-----------|     |-----------|
> >>       |                |                |                 |
> >>       |                |                |                 |
> >>       |                |                |                 |
> >>       -----------------------------------------------------
> >> and control communications by specific sequencing. configuring this
> >> appears to require being able to pull RX Low
> >>> The MCU unit can reset the device UART and protocol state machine at
> >>> any time by holding the RX input low for a period of at least 12 bit
> >>> times (16 × 12 CLK periods).
> >> practically i can always pull RX low via other means, but if the UART
> >> can do this it would be better and be more generic.
> > How can your UART do that in a generic way? thanks, greg k-h sorry
> 
> im not sure i explained that clearly
> 
> i also appear to have, not got the previous diagram right, (corrected in
> this reply for clarity) Im still getting used to plain text emails.
> 
> im not that familiar with UARTs in practice, and after re-reading i think i
> could have phrased that better, as had issue with MCU/IC UART TX/RX
> perspectives
> 
> e.g
> 
> |-----------|           |-----------|
> |         TX|-----------|RX         |
> | MCU UART  |           |    IC     |
> |         RX|-----------|TX         |
> |-----------|           |-----------|
> 
> from the mcu perspective its the TX pin, while from the RX pin from the ICs
> perspective.
> 
> from that perspective i need to pull the ICs RX pin low which means pull the
> MCU UART TX pin Low.
> 
> now this seems conceptually similar to a "break condition"
> 
> which some tty functions can produce
> e.g
> static int send_break(struct tty_struct *tty, unsigned int duration)
> [https://elixir.bootlin.com/linux/latest/source/drivers tty/tty_io.c#L2461]
> 
> with which i might me half way to answering my own question
> 
> i can't see call to that via serdev, or equivalent
> 

That is correct, serdev can not handle break conditions on the tty port
right now.  You need to write a "real" serial driver if you want to have
that type of control over the connection.

You could propose a patch for serdev to handle break, try that and
submit it and see if the serdev maintainer agrees that it is a worth
addition.

thanks,

greg k-h
