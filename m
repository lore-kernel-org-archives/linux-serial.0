Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B7C433EF
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B66F661AA2
	for <linux-serial@archiver.kernel.org>; Tue, 16 Nov 2021 11:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbhKPLux (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 16 Nov 2021 06:50:53 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:25179 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234990AbhKPLuT (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 16 Nov 2021 06:50:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1637063240;
    s=strato-dkim-0002; d=mades.net;
    h=Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=iXgbtXGbDfC25xwcraJSjgd3+g8VZzfKKHi5co+LeCw=;
    b=IJHUkadWZXJ5q+QFlmVfdiXKaKCHIBiOji8RKfi3EurrKHIHRObhHL+2yXwUgC01oW
    FMdSqXlT7xLbsWRPuMoNWYzEYuO7MsF+FNQC/tcK5QGKQxvivA/+im6oR98Uoqzv/PON
    XUMVXFue3aQdYGx9qM5f29DOheh004OHg1Tt9KlQaYF7WTFTMAnNzOwipNH35ZVB5u5c
    os7npnelMyzHn4ibwv3h7doah7QZglJonv80uND2t5OUKy/M9UX1ocN9w/CAkx4kZzv/
    mvBBfMtLOiUOhwgTUXRgvUihK1yDTB6iE6UVhvtSGJCqBIgsTasE4B3e/+dT9xIfsx/w
    snjg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":JmMHfUWmW/JCZ5q3rSbjoqaGiJoG2nOuw/BEppjnAC9QlFFS7UbO3fgyYpMDJqZr"
X-RZG-CLASS-ID: mo00
Received: from oxapp04-01.back.ox.d0m.de
    by smtp-ox.front (RZmta 47.34.5 AUTH)
    with ESMTPSA id K04312xAGBlJYRG
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
    Tue, 16 Nov 2021 12:47:19 +0100 (CET)
Date:   Tue, 16 Nov 2021 12:47:19 +0100 (CET)
From:   Jochen Mades <jochen@mades.net>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "sistik@3ksolutions.sk" <sistik@3ksolutions.sk>,
        linux-serial@vger.kernel.org
Message-ID: <1972392418.278738.1637063239577@webmail.strato.com>
In-Reply-To: <YZNrqFGjTbu77b/n@kroah.com>
References: <731e2516-9703-8c9a-7e56-e7e7b362de94@mades.net>
 <YYGKbfvFki8VN4HN@kroah.com>
 <236176398.157022.1637045032216@webmail.strato.com>
 <YZNrqFGjTbu77b/n@kroah.com>
Subject: Re: Extending serial port linux driver to toggle RS485 direction
 pin (GPIO)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.5-Rev27
X-Originating-Client: open-xchange-appsuite
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


> I do not remember if these patches have been resubmitted or not, check
> the current kernel tree for details.
> 
> If not, then obviously they need to be fixed up based on the review
> comments made.
> 
> thanks,
> 
> greg k-h

In the current kernel tree there is nothing to find about these patches.
Do you know about any alternatives?

Jochen

P.S.: is this the posting style you prefer?
