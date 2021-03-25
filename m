Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F012EC433DB
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B91B160240
	for <linux-serial@archiver.kernel.org>; Thu, 25 Mar 2021 11:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhCYLM6 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 25 Mar 2021 07:12:58 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34402 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230121AbhCYLMu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 25 Mar 2021 07:12:50 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12PB8KZQ029488;
        Thu, 25 Mar 2021 12:12:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=selector1;
 bh=sx81ySGR8bPSutf92/n2FFZ8Gn5Yxf3a1PbQ8ivsBJk=;
 b=THaUiffSVEE09/leQ/NJbBiJbM4G1JPDHfCcK6+DhsFlXjCaGLbUaB+JK1i7rujBaId1
 kHkC6iMyqIWdE9QxaRsmFW0+Unglqba0mCW1sYkecTtcwu3RfukLTZ50xGXSZy/9ookb
 VLp5dRBvYgm8oeEyCaGwKiXz0ptn9JBiAP4R0pm9FTc93EhyV1HuRvmF6IQ+hHoQ6XlU
 P1Z34fDFKPaZEy4Y3gt+IVEEq4AIC5JIw+JamI4Ptfo3IkuH7yMzZkgOddTChf1oNLad
 KwjmowvdAf3V+6/Ni3hHS6c3Iu+L3o5loaR1H1pgbg5UIHh7uh2aZP8GkGdqWfs5qiOI zQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 37d8tpv3wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Mar 2021 12:12:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7509510002A;
        Thu, 25 Mar 2021 12:12:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36D142463E6;
        Thu, 25 Mar 2021 12:12:22 +0100 (CET)
Received: from SFHDAG2NODE3.st.com (10.75.127.6) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Mar
 2021 12:12:21 +0100
Received: from SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c]) by
 SFHDAG2NODE3.st.com ([fe80::31b3:13bf:2dbe:f64c%20]) with mapi id
 15.00.1497.012; Thu, 25 Mar 2021 12:12:21 +0100
From:   Valentin CARON - foss <valentin.caron@foss.st.com>
To:     "dillon.minfei@gmail.com" <dillon.minfei@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        Alexandre TORGUE - foss <alexandre.torgue@foss.st.com>,
        "rong.a.chen@intel.com" <rong.a.chen@intel.com>,
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
        Erwan LE RAY <erwan.leray@st.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [PATCH v5 9/9] dt-bindings: serial: stm32: Use 'type: object'
 instead of false for 'additionalProperties'
Thread-Topic: [PATCH v5 9/9] dt-bindings: serial: stm32: Use 'type: object'
 instead of false for 'additionalProperties'
Thread-Index: AQHXIT7ih+t4cxLl+EWQ55a6uRUl+aqUfCqA
Date:   Thu, 25 Mar 2021 11:12:21 +0000
Message-ID: <068cb7ae-9afc-606d-2579-189e46516cd5@foss.st.com>
References: <1616653162-19954-1-git-send-email-dillon.minfei@gmail.com>
 <1616653162-19954-8-git-send-email-dillon.minfei@gmail.com>
In-Reply-To: <1616653162-19954-8-git-send-email-dillon.minfei@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="utf-8"
Content-ID: <82932ED2BBCA05459E35290288E3E327@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-25_02:2021-03-24,2021-03-25 signatures=0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgRGlsbG9uLA0KDQpJdCdzIG9rYXkgZm9yIG1lLg0KDQpSZWdhcmRzLA0KDQpWYWxlbnRpbg0K
DQpPbiAzLzI1LzIxIDc6MTkgQU0sIGRpbGxvbi5taW5mZWlAZ21haWwuY29tIHdyb3RlOg0KPiBG
cm9tOiBkaWxsb24gbWluIDxkaWxsb24ubWluZmVpQGdtYWlsLmNvbT4NCj4NCj4gVG8gdXNlIGFk
ZGl0aW9uYWwgcHJvcGVydGllcyAnYmx1ZXRvb3RoJyBvbiBzZXJpYWwsIG5lZWQgcmVwbGFjZSBm
YWxzZSB3aXRoDQo+ICd0eXBlOiBvYmplY3QnIGZvciAnYWRkaXRpb25hbFByb3BlcnRpZXMnIHRv
IG1ha2UgaXQgYXMgYSBub2RlLCBlbHNlIHdpbGwNCj4gcnVuIGludG8gZHRic19jaGVjayB3YXJu
aW5ncy4NCj4NCj4gJ2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyaDc1MGktYXJ0LXBpLmR0LnlhbWw6
IHNlcmlhbEA0MDAwNDgwMDoNCj4gJ2JsdWV0b290aCcgZG9lcyBub3QgbWF0Y2ggYW55IG9mIHRo
ZSByZWdleGVzOiAncGluY3RybC1bMC05XSsnDQo+DQo+IEZpeGVzOiBhZjFjMmQ4MTY5NWIgKCJk
dC1iaW5kaW5nczogc2VyaWFsOiBDb252ZXJ0IFNUTTMyIFVBUlQgdG8ganNvbi1zY2hlbWEiKQ0K
PiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBpbnRlbC5jb20+DQo+IFRlc3Rl
ZC1ieTogVmFsZW50aW4gQ2Fyb24gPHZhbGVudGluLmNhcm9uQGZvc3Muc3QuY29tPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBkaWxsb24gbWluIDxkaWxsb24ubWluZmVpQGdtYWlsLmNvbT4NCj4gLS0tDQo+
DQo+IHY1OiBhY2Nyb2RpbmcgdG8gcm9iJ3Mgc3VnZ2VzdGlvbiwgcmVwbGFjZSBmYWxzZSB3aXRo
ICd0eXBlOiBvYmplY3QnDQo+ICAgICAgb2YgJ2FkZGl0aW9uYWxQcm9wZXJ0aWVzJy4NCj4NCj4g
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMyLXVhcnQu
eWFtbCB8IDMgKystDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc2VyaWFsL3N0LHN0bTMyLXVhcnQueWFtbA0KPiBpbmRleCA4NjMxNjc4MjgzZjku
Ljg2NWJlMDUwODNjMyAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwNCj4gQEAgLTgwLDcg
KzgwLDggQEAgcmVxdWlyZWQ6DQo+ICAgICAtIGludGVycnVwdHMNCj4gICAgIC0gY2xvY2tzDQo+
ICAgDQo+IC1hZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gK2FkZGl0aW9uYWxQcm9wZXJ0
aWVzOg0KPiArICB0eXBlOiBvYmplY3QNCj4gICANCj4gICBleGFtcGxlczoNCj4gICAgIC0gfA==
