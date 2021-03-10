Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2B2C433E0
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 08:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D5764FE7
	for <linux-serial@archiver.kernel.org>; Wed, 10 Mar 2021 08:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbhCJImF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 10 Mar 2021 03:42:05 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:9122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231539AbhCJIl7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 10 Mar 2021 03:41:59 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12A8Gqm2032122;
        Wed, 10 Mar 2021 09:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=selector1;
 bh=EGWBG9H2dj1JOuRZp9raVFHziFicf+Gku0YgY3zajzc=;
 b=nX4SJiobo7ikV/qN8W0aqaT0z4OtG/QSLvEFeCZJrAkknLhRvo2WTS+EsBiIgXhHKlML
 7tkeVYpoRl073uy2ApFlcL4cg+DHpW/bO1JsjTUzkqCMQVJNgo88RE7TH2mU4SX0WxvA
 dgdK+OH8NcWLJswHt7XeusEctHgdVQY3ep8Dtjo51SWRPVTFMq0ryh6SlaCa82CXj4iu
 sEr6OvGDABydXncO81i/wkSj2TAT/+3x/3OT+krBrtCO8HZgv5znYJxtqVAYh6HAjHHc
 H/y6QKGYXisHrvWp8CAfs9aoqXAr3u24U6zkKDFGi3EMkCKm3wqYR9+ngqOBSJbACE7F 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 373yreqjwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Mar 2021 09:41:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B631B10002A;
        Wed, 10 Mar 2021 09:41:43 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A1D1C22616C;
        Wed, 10 Mar 2021 09:41:43 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 10 Mar
 2021 09:41:43 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1473.003; Wed, 10 Mar 2021 09:41:43 +0100
From:   Valentin CARON - foss <valentin.caron@foss.st.com>
To:     Rob Herring <robh@kernel.org>
CC:     Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Erwan LE-RAY - foss <erwan.leray@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: stm32: add examples
Thread-Topic: [PATCH] dt-bindings: serial: stm32: add examples
Thread-Index: AQHXEfDj1skxal1T3EamiE+nrv7Bzqp83agA
Date:   Wed, 10 Mar 2021 08:41:43 +0000
Message-ID: <60c2caa0-4b69-4460-63b4-6debf1065c42@foss.st.com>
References: <20210209095948.15889-1-valentin.caron@foss.st.com>
 <20210305185347.GA466473@robh.at.kernel.org>
In-Reply-To: <20210305185347.GA466473@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8D4E22DB76473D4F896CC6A013180C20@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-10_04:2021-03-09,2021-03-10 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

DQpPbiAzLzUvMjEgNzo1MyBQTSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDA5
LCAyMDIxIGF0IDEwOjU5OjQ4QU0gKzAxMDAsIFZhbGVudGluIENhcm9uIHdyb3RlOg0KPj4gRnJv
bTogVmFsZW50aW4gQ2Fyb24gPHZhbGVudGluLmNhcm9uQHN0LmNvbT4NCj4+DQo+PiBBZGQgZXhh
bXBsZXMgdG8gc2hvdyBtb3JlIHVzZSBjYXNlcyA6DQo+PiAgIC0gdWFydDIgd2l0aCBoYXJkd2Fy
ZSBmbG93IGNvbnRyb2wNCj4+ICAgLSB1YXJ0NCB3aXRob3V0IGZsb3cgY29udHJvbA0KPiBXaHkg
ZG8gSSBuZWVkIHRoZXNlPyBJIGNhbiBnbyByZWFkIHlvdXIgZHRzIGZpbGVzIGlmIEkgbmVlZCBt
b3JlDQo+IGV4YW1wbGVzLg0KSGksDQoNClRoZXNlIGV4YW1wbGVzIHdlcmUgcHJlc2VudCBpbiB0
aGUgZHQtYmluZGluZyBiZWZvcmUgdGhlIGNvbnZlcnRpb24gdG8gDQpqc29uIDoNCg0KaHR0cHM6
Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LWFybS1rZXJuZWwvcGF0Y2gvMjAy
MDAxMjIwOTU1NTguMjI1NTMtMy1iZW5qYW1pbi5nYWlnbmFyZEBzdC5jb20vDQoNCldvdWxkIHlv
dSBsaWtlIGEgdjIgd2l0aCB0aGlzIHByZWNpc2lvbiA/DQpIb3dldmVyIHRoaXMgaXMgbm90IGFu
IGVzc2VudGlhbCBwYXRjaCwgd2UgY2FuIGp1c3QgZHJvcCBpdC4NCj4NCj4+IFNpZ25lZC1vZmYt
Ynk6IFZhbGVudGluIENhcm9uIDx2YWxlbnRpbi5jYXJvbkBmb3NzLnN0LmNvbT4NCj4+IC0tLQ0K
Pj4gICAuLi4vYmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMyLXVhcnQueWFtbCAgICAgICAgfCAyMCAr
KysrKysrKysrKysrKysrKysrDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCsp
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9z
ZXJpYWwvc3Qsc3RtMzItdWFydC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwNCj4+IGluZGV4IDA2ZDVmMjUxZWM4OC4uM2E0
YWFiNWQxODYyIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc3Qsc3RtMzItdWFydC55YW1sDQo+PiBAQCAtODIsNiAr
ODIsMjYgQEAgYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+PiAgIGV4YW1wbGVzOg0KPj4g
ICAgIC0gfA0KPj4gICAgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL3N0bTMybXAxLWNs
a3MuaD4NCj4+ICsNCj4+ICsgICAgdXNhcnQ0OiBzZXJpYWxANDAwMDRjMDAgew0KPj4gKyAgICAg
IGNvbXBhdGlibGUgPSAic3Qsc3RtMzItdWFydCI7DQo+PiArICAgICAgcmVnID0gPDB4NDAwMDRj
MDAgMHg0MDA+Ow0KPj4gKyAgICAgIGludGVycnVwdHMgPSA8NTI+Ow0KPj4gKyAgICAgIGNsb2Nr
cyA9IDwmY2xrX3BjbGsxPjsNCj4+ICsgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0K
Pj4gKyAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF91c2FydDQ+Ow0KPj4gKyAgICB9Ow0KPj4g
Kw0KPj4gKyAgICB1c2FydDI6IHNlcmlhbEA0MDAwNDQwMCB7DQo+PiArICAgICAgY29tcGF0aWJs
ZSA9ICJzdCxzdG0zMi11YXJ0IjsNCj4+ICsgICAgICByZWcgPSA8MHg0MDAwNDQwMCAweDQwMD47
DQo+PiArICAgICAgaW50ZXJydXB0cyA9IDwzOD47DQo+PiArICAgICAgY2xvY2tzID0gPCZjbGtf
cGNsazE+Ow0KPj4gKyAgICAgIHN0LGh3LWZsb3ctY3RybDsNCj4+ICsgICAgICBwaW5jdHJsLW5h
bWVzID0gImRlZmF1bHQiOw0KPj4gKyAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF91c2FydDIg
JnBpbmN0cmxfdXNhcnQyX3J0c2N0cz47DQo+PiArICAgIH07DQo+PiArDQo+PiAgICAgICB1c2Fy
dDE6IHNlcmlhbEA0MDAxMTAwMCB7DQo+PiAgICAgICAgIGNvbXBhdGlibGUgPSAic3Qsc3RtMzIt
dWFydCI7DQo+PiAgICAgICAgIHJlZyA9IDwweDQwMDExMDAwIDB4NDAwPjsNCj4+IC0tIA0KPj4g
Mi4xNy4xDQo+Pg==
