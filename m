Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D83C433E6
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 18:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C20F64EF1
	for <linux-serial@archiver.kernel.org>; Wed, 24 Feb 2021 18:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbhBXSO3 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 24 Feb 2021 13:14:29 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:49620 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233896AbhBXSO0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 24 Feb 2021 13:14:26 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5D904481576;
        Wed, 24 Feb 2021 18:13:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (100-96-27-123.trex.outbound.svc.cluster.local [100.96.27.123])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E90974814BC;
        Wed, 24 Feb 2021 18:13:44 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.27.123 (trex/6.0.2);
        Wed, 24 Feb 2021 18:13:45 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Invention-Arch: 0ff916461e74ed27_1614190425247_808837541
X-MC-Loop-Signature: 1614190425246:141840329
X-MC-Ingress-Time: 1614190425246
Received: from pdx1-sub0-mail-a34.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a34.g.dreamhost.com (Postfix) with ESMTP id A2CE68B8E0;
        Wed, 24 Feb 2021 10:13:44 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a34.g.dreamhost.com (Postfix) with ESMTPSA id B22088B601;
        Wed, 24 Feb 2021 10:13:40 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 5F099282D7A;
        Wed, 24 Feb 2021 13:13:39 -0500 (EST)
To:     Johan Hovold <johan@kernel.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
 <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
 <YDUiuLtwRkZ0D0Mi@hovoldconsulting.com>
 <f63df659-6cdf-bba6-f892-1012b98f82e2@IEEE.org>
 <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <4edfb35f-ed81-bade-daee-38a1d7a60a7d@IEEE.org>
 <YDaHEtQCGkiM/pad@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a34
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <2162ce18-32e9-e54c-f266-47febdea11f1@IEEE.org>
Date:   Wed, 24 Feb 2021 13:13:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDaHEtQCGkiM/pad@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMi8yNC8yMSAxMjowNCBQTSwgSm9oYW4gSG92b2xkIHdyb3RlOgo+IFBlcmhhcHMgeW91
IGNhbiBldmVuIGZpZ3VyZSBvdXQgaG93IHRvIHBvbGwgZm9yIGFuIGVtcHR5IFRYIEZJRk8g
ZnJvbQo+IGl0LCB1bmxlc3MgQ2hhcmxlcyBpcyBhYmxlIHRvIHByb3ZpZGUgc29tZSBkZXRh
aWxzIG9uIHRoYXQgc2VwYXJhdGUKPiBtYXR0ZXI/Cj4KSSBwcmVzdW1lIGZyb20gdGhlIGNv
ZGUgYmVsb3csIHRoYXQgd2hlbiB0aGUgZGV2aWNlIGlzIGNsb3NlZCwgYWxsIGRhdGEgd2Fp
dGluZyB0byBzZW5kIGlzIGNsb2JiZXJlZCAoaWYgc28sIHNvIHRoZSBwcm9ibGVtIGlzIHRo
ZSBkcml2ZXIgYW5kIG5vdCB0aGUgZGV2aWNlKQoKSSB3b3VsZCBoYXZlIHRob3VnaHQgdGhh
dCB0aGUgZHJpdmVyIHNob3VsZCBkcmFpbiB0aGUgYnVmZmVycy4gSSBjYW4gc2VlIHRoYXQg
dGhpcyBtaWdodCBiZSBhIHByb2JsZW0gaWYgdGhlcmUgaXMgZmxvdyBjb250cm9sIChpdCBt
YXkgbmV2ZXIgZHJhaW4pIGJ1dCB0aGUgY3VycmVudCBtZXRob2Qgc2VlbXMgcHJldHR5IGJy
dXRhbC4KCgoxMTkgdm9pZCB1c2Jfc2VyaWFsX2dlbmVyaWNfY2xvc2Uoc3RydWN0IHVzYl9z
ZXJpYWxfcG9ydCAqcG9ydCkKMTIwIHsKMTIxwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBs
b25nIGZsYWdzOwoxMjLCoMKgwqDCoMKgwqDCoMKgIGludCBpOwoxMjMKMTI0wqDCoMKgwqDC
oMKgwqDCoCBpZiAocG9ydC0+YnVsa19vdXRfc2l6ZSkgewoxMjXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmb3IgKGkgPSAwOyBpIDwgQVJSQVlfU0laRShwb3J0LT53cml0
ZV91cmJzKTsgKytpKQoxMjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgdXNiX2tpbGxfdXJiKHBvcnQtPndyaXRlX3VyYnNbaV0pOwoxMjcKMTI4
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl9sb2NrX2lycXNhdmUoJnBv
cnQtPmxvY2ssIGZsYWdzKTsKMTI5wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
a2ZpZm9fcmVzZXRfb3V0KCZwb3J0LT53cml0ZV9maWZvKTsKMTMwwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywg
ZmxhZ3MpOwoxMzHCoMKgwqDCoMKgwqDCoMKgIH0KMTMywqDCoMKgwqDCoMKgwqDCoCBpZiAo
cG9ydC0+YnVsa19pbl9zaXplKSB7CjEzM8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGZvciAoaSA9IDA7IGkgPCBBUlJBWV9TSVpFKHBvcnQtPnJlYWRfdXJicyk7ICsraSkK
MTM0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVz
Yl9raWxsX3VyYihwb3J0LT5yZWFkX3VyYnNbaV0pOwoxMzXCoMKgwqDCoMKgwqDCoMKgIH0K
MTM2IH0KCg==
