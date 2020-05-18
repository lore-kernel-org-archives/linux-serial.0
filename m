Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D5C433E1
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 07:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B2C520657
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 07:26:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="DD4gCEFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgERH0D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 03:26:03 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23056 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726872AbgERH0C (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 03:26:02 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04I7MwVY000489;
        Mon, 18 May 2020 09:25:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=STMicroelectronics;
 bh=96Qx9T4l9btbZlYCanjYMz8LWe4TWd5HlYaC0S7keCg=;
 b=DD4gCEFgAjLIf4Sdl2mn9FNSK0ht4/M3toLBzrVmSh+c/wn2sbrhNyuuouB5oe6xHr2D
 cwb64BE6kpGK8tDbyi4Caqw4baabKjaPGqfMWOABIOrR5/aH9PBQYXCIXtSWnBFwHBpZ
 MgIlR8EdstvmG4VKciLF65st+VguxD/4aos+MPgfLC4udP05rP2MDRx73m2MJbMmRvFZ
 CpwS53KCF2gkXYGZrlwfswGv5bbFnPLBH0mAheWn41DooCt6DXktVBSVaaLDgIMmlpaO
 YD+ytoJ5VCnvL7MqBB1pjpDGGdIY9tkM4urxlYIf2EZt/GodnLmq/N/5Om6qUeqvlpDy zg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3125xxj4ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 09:25:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D6AE310002A;
        Mon, 18 May 2020 09:25:47 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node2.st.com [10.75.127.14])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C12FF2A759E;
        Mon, 18 May 2020 09:25:47 +0200 (CEST)
Received: from SFHDAG3NODE1.st.com (10.75.127.7) by SFHDAG5NODE2.st.com
 (10.75.127.14) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 May
 2020 09:25:47 +0200
Received: from SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86]) by
 SFHDAG3NODE1.st.com ([fe80::1166:1abb:aad4:5f86%20]) with mapi id
 15.00.1473.003; Mon, 18 May 2020 09:25:47 +0200
From:   Erwan LE RAY <erwan.leray@st.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "mani@kernel.org" <mani@kernel.org>
CC:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Linux-stm32] [PATCH v3 1/2] dt-bindings: serial: Document
 CTS/RTS gpios in STM32 UART
Thread-Topic: [Linux-stm32] [PATCH v3 1/2] dt-bindings: serial: Document
 CTS/RTS gpios in STM32 UART
Thread-Index: AQHWLOKqKuTyIkoopEKFBSTOruYjFqitT8sA
Date:   Mon, 18 May 2020 07:25:47 +0000
Message-ID: <4ff30338-e704-12bd-80fe-82b8c08e78d9@st.com>
References: <20200420170204.24541-1-mani@kernel.org>
 <20200420170204.24541-2-mani@kernel.org>
 <CAMuHMdVGem_2BGQK4dqZQb3sOd0LZk+RS_z4SvSRcNECEJHdwA@mail.gmail.com>
In-Reply-To: <CAMuHMdVGem_2BGQK4dqZQb3sOd0LZk+RS_z4SvSRcNECEJHdwA@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.49]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9984B761F26544187A953C83E9086B0@st.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_02:2020-05-15,2020-05-18 signatures=0
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgR2VlcnQsDQoNCg0KT24gNS8xOC8yMCA5OjA0IEFNLCBHZWVydCBVeXR0ZXJob2V2ZW4gd3Jv
dGU6DQo+IEhpIE1hbmksDQo+DQo+IE9uIE1vbiwgQXByIDIwLCAyMDIwIGF0IDc6MDIgUE0gPG1h
bmlAa2VybmVsLm9yZz4gd3JvdGU6DQo+PiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0gPG1h
bmlAa2VybmVsLm9yZz4NCj4+DQo+PiBEb2N1bWVudCB0aGUgdXNlIG9mIENUUy9SVFMgZ3Bpb3Mg
Zm9yIGZsb3cgY29udHJvbCBpbiBTVE0zMiBVQVJUDQo+PiBjb250cm9sbGVyLiBUaGVzZSBwcm9w
ZXJ0aWVzIGNhbiBiZSB1c2VkIGluc3RlYWQgb2YgJ3N0LGh3LWZsb3ctY3RybCcNCj4+IGZvciBt
YWtpbmcgdXNlIG9mIGFueSBncGlvIHBpbnMgZm9yIGZsb3cgY29udHJvbCBpbnN0ZWFkIG9mIGRl
ZGljYXRlZA0KPj4gcGlucy4gSXQgc2hvdWxkIGJlIG5vdGVkIHRoYXQgYm90aCBDVFMvUlRTIGFu
ZCAnc3QsaHctZmxvdy1jdHJsJw0KPj4gcHJvcGVydGllcyBjYW5ub3QgY28tZXhpc3QgaW4gYSBk
ZXNpZ24uDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IEFuZHkgU2hldmNoZW5rbyA8YW5keS5zaGV2Y2hl
bmtvQGdtYWlsLmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8
bWFuaUBrZXJuZWwub3JnPg0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NlcmlhbC9zdCxzdG0zMi11YXJ0LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvc3Qsc3RtMzItdWFydC55YW1sDQo+PiBAQCAtNTUsNiAr
NjEsMTQgQEAgcHJvcGVydGllczoNCj4+ICAgICBsaW51eCxyczQ4NS1lbmFibGVkLWF0LWJvb3Qt
dGltZTogdHJ1ZQ0KPj4gICAgIHJzNDg1LXJ4LWR1cmluZy10eDogdHJ1ZQ0KPj4NCj4+ICtpZjoN
Cj4+ICsgIHJlcXVpcmVkOg0KPj4gKyAgICAtIHN0LGh3LWZsb3ctY3RybA0KPiBQZXJoYXBzICJz
dCxody1mbG93LWN0cmwiIHNob3VsZCBiZSBkZXByZWNhdGVkLCBpbiBmYXZvciBvZiB0aGUgc3Rh
bmRhcmQNCj4gInVhcnQtaGFzLXJ0c2N0cyIgcHJvcGVydHk/DQo+IE9mIGNvdXJzZSB0aGUgZHJp
dmVyIG5lZWRzIHRvIGdhaW4gc3VwcG9ydCBmb3IgdGhlIGxhdHRlciBmaXJzdC4NCg0KWW91J3Jl
IGZ1bGx5IHJpZ2h0LCB0aGUgcGF0Y2ggdG8gZGVwcmVjYXRlICJzdCwgaHctZmxvdy1jdHJsIiBh
bmQgDQppbnRyb2R1Y2UgZ2VuZXJpYyAidWFydC1oYXMtcnRzY3RzIiBwcm9wZXJ0eSBpbiB0aGUg
ZHJpdmVyIGlzIHJlYWR5IGFuZCANCndpbGwgYmUgc2VudCB0aGlzIHdlZWsgb24gdG9wIG9mIE1h
bmkgcGF0Y2guDQoNCg0KPg0KPj4gK3RoZW46DQo+PiArICBwcm9wZXJ0aWVzOg0KPj4gKyAgICBj
dHMtZ3Bpb3M6IGZhbHNlDQo+PiArICAgIHJ0cy1ncGlvczogZmFsc2UNCj4+ICsNCj4+ICAgcmVx
dWlyZWQ6DQo+PiAgICAgLSBjb21wYXRpYmxlDQo+PiAgICAgLSByZWcNCj4gR3J7b2V0amUsZWV0
aW5nfXMsDQo+DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBHZWVydA0KPg==
