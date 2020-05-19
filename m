Return-Path: <SRS0=bJiX=7B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA53C433E0
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5FF0207C4
	for <linux-serial@archiver.kernel.org>; Tue, 19 May 2020 12:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbgESMCI (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 19 May 2020 08:02:08 -0400
Received: from fieber.vanmierlo.com ([84.243.197.177]:56834 "EHLO
        kerio9.vanmierlo.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726949AbgESMCI (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 19 May 2020 08:02:08 -0400
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by kerio9.vanmierlo.com (Kerio Connect 9.2.12 patch 1) with ESMTPA;
        Tue, 19 May 2020 14:01:32 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 19 May 2020 14:01:32 +0200
From:   Maarten Brock <m.brock@vanmierlo.com>
To:     Daniel Mack <daniel@zonque.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, pascal.huerst@gmail.com,
        linux-serial-owner@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: sc16is7xx: Add flag to activate IrDA
 mode
In-Reply-To: <0494dbe1-81ad-493c-6eb0-a463a5604309@zonque.org>
References: <20200508143757.2609740-1-daniel@zonque.org>
 <20200508143757.2609740-2-daniel@zonque.org> <20200518180853.GA18566@bogus>
 <0494dbe1-81ad-493c-6eb0-a463a5604309@zonque.org>
Message-ID: <d959a9c97d64f38ea6335ad372ea541d@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
User-Agent: Roundcube Webmail/1.3.3
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 2020-05-18 20:41, Daniel Mack wrote:
> On 5/18/20 8:08 PM, Rob Herring wrote:
>> On Fri, May 08, 2020 at 04:37:54PM +0200, Daniel Mack wrote:
>>> From: Pascal Huerst <pascal.huerst@gmail.com>
>>> 
>>> This series of uart controllers is able to work in IrDA mode.
>>> This adds a flag to the device tree to enable that feature if needed.
>>> 
>>> Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
>>> ---
>>>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>> 
>>> diff --git 
>>> a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt 
>>> b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> index c1091a923a89..9317c320c82c 100644
>>> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
>>> @@ -21,6 +21,8 @@ Optional properties:
>>>    the second cell is used to specify the GPIO polarity:
>>>      0 = active high,
>>>      1 = active low.
>>> +- linux,irda-mode-port-0: Use IrDA mode on port #0
>>> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port 
>>> devices only)
>>> 
>>>  Example:
>>>          sc16is750: sc16is750@51 {
>>> @@ -55,6 +57,8 @@ Optional properties:
>>>    the second cell is used to specify the GPIO polarity:
>>>      0 = active high,
>>>      1 = active low.
>>> +- linux,irda-mode-port-0: Use IrDA mode on port #0
>>> +- linux,irda-mode-port-1: Use IrDA mode on port #1 (for dual-port 
>>> devices only)
>> 
>> How about an array of 1 or 2 entries instead?

I like this idea.

> Yes, that would be an alternative. We just weren't sure what type the
> elements of the array would have. Could you point to an existing 
> example?

I think you need device_property_read_u8_array(). I can only find
device_property_read_u32_array() used in the serial drivers tree in 
serial_core.c,
but that should be similar.

Maarten

