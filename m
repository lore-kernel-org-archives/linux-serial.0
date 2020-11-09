Return-Path: <SRS0=KjKo=EP=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 857B4C2D0A3
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 03:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4454D22244
	for <linux-serial@archiver.kernel.org>; Mon,  9 Nov 2020 03:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729218AbgKIDqn (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 8 Nov 2020 22:46:43 -0500
Received: from m176150.mail.qiye.163.com ([59.111.176.150]:39278 "EHLO
        m176150.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgKIDqn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sun, 8 Nov 2020 22:46:43 -0500
Received: from vivo.com (wm-10.qy.internal [127.0.0.1])
        by m176150.mail.qiye.163.com (Hmail) with ESMTP id C2D221A0FF7;
        Mon,  9 Nov 2020 11:46:06 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <AOEAiAC-DcjiUQMyWDjC1qpx.3.1604893566790.Hmail.bernard@vivo.com>
To:     =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, opensource.kernel@vivo.com
Subject: =?UTF-8?B?UmU6UmU6IFtQQVRDSCAxLzJdIHR0eS9zZXJpYWw6IGRlbGV0ZSBicmVhayBhZnRlciByZXR1cm4=?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 58.213.83.157
In-Reply-To: <20201107140129.kpfhanzjidvdg662@pengutronix.de>
MIME-Version: 1.0
Received: from bernard@vivo.com( [58.213.83.157) ] by ajax-webmail ( [127.0.0.1] ) ; Mon, 9 Nov 2020 11:46:06 +0800 (GMT+08:00)
From:   Bernard <bernard@vivo.com>
Date:   Mon, 9 Nov 2020 11:46:06 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZGUlNSx9OHk0YTExJVkpNS09DQkhOTU1MQkNVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS09ISFVLWQY+
X-HM-Sender-Digest: e1kJHlYWEh9ZQU5CTUtCSkhDSEtMN1dZDB4ZWUEPCQ4eV1kSHx4VD1lB
        WUc6ND46Ejo4Vj8YERIuKjYCLD8ROEoKCwNVSFVKTUtPQ0JITk1MSU9NVTMWGhIXVRkeCRUaCR87
        DRINFFUYFBZFWVdZEgtZQVlOQ1VJSkhVQ0hVSk5MWVdZCAFZQUxLT0o3Bg++
X-HM-Tid: 0a75ab1c675393b4kuwsc2d221a0ff7
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

CkZyb206ICJVd2UgS2xlaW5lLUvDtm5pZyIgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5k
ZT4KRGF0ZTogMjAyMC0xMS0wNyAyMjowMToyOQpUbzogIEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2
aXZvLmNvbT4KQ2M6ICBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24u
b3JnPixKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2VybmVsLm9yZz4sU2hhd24gR3VvIDxzaGF3bmd1
b0BrZXJuZWwub3JnPixTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+LFBlbmd1
dHJvbml4IEtlcm5lbCBUZWFtIDxrZXJuZWxAcGVuZ3V0cm9uaXguZGU+LEZhYmlvIEVzdGV2YW0g
PGZlc3RldmFtQGdtYWlsLmNvbT4sTlhQIExpbnV4IFRlYW0gPGxpbnV4LWlteEBueHAuY29tPixs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnLGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5lbC5vcmcs
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnLG9wZW5zb3VyY2Uua2VybmVsQHZp
dm8uY29tClN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8yXSB0dHkvc2VyaWFsOiBkZWxldGUgYnJlYWsg
YWZ0ZXIgcmV0dXJuPkhlbGxvLAo+Cj50aGUgU3ViamVjdCBpcyB3cm9uZywgaXQgc2hvdWxkIHVz
ZSBhIHByZWZpeCBzaW1pbGFyIHRvICJzZXJpYWw6IGlteDoiLgo+SXQncyBhIGdvb2QgaWRlYSB0
byBjaGVjayBwcmV2aW91cyBwYXRjaGVzIHRvIHRoZSBzYW1lIGZpbGUgdG8gcGljayBhCj5zdWl0
YWJsZSBwcmVmaXguIChFLmcuIGdpdCBsb2cgLS1vbmVsaW5lIGRyaXZlcnMvdHR5L3NlcmlhbC9p
bXguYykKCkhpLCBVd2U6CgpUaGFuayB5b3UgZm9yIHlvdXIgc3VnZ2VzdGlvbiwgSSB3aWxsIG1h
a2UgYSBtb3JlIGFjY3VyYXRlIHN1YmplY3QgaW4gbXkgZnV0dXJlIHBhdGNoZXMuCgo+T24gRnJp
LCBOb3YgMDYsIDIwMjAgYXQgMDc6Mjk6MjNQTSAtMDgwMCwgQmVybmFyZCBaaGFvIHdyb3RlOgo+
PiBEZWxldGUgYnJlYWsgYWZ0ZXIgcmV0dXJuLCB3aGljaCB3aWxsIG5ldmVyIHJ1bi4KPj4gCj4+
IFNpZ25lZC1vZmYtYnk6IEJlcm5hcmQgWmhhbyA8YmVybmFyZEB2aXZvLmNvbT4KPj4gLS0tCj4+
ICBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgfCA1IC0tLS0tCj4+ICAxIGZpbGUgY2hhbmdlZCwg
NSBkZWxldGlvbnMoLSkKPj4gCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14
LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKPj4gaW5kZXggMTczMWQ5NzI4ODY1Li4wOTcw
MzA3OWRiN2IgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdHR5L3NlcmlhbC9pbXguYwo+PiArKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKPj4gQEAgLTMyMCw3ICszMjAsNiBAQCBzdGF0aWMg
dTMyIGlteF91YXJ0X3JlYWRsKHN0cnVjdCBpbXhfcG9ydCAqc3BvcnQsIHUzMiBvZmZzZXQpCj4+
ICAJc3dpdGNoIChvZmZzZXQpIHsKPj4gIAljYXNlIFVDUjE6Cj4+ICAJCXJldHVybiBzcG9ydC0+
dWNyMTsKPj4gLQkJYnJlYWs7Cj4+ICAJY2FzZSBVQ1IyOgo+PiAgCQkvKgo+PiAgCQkgKiBVQ1Iy
X1NSU1QgaXMgdGhlIG9ubHkgYml0IGluIHRoZSBjYWNoZWQgcmVnaXN0ZXJzIHRoYXQgbWlnaHQK
Pj4gQEAgLTMzMSwxNiArMzMwLDEyIEBAIHN0YXRpYyB1MzIgaW14X3VhcnRfcmVhZGwoc3RydWN0
IGlteF9wb3J0ICpzcG9ydCwgdTMyIG9mZnNldCkKPj4gIAkJaWYgKCEoc3BvcnQtPnVjcjIgJiBV
Q1IyX1NSU1QpKQo+PiAgCQkJc3BvcnQtPnVjcjIgPSByZWFkbChzcG9ydC0+cG9ydC5tZW1iYXNl
ICsgb2Zmc2V0KTsKPj4gIAkJcmV0dXJuIHNwb3J0LT51Y3IyOwo+PiAtCQlicmVhazsKPj4gIAlj
YXNlIFVDUjM6Cj4+ICAJCXJldHVybiBzcG9ydC0+dWNyMzsKPj4gLQkJYnJlYWs7Cj4+ICAJY2Fz
ZSBVQ1I0Ogo+PiAgCQlyZXR1cm4gc3BvcnQtPnVjcjQ7Cj4+IC0JCWJyZWFrOwo+PiAgCWNhc2Ug
VUZDUjoKPj4gIAkJcmV0dXJuIHNwb3J0LT51ZmNyOwo+PiAtCQlicmVhazsKPgo+eW91J3JlIHRo
ZSB0aGlyZCB0byBzZW5kIHRoaXMgcGF0Y2ggc2luY2UgT2N0b2JlciAyMDoKPgo+CWh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL3IvMjAyMDEwMjYxMjUxNDIuMjExMDUtMS16aGFuZ3FpbG9uZzNAaHVh
d2VpLmNvbQo+CWh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyMDEwMjAxMzA3MDkuMjgwOTYt
MS10cml4QHJlZGhhdC5jb20KPgo+TXkgY29tbWVudCBmb3IgdGhlc2Ugd2FzOgo+Cj4+IHRoaXMg
bWlnaHQgYmUgc3ViamVjdGl2ZSwgYnV0IEkgbGlrZSB0aGUgYnJlYWsgYmVpbmcgdGhlcmUgZm9y
IGNsZWFyaXR5Lgo+PiBTbyBJIG9iamVjdCB0byBtYWtlIGEgcGF0Y2ggdG8gcmVtb3ZlIHRoZW0u
IEluIGNhc2UgSSdtIG91dHZvdGVkIEknZCBhdAo+PiBsZWFzdCB3YW50IGVtcHR5IGxpbmVzIGlu
c3RlYWQuCj4KPlpoYW5nIFFpbG9uZyB3cm90ZSBoZSBmb3VuZCB0aGUgcGF0Y2ggb3Bwb3J0dW5p
dHkgYnkgbWFudWFsIGNvZGUKPmluc3BlY3Rpb24sIEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGF0
IHRoZXJlIGlzIGEgdG9vbCB0aGF0IGlkZW50aWZpZXMgYQo+YnJlYWsgYWZ0ZXIgYSByZXR1cm4u
IElmIHlvdSBoYWQgdG9vbCBzdXBwb3J0LCBwbGVhc2UgbWVudGlvbiB0aGUgdG9vbAo+aW4gdGhl
IGNvbW1pdCBsb2cgKGlmIHlvdSByZWFsbHkgd2FudCB0byBrZWVwIGZvbGxvd2luZyB0aGUgcGF0
Y2gncwo+aWRlYSkuCgpGb3IgdGhpcyBwYXJ0OgpJIHdyb3RlIGEgcHl0aG9uIHNjcmlwdCB0byBj
aGVjayBpZiB0aGVyZSBpcyBhIGJyZWFrIGFmdGVyIGEgcmV0dXJuIG9yIGdvdG8uClRoZSBzY3Jp
cHQgY3VycmVudGx5IGhhcyBzb21lIGlzc3VlcyBpbiBpdHMgaGFuZGxpbmcgb2Ygc3BlY2lhbCBj
aGFyYWN0ZXJzLCB0aGUgc2VhcmNoIHJlc3VsdCBpcyBub3QgcHJlY2lzZSBlbm91Z2guIEl0IGlz
IHN0aWxsIHVuZGVyIGRlYnVnZ2luZy4gClRoZXNlIGFyZSB0aGUgb25seSBwbGFjZXMgd2hpY2gg
IHRoZSBzY3JpcHQgY2hlY2tzIG91dCBpbiBwYXRoOiBkcml2ZXIvdHR5LgpJIGFsc28gY2hlY2tl
ZCBvdGhlciBwYXRoKGxpa2U6IGRyaXZlci92bWUvLCBkcml2ZXIvdmlkZW8sIGRyaXZlci91c2Ip
LCB0aGVzZSBwYXRocyBhbHNvIGhhdmUgYSBjZXJ0YWluIG51bWJlciBvZiBzaW1pbGFyIGlzc3Vl
cy4gQW5kIEkgd2lsbCB0cnkgdG8gc3VibWl0IHRoZXNlIHBhdGNoIGxhdGVyLgpUaGFua3MhCgpC
Ui8vQmVybmFyZAoKPkJlc3QgcmVnYXJkcwo+VXdlCj4KPi0tIAo+UGVuZ3V0cm9uaXggZS5LLiAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgVXdlIEtsZWluZS1Lw7ZuaWcgICAgICAgICAgICB8
Cj5JbmR1c3RyaWFsIExpbnV4IFNvbHV0aW9ucyAgICAgICAgICAgICAgICAgfCBodHRwczovL3d3
dy5wZW5ndXRyb25peC5kZS8gfAoNCg0K
