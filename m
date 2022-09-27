Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FCE0C07E9D
	for <linux-serial@archiver.kernel.org>; Tue, 27 Sep 2022 15:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbiI0PEb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 27 Sep 2022 11:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbiI0PE0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 27 Sep 2022 11:04:26 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE33E7E33;
        Tue, 27 Sep 2022 08:04:23 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4McNFK30KPzvjfm; Tue, 27 Sep 2022 17:04:21 +0200 (CEST)
Date:   Tue, 27 Sep 2022 17:04:21 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] tty: serial: unify TX space reads under
 altera_jtaguart_tx_space()
Message-ID: <20220927150420.nqzvgbs43etwpuxd@distanz.ch>
References: <20220927111819.18516-1-jslaby@suse.cz>
 <20220927111819.18516-3-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927111819.18516-3-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-09-27 at 13:18:18 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> TX space reads from the control register are performed in various forms
> on 4 places in altera_jtaguart. Unify all those and do the read and
> masking on a single place.
> 
> The new helper altera_jtaguart_tx_space() uses FIELD_GET(), so we can
> drop ALTERA_JTAGUART_CONTROL_WSPACE_OFF now.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
