Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDFCC433C1
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3011961879
	for <linux-serial@archiver.kernel.org>; Mon, 22 Mar 2021 11:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbhCVLGG (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 22 Mar 2021 07:06:06 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:40512 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230384AbhCVLFf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 22 Mar 2021 07:05:35 -0400
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12MAudE4013707;
        Mon, 22 Mar 2021 12:05:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=selector1;
 bh=Pymfk/EgZE9Sai/go/LCUbW5Sj5kXKwBZSorsF6E/JM=;
 b=AS1MsmI1/uy4Sqoh816U7Rf3Y4jB9++nFcdz5kCsetmSk2Iey3fDSAJZWiUPA8dmOsan
 cg1qUuooc9ceCD1crogkfyUqwd7vOUTAmK4ul6KOWPoiephnLdt88q8+Uh68SLUEsmVt
 FqBo76MwbFm7NEuC0Al0+j1GsRNXc8j89xjU4BK1CbkbRAtnP1jgdK6qLJSx9xxxEK0E
 9MPtSVMMKqxiJ6cimeucoxj0T4rBVpJddbanKv+r8pCWWRAatphwWnGEcq5MXjAzC0lk
 Mv9/0lymVBMCXAur+C/5mrNwpfWb+0AsyR/6BZSByxKWhOFsmRuygl8gnSBDLHL+Lpku lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d9968xhu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Mar 2021 12:05:06 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4829C10002A;
        Mon, 22 Mar 2021 12:05:04 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B8BF2463CD;
        Mon, 22 Mar 2021 12:05:04 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 22 Mar
 2021 12:05:03 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1497.012; Mon, 22 Mar 2021 12:05:03 +0100
From:   Valentin CARON - foss <valentin.caron@foss.st.com>
To:     "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "Alexandre TORGUE - foss" <alexandre.torgue@foss.st.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "vladimir.murzin@arm.com" <vladimir.murzin@arm.com>,
        "afzal.mohd.ma@gmail.com" <afzal.mohd.ma@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Erwan LE-RAY - foss" <erwan.leray@foss.st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [Linux-stm32] [PATCH v4 9/9] dt-bindings: serial: stm32: Use
 'unevaluatedProperties' instead of 'additionalProperties'
Thread-Topic: [Linux-stm32] [PATCH v4 9/9] dt-bindings: serial: stm32: Use
 'unevaluatedProperties' instead of 'additionalProperties'
Thread-Index: AQHXHws10grT1ARp1UKFub73w++Z4Q==
Date:   Mon, 22 Mar 2021 11:05:03 +0000
Message-ID: <5f95b6ad-ddbe-8394-8599-e78f30c8b62c@foss.st.com>
References: <1616205383-24114-1-git-send-email-dillon.minfei@gmail.com>
 <1616205383-24114-8-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1616205383-24114-8-git-send-email-dillon.minfei@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.48]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3C33FA9F1EEDA74F9DCE468962861821@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-22_04:2021-03-22,2021-03-22 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgRGlsbG9uLA0KDQpJdCB3b3JrcyBmb3IgbWUuDQoNCk9uIDMvMjAvMjEgMjo1NiBBTSwgZGls
bG9uLm1pbmZlaUBnbWFpbC5jb20gd3JvdGU6DQo+IEZyb206IGRpbGxvbiBtaW4gPGRpbGxvbi5t
aW5mZWlAZ21haWwuY29tPg0KPg0KPiBUbyB1c2UgYWRkaXRpb25hbCBwcm9wZXJ0aWVzICdibHVl
dG9vdGgnLCBuZWVkIHVzZSB1bmV2YWx1YXRlZFByb3BlcnRpZXMNCj4gdG8gZml4IGR0YnNfY2hl
Y2sgd2FybmluZ3MuDQo+DQo+ICdhcmNoL2FybS9ib290L2R0cy9zdG0zMmg3NTBpLWFydC1waS5k
dC55YW1sOiBzZXJpYWxANDAwMDQ4MDA6ICdibHVldG9vdGgnDQo+IGRvZXMgbm90IG1hdGNoIGFu
eSBvZiB0aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAtOV0rJw0KPg0KPiBSZXBvcnRlZC1ieToga2Vy
bmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IEZpeGVzOiBhZjFjMmQ4MTY5NWIgKCJk
dC1iaW5kaW5nczogc2VyaWFsOiBDb252ZXJ0IFNUTTMyIFVBUlQgdG8ganNvbi1zY2hlbWEiKQ0K
DQpZb3UgY2FuIGFkZCBteToNClRlc3RlZC1ieTogVmFsZW50aW4gQ2Fyb24gPHZhbGVudGluLmNh
cm9uQGZvc3Muc3QuY29tPg0KDQo+IFNpZ25lZC1vZmYtYnk6IGRpbGxvbiBtaW4gPGRpbGxvbi5t
aW5mZWlAZ21haWwuY29tPg0KPiAtLS0NCj4NCj4gdjQ6DQo+IC0gYWRkIFJlcG9ydGVkLWJ5IGFu
ZCBGaXhlcyB0YWcNCj4gLSB1c2UgdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZSB0byBmaXgg
ZHRic19jaGVjayB3YXJybmluZ3MgaW5zdGVhZCBvZg0KPiAgICBhZGQgJ2JsdWV0b290aCcgaW4g
c3Qsc3RtMzItdWFydC55YW1sDQo+DQo+ICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwgfCAyICstDQo+ICAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMyLXVhcnQueWFtbCBiL0Rv
Y3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc3Qsc3RtMzItdWFydC55YW1s
DQo+IGluZGV4IDg2MzE2NzgyODNmOS4uMzA1OTQxYjFkNWEwIDEwMDY0NA0KPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMyLXVhcnQueWFtbA0K
PiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMy
LXVhcnQueWFtbA0KPiBAQCAtODAsNyArODAsNyBAQCByZXF1aXJlZDoNCj4gICAgIC0gaW50ZXJy
dXB0cw0KPiAgICAgLSBjbG9ja3MNCj4gICANCj4gLWFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KPiAgIA0KPiAgIGV4YW1wbGVzOg0K
PiAgICAgLSB8DQoNClJlZ2FyZHMsDQpWYWxlbnRpbg0K
