Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42714CDB46E
	for <linux-serial@archiver.kernel.org>; Thu, 12 Oct 2023 07:45:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbjJLHpY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 Oct 2023 03:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343626AbjJLHpX (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Oct 2023 03:45:23 -0400
X-Greylist: delayed 302 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 12 Oct 2023 00:45:20 PDT
Received: from mail.unseenlabs.fr (mail.unseenlabs.fr [51.91.207.241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0AA5B7
        for <linux-serial@vger.kernel.org>; Thu, 12 Oct 2023 00:45:20 -0700 (PDT)
Received: from S1014830.EX1014830.lan (51.91.207.241) by
 S1014830.EX1014830.lan (51.91.207.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.39; Thu, 12 Oct 2023 09:40:16 +0200
Received: from S1014830.EX1014830.lan ([fe80::e4ed:2140:743a:7649]) by
 S1014830.EX1014830.lan ([fe80::e4ed:2140:743a:7649%2]) with mapi id
 15.02.1118.039; Thu, 12 Oct 2023 09:40:16 +0200
From:   Julien MALIK - UNSEENLABS <julien.malik@unseenlabs.fr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Re: [PATCH] serial: xilinx_uartps: unset STOPBRK when setting
 STARTBRK
Thread-Topic: [PATCH] serial: xilinx_uartps: unset STOPBRK when setting
 STARTBRK
Thread-Index: AQHZpt9m6m00LN3psEKP4ubkdAfEfrBGT2kA
Date:   Thu, 12 Oct 2023 07:40:16 +0000
Message-ID: <3fdb8c7a-6b31-4569-829c-cff84d8b836d@unseenlabs.fr>
References: <20230624210323.88455-1-julien.malik@unseenlabs.fr>
In-Reply-To: <20230624210323.88455-1-julien.malik@unseenlabs.fr>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [45.80.32.184]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A2B6B9B14FB8FE44A7DC88A0630F8DAC@EX1014830.lan>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

TGUgMjQvMDYvMjAyMyDDoCAyMzowMywgSnVsaWVuIE1hbGlrIGEgw6ljcml0wqA6DQo+IFp5bnEg
VUc1ODUgc3RhdGVzLCBpbiBjaGFwdGVyIEIuMzMsIGZvciBYVUFSVFBTX0NSX1NUQVJUQlJLOg0K
PiBJdCBjYW4gb25seSBiZSBzZXQgaWYgU1RQQlJLIChTdG9wIHRyYW5zbWl0dGVyIGJyZWFrKSBp
cyBub3QgaGlnaA0KPg0KPiBUaGlzIGZpeGVzIHRjc2VuZGJyZWFrLCB3aGljaCBvdGhlcndpc2Ug
ZG9lcyBub3QgYWN0dWFsbHkgYnJlYWsuDQo+DQo+IFNpZ25lZC1PZmYtQnk6IEp1bGllbiBNYWxp
ayA8anVsaWVuLm1hbGlrQHVuc2VlbmxhYnMuZnI+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvdHR5L3Nl
cmlhbC94aWxpbnhfdWFydHBzLmMgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJp
YWwveGlsaW54X3VhcnRwcy5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0K
PiBpbmRleCA4ZTUyMWM2OWE5NTkuLjJlNjlmY2VhYTc5MiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVy
cy90dHkvc2VyaWFsL3hpbGlueF91YXJ0cHMuYw0KPiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwv
eGlsaW54X3VhcnRwcy5jDQo+IEBAIC02NTcsNyArNjU3LDcgQEAgc3RhdGljIHZvaWQgY2Ruc191
YXJ0X2JyZWFrX2N0bChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0LCBpbnQgY3RsKQ0KPiAgIAlzdGF0
dXMgPSByZWFkbChwb3J0LT5tZW1iYXNlICsgQ0ROU19VQVJUX0NSKTsNCj4gICANCj4gICAJaWYg
KGN0bCA9PSAtMSkNCj4gLQkJd3JpdGVsKENETlNfVUFSVF9DUl9TVEFSVEJSSyB8IHN0YXR1cywN
Cj4gKwkJd3JpdGVsKENETlNfVUFSVF9DUl9TVEFSVEJSSyB8ICh+Q0ROU19VQVJUX0NSX1NUT1BC
UksgJiBzdGF0dXMpLA0KPiAgIAkJCQlwb3J0LT5tZW1iYXNlICsgQ0ROU19VQVJUX0NSKTsNCj4g
ICAJZWxzZSB7DQo+ICAgCQlpZiAoKHN0YXR1cyAmIENETlNfVUFSVF9DUl9TVE9QQlJLKSA9PSAw
KQ0KDQoNCkRlYXIgcmV2aWV3ZXJzLA0KDQoNClRoaXMgaXMgYSBraW5kIHBpbmcgdG8gYXR0cmFj
dCBtb3JlIGF0dGVudGlvbiB0byB0aGlzIHNtYWxsIHBhdGNoLg0KDQoNClRoZSBpc3N1ZSBhbmQg
Y29ycmVzcG9uZGluZyBmaXggaGFzIGFscmVhZHkgYmVlbiBzdWdnZXN0ZWQgYmFjayBpbiAyMDE2
IA0Kb24gdGhlIHhpbGlueCBmb3J1bSBbMV0uDQoNCg0KVGhpcyBpcyBteSB2ZXJ5IGZpcnN0IHBh
dGNoIHN1Ym1pc3Npb24gdG8gdGhlIGtlcm5lbC4NCg0KVGhvdWdoIEkgZGlkIG15IGJlc3QsIG1h
eWJlIEkgZGlkIG5vdCBmb2xsb3cgYmVzdCBwcmFjdGljZXMsIGluIHdoaWNoIA0KY2FzZSBJJ20g
YWxsIGVhcnMgdG8gc3VnZ2VzdGlvbnMuDQoNCg0KQmVzdCByZWdhcmRzLA0KDQpKdWxpZW4NCg0K
WzFdIA0KaHR0cHM6Ly9zdXBwb3J0LnhpbGlueC5jb20vcy9xdWVzdGlvbi8wRDUyRTAwMDA2aHBV
U0tTQTIvY2Fubm90LXNlbmQtc2VyaWFsLWxpbmUtYnJlYWstaW4tbGludXgtMzgwLXRyZC0xNDUN
Cg0K
