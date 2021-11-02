Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E545C433FE
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 071B060F24
	for <linux-serial@archiver.kernel.org>; Tue,  2 Nov 2021 18:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhKBSKh (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 2 Nov 2021 14:10:37 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:36018 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234823AbhKBSKh (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 2 Nov 2021 14:10:37 -0400
X-Greylist: delayed 540 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Nov 2021 14:10:37 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1635875757;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=WFiiP4mZDwf8eUQXw19endczGOXcmmLu2bVNQhEO7sY=;
    b=fSTNzWP7c55BolH66BoY5jCgUJo62BCwycqssAWw64ZNlJkOsVLgrhFzowv4emq/My
    c5L5x7RnNpCeqnVAvUXB47+SP38PP10tbMUyiYwWMbO1YrjgsJ80jMULpkfF4dLPA78O
    Ok7lsopFfzmI2xnDcnJkpGdLqnPbQijsuKOmnTxGCwfLx2QhbQ+f4qHv5oT1QEFj6d7/
    mLJfcjVGqjD7RdDEhajXyXn09thSsH8XwvISw2ynjHr90p5sQkrNdXpa20XJZzugaLkk
    sHp99MTo+5OLjjBig2LeQe3qRSDDLnLH3B0LpTaTj5BB1fBj94Bae+W9bt6vqB9KlAOG
    FzZA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/9ZoJyEZEuoUXlOQl3ihigFESvedWagVA=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.178.47]
    by smtp.strato.de (RZmta 47.34.1 AUTH)
    with ESMTPSA id f02274xA2HtvsAI
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
    for <linux-serial@vger.kernel.org>;
    Tue, 2 Nov 2021 18:55:57 +0100 (CET)
Message-ID: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
Date:   Tue, 2 Nov 2021 18:55:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
To:     linux-serial@vger.kernel.org
Content-Language: en-US
From:   Jochen <jochen@mades.net>
Subject: Extending serial port linux driver to toggle RS485 direction pin
 (GPIO)
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

I have a RS485 hardware shield connected to the hardware uart of a raspberry PI3, where you have to toggle the RS485 driver DIRECTION-pin from within your software during write-commands. The DIR-Pin is connected to a GPIO pin of the PI.

As I do not want to do that in every application software, I thought it could be a good idea to enhance the serial-port driver (locally on my PI) with that functionality. Looking to the sources of amba-pl011.c I thought the "pl011_write"-function could be the right place to do so....but to be honest it seems not to work

Could you please give me a hint where to do that best in the serial port driver? (or is there already a RS485 driver with configurable Dir-GPIO-pin).
Is there a documentation of the serial-port architecture available which could help me to solve my problem?

Bests
Jochen

