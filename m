Return-Path: <SRS0=4AmH=3E=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1BAC33CB1
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jan 2020 12:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBED2467D
	for <linux-serial@archiver.kernel.org>; Wed, 15 Jan 2020 12:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579092018;
	bh=zTGCcTH+zuuEPEMCypp/98qgq+Cl+r+pOzE4p1d1l3k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cm4toBVU61J8LVjlDaWNg+NMMAvZOJJViVrbUx+TygylIL33iCMrRx92GxO9gNTGy
	 NVUf5tQ2iPI+1xtdSSSmoJT4s7hRxGWOz3CZWEnVgv6eCem6GP+BtIHpwNmSWYcEo0
	 YJ4AlDySSF/lmoKp0THCdIR6gDaTcxJVhl/tGrok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgAOMkS (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 15 Jan 2020 07:40:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbgAOMkR (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 15 Jan 2020 07:40:17 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC3CB2467C;
        Wed, 15 Jan 2020 12:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579092017;
        bh=zTGCcTH+zuuEPEMCypp/98qgq+Cl+r+pOzE4p1d1l3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rx6YGJgJS+147krh4fIi4LbiffxplbddVF+NbLtNgRjQvW0oy6msAcz0YFF9OPU19
         VbD80RBe/bvYrIsAhtZY6Nobof2AagdJBtBxZlVbUMPe977oYzWN8ra6AaEleCy4Wc
         /LCSsT87BAJ1pgnwUdwpB7jixE9siZsHUvfr/Znw=
Date:   Wed, 15 Jan 2020 13:40:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jiri Slaby <jslaby@suse.com>, Joe Perches <joe@perches.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vasiliy Khoruzhick <vasilykh@arista.com>,
        linux-serial@vger.kernel.org
Subject: Re: [PATCHv2-next 3/3] serial_core: Remove unused member in uart_port
Message-ID: <20200115124014.GA3485808@kroah.com>
References: <20200114171912.261787-1-dima@arista.com>
 <20200114171912.261787-4-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114171912.261787-4-dima@arista.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jan 14, 2020 at 05:19:12PM +0000, Dmitry Safonov wrote:
> It should remove the align-padding before @name.
> 
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  include/linux/serial_core.h | 1 -
>  1 file changed, 1 deletion(-)

I've applied this patch to my tree now.  See my comments on the first
patch and then feel free to rebase and redo those and resend.

thanks,

greg k-h
