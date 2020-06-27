Return-Path: <SRS0=J/Eu=AI=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D23C433DF
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A642186A
	for <linux-serial@archiver.kernel.org>; Sat, 27 Jun 2020 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593266403;
	bh=8p6ith1ME+sCnv+twqE6KzbdUe2pNu4IyonGeBoDCKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=osZ9E8cX2RSbS9JmnRX0eXB0gILQ2MbHgZdsZs4mCCRwTAJeJ+qrsOzVIwcnIwNSy
	 y9oE0zEdCdS5jvgivfkjCmoS6VINpCIBCvjpM3YTGCpDtxB/VTgK3bKv4eaA418pi5
	 O11apF05QNBR/Hh75z+znOKOMc+9oYZL6pXnu3dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgF0N77 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 27 Jun 2020 09:59:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725850AbgF0N77 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 27 Jun 2020 09:59:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AB0E21852;
        Sat, 27 Jun 2020 13:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593266398;
        bh=8p6ith1ME+sCnv+twqE6KzbdUe2pNu4IyonGeBoDCKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W2q0O0MhOlak7stnGPXyc73KOyI3qFPvhTbZSJplNQ90P5hUwIPNVLCfVESAPOuJ6
         4/6bRKvEWijMkPkYikI7Wr5DB7D3Jul0kCcvBU4Sl0+A7jYslXkibZYrAtVjpd9O5g
         tkuz6kNxCTlxHH7ze9xVZ7nQkm6Q3YiEuTsmwKso=
Date:   Sat, 27 Jun 2020 15:59:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     evgreen@chromium.org, daniel.thompson@linaro.org,
        akashast@codeaurora.org, swboyd@chromium.org,
        kgdb-bugreport@lists.sourceforge.net,
        linux-arm-msm@vger.kernel.org, sumit.garg@linaro.org,
        vivek.gautam@codeaurora.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 0/2] serial: qcom_geni_serial: Use the FIFOs properly for
 console
Message-ID: <20200627135951.GA1901451@kroah.com>
References: <20200626200033.1528052-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626200033.1528052-1-dianders@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Jun 26, 2020 at 01:00:31PM -0700, Douglas Anderson wrote:
> This series of two patches gets rid of some ugly hacks that were in
> the qcom_geni_serial driver around dealing with a port that was used
> for console output and dealing with a port that was being used for
> kgdb.
> 
> While the character reading/writing code is now slightly more complex,
> it's better to be consistently configuring the serial port the same
> way and doing so avoids some corner cases where the old hacks weren't
> always catching properly.
> 
> This change is slightly larger than it needs to be because I was
> trying not to use global variables in the read/write functions.
> Unfortunately the functions were sometimes called earlycon which
> didn't have any "private_data" pointer set.  I've tried to do the
> minimal change here to have some shared "private_data" that's always
> present, but longer term it wouldn't hurt to see if we could unify
> more.
> 
> Greg / Andy / Bjorn:
> 
> This series of patches is atop the current Qualcomm tree to avoid
> conflicts.  Assuming it looks OK, presumably the best way for it to
> land would be to get an Ack from Greg and then Bjorn or Andy could
> land it.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
