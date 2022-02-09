Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5A5C433F5
	for <linux-serial@archiver.kernel.org>; Wed,  9 Feb 2022 11:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiBILFM (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 9 Feb 2022 06:05:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiBILFL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 Feb 2022 06:05:11 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1856E01C530
        for <linux-serial@vger.kernel.org>; Wed,  9 Feb 2022 02:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644403120; x=1675939120;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=5D/0QUgoH9JGlZ74NmdL/hyB7WEQbne5NYgfsRvs9+c=;
  b=piiMdA5H1xVl8T7wwkqeNDOdHSRCf4jpMoUkg7FPaAKyhJN1GoV7v6ny
   XR1AVQ7qXQ6uA7kZOJw66hTjwMT5YZc9DcM7B0mGt/BMYew2jLJQgoI+e
   HTIq7GqusdI28VZXHCyJ/nND6dNAE/vS+ps1sNuHzjA7GD5l1nFcA4qcp
   YwQrXMH+7urKtOQsllgIh5bCqrAsORP4lZXMqZTeEW92fZbJYGEnDYh6X
   XL/H5RE5S0y3kkCt0UlrBdjq7r/1gtY2CQdFFdaD+hNF4ZZ+juu3JFWN5
   723KKLKfIvCzQ9dRjn7JJ2B+b9fmMMl1DKvcVH1yWNbdCaTTiEOzzVmKJ
   w==;
IronPort-SDR: En8+PDFBrmv/FBcm+K1qz6/7jPNLWJC3OaxPiPkZ44epR22Tbl73MvoDv62uAQWYurNX0ubdNH
 /yRYJXYR6wtrPE1JP/H+l5/+A2CvKySuLb4XS6O/YL9hzk66rAuZcIj6kehG6DKBmpEr3zutAp
 s6a2yxgVNN6Qyk4ur7l+64G8+eSlK83GdRK3/UQerlddE30yWWqGVzJkXwNKhfQC9OTCYkjmOF
 PefsK0gUpi6sMeZOveBOsUvyVSqNsDKgo8Wny1AEmFcirIHY/1bA+QXSVS1x8E9pp+j8MUB3hX
 T2oF2GKz1LyFMcibvJDjwFxG
X-IronPort-AV: E=Sophos;i="5.88,355,1635231600"; 
   d="scan'208";a="152443837"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2022 03:38:39 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Feb 2022 03:38:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Feb 2022 03:38:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJiR0KCT2kzMlz5p42g7+dy+iyBJPFZThI8542j5f5zAFx4RAmCdU9UFZo2VV7YjFCBjS5lVAKEaQ/672C3BMdDqAzqf6P8/xDksj0e2hCk3ck/NgRrXCwvaS0kX+43j0yfVy3waZbq15gkoe5ypvl6TpOtqZVtX4Q5T4wRhfxaWQ8nYAHxXP7O+8CuWyj4Ue/F7litvolufSDo4FENopf7IHCAtpypOsgkagDBoBko8NLTkB5ZGPUP0T05XA6nfnhjaI9Uqg9yZxaKmpUM0kpjnIJ3/IRDG34pYCTv1nVypE2e3mGn6BrVTXbpRWwS1iBZZV3n3et6T+C51iKc5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D/0QUgoH9JGlZ74NmdL/hyB7WEQbne5NYgfsRvs9+c=;
 b=I/IPnGVpkDgSv6sIciunOEb9G4PkswztOfcjJ6AcRRZvOeTJ5aQ998xgop6LMdKXfaavKci6S/AgW03k6w2029L1jAA4IkzLAYc0xhIcsuCgXND71ni/VCPQKtNfkVRbxGG1AOezV6z9lzqitQ9cmdbGPSCUbJuu3KihROEIVjJzz+7eZv+K6+CX64OZL2muDB8Z9Utp6FKsZn8L8kqNbRggbu1hDCcYRZlksKsM2btjh2HdQXcmUTPJRREOmRNgCw9+KKGXyIg4iEQz/Xqgra7JhGvrk6LEGHNc91uBJG9k92o2ma/GDW2cpCQGTgnZGjmYvvLXsRQNpKiQrlcUZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5D/0QUgoH9JGlZ74NmdL/hyB7WEQbne5NYgfsRvs9+c=;
 b=kEzjhjoKeRs39TdzidAXXM0RTXRszebhhyStaS+hXb6cQCRnfN2CnssKdS9raboyTtmBc7uitKUnKiaTHe8h32OVeUzpM88BRfZhx7Ft79xF8YIvdauPBbJMddeVfeJtXxYdJ95t+0udPcerHd0SvU2z1vNbGLlWSYYQ88ud8bM=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by MWHPR11MB1984.namprd11.prod.outlook.com (2603:10b6:300:110::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 10:38:34 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 10:38:34 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <Sundararaman.H@microchip.com>,
        <Ronnie.Kunin@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>, <Annirudh.D@microchip.com>,
        <Pragash.Mangalapandian@microchip.com>
Subject: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Topic: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Index: AdgdoSwgtfXI08/UQwiITF2vlWhSpw==
Date:   Wed, 9 Feb 2022 10:38:34 +0000
Message-ID: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d6803b3-76b2-45a4-00fe-08d9ebb852ce
x-ms-traffictypediagnostic: MWHPR11MB1984:EE_
x-microsoft-antispam-prvs: <MWHPR11MB198462F4D976D3607942E9B5E92E9@MWHPR11MB1984.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bRjIRKnI0tQfx4BlrY/v0UwbxH6O2vuK3gqkNxlPM7SYIR1uaKDEosMPJ1AI9ql0mzZaquB+rYted86unQM/Qn1tbiorbyCXdvexa4CQjK8xuCXkZKeuhVBF5W2k8LH/+dCPP0238DBLSpy4006tNGO9KItgoaBKJ9sriZvoT5uBkIJ/vGSARaMVKBGyLZzs8f14E1n7w+utGSrFnUUh0m7e6g2Pn8lCYg89EU9/uvmyL1Tf3f1jIFz2Y6C/lfNwYOn61pUS1PH9F4Q3w1WCuOvFRzias+t+tM1sAM1v679eTGFKxvyN8Oupe4teJsglTCJh2HM/nRB8V9d0wJxuVL/t7NPeKZB2kWJGAMKFSlpeFcLnETRTwCVfizZwPm9d/SgiMj9coT+lzE9nikEpIDRTgKzN36+zYpBrsPvLJDG32G5tcdr6bq35Phxne/pZ2hmHquMSQq2cy3510AtEva0Lab9q8lcMp89XN+zO0iBZXndypUiwN8zeFW3rGtrLEWPzph4enQrsn1898l2Jv987OOl9rMnb/c5eNA1RuxkJQ5aTGcccD5ijY2muifDfp46kA4X6mqaYGNuv0DbcwBIP03glt6j9GTabJEg+ZpGdFhI7ZHGZktfmZF2rKh0dGLqk19OAZcd+Yg6oNUuLRcbMGhuGPzw1Laf36wL50CvYS48CbdYpjVzYHuJvJLTos+PzcCVU0oraxZ6NUh98NQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(66446008)(86362001)(9686003)(8936002)(66556008)(64756008)(186003)(83380400001)(26005)(508600001)(6916009)(316002)(54906003)(4744005)(122000001)(66946007)(71200400001)(38070700005)(6506007)(76116006)(38100700002)(33656002)(52536014)(7696005)(66476007)(4326008)(8676002)(5660300002)(2906002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DnAX47mH0nbjQ8u1XdCPDgDvXgap/4mxXPIZB07dKjWWs5Afq7fUxSFWn3NX?=
 =?us-ascii?Q?C4jRihk5s6ba6+cjbTuk4Ln+mPUjOBXKk7VT/O0VWpXE1sJQThlO1ongf46t?=
 =?us-ascii?Q?HpENWkkQSB/WkmnBgHmDmQkGcPVuUA65dOO7yFmcJKcXauZUy29YpWsLPJS8?=
 =?us-ascii?Q?GJaAXHsgTvbs0lidBHE9NmqXp9BY/qExgTC5bNf6621OhnBZPErJVP2Y2jeD?=
 =?us-ascii?Q?HD5pN2Xk/yO1BtBuHV0uaPaXqnAboZnEsyMQ/5mcamcXp6IhYYQ2hnkfqJCM?=
 =?us-ascii?Q?Bf+9B6yQUbeuWuwpysRM6yBkGdQcetAcwkhRcZv8ZyK8vxDWiX4ph6IkD15U?=
 =?us-ascii?Q?q60/XFB21cjY+x6TLb7KAdTgXImYsxKgRZnrvBGEWjXridp3ouhd/DV1GL4D?=
 =?us-ascii?Q?fu784ZXMKuoj4fv8EbOH43qpAbI7WZOw0cIxZzAy+21FIptS1ZuleTcrKinn?=
 =?us-ascii?Q?SzyQqGbN+7TUFdxrIwSHm9pKodOb01cU1bUwMw8Dj6FHkizBuEtLXsrxMSCV?=
 =?us-ascii?Q?KtAvT0fV5Pda6n8K5CU3pOZ+SBafD2IAf5IvuguacGkEFONNokl6kNFT4azD?=
 =?us-ascii?Q?k6GJcaoYewqCO/taBxYc7S751oVzAGInbvkgjiZjfnluyj5kAtPzMXCgf5D6?=
 =?us-ascii?Q?DPGB/CDo2Xowk54m3yCMCYkDiF9DJEHEyKjUdYDEFXjyWnOJqN3ybgr8UajP?=
 =?us-ascii?Q?aobYoRMzUzkbth1+Imot7WKAVCm90tybM35oswx14nyyolZQHB0mvc/JVdU2?=
 =?us-ascii?Q?9jp6QptMOQxfzF7vE1bqT1KL68w2a0/E5e9aNkiBerLH+OvyFHFk7D0/d+JX?=
 =?us-ascii?Q?gtQFINxFiypKRRcoTnvNHx6v7kmDi4VcAk8dTuU+5qHJ7u+ch9UKl7QwAUfV?=
 =?us-ascii?Q?st3W5WlDaz7BOK4FpDcyKcQ+3J0CrB/kXCjsXQkUmU163EyJ+0zg8PQvjpxr?=
 =?us-ascii?Q?lbCiR347vOS2Zi09YxPrM2mQqrNhLNdFzV6Z3l13U/klCKz1Aywa5mDwxTbG?=
 =?us-ascii?Q?wzg04+ylwNLJdW/lJ/KLeAeMSOxl05Xj0LuZBqS/dCufc3TUzkwgjnH+QmTy?=
 =?us-ascii?Q?oYtrXRrVfGdWkYk3Vu9Zg88KSRtP7olQkC5Ps1vcjIla+SjRUVs3ASa8Ja5/?=
 =?us-ascii?Q?F0U6kVpH1phBZxTATOgxN0HNASsSQEqjbE2WXsuNbtAQZNwnohgzi/kaFLk1?=
 =?us-ascii?Q?43bpWP+ErBLVnadkESYkswwCWnAz51t4wiP2roLOhuyTNdz58FUxxd+Myne/?=
 =?us-ascii?Q?C5DaYPra1+UWrCA/hYAfmcAuSw78ID2/RarKpbuEOsym7hiSbNtVTAIWfC+4?=
 =?us-ascii?Q?Pw+/7h4EGX5q8Ah710fy5265q3ju6kJy8czjHo6NP2PhLJA9gCtcuD2biOb+?=
 =?us-ascii?Q?DIp8gvG51YAT4Kh4bQKbIcpUJ1kUZjFYghQjs5UELjbM+KKsKP/eQo2DsMHL?=
 =?us-ascii?Q?OAyIXvMSUyMqWX2htIyz3QPA5g+yRDKAZIJYj10AzY5plZz8m9M72R0ZlqKa?=
 =?us-ascii?Q?XUvgKSfek/S8ornwkocF2v7CAVFI6hP85r2JGbl5Y+f6LwE9VnS1ulVcHLX+?=
 =?us-ascii?Q?Trf1lEkoP7erFRT5Aozdf+lWrsj0XyOkuMtu88O1C5XqwWK3UX+jakDrn5Pa?=
 =?us-ascii?Q?EDpl1E2IDCtXVM4nPjgKbNJNco7CtU/tuAR6gJVmJhuCC6xWYh834KQnXM9Y?=
 =?us-ascii?Q?8lE0czHbvlO1lTl3F6IBTD/vvTQ0qx+AIDCoQoRE6cajbpjonKdloS708Jag?=
 =?us-ascii?Q?GiyMYAi9WA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6803b3-76b2-45a4-00fe-08d9ebb852ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 10:38:34.3972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UdYbsYaWW6RNoeY3HJWkauz6Nz8yBHtcFdVYqAlg0JvjBdyPm1ifUDBzF+/VyIE2rUHcAnrqO2iSZ/Dr/GLCmiFfdBnR7GZ9Kwg/HNAouu6LTypWfEFT9dZ2Rw1UhXpw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1984
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Greg KH,

I am Kumaravel Thiagarajan from Microchip India.

We are working on a PCIe based multi-instance UART device.
Based on the Linux community feedback few months back, we had written it as=
 a custom driver inside drivers/tty/serial/8250.
Now this custom driver is requiring a DWORD FIFO access for both Tx and Rx,=
 and I am in the process of changing my driver code.

Can I model my custom driver on serial drivers present in drivers/tty/seria=
l/ directory?
I am implementing my functions for uart_ops structure and the necessary ISR=
 in a separate file mchp_pci1xxxx_uart.c inside the drivers/tty/serial/ dir=
ectory.

I wish this custom UART driver to get through Linux community submission.
Do you see any risk in this approach? Do you have any suggestions?

Thank You.

Regards,
Kumaravel Thiagarajan
Technical staff Engineer - Software
Microchip India Private Limited,
Chennai, India

