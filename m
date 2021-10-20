Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A6BC433EF
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 20:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BBB560FD8
	for <linux-serial@archiver.kernel.org>; Wed, 20 Oct 2021 20:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhJTUrN (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 20 Oct 2021 16:47:13 -0400
Received: from mail-bn7nam10on2054.outbound.protection.outlook.com ([40.107.92.54]:61056
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230269AbhJTUrL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 20 Oct 2021 16:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZR5HNYnveNcGKaUAtjon1c7e7pv60+x2dms+Jw3lJN2+JuO4F0owl68/txf3FlZb1d97YeTp/BlnRNyVV8bhbahY3T6ajNnmZoT7fqp2NMbOCfk3ftHH+GTr34s166ZJAEu8iDJlz59syu92pC+jsK+OflYbx6Gfzqb7mWamCS5KP9ZsJrOZpAsfVdyingDQ+TUWeEkGkmxRFMZci7BIJTqHNNGkQt7um5bTmDq53pYPxRMSUELdWQYCxwzbmzC0RJUI75zOcK+Y8z/AtlQjvn7w05ySHgVL4NdqimJE77W6AmVIZQ1UJ0x1h6V+dLNzcsj21Pug04Ofhtker9atBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dELYd6DB8Sca9jElmRd2abABjVR15PIU7iPQEBZzbEk=;
 b=d+2bJ3THxZXu+63y7sP//dhbVJJHb9vyzpCPK0AIRDwap1Qry4b13/c7QJvcj9nBvUMuWZT8h7CXlrW8iY3U+0mcWgmWJko9PuqOSzygRMyQ5EZALbHG7jLbVLaXaDYT3/EveV3A6VKBG7cPJcsvNYtUqPp+/mkadsDwKPDddXtd+gsmf6H2KFL77DZDceGQ4ALJTEXuQTlhHglibpp9pXXFopIcQhU/1YgMOqcTrtVgaSEYaOAKSWNHsFy2dz0v1CJ5sTYyojKx/HKU4V8X2cFqyYoHlDgQ5eFP05NVdiHqCq6UWY6M2trrwDMlT+E2WMsEU4xgSAZmm/l27zfWBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sealevel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dELYd6DB8Sca9jElmRd2abABjVR15PIU7iPQEBZzbEk=;
 b=TAX1qsKtTbes7ifXVbyBSV+DFV13C/MhtIjwpWPYkRKVmwYHoN9FRX64xAoFvkgl7tY8DiWekdw4FYiVse7tatQW8n+6Gc2POOCSZWKPdItPpwYc7LhTEU0n916k2WWmlLkA75T1H5muJbzQCSZWJGY7Z/B5Pm63SZEJYAzNWd6h1zAwDcrzH66YjFh6IWD5qCkVjCJQyi6PQ7HjF5StUAZ5QE0BfQblOwvshhxnJ50NxXG1A9HTNvWhFiuaUevdO/qzznndPmqoBA5YCrq+qKtvEY9A9DnHKl815EvmLgjaqXOU9owOa9PXqeg338w9ynSRmLjpi73s65I98zXIiw==
Received: from BY5PR05MB7092.namprd05.prod.outlook.com (2603:10b6:a03:1ba::22)
 by BY5PR05MB6915.namprd05.prod.outlook.com (2603:10b6:a03:1c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.11; Wed, 20 Oct
 2021 20:44:54 +0000
Received: from BY5PR05MB7092.namprd05.prod.outlook.com
 ([fe80::2dec:3a8:30a1:7ffa]) by BY5PR05MB7092.namprd05.prod.outlook.com
 ([fe80::2dec:3a8:30a1:7ffa%6]) with mapi id 15.20.4628.016; Wed, 20 Oct 2021
 20:44:54 +0000
From:   Matthew Howell <matthew.howell@sealevel.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Possible issue with RS485 IOCTLs on 16C950 UARTs?
Thread-Topic: Possible issue with RS485 IOCTLs on 16C950 UARTs?
Thread-Index: AdfF6Ti+ijm0oExcTXqIAkAc9U2ADA==
Date:   Wed, 20 Oct 2021 20:44:54 +0000
Message-ID: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=sealevel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 631e47e3-2785-44f9-4059-08d9940a7890
x-ms-traffictypediagnostic: BY5PR05MB6915:
x-microsoft-antispam-prvs: <BY5PR05MB691577F3B97BE4147F29A30AF9BE9@BY5PR05MB6915.namprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z8PAmopLx4FNvfy3otZNvFGA7atFRrszPnPQ2KgioNK9+z7oJOlVYHGDwZxc6N9V9QDN/Viu19M8lScABOi+DPCHbJ6cM2dloRraoho+QHo0AeC6K0pJWOVQgbi4bXnFeRp/AZZdwRYC2bBbEcwGsn1VX8zvarXpUkElMKo9wEA4EjNnvWbanTY2lKRIxl72ISpwUOY1smWqT3F49XDzzw+IKzJQgMj3QOsTakIztVO1IQ5bzdW3SdK7xqK3hL+F8EbwP7QsF4mM7uJD3Rg2wHD8MBfHi4P/KLXyL1qmXxHd3sUJ2pp8wFggs5qp+gg24xw2IeVWqfAwRo4y5qf/d5oYh1ryKUwK30KGfRm1RIGtAUB+oHPEJYA9T3xLypdHy0zJjrfNho/Ohe666wZM5MCtKdEOMrpSP3kXKwCCpRB+H2O/GPHcdDJSu/cezUzOPjak3D+bi7Dpr7KoIvUOu+u9H04dkyMAdB3E5zDKADDzOj29hV7ODIPJ5FshdwNeDvvh/Y7GOIb8wt0IKchtzydETU694pUD5vjK8cIJvloWwVXpG3+uhXB5XKJA0Dq6qeqEgnKu8WOCvEBF7e75Fws7cSXHCMI6UDbavSX99fSThZc4YdX3X804Er4yUNYdEN85yBvopyzFpssyzCY2zT1kA3b/33gl3SLY2TtvWb5pK4glphwtfYYdhD1XhrmFRHpcAMRUlaKvjgm1sT4M0jlOqqLNZhfL4EZBuILIXdFILdAWgff+aoocJc/ZRBgxkIIDrnz2GRpbAgYVdFX19KMpcgEPB+zxgUWB2GYzhmU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR05MB7092.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(396003)(346002)(136003)(376002)(366004)(83380400001)(76116006)(4326008)(9686003)(38100700002)(122000001)(6916009)(38070700005)(54906003)(966005)(44832011)(2906002)(508600001)(6506007)(7696005)(26005)(86362001)(8676002)(186003)(66476007)(40140700001)(55016002)(71200400001)(66556008)(66446008)(66946007)(64756008)(8936002)(33656002)(5660300002)(316002)(107886003)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+lcZvQhxz3LzOtq6ekIBoM9yj0Bj0E0f1W2Nptk+ue32iRpcKncdkVcnbj9E?=
 =?us-ascii?Q?uTb4azWiUhfnKDIM4m/CMLLzD2mc7vw0ldFbHTaynNiBdp9srANFONh7tamG?=
 =?us-ascii?Q?xVwvAtGqhQbCXQIoz9AyJ51Z8ZxJPCrYDqjU/hNPXwFNFb2e7jHD4tIHC2xO?=
 =?us-ascii?Q?hBNGdpRQ/jnCtiR/Vbk0qwwwZojD4YJtY+vbr1Fn20wPYgzhzdnu/K4M/16n?=
 =?us-ascii?Q?5h4Vv/GAqW6/q2Sr+hWbpAVDnHDhorRIzP+X83/RhYJxVxZqIBCP5gEscvFj?=
 =?us-ascii?Q?jEe0Hkl2JVgLiGqR5ow2V0QgJ+V2f9BhepjpRBoLPMle1qvSYVpgdRoJ5kWp?=
 =?us-ascii?Q?FMASWuibYOrxYZMRPPXgrY033bFp3iye85xA7QtCV3N4SA5+/oBjyrgWR3H8?=
 =?us-ascii?Q?2YB+Q2kEokAWAlsQeROwU3aIPcCSKssFOy5n9TVAn5rDmjg1UewOzP7VrqGu?=
 =?us-ascii?Q?F3AstIYFxQHweMzWAXJKkJ10oQQf/AeVBwZfkBJkGqyNgUXSa8sGsqC6zq/K?=
 =?us-ascii?Q?qOBGZ7BuFOadHBJ0rl8N+cjGYoDy6Jvlcru3mEYszjss0Bp9l5h8q9ar5u68?=
 =?us-ascii?Q?1mq6b4oFFWCVK/XA7QOtZfUaa3zfu96iHwANjezY/VatO5h/RvObX+O1NRvx?=
 =?us-ascii?Q?8yXxFrC2E116j0qxTbVj8jhsST+WwwQmyFeSplOEs/ulv7TGSMKmRAA4pdaG?=
 =?us-ascii?Q?xszc080kANIaklUR0oaM3ebR+HhADhTul3CH6ozYYaai3Wy6gQ633TCp6Lph?=
 =?us-ascii?Q?SAZxvpMrutaPui/y0NtS0a4bL7loTxKNcc0g9s6OEksFuKwwAHkLHuT9TmVI?=
 =?us-ascii?Q?tYBB6eZ/X2wT3VgNBopwQM1QZo8qZkKRAPd6HMh4zTDTPhblBPxeFwlqo88c?=
 =?us-ascii?Q?R4trFxnUAFTpdxNiFV536iI445/VBxzRn48zdL7M7pTpW2Fku3mRXKYX49z1?=
 =?us-ascii?Q?U8YQ6An0t0SUmDhyohUuViU47vDZlGT+nd/bMp9I4BMGmPYD9xMB6FyWrrnt?=
 =?us-ascii?Q?l65WdtjcN/4brgDlQdqTdHxfrJHae1HEHpR1GXVSdbQ6imJw0iOROh2Ge+s5?=
 =?us-ascii?Q?eaG2slr4JtJv7vtX3o3cV9RCRN6LMzRBkqsSuG/Xf1RjlLHo1vVLbF+hGRlv?=
 =?us-ascii?Q?GKzNMTJPr+cZIRwQXkZThGXte/8wT2hC0qYY264aFOwIO4/ufCGuMRK8NXxq?=
 =?us-ascii?Q?+yDaEolFcgSRXKAj1Z1229aOb9uHYDG2qG7XC72rqodVNAAKpli3xr7WhQ+2?=
 =?us-ascii?Q?VJM4L0kRQSrNzHtcpLRsxI4JcwilPU+ffQ1A5ZQXBhLl/eysacYs8Edg1pao?=
 =?us-ascii?Q?itCgxGJ39at85zqfIy4UeMN6jkGyFfd214UuFKKZ5mNk2aK4p4EyNCqaDLJE?=
 =?us-ascii?Q?Si5ZWt+4pkPhwR7ltyllTWCR0me8OrfCwfwdhpYrWTmMfHpB81kRn7v6/Hkg?=
 =?us-ascii?Q?0xFtAtmqWRbEqX+pgY+i2g8hBGy32mfKjTExLmwTT9q8qXolcNKvjhVAbY5j?=
 =?us-ascii?Q?ERgAJn3tEZH4PVtcgXywlF0VWzVbDaqhSdMcHsqv8XpVWvxJF4CMca7otf6Y?=
 =?us-ascii?Q?RfffBUDeboZyWEMtiPdJRFgq8izu/1i4p/jf+vsLBDaEewNSeVDkTHwSI97+?=
 =?us-ascii?Q?EZB+jyoyjeW3xw/1n0qoc0hg9BHQxYKZgKGtVFdJ/ynjl73j/KcYoJK4yPHZ?=
 =?us-ascii?Q?5CQhxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR05MB7092.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 631e47e3-2785-44f9-4059-08d9940a7890
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 20:44:54.1380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4b9HViV/RsFZW8K2eH0o13JsOo6leWHRcr+Hzs5jWJclBxlmYsD9bbEXT2YgOmtZQfOQXQmN0MWZQdkDEQoTvvq1dPGsnTCvgezWZVO3oEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR05MB6915
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

I'm not sure if this is the right place for this, but hopefully someone can=
 help me figure out what else I can do to troubleshoot this problem, or poi=
nt me to the right place to ask questions about this.

A recent investigation led us to discover issues related to the RS485 IOCTL=
s on our serial cards utilizing the 16C950 UART. More specifically, the TIO=
CSRS485 IOCTL to set the serial_rs485 flags as documented at https://www.ke=
rnel.org/doc/html/latest/driver-api/serial/serial-rs485.html .

When attempting to set the SER_RS485_ENABLED flag using TIOCSRS485 as per b=
elow I receive an error code 25, "Inappropriate IOCTL for device"

        /* -----RS485----- */
        struct serial_rs485 rs485conf =3D {0};
        rs485conf.flags |=3D SER_RS485_ENABLED;
        rc =3D ioctl(fd, TIOCSRS485, &rs485conf);
        if (rc < 0) {
                printf("error=3D%d %s\n", errno, strerror(errno));
                return rc;
        }

From what I've read this typically indicates an unsupported serial device, =
but the documentation mentions the 16C950 UART as a specific example, so I =
would think the kernel is intended to support this functionality on the 16C=
950.

I have tried this across several kernel versions: 3.10 (Centos 7) , 4.18 (C=
entos 8), and 5.11 (Ubuntu 21.04) with no change in the behavior.
The issue was originally discovered on a PLX OXPCIe952 UART, but has been r=
eplicated on 'standard' OX16C950 UARTs as well. setserial -ag correctly ide=
ntifies all cards as 16950's (Specifically "16950/954").

Has anyone else had or seen this IOCTL issue on the 16C950? Are there any '=
known good' 16C950 based cards people can confirm that this works with?

Let me know if you need any more details/testing. I also tried to configure=
 my email client to behave nicely with the mailing list. Does it seem ok?

P.S, I also tried using 3rd party libraries that support the RS485 flags, s=
uch as https://pyserial.readthedocs.io/en/latest/pyserial_api.html#rs485-su=
pport, in case there was something broken in my C application, but I get th=
e same error.

Thanks,
Matthew Howell
Applications Engineer
Sealevel Systems, Inc
Confidentiality Notice This message is intended exclusively for the individ=
ual or entity to which it is addressed. This communication may contain info=
rmation that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or othe=
rwise legally exempt from disclosure. If you are not the named addressee, y=
ou are not authorized to read, print, retain, copy or disseminate this mess=
age or any part of it. If you have received this message in error, please n=
otify the sender immediately either by phone (864.843.4343) or reply to thi=
s e-mail and delete all copies of this message.
