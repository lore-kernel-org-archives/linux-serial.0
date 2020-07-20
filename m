Return-Path: <SRS0=irUw=A7=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F4DC433E6
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jul 2020 09:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FDE21775
	for <linux-serial@archiver.kernel.org>; Mon, 20 Jul 2020 09:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgGTJMw (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:12:52 -0400
Received: from sym2.noone.org ([178.63.92.236]:60436 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbgGTJMv (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 20 Jul 2020 05:12:51 -0400
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 4B9GGT4gvpzvjdR; Mon, 20 Jul 2020 11:12:49 +0200 (CEST)
Date:   Mon, 20 Jul 2020 11:12:49 +0200
From:   Tobias Klauser <tklauser@distanz.ch>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: altera_jtaguart: Replace HTTP links with HTTPS
 ones
Message-ID: <20200720091249.djfmacmstxorrtuf@distanz.ch>
References: <20200718103018.3164-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718103018.3164-1-grandmaster@al2klimov.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-07-18 at 12:30:18 +0200, Alexander A. Klimov <grandmaster@al2klimov.de> wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Acked-by: Tobias Klauser <tklauser@distanz.ch>

Thanks
