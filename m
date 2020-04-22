Return-Path: <SRS0=lyyL=6G=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC841C54FCB
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 18:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3E92098B
	for <linux-serial@archiver.kernel.org>; Wed, 22 Apr 2020 18:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587578943;
	bh=DbXSxiXMHu9tU9vMTNParw5iSEIHMpG8ZCFcfxstLUg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mvh7PzAV5MdTbcsn4o0qvUi42JVmeNSMNilJJYdMDEjZLHAGkQtNDrWhcC95wzN7Y
	 q78PedHv7RtHNSIolhJSNUMWOnetPR/ObaONp6NLt2EinGM0DbMJwf0ncF52PsQ7tU
	 Z84+Hj/WGvtmCfH9HTtsHy+CIAseoIdq/EivrYYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgDVSJD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:09:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgDVSJD (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 22 Apr 2020 14:09:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4867B2076E;
        Wed, 22 Apr 2020 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587578942;
        bh=DbXSxiXMHu9tU9vMTNParw5iSEIHMpG8ZCFcfxstLUg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y12gr1v8W3Cp5my1PFVQOqrT0SNBpbvuG4iD9FgpkkdHHdSLfpRXKfi0+6uOMVdWV
         dKVWetYESo596O1mJfxXE8Tkhhozi1bUCryhNmRDCs1TiAsHMY/3CF7hvaTANkoKoh
         FVDAUp8UhagDM3QQ8E2ewFDBizGrQFbskObzXK9Q=
Date:   Wed, 22 Apr 2020 20:09:00 +0200
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
Message-ID: <20200422180900.GA3454664@kroah.com>
References: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc41ea10be9ab96568f0371784e3b9f8d9f434b9.1587577548.git.sean.wang@mediatek.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 23, 2020 at 02:02:08AM +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Bluetooth Interface (BTIF) is designed dedicatedly for MediaTek SOC with
> BT in order to be instead of the UART interface between BT module and Host
> CPU, and not exported to user space to access.
> 
> As the UART design, BTIF will be an APB slave and can transmit or receive
> data by MCU access, but doesn't provide termios function like baudrate and
> flow control setup.

Why does it matter?  If the connection isn't exported to userspace, who
would run those termios functions on the port?

thanks,

greg k-h
