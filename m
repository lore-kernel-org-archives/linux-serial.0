Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD58DCCA473
	for <linux-serial@archiver.kernel.org>; Fri,  1 Jul 2022 03:16:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiGADQX (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 30 Jun 2022 23:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233952AbiGADQV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 30 Jun 2022 23:16:21 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2112.outbound.protection.outlook.com [40.107.117.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5848144A24;
        Thu, 30 Jun 2022 20:16:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AXi3jRPj7hkRgSg0m+ksqni36fPfYb1A0+I+2QHLfu+N4KDxcT7AsSI+6NKsryDm/CK3FPKtfSpfUqEL6Ebom4V3gIIR+KE92MPp+4Zwal5ZrGnAxNslZdPEy8u5+jZUuY1BulhXkwoyJMwX+pwnFq9CHorOs8FVVBWnMeAinY1HUEyoQY4ONP7qXIDgDHmewkavz0b2GxplkLbKzWtOXitfMiafRRf2IdPierhwUT5OUDhAk4gdyczNnCNeBLyBxcAkK4jTRMfuAxNr74TG1FauCtVRE8mMr6eOXUeZOW6ieDqb/AhaCyc8XrBzYgLxIYMY1LTrsmvVwu5Mf3Asyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rosjfANZV1uTtprNkzCSh6SN4aslbt6UmM8DV96Psxs=;
 b=PzWQJYTR1ol7KE+G56GvP61IEMsrj1dYKPyTMk1xK12qznCHVpsCWuAnskrAN6Ulh9pyH4XKITKw2ctenw1WpupwgZX2rPPcvtQxXbUXFjTQJxnM3KnYa8XsyjZYOm2aePqyDpkAKF/fI94ATC2HUTuGbPqmJIeoaW+3KA58Ux3+iAbbBA3gtI3BMeQ5pIJbNZLlAoeIgrgN6HYdFxO86VILJ/dVG0KWXF/nj/t8tpaloriK1aO3uKRB4d4qMt/bBa3bzy1BYMF6uxZhJrfEpZKgblzRiH1X2SDOR0CRElzkWE9TxEDCLK/1WpyA8wcP93bLB3kfOxJyrtlIksNXSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rosjfANZV1uTtprNkzCSh6SN4aslbt6UmM8DV96Psxs=;
 b=J/h1wNJ9Xs9Ugf2X7+DUXiSVhvNkBSoBCDWyHLrN3NviAFz15jNJyj4JziKaTNLf0xICPszCKVpnRJH3yRspNCDbtMqAdQspUYIT56sZ/1fTae+kw0FY1hKg8WHk7eSlxzJ4LVA4xvMC0kMnfskaKMz1cHlrQyR0r3nbtNgTZ7h0AcCA0kQj62rwDKfco3ih/E5nDmXSgndRGjTI0uUgz9iZH210fcdZ7NBglyNWs8gK3tdL3YF+E3WZGarT0TfzFbaFHzoggDAVCGv39PaeIOD7OQujchbpouiAiPEaBH4qGKT6ZSGRiPQTOVYI7QkPPr0FKHLFGNfH/Tf19eJ+EQ==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by SG2PR06MB3434.apcprd06.prod.outlook.com (2603:1096:4:a0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Fri, 1 Jul
 2022 03:16:13 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::46d:a7a:f047:e9bf%5]) with mapi id 15.20.5373.018; Fri, 1 Jul 2022
 03:16:13 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Questions about usb to serial driver
Thread-Topic: Questions about usb to serial driver
Thread-Index: AdiM+OnNdGp6/p28TOGY715mtlYERw==
Date:   Fri, 1 Jul 2022 03:16:13 +0000
Message-ID: <HK0PR06MB3202C7064582E6CB027237BC80BD9@HK0PR06MB3202.apcprd06.prod.outlook.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b1497df0-0d83-4d62-82e8-08da5b100d80
x-ms-traffictypediagnostic: SG2PR06MB3434:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DpG8021U7L/jKZl/lwmIY5u6FyXjQzhez//3A+tVN9J2KYoRAnOQrvR0gEX4Y83vJ+oSiPhjzQwl7K6cv6d865BYdZWN+9OKtfNau4RhUuViBwmoGqLxWBElRfETDBqxNgrDtJ+2nx/UZ+gx5TWEAGaZ2mkrzLszqwu4W1qDzonoF9yjQQzXNzTOTJQwblMQoSGBqzii7lw+uPuEnvppHfVm/XBQic7pJFSdekc33gs2xMS0GyQxBf5xLXY8ZTM1J/9RJAku15q+GbHHUll904vxarjZ/uUDEhRtXOY8ekonicEgBxs3ydXgPEOymyqdpD7rcHAbO9nVcS1hAMFi7XvrX0cW6vRd2Z/j268PN1vamANyJYIlCwUlSTZjhmjEMOPGkdljgbuehme7pf2UmyC/qumq+FobpYs4Q5pEs1mzRda36D3j+7IPbSzQkIlNWdwagYsnQi2qVQ0HFG3544fpa50d8sg08sYpSpTrUopk0jUeEAOmn6pkT/KAfusMohqrVXtQaSLRLcdPl77TsNeWR2UlBT9z5kw3cwIOVocxDvSYBoS4jixC8xe2fWIDuGy4kUrCZDT6PH6/Z50rZbkG/lYU9ZIW59uvFFh1JOkIG62SJe90rf6Oh6lJEcDQcOEnD0drXhXSauPPCseu97e6lPcrOiwdmw2NKejOm0n6uDlZQVNupSzfZcrBOpy9BHJG3ziA+lFkWFqHiDZyWDDTbUtPg1DX6SpNxSpQ7jbE7xxtGXHG0o63HAVIBib2TuF5Yt0YL4XKnpL2MN1CwPdOq/Y7a3aXWA5ymudbJcN71Whsxa+H56I+Cgs8bqHU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39850400004)(346002)(136003)(366004)(396003)(41300700001)(186003)(7696005)(26005)(52536014)(6506007)(316002)(8676002)(110136005)(64756008)(86362001)(9686003)(33656002)(2906002)(66446008)(76116006)(71200400001)(8936002)(66476007)(5660300002)(122000001)(38070700005)(66946007)(4744005)(478600001)(55016003)(38100700002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3s7C3lgMuRBiWqncPUAWuNiYlw47TrUgLrgGAZHvqhnExB0B2MZgC3QKFNLq?=
 =?us-ascii?Q?GsSdbcFZnazTk4GGb5jd1ctxoo5Udi4El+xV3BQ0Q1YiOn8LbkDazBL7tsZx?=
 =?us-ascii?Q?w6IkyegP6csrpA+kPN/iAceW/brmP2WzLfwMlLJcvWL7a1iSxgGQLBAISZi3?=
 =?us-ascii?Q?itib1WBBfDiI/YMO+x8jqGnHS3bt2yOapUtA+HLzgURY8WXWgfagZ5Y9kEqW?=
 =?us-ascii?Q?OjWJDzFCps5tqVrNIUkyml+6jkVKJc2W/UrNDfa4z8F18K6DsEHwU70Y9pvP?=
 =?us-ascii?Q?mJCM8W1FjT32cvtsXcuYLpyMOc5WcLFs4XvDy9EUJyIZSD0HofiCunPxpLWa?=
 =?us-ascii?Q?V6HEpPelQe9SI78y3yRChpHHeEuGaNOnkS9cirMNlvjson6pf71ZMwK6Iz+v?=
 =?us-ascii?Q?wEgI57rDgLr2wBLztffoWb5NnOCfTIWRpEI9nFO10oho8Tj+HE7gx8srkFS+?=
 =?us-ascii?Q?e72/qYRWHrtN2KGvvA2sskwk+SxfYd0mXC7cV6n1LbCyVH3yqS5bpOLhp3Ts?=
 =?us-ascii?Q?sPQfehYSdS32WxoPiG0B6/EdO+EmlPtpIAY/hwqM4o/t/rmWIyS3zZIVEdea?=
 =?us-ascii?Q?nJoKL+UquD/TOv+O/XFFQPqxHPti3qOqGx+sOqAdraRnCWLY6lzVC4i/IThY?=
 =?us-ascii?Q?dTS7o3yBeHFXGYoEawfZ3WpRNdaifsyWQ0198570e96pUIFQLtqIhhwZ1Lca?=
 =?us-ascii?Q?wfiW7lpEKvpo5guDYJGqYZNawMMQYav2XvKJ0zs3jCoJscJTtxmCU44OpA0s?=
 =?us-ascii?Q?A/lObGK68hVyquA+QPT48NY5d16mz378f8LivbY/Xzb1XEJsSQdZfUic9iAz?=
 =?us-ascii?Q?TWJYsUyi+B6+8y36dXfqP7LtwN+N6m3x7y5P9rGIXSLlHAfXdz64cwNp98ut?=
 =?us-ascii?Q?QRisksfbYNB6YdCVGJmnS4J4TF/PRTnDnMD31uCvicw0+1uaogMEFlTMVDhF?=
 =?us-ascii?Q?DzDIVoOfsGA0R5HTu77hz5bclSu84MDXB1ueXgNDGv5Vno3MeE75jdb4qdyl?=
 =?us-ascii?Q?dGFkEqVPl3zyDw9AeDLM1y1T5zE/B5SXIdRTiHe9nJJGm+Lo5D1+MoGEa/Jc?=
 =?us-ascii?Q?2Qt+1bLRt3t05r/rZdiHD6jy1bQEDCKmO82xBoMw+CgLa8y/PFw8rkHyrJon?=
 =?us-ascii?Q?bOFc1wdE1RmUf/to4dyQWs63LNGJHyEGOAcqRl5RLET/kJmusS/QW3DYTPRc?=
 =?us-ascii?Q?gFWi80z/q2qqzd7JLBUz40eIaibjdQapMLHhJQOp72sDgD2fJBeqpYu4EYC/?=
 =?us-ascii?Q?iW64mc6inHDYEIJGuLJtQc0YIPwrCSeFySqGZz9jLlCxR3uKuy8D3YxEelQL?=
 =?us-ascii?Q?3rr6I977nLDiEvozIUdetYCoE1Kg2km1N1Cc+OPEdIVmEDy/QaeSNQjAmgP/?=
 =?us-ascii?Q?rpCW8ZW+BjyLOolpCfey+Cl2cArJozgbTJfeMzwYos3ORjyrsuov4qrdYich?=
 =?us-ascii?Q?F2dW9xLWt0cTDbE4nwp8H3oAFhFyrxcKJ+JqKJ78WelNl+2/yWTDN6cjj7Ff?=
 =?us-ascii?Q?J1au+Cvq+mX1tNeWCSWVpMxJek0JlVNI8OOgsTxDlAdtoOb79eXJVSKQApR5?=
 =?us-ascii?Q?eaE/tXqOVF+a26ivmnisbR2xcxZJAkmgaEuzYnoz?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1497df0-0d83-4d62-82e8-08da5b100d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 03:16:13.0320
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: St3VsXkrj1YZYruZabaMlR8Po0ve5fncJZYt/Vf7HG+2gFNVJrdXW8ffpvpyEKrZ04SYR3o5O0n9rXncBiID/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3434
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi all,

I have a question about USB-serial and I hope I can find the answer from he=
re.
I'll be appreciated it if there is any feedback from you.

My question is If I have a USB device controller (udc) and a uart controlle=
r (16550) independently in a SoC,
is there any usb-serial drivers or applications that could possible to supp=
ort/connect:
-	udc tx to uart rx
-	uart tx to udc rx

Any chance I can make this SoC as a usb-serial devices?
Is there any exist drivers or applications I can reference it?
Thanks

Best Regards,
-Neal
