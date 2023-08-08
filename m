Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC10C001B0
	for <linux-serial@archiver.kernel.org>; Tue,  8 Aug 2023 16:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjHHQgK (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjHHQe6 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 8 Aug 2023 12:34:58 -0400
Received: from sym2.noone.org (sym.noone.org [IPv6:2a01:4f8:120:4161::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3744B6;
        Tue,  8 Aug 2023 08:52:38 -0700 (PDT)
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4RKwgG42ySzvjhL; Tue,  8 Aug 2023 16:34:18 +0200 (CEST)
Date:   Tue, 8 Aug 2023 16:34:18 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/10] serial: altera_jtaguart: switch status to u32
Message-ID: <20230808143417.lcwb4kh2df6kdrxh@distanz.ch>
References: <20230731080244.2698-1-jirislaby@kernel.org>
 <20230731080244.2698-7-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731080244.2698-7-jirislaby@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2023-07-31 at 10:02:40 +0200, Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
> 'status' is assigned a result from readl(). There is no need for the
> variable to be 'unsigned long'. readl() returns 32bit values.
> 
> Provided, this is a Nios II driver (32-bit), there is no change in
> semantics. This only makes the type explicit.
> 
> Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
> Cc: Tobias Klauser <tklauser@distanz.ch>

Acked-by: Tobias Klauser <tklauser@distanz.ch>
