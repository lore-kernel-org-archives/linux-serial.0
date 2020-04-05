Return-Path: <SRS0=ea9B=5V=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5616C2BA17
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 13:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB5A220672
	for <linux-serial@archiver.kernel.org>; Sun,  5 Apr 2020 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586094619;
	bh=bR1WXlMJEBNzWcKWcDl/QhYQj4ePiYgOHWnZdlwCXxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=br5tXl7TVkBO3QElxOwZ+TjbeUE0IE8cRhnpj3CKYRihPm72YRhFf6UhDgkzzx7Xh
	 6Mmpm/xljYo2P5xsfoQVoSY5cj1TGkWEBjsOVI4GZ96l6XKDnF6at0DPxijLw1And/
	 Z4GMygOIWIZC1VdEB577sQ45EYnsdqgS3fq5QH7U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgDENuO (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:50:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726636AbgDENuN (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 5 Apr 2020 09:50:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DFF720672;
        Sun,  5 Apr 2020 13:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586094613;
        bh=bR1WXlMJEBNzWcKWcDl/QhYQj4ePiYgOHWnZdlwCXxo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwsSCn0kr9vsqQUeCx5pEmdJhCy+R801Pa3w5MnT3N2gZHLFZq4XWdM5caunBHc1t
         RaaxfXlYG0yM0qH20ML8OsoIvoLKhfiBcI0boiQFlouNwBQJiZk2bLyWPZyl+/ARvf
         1hE+HyvrSn4qYUsUlWTu3DQ5AhMlhtYOF3RgTDJY=
Date:   Sun, 5 Apr 2020 15:50:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin Ian King <colin.king@canonical.com>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/tty: emove redundant assignment to variable i
 and rename it to ret
Message-ID: <20200405135005.GA1573947@kroah.com>
References: <20200405133013.380080-1-colin.king@canonical.com>
 <dd83c6dc-da74-e961-4a25-b6515742052a@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd83c6dc-da74-e961-4a25-b6515742052a@canonical.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Sun, Apr 05, 2020 at 02:35:43PM +0100, Colin Ian King wrote:
> Oops, typo on $SUBJECT, can "emove" be replaced with "remove" when this
> is applied?

It's easier if you fix it up and send it again, thanks.

greg k-h
