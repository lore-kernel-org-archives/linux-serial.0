Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B53C433DB
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 02:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A79E64E04
	for <linux-serial@archiver.kernel.org>; Mon, 22 Feb 2021 02:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhBVCP4 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 21 Feb 2021 21:15:56 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:29232 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230080AbhBVCPz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 21 Feb 2021 21:15:55 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id F03DC681231
        for <linux-serial@vger.kernel.org>; Mon, 22 Feb 2021 02:15:08 +0000 (UTC)
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (100-96-18-24.trex.outbound.svc.cluster.local [100.96.18.24])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 5B40C681429
        for <linux-serial@vger.kernel.org>; Mon, 22 Feb 2021 02:15:08 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.24 (trex/6.0.2);
        Mon, 22 Feb 2021 02:15:08 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Bubble-Cold: 20ca1d7675e77ea5_1613960108593_1269546919
X-MC-Loop-Signature: 1613960108593:246915781
X-MC-Ingress-Time: 1613960108593
Received: from pdx1-sub0-mail-a46.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTP id 2380F7FE13
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 18:15:08 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a46.g.dreamhost.com (Postfix) with ESMTPSA id F38DE7F59A
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 18:15:07 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 8DC37282D7A
        for <linux-serial@vger.kernel.org>; Sun, 21 Feb 2021 21:15:06 -0500 (EST)
X-DH-BACKEND: pdx1-sub0-mail-a46
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
To:     linux-serial@vger.kernel.org
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
Date:   Sun, 21 Feb 2021 21:15:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

