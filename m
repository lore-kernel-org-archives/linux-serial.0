Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CFEBC433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08B9420715
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728753AbgERSlk (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728514AbgERSlk (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 14:41:40 -0400
Received: from mail.bugwerft.de (mail.bugwerft.de [IPv6:2a03:6000:1011::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 43371C061A0C;
        Mon, 18 May 2020 11:41:40 -0700 (PDT)
Received: from [192.168.178.106] (pd95ef567.dip0.t-ipconnect.de [217.94.245.103])
        by mail.bugwerft.de (Postfix) with ESMTPSA id 1999940A757;
        Mon, 18 May 2020 18:38:43 +0000 (UTC)
Subject: Re: [PATCH 1/4] dt-bindings: sc16is7xx: Add flag to activate IrDA
 mode
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        pascal.huerst@gmail.com
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-2-daniel@zonque.org> <20200518180853.GA18566@bogus>
From:   Daniel Mack <daniel@zonque.org>
Message-ID: <0494dbe1-81ad-493c-6eb0-a463a5604309@zonque.org>
Date:   Mon, 18 May 2020 20:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518180853.GA18566@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 5/18/20 8:08 PM, Rob Herring wrote:
> On Fri, May 08, 2020 at 04:37:54PM +0200, Daniel Mack wrote:
>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>
>> This series of uart controllers is able to work in IrDA mode.
>> This adds a flag to the device tree to enable that feature if needed.
>>
>> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>> index c1091a923a89..9317c320c82c 100644
>> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>> @@ -21,6 +21,8 @@ Optional properties:
>>    the second cell is used to specify the GPIO polarity:
>>      0 = active high,
>>      1 = active low.
>> +- linux,irda-mode-port-0: Use IrDA mode on port #0
>> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)
>>  
>>  Example:
>>          sc16is750: sc16is750@51 {
>> @@ -55,6 +57,8 @@ Optional properties:
>>    the second cell is used to specify the GPIO polarity:
>>      0 = active high,
>>      1 = active low.
>> +- linux,irda-mode-port-0: Use IrDA mode on port #0
>> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port devices only)
> 
> How about an array of 1 or 2 entries instead?

Yes, that would be an alternative. We just weren't sure what type the
elements of the array would have. Could you point to an existing example?


Thanks,
Daniel
