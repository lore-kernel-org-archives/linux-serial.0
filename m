Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BB9C433E0
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CB164EE3
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbhBBA3V (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Feb 2021 19:29:21 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:47072 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbhBBA3U (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Feb 2021 19:29:20 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 0A4EDB04814
        for <linux-serial@vger.kernel.org>; Tue,  2 Feb 2021 01:28:36 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1612225715; x=1613089716; bh=JxP7LmBQXWp8+fn4nnMWKgOwLEm0OV0hIqn
        35rpYk5c=; b=W7FVB/oVs6yI3GQPrTJReWVG71GGzEnbDuiZ21lTiVyDtVtW9UO
        glAGdOhfTItxXAwcXhG8cg9Ak32gqYWP+IwAzYVBlgYw9zutcOoxsVuGof3j4wuE
        sypwoOQtA6Nq6bALJLMLl3tFq888nH0EaKgvpPTFvvu/OL90jmWzPzXg=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lL8A3cjfaqIt for <linux-serial@vger.kernel.org>;
        Tue,  2 Feb 2021 01:28:35 +0100 (CET)
Received: from [192.168.50.85] (146-241-184-239.dyn.eolo.it [146.241.184.239])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id 034A5B047FF;
        Tue,  2 Feb 2021 01:28:33 +0100 (CET)
Subject: Re: [PATCH 0/3] Handle UART without interrupt on TEMT using em485
To:     Eric Tremblay <etremblay@distech-controls.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        andriy.shevchenko@linux.intel.com, matwey.kornilov@gmail.com,
        lukas@wunner.de, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        heiko.stuebner@theobroma-systems.com
References: <5FC36FF8-8F09-4B82-92C0-BE5E0AA2C117@micronovasrl.com>
 <f480b022-0dbb-7dba-e426-2882683ec54b@distech-controls.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <ab49f27c-50ca-5d29-e3a4-ff47acdd47ce@micronovasrl.com>
Date:   Tue, 2 Feb 2021 01:28:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <f480b022-0dbb-7dba-e426-2882683ec54b@distech-controls.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Il 02/02/2021 01:02, Eric Tremblay ha scritto:
> On 2021-01-28 7:12 p.m., Giulio Benetti wrote:
>> Hi Eric,
>>
>>> Il giorno 29 gen 2021, alle ore 00:37, Eric Tremblay <etremblay@distech-controls.com> ha scritto:
>>>
>>> ﻿The series is mainly about the support of 8250 UART without TEMT
>>> interrupt. I saw that there was some development in the past but
>>> it was never merged. Since the last discussion were quite some
>>> time ago, I was not sure if I should post a v4 over the
>>> last v3 or start from scratch so I decided to post a new patch. Please
>>> advice if I should have done the reverse.
>> Please keep my and Heiko’s SoB and add your SoB too describing between [ ] what Heiko has done and what you’ve done.
>> For example:
>> SoB: Giulio
>> SoB: Heiko
>> [Heiko: ...]
>> SoB Eric
>> [Eric: improved timeout etc.]
> 
> I will add them in the next version, thanks for mentioning it.

Thank you

>>
>>> The approach is a little different from the last proposed patch which was
>>> doing using a polling at 100us. I tought that it could be really long on
>>> some fast baudrate and really not that long on slow baudrate. The current
>>> approach is to calculate the time of a bytes when the settings are changed.
>>> When we get the interrupt for the empty FIFO, it's the longer it can take
>>> to empty the shift register.
>> Good idea.
>>
>>> The other two patches are to use that features with the PORT_16550A_FSL64
>>> found on some chip like the LS1043A.
>> Do you mind to add my 8250_dw patch that was originally part of this patchset? I had to send it
>> soon, you’ve preceded me :-)
> 
> I think there was still a comment pending on that patch. I think you should resubmit
> since I think it's a bit out-of-scope for me.

Ah yes, you're correct, I will submit it then.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale € 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

>>
>> Thank you
>> Best regards
>> Giulio
>>
>>> Thanks
>>>
>>> Eric Tremblay (3):
>>> serial: 8250: Handle UART without interrupt on TEMT using em485
>>> serial: 8250: add compatible for fsl,16550-FIFO64
>>> serial: 8250: remove UART_CAP_TEMT on PORT_16550A_FSL64
>>>
>>> drivers/tty/serial/8250/8250.h            |  1 +
>>> drivers/tty/serial/8250/8250_bcm2835aux.c |  2 +-
>>> drivers/tty/serial/8250/8250_of.c         |  5 ++
>>> drivers/tty/serial/8250/8250_omap.c       |  2 +-
>>> drivers/tty/serial/8250/8250_port.c       | 89 ++++++++++++++++++++++-
>>> include/linux/serial_8250.h               |  2 +
>>> 6 files changed, 98 insertions(+), 3 deletions(-)
>>>
>>> -- 
>>> 2.17.1
> 
> 

