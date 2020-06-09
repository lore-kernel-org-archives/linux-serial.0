Return-Path: <SRS0=2Hcl=7W=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6638CC433E0
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 13:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2251B2074B
	for <linux-serial@archiver.kernel.org>; Tue,  9 Jun 2020 13:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=infinera.com header.i=@infinera.com header.b="bK3VmC7R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFINNK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 9 Jun 2020 09:13:10 -0400
Received: from mail-eopbgr700074.outbound.protection.outlook.com ([40.107.70.74]:13484
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726937AbgFINNJ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 9 Jun 2020 09:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGeEvO6bbH4p1poJ9gykgqTMvFg1v+N1hiJEAmTl6Otb8CSVsS0dH3SW0ASqwwRCoC9diewc6G0dtDJBCETRMGtp80YjyVw2tGEcPl09WNihaMOKjxYTnxJgAwG9E7rQuim43JPygoPDDIJR2sHYTr+/nrG+0SHv6OB8zD5Zh6wKEfYVexmsNul1c3w8r5qxlHiA558rFQu095XtzwJT9GEFCbv/7Z53TFQfQYkkQ7TeEJC01O18KMMzlaXs1DkCGQYeIZ48sUZdtDzL9HHJ5sTSfoFEbBgULG9IHyyYzsx1SqGrxt/acy1hr/3OxTD2zv2Lr09PplhSpFeg1+D1Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V94gZ/g6pD8OOr6iWSe1hJHSAnajpUcq+KO5qG1sI1A=;
 b=ERNA09pQc2BvIsXgEyqyUrJXlMGpqeGa3qSM3n9atET9c/PfRa1Ojobxe8DFd8QHHfpLIoZlCtu3VtZollOSdrZwo64I7aMz9r1ph2YeDDqDM46UkxSdd/iRBYnNMLEL+O9GReRyM4nv+OB3Lo0myUuFjnXNZejgT2EBBQiY+PUD1llmAdZdoHx5U88TNx4+TbbTOl+51Gp9AM2ecM64iyBnDm4WgsTDe1yiquC9HxloGyMtRj4741AiCoa3qblf5tEIdpocDZR7fpfHiw7kmj1DFnxNvB7dhBaeoB81NjD1N0wAPUUtQcMXnhwuZmjQjdPjvFl/mFhsSx3iDwLOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V94gZ/g6pD8OOr6iWSe1hJHSAnajpUcq+KO5qG1sI1A=;
 b=bK3VmC7RAtjKlPtP7qorSNgoAcV1Wb5TDjbnhe+2sf1vYcVDzyHPe3Pt5z2Af5VxcCa2F5zIS/BqDR/he1apwnenGBe5YP83cLx9SOlB+UkrxiuUfS319l2Dp39G7DEHHyIp17IY/XLhSLHjXw/X+o69+svluRHdFJtAQ34/YuE=
Received: from BN8PR10MB3540.namprd10.prod.outlook.com (2603:10b6:408:ae::24)
 by BN8PR10MB3362.namprd10.prod.outlook.com (2603:10b6:408:cf::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Tue, 9 Jun
 2020 13:13:06 +0000
Received: from BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941]) by BN8PR10MB3540.namprd10.prod.outlook.com
 ([fe80::c158:d59f:e3bc:1941%2]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 13:13:06 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "oneukum@suse.com" <oneukum@suse.com>
Subject: Re: Default ECHO on TTYs causes unwanted garbage chars
Thread-Topic: Default ECHO on TTYs causes unwanted garbage chars
Thread-Index: AQHWPlKKxJr0ir3sA0SM2brkyH1CUqjQLZMAgAAVM4A=
Date:   Tue, 9 Jun 2020 13:13:06 +0000
Message-ID: <984225ab9969a18fc67244a69b71c1534174d4f9.camel@infinera.com>
References: <d6d376ceb45b5a72c2a053721eabeddfa11cc1a5.camel@infinera.com>
         <20200609115712.GD819153@kroah.com>
In-Reply-To: <20200609115712.GD819153@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.3 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6861809d-cc96-4b11-bc0e-08d80c76d96a
x-ms-traffictypediagnostic: BN8PR10MB3362:
x-microsoft-antispam-prvs: <BN8PR10MB336291BFEDA94F3FD058A07EF4820@BN8PR10MB3362.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +l2HKa5WXnr4n5zDw+LTaQSDOhRr87i35KECnaaUP+pYT9JUZOD+frK951EXgIGGof/FGd7rKVgU+E6DbkWy3Vfq0cNhqusiv/M51DvsWdoR2267Uv6LMqbZ3LvRCaqFBmCnHZ/r+Qp97eY9Z+I/Q06JgtEElJVL6KCjiKZ9+k9x+izlR2nofcQz6Acs9oJRyysu4PVz0+JlhnNuaasDLIrJ6+npjJhnc/7WBs9GashUxhgpxXaoLwb50gs9CsTo0L9SZlce2LR5aq2df7aGFIW5RzgKw+ep4alcMllWE19HNtk5Sfcr7gldnNXDj56DRONV9dlI7vO2Wzf+ISfP2TSNVH0hGSncladHtPDKVbivUU3SGCB571gVKHJxP2uZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3540.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(6486002)(5660300002)(54906003)(2616005)(2906002)(71200400001)(478600001)(4326008)(8936002)(186003)(86362001)(6512007)(36756003)(66476007)(26005)(6506007)(8676002)(66446008)(76116006)(66946007)(64756008)(316002)(91956017)(66556008)(6916009)(26123001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 96aFDR6IGrtB3xpf3hjrv1GRAmjnKRODfE6r4ufbAAoh+XNNNjEVMLfBXDQReAp5/fC/hAESXoI3kc3dhBomWvyeT/vOL0a52bRugji3ZW7Gwl7KuRTthKhCu9gP+irCUxHrMcegfNTXUHVBo2LOzJituoXHXGkyZ8lJrqzypwZ1Zn/m/5GaptfP2qOPZLfXqfgavZnNIucWsMp1XEJDlXlPFsZJTBI8sCpIEReYT9lLEcF3zBnkZYRJU589OWKo3jWKgB1EjTPdqbyLS4B0RI9LPZpXDvLxkaSH5oi61XxBlU2LEOgQXHh1HffCSGsG3pH44ttMCdneOj7QUSLtNhArJmV1S7vDl4oecFwB9XqgBP0bkJX3G+ncl5OXgiwYQTlbCzkZxlCk2e/NzUPR74eP4Cbs0oWBYAIPDkoOoTLCYn7PvZVmDYgLFUfZO20L8LdE3V7kKdKo9lG3s+UWV/Gj/LcioFHTHJDh7C7zWls=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5D5D84E4FC7CE4890B25442B8F34F5B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6861809d-cc96-4b11-bc0e-08d80c76d96a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 13:13:06.5820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0KMuPa1SDebB1UvmNlrt3z5neuFGZHXtdVi6hs8MUs0R53ZWwbHerTXIcdzewcefSqbCNYQeGYZz82KbWEoRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3362
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTA5IGF0IDEzOjU3ICswMjAwLCBHcmVnIEtIIHdyb3RlOg0KPiANCj4g
T24gVHVlLCBKdW4gMDksIDIwMjAgYXQgMTE6Mzg6NDlBTSArMDAwMCwgSm9ha2ltIFRqZXJubHVu
ZCB3cm90ZToNCj4gPiBIaSBMaXN0DQo+ID4gDQo+ID4gSSB3YXMgYWR2aXNlZCB0byBjb21lIGhl
cmUgd2l0aCB0aGlzIHByb2JsZW0oc3RhcnRlZCBvbiB0aGUgVVNCIGxpc3QpLg0KPiA+IA0KPiA+
IFdlIGhhdmUgYSBVU0IgdG8gUlMyMzIgYnJpZGdlIHdoaWNoIHByZXNlbnRzIGl0c2VsZiBhcyBh
biB0dHlBQ00gYW5kIHRoZSBmaXJzdCBjb25uZWN0IGFmdGVyIHBvd2VyIG9uLA0KPiA+IHdlIHNl
ZSBzb21lIGdhcmJhZ2UgY2hhcnMgdHJhbnNtaXR0ZWQgYmFjayBmcm9tIFVTQiBob3N0KFBDKSB0
byBvdXQgZGV2aWNlIHdoaWNoIGJlY29tZXMgaW5wdXQgdG8NCj4gPiB0aGUgZGV2aWNlLg0KPiA+
IA0KPiA+IEFmdGVyIG11Y2ggZGVidWdnaW5nIEkgZm91bmQgdGhhdCB0aGlzIGFyZSBjaGFycyBz
ZW50IGVhcmx5IGluIHRoZSBib290IHByb2Nlc3Mgd2hpY2ggdGhlbg0KPiA+IGFyZSBidWZmZXJl
ZCBhbmQgdGhlIFRUWXMgZGVmYXVsdCB0byBFQ0hPIGNoYXJzIGlzIHRoZSBjYXVzZS4NCj4gDQo+
IFNvIHNvbWUgcHJvZ3JhbSBpbiB0aGUgYm9vdCBzZXF1ZW5jZSBpcyB0cnlpbmcgdG8gc2VuZCBk
YXRhIG91dCB0aGUNCj4gZGV2aWNlPyAgV2h5IG5vdCBqdXN0IG5vdCBkbyB0aGF0Pw0KDQpUaGlz
IGlzIHRoZSBib290IGNvbnNvbGUuIEJvdGggdS1ib290IGFuZCBMaW51eCBwcmludHMgYSBsb3Qg
dGhlcmUsIHRoZW4gaW5pdCBwcmludHMgd2hpbGUgc3RhcnRpbmcgc2VydmljZXMNCg0KPiANCj4g
PiBXaGVuIHRoZSBUVFkgaXMgb3BlbmVkLCBhbnkgY2hhcnMgaW4gdGhlIHRoaXMgYnVmZmVyIGlz
IEVDSE9lZCBiYWNrIG92ZXIgVVNCIHRvIHRoZSBkZXZpY2UsDQo+ID4gYmVmb3JlIG9uZSBoYXMg
YSBjaGFuY2UgdG8gZGlzYWJsZSBFQ0hPLiBUaGUgZGV2aWNlIHRoZW4gdGhpbmtzIHRoZXNlIGNo
YXJzIGFyZSByZWd1bGFyIGlucHV0Lg0KPiANCj4gV2FpdCwgeW91IHNhaWQgc29tZXRoaW5nIGlu
IHRoZSBib290IHByb2Nlc3MgZGlkIHdyaXRlIHRvIHRoZSBkZXZpY2UsDQo+IHdoaWNoIHdvdWxk
IGhhdmUgY2F1c2VkIHRoZSB0dHkgdG8gYmUgb3BlbmVkIHRoZW4sIHJpZ2h0Pw0KDQp3ZWxsLCBi
b290IHByb2Nlc3Mgb2YgdGhlIGRldmljZSBwcmludHMgYW5kIGl0IGlzIGVub3VnaCBmb3IgdGhl
IFVTQiBjYWJsZSB0byBiZSBhdHRhY2hlZCBidXQgbm90IG9wZW5lZCBieSBhbnkgYXBwLg0KVGhl
IGRldmljZSBqdXN0IHNlZSBhbiBVQVJUIGFuZCBwcmludHMgd2hlbiBVQVJUIGlzIGluaXRpYWxp
emVkLg0KDQo+IA0KPiA+IFNlZW1zIHRvIG1lIHRoYXQgdGhpcyBiZWhhdmlvdXIgaXMgdW53YW50
ZWQgaW4gZ2VuZXJhbCBhbmQgYW5kIGFwcC4gc2hvdWxkIGdldCBhIGNoYW5jZSB0byBmbHVzaC9k
aXNjYXJkDQo+ID4gYW55IGNoYXJzIHNvIHRoaXMgZG9lcyBub3QgaGFwcGVuLg0KPiANCj4gV2hl
cmUgYXJlIHRoZSBjaGFyYWN0ZXJzIGNvbWluZyBmcm9tIHRoYXQgd291bGQgbmVlZCB0byBiZSBm
bHVzaGVkPw0KDQpFYXJseSBvdXRwdXQgZnJvbSBib290LCBiYXNpY2FsbHkgd2hhdGV2ZXIgcHJp
bnRzIGp1c3QgYWZ0ZXIgY29ubmVjdGluZyB0aGUgVVNCIGNhYmxlLg0KDQo+IFdoZW4gc2hvdWxk
IGNoYXJhY3RlcnMgYmUgZmx1c2hlZCBleGFjdGx5Pw0KDQpXaGF0ZXZlciBpcyBpbiB0aGUgYnVm
ZmVycyBiZWZvcmUgb3BlbmluZyB0aGUgdHR5Lg0KVGhlIHRlcm1pbmFsIGFwcChsaWtlIGN1KSB0
cmllcyB0byBmbHVzaCBhbnkgaW5wdXQgd2hlbiBpdCBzdGFydHMsIGp1c3QgdG8gYXZvaWQgYW55
IG9sZCBjaGFycyBpbiB0aGUNCnF1ZXVlIGJ1dCBpdCBpcyB0byBsYXRlIHRoZW4uDQoNCiBKb2Nr
ZQ0KDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0KDQo=
