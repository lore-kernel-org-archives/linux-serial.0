Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F360C433E0
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1C64F5E
	for <linux-serial@archiver.kernel.org>; Fri, 12 Mar 2021 20:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhCLU3s (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:29:48 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:38472 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234772AbhCLU3T (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 12 Mar 2021 15:29:19 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9471A220BA;
        Fri, 12 Mar 2021 20:29:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (100-96-17-75.trex.outbound.svc.cluster.local [100.96.17.75])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id CC07E21C8C;
        Fri, 12 Mar 2021 20:29:12 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.75 (trex/6.1.1);
        Fri, 12 Mar 2021 20:29:13 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Blushing-Relation: 38df238c301a2ebc_1615580953179_1329881627
X-MC-Loop-Signature: 1615580953179:3019562172
X-MC-Ingress-Time: 1615580953179
Received: from pdx1-sub0-mail-a6.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTP id 93DDB88404;
        Fri, 12 Mar 2021 12:29:12 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a6.g.dreamhost.com (Postfix) with ESMTPSA id CD41188393;
        Fri, 12 Mar 2021 12:29:08 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 87315282A07;
        Fri, 12 Mar 2021 15:29:07 -0500 (EST)
To:     Johan Hovold <johan@kernel.org>
Cc:     Charles Yeh <charlesyeh522@gmail.com>,
        =?UTF-8?B?WWVoLkNoYXJsZXMgW+iRieamrumRq10=?= 
        <charles-yeh@prolific.com.tw>, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Joe Abbott <jabbott@rollanet.org>
References: <YDUp0tIThOZSTHJt@hovoldconsulting.com>
 <93584ae4-665e-1e67-01e0-cc53f987bee4@IEEE.org>
 <YDUysZY90FfVhrHK@hovoldconsulting.com>
 <CAAZvQQ6F=cQ-EhC0kgeTVM3GrtBWR+HfM6UJWj2AEF1NYZ-vAQ@mail.gmail.com>
 <YDaGRRYrEO5BEJv0@hovoldconsulting.com>
 <CAAZvQQ7+b9=DKqPxgsXxS7Lhqj=QTzKHCMarSbsQkAnYqdO1GA@mail.gmail.com>
 <YEH7okblCx8+Odxn@hovoldconsulting.com>
 <ddc0e424-21c2-b8f4-1b00-f589267d2b51@IEEE.org>
 <YEpAaL9QtVMduEpi@hovoldconsulting.com>
 <9d02257d-cca1-116e-634a-6ac952362c5d@IEEE.org>
 <YEtwNzhCmvyKhRto@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a6
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <abd960f2-c084-12d6-cce6-0a5a59e74a3f@IEEE.org>
Date:   Fri, 12 Mar 2021 15:29:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <YEtwNzhCmvyKhRto@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMy8xMi8yMSA4OjQ0IEFNLCBKb2hhbiBIb3ZvbGQgd3JvdGU6CgpTZWUgZGlmZiB0byB5
b3VyIGJyYW5jaCBiZWxvdy4KClVubGVzcyB3ZSBkbyB3aGF0IEkgb3JpZ2luYWxseSBkaWQg
YW5kIHBhc3MgJ3BvcnQnwqAgdG8gcGwyMzAzX2VuY29kZV9iYXVkX3JhdGVfZGl2aXNvciB3
ZSBjYW5ub3QgdGVzdCBmb3IgJ2FsdF9kaXZpc29yIHRoZXJlLgoKSSBkaWQgdGhpcyB0ZXN0
IGluIHBsMjMwM19lbmNvZGVfYmF1ZF9yYXRlIGluc3RlYWQgc28gaXQgbG9va3MgbGlrZSAu
Li4KCsKgwqDCoMKgwqDCoMKgIGlmIChiYXVkID09IGJhdWRfc3VwKQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgYmF1ZCA9IHBsMjMwM19lbmNvZGVfYmF1ZF9yYXRlX2RpcmVj
dChidWYsIGJhdWQpOwrCoMKgwqDCoMKgwqDCoCBlbHNlIGlmIChzcHJpdi0+dHlwZS0+YWx0
X2Rpdmlzb3JzKQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYmF1ZCA9IHBsMjMw
M19lbmNvZGVfYmF1ZF9yYXRlX2Rpdmlzb3JfYWx0KGJ1ZiwgYmF1ZCk7CsKgwqDCoMKgwqDC
oMKgIGVsc2UKwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJhdWQgPSBwbDIzMDNf
ZW5jb2RlX2JhdWRfcmF0ZV9kaXZpc29yKGJ1ZiwgYmF1ZCk7CgoKTWljaGFlbAoKCjE5MWQx
OTAKPCDCoMKgwqAgdW5zaWduZWQgaW50IGFsdF9kaXZpc29yczoxOwoyMjFkMjE5CjwgwqDC
oMKgIMKgwqDCoCAuYWx0X2Rpdmlzb3JzwqDCoMKgIMKgwqDCoCA9IHRydWUsCjIyNmQyMjMK
PCDCoMKgwqAgwqDCoMKgIC5hbHRfZGl2aXNvcnPCoMKgwqAgwqDCoMKgID0gdHJ1ZSwKNjI1
LDY2NGQ2MjAKPCBzdGF0aWMgc3BlZWRfdCBwbDIzMDNfZW5jb2RlX2JhdWRfcmF0ZV9kaXZp
c29yX2FsdCh1bnNpZ25lZCBjaGFyIGJ1Zls0XSwKPMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNw
ZWVkX3QgYmF1ZCkKPCB7CjzCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBiYXNlbGlu
ZSwgbWFudGlzc2EsIGV4cG9uZW50Owo8CjzCoMKgwqDCoMKgwqDCoMKgIC8qCjzCoMKgwqDC
oMKgwqDCoMKgwqAgKiBBcHBhcmVudGx5LCBmb3IgdGhlIFRBIHZlcnNpb24gdGhlIGZvcm11
bGEgaXM6CjzCoMKgwqDCoMKgwqDCoMKgwqAgKsKgwqAgYmF1ZHJhdGUgPSAxMk0gKiAzMiAv
IChtYW50aXNzYSAqIDJeZXhwb25lbnQpCjzCoMKgwqDCoMKgwqDCoMKgwqAgKiB3aGVyZQo8
wqDCoMKgwqDCoMKgwqDCoMKgICrCoMKgIG1hbnRpc3NhID0gYnVmWzEwOjBdCjzCoMKgwqDC
oMKgwqDCoMKgwqAgKsKgwqAgZXhwb25lbnQgPSBidWZbMTU6MTMgMTZdCjzCoMKgwqDCoMKg
wqDCoMKgwqAgKi8KPMKgwqDCoMKgwqDCoMKgwqAgYmFzZWxpbmUgPSAxMjAwMDAwMCAqIDMy
Owo8wqDCoMKgwqDCoMKgwqDCoCBtYW50aXNzYSA9IGJhc2VsaW5lIC8gYmF1ZDsKPMKgwqDC
oMKgwqDCoMKgwqAgaWYgKG1hbnRpc3NhID09IDApCjzCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBtYW50aXNzYSA9IDE7wqDCoCAvKiBBdm9pZCBkaXZpZGluZyBieSB6ZXJv
IGlmIGJhdWQgPiAzMioxMk0uICovCjzCoMKgwqDCoMKgwqDCoMKgIGV4cG9uZW50ID0gMDsK
PMKgwqDCoMKgwqDCoMKgwqAgd2hpbGUgKG1hbnRpc3NhID49IDIwNDgpIHsKPMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChleHBvbmVudCA8IDE1KSB7CjzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWFudGlzc2EgPj49
IDE7IC8qIGRpdmlkZSBieSAyICovCjzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZXhwb25lbnQrKzsKPMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH0gZWxzZSB7CjzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgLyogRXhwb25lbnQgaXMgbWF4ZWQuIFRyaW0gbWFudGlzc2EgYW5k
IGxlYXZlLiAqLwo8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIG1hbnRpc3NhID0gMjA0NzsKPMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBicmVhazsKPMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIH0KPMKgwqDCoMKgwqDCoMKgwqAgfQo8CjzCoMKgwqDCoMKgwqDCoMKgIGJ1Zlsz
XSA9IDB4ODA7CjzCoMKgwqDCoMKgwqDCoMKgIGJ1ZlsyXSA9IGV4cG9uZW50ICYgMHgwMTsg
Ly8gTFMgYml0IG9mIGV4cG9uZW50CjzCoMKgwqDCoMKgwqDCoMKgIGJ1ZlsxXSA9IChleHBv
bmVudCAmIH4weDAxKSA8PCA0IHwgbWFudGlzc2EgPj4gODsgLy8gMyBiaXRzIG9mIHRoZSBl
eHBvbmVudCBhbmQgTVMgMyBiaXRzIG9mIHRoZSBtYW50aXNzYQo8wqDCoMKgwqDCoMKgwqDC
oCBidWZbMF0gPSBtYW50aXNzYSAmIDB4ZmY7IC8vIExTIDggYml0cyBvZiB0aGUgbWFudGlz
c2EKPAo8wqDCoMKgwqDCoMKgwqDCoCAvKiBDYWxjdWxhdGUgYW5kIHJldHVybiB0aGUgZXhh
Y3QgYmF1ZCByYXRlLiAqLwo8wqDCoMKgwqDCoMKgwqDCoCBiYXVkID0gKGJhc2VsaW5lIC8g
bWFudGlzc2EpID4+IGV4cG9uZW50Owo8CjzCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBiYXVk
Owo8IH0KPAo8CjY5Miw2OTNkNjQ3CjwgwqDCoMKgIGVsc2UgaWYgKHNwcml2LT50eXBlLT5h
bHRfZGl2aXNvcnMpCjzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBiYXVkID0g
cGwyMzAzX2VuY29kZV9iYXVkX3JhdGVfZGl2aXNvcl9hbHQoYnVmLCBiYXVkKTsKCg==
