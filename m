Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C94D5FA3742
	for <linux-serial@archiver.kernel.org>; Thu, 27 Oct 2022 12:07:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiJ0MHx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 27 Oct 2022 08:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiJ0MHw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 27 Oct 2022 08:07:52 -0400
Received: from mx2.securetransport.de (mx2.securetransport.de [IPv6:2a03:4000:13:6c7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F8DB03E8;
        Thu, 27 Oct 2022 05:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
        s=dhelectronicscom; t=1666872427;
        bh=0Q4WJMmZYsuUKZ8ySwv4DXKxGRJk55X3Hf7mKSpKNDQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=B6sUo8Km4GOi1Cb8DX0wdQbr9d9j/oO4cihb4EKeFqhOztCdkXXbKsrodZjSMvHuB
         m56S6k0LrwTs5esNtNyEneTHJ85SWnLIzOE4g+uYpZLiiWd8/lafnMsDAyjz2aD+Y2
         kv4/2iaMY4sY11XiNbiDVRmlu/N4eKFYz/9mkEz1OGToJCm5YjMrThghkkqCemgckZ
         /AqwKN/HxqhVAdCCuSUaK0UCsBdLgbPCdKnvoyNcVjsDyKRiJnAvEOGdNGG1TWTDEt
         jzakv2BgzP+FLIqgO5RWv1lU9FegwN5hZfssOMMV4ralfZYuFlIMznIfcFrGwcJo64
         bsKrPCqDkIsdA==
X-secureTransport-forwarded: yes
From:   Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To:     Rob Herring <robh@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "marex@denx.de" <marex@denx.de>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Thread-Topic: [PATCH 1/4] dt_bindings: rs485: Add binding for GPIO that
 controls Rx enable during Tx
Thread-Index: AQHY6VtPL1dpKjxCfE69ES0JgWopKq4hB10AgADJ5GA=
Date:   Thu, 27 Oct 2022 12:06:56 +0000
Message-ID: <f04351971a5c4b5e8930000addb06398@dh-electronics.com>
References: <20221026165049.9541-1-cniedermaier@dh-electronics.com>
 <20221026165049.9541-2-cniedermaier@dh-electronics.com>
 <20221026205914.GA1294440-robh@kernel.org>
In-Reply-To: <20221026205914.GA1294440-robh@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

RnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5lbC5vcmddDQpTZW50OiBXZWRuZXNk
YXksIE9jdG9iZXIgMjYsIDIwMjIgMTA6NTkgUE0NCj4gT24gV2VkLCBPY3QgMjYsIDIwMjIgYXQg
MDY6NTA6NDZQTSArMDIwMCwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4gQWRkIHRo
ZSBiaW5kaW5nIGZvciBhIGdlbmVyaWMgZGVmaW5pdGlvbiBvZiBhIEdQSU8sIHRoYXQgY29udHJv
bHMgd2hldGhlciBSeA0KPj4gaXMgY29ubmVjdGVkIG9yIGRpc2Nvbm5lY3RlZCBieSBhbiBlbGVj
dHJpY2FsIGNpcmN1aXQgdG8gaGF2ZSB0aGUgYWJpbGl0eQ0KPj4gdG8gcmVjZWl2ZSB0aGUgc2ln
bmFscyBvbiB0aGUgYnVzIGR1cmluZyBzZW5kaW5nIG9yIGRpc2FibGUgcmVjZWl2aW5nIGR1cmlu
Zw0KPj4gc2VuZGluZy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggTmllZGVybWFp
ZXIgPGNuaWVkZXJtYWllckBkaC1lbGVjdHJvbmljcy5jb20+DQo+PiAtLS0NCj4+IENjOiBHcmVn
IEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPj4gQ2M6IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+DQo+PiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnPg0KPj4gQ2M6IE1hcmVrIFZhc3V0IDxt
YXJleEBkZW54LmRlPg0KPj4gQ2M6IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+PiBUbzog
bGludXgtc2VyaWFsQHZnZXIua2VybmVsLm9yZw0KPj4gVG86IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPj4gLS0tDQo+PiAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9yczQ4NS55YW1sIHwgNCArKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQg
aW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwNCj4+IGluZGV4IDkwYTFiYWI0MGYwNS4uMGViZDc2
OTBmODVkIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3NlcmlhbC9yczQ4NS55YW1sDQo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvc2VyaWFsL3JzNDg1LnlhbWwNCj4+IEBAIC01MSw2ICs1MSwxMCBAQCBwcm9wZXJ0aWVz
Og0KPj4gICAgICBkZXNjcmlwdGlvbjogR1BJTyBwaW4gdG8gZW5hYmxlIFJTNDg1IGJ1cyB0ZXJt
aW5hdGlvbi4NCj4+ICAgICAgbWF4SXRlbXM6IDENCj4+DQo+PiArICByczQ4NS1yeC1kdXJpbmct
dHgtZ3Bpb3M6DQo+PiArICAgIGRlc2NyaXB0aW9uOiBHUElPIHBpbiB0byBjb250cm9sIFJTNDg1
IFJ4IGVuYWJsZSBkdXJpbmcgVHguDQo+IA0KPiBBY3RpdmUgc3RhdGUgbWVhbnMgZG8gd2hhdD8g
QW5kIGluYWN0aXZlPyBUaGlzIGlzIGFuIG91dHB1dCBnYXRpbmcgdGhlDQo+IFJYIHNpZ25hbCBv
ciBhbiBpbnB1dCB0ZWxsaW5nIHRoZSByZWNlaXZlciB3aGF0IHRvIGRvIGR1cmluZyB0eD8gVGhl
DQo+IGRlc2NyaXB0aW9uIGlzIG5vdCBhZGVxdWF0ZS4NCj4gDQo+IEhvdyBkb2VzIHRoaXMgcHJv
cGVydHkgcmVsYXRlIHRvICdyczQ4NS1yeC1kdXJpbmctdHgnIEFueSBjb21iaW5hdGlvbiBvZg0K
PiB0aGUgMiBiZWluZyBwcmVzZW50IG9yIG5vdCBpcyBva2F5PyBJZiBub3QsIHlvdSBuZWVkIHNv
bWUgY29uc3RyYWludHMuDQo+IA0KPiBSb2INCg0KDQpIaSBSb2IsDQoNCkkgaGF2ZSBpbXByb3Zl
ZCB0aGUgbWVzc2FnZToNCg0KVGhlIHN0YW5kYXJkIFJTNDg1IGlzIGEgaGFsZi1kdXBsZXggYnVz
IHRoYXQgaW4gbW9zdCBjYXNlZCBpcyBkcml2ZW4gYnkgYW4NClVBUlQgY29udHJvbGxlci4gVGhl
IGludGVyZmFjZSB0byB0aGUgYnVzIGlzIGNvbnRyb2xsZWQgYnkgYSB0cmFuc2NlaXZlciwgdGhh
dA0KaGFzIGEgcGluIGNhbGxlZCBSRSAoUnggZW5hYmxlKSBvciBzaW1pbGFyLCB3aGljaCBjb25u
ZWN0cyB0aGUgYnVzIHRvIFJ4IHNpZ25hbA0Kb2YgdGhlIFVBUlQgY29udHJvbGxlci4gVGhpcyBw
YXRjaCBhZGRzIGEgYmluZGluZyBmb3IgYSBnZW5lcmljIGRlZmluaXRpb24gb2YgYQ0KR1BJTyB0
aGF0IGNhbiBzd2l0Y2ggYmV0d2VlbiB0d28gc3RhdGVzIHRvIGNvbnRyb2wgdGhlIFJFIHBpbiB2
aWEgYW4gZWxlY3RyaWNhbA0KY2lyY3VpdDoNCi0gQWN0aXZlOg0KICBUaGUgUkUgcGluIGlzIGFs
d2F5cyBhY3RpdmUuIFRoZSBVQVJUIFJ4IHNlZSBldmVyeXRoaW5nIG9uIHRoZSBidXMgYW5kDQog
IHRoZXJlZm9yZSBhbHNvIHdoYXQgaGFwcGVucyB3aXRoIHRoZSBUeCBzaWduYWwgb24gdGhlIGJ1
cy4NCi0gSW5hY3RpdmU6DQogIFRoZSBSRSBwaW4gaXMgYWx3YXlzIGFjdGl2ZSwgYnV0IGR1cmlu
ZyBzZW5kaW5nIG9uIHRoZSBidXMgdGhlIHBpbiBSRSBpcw0KICBpbmFjdGl2ZS4gU28gYmFzaWNh
bGx5IHRoZSByZWNlaXZpbmcgZHVyaW5nIHNlbmRpbmcgaXMgc3VwcHJlc3NlZC4NCg0KSXMgaXQg
bm93IG1vcmUgdW5kZXJzdGFuZGFibGUsIG9yIGhhdmUgSSBzdGlsbCBub3QgY29uc2lkZXJlZCBh
biBhc3BlY3Q/DQoNCg0KVGhhbmtzIGFuZCByZWdhcmRzDQpDaHJpc3RvcGgNCg==
