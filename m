Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F53C63797
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 11:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2961E6135D
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 11:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhGVLM1 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 07:12:27 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:34576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231828AbhGVLM0 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 07:12:26 -0400
X-UUID: 1ffb8b2efa404a4baea454d1499d56c5-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=HI+e/xvoUOH4i2trhO8dcOHc+LQTOalKpiniQMNVN5I=;
        b=jB2RGs9DabERlVdkoje6zFj040j2iY7Xjhrw91klEjI9h3I+neZxnAVdRE9QecDFv0i7oD+wvac41HTeba9p5V5hpcFy6itdDIKv3p1DGobWh4KEDOtvFjYmtUxGXNQGPA4SVDph8hKC9hwoudRv8LqYw39sfNKA+fZnJoxz7YQ=;
X-UUID: 1ffb8b2efa404a4baea454d1499d56c5-20210722
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1036131041; Thu, 22 Jul 2021 19:52:57 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS32N1.mediatek.inc
 (172.27.4.71) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 19:52:51 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 19:52:50 +0800
Message-ID: <1626954770.29611.55.camel@mhfsdcap03>
Subject: Re: [PATCH] uart: mediatek: fix memory corruption issue
From:   zhiyong tao <zhiyong.tao@mediatek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <timur@kernel.org>, <linux@armlinux.org.uk>, <alcooperx@gmail.com>,
        <tklauser@distanz.ch>, <sean.wang@kernel.org>,
        <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <yuchen.huang@mediatek.com>, <huihui.wang@mediatek.com>,
        <eddie.huang@mediatek.com>, <sean.wang@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Date:   Thu, 22 Jul 2021 19:52:50 +0800
In-Reply-To: <YPlEjlKn5Hav/GNH@kroah.com>
References: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
         <20210710090103.2643-2-zhiyong.tao@mediatek.com>
         <YPf67gw2KJCk/Ucs@kroah.com> <1626948212.29611.47.camel@mhfsdcap03>
         <YPlEjlKn5Hav/GNH@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EA5696D511CFA7729DB6F188DE337549E8F4B85D9D40B97435D180AAF18AFE812000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gVGh1LCAyMDIxLTA3LTIyIGF0IDEyOjEyICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBU
