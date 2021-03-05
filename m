Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B3F0C433E0
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 09:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D9A64FD6
	for <linux-serial@archiver.kernel.org>; Fri,  5 Mar 2021 09:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbhCEJgw (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 5 Mar 2021 04:36:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:40212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhCEJgU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 5 Mar 2021 04:36:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2274864E59;
        Fri,  5 Mar 2021 09:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614936980;
        bh=wU5YAKg/MALtqoNQ/Vo+rxa9yxOrrqGUYmvXORD2ePM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bWePa1BdNz+DtFOVIwOfPd/q1ADauj9jANLP31iN+4KUrV+e2TtUdNINjWxnV6B2c
         6+PmgzI3DdBAsC6ZnHwrW8kd4itqmS2+1mZLEKbh0KQm2tzl2EwdWmpM+LHubT3Eax
         oKskemYmn6jeg+4GV3aafQOoSaS6Imj7ocVjE4T497UNZzkwJD4ufE7Y4Dsu3vExoY
         j5TfRSMscfyTqbkSfTYHc0BozmJHXUGffKIRmMFjxvDsSHs0BN5FjBQFuVZKPmrtmJ
         0R4Jj8fbouBgaZt7PI2l8wMNC/E0/tjVSrMG7ebukZtvKyv9upolvxcMHr3OHjmcdS
         wG8y31OhP7rlw==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1lI6ss-0000Jq-F9; Fri, 05 Mar 2021 10:36:34 +0100
Date:   Fri, 5 Mar 2021 10:36:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Charles Yeh <charlesyeh522@gmail.com>
Cc:     "Michael G. Katzmann" <michaelk@ieee.org>,
        =?utf-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <YEH7okblCx8+Odxn@hovoldconsulting.com>
References: <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Mar 05, 2021 at 05:32:23PM +0800, Charles Yeh wrote:
> 110 bps is not the standard Baud rate,
> PL2303TA don't work with the current Linux driver (d5 0e 00 80), It
> needs to "a8 a6 01 80"

Ok, thanks for confirming. Then we should be able to fix this up based
on Michael's findings.

> Johan Hovold <johan@kernel.org> 於 2021年2月25日 週四 上午1:00寫道：
> 
> > But can you confirm that your PL2303TA works with the current Linux
> > driver at 110 Bd (and doesn't need the alternate divisor encoding)?

Johan
