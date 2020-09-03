Return-Path: <SRS0=cUMT=CN=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA6DC433E2
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AB082075D
	for <linux-serial@archiver.kernel.org>; Fri,  4 Sep 2020 00:22:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nttdata.com header.i=@nttdata.com header.b="dxpV4aQG";
	dkim=pass (1024-bit key) header.d=NTTDataGroup.onmicrosoft.com header.i=@NTTDataGroup.onmicrosoft.com header.b="VPVmBRfu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgIDAWd (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 3 Sep 2020 20:22:33 -0400
Received: from mx07-004dc301.pphosted.com ([185.132.183.31]:27910 "EHLO
        mx07-004dc301.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725787AbgIDAWb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 Sep 2020 20:22:31 -0400
X-Greylist: delayed 24350 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Sep 2020 20:22:29 EDT
Received: from pps.filterd (m0196591.ppops.net [127.0.0.1])
        by mx07-004dc301.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083HQkOV021831
        for <linux-serial@vger.kernel.org>; Thu, 3 Sep 2020 17:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nttdata.com; h=from : to : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=20191111; bh=c15u7n0j9RpCrrJV9pBXQHU423UFORZDvO5z8uR7WZg=;
 b=dxpV4aQGEa2o3oiOWCRTnu3tjekH9lZlAAX90wPvUVXqy3Q+KFxP7dE/tu0h2+GSaOzN
 jHaZllb5w3hRpQFAs+2Bbc1KNG2l9gLkjZPE0BDi1ZkfZNWSrvLte6jmF6XynHQNXMmi
 XWYUyU/CRcSWnNWdz1wyGUOiGb3zx7s60/7wsnrtntThbBEU+UGOZUzXwexrBNx3BHNO
 pgXK2k8s05DMqMP7gVZsJ7ccpKaG6GhmHzbEN/X3OlYay0OEcESDYr0SKwR+0iVVxIuE
 3Saji61sLT1A/EDdMrEDmEEKrgIphjBshvxeEDVrcqudsKWzGQLU4ZgO1F6706FScD6B 7A== 
Authentication-Results: ppops.net;
        dkim=pass header.s=selector1-NTTDataGroup-onmicrosoft-com header.d=nttdatagroup.onmicrosoft.com
Received: from mx07-004dc303.pphosted.com (mx07-004dc303.pphosted.com [185.132.183.32])
        by mx07-004dc301.pphosted.com with ESMTP id 337fh8kryd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-serial@vger.kernel.org>; Thu, 03 Sep 2020 17:36:38 +0000
Received: from pps.filterd (m0196620.ppops.net [127.0.0.1])
        by mx07-004dc303.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 083HZIrc021391
        for <linux-serial@vger.kernel.org>; Thu, 3 Sep 2020 17:36:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx07-004dc303.pphosted.com with ESMTP id 337et1s0ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-serial@vger.kernel.org>; Thu, 03 Sep 2020 17:36:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SmN6/gSBNqaPvL4oHo4HXQ5V1FdlSizBqutCI0p43CuL/CG7gIdwzuSWPhqOrKIEbw09/raptdwNyuorqS7EtLKCLmOffv3FpmeATJDmorNLxkuH8cADvccoi1mUU7eLICNTAr111pzIZ0WAqSdJ/0MCRlZGm3fHKXqiVUQivE+1CKXA1FdwWaPorxujpm94iqBxUaCT49a/YMWJOXRUpCbmnTNUh6P4XsNnok3356S7JhYsxQK6swq4M/FXYMkm/K1nSc2A8DUYS/6n6vdR1hjMrPG6aQCpw6SDVqhQEXCHDd9BfJD7e6Dr5ywJyEKhiW4TnXx1WYLeEeFxteUQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c15u7n0j9RpCrrJV9pBXQHU423UFORZDvO5z8uR7WZg=;
 b=H2/SMwmDzreDxWthqpE16k9WdcLHTJna+k31+fCH2I56+fBlSSKXqX7MEUtz2lJYsqFZg5IHXIK8mXa8k8yogU5kR3EumOqY8fzUelf4+GyJHiMa2vJ+ImWRll3m9mFfOGSYNYaMkkDUzg0aob/zHksM5oTq7roYITQr4yuNJQzUkRtxKFsLFeQJvqujI43vcC2Gxm+7OvoF5gg/ilnxVyXBc31dr4onC0+NXMdvECw0ZKZ6JJqRNe29ZLOZLttrZCxanyn/9EA0TvCAHRNxKSxQfLFU43qyCKdKkJMqH1baGAihwOZDoExVdMMXqo2vdRdslOC8jTDK4HQeY+Y2UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nttdata.com; dmarc=pass action=none header.from=nttdata.com;
 dkim=pass header.d=nttdata.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NTTDataGroup.onmicrosoft.com; s=selector1-NTTDataGroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c15u7n0j9RpCrrJV9pBXQHU423UFORZDvO5z8uR7WZg=;
 b=VPVmBRfuYmTFZaKs9MtB4E9oPmyNsG7/gK02f0SQIotcq1QKDYnRKwgoWkqtZJq2Jn1eyeIxdOjAWRkw1Azqnx9jC4+L64aNHfc5sWKwKrgSt3B1Z6EU+0y0KAH+ICsU7e6jTKDZzTuC6xifAIDPn9/bxq+zNlsu22fvNZcw1GI=
Received: from CY4PR1201MB2532.namprd12.prod.outlook.com
 (2603:10b6:903:d8::23) by CY4PR1201MB0149.namprd12.prod.outlook.com
 (2603:10b6:910:1c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 17:36:34 +0000
Received: from CY4PR1201MB2532.namprd12.prod.outlook.com
 ([fe80::ec3d:78b2:12df:1d13]) by CY4PR1201MB2532.namprd12.prod.outlook.com
 ([fe80::ec3d:78b2:12df:1d13%8]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 17:36:34 +0000
From:   "Barnett, Andy" <Andy.Barnett@nttdata.com>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: 
Thread-Index: AdaCGMPDiceh91wdQLWTmitxXcFcPQ==
Date:   Thu, 3 Sep 2020 17:36:34 +0000
Message-ID: <CY4PR1201MB25321441CB372AD9068F8C458D2C0@CY4PR1201MB2532.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nttdata.com;
x-originating-ip: [165.225.223.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35e5f737-5796-4cd9-f406-08d8502fe714
x-ms-traffictypediagnostic: CY4PR1201MB0149:
x-microsoft-antispam-prvs: <CY4PR1201MB01491815538B797546A354AE8D2C0@CY4PR1201MB0149.namprd12.prod.outlook.com>
x-ld-processed: 65e4e06f-f263-4c1f-becb-90deb8c2d9ff,ExtAddr
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCAoa46WdNwIf67F5V3u9dXckMh76Pji402/TczFNTolVSLUZ1V2l10FxVszRvkAR9H8c3xBAYwta40BUQgExmDsQD/shApuFJKP7yti1QE0ouigRTVzPUxJhptxEonDg6hvZdRLvDUGm3k77kcT/JTuuJxbd69NGECHYhFBiSolqH3iTauDy+m2XfyQOc5uol1Kh+Q9xtNW43gSKqI5ZnfPCFTxDdnIsIvIk7aszRK2zfKwPDhJ3hN4uEr5fDuVDM4HSqvxZt6wf+0ib68n3KmFxD80F+ET03RVLWAvtcZd1s/U+q+levOHJZnzmg/IMg++iy4Mxta79noRnTnOdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1201MB2532.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(52536014)(5660300002)(26005)(478600001)(2906002)(5406001)(71200400001)(55016002)(9686003)(83380400001)(55236004)(8936002)(66556008)(64756008)(66476007)(33656002)(6916009)(66946007)(76116006)(186003)(66446008)(86362001)(316002)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: UQbHCKjkAhy2skAS5AEjczLGTHXKF+LK/DLsLhk+h6NfAXyMO0eRNl/zDqpkLOAquORJUAX7RnV6nr38jp6mjn00zoTF8nElU9lniVA1PC1Vqk+0/KQ8eVRIWuwp8X0+7yyMfPk7NfHkeZe5XEeext1r0niEPKSFiAFL1MCuLUg716sdstP4EP3SQ0uRtgduaGs70G6idKzp7guZxRMrrmuyscJf/5p5ppe0p4+DeOiAX9s2kyVgiwg+vFqz3gLLzzuU7SYt6PqhrpniejI1UxnMbG4nwdvBgGeX6tMG/CNQjD1ADuXS+mSrAskMEvz6PScCYzkDF9aihU4/wEBvt1xcmTbaPKwaRjphkS/qQFJDdi1XOW0frh2hmPEoqwT5ybU0IzjuWfuaB4zzhKHtC+wc19hnP5g11OfuikGENzpYRMgmxsg374gF/FyLXGDEJQYGOsJ2yQJPYX6v1Q8zf+nCUwmgKHdRM80RQ/d8l+IKg8SkibaMPSXLglG/w88Tp7ngflZTx5HYV6Qs6z3aevErThucanvnljQFQG/b+lNo+K2xV8A1iarfWPepxI/+/vjhBD35nEGD1a8z2w2P7BSJHvOCpR+bUtrvqV4TQgtKhVH37ZQFDlyTgES5kzs+yeJ87asYxhNQDyc77iVaqA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nttdata.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1201MB2532.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e5f737-5796-4cd9-f406-08d8502fe714
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 17:36:34.2770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 65e4e06f-f263-4c1f-becb-90deb8c2d9ff
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IikX6yQHRHEijHFzCXf8Zidk8/Uo+GGaYrCrRE9tCiPMejw8U2qetr3eCFrOf7RL+uhr+M5ykKmC7wZwGb6dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0149
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-03_12:2020-09-03,2020-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030163
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Title - Edgport/4 compatibility question

Hello there - I am trying to get some legacy EdgePort/4 and 8 devices to wo=
rk on Linux using Raspberry Pi OS.

I notice in the kernel. org notes, compatibility with Edgeport seems to be =
a good possibility.
In dmesg I get "usbserial: USB Serial support registered for Edgeport TI 1 =
port adapter" but no corresponding ttyUSB0-3 being set up.

I also tried adding a folder into lib/firmware called "edgeport" with some =
firmware I found online but I get multiple "Cannot send clear loopback comm=
and" messages in dmesg.  This did seem to create ttyUSBs 0-3 but I could no=
t use these devices.

I do not have any problems connecting with a few Keyspan USA-49W devices (w=
hich are also referenced in the Compatibility section in the notes) so I th=
ink my machine is good.

Apologies in advance - I am not in anyway a Linux expert.

Any guidance or tips would be appreciated!

Thanks
Andy

Disclaimer: This email and any attachments are sent in strictest confidence=
 for the sole use of the addressee and may contain legally privileged, conf=
idential, and proprietary data. If you are not the intended recipient, plea=
se advise the sender by replying promptly to this email and then delete and=
 destroy this email and any attachments without any further use, copying or=
 forwarding.
