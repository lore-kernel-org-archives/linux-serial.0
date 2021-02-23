Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF9C5C43381
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A256E64E77
	for <linux-serial@archiver.kernel.org>; Tue, 23 Feb 2021 15:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232599AbhBWPAc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:00:32 -0500
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:10415 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230291AbhBWPAb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 23 Feb 2021 10:00:31 -0500
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9C63D781D33;
        Tue, 23 Feb 2021 14:58:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (100-96-17-34.trex.outbound.svc.cluster.local [100.96.17.34])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 23839782449;
        Tue, 23 Feb 2021 14:58:53 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|smtp@contentfirst.com
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.17.34 (trex/6.0.2);
        Tue, 23 Feb 2021 14:58:53 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|smtp@contentfirst.com
X-MailChannels-Auth-Id: dreamhost
X-Arch-Army: 17f04f6537bef379_1614092333452_3684474540
X-MC-Loop-Signature: 1614092333452:1392463749
X-MC-Ingress-Time: 1614092333452
Received: from pdx1-sub0-mail-a45.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTP id D5E457F057;
        Tue, 23 Feb 2021 06:58:52 -0800 (PST)
Received: from industrynumbers.com (pool-100-15-209-187.washdc.fios.verizon.net [100.15.209.187])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: smtp@contentfirst.com)
        by pdx1-sub0-mail-a45.g.dreamhost.com (Postfix) with ESMTPSA id 3DC7D7F03D;
        Tue, 23 Feb 2021 06:58:49 -0800 (PST)
Received: from industrynumbers.com (localhost [127.0.0.1])
        by industrynumbers.com (Postfix) with ESMTP id 6C66F282D7A;
        Tue, 23 Feb 2021 09:58:47 -0500 (EST)
To:     Johan Hovold <johan@kernel.org>
Cc:     charles-yeh@prolific.com.tw, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, Charles Yeh <charlesyeh522@gmail.com>,
        Joe Abbott <jabbott@rollanet.org>
References: <3aee5708-7961-f464-8c5f-6685d96920d6@IEEE.org>
 <dc3458f1-830b-284b-3464-20124dc3900a@IEEE.org>
 <YDNwxtDxd7JntAXt@hovoldconsulting.com>
 <e2dcc839-3b43-2c80-6ad1-2d97e639b46a@IEEE.org>
 <YDOvLseYXaUHs0lS@hovoldconsulting.com>
 <fb1489c2-b972-619b-b7ce-4ae8e1d2cc0f@IEEE.org>
 <YDPO/JprcDTaPmR4@hovoldconsulting.com>
 <0f9caf26-af58-13a9-9947-47bb646f505e@IEEE.org>
 <YDPS3AP63/PwmwJU@hovoldconsulting.com>