ClNvIG9uIG1vcmUgaW52ZXN0aWdhdGlvbiBhbmQgbWFueSBob3VycyBvZiB0cmlhbCBhbmQg
ZXJyb3IgSSBoYXZlIGRldGVybWluZWQgdGhlIGNvcnJlY3QgZm9ybXVhIGZvciB0aGUgbm9u
LXN0YW5kYXJkIHJhdGVzIHdpdGggdGhpcyBQcm9saWZpYyAyMzAzLgpUaGVyZSBhcmUgZm91
ciBieXRlcyB1c2VkIHRvIHNlbmQgdGhlIGJhdWQgcmF0ZS4gV2hlbiBub3QgdXNpbmcgdGhl
ICdzdGFuZGFyZCcgcmF0ZXMsIHRoZSBMaW51cyBkcml2ZXIgc2V0cyBieXRlIDMgdG8gMHg4
MCBhbmQgYnl0ZXMgMSBhbmQgMCBob2xkIHRoZSBkaXZpc29yIG9mIHRoZSBjbG9jayAoMTJN
SHogKiAzMikuClRoaXMgZGl2aXNvciBpcyBlbmNvZGVkIGluIGEgc3BlY2lhbCB3YXkuIFRo
ZSAnZXhwb25lbnQnIChsb2cgNCkgYW5kIHRoZSBtYW50aXNzYS4gVGhpcyBpcyBjYWxjdWxh
dGVkIGJ5IGRpdmlkaW5nIHRoZSBkaXZpc29yIGJ5IDQgdW50aWwgaXQgaXMgbGVzcyB0aGFu
IDUxMiAodGhlIG51bWJlciBvZiB0aW1lcyB5b3UgY2FuCmRvIHRoaXMgaXMgdGhlIGV4cG9u
ZW50KS4gZSB0aGVuIGdvZXMgaW4gYml0cyAxLDIgYW5kIDMgb2YgYnl0ZSAxIHdpdGggdGhl
IE1TQml0IG9mIHRoZSBtYW50aXNzYSBpbiBiaXQgMCBvZiBieXRlIDEuIEJ5dGUgMCBob2xk
cyB0aGUgbG93ZXIgOCBiaXRzIG9mIHRoZSBtYW50aXNzYS4KClRoaXMgZG9lcyBub3Qgd29y
ayBvbiB0aGUgZGV2aWNlIEkgaGF2ZSBVU0IgUElEL1ZJRC9SRVYgaXMgMDY3MyAvIDIzMDMv
My4wMC4gSW5zdGVhZC4uLnRoZSBjYWxjdWxhdGlvbiB1c2VzIDEwMjQgaW5zdGVhZCBvZiA1
MTIgaW4gdGhlIG1ldGhvZCBhYm92ZSBhbmQgdGhlIGV4cG9uZW50IGlzIGluIGJ5dGUgMSBi
aXRzIDcsNiY1ICh0aGUgdG9wIDIgYml0cyBvZiB0aGUgbWFudGlzc2EgYXJlIGluIGJpdHMg
MCBhbmQgMSkuCkkgdGVzdGVkIHRoaXMgb24gYWxsIGJhdWQgcmF0ZXMgdGhhdCBzdHR5IHdp
bGwgYWxsb3cgdGhhdCBhcmUgbm90ICdzdGFuZGFyZCcgYW5kIGl0IHdvcmtzLiAoNTAsIDEx
MCAuLi4uIDMwMDAwMDApLgoKVGhlIGNoYW5nZWQgcm91dGluZSBpcyBiZWxvdy4gSSBwcmVz
dW1lIHRoZSBvcmlnaW5hbCBkcml2ZXIgd29ya2VkIHNvIHBlcmhhcHMgdGhpcyBkZXZpY2Ug
aXMgYSBuZXcgdmFyaWFudCB3aXRoIHRoZSBzYW1lIFVTQiBWSUQvUElELgoKTWljaGFlbAoK
c3RhdGljIHNwZWVkX3QgcGwyMzAzX2VuY29kZV9iYXVkX3JhdGVfZGl2aXNvcih1bnNpZ25l
ZCBjaGFyIGJ1Zls0XSwKwqDCoMKgIMKgwqDCoCDCoMKgwqAgwqDCoMKgIMKgwqDCoCDCoMKg
wqAgwqDCoMKgIMKgwqDCoCBzcGVlZF90IGJhdWQpCnsKwqDCoMKgIHVuc2lnbmVkIGludCBi
YXNlbGluZSwgbWFudGlzc2EsIGV4cG9uZW50OwrCoMKgwqAgLyoKwqDCoMKgIMKgKiBBcHBh
cmVudGx5IHRoZSBmb3JtdWxhIGlzOgrCoMKgwqAgwqAqwqDCoCBiYXVkcmF0ZSA9IDEyTSAq
IDMyIC8gKG1hbnRpc3NhICogNF5leHBvbmVudCkKwqDCoMKgIMKgKiB3aGVyZQrCoMKgwqAg
wqAqwqDCoCBtYW50aXNzYSA9IGJ1Zls4OjBdCsKgwqDCoCDCoCrCoMKgIGV4cG9uZW50ID0g
YnVmWzExOjldCsKgwqDCoMKgwqDCoMKgwqAgKgrCoMKgwqDCoMKgwqDCoMKgICogTWljaGFl
bCBLYXR6bWFubjogQXQgbGVhc3QgdmVyc2lvbnMgb2YgdGhlIGNoaXAgVklEIDB4MDY3YiBQ
SUQgMHgyMzAzIGJjZERldmljZSAzLjAwCsKgwqDCoMKgwqDCoMKgwqAgKsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1c2VzIG1hbnRpc3NhID0gYnVmWzk6MF0KwqDC
oMKgIMKgKsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZXhwb25lbnQgPSBidWZbMTU6MTNdCsKgwqDCoCDCoCovCsKgwqDCoCBiYXNlbGluZSA9IDEy
MDAwMDAwICogMzI7CsKgwqDCoCBtYW50aXNzYSA9IGJhc2VsaW5lIC8gYmF1ZDsKwqDCoMKg
IGlmIChtYW50aXNzYSA9PSAwKQrCoMKgwqAgwqDCoMKgIG1hbnRpc3NhID0gMTvCoMKgwqAg
LyogQXZvaWQgZGl2aWRpbmcgYnkgemVybyBpZiBiYXVkID4gMzIqMTJNLiAqLwrCoMKgwqAg
ZXhwb25lbnQgPSAwOwojdW5kZWYgT1JJR0lOQUwKI2lmZGVmIE9SSUdJTkFMCsKgwqDCoCB3
aGlsZSAobWFudGlzc2EgPj0gNTEyKSB7CsKgwqDCoCDCoMKgwqAgaWYgKGV4cG9uZW50IDwg
NykgewrCoMKgwqAgwqDCoMKgIMKgwqDCoCBtYW50aXNzYSA+Pj0gMjvCoMKgwqAgLyogZGl2
aWRlIGJ5IDQgKi8KwqDCoMKgIMKgwqDCoCDCoMKgwqAgZXhwb25lbnQrKzsKwqDCoMKgIMKg
wqDCoCB9IGVsc2UgewrCoMKgwqAgwqDCoMKgIMKgwqDCoCAvKiBFeHBvbmVudCBpcyBtYXhl
ZC4gVHJpbSBtYW50aXNzYSBhbmQgbGVhdmUuICovCsKgwqDCoCDCoMKgwqAgwqDCoMKgIG1h
bnRpc3NhID0gNTExOwrCoMKgwqAgwqDCoMKgIMKgwqDCoCBicmVhazsKwqDCoMKgIMKgwqDC
oCB9CsKgwqDCoCB9CsKgwqDCoCBidWZbM10gPSAweDgwOwrCoMKgwqAgYnVmWzJdID0gMDsK
wqDCoMKgIGJ1ZlsxXSA9IGV4cG9uZW50IDw8IDEgfCBtYW50aXNzYSA+PiA4OwrCoMKgwqAg
YnVmWzBdID0gbWFudGlzc2EgJiAweGZmOwojZWxzZQrCoMKgwqAgd2hpbGUgKG1hbnRpc3Nh
ID49IDEwMjQpIHsKwqDCoMKgIMKgwqDCoCBpZiAoZXhwb25lbnQgPCA3KSB7CsKgwqDCoCDC
oMKgwqAgwqDCoMKgIG1hbnRpc3NhID4+PSAyO8KgwqDCoCAvKiBkaXZpZGUgYnkgNCAqLwrC
oMKgwqAgwqDCoMKgIMKgwqDCoCBleHBvbmVudCsrOwrCoMKgwqAgwqDCoMKgIH0gZWxzZSB7
CsKgwqDCoCDCoMKgwqAgwqDCoMKgIC8vIFRoaXMgaXMgYW4gbG9naWNhbCBtb2RpZmljYXRp
b24gb2YgdGhlIG9yaWdpbmFsIGNvZGUKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAvLyBidXQgSSBkbyBub3Qga25vdyBpZiB0aGlzIGFuIGFjdHVh
bCBsaW1pdGF0aW9uCsKgwqDCoCDCoMKgwqAgwqDCoMKgIC8qIEV4cG9uZW50IGlzIG1heGVk
LiBUcmltIG1hbnRpc3NhIGFuZCBsZWF2ZS4gKi8KwqDCoMKgIMKgwqDCoCDCoMKgwqAgbWFu
dGlzc2EgPSAxMDIzIDsKwqDCoMKgIMKgwqDCoCDCoMKgwqAgYnJlYWs7CsKgwqDCoCDCoMKg
wqAgfQrCoMKgwqAgfQrCoMKgwqAgYnVmWzNdID0gMHg4MDsKwqDCoMKgIGJ1ZlsyXSA9IDA7
CsKgwqDCoCBidWZbMV0gPSBleHBvbmVudCA8PCA1IHwgKG1hbnRpc3NhID4+IDgpOwrCoMKg
wqAgYnVmWzBdID0gbWFudGlzc2EgJiAweGZmOwojZW5kaWYKwqDCoMKgIC8qIENhbGN1bGF0
ZSBhbmQgcmV0dXJuIHRoZSBleGFjdCBiYXVkIHJhdGUuICovCsKgwqDCoCBiYXVkID0gKGJh
c2VsaW5lIC8gbWFudGlzc2EpID4+IChleHBvbmVudCA8PCAxKTsKCsKgwqDCoCByZXR1cm4g
YmF1ZDsKfQoKCk9uIDIvMjEvMjEgMTA6MzcgQU0sIE1pY2hhZWwgRy4gS2F0em1hbm4gd3Jv
dGU6Cj4gVGhlIExpbnV4IGRyaXZlciBkb2VzIG5vdCBzZWVtIHRvIHByb2R1Y2Ugc2Vuc2li
bGUgYmF1ZCByYXRlZCBmb3Igb3RoZXIgdGhhbiB0aGUgJ3N1cHBvcnRlZCcgcmF0ZXMuCj4K
PiBzdHR5IHRvIDExMCBiZCByZXN1bHRzIGluIH45NSwwMDAgYmQgKHRoYXQncyBub3QgYSB0
eXBvIGJ1dCA5NSB0aG91c2FuZCkuIE90aGVyIHJhdGVzIGxpa2UgMjAwIGFsc28gcHJvZHVj
ZSBvZGQgc3BlZWRzIGFsdGhvdWdoIG5vdCBpbiBhIGxvZ2ljYWwgbWFubmVyLgo+Cj4gVGhl
IGRhdGEgc2hlZXRzIGRvbid0IGRlc2NyaWJlIHRoZSBmb3JtdWxhIHVzZWQgZm9yIGRlcml2
aW5nIHRoZSBmb3VyIGJ5dGVzIHVzZWQgdG8gc2V0IHRoZSBzcGVlZC4KPgo+IEkgdHJpZWQg
YWRkaW5nIDExMCB0byB0aGUgc3VwcG9ydGVkIHJhdGVzIGJ1dCB0aGlzIGRpZCBub3QgcHJv
ZHVjZSB0aGUgY29ycmVjdCBiYXVkIHJhdGUgc28gSSBwcmVzdW1lIHRoZSBXaW5kb3dzIGRy
aXZlciBpcyB1c2luZyBhIGZvcm11bGEgZGlmZmVyZW50IHRoYW4gdGhlIG9uZSBpbiB0aGUg
TGludXggZHJpdmVyIGZvciAnbm9uIHN0YW5kYXJkJyBiYXVkIHJhdGVzLgo+Cg==
