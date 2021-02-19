Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2393DC433DB
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 22:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED23164E24
	for <linux-serial@archiver.kernel.org>; Fri, 19 Feb 2021 22:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBSWIp (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 19 Feb 2021 17:08:45 -0500
Received: from mail-mw2nam10on2106.outbound.protection.outlook.com ([40.107.94.106]:7648
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229700AbhBSWIl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 19 Feb 2021 17:08:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dzcyzwx9tFQCOXIks2VZrTlY+nh4OdQ/VBN1zmsLHDVnvpW4fO+VF7fitS1o1UT1690IfgM/Ok+wDGGeZUXc0huZes554fnQn9Ca1NXv7ZC+bTkVVeF+gZOelmIcp7gAX7f2NxqvUY94q4gAx02O8OMnbPtuG6zdcN2NY9PUDpI5kLtU7/BB9Tdzca5+Rvao+LizxqB9dHD4IJCQUgySn95AybalOuTJFwekwsgv6EkDn/m/q2Ocz3nDbzbYlMw0za91dVTUAx0+OUxUe3LGr9qCh7bTxG6G5sHOR7wtOY2iQdL0d5SDookXhn9Hls0KYXPcYglsV4SIriVKhb0UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYDRwD+b8JL0OUNzdzxs0p6Y7KvNhMnNAdYUuFAcHk=;
 b=Y63sBqe7GiI1ZQpF3d1QeRr4n4hlsx7ASPtkx4hzud/uhIb5zUA8BPd6OUSXVcWQKv6FEN9q6mGke3EegEAxgiRg2pxUPWlKUpUxAcaABfNsGR5JruL38kigRzbCS8mhsIXVnZQ6ljegCMlJPhjI6vqp6mUiAz7nUiWky7PM/MpZ4zUbvRlrJoXeAUDVuJL6zeIx/qG9w2pwtxa+JBPe5+9kJtggS1PZM1xmSu4l1W621YZ4c1oqaHYjL+ZWDkXcPZ4eXhNXQXrkVQWAYTbcOzug7KSYIDevnQz2oIWmn055z6IEDbFD5N71Yp08quenrlC9dHMOQYwkOOjrIY8RGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=purdue.edu; dmarc=pass action=none header.from=purdue.edu;
 dkim=pass header.d=purdue.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=purdue0.onmicrosoft.com; s=selector2-purdue0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVYDRwD+b8JL0OUNzdzxs0p6Y7KvNhMnNAdYUuFAcHk=;
 b=sOMozdO5b2dhidZIpfaeG1kqQb6mAFNChp7yr6RsyVVHxgsoKj8GrvU8seOxZwwbfYp7wmiHvsd/EZPDyipKj3+uMrWi1JoLYSSciZnh8nINlt+Uc0yC54uBRWpsJCs9/sLIgJGc8LZsnYKcghp7ooYh8jXIOVGLz7KBrNYR7Rw=
Received: from CH2PR22MB2056.namprd22.prod.outlook.com (2603:10b6:610:5d::11)
 by CH2PR22MB1974.namprd22.prod.outlook.com (2603:10b6:610:8d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Fri, 19 Feb
 2021 22:07:55 +0000
Received: from CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::4030:a132:aaff:aaa9]) by CH2PR22MB2056.namprd22.prod.outlook.com
 ([fe80::4030:a132:aaff:aaa9%8]) with mapi id 15.20.3846.041; Fri, 19 Feb 2021
 22:07:54 +0000
From:   "Gong, Sishuai" <sishuai@purdue.edu>
To:     "jirislaby@kernel.org" <jirislaby@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: Grab led_lock for reading ledflagstate in vt_do_kdskled()
Thread-Topic: Grab led_lock for reading ledflagstate in vt_do_kdskled()
Thread-Index: AQHXBwusiymSGDI9rUWUZsFmT6irig==
Date:   Fri, 19 Feb 2021 22:07:54 +0000
Message-ID: <EAC1E6B4-7861-408E-80F6-A13AD70EBCEF@purdue.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=purdue.edu;
x-originating-ip: [66.253.158.157]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18c6405c-b840-4dab-e99e-08d8d522cee4
x-ms-traffictypediagnostic: CH2PR22MB1974:
x-microsoft-antispam-prvs: <CH2PR22MB1974368DD647FB3DE98F07DBDF849@CH2PR22MB1974.namprd22.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6EqixxAMGT6pEiTPQe1Q1KDDkx7VFpa/mD/b7F4CnXIRmEFQkWiBV/pIFAXPBzCUUBEjx/cqYb7zhPoqqeF1aLaIl+BvjaNgwEpzMxHVoa+hJ5tjeQS3hwePgEjJEp4NgC/LrWkdUXbjfBMMPOCxcAzFlbriNcj9A7n7yuR6wWMYQKfefiWF2avRYhy9NMQUnsaMc/6cJsyEy593U5RRsr4PwuqDTAvx85z4OEN99JjoBahRYNg1eWo3d22EjOZkitMosD4+vw27tI14pl2He0UHpEEh5uAddPkaYntuuWK4nXXOYAwgCC6n9mAcGBjmzIBHA39vurbarN+rlNJpWHLEN94pBJlJ3DPb+PrF1LJa6rlGEww8Qqg4o/g5tCokZ9Qwo0iNDh8oajlaQthDtqnk6IwpAHgVakFIghv/nqi7BC/yNxGD9Eo7Piwj47jGiyTyGETlJez3TYuiF+yw/xjHAhU/7FpFi37JB2oU/XewIuMvmNCrflmVAWPH8E7T6KHyvVP+xKzxaYpdvV2VrWiKN42YUbgePkVQgTzF3rEh0Q+MTuOy/QKjloou6oG98a2LncN0u7QPq005KRa3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR22MB2056.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(136003)(376002)(366004)(396003)(4326008)(76116006)(75432002)(316002)(66946007)(71200400001)(33656002)(2906002)(6916009)(786003)(4744005)(6486002)(5660300002)(186003)(8676002)(6512007)(64756008)(66446008)(8936002)(66476007)(36756003)(86362001)(66556008)(6506007)(478600001)(2616005)(83380400001)(26005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?TRQhjDW/0AODa7dhv233Par5JW4W0aUnKw5VRvvBQhPi2GIdmAlxB8T2SHUw?=
 =?us-ascii?Q?uwqmuuAUFPE6Un7SYk943XISemLitUho19mCigkMovzF3GCAEiJ3M8FXLKng?=
 =?us-ascii?Q?vmLWECTejewXYHtQH/pleo0R85qCotZOBt/3g7X48y7Tv38GGjJwwini7uZB?=
 =?us-ascii?Q?MblRrAsjtQGHYyy6zhokGWMV37AppdKoVigqxKYf8VF0YgArmQKqjezefb2l?=
 =?us-ascii?Q?lPV2L4nOdm9li43uqvjoNWsxVtWcaKi38xqTnPiM8A1fktLwYHx7gu2aW6sE?=
 =?us-ascii?Q?MqVPdF9+WgyoLQ3mw9I4bxWA3v8bdNHI/jyHOBgni7RlhMQ+IcaGgIaL/eIx?=
 =?us-ascii?Q?v6qmMUWC9SZFhPFTiWzgZMc4hK3iow+axILs3wZzFBUv1WW6V7eYBIqkekYh?=
 =?us-ascii?Q?ojn19wir7r1NWr/DEbddMtKX3YjxBPQdDH4Y2MIzlfUzExh1lZnAXk0w4Uce?=
 =?us-ascii?Q?ca7ouIp3lH2GNtYLGbpMXCsSG5m23to1TlvWeangMY/vXCd/KH0LE5744mwx?=
 =?us-ascii?Q?WP6iI+VBtNjMRTLhDXhWq9ljMm6jCsSWcWw9sNTjO6rUt/VoRQvob/ks++VV?=
 =?us-ascii?Q?TkyTw3g5+6u0YvHeOu+zmk9YbQtpqwUeevuY3tYTzSqY0+CX931+JbHFGCrj?=
 =?us-ascii?Q?H45wL2qRIpXJUKBekUfABavXJ+vy0MQgrXM5UrEfTWf1WI1XGxOLhMyxcMtw?=
 =?us-ascii?Q?v+lIgESRW6VrRNDYVBah/Ta8kXr+XuxS0L14CWo8x1cA9B360EtSiCED8LGy?=
 =?us-ascii?Q?cFVlsqcDajQeo/X4Vnk09SD4/bLa2+NmimkTIuPgoHUBF+4NTUCW9hVlm3QL?=
 =?us-ascii?Q?D8JbCKw34/LtOgFPDyRAjkrFBttByJL215faIQxdN4caRtLuZcBaOT9IIpsP?=
 =?us-ascii?Q?FUKHIktlMyrnB8KfPPh64R8B8f66yyF4SpQnSP20l+tc4GJ2/AjFSfstaIyg?=
 =?us-ascii?Q?nf2bWWUSQo6me3IvxfBT6Lf6OIpvfs95zzjVYK0ApBJWw4mD2UW/m649ztAH?=
 =?us-ascii?Q?7O8XCjcfXZOGoBE/6UH+u7VfKnusJLRIbgbfr6GJO6ZqLA/v5kOTh+HhYzu6?=
 =?us-ascii?Q?4tN7ffra4zSVgOClwvaOxrnAg+oUhwx/+PqoDXfiXUxdCae25M0nCiNgiETW?=
 =?us-ascii?Q?+RzPU7WEjYHaJ4J20v3OTWpOT4JxbkO2NZB95My5KajIE7wHndEfHx9yvBTR?=
 =?us-ascii?Q?rL8bzai/C9WpTYa6+p6x37lhAN9exFhEHwX1SGzjcxqnX7xxdHeIL6b3m3Xf?=
 =?us-ascii?Q?2eH/kon56BKD8HDe2ZCzQ+WqbK4JhdIvWSghXQ3uLcX5uaUFwakqmz6IfG0N?=
 =?us-ascii?Q?RDgpwu/C3DCGtHT93e4S7meH?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3D5EC7E1361080488325B3E40EAB7649@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: purdue.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR22MB2056.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c6405c-b840-4dab-e99e-08d8d522cee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2021 22:07:54.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4130bd39-7c53-419c-b1e5-8758d6d63f21
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ha/PedAFljdSIQot+4cjsiMqtfHcsZQ0GlcQGzeEfJBH4Znv85krYKOact05h0+fPDNTbXpXLDhHjCScP0YZyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1974
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hello,

We found a data race on kbd->ledflagstate that could happen between set_vc_=
kbd_led() and vt_do_kdskled(). The interleaving is shown below.

Writer(set_vc_kbd_led())						Reader(vt_do_kdskled())
										case KDGKBLED:
											spin_lock_irqsave(&kbd_event_lock, flags);
											ucval =3D kb->ledflagstate | (kb->default_ledflagstate << 4);
// led_lock grabbed
kbd->ledflagstate |=3D 1 << flag;
											spin_unlock_irqrestore(&kbd_event_lock, flags);
											return put_user(ucval, (char __user *)arg);

This data race can cause the out-of-date ledflagstate being returned to the=
 user, although it is not serious.
But another reading spot for kbd->ledflagstate in getleds() is protected by=
 the led_lock, maybe vt_do_kdskled could also grab led_lock for case KDGKBL=
ED.

Thanks,
Sishuai

