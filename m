Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MONEY_NOHTML,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30E0C43381
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B098864ED0
	for <linux-serial@archiver.kernel.org>; Tue,  2 Feb 2021 00:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhBBAcB (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 1 Feb 2021 19:32:01 -0500
Received: from mail.micronovasrl.com ([212.103.203.10]:47290 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbhBBAcB (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 1 Feb 2021 19:32:01 -0500
Received: from mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1])
        by mail.micronovasrl.com (Postfix) with ESMTP id 5E683B04847
        for <linux-serial@vger.kernel.org>; Tue,  2 Feb 2021 01:31:19 +0100 (CET)
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=micronovasrl.com;
         h=content-transfer-encoding:content-language:content-type
        :content-type:in-reply-to:mime-version:user-agent:date:date
        :message-id:from:from:references:to:subject:subject; s=dkim; t=
        1612225878; x=1613089879; bh=rhiVnujukiPvzaErM/MEb08eoHPbwq0Lwyc
        mjO9W3QI=; b=T1pv4HOLQMwtDZvVh0nVixyYcI4oW/FvBZX8GtGyvElzmFjOVvj
        WlDfxn/osTT7W9kAHX1lGiNg5w6Jwex+TI/tmR9LapCBm0Utvv+65NQ3cSBetxwr
        qCxh4Z10bu63AvbwdYXe/L+UTtTv/CRca+Z01zJ3v51QMP1Uwpii2WUg=
X-Virus-Scanned: Debian amavisd-new at mail.micronovasrl.com
Received: from mail.micronovasrl.com ([127.0.0.1])
        by mail.micronovasrl.com (mail.micronovasrl.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id TGPe0-QFj-Oi for <linux-serial@vger.kernel.org>;
        Tue,  2 Feb 2021 01:31:18 +0100 (CET)
Received: from [192.168.50.85] (146-241-184-239.dyn.eolo.it [146.241.184.239])
        by mail.micronovasrl.com (Postfix) with ESMTPSA id F2C64B047FF;
        Tue,  2 Feb 2021 01:31:17 +0100 (CET)
Subject: Re: [PATCH v3 5/5] serial: 8250_dw: add em485 support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com,
        matwey.kornilov@gmail.com, lukas@wunner.de,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        christoph.muellner@theobroma-systems.com,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
References: <20200517215610.2131618-1-heiko@sntech.de>
 <20200517215610.2131618-6-heiko@sntech.de>
 <20200518152103.GI1634618@smile.fi.intel.com>
From:   Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <1f7881b5-f900-dbbe-3f8d-f990d2bdf5a7@micronovasrl.com>
Date:   Tue, 2 Feb 2021 01:31:17 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20200518152103.GI1634618@smile.fi.intel.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Andy,

Il 18/05/2020 17:21, Andy Shevchenko ha scritto:
> On Sun, May 17, 2020 at 11:56:10PM +0200, Heiko Stuebner wrote:
>> From: Giulio Benetti <giulio.benetti@micronovasrl.com>
>>
>> Need to use rs485 transceiver so let's use existing em485 485 emulation
>> layer on top of 8250.
>>
>> Add rs485_config callback to port and uses the standard em485 start and
>> stop helpers.
> 
> Would it prevent to use native RS485 support?

8250_dw doesn't have a native RS485 support, do you mean using hardware
RTS assertion? Anyway at the moment it's not present. This would be the
first rs485 support added to 8250_dw.

Best regards
-- 
Giulio Benetti
CTO

MICRONOVA SRL
Sede: Via A. Niedda 3 - 35010 Vigonza (PD)
Tel. 049/8931563 - Fax 049/8931346
Cod.Fiscale - P.IVA 02663420285
Capitale Sociale ¤ 26.000 i.v.
Iscritta al Reg. Imprese di Padova N. 02663420285
Numero R.E.A. 258642

> ...
> 
>>   	p->serial_out	= dw8250_serial_out;
>>   	p->set_ldisc	= dw8250_set_ldisc;
>>   	p->set_termios	= dw8250_set_termios;
>> +	p->rs485_config = serial8250_em485_config;
>> +	up->rs485_start_tx = serial8250_em485_start_tx;
>> +	up->rs485_stop_tx = serial8250_em485_stop_tx;
> 

