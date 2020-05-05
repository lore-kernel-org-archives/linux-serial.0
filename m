Return-Path: <SRS0=jHyV=6T=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0CEC47254
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 11:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 655102078C
	for <linux-serial@archiver.kernel.org>; Tue,  5 May 2020 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588677031;
	bh=GczSjg2mY+zVUBwyK+x5JROwfYQz7w+f1HqDD4SgsRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fWQw0F6C1J5rWj0lXVRDL88wyJyOLqx/1rRgjxR1JCe3fCCDnCPBJArxNWChgdUTB
	 NBcO8DZuVw8qOzQBu3oKhlhMhf4Vx5VCLuldArDruaHGz3jbWkVZ1V4BVIX/cS/EcI
	 Ne00a4s9V+AbJT3Np+WQiXxDYEknWgAdkSP1sBOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgEELKb (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 5 May 2020 07:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgEELKa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 5 May 2020 07:10:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1E3C0206D7;
        Tue,  5 May 2020 11:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588677030;
        bh=GczSjg2mY+zVUBwyK+x5JROwfYQz7w+f1HqDD4SgsRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OCwki1USRAmdS8aGyCPfJLL9E0Xi+2JLTACEEI3+u+VJjiE0S1JA2cFDtoV+JBCFM
         6aaBfjDN/9N1JrYxckDC1PQ9cxInamd/QsLMvCTI4Dp4PZTOy+JUXzMkDjcroWR8PE
         F/61FnIJ3qm1kmp5PKmLOZtQccMbeD6Mk8Pxi2X4=
Date:   Tue, 5 May 2020 13:10:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     sean.wang@mediatek.com
Cc:     jslaby@suse.com, andriy.shevchenko@linux.intel.com,
        mika.westerberg@linux.intel.com, sr@denx.de, arnd@arndb.de,
        matthias.bgg@gmail.com, tthayer@opensource.altera.com,
        linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Steven Liu <steven.liu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: Re: [PATCH v3] tty: serial: don't do termios for BTIF
Message-ID: <20200505111028.GA114206@kroah.com>
References: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
 <20200422180900.GA3454664@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422180900.GA3454664@kroah.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Apr 22, 2020 at 08:09:00PM +0200, Greg KH wrote:
> On Thu, Apr 23, 2020 at 02:02:08AM +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> > BT in order to be instead of the UART interface between BT module and Host
> > CPU, and not exported to user space to access.
> > 
> > As the UART design, BTIF will be an APB slave and can transmit or receive
> > data by MCU access, but doesn't provide termios function like baudrate and
> > flow control setup.
> 
> Why does it matter?  If the connection isn't exported to userspace, who
> would run those termios functions on the port?

Dropping from my patch queues due to a lack of response, please address
this question when you resend this.

greg k-h
