Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6F7C54EBD
	for <linux-serial@archiver.kernel.org>; Mon,  9 Jan 2023 07:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjAIHIK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 9 Jan 2023 02:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbjAIHIA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 9 Jan 2023 02:08:00 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4061157;
        Sun,  8 Jan 2023 23:07:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C06F9CE0E95;
        Mon,  9 Jan 2023 07:07:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001ACC433F0;
        Mon,  9 Jan 2023 07:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673248075;
        bh=Zwa/0Kc9RycNQnqCv0qfKsVWUve+AEFePq/i81NsDEY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3zMiOBPFIu23E6+s5kU6iMY1QAgTfsXd/W2nB40wUjffSrgdl1xdlnUPfcdq539z
         sR8cX8glQzBoUdDdR87J3aQETNpL3xAOCp+ZhAcYyl19hKv9dXZgQW24Al20mZzV2a
         sVwtWQzw+wCf3u99Gvag9CKunlSPbaPQ2pM4SJuI=
Date:   Mon, 9 Jan 2023 08:07:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Tobias Schramm <t.schramm@manjaro.org>
Cc:     Richard Genoud <richard.genoud@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: atmel: fix incorrect baudrate setup
Message-ID: <Y7u9SAX++YsXvnVC@kroah.com>
References: <20230109070200.200181-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109070200.200181-1-t.schramm@manjaro.org>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, Jan 09, 2023 at 08:02:00AM +0100, Tobias Schramm wrote:
> Commit ba47f97a18f2 ("serial: core: remove baud_rates when serial console
> setup") changed uart_set_options to select the correct baudrate
> configuration based on the absolute error between requested baudrate and
> available standard baudrate settings.
> Prior to that commit the baudrate was selected based on which predefined
> standard baudrate did not exceed the requested baudrate.
> This change of selection logic was never reflected in the atmel serial
> driver. Thus the comment left in the atmel serial driver is no longer
> accurate.
> Additionally the manual rounding up described in that comment and applied
> via (quot - 1) requests an incorrect baudrate. Since uart_set_options uses
> tty_termios_encode_baud_rate to determine the appropriate baudrate flags
> this can cause baudrate selection to fail entirely because
> tty_termios_encode_baud_rate will only select a baudrate if relative error
> between requested and selected baudrate does not exceed +/-2%.
> Fix that by requesting actual, exact baudrate used by the serial.
> 
> Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
> ---

What commit id does this fix?  Please list that as a the "Fixes:" tag.

Also, does this need to go to older/stable kernels?

thanks,

greg k-h
