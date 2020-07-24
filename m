Return-Path: <SRS0=jxo+=BD=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0894AC433E0
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 06:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDC92070B
	for <linux-serial@archiver.kernel.org>; Fri, 24 Jul 2020 06:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="GXGBk5yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgGXGgo (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:36:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:15394 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgGXGgn (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 24 Jul 2020 02:36:43 -0400
X-UUID: ce487071849c45eda65232134b3a46a0-20200724
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LqLck1fwSu4qq9+0rFPa49nhL2/61wPAzLCarhjNGK4=;
        b=GXGBk5yJ1rNUirFNFLv+qwbcnilBv5cgAqDf0vIRrkfeUyn29nsjVsB0j0W47NJRN5no2l1sway7q5RoNKaO00YnuPU4v22DJ9PP2vW3rR5fkQleBfLEHJhgFnMLYrGH7WJCRakn9MOMbCzg0MdGT3WbaCOFDCdo2J67EbmpodU=;
X-UUID: ce487071849c45eda65232134b3a46a0-20200724
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <crystal.guo@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1363268807; Fri, 24 Jul 2020 14:36:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs07n2.mediatek.inc
 (172.21.101.141) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 24 Jul
 2020 14:36:37 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Jul 2020 14:36:35 +0800
Message-ID: <1595572526.15289.9.camel@mhfsdcap03>
Subject: Re: [PATCH 4/4] dt-binding: mediatek: mt8192: update mtk-wdt
 document
From:   Crystal Guo <crystal.guo@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Seiya Wang =?UTF-8?Q?=28=E7=8E=8B=E8=BF=BA=E5=90=9B=29?= 
        <seiya.wang@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Fri, 24 Jul 2020 14:35:26 +0800
In-Reply-To: <d69d441d-b8c7-f4a4-7ae1-a0012d8001f3@gmail.com>
References: <20200723090731.4482-1-seiya.wang@mediatek.com>
         <20200723090731.4482-5-seiya.wang@mediatek.com>
         <20200723212935.GA889594@bogus>
         <d69d441d-b8c7-f4a4-7ae1-a0012d8001f3@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gRnJpLCAyMDIwLTA3LTI0IGF0IDA2OjAyICswODAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3Rl
Og0KPiANCj4gT24gMjMvMDcvMjAyMCAyMzoyOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+ID4gT24g
VGh1LCBKdWwgMjMsIDIwMjAgYXQgMDU6MDc6MzFQTSArMDgwMCwgU2VpeWEgV2FuZyB3cm90ZToN
Cj4gPj4gRnJvbTogQ3J5c3RhbCBHdW8gPGNyeXN0YWwuZ3VvQG1lZGlhdGVrLmNvbT4NCj4gPj4N
Cj4gPj4gdXBkYXRlIG10ay13ZHQgZG9jdW1lbnQgZm9yIE1UODE5MiBwbGF0Zm9ybQ0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBDcnlzdGFsIEd1byA8Y3J5c3RhbC5ndW9AbWVkaWF0ZWsuY29t
Pg0KPiA+PiAtLS0NCj4gPj4gICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvd2F0
Y2hkb2cvbXRrLXdkdC50eHQgfCAyICsrDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0
aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0DQo+ID4+IGluZGV4IDRkZDM2YmQzZjFhZC4u
ZDc2MGNhOGE2MzBlIDEwMDY0NA0KPiA+PiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvd2F0Y2hkb2cvbXRrLXdkdC50eHQNCj4gPj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL210ay13ZHQudHh0DQo+ID4+IEBAIC0xMiw2ICsx
Miw4IEBAIFJlcXVpcmVkIHByb3BlcnRpZXM6DQo+ID4+ICAgCSJtZWRpYXRlayxtdDc2Mjktd2R0
IiwgIm1lZGlhdGVrLG10NjU4OS13ZHQiOiBmb3IgTVQ3NjI5DQo+ID4+ICAgCSJtZWRpYXRlayxt
dDgxODMtd2R0IiwgIm1lZGlhdGVrLG10NjU4OS13ZHQiOiBmb3IgTVQ4MTgzDQo+ID4+ICAgCSJt
ZWRpYXRlayxtdDg1MTYtd2R0IiwgIm1lZGlhdGVrLG10NjU4OS13ZHQiOiBmb3IgTVQ4NTE2DQo+
ID4+ICsJIm1lZGlhdGVrLG10ODE5Mi13ZHQiOiBmb3IgTVQ4MTkyDQo+ID4+ICsNCj4gPiANCj4g
PiBTbywgbm90IGNvbXBhdGlibGUgd2l0aCAibWVkaWF0ZWssbXQ2NTg5LXdkdCI/IElzIHNvLCBw
ZXJoYXBzIHN1bW1hcml6ZQ0KPiA+IHdoYXQgdGhlIGRpZmZlcmVuY2VzIGFyZS4NCj4gPiANCj4g
DQo+IEhtLCBsb29rcyB0byBtZSBhcyBpZiB0aGUgYmluZGluZyBkZXNjcmlwdGlvbiBmb3IgbXQy
NzEyIGFuZCBtdDgxODMgaXNuJ3QgDQo+IGNvcnJlY3QsIGFzIHdlIGhhdmUgYSBPRiBkYXRhIGp1
c3QgYXMgd2UgaGF2ZSBmb3IgbXQ4MTkyIG5vdy4gQ291bGQgeW91IGZpeCB0aGlzIA0KPiBpbiBh
IHNlcGFyYXRlIHBhdGNoPw0KPiANCj4gUmVnYXJkcywNCj4gTWF0dGhpYXMNCj4gDQo+IEJlc2lk
ZXMgd2F0Y2hkb2csIG10ODE5MiB0b3ByZ3UgbW9kdWxlIGFsc28gcHJvdmlkZSBzdWItc3lzdGVt
IHNvZnR3YXJlIHJlc2V0IGZlYXR1cmVzLg0KPiBtdDI3MTIgYW5kIG10ODE4MyBhcmUgc2FtZSBh
cyBtdDgxOTIuIEJ1dCBtdDY1ODkgbm90IHN1cHBvcnQgc3ViLXN5c3RlbSBzb2Z0d2FyZSByZXNl
dC4NCj4gDQo+ID4+ICAgDQo+ID4+ICAgLSByZWcgOiBTcGVjaWZpZXMgYmFzZSBwaHlzaWNhbCBh
ZGRyZXNzIGFuZCBzaXplIG9mIHRoZSByZWdpc3RlcnMuDQo+ID4+ICAgDQo+ID4+IC0tIA0KPiA+
PiAyLjE0LjENCg0K

