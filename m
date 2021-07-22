Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A353C6379A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 10:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E843561377
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhGVJYD (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 05:24:03 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:62405 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231861AbhGVJXz (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 05:23:55 -0400
X-UUID: 00061330de2e453285e1c3679fcb2436-20210722
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=l6KbJziSHG3anQMOz7NsvNX052w7IZh/nwF6Sf4i7VM=;
        b=G1Zlg0d2m1uTvVu1DNIraR/opbUCugjO9pZBl68TDxb/xYzMn/VCBVLMbxgA3IJIku6nevQFhsHbP1Du+dq/aZaVkZVSuR+SKSM3USSmcaO9XNuIEOcjjoXxR9ETQdBU4G0He5tUELcXllxSZjolNAjLKRAfG7CLL9RtJSd+2bw=;
X-UUID: 00061330de2e453285e1c3679fcb2436-20210722
Received: from mtkmrs31.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <zhiyong.tao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 369847993; Thu, 22 Jul 2021 18:03:41 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 22 Jul
 2021 18:03:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 22 Jul 2021 18:03:32 +0800
Message-ID: <1626948212.29611.47.camel@mhfsdcap03>
Subject: Re: [PATCH] uart: mediatek: fix memory corruption issue
From:   zhiyong tao <zhiyong.tao@mediatek.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <timur@kernel.org>, <linux@armlinux.org.uk>, <alcooperx@gmail.com>,
        <tklauser@distanz.ch>, <sean.wang@kernel.org>,
        <srv_heupstream@mediatek.com>, <hui.liu@mediatek.com>,
        <zhiyong.tao@mediatek.com>, <yuchen.huang@mediatek.com>,
        <huihui.wang@mediatek.com>, <eddie.huang@mediatek.com>,
        <sean.wang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-serial@vger.kernel.org>
Date:   Thu, 22 Jul 2021 18:03:32 +0800
In-Reply-To: <YPf67gw2KJCk/Ucs@kroah.com>
References: <20210710090103.2643-1-zhiyong.tao@mediatek.com>
         <20210710090103.2643-2-zhiyong.tao@mediatek.com>
         <YPf67gw2KJCk/Ucs@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 5812E3E14726AC00B2603BE441B9A33120E85081E654CF0F84FBEE315A7F59C12000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gV2VkLCAyMDIxLTA3LTIxIGF0IDEyOjQ2ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiBPbiBT
YXQsIEp1bCAxMCwgMjAyMSBhdCAwNTowMTowM1BNICswODAwLCBaaGl5b25nIFRhbyB3cm90ZToN
Cj4gPiBUaGlzIHBhdGNoIGlzIHVzZWQgdG8gZml4IG1lbW9yeSBjb3JydXB0aW9uIGlzc3VlIHdo
ZW4gcnggcG93ZXIgb2ZmLg0KPiA+IDEuIGFkZCBzcGluIGxvY2sgaW4gbXRrODI1MF9kbWFfcnhf
Y29tcGxldGUgZnVuY3Rpb24gaW4gQVBETUEgbW9kZS4NCj4gDQo+IFdoYXQgZG9lcyBhIGxvY2sg
cHJvdGVjdCBmcm9tPyAgUGxlYXNlIGJlIGV4cGxpY2l0IGFuZCBkZXRhaWxlZC4NCg0KPT0+IEhp
IEdyZWdraCwNCg0Kd2hlbiB1YXJ0IGlzIHVzZWQgYXMgYSBjb21tdW5pY2F0aW9uIHBvcnQgd2l0
aCBleHRlcm5hbCBkZXZpY2UoR1BTKS4NCndoZW4gZXh0ZXJuYWwgZGV2aWNlKEdQUykgcG93ZXIg
b2ZmLCB0aGUgcG93ZXIgb2YgcnggcGluIGlzIGFsc28gZnJvbQ0KMS44diB0byAwdi4gRXZlbiBp
ZiB0aGVyZSBpcyBub3QgYW55IGRhdGEgaW4gcnguIEJ1dCB1YXJ0IHJ4IHBpbiBjYW4NCmNhcHR1
cmUgdGhlIGRhdGEgIjAiLg0KSWYgdWFydCBkb24ndCByZWNlaXZlIGFueSBkYXRhIGluIHNwZWNp
ZmllZCBjeWNsZSwgdWFydCB3aWxsIGdlbmVyYXRlcw0KQkkoQnJlYWsgaW50ZXJydXB0KSBpbnRl
cnJ1cHQuDQpJZiBleHRlcm5hbCBkZXZpY2UoR1BTKSBwb3dlciBvZmYsIHdlIGZvdW5kIHRoYXQg
QkkgaW50ZXJydXB0IGFwcGVhcmVkDQpjb250aW51b3VzbHkgYW5kIHZlcnkgZnJlcXVlbnRseS4N
CldoZW4gdWFydCBpbnRlcnJ1cHQgdHlwZSBpcyBCSSwgdWFydCBJUlEgaGFuZGxlcig4MjUwIGZy
YW13b3JrDQpBUEk6c2VyaWFsODI1MF9oYW5kbGVfaXJxKSB3aWxsIHB1c2ggZGF0YSB0byB0dHkg
YnVmZmVyLg0KVGhlIGNvZGUgcGF0aDoNCmh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4
L2xhdGVzdC9zb3VyY2UvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9wb3J0LmMjTDE5MTcN
Cg0KbXRrODI1MF9kbWFfcnhfY29tcGxldGUgaXMgYSB0YXNrIG9mIG10a191YXJ0X2FwZG1hX3J4
X2hhbmRsZXIuDQptdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSBwcmlvcml0eSBpcyBsb3dlciB0aGFu
IHVhcnQgaXJxDQpoYW5kbGVyKHNlcmlhbDgyNTBfaGFuZGxlX2lycSkuDQppZiB3ZSBhcmUgaW4g
cHJvY2VzcyBvZiBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSwgdWFydCBhcHBlYXIgQkkNCmludGVy
cnVwdDoxKXNlcmlhbDgyNTBfaGFuZGxlX2lycSB3aWxsIHByaW9yaXR5IGV4ZWN1dGlvbi4yKWl0
IG1heSBjYXVzZQ0Kd3JpdGUgdHR5IGJ1ZmZlciBjb25mbGljdCBpbiBtdGs4MjUwX2RtYV9yeF9j
b21wbGV0ZS4NClNvIHRoZSBzcGluIGxvY2sgcHJvdGVjdCB0aGUgcnggcmVjZWl2ZSBkYXRhIHBy
b2Nlc3MgaXMgbm90IGJyZWFrLg0KPiANCj4gPiAyLiBhZGQgcHJvY2Vzc2luZyBtZWNoYW5pc20g
d2hpY2ggY291bnQgdmFsdWUgaXMgMA0KPiANCj4gV2hhdCBkb2VzIHRoaXMgZG8/ICBBbmQgd2h5
IGlzIGl0IG5lZWRlZD8NCg0KPT0+IHdoZW4gY291bnQgdmFsdWUgaXMgMCwgd2UgZG9uJ3QgbmVl
ZCBwdXNoIGRhdGEgdG8gdHR5IGJ1ZmZlci4NCnNvIHdlIGFkZCBpdC4NCj4gDQo+ID4gDQo+ID4g
U2lnbmVkLW9mZi1ieTogWmhpeW9uZyBUYW8gPHpoaXlvbmcudGFvQG1lZGlhdGVrLmNvbT4NCj4g
DQo+IFdoYXQgY29tbWl0IGRvZXMgdGhpcyBmaXg/ICBEb2VzIHRoaXMgbmVlZCB0byBnbyB0byBz
dGFibGUga2VybmVsIHRyZWVzPw0KPiBJZiBzbywgaG93IGZhciBiYWNrPw0KPiANCj4gPiAtLS0N
Cj4gPiAgZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9tdGsuYyB8IDE1ICsrKysrKysrKysr
LS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1MF9t
dGsuYyBiL2RyaXZlcnMvdHR5L3NlcmlhbC84MjUwLzgyNTBfbXRrLmMNCj4gPiBpbmRleCBmN2Qz
MDIzZjg2MGYuLjA5ZjdkMjE2NjMxNSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJp
YWwvODI1MC84MjUwX210ay5jDQo+ID4gKysrIGIvZHJpdmVycy90dHkvc2VyaWFsLzgyNTAvODI1
MF9tdGsuYw0KPiA+IEBAIC05MSwxMiArOTEsMTUgQEAgc3RhdGljIHZvaWQgbXRrODI1MF9kbWFf
cnhfY29tcGxldGUodm9pZCAqcGFyYW0pDQo+ID4gIAlzdHJ1Y3QgbXRrODI1MF9kYXRhICpkYXRh
ID0gdXAtPnBvcnQucHJpdmF0ZV9kYXRhOw0KPiA+ICAJc3RydWN0IHR0eV9wb3J0ICp0dHlfcG9y
dCA9ICZ1cC0+cG9ydC5zdGF0ZS0+cG9ydDsNCj4gPiAgCXN0cnVjdCBkbWFfdHhfc3RhdGUgc3Rh
dGU7DQo+ID4gLQlpbnQgY29waWVkLCB0b3RhbCwgY250Ow0KPiA+ICsJdW5zaWduZWQgaW50IGNv
cGllZCwgdG90YWwsIGNudDsNCj4gPiAgCXVuc2lnbmVkIGNoYXIgKnB0cjsNCj4gPiArCXVuc2ln
bmVkIGxvbmcgZmxhZ3M7DQo+ID4gIA0KPiA+ICAJaWYgKGRhdGEtPnJ4X3N0YXR1cyA9PSBETUFf
UlhfU0hVVERPV04pDQo+ID4gIAkJcmV0dXJuOw0KPiA+ICANCj4gPiArCXNwaW5fbG9ja19pcnFz
YXZlKCZ1cC0+cG9ydC5sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICAJZG1hZW5naW5lX3R4X3N0
YXR1cyhkbWEtPnJ4Y2hhbiwgZG1hLT5yeF9jb29raWUsICZzdGF0ZSk7DQo+ID4gIAl0b3RhbCA9
IGRtYS0+cnhfc2l6ZSAtIHN0YXRlLnJlc2lkdWU7DQo+ID4gIAljbnQgPSB0b3RhbDsNCj4gPiBA
QCAtMTA0LDkgKzEwNywxMSBAQCBzdGF0aWMgdm9pZCBtdGs4MjUwX2RtYV9yeF9jb21wbGV0ZSh2
b2lkICpwYXJhbSkNCj4gPiAgCWlmICgoZGF0YS0+cnhfcG9zICsgY250KSA+IGRtYS0+cnhfc2l6
ZSkNCj4gPiAgCQljbnQgPSBkbWEtPnJ4X3NpemUgLSBkYXRhLT5yeF9wb3M7DQo+ID4gIA0KPiA+
IC0JcHRyID0gKHVuc2lnbmVkIGNoYXIgKikoZGF0YS0+cnhfcG9zICsgZG1hLT5yeF9idWYpOw0K
PiA+IC0JY29waWVkID0gdHR5X2luc2VydF9mbGlwX3N0cmluZyh0dHlfcG9ydCwgcHRyLCBjbnQp
Ow0KPiA+IC0JZGF0YS0+cnhfcG9zICs9IGNudDsNCj4gPiArCWlmIChjbnQgIT0gMCkgew0KPiAN
Cj4gV2h5IGRvZXMgY250IG1hdHRlciBoZXJlPyAgSWYgY250IGlzIDAsIHRoZSBjb2RlIGFib3Zl
IHNob3VsZCBub3QgZG8NCj4gYW55dGhpbmcgYXQgYWxsLCByaWdodD8NCg0KPT0+IHllcywgaWYg
dGhlIGNvdW50ZXIgdmFsdWUgaXMgMCwgd2UgZG9uJ3QgbmVlZCBwdXNoIGRhdGEgdG8gdGhlIHR0
eQ0KYnVmZmVyLg0KPiANCj4gT3IgaWYgaXQgZG9lcywgc2hvdWxkIHdlIGNoYW5nZSB0dHlfaW5z
ZXJ0X2ZsaXBfc3RyaW5nKCkgdG8gYWx3YXlzIGNoZWNrDQo+IGZvciBjbnQgIT0gMCBiZWZvcmUg
aXQgZG9lcyB0aGUgZmlyc3QgbG9vcD8gIEhtLCBpdCBsb29rcyBsaWtlIGl0IHdpbGwNCj4gYWJv
cnQgaWYgY250IGlzIDAsIHNvIHdoYXQgaXMgdGhpcyBjaGFuZ2UgcmVhbGx5IGRvaW5nPyAgV2h5
IGRvIHlvdSBuZWVkDQo+IGl0PyAgV2hhdCBpcyBpdCAiZml4aW5nIj8NCj4gDQo9PT4gSXQgaXMg
bm90IGZpeCBhbnl0aGluZywgd2UganVzdCB0aGluayBpZiBjb3VudCB2YWx1ZSBpcyAwLCB3ZSBk
b24ndA0KbmVlZCBkbyBhbnl0aGluZy4NCg0KVGhhbmtzLg0KDQo+IHRoYW5rcywNCj4gDQo+IGdy
ZWcgay1oDQoNCg==

