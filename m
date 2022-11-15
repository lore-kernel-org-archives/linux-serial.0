Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9EDC43217
	for <linux-serial@archiver.kernel.org>; Tue, 15 Nov 2022 15:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiKOPI0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKOPIY (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Nov 2022 10:08:24 -0500
X-Greylist: delayed 560 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Nov 2022 07:08:22 PST
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF30D1838B;
        Tue, 15 Nov 2022 07:08:22 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4NBTpW4Ds9zvjfp; Tue, 15 Nov 2022 15:58:59 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:58:59 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: altera_jtaguart: use
 uart_port::read_status_mask
Message-ID: <20221115145859.kk2ygswlsqth6nqq@distanz.ch>
References: <20221115071724.5185-1-jirislaby@kernel.org>
 <20221115071724.5185-3-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115071724.5185-3-jirislaby@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-11-15 at 08:17:23 +0100, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> Instead of self-defined struct altera_jtaguart::imr, use preexisting
> uart_port::read_status_mask.
> 
> Note that imr was ulong. But there is no reason for that, its values are
> uints. And readl/writel's are used to read it/write to it.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
