Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68353C433EF
	for <linux-serial@archiver.kernel.org>; Mon, 31 Jan 2022 09:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiAaJtq (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 31 Jan 2022 04:49:46 -0500
Received: from mail-am6eur05on2102.outbound.protection.outlook.com ([40.107.22.102]:61152
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232052AbiAaJtp (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 31 Jan 2022 04:49:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZF0dPCx5pi7b5fW0gWg858UGN2i0UCbrEVFVbnuG6u1/Coi5gcghS91faNqAldt46+1m831jDd2LkHYSClrlGGp5pQzzo3tF9XseXklC840xPyuM0NTLL8UsyzUPKC7F3NTmHcYDPyODRzOiId4CXeW+Cdm91BOLMw0ipxcZv57lqnGgLs7JU9UBtqxTd3uFk/1ComHQBPFWuupqfJbELS+ENa5RwpZ5tGdPN2fMG0iZUeS3JQMDVHwSJwqaqTGA78blSUH72Mmr8RV/eNdrWPLwzGQpjaYTBDAWWdwKtziT/EwTknGunXaD6s5jInAChOxfvafngSRWkwDflBSzag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QmoE1/IuyWrtGl8DabZAWD34hyXe9hTh1/S4LTaatuo=;
 b=IZiiYTVE9P6KtQpDl4ekzYVtChVTcRTvrxeAbfnehKB4V126G9qoh2HZzNa13sCM+LYAvSCm6lPrSkG4wAKWebIGbSH99guzOneqN6qLH8B7iUznYFFicBf+YzKjgOVD+6r2FCdy4PPi66gDmeNqCvavGsybajJ/SakAeVJF4XGhoqKEmfAPddhA+rXDBzm5kcqCBlA61RPzLnpLlVbbM+G7rLV/sKFP0hYZ9Tew+9ZwvyzsRkjmllbF/SiltG3h3jddzMkxJFnl8aLbpbAL3zLEnBGslY+yQt632Wj7MRWxTj3J+DwQ0w8JYLPRhip3CcP9LkrsNrP0rbA/+BY40Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=codewrights.onmicrosoft.com; s=selector2-codewrights-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QmoE1/IuyWrtGl8DabZAWD34hyXe9hTh1/S4LTaatuo=;
 b=cYaMWYbZhnRSKoKDaGYpaZXUTnLKx52WoZgHks1wFzbOiTLd9ABaQkBq3wdEWf2Ql46yqnPNoKkrmWuCyAe8IEp+oAiN1r4VORkSvtKPfWHPdpuLrgE07xhg6mdgMtOv6K8BZshpF1kBK9jL/ovYIRHBeYhSjPElqvBGFyUnatU=
Received: from AM9PR03MB6771.eurprd03.prod.outlook.com (2603:10a6:20b:2dc::9)
 by PR2PR03MB5196.eurprd03.prod.outlook.com (2603:10a6:101:21::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.21; Mon, 31 Jan
 2022 09:49:42 +0000
Received: from AM9PR03MB6771.eurprd03.prod.outlook.com
 ([fe80::3422:f3da:be12:3ffb]) by AM9PR03MB6771.eurprd03.prod.outlook.com
 ([fe80::3422:f3da:be12:3ffb%4]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 09:49:42 +0000
From:   Benjamin Ulrich <Benjamin.Ulrich@codewrights.de>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: response time of serdev_device
Thread-Topic: response time of serdev_device
Thread-Index: AdgUR39xXvO81U35TDmtPJFuFb7UUQAFZx0AAIm7oVA=
Date:   Mon, 31 Jan 2022 09:49:42 +0000
Message-ID: <AM9PR03MB6771D924CB229E657B79F0B693259@AM9PR03MB6771.eurprd03.prod.outlook.com>
References: <AM9PR03MB6771AA9FC0E036F21320400893229@AM9PR03MB6771.eurprd03.prod.outlook.com>
 <YfQN+iV9jA5aIOYr@kroah.com>
In-Reply-To: <YfQN+iV9jA5aIOYr@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=codewrights.de;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ee687edd-c1a9-4854-1e5a-08d9e49f01a3
x-ms-traffictypediagnostic: PR2PR03MB5196:EE_
x-microsoft-antispam-prvs: <PR2PR03MB5196229531BD16EF606F236193259@PR2PR03MB5196.eurprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6sbI/e+0sfKGYI2FL8EDGdZ1+kzEdUcpaPmOXfUaGYTOUWUfBk4zR/LGh6VCN0pIGO4qKSALuIM3WiWZKTZXFx4fyq1Z/WCvjQ9X9Pa5ixNsH6Hwqjadz7Gf0n03g2iqVTce1C5sEzQ4+C++dM2oKuhgEolSLw0lE31xA44UkTq1MRc0DUgh/d7mIUcAXgPqWidluSDg4hvuKaTSNZJuW4CBgcVQxGYEcLcSANeYW1V3kyYBs7hvA0cFZla8sWT88JQFHShU/ee6ampDchDcoXeWloRjsKjkQu5q2aVN0nHHh06iYcTCRdhsGXPEJ4uiGVWxsSZ0cY1TSiQmFsh/hWRW3fw7fI+O7yok4ZqIP6+f08Uuc3I8GhpVFqQ2Cqw8+WUhgyt4K1bNNIICV59qTNx6HrxVRSDYTTXO4GWc9IHajo1hnvLn5MRN00vExF3BlsKL8d6FQoiEzDuT/D6H870kKz2//BEsA1KW7kLoYWFXyoJcvAZX3Hwi4EXjkHrd82kg1POmCjWEAJkP332XjXRw77gemI5tOEdVzh/rAK1yY8eJwgMyGwduxxpwUz53ltj/8bCldv2C8nSLBIvyRnG8ugt0QLqtbv1usRniR67BG+Iw3qLVdAnxmHZ7Qyj4R7PbHrQRgigtIBx1C91LY7eTiKEZ4eDop90ZrNVXjr4n0Mm3gL27EKL24VIdKYjW/KNcX+egr8LBCnz6tjG+Aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB6771.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(39830400003)(396003)(346002)(136003)(376002)(366004)(86362001)(76116006)(122000001)(66556008)(66476007)(83380400001)(66946007)(33656002)(53546011)(66446008)(64756008)(38070700005)(2906002)(8676002)(5660300002)(4326008)(8936002)(52536014)(7696005)(6506007)(55016003)(9686003)(6916009)(71200400001)(38100700002)(508600001)(186003)(26005)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iX7N/Wvi5xcP4fUwANiyOVxRCdFKXEB2Dfn6K0WDw1uFM8pVdUXhdo7pDWQe?=
 =?us-ascii?Q?/fTCTxD3yyOyYgts3fcig9IDAGc0wrlgfzbwlD12PcVRp9loC2ZLiQjkm8+V?=
 =?us-ascii?Q?CjUw74IBfVtwAmylSjlcahWmlawUP4A/47mX3sb2sEWL09znEgZdkDUym+zF?=
 =?us-ascii?Q?gieqAwmrPtwNqFWBYDsrdoCHuLRu+1xiR8c0+95LOLvemu+oMshc2C/wa40c?=
 =?us-ascii?Q?cxjfOtVClGA3ma+jUp3GD+294FzeWSWx/OLqYQRU3zbtZuKtEpTkK0/IPyLy?=
 =?us-ascii?Q?nTLlxRizKIGDJs4StUKZZW5M3Y85SbeWm07RYHZve3TvoID5jq9ckb5J/K4h?=
 =?us-ascii?Q?4Xd6ft4k0aG2ZQgMll6gFzIyT2J7ixcLZqT7A+ddtVfOrXKk7Aw1AyJ2Oa3j?=
 =?us-ascii?Q?OMSGCHlpzh1LL3nhAO8acr50WvqZ+3HiOERKwAov3TnmMJjYlulsoJVNnwyU?=
 =?us-ascii?Q?VMgr01+U/vQBXiBWjP52IwjTY1muf/nmDAxaVPjTBSkVavgPwITq9TzdAqtJ?=
 =?us-ascii?Q?+X8B0v3uEQg5kRLfWFcbWMRNr5WYyO3wGYDg9nf2JwV1FTrhdPZH43lCpqZu?=
 =?us-ascii?Q?l2botuXbuCz3xUTThsJlFuDzkilXUbr31hikcTtBzfVVTb6ByZP/zU+3Is8Q?=
 =?us-ascii?Q?n7v776DufIzqWmbmz8HDIRYM+JqurL9EaNwfaN8gswnKG6nhNKHBdPKifI6+?=
 =?us-ascii?Q?FJv2DyQPxiAC4BY5vyzE2RPpEGf0gh7nMZd52Pe21Que/SOQR2CjIyilZvrK?=
 =?us-ascii?Q?1x7/OTMGBi378eyzMdDg+4QrbH+uCllfPg6JXP4vRodbthVzFp06KM/8EX3N?=
 =?us-ascii?Q?Un/IQeU+9NOKzHfUWqYcVPdgIpSY5AP3r4Z0d/J9WBhR82ihkyRd66WUWipu?=
 =?us-ascii?Q?yjLRdrAJRXDG58R3zZp79veWDy2CjsxeG5WvUSueuTIgQT+tF5d0cOmOERz3?=
 =?us-ascii?Q?4ClG9qNBChQd1sDfaZc6CmYMnGz98ekflH/vns3wTbHrh7sbLjkiap3I0qu8?=
 =?us-ascii?Q?mtuF5C7UI3QkErFMpEsuY9NlDStP0bXG5p1Cl63D+I3YfaIbNUAregO1AusT?=
 =?us-ascii?Q?psBRsVhOeqJKLkR97HBPuN2AZqxpW76lGIkzVZEZ7XpK46jnl9/9Ru/UHgsT?=
 =?us-ascii?Q?XKn+IGJ9QMozkHsp3Of8CQhio4gIiT8Bmdidncyg/92lfTYdeWIZ/ARUrgXs?=
 =?us-ascii?Q?juYgAlo9SgfG3ZLc1Sp3pIjb64WbCfWDw9sy0RcYLJWjpxIlIYghbezCyUZN?=
 =?us-ascii?Q?m7Uy02ImvqtsUVcrtxR/zQTr5Jqjx1B6akVrQ9Quxn0LX2RaBzEZLh8vVDDh?=
 =?us-ascii?Q?a1TfwkoVvC45WogFgYg8HNr0DbOlizt8ux3Fdq8Zkiw4/Qp81urqevmw0k6W?=
 =?us-ascii?Q?pW3PH7AYmBjlvDrP33EgZJS2tqzvoMrZUccXAmipLrO36UUURSt5J7ywTEQs?=
 =?us-ascii?Q?gL2ftGMsg5jUhZMoHHOoPcH4eBfGdu2A5ghlRIxSOSkVuaps6hNQkc3ISMAt?=
 =?us-ascii?Q?NXVjqmK3Jcc3ghgqzYE4B+2FWdof1993Cl5t/qHXVBc5nUaUnHRaqvV7l5uU?=
 =?us-ascii?Q?YXndeN0DEGZaPAmHK+gXqDqNfqkBeWJamQ/0vlMPb/avIVmHPRL7mAEiGlcI?=
 =?us-ascii?Q?xjk6SbVKWbmkEUsdUkXyBrijontlQWbwSs/6pwl2cMjVqVYFQYRCQJXHat0G?=
 =?us-ascii?Q?/5qTAQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: codewrights.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB6771.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee687edd-c1a9-4854-1e5a-08d9e49f01a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 09:49:42.7411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0974af9b-352b-437c-b606-e9f242c0c227
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5EJCbcCAw6lglsC9Ppxf512jGlrfrToMeGr1ygawR3qVZVqiCdBNqgXr+G95qi6Grv01u6aHiqW3nWSL5/lDUut4tAFZTgWDnyCHhE8lpfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5196
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi Greg,

on my machine the RT-Kernel is already running. I also tried to change the =
preempt-priority for the uart-irq and set down the scheduling period. Both =
had no effect on the delays.
I'm pretty sure that the hardware can handle the speed, and even the OS/Ker=
nel; Because at 256000 Baud, the response delay is only 0.7ms!=20
So at least, this delay-time must also be possible at 19200 Baud.
In my view the delay is not happening on the uart-driver layer, but somewhe=
re above.


Right now perf is not available on the system, but I'll give it a try.

Tanks, Benjamin





-----Original Message-----
From: Greg KH <gregkh@linuxfoundation.org>=20
Sent: Friday, January 28, 2022 4:39 PM
To: Benjamin Ulrich <Benjamin.Ulrich@codewrights.de>
Cc: linux-serial@vger.kernel.org
Subject: Re: response time of serdev_device

On Fri, Jan 28, 2022 at 01:03:53PM +0000, Benjamin Ulrich wrote:
> Hi all,
>=20
> I'm using your serdev_device kernel module because it fit my needs pretty=
 well.
> In my application the response delay to an received frame is time critica=
l, because of that I made following observations:
>=20
> When I'm writing an UART "echo-device" with:
> static int device_receive_buf(struct serdev_device *serdev, const=20
> unsigned char *pbuf, size_t length) {
>     return serdev_device_write_buf(serdev, pbuf, length); }
>=20
> I can measure the response delay between the TX/RX UART line.
> On my device (IMX8,with preempt-rt) the delay is dependent from the baudr=
ate:
> 19200b -> 4.6ms
> 115200 -> 1ms
> 256000 -> 0.7ms
>=20
> The result is very surprising to me, at least the baudrate-response depen=
dency.

This all depends on your uart hardware as well.

> I know that there are HW-Flow control stuff for Half-Duplex communication=
 like in many RS485 applications.=20
> Is it possible that there are some old configs left? In the function: sta=
tic int ttyport_open(struct serdev_controller *ctrl) the ktermios flags are=
 set properly.
>=20
> For my driver a response time of 1ms@19200 would be really good.

Why do you think that?

> Can someone help me to archive that?

Are you sure this is possible with your hardware?  This depends on your wor=
kload and lots of other things happening at the same time.  If you need det=
erminisitic behavior, have you tried the -RT kernel?

Have you used perf to measure where the delay is happening?

thanks,

greg k-h
