Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EBCC433FE
	for <linux-serial@archiver.kernel.org>; Tue, 22 Mar 2022 10:59:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbiCVLAo (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 22 Mar 2022 07:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233828AbiCVLAm (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 22 Mar 2022 07:00:42 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2756A438;
        Tue, 22 Mar 2022 03:59:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX9VUTv909hmLOPO3opx9eanxxoWB+uHdmGi535zQP0KkNrQcMDnHtTsC7QvS3NhIbj75It+AiiowvAKROlh72QofXcgFUFnCGK9DOM4JCAbCzJbj7+EHkEJLfMhQM9iAbrVcezDmmL6DYX39VjoEhCsghGPY9P6V0vGIHX89kx7+8ELE+w+eZU9NsTdwCXYnxGPK90D39qfhIeYJzVZyDSdmvPqPzh6nURJvANVXVLP0+5dwrCrW3fMYtDFdoYdZNKlpZ6EGPHDkfGL9O2vD+v6xsNPv8UsB3p6nHReqWWukAkXDaCeheNl+OyKV3l7SJE8Rski8I4kL9jwcaZiJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dcDRlN1IRYIsBSOGc5ldnougfqmaXXJc31+x42P9mnc=;
 b=SeOldKzTk4oSjC6Tv0BeG78ShSR18HEABt3FvdzBqhBEv9noS6jy76z4J6chmSCt7pphRwWXLFts/wyP4Sy3ECq2LYSdXcrS3bbg3cw/rX7bFo2l4NDiOra+PCQK2MQVrjrpXnutkSUOr7+F7quinSstsR5RuonH+Eiftru/60YRxKDls9Q7LYJg6Wvr/R9BKxx6PBvLIHB3zOl6iFp8UQ+nk7LhNSv5GVqxpNMQpWESgLLIzQEv31PqX/dCEKkOlSYQZt8rvDtIdXefn3EXyImdRyaMgM3tr3hdVf5CjHWr5a/JCQkfFvlDmbmTyszouV0MWe2YpbKsnPkr6R4uJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcDRlN1IRYIsBSOGc5ldnougfqmaXXJc31+x42P9mnc=;
 b=AF4HTdy7PalVh3zjRw5K39xUMth2bxWvknL2W3A6Rgb5X1LY4VIYL8roTkZXddW5UZD1/JnPQb5NL0f6vUsWgV5qVXFhB9+Bx02yFtnGn1XwNIOWM0Shxsd4rASeCbgT6uD2N251jyMCgHAZxl/SYIwa/K4fD3gf49NusVHqlK8=
Received: from DM6PR02MB6635.namprd02.prod.outlook.com (2603:10b6:5:221::18)
 by CY4PR02MB2726.namprd02.prod.outlook.com (2603:10b6:903:124::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Tue, 22 Mar
 2022 10:59:10 +0000
Received: from DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a98b:ed39:5b71:5209]) by DM6PR02MB6635.namprd02.prod.outlook.com
 ([fe80::a98b:ed39:5b71:5209%7]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 10:59:08 +0000
From:   Shubhrajyoti Datta <shubhraj@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Raviteja Narayanam <rna@xlnx.xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>
Subject: RE: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Topic: [PATCH 1/2] dt-bindings: serial: pl011: Add 'arm,xlnx-uart'
Thread-Index: AQHX2tuZuKAQ26hOP0aW5QzRukRvFawbJZYAgBClDzCAZ11GsIA42cGg
Date:   Tue, 22 Mar 2022 10:59:08 +0000
Message-ID: <DM6PR02MB66352597DBF172ACC5307274AA179@DM6PR02MB6635.namprd02.prod.outlook.com>
References: <cover.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <e1d6913bfe5ce023d7f6ea106d0359142063e694.1637061057.git.shubhrajyoti.datta@xilinx.com>
 <YaVPYiGmDsqY+1at@robh.at.kernel.org>
 <DM6PR02MB663589B3489C53A34DC25A31AA719@DM6PR02MB6635.namprd02.prod.outlook.com>
 <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6640017950EFB0FD21D2AD91AA339@MN2PR02MB6640.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=xilinx.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 81398bf7-c185-47b4-cd75-08da0bf2fd53
x-ms-traffictypediagnostic: CY4PR02MB2726:EE_
x-microsoft-antispam-prvs: <CY4PR02MB27262108ECEA55E237F470BEAA179@CY4PR02MB2726.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oxcoozbCiL9iGex0Srg+qFwe0dsctpUjHKRAOEUe3tT/AA6Vqnp7AoQbibdVmlkfFW5gjtd3pCi9OaNOlxNnriNiafsbs/vYzisGI+1o0VsY7OnoCErH+57TTuDjQRSS2WKowLjcuLPn6/IQiKOaZrVk3qi+bi0FU7e+FiiiThOTa+ywHrH9ZHZ1QA7altfJ1WV4A0NBlfHxaklie0wtDHXxUjduhCBBI5AVKWStk5QmGRG0sG63KhfwBSbsJjeJm7BfsOx7wRVRweKsYbk5Jgp4HPdyWjYFphfhifUAj+6vQLxapngSfEkIqDFee7UYsftxpzIPKiSv2sW3bt/OGlTefD6xsNer8R4GZ43S8TiqjmIU6O1dTcuVSD/vwhWJN7NB+QLp3AzF8/slel9vtE/iTGKKKdqmAEKYISCSv5pOxlb3zjKPM+NWC+nulsH/hLldbvrnHMLgzbquLgxBRLMvmjA2UqJ9Gq5zVqzQYM00wcuNZOrDolyQC0uSMRgMyZf20B4ZGBt9IdDBIoD1C8vJVDj7meZkoODdrXSdwChLLQO2KV2gKIUKbUaDy+Ez2QIu7I8X7ks8n5mSd4io9hSCWPkEyRpTgohVvtuypwc3yiqAcKiFVjbnRFG3CM9mEifPU1VJsRFTEtp5R7/ae5MO5zuiAE/rYYnII1yqiPazWRPlcjuVjeXbGTB7GTi8Vvxu/OXAJ9i+7ynKhZ3ndQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB6635.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(508600001)(71200400001)(8936002)(76116006)(4326008)(66946007)(64756008)(66446008)(66476007)(66556008)(8676002)(6506007)(7696005)(55016003)(86362001)(33656002)(38100700002)(6916009)(52536014)(122000001)(107886003)(83380400001)(186003)(26005)(5660300002)(2906002)(54906003)(38070700005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?G0dk+mSsjLhnYA2a1sMvXyF68eIv8/Kn4z976xUIQeooVtWr5sx5QGK/aueQ?=
 =?us-ascii?Q?o7AjgGJ7NKmkkC/mT2DrlqXkn9VhIrz1lhYBazt/sWM8LKybU4feqO2yQmvu?=
 =?us-ascii?Q?OcFYFl/OAgPKU2lEm5nA+q75oNMDeER2IaVzuJxkUz9wVdHHm6cyfqYD+iNp?=
 =?us-ascii?Q?TUREFeV/kf/lrVnNe14y4i42G272XsXp5kGSJSojBlSFf0Ar2OuqMjc70NqT?=
 =?us-ascii?Q?WzkKB8mZMqgANgL24k/7eT2+85e54pAUBltFEUB3tdIYQ+ZAINe1EwB0dzwI?=
 =?us-ascii?Q?5BxPKil53s57zD+SZ+mfeXdZTs+ic3+QsxXTfyUbMvR71+Ozry0cPQg9qcJr?=
 =?us-ascii?Q?lf5O3Bd/efn7ErhfC713FvvtcgKPTe+fv1IahtaYsSaswHdEb+TZgY1Ssi76?=
 =?us-ascii?Q?GZS1/0Xr1ckuISsmU9EQBDW9Hsd8h56UDZt7EsZ0zhaa4ZtvhjFujsRF3X7X?=
 =?us-ascii?Q?wEZBPnzPxgsI42s6FtlG2mJlfofyHONEMvqm+h28jImIBOAD1H5HnwBctf19?=
 =?us-ascii?Q?az79c6748BxiobQf2CNff7IuHBBbiLSOp+id960i7d9emUwqwqL97EqLmB52?=
 =?us-ascii?Q?j/6acc4g6W6mjM/Ko8DNLe1MvxD4cwGMjiY0nnEVvRfYNwXNwa2vzViqDMTe?=
 =?us-ascii?Q?VGF5rY5D9OJ+UPO8zpoVRG71UD8l6EAw/I8hJ3nhJqZfY3oH8HBH2K+EPU/4?=
 =?us-ascii?Q?ueAaQ0BpqAJTaRHLvS09VY2l7dJBdDGWG+tMmOmgC+6aTpRkCxaQtY/CV+kg?=
 =?us-ascii?Q?V/varpNi9NEw2RdD6UHNwmTWHUHXKrqxmjcDIt4DEpnO9G+WTEVXodgndeZN?=
 =?us-ascii?Q?CiqpILVeHVMj1l10XNGeSySAm3Q6kjzYe83/t/FX028Z/52xNioamK+7YPdi?=
 =?us-ascii?Q?Ip/6vIiyM5laGtxe99dlZOn1CjsgkdSNQ5MN+uQ4EIh+2460o+RajemtQhqW?=
 =?us-ascii?Q?ltUrEnwMxiSBfXiSViazsl8jGE694oUxOrZBBwHpOot9626iPwxwnimrNis4?=
 =?us-ascii?Q?50hQEEbsLYrU4XBzREHuOqTbvw+EUpWruyfcR2YVFMzQujQ821FvqIhgql6v?=
 =?us-ascii?Q?ZErzULDdIdO31ZWSnixY7dCwyFjfVk5oh6HyBsqGwz1mzabjbc17AoQ0SJKQ?=
 =?us-ascii?Q?ZEbrUEV1UpKJMLRENi5METc4kugKrVyBPp8RNLxt4Zbw11emorbOk3T/zOd/?=
 =?us-ascii?Q?cecsAF1HWRZPNFfJTyjyZp9ois87d/Y87Ega6+rb8EWT3tgkro9nqHVie8mL?=
 =?us-ascii?Q?/weyhzxQiEAiWnusKXj4RTZttv8HubJzLPsB3+mRsUVUCAjaYipJhX4r7uNR?=
 =?us-ascii?Q?UdApg7LBMgNmudDg5cKLryf8s5uLWRBwFV0Qh+Fnadb/BtJ+1nJj8jD5x45A?=
 =?us-ascii?Q?zCYqzF5lx0HIQdRv2nMeTVmVj6Je+FAKvOTC1Z5rRbyeNpxn5jJ55PTiX95q?=
 =?us-ascii?Q?QTqtQgYb7yfFPT1YAU1XEN0FmGX9wrCd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB6635.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81398bf7-c185-47b4-cd75-08da0bf2fd53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 10:59:08.4434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eW6nJcN47OtVV9PIaHcPEZPCXM5HHYwm7HQoVHJF4bWn/S4xNcvTTJmdSwfl+bAGaYhuesEl8DO5luXsC8nvKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2726
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

<snip>
> > > > diff --git a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > index 5ea00f8a283d..6c73923dd15e 100644
> > > > --- a/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > +++ b/Documentation/devicetree/bindings/serial/pl011.yaml
> > > > @@ -24,9 +24,13 @@ select:
> > > >
> > > >  properties:
> > > >    compatible:
> > > > -    items:
> > > > -      - const: arm,pl011
> > > > -      - const: arm,primecell
> > > > +    oneOf:
> > > > +      - items:
> > > > +          - const: arm,pl011
> > > > +          - const: arm,primecell
> > > > +      - items:
> > > > +          - const: arm,pl011
> > > > +          - const: arm,xlnx-uart # xilinx uart as platform device
> > >
> > > 'arm,primecell' means the block has ID registers. Are you saying
> > > this implementation doesn't?
> >
> > The ID registers do not have any Xilinx specific identifiers.
> > However there are differences  like 32-bit access.
>=20
> Hope that the current approach is fine with you.

Could you please guide  how to go about it.
>=20
> Thanks
> > >
> > > >
> > > >    reg:
> > > >      maxItems: 1
> > > > --
> > > > 2.25.1
> > > >
> > > >
