Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5B3C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 12 Jul 2022 12:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiGLMBH (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 12 Jul 2022 08:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiGLL7D (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 12 Jul 2022 07:59:03 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Jul 2022 04:58:39 PDT
Received: from connect2.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 058B013F1E
        for <linux-serial@vger.kernel.org>; Tue, 12 Jul 2022 04:58:37 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect2.vanmierlo.com (Kerio Connect 9.4.0) with ESMTPA;
        Tue, 12 Jul 2022 13:28:17 +0200
MIME-Version: 1.0
Date:   Tue, 12 Jul 2022 13:28:17 +0200
From:   m.brock@vanmierlo.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Subject: Re: [PATCH 4/7] USB: serial: ftdi_sio: Do not reset baudrate to 9600
 on error
In-Reply-To: <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
References: <20220707145354.29705-1-kabel@kernel.org>
 <20220707145354.29705-5-kabel@kernel.org>
 <CAHp75VdamVbTZ2--GXLY6u_O9QmqN5GXTyZQ-NLfWWaEX6bBBw@mail.gmail.com>
Message-ID: <f94731a7bc103f153bea7a405b4fd9fc@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Andy Shevchenko schreef op 2022-07-08 17:51:
>> +                       baud = old_baud ? old_baud : 9600;
> 
> Can be written as
> 
>   baud = old_baud ?: 9600;

That is invalid C !
This is a GCC extension.

Maarten