X-DH-BACKEND: pdx1-sub0-mail-a45
From:   "Michael G. Katzmann" <michaelk@IEEE.org>
Subject: Re: non-standard baud rates with Prolific 2303 USB-serial
Message-ID: <780b9aa6-890d-47fd-d6b2-cd9a39f7634a@IEEE.org>
Date:   Tue, 23 Feb 2021 09:58:47 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <YDPS3AP63/PwmwJU@hovoldconsulting.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gMi8yMi8yMSAxMDo1MCBBTSwgSm9oYW4gSG92b2xkIHdyb3RlOgoKCldlbGwgSSBmb3Vu
ZCBJIGhhdmUgYW5vdGhlciBQcm9saWZpYyBkZXZpY2UgaGVyZSB0aGF0IEkgZ290IGZyb20g
QWRhZnJ1aXQgKGh0dHBzOi8vd3d3LmFkYWZydWl0LmNvbS9wcm9kdWN0Lzk1NCkKCkl0IGFs
c28gaGFzIGEgUHJvbGlmaWMgMjMwMyBhbmQgYmVoYXZlcyBleGFjdGx5IGxpa2UgdGhlIG90
aGVyIG9uZS4gaS5lLiB3aXRoIHRoZSBjdXJyZW50IExpbnV4IGRyaXZlciBpdCBnaXZlcyBh
IHZlcnkgaGlnaCBiYXVkcmF0ZSB3aGVuIHNldCB0byAxMTAgYmQgYW5kIGdpdmVzIDExMGJk
IHdoZW4gdGhlIG1vZGlmaWNhdGlvbnMgYXJlIG1hZGUgdG8gdGhlIGRyaXZlciB0aGF0IEkg
Zm91bmQuCgpJcyBpdCB0aGF0IHdlIGFyZSBwcmVzdW1pbmcgdGhhdCB3aGF0IFByb2xpZmlj
IGlzIHRlbGxpbmcgdXMgaXMgdHJ1ZSBhbmQgb25seSBKb2UgYW5kIEkgYXJlIGFjdHVhbGx5
IG1lYXN1cmluZyB0aGUgZGF0YSByYXRlP8KgIChpLmUuIHdoeSBkb2VzIHRoZSBQcm9saWZp
YyBXaW5kb3dzIGRyaXZlciBzZXQgdGhlIHZhbHVlcyBhcyBKb2UgZm91bmQgPz8/KQoKQWRh
ZnJ1aXQgZGV2aWNlOgoKQnVzIDAwMSBEZXZpY2UgMDEzOiBJRCAwNjdiOjIzMDMgUHJvbGlm
aWMgVGVjaG5vbG9neSwgSW5jLiBQTDIzMDMgU2VyaWFsIFBvcnQKRGV2aWNlIERlc2NyaXB0
b3I6CsKgIGJMZW5ndGjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTgKwqAgYkRl
c2NyaXB0b3JUeXBlwqDCoMKgwqDCoMKgwqDCoCAxCsKgIGJjZFVTQsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgMi4wMArCoCBiRGV2aWNlQ2xhc3PCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDAKwqAgYkRldmljZVN1YkNsYXNzwqDCoMKgwqDCoMKgwqDCoCAwCsKgIGJEZXZpY2VQ
cm90b2NvbMKgwqDCoMKgwqDCoMKgwqAgMArCoCBiTWF4UGFja2V0U2l6ZTDCoMKgwqDCoMKg
wqDCoCA2NArCoCBpZFZlbmRvcsKgwqDCoMKgwqDCoMKgwqDCoMKgIDB4MDY3YiBQcm9saWZp
YyBUZWNobm9sb2d5LCBJbmMuCsKgIGlkUHJvZHVjdMKgwqDCoMKgwqDCoMKgwqDCoCAweDIz
MDMgUEwyMzAzIFNlcmlhbCBQb3J0CsKgIGJjZERldmljZcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgMy4wMArCoCBpTWFudWZhY3R1cmVywqDCoMKgwqDCoMKgwqDCoMKgwqAgMSBQcm9saWZp
YyBUZWNobm9sb2d5IEluYy4KwqAgaVByb2R1Y3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMiBVU0ItU2VyaWFsIENvbnRyb2xsZXIKwqAgaVNlcmlhbMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDAKwqAgYk51bUNvbmZpZ3VyYXRpb25zwqDCoMKgwqDCoCAx
CsKgIENvbmZpZ3VyYXRpb24gRGVzY3JpcHRvcjoKwqDCoMKgIGJMZW5ndGjCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA5CsKgwqDCoCBiRGVzY3JpcHRvclR5cGXCoMKgwqDC
oMKgwqDCoMKgIDIKwqDCoMKgIHdUb3RhbExlbmd0aMKgwqDCoMKgwqDCoCAweDAwMjcKwqDC
oMKgIGJOdW1JbnRlcmZhY2VzwqDCoMKgwqDCoMKgwqDCoMKgIDEKwqDCoMKgIGJDb25maWd1
cmF0aW9uVmFsdWXCoMKgwqDCoCAxCsKgwqDCoCBpQ29uZmlndXJhdGlvbsKgwqDCoMKgwqDC
oMKgwqDCoCAwCsKgwqDCoCBibUF0dHJpYnV0ZXPCoMKgwqDCoMKgwqDCoMKgIDB4YTAKwqDC
oMKgwqDCoCAoQnVzIFBvd2VyZWQpCsKgwqDCoMKgwqAgUmVtb3RlIFdha2V1cArCoMKgwqAg
TWF4UG93ZXLCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMDBtQQrCoMKgwqAgSW50ZXJm
YWNlIERlc2NyaXB0b3I6CsKgwqDCoMKgwqAgYkxlbmd0aMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDkKwqDCoMKgwqDCoCBiRGVzY3JpcHRvclR5cGXCoMKgwqDCoMKgwqDC
oMKgIDQKwqDCoMKgwqDCoCBiSW50ZXJmYWNlTnVtYmVywqDCoMKgwqDCoMKgwqAgMArCoMKg
wqDCoMKgIGJBbHRlcm5hdGVTZXR0aW5nwqDCoMKgwqDCoMKgIDAKwqDCoMKgwqDCoCBiTnVt
RW5kcG9pbnRzwqDCoMKgwqDCoMKgwqDCoMKgwqAgMwrCoMKgwqDCoMKgIGJJbnRlcmZhY2VD
bGFzc8KgwqDCoMKgwqDCoCAyNTUgVmVuZG9yIFNwZWNpZmljIENsYXNzCsKgwqDCoMKgwqAg
YkludGVyZmFjZVN1YkNsYXNzwqDCoMKgwqDCoCAwCsKgwqDCoMKgwqAgYkludGVyZmFjZVBy
b3RvY29swqDCoMKgwqDCoCAwCsKgwqDCoMKgwqAgaUludGVyZmFjZcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDAKwqDCoMKgwqDCoCBFbmRwb2ludCBEZXNjcmlwdG9yOgrCoMKgwqDC
oMKgwqDCoCBiTGVuZ3RowqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNwrCoMKg
wqDCoMKgwqDCoCBiRGVzY3JpcHRvclR5cGXCoMKgwqDCoMKgwqDCoMKgIDUKwqDCoMKgwqDC
oMKgwqAgYkVuZHBvaW50QWRkcmVzc8KgwqDCoMKgIDB4ODHCoCBFUCAxIElOCsKgwqDCoMKg
wqDCoMKgIGJtQXR0cmlidXRlc8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMwrCoMKgwqDCoMKg
wqDCoMKgwqAgVHJhbnNmZXIgVHlwZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSW50ZXJydXB0
CsKgwqDCoMKgwqDCoMKgwqDCoCBTeW5jaCBUeXBlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBOb25lCsKgwqDCoMKgwqDCoMKgwqDCoCBVc2FnZSBUeXBlwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBEYXRhCsKgwqDCoMKgwqDCoMKgIHdNYXhQYWNrZXRTaXplwqDCoMKg
wqAgMHgwMDBhwqAgMXggMTAgYnl0ZXMKwqDCoMKgwqDCoMKgwqAgYkludGVydmFswqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxCsKgwqDCoMKgwqAgRW5kcG9pbnQgRGVzY3JpcHRv
cjoKwqDCoMKgwqDCoMKgwqAgYkxlbmd0aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDcKwqDCoMKgwqDCoMKgwqAgYkRlc2NyaXB0b3JUeXBlwqDCoMKgwqDCoMKgwqDCoCA1
CsKgwqDCoMKgwqDCoMKgIGJFbmRwb2ludEFkZHJlc3PCoMKgwqDCoCAweDAywqAgRVAgMiBP
VVQKwqDCoMKgwqDCoMKgwqAgYm1BdHRyaWJ1dGVzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAy
CsKgwqDCoMKgwqDCoMKgwqDCoCBUcmFuc2ZlciBUeXBlwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBCdWxrCsKgwqDCoMKgwqDCoMKgwqDCoCBTeW5jaCBUeXBlwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBOb25lCsKgwqDCoMKgwqDCoMKgwqDCoCBVc2FnZSBUeXBlwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBEYXRhCsKgwqDCoMKgwqDCoMKgIHdNYXhQYWNrZXRTaXpl
wqDCoMKgwqAgMHgwMDQwwqAgMXggNjQgYnl0ZXMKwqDCoMKgwqDCoMKgwqAgYkludGVydmFs
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwCsKgwqDCoMKgwqAgRW5kcG9pbnQgRGVz
Y3JpcHRvcjoKwqDCoMKgwqDCoMKgwqAgYkxlbmd0aMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDcKwqDCoMKgwqDCoMKgwqAgYkRlc2NyaXB0b3JUeXBlwqDCoMKgwqDCoMKg
wqDCoCA1CsKgwqDCoMKgwqDCoMKgIGJFbmRwb2ludEFkZHJlc3PCoMKgwqDCoCAweDgzwqAg
RVAgMyBJTgrCoMKgwqDCoMKgwqDCoCBibUF0dHJpYnV0ZXPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDIKwqDCoMKgwqDCoMKgwqDCoMKgIFRyYW5zZmVyIFR5cGXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIEJ1bGsKwqDCoMKgwqDCoMKgwqDCoMKgIFN5bmNoIFR5cGXCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5vbmUKwqDCoMKgwqDCoMKgwqDCoMKgIFVzYWdlIFR5cGXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIERhdGEKwqDCoMKgwqDCoMKgwqAgd01heFBhY2tl
dFNpemXCoMKgwqDCoCAweDAwNDDCoCAxeCA2NCBieXRlcwrCoMKgwqDCoMKgwqDCoCBiSW50
ZXJ2YWzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDAKCgotLSAKICAgfFwgICAgICBf
LCwsLS0tLCxfICAgICAgICAgICAgIE1pY2hhZWwgS2F0em1hbm4KICAgLyxgLi0nYCcgICAg
LS4gIDstOzssXyAgICAgICAgIE5WM1ogLyBWSzJCRUEgLyBHNE5ZVgogIHwsNC0gICkgKS0s
Xy4gLFwgKCAgYCctJyAKICctLS0nJyhfLy0tJyAgYC0nXF8pICAgICAgICAgICAgIE1pY2hh
ZWxLQElFRUUub3JnCgo=