aHUsIEp1bCAyMiwgMjAyMSBhdCAwNjowMzozMlBNICswODAwLCB6aGl5b25nIHRhbyB3cm90ZToN
Cj4gPiBPbiBXZWQsIDIwMjEtMDctMjEgYXQgMTI6NDYgKzAyMDAsIEdyZWcgS0ggd3JvdGU6DQo+
ID4gPiBPbiBTYXQsIEp1bCAxMCwgMjAyMSBhdCAwNTowMTowM1BNICswODAwLCBaaGl5b25nIFRh
byB3cm90ZToNCj4gPiA+ID4gVGhpcyBwYXRjaCBpcyB1c2VkIHRvIGZpeCBtZW1vcnkgY29ycnVw
dGlvbiBpc3N1ZSB3aGVuIHJ4IHBvd2VyIG9mZi4NCj4gPiA+ID4gMS4gYWRkIHNwaW4gbG9jayBp
biBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSBmdW5jdGlvbiBpbiBBUERNQSBtb2RlLg0KPiA+ID4g
DQo+ID4gPiBXaGF0IGRvZXMgYSBsb2NrIHByb3RlY3QgZnJvbT8gIFBsZWFzZSBiZSBleHBsaWNp
dCBhbmQgZGV0YWlsZWQuDQo+ID4gDQo+ID4gPT0+IEhpIEdyZWdraCwNCj4gPiANCj4gPiB3aGVu
IHVhcnQgaXMgdXNlZCBhcyBhIGNvbW11bmljYXRpb24gcG9ydCB3aXRoIGV4dGVybmFsIGRldmlj
ZShHUFMpLg0KPiA+IHdoZW4gZXh0ZXJuYWwgZGV2aWNlKEdQUykgcG93ZXIgb2ZmLCB0aGUgcG93
ZXIgb2YgcnggcGluIGlzIGFsc28gZnJvbQ0KPiA+IDEuOHYgdG8gMHYuIEV2ZW4gaWYgdGhlcmUg
aXMgbm90IGFueSBkYXRhIGluIHJ4LiBCdXQgdWFydCByeCBwaW4gY2FuDQo+ID4gY2FwdHVyZSB0
aGUgZGF0YSAiMCIuDQo+IA0KPiBUaGF0IHNvdW5kcyBsaWtlIGEgYnJva2VuIGhhcmR3YXJlIGRl
c2lnbi4NCj4gDQo+ID4gSWYgdWFydCBkb24ndCByZWNlaXZlIGFueSBkYXRhIGluIHNwZWNpZmll
ZCBjeWNsZSwgdWFydCB3aWxsIGdlbmVyYXRlcw0KPiA+IEJJKEJyZWFrIGludGVycnVwdCkgaW50
ZXJydXB0Lg0KPiA+IElmIGV4dGVybmFsIGRldmljZShHUFMpIHBvd2VyIG9mZiwgd2UgZm91bmQg
dGhhdCBCSSBpbnRlcnJ1cHQgYXBwZWFyZWQNCj4gPiBjb250aW51b3VzbHkgYW5kIHZlcnkgZnJl
cXVlbnRseS4NCj4gPiBXaGVuIHVhcnQgaW50ZXJydXB0IHR5cGUgaXMgQkksIHVhcnQgSVJRIGhh
bmRsZXIoODI1MCBmcmFtd29yaw0KPiA+IEFQSTpzZXJpYWw4MjUwX2hhbmRsZV9pcnEpIHdpbGwg
cHVzaCBkYXRhIHRvIHR0eSBidWZmZXIuDQo+ID4gVGhlIGNvZGUgcGF0aDoNCj4gPiBodHRwczov
L2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvdHR5L3Nlcmlh
bC84MjUwLzgyNTBfcG9ydC5jI0wxOTE3DQo+ID4gDQo+ID4gbXRrODI1MF9kbWFfcnhfY29tcGxl
dGUgaXMgYSB0YXNrIG9mIG10a191YXJ0X2FwZG1hX3J4X2hhbmRsZXIuDQo+ID4gbXRrODI1MF9k
bWFfcnhfY29tcGxldGUgcHJpb3JpdHkgaXMgbG93ZXIgdGhhbiB1YXJ0IGlycQ0KPiA+IGhhbmRs
ZXIoc2VyaWFsODI1MF9oYW5kbGVfaXJxKS4NCj4gPiBpZiB3ZSBhcmUgaW4gcHJvY2VzcyBvZiBt
dGs4MjUwX2RtYV9yeF9jb21wbGV0ZSwgdWFydCBhcHBlYXIgQkkNCj4gPiBpbnRlcnJ1cHQ6MSlz
ZXJpYWw4MjUwX2hhbmRsZV9pcnEgd2lsbCBwcmlvcml0eSBleGVjdXRpb24uMilpdCBtYXkgY2F1
c2UNCj4gPiB3cml0ZSB0dHkgYnVmZmVyIGNvbmZsaWN0IGluIG10azgyNTBfZG1hX3J4X2NvbXBs
ZXRlLg0KPiA+IFNvIHRoZSBzcGluIGxvY2sgcHJvdGVjdCB0aGUgcnggcmVjZWl2ZSBkYXRhIHBy
b2Nlc3MgaXMgbm90IGJyZWFrLg0KPiANCj4gVGhlbiBwdXQgc29tZXRoaW5nIGxpa2UgdGhpcyBp
biB0aGUgY2hhbmdlbG9nIHRleHQsIGFzIGl0IGlzLCBpdCBpcyBub3QNCj4gZGVzY3JpcHRpdmUg
YXQgYWxsLg0KDQo9PT4gDQpUaGFua3MgZm9yIHlvdXIgc3VnZ2VzdGlvbi4NCndlIHdpbGwgYWRk
IGl0IGluIGNoYW5nZWxvZyB0ZXh0KFtQQVRDSCAwLzFdIE1lZGlhdGVrIHVhcnQgcGF0Y2gpIGlu
IHYxLg0KDQo+IA0KPiA+ID4gPiAyLiBhZGQgcHJvY2Vzc2luZyBtZWNoYW5pc20gd2hpY2ggY291
bnQgdmFsdWUgaXMgMA0KPiA+ID4gDQo+ID4gPiBXaGF0IGRvZXMgdGhpcyBkbz8gIEFuZCB3aHkg
aXMgaXQgbmVlZGVkPw0KPiA+IA0KPiA+ID09PiB3aGVuIGNvdW50IHZhbHVlIGlzIDAsIHdlIGRv
bid0IG5lZWQgcHVzaCBkYXRhIHRvIHR0eSBidWZmZXIuDQo+ID4gc28gd2UgYWRkIGl0Lg0KPiAN
Cj4gQnV0IHRoYXQgZG9lcyBub3QgYWN0dWFsbHkgZG8gYW55dGhpbmcgZGlmZmVyZW50IGZyb20g
d2hhdCBpdCBkb2VzDQo+IHRvZGF5LiAgQW5kIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdGhl
IGxvY2ssIHNvIHRoaXMgc2hvdWxkIGJlIDINCj4gZGlmZmVyZW50IHBhdGNoZXMsIHJpZ2h0Pw0K
PT0+DQp5ZXMsIGl0IGhhcyBub3RoaW5nIHRvIGRvIHdpdGggdGhlIGxvY2suIHdlIHdpbGwgc2Vw
YXJhdGUgaXQgaW4gdjEuDQoNCj4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFpoaXlvbmcgVGFv
IDx6aGl5b25nLnRhb0BtZWRpYXRlay5jb20+DQo+ID4gPiANCj4gPiA+IFdoYXQgY29tbWl0IGRv
ZXMgdGhpcyBmaXg/ICBEb2VzIHRoaXMgbmVlZCB0byBnbyB0byBzdGFibGUga2VybmVsIHRyZWVz
Pw0KPiA+ID4gSWYgc28sIGhvdyBmYXIgYmFjaz8NCj4gPiA+IA0KPiA+ID4gPiAtLS0NCj4gPiA+
ID4gIGRyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMgfCAxNSArKysrKysrKysrKy0t
LS0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3NlcmlhbC84
MjUwLzgyNTBfbXRrLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX210ay5jDQo+ID4g
PiA+IGluZGV4IGY3ZDMwMjNmODYwZi4uMDlmN2QyMTY2MzE1IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX210ay5jDQo+ID4gPiA+ICsrKyBiL2RyaXZl
cnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMNCj4gPiA+ID4gQEAgLTkxLDEyICs5MSwxNSBA
QCBzdGF0aWMgdm9pZCBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSh2b2lkICpwYXJhbSkNCj4gPiA+
ID4gIAlzdHJ1Y3QgbXRrODI1MF9kYXRhICpkYXRhID0gdXAtPnBvcnQucHJpdmF0ZV9kYXRhOw0K
PiA+ID4gPiAgCXN0cnVjdCB0dHlfcG9ydCAqdHR5X3BvcnQgPSAmdXAtPnBvcnQuc3RhdGUtPnBv
cnQ7DQo+ID4gPiA+ICAJc3RydWN0IGRtYV90eF9zdGF0ZSBzdGF0ZTsNCj4gPiA+ID4gLQlpbnQg
Y29waWVkLCB0b3RhbCwgY250Ow0KPiA+ID4gPiArCXVuc2lnbmVkIGludCBjb3BpZWQsIHRvdGFs
LCBjbnQ7DQo+ID4gPiA+ICAJdW5zaWduZWQgY2hhciAqcHRyOw0KPiA+ID4gPiArCXVuc2lnbmVk
IGxvbmcgZmxhZ3M7DQo+ID4gPiA+ICANCj4gPiA+ID4gIAlpZiAoZGF0YS0+cnhfc3RhdHVzID09
IERNQV9SWF9TSFVURE9XTikNCj4gPiA+ID4gIAkJcmV0dXJuOw0KPiA+ID4gPiAgDQo+ID4gPiA+
ICsJc3Bpbl9sb2NrX2lycXNhdmUoJnVwLT5wb3J0LmxvY2ssIGZsYWdzKTsNCj4gPiA+ID4gKw0K
PiA+ID4gPiAgCWRtYWVuZ2luZV90eF9zdGF0dXMoZG1hLT5yeGNoYW4sIGRtYS0+cnhfY29va2ll
LCAmc3RhdGUpOw0KPiA+ID4gPiAgCXRvdGFsID0gZG1hLT5yeF9zaXplIC0gc3RhdGUucmVzaWR1
ZTsNCj4gPiA+ID4gIAljbnQgPSB0b3RhbDsNCj4gPiA+ID4gQEAgLTEwNCw5ICsxMDcsMTEgQEAg
c3RhdGljIHZvaWQgbXRrODI1MF9kbWFfcnhfY29tcGxldGUodm9pZCAqcGFyYW0pDQo+ID4gPiA+
ICAJaWYgKChkYXRhLT5yeF9wb3MgKyBjbnQpID4gZG1hLT5yeF9zaXplKQ0KPiA+ID4gPiAgCQlj
bnQgPSBkbWEtPnJ4X3NpemUgLSBkYXRhLT5yeF9wb3M7DQo+ID4gPiA+ICANCj4gPiA+ID4gLQlw
dHIgPSAodW5zaWduZWQgY2hhciAqKShkYXRhLT5yeF9wb3MgKyBkbWEtPnJ4X2J1Zik7DQo+ID4g
PiA+IC0JY29waWVkID0gdHR5X2luc2VydF9mbGlwX3N0cmluZyh0dHlfcG9ydCwgcHRyLCBjbnQp
Ow0KPiA+ID4gPiAtCWRhdGEtPnJ4X3BvcyArPSBjbnQ7DQo+ID4gPiA+ICsJaWYgKGNudCAhPSAw
KSB7DQo+ID4gPiANCj4gPiA+IFdoeSBkb2VzIGNudCBtYXR0ZXIgaGVyZT8gIElmIGNudCBpcyAw
LCB0aGUgY29kZSBhYm92ZSBzaG91bGQgbm90IGRvDQo+ID4gPiBhbnl0aGluZyBhdCBhbGwsIHJp
Z2h0Pw0KPiA+IA0KPiA+ID09PiB5ZXMsIGlmIHRoZSBjb3VudGVyIHZhbHVlIGlzIDAsIHdlIGRv
bid0IG5lZWQgcHVzaCBkYXRhIHRvIHRoZSB0dHkNCj4gPiBidWZmZXIuDQo+IA0KPiBCdXQgdGhp
cyBkb2VzIG5vdCBjaGFuZ2UgdGhlIGxvZ2ljIGFzIGlmIGNudCBpcyAwLCBub3RoaW5nIGdldHMg
cHVzaGVkDQo+IHdpdGggdGhlIGN1cnJlbnQgY29kZSBlaXRoZXIsIHJpZ2h0Pw0KPT0+DQp5ZXMs
IGl0IGlzLg0KDQo+IA0KPiA+ID4gT3IgaWYgaXQgZG9lcywgc2hvdWxkIHdlIGNoYW5nZSB0dHlf
aW5zZXJ0X2ZsaXBfc3RyaW5nKCkgdG8gYWx3YXlzIGNoZWNrDQo+ID4gPiBmb3IgY250ICE9IDAg
YmVmb3JlIGl0IGRvZXMgdGhlIGZpcnN0IGxvb3A/ICBIbSwgaXQgbG9va3MgbGlrZSBpdCB3aWxs
DQo+ID4gPiBhYm9ydCBpZiBjbnQgaXMgMCwgc28gd2hhdCBpcyB0aGlzIGNoYW5nZSByZWFsbHkg
ZG9pbmc/ICBXaHkgZG8geW91IG5lZWQNCj4gPiA+IGl0PyAgV2hhdCBpcyBpdCAiZml4aW5nIj8N
Cj4gPiA+IA0KPiA+ID09PiBJdCBpcyBub3QgZml4IGFueXRoaW5nLCB3ZSBqdXN0IHRoaW5rIGlm
IGNvdW50IHZhbHVlIGlzIDAsIHdlIGRvbid0DQo+ID4gbmVlZCBkbyBhbnl0aGluZy4NCj4gDQo+
IFRoZW4gbWFrZSBpdCBhIHNlcGFyYXRlIHBhdGNoLCBpbmRlcGVuZGFudCBmcm9tIHRoZSBsb2Nr
IHBhdGNoLCBhbmQgd2UNCj4gY2FuIGRpc2N1c3MgaXQgdGhlcmUuICBEbyBOT1QgaGF2ZSBwYXRj
aGVzIGRvIG11bHRpcGxlIHRoaW5ncy4NCj09Pg0KSSB3aWxsIG1ha2UgaXQgYSBzZXBhcmF0ZSBw
YXRjaCBpbiB2MS4NCg0KVGhhbmtzLg0KPiANCj4gdGhhbmtzLA0KPiANCj4gZ3JlZyBrLWgNCg0K

