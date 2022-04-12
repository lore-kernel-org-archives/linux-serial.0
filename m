Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B7C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 12 Apr 2022 12:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiDLMaK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Apr 2022 08:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345421AbiDLM1W (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Apr 2022 08:27:22 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 04:34:08 PDT
Received: from sym2.noone.org (sym.noone.org [178.63.92.236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52A931200;
        Tue, 12 Apr 2022 04:34:08 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4Kd3KT2lSTzvjfn; Tue, 12 Apr 2022 13:24:45 +0200 (CEST)
Date:   Tue, 12 Apr 2022 13:24:45 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] tty: serial: altera: use altera_jtaguart_stop_tx()
Message-ID: <20220412112444.ovep2442cybue5nu@distanz.ch>
References: <20220411104506.8990-1-jslaby@suse.cz>
 <20220411104506.8990-4-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411104506.8990-4-jslaby@suse.cz>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2022-04-11 at 12:45:06 +0200, Jiri Slaby <jslaby@suse.cz> wrote:
> altera_jtaguart_tx_chars() duplicates what altera_jtaguart_stop_tx()
> already does. So instead of the duplication, call the helper instead.
> 
> Not only it makes the code cleaner, but it also says what the "if"
> really does.
> 
> Cc: Tobias Klauser <tklauser@distanz.ch>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
