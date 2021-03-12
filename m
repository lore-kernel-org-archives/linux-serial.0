Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381CAC43381
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F38464FD6
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 15:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhCLPFl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 10:05:41 -0500
Received: from smtp.wifcom.cz ([85.207.3.150]:42468 "EHLO smtp.wifcom.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232131AbhCLPFh (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 10:05:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=eaxlabs.cz; s=mail;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:Subject; bh=UwtzL4pDkwTQcSrJ+2meBQW1w8X0nrXrsAaZqyjKa0A=;
        b=c0+fb+RWYoBtShUccUrvuuwXJIkZbe8H4zynmm4WiYTT2OrDz69F37RSVs2ybenTn8pacujGhlyGxSBK+BgQwMfQl6Qks72QXBUuwD9L9mtQD46DJXx0wOW2Ty9ud2ydBrxsNgZLINLkREhbjC7/YAqRhzyz/z1pgBbyK7yPN8w=;
Subject: Re: [PATCH v6 1/2] dt-bindings: serial: Add rx-tx-swap to stm32-usart
From:   Martin DEVERA <devik@eaxlabs.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Le Ray <erwan.leray@st.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        fabrice.gasnier@foss.st.com, linux-arm-kernel@lists.infradead.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
References: <YEsjMJae3cGOdyjG@kroah.com>
 <20210312102713.27776-1-devik@eaxlabs.cz>
 <1615559009.788146.2976052.nullmailer@robh.at.kernel.org>
 <e1cee5c4-8802-bf6b-be06-e453af559e62@eaxlabs.cz>
Message-ID: <f1762dc1-d359-e499-ace7-f957bca519b8@eaxlabs.cz>
Date:   Fri, 12 Mar 2021 16:03:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <e1cee5c4-8802-bf6b-be06-e453af559e62@eaxlabs.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Wif-ss: -2.9 (--)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 3/12/21 3:56 PM, Martin DEVERA wrote:
> On 3/12/21 3:23 PM, Rob Herring wrote:
>> On Fri, 12 Mar 2021 11:27:12 +0100, Martin Devera wrote:
>>> Add new rx-tx-swap property to allow for RX & TX pin swapping.
>>>
>>> Signed-off-by: Martin Devera <devik@eaxlabs.cz>
>>> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
>>> ---
>>> v6:
>>>    - add version changelog
>>> v5:
>>>    - yaml fixes based on Rob Herring comments
>>>      - add serial.yaml reference
>>>      - move compatible from 'then' to 'if'
>>> v3:
>>>    - don't allow rx-tx-swap for st,stm32-uart (suggested
>>>      by Fabrice Gasnier)
>>> v2:
>>>    - change st,swap to rx-tx-swap (suggested by Rob Herring)
>>> ---
>>>   .../devicetree/bindings/serial/st,stm32-uart.yaml  | 29 
>>> ++++++++++++++--------
>>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>>
>> My bot found errors running 'make dt_binding_check' on your patch:
>>
>> yamllint warnings/errors:
>> ./Documentation/devicetree/bindings/serial/st,stm32-uart.yaml:81:12: 
>> [warning] wrong indentation: expected 10 but found 11 (indentation)
>>
>> dtschema/dtc warnings/errors:
>>
>> See https://patchwork.ozlabs.org/patch/1451861
>>
>> This check can fail if there are any dependencies. The base for a patch
>> series is generally the most recent rc1.
>>
>> If you already ran 'make dt_binding_check' and didn't see the above
>> error(s), then make sure 'yamllint' is installed and dt-schema is up to
>> date:
>>
>> pip3 install dtschema --upgrade
>>
> Yoy are right, there is one extra space. But for some reason the check 
> doesn't
> find it: 
Argh... sorry, ignore it please. It seems I removed yamllint.
I see the error now.
