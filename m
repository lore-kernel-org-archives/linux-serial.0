Return-Path: <SRS0=Up7l=ZR=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD446C432C0
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 01:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A2CF2071A
	for <linux-serial@archiver.kernel.org>; Mon, 25 Nov 2019 01:23:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KCRZnSA9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfKYBXT (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Sun, 24 Nov 2019 20:23:19 -0500
Received: from mail-eopbgr30060.outbound.protection.outlook.com ([40.107.3.60]:43419
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727106AbfKYBXS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Sun, 24 Nov 2019 20:23:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+bqn6X5QQj3LEhWY0ADtIvzoIqBL+cGS80zmNHVLr5uijOLPKvV5I+3tghfynoeaeKgZ9QpdWPHVERI+JNOGbqzrXteexNuXsiN9QlXDYfTYeKbkc5x0D+YNcgnMPYZuIUfwgtvk3d2gYnAPgncHnTxo/wMb+RFTuRE1PGMScgI8lROct5rH8dfWl6v2V9anLi/lh2EttO3BFV9mX2HM/3qKz1EfzBCb5AYiB7jacCuj0tl7hluvFLOfU5FhM9tu1m1LkDiRZl0zHqQW68Fojnt0c8J57dEVStdjQowC7i1mKMM1bu4iohd0ISLdfIgAfqEhI1lckSjVzHIAnSNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XgKmcJlu9ZQPiFwkLwq+gvVHohVJp6THCc4bLVsfWQ=;
 b=Fr+pvpE0Ya5N73gV3ynT//u2eRC0SGHFtvNvQlQBob8wzf6a1ztSSoNuX48beKRjXe3S+Fg5X0o/rG1kBF2Sm+4+J7f1hlpEBh3vuSgpMl10k2HLd60CpOiTH+5LOM438ODtzQNqqImRr5s2/seo8msLLSCaXYM7SzJkiiiDxpi0vF6o9tT/p4fm39FT2/7ydp4yvw/iNbKiAap1KpMuJyoDU7h+CrkxbLDVfEXrJ6GnKmJjK6GscueZMRLbmo6iZBIyRiucLBLrzszyXDQ3PwqUvsAWTzI2GbWNVPhX30+P+saA0Qd+KowFzyk2NaydMUqoN5RyPuwpqMKKzvlopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XgKmcJlu9ZQPiFwkLwq+gvVHohVJp6THCc4bLVsfWQ=;
 b=KCRZnSA9uZ119Jsvx5DnxwMoxRJP7AhSzlcfedLrtnMiS4iHlFBuFTH66H1hINqpW6dsRiqfGZIXqlKvMeNmCdP4MUZCAgBSmegn34FidaeBUk7moQ4IXD4SgqubtcOgcZggPufflErgM0LgTDbMKHl3lP0S5jRyNSpRewXjsO8=
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com (52.134.3.146) by
 VI1PR0402MB3566.eurprd04.prod.outlook.com (52.134.4.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.21; Mon, 25 Nov 2019 01:23:14 +0000
Received: from VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625]) by VI1PR0402MB3600.eurprd04.prod.outlook.com
 ([fe80::30e0:6638:e97c:e625%7]) with mapi id 15.20.2474.023; Mon, 25 Nov 2019
 01:23:14 +0000
From:   Andy Duan <fugang.duan@nxp.com>
To:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "jslaby@suse.com" <jslaby@suse.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Petr Mladek <pmladek@suse.com>
Subject: RE: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq
 lockdep issue
Thread-Topic: [EXT] Re: [PATCH tty/serial 1/1] tty: serial: imx: fix sysrq
 lockdep issue
Thread-Index: AQHVoRu6Bk8vNebpvUC1GhrGJLMZuaeW/nuAgAQcKeA=
Date:   Mon, 25 Nov 2019 01:23:14 +0000
Message-ID: <VI1PR0402MB3600D0762BCB83C480AF6EB5FF4A0@VI1PR0402MB3600.eurprd04.prod.outlook.com>
References: <1574416632-32321-1-git-send-email-fugang.duan@nxp.com>
 <20191122103359.fud44lh5wl5d3gxe@pengutronix.de>
In-Reply-To: <20191122103359.fud44lh5wl5d3gxe@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fugang.duan@nxp.com; 
x-originating-ip: [119.31.174.66]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 02c3599e-2ead-472b-781e-08d771460b36
x-ms-traffictypediagnostic: VI1PR0402MB3566:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR0402MB35665C24B28C2E3899E9159FFF4A0@VI1PR0402MB3566.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:449;
x-forefront-prvs: 0232B30BBC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(189003)(199004)(55016002)(33656002)(6116002)(3846002)(6916009)(76176011)(102836004)(229853002)(316002)(2906002)(6506007)(99286004)(86362001)(7696005)(966005)(54906003)(478600001)(7736002)(71200400001)(71190400001)(74316002)(66066001)(66476007)(66556008)(64756008)(66446008)(76116006)(66946007)(52536014)(66574012)(14454004)(4326008)(8936002)(446003)(14444005)(186003)(6306002)(6436002)(5660300002)(11346002)(6246003)(9686003)(26005)(81166006)(81156014)(8676002)(25786009)(45080400002)(305945005)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3566;H:VI1PR0402MB3600.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TAYSd87yEXRAYpAvCPd8MveTUXs3LBAW1mDeYNUy2g5Dv3vwI1DbUNN+bHRt5VwWb5Ga3X3+jQa381JJJPiIUlmHi4swDFNxK38S/Bd7jjRc2eZ0NJYEifcUosCjxZwyhhjIIQtqV8xgredfINS+J/U76usgWiyrR57jcl1e8psXF1QHJdaC08faepO5ZVvvA5eOj4OgwZ8BQPDxS5K8ftQ/BrVPkOwZ1yJHXOLGQwPBIb8uN7gvz4UENJnG9Ccu4d6dXuNBknBaGyRWW/P6EzAxYVY0YycXAwexT8ZInXJYrgLaLrnJm5F3APEOaW3PENJU5Dtb83yhRLjsAIdUqxqTxk9synqj+TjEW6wTDr167xUnbyCjWJju49pPO4Lm47HXdY3N/mrNJcUvXPM+ec55mqqU3kTTzehm2qDP1tP51/0KlE9+m4WL9IGuZR5dhhOxWhf2UamOpKgFv25e+nJE41uDQKVkkQbKCUj69nE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02c3599e-2ead-472b-781e-08d771460b36
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2019 01:23:14.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SBipcWo9/khqlz6MtxpFr0uZv01w1h7NXzw3sPfCS3pSmwbmPglAcMftVA0cEYTn7rumonIlGWUr8rFL9JhiKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3566
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

From: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> Sent: Friday, Nov=
ember 22, 2019 6:34 PM
> Hello,
>=20
> On Fri, Nov 22, 2019 at 10:00:53AM +0000, Andy Duan wrote:
> > From: Fugang Duan <fugang.duan@nxp.com>
> >
> > commit dbdda842fe96 ("printk: Add console owner and waiter logic to
> > load balance console writes") introduces the lockdep issue for imx
> > serial driver in sysrq case:
> >      CPU0                    CPU1
> >      ----                    ----
> > lock(&port_lock_key);
> >                              lock(console_owner);
> >                              lock(&port_lock_key);
> > lock(console_owner);
> >
> > It should unlock port_lock_key in handle_sysrq().
>=20
> I already discussed this problem some time ago but then failed to complet=
e
> the topic. You might want to look at the old discussion, see
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.s
> pinics.net%2Flists%2Fkernel%2Fmsg3266353.html&amp;data=3D02%7C01%7Cf
> ugang.duan%40nxp.com%7C88047af87afa448bddaf08d76f377e8b%7C686ea
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637100156446083651&amp;
> sdata=3DmLk%2BLEyiJjIuRlLs0STJpWJ8K7Q2uPa2fL44bcf2mgY%3D&amp;reserv
> ed=3D0.
>=20
> Best regards
> Uwe

Thanks for point out the old discussion.
The issue seems exist all most of serial drivers. It is better to fix it on=
 common code.

How about the next step, we hope to the lockdep issue is fixed ASAP.=20
Thanks!

Regards,
Fugang
>=20
> --
> Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> |
> Industrial Linux Solutions                 |
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww.
> pengutronix.de%2F&amp;data=3D02%7C01%7Cfugang.duan%40nxp.com%7C88
> 047af87afa448bddaf08d76f377e8b%7C686ea1d3bc2b4c6fa92cd99c5c30163
> 5%7C0%7C0%7C637100156446093642&amp;sdata=3DcCymbZXjFr6YgarayXHbn
> %2F2i8aI%2BLHOLM14A7ETCu28%3D&amp;reserved=3D0 |
