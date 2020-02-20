Return-Path: <SRS0=HSIU=4I=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19451C11D0C
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFE04208CD
	for <linux-serial@archiver.kernel.org>; Thu, 20 Feb 2020 19:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728981AbgBTTo4 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:44:56 -0500
Received: from muru.com ([72.249.23.125]:56484 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728968AbgBTTo4 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 20 Feb 2020 14:44:56 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1F44C8080;
        Thu, 20 Feb 2020 19:45:41 +0000 (UTC)
Date:   Thu, 20 Feb 2020 11:44:53 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] n_gsm: drop unneeded gsm_dlci->fifo field
Message-ID: <20200220194453.GT37466@atomide.com>
References: <20200219084949.28074-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219084949.28074-1-jslaby@suse.cz>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

* Jiri Slaby <jslaby@suse.cz> [700101 00:00]:
> gsm_dlci->fifo always points to gsm_dlci->_fifo. So drop the pointer and
> rename _fifo to fifo. And update all the users (add & to them).

I gave this series a quick test with my pending n_gsm serdev changes
and things work fine for me.

So for the whole series, please feel free to add:

Tested-by: Tony Lindgren <tony@atomide.com>
