Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98EBC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 11:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F52E20812
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 11:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="QfmpB5VY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgFILiy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:38:54 -0400
Received: from mail-co1nam11on2048.outbound.protection.outlook.com ([40.107.220.48]:19289
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729056AbgFILiw (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 07:38:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bm/7JeZrpNwWEpu93kyRnQt2vz9INa1jmRnaZ6TQ1ZeP6huFXhYWnFwFU70QLo3yqi5LKBCPbrhVDhenuKKH5/9lYIPVGVsFhm07m8za3HmpSEySQYLr5V5n57BUsgsk5rRKWqtRxnATFYw3vnddp0KPF/sgfvsbv8ckueqCO8toJIDz0tmXcSN711LzXYanL1wcO3F7TKPHS4Rph/gfQCKzA+EBxVCIe3l6kloaxYSZqsS9WRmGSe2AzDJJMLa9BaUi2duz2oTvnPEGxONq4iXfDtsPazLogPluPmq/QIBKdmHy3rRcZre417MOBsy4E09k+Gg1YDCnOelYfVV4KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QzNuCon76Wngu9AGIH+LWL2Jn4/N41c7P8JyRqnR9c=;
 b=JGB3OYBRnwOTvrzzYxY+qb2zlOSl1NXl/q8SV9DEM3vzZmLJvjGxXHXKy7Vr6tm9WsqpWMvjjJOv605LC+xY98f+4/WcXFIN3ta9mfKEGwVIEdu8Wkq42Wa7fGLOYw8nShqx/JG5/g5KRYkRNh4FBjMBZb7YlXp+KNWxZ0IgMvQWXumsIpcgRwuU0nQz17zm7B/rj6rQrKHCoCUdDkNoh1VZUzd19CJCpsFsrXGtjzo9zJ0DI/vwxJd4PvfE30pxSuOPexjFxgX6+lCV5kXfi8whqmOzQvoVi9iEj/NIZ6v3QsCJraSNjTsifBsuixhuv0h9ZPGuvS6QmlmRLBVK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QzNuCon76Wngu9AGIH+LWL2Jn4/N41c7P8JyRqnR9c=;
 b=QfmpB5VYP/A5oTxjURzd4CXn4ylFE58ZIZc/Qhe0jJOwgnrHKmYk4u2U6LOjya1s/3VTncakxOgQlamY+MdGxzi4aeqK/FHm66c9Z6kSgAkcVsOU3hR0Ui/xl1V1/XwjPt1uWHozn9xcNqoiObel+1a00tU+p0KyS/JRvVC4WJU=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB3538.namprd10.prod.outlook.com (2603:10b6:408:b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 11:38:49 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 11:38:49 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "oneukum@suse.com" <oneukum@suse.com>
Subject: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUg==
Date:   Tue, 9 Jun 2020 11:38:49 +0000
Message-ID: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 23f5c670-198a-4b67-e346-08d80c69ad6b
x-ms-traffictypediagnostic: BN8PR10MB3538:
x-microsoft-antispam-prvs: <BN8PR10MB353808CCF7C3E0115D3E1C9AF4820@BN8PR10MB3538.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DHcHKh2lpIdEororlbMC4oA3/fxJUM4ClfacSySsNyk/UeTgTEI7X/rDMBUqh5ZPy8cxfxnMMAyoYBzBhINRL5YPB3/ACfkSR9euvifCgUNKDI7C0B4VKzV1rPwmh5O7DSnpdH0Mnkv0taVZj3BEXlWyEOFoezc4MjyNHHmzMd+TycXAvELiYlTH4jEbBwkHroNy68Zv0c2UPNc4BrJepyBQtsVBCPmcG3i2cEHgASydUyU1XqN8hW7hx9h4/5ahFzmfQG7XVid+x5DrwgcR28rQoAjD2Y2Zlilxt+LrUc95cxi51Q6sZEsS76ED2Lb0kmew8ttwtuLvtR2XHH1s5j1ZvFYk9ig1tDgP05QsXxybWBHe/hKGvGi1mGKPmZbY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(36756003)(4744005)(5660300002)(66946007)(76116006)(91956017)(316002)(6916009)(66556008)(66446008)(71200400001)(2616005)(66476007)(8676002)(64756008)(478600001)(6486002)(186003)(2906002)(26005)(8936002)(6506007)(86362001)(4326008)(6512007)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: yQkzBTkegkIV9lNgn6M5qNpWt8vj6RHCdxl8Li8nFy4YDFauVgzlLW7C9yercdRVAvH4+6/dOxw3YYK9jE2v9HDXn8k7aINWrT+14qU0+Hh89MrLWvDfBpZqQ5J2uGxzhOn+28cFjnLU50sqpVvSXYPCUUPpEEFpkPpCIk56D5jjc+Kgs/SAptvjmPOL3W8xD8UgXpX19yz8mMi7GW01deP/Fbk4SUe//iJfGYGTMLGjunIvlZKKPdBu8jPfYbyvESGqZUlVQQumXTbnK5P6EdEKaGYlKu51FTCs6byP7u+iAGvnxCaira8JRch5of7k/76WSlk1/BM+GPAIjQ5N8jrSNbFZ3AGyR3HfNKqKOdfXgx7hL6WuVj+ApwISEbWWwG0TdqG64vRevA9Z3HkLDcqtj8+wAN+eNcF0Wirw4/Q9Nre/khikSEn/hxgHVxiqe11yK+4j9XUf12L6Ihzt68q2t0v6O7HlV3G6ruPPpG8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <7243D025C223E94C93AA33A50068698A@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23f5c670-198a-4b67-e346-08d80c69ad6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 11:38:49.2584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 584xpqf1IV3/ZJA3LuG3NTE02bCKBU/hyJEockBR0JaGaULQ9T9oMOJkIOk/5IlhUjie8b76dc14o1e0VxldBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3538
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

SGkgTGlzdA0KDQpJIHdhcyBhZHZpc2VkIHRvIGNvbWUgaGVyZSB3aXRoIHRoaXMgcHJvYmxlbShz
dGFydGVkIG9uIHRoZSBVU0IgbGlzdCkuDQoNCldlIGhhdmUgYSBVU0IgdG8gUlMyMzIgYnJpZGdl
IHdoaWNoIHByZXNlbnRzIGl0c2VsZiBhcyBhbiB0dHlBQ00gYW5kIHRoZSBmaXJzdCBjb25uZWN0
IGFmdGVyIHBvd2VyIG9uLA0Kd2Ugc2VlIHNvbWUgZ2FyYmFnZSBjaGFycyB0cmFuc21pdHRlZCBi
YWNrIGZyb20gVVNCIGhvc3QoUEMpIHRvIG91dCBkZXZpY2Ugd2hpY2ggYmVjb21lcyBpbnB1dCB0
bw0KdGhlIGRldmljZS4NCg0KQWZ0ZXIgbXVjaCBkZWJ1Z2dpbmcgSSBmb3VuZCB0aGF0IHRoaXMg
YXJlIGNoYXJzIHNlbnQgZWFybHkgaW4gdGhlIGJvb3QgcHJvY2VzcyB3aGljaCB0aGVuDQphcmUg
YnVmZmVyZWQgYW5kIHRoZSBUVFlzIGRlZmF1bHQgdG8gRUNITyBjaGFycyBpcyB0aGUgY2F1c2Uu
DQoNCldoZW4gdGhlIFRUWSBpcyBvcGVuZWQsIGFueSBjaGFycyBpbiB0aGUgdGhpcyBidWZmZXIg
aXMgRUNIT2VkIGJhY2sgb3ZlciBVU0IgdG8gdGhlIGRldmljZSwNCmJlZm9yZSBvbmUgaGFzIGEg
Y2hhbmNlIHRvIGRpc2FibGUgRUNITy4gVGhlIGRldmljZSB0aGVuIHRoaW5rcyB0aGVzZSBjaGFy
cyBhcmUgcmVndWxhciBpbnB1dC4NCg0KU2VlbXMgdG8gbWUgdGhhdCB0aGlzIGJlaGF2aW91ciBp
cyB1bndhbnRlZCBpbiBnZW5lcmFsIGFuZCBhbmQgYXBwLiBzaG91bGQgZ2V0IGEgY2hhbmNlIHRv
IGZsdXNoL2Rpc2NhcmQNCmFueSBjaGFycyBzbyB0aGlzIGRvZXMgbm90IGhhcHBlbi4NCg0KV2hh
dCBkbyB5b3UgdGhpbms/DQogDQo=
