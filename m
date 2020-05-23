Return-Path: <SRS0=TiTh=7F=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A0FC433E0
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 12:27:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83867207F9
	for <linux-serial@archiver.kernel.org>; Sat, 23 May 2020 12:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731335AbgEWM1b (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 23 May 2020 08:27:31 -0400
Received: from mail.bugwerft.de ([46.23.86.59]:51568 "EHLO mail.bugwerft.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731291AbgEWM1a (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sat, 23 May 2020 08:27:30 -0400
Received: from [192.168.178.106] (pd95eff8e.dip0.t-ipconnect.de [217.94.255.142])
        by mail.bugwerft.de (Postfix) with ESMTPSA id A3325420697;
        Sat, 23 May 2020 12:24:28 +0000 (UTC)
Subject: Re: [PATCH v3 0/6] sc16is7xx: IrDA mode and threaded IRQs
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        robh+dt@kernel.org, jslaby@suse.com, jringle@gridpoint.com,
        m.brock@vanmierlo.com, pascal.huerst@gmail.com
References: <20200521091152.404404-1-daniel@zonque.org>
 <20200522090755.GA1189521@kroah.com>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <8a69bae2-8080-d0b0-bba7-813d9b8b0af2@zonque.org>
Date:   Sat, 23 May 2020 14:27:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522090755.GA1189521@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/22/20 11:07 AM, Greg KH wrote:
> On Thu, May 21, 2020 at 11:11:46AM +0200, Daniel Mack wrote:
>> This is v3 of the series.
>>
>> v3:
>>
>>  * Add my s-o-b to the first two patches
>>
>> v2:
>>
>>  * Change single bool properties into an array
>>    (suggested by Rob Herring)
>>  * Add a patch first try TRIGGER_LOW and SHARED interrupts, and then
>>    fall back to FALLING edge if the IRQ controller fails to provide the
>>    former (suggested by Maarten Brock)
>>  * Add a patch to check for the device presence
>>
>> Daniel Mack (4):
>>   sc16is7xx: Always use falling edge IRQ
>>   sc16is7xx: Use threaded IRQ
>>   sc16is7xx: Allow sharing the IRQ line
>>   sc16is7xx: Read the LSR register for basic device presence check
>>
>> Pascal Huerst (2):
>>   dt-bindings: sc16is7xx: Add flag to activate IrDA mode
>>   sc16is7xx: Add flag to activate IrDA mode
> 
> As I have to wait for the DT addition to be reviewed before applying the
> first 2 patches here, I've taken the other 4 instead at the moment.  If
> you could rebase the first two and resend when they get acked, so that I
> could apply them, that would be great.

Sure, will do. Thanks :)


Daniel
