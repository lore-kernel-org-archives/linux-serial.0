Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61D3C4332F
	for <linux-serial@archiver.kernel.org>; Tue, 15 Nov 2022 15:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKOPD1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 15 Nov 2022 10:03:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiKOPD0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 15 Nov 2022 10:03:26 -0500
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07D32C133;
        Tue, 15 Nov 2022 07:03:22 -0800 (PST)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4NBTm95Plbzvjfm; Tue, 15 Nov 2022 15:56:57 +0100 (CET)
Date:   Tue, 15 Nov 2022 15:56:57 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: serial: altera_jtaguart: remove flag from
 altera_jtaguart_rx_chars()
Message-ID: <20221115145657.b6475kn6rr4ysmml@distanz.ch>
References: <20221115071724.5185-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115071724.5185-1-jirislaby@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-11-15 at 08:17:21 +0100, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> TTY_NORMAL is the only value it contains, so remove the variable and use
> the constant instead.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>

Reviewed-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
