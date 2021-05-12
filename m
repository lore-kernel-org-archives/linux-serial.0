Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB24C433ED
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 09:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27CFD613F3
	for <linux-serial@archiver.kernel.org>; Wed, 12 May 2021 09:42:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhELJnw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 12 May 2021 05:43:52 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:47681 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbhELJnv (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 12 May 2021 05:43:51 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 8131C22256;
        Wed, 12 May 2021 11:42:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1620812562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7nbJoxdcCMrYIOrc92gWt54SLeKp48Z204OCdEftvl0=;
        b=HUG8c5HPusvlbffhInmTzgSsB9Zk1zS+jfhFM27xyPWX/6io6+QSUuDX9HgyG9apKZe398
        cfLTDZ1me2+a1Tv1Bnh25YSTk+eMD4k56OA/ZXN5wVFYkCFCHY9EnYUFBKyd24hA5jyGhl
        bAlITeQeOlyrHrjqFzytgeNlR5Kq8h4=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 May 2021 11:42:42 +0200
From:   Michael Walle <michael@walle.cc>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 3/8] serial: fsl_lpuart: don't restore interrupt state in
 ISR
In-Reply-To: <YJufDcQ5l/yz4MF1@hovoldconsulting.com>
References: <20210511200148.11934-1-michael@walle.cc>
 <20210511200148.11934-4-michael@walle.cc>
 <YJufDcQ5l/yz4MF1@hovoldconsulting.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <875e14fc65df5612f9bee6aeaa33b2a2@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Am 2021-05-12 11:25, schrieb Johan Hovold:
> On Tue, May 11, 2021 at 10:01:43PM +0200, Michael Walle wrote:
>> Since commit 81e2073c175b ("genirq: Disable interrupts for force
>> threaded handlers") interrupt handlers that are not explicitly 
>> requested
>> as threaded are always called with interrupts disabled and there is no
>> need to save the interrupt state when taking the port lock.
> 
> Since you've copied the above words verbatim from commit 75f4e830fa9c
> ("serial: do not restore interrupt state in sysrq helper") I'd expect
> you to use quotes or at least refer to the commit you copied the
> rationale from.

Sure, sorry.

>> This is a preparation for sysrq handling which uses
>> uart_unlock_and_check_sysrq();

-michael
