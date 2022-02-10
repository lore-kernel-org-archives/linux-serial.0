Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DC1C433EF
	for <linux-serial@archiver.kernel.org>; Thu, 10 Feb 2022 10:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239713AbiBJKim (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 10 Feb 2022 05:38:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238091AbiBJKil (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 Feb 2022 05:38:41 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033ADC39
        for <linux-serial@vger.kernel.org>; Thu, 10 Feb 2022 02:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644489521; x=1676025521;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/TreyvpdG8z1GNyncZuX/KFFl9QwdYk+IQvW9hZfycU=;
  b=g/QjMU45+QIm5HT2oO3MCH5s72XiABybgmp5ekkCPBlOp0LJ+kqcus8x
   i46Vg7pGo0CxT/uA/G3FxQq7KLBWpV+ybJwfgwAAHkKv1EZ4aQzmhUjz6
   qGzciXg9v/uveQcCpXiaDiuAZWDFTfF0jJJ5c6LzqMuSGRjFv+9WKr/e+
   sVVcBaxr8eHi1zLN8HQ9AL3Nu54Cy24j3IHmcn0gVfAWkT5phZr6Y7UME
   zGEQwm6k9yAV5jr6n2WfSd+EJZ3AWseaHLzEV5y2X0xEyyHfxTh/sVJ2X
   yzAO+FkpO46lNegK4RPimlArlGcrQ5XbGferYbZZ59i2QP6+5b3exqsAG
   Q==;
IronPort-SDR: J04xWOfn1S/uBsAOqidDOIJbb1tM6F5dy/Adgi0mPUCZ47YvYFyHIhDkzpxaACaa+5Cd4I2Mi6
 ViIDvyAO4SXDOViU0pboJT06QXCd6/ruaUl0cL/0b/Mj9tn3cby89ONMfd/dE0bNMvWrC8UCdc
 zpH+hR5noJYKZemndi9+e1xYtXcla/oA4hYjhZqxiOgEcgJ/SihVVP/EkAEfkmNpdRzomhXsA1
 /L+tu1JOg4D3FvjCyxe39mDID5eMAv1Xeu1EcTFOYHzQv2dRrhoVvDLpRAPNnypTS7ywCKh9FM
 7ROnFK3Jl4LFRMe/Y8VTx0YY
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="161768338"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2022 03:38:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Feb 2022 03:38:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Feb 2022 03:38:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1cPSlT+aqF2+a3IW8nPzMgIbszj1Nbus39Hyv5sclr3MpgDmTFU6oS9blPRG5b8KKN+IjfAp1cMD4/VgYYygViW6DMW9iCvVzp9i9phUahOzwkXrFyaEC8pgjYtIs0hDfMyIoYTEFaF1Wmpxq9lErrZiFVXZ4cS9gMH9keQGsKjPu8O2XcKYj8iPsm01XJEHuXVe/RqsnEGOMf1P9qfGRB16IAD5OTP0Dkir/FUdyg3TLMSB/j7oQLYaQIfdjMbKIuA3a719xprbQQQPrJBPN7cgHzV8amC3mkLLKtaW4yqvfOO2J4GFB6zTUhk+axZW/vTerjw75AxeU2HUr+X7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Yrb+J5WuqBGUNh5GI5FKNhMcDiJOaxCkYVUVruklf4=;
 b=nlBjAs73ffUMx6hH8RSRUnW6Tgq4KOfJgFdlygpsitD9aqaoO4acf2b/kwAG0fwxEpfM25Iw8W7xSFCtNqCmQihE67TF781PeKNkyXiQNwgREEn8Lpx+eOpiQADl+zaFd0WuG58TRLgPUi924i0/abQCSRSDCt6HC1SUrNXewQl6PslJiKrTtYFmOHmW+UW6C7FHGl7aESk40rpzpFdXsJs17/a5M7zJhZaQo7Y+eoCONkyuJLzM+FcQaG7hvgJmvpImsu+wsPebIWsrDp0ysl16G+zw8+mMWwyRLmeQpivMBFADs6Vp9jlStoLRyIqhs67KJ3Ahfq447VLVQSFlfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Yrb+J5WuqBGUNh5GI5FKNhMcDiJOaxCkYVUVruklf4=;
 b=HOmqrZIbcKRPb5NsX/TgqyCFPTWki/PcI7zDGdVbhBLXTG2ILopV7MB0hU+y9/vvCgpGO1/k9VsQT9tCtI2Uleqem274AdKNxX2ydL8+C2fEn6mOHhYN1IAHFLrj7FKvizV/LKEkQTk+rK9Q+HgX7g2uxGArdxr9hxXNcYlTNmM=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by DM5PR1101MB2249.namprd11.prod.outlook.com (2603:10b6:4:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 10:38:39 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 10:38:39 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>, <Richard.Petrie@microchip.com>
CC:     <linux-serial@vger.kernel.org>, <Sundararaman.H@microchip.com>,
        <Ronnie.Kunin@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>, <Annirudh.D@microchip.com>,
        <Pragash.Mangalapandian@microchip.com>
Subject: RE: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Topic: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Index: AdgdoSwgtfXI08/UQwiITF2vlWhSpwAB1B+AAC6iIhA=
Date:   Thu, 10 Feb 2022 10:38:39 +0000
Message-ID: <CH0PR11MB5380EE38DD9B8BF9EE5F1796E92F9@CH0PR11MB5380.namprd11.prod.outlook.com>
References: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YgOl6SFsKnZxkbFy@kroah.com>
In-Reply-To: <YgOl6SFsKnZxkbFy@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-Mentions: Richard.Petrie@microchip.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 027a996e-2332-4af2-9dcb-08d9ec81801e
x-ms-traffictypediagnostic: DM5PR1101MB2249:EE_
x-microsoft-antispam-prvs: <DM5PR1101MB2249B6627D21AC673B55D714E92F9@DM5PR1101MB2249.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u/w2iulXpkYaoPyhMgQfbxHS4vQNnfhdhgcvFtxbNQQoJ/ZeYgwLhL7Z518uc3We5w827kolfvj7XL4NWbyri+Z5E02pRp2WN5qireo2LdfoIFmkmH8d8lRA/ulUTbvxcU4FUhnMWKAZsg557p3vaVCykQTR9R5U/hv+6fpnD/5AsiHMDk0uWRUpL1sAEb/2L5P8QGq3XgMYmzYZ6kgrGhw3kRlKsinwlIcP85SAYSMy2ynt1uiBdEINRkUOfpkM7BxaQZME3u9Xe9v7bCcT+cwQTvpPRHxsnfWZ9e+GPsHeb1nGSJ8YIgcDJM49l41o1oarZE8hTBzma0nlWsfiPCc8OBu7Ed+rkDNK4klq3EJUDc5jA+a1fV8mzcOBcVQ6LQTB3Ycmm5jGYlRxJxXNz1HNFoJ1Le0WK0OPsYY8pdiXas9edpnSplLr2zZhFCS0r5bUeMPmrYD5MOjkZiMOu3PC1OihDWh2DFoEMIHx50pi4+s3CVYJUac+7me4KbbhcYs9wcWSTVxSCQZ6lm2zkVLQw+zlFxHL/kmmzcEUHlz2rrCz1FZnc+OVr8cDH/STxQZ6RA7ntjMOG7OHj1rD5zHGklRhFOydWoVHTOYbdK78S++VkwDFMHFvblXx3diWgyLMmhVF8ZPI1SQbQuhyiG95GdlkvDMTkmvc1waujC/jVMuHwHGD7q5yRHFlWkNnj4nI1NscsNvozGl6GLmcBw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(9686003)(508600001)(53546011)(52536014)(5660300002)(83380400001)(55016003)(38070700005)(122000001)(186003)(6636002)(8936002)(66946007)(76116006)(64756008)(8676002)(66446008)(4326008)(110136005)(107886003)(6506007)(7696005)(66556008)(66476007)(71200400001)(86362001)(316002)(54906003)(26005)(2906002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RClVwG/kIYz7N0d1paWPX+Y5sbhWfU4pLxGyicWuiipZorSpJsx9f+E6DA3W?=
 =?us-ascii?Q?egq5yteJPsNcTuT0vzDiKXqWTRnRKfZJAI8ZIBzS7VxkKTYHw/Uh+kMfw3nL?=
 =?us-ascii?Q?OdfkiIIdEdpmhqm9pFKWeVqULGHIvcmA0xqB065ugjUeEnNUUVeMjxgIq1ci?=
 =?us-ascii?Q?9h+AO7sPXzw1Mf/VisAELw8+y3OFeroA+6jcBCPEvan4tW+7WilY0uCv4aiK?=
 =?us-ascii?Q?mVUQuo1eooqTg2f6R+xOENz2QQ92Ov7VD9IfTxd1xc2M9C1skN2oiGECpqQt?=
 =?us-ascii?Q?pXVksAhlPB3GwaPN8+k6PjzRNmsKN/3740IszliD7hYTooiNGVxQ8CEP1bEB?=
 =?us-ascii?Q?t+75Llk/K33BzKYL66dGdACtX+A/PSfKygAku5BqAFArTsEgGUw3eTEVzbhU?=
 =?us-ascii?Q?/kX6vGhoCqsXzV2IKwcMQRB1NM+T6nzogwv2O9i/eKeZMnxyE6MvvSWPsDnf?=
 =?us-ascii?Q?rboMpiBws8PkOvFF+oGoHrrXfFibyVe08YwtZF8xRiePo9DQwIMoLOFCpI62?=
 =?us-ascii?Q?EbRxQmBFTUq44PZwndGTAdXbQEXhMorxfYtCTrXWD+4ZISxfdQyU9HX7A+uI?=
 =?us-ascii?Q?st9gL7v2ER1CZKaCF37YXtjS7nBhry0wkkSrWuSgM8RJ33Yet6H6JnrQXS9/?=
 =?us-ascii?Q?VIf5hlKtl4r/+RxKX6waI+Nek+cV0i+yhoGneI4tS3Prh21d4+83KxEyMmh9?=
 =?us-ascii?Q?Va5z6FkVClkUBPdVA//vJdv8NdS1j19bD6ao/xtEUWkQRV3T2nUIpLROKeHG?=
 =?us-ascii?Q?JBqO8mpunfenuFZ45mFsV082VdaoQ9OaheKP5AecElrhSHAWdC/qObpkkwVj?=
 =?us-ascii?Q?RxxKedhEZuEOpE1w5bMbPr8q+rLMFQIHyycbyaUgtr6iVPOLulz3aTyXUKlb?=
 =?us-ascii?Q?g3S4c4tSXknFwhqrXp5bOIGHwv4ZIBCHlJYisLe4CYAkuSSQV6/c/QngEELR?=
 =?us-ascii?Q?5J3PwYK+14ipIZst4lt0e6O6qGOylbcA8NYR8Umt4sTtt7V4Bh2+y88B3UZj?=
 =?us-ascii?Q?aagtAJpGu/22M4pMIyGVJsClvYWEzhiVqd0ChkQc1YRWlpvMFg3R8Q7DRScF?=
 =?us-ascii?Q?F1SE4XixzokkW/OROfTmHXZ//n+ARRk/izFJUZcU3uWiWR+h1aZoOO+GlRtD?=
 =?us-ascii?Q?eTxitsU+wO3Tf1spDT6C2y62kkfDIfK2X2dS5SqQoSJOsTJOo7NBn4Jsp0rC?=
 =?us-ascii?Q?vTcMR+MblScEaLIEFUkjTyXgxcUNPC+p0mBcXcemXLNc2/vBkHl08AgepXT5?=
 =?us-ascii?Q?p5L9aIWG7g8UHyhmasCknnAr2NK+L9POFOIKN50o8BgU9QefZPgFPRpp8hdb?=
 =?us-ascii?Q?hx/TWOuJkYWHIBMQMg0ZR0XHYk8hl+gsJ3IOOhXANR9iQhhMa9oRrWa0dcwZ?=
 =?us-ascii?Q?bZXDAu+SkYzStw5CGcuH1gf+pJdeg66bWodQWTZ9V4d+dUT0lKGRz6jiDCGp?=
 =?us-ascii?Q?bt3AodD2YuervJfLvA+j2bEllAfrWFvb2Nv4GsAaTk5nPXe7p+BegeEXSlfD?=
 =?us-ascii?Q?uytr5D/Mk8uCR2zHW6tauNg5ot8HAPsFhTRMNMotMhhqnonShc7NIHIrntO5?=
 =?us-ascii?Q?Oej1UrMXppQfiqpfWYhkWmzJkGC/IpEhsbZetybSSV2p0sHOUDadeEFbOLi0?=
 =?us-ascii?Q?HS3UgTFQsK+YubmBsL18LmKWDT3tojW4oyrGRH3m7pBh0yFRLmS90HyIR7wP?=
 =?us-ascii?Q?lXzvVFA/E+K0LWwJWz53zj+UwveGLqB862Zes2094gtaFRBb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 027a996e-2332-4af2-9dcb-08d9ec81801e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2022 10:38:39.3124
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S7s9bQBfaF1cpIkHUHJgYBmbfYwnvTRrCgymllJcpR60XJQbu0/8R4QwS0fXsuVaeVRkZkj6KofUldR2Ako6z1ie3cuMeGtScOUQiWwOjIj/h85w6muAv5TZbj79LmIE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2249
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Greg KH,

I discussed with our silicon architect @Richard Petrie - M18281 and our ans=
wers are inline below.
Please let us know if you need any further information.

Thank You.

Regards,
Kumar

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Wednesday, February 9, 2022 5:01 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: linux-serial@vger.kernel.org; Sundararaman Hariharaputran - I21286
> <Sundararaman.H@microchip.com>; Ronnie Kunin - C21729
> <Ronnie.Kunin@microchip.com>; Tharunkumar Pasumarthi - I67821
> <Tharunkumar.Pasumarthi@microchip.com>; Annirudh D - I64147
> <Annirudh.D@microchip.com>; Pragash Mangalapandian - I21326
> <Pragash.Mangalapandian@microchip.com>
> Subject: Re: Reg: Serial port driver for microchip's new PCIe UART device
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Wed, Feb 09, 2022 at 10:38:34AM +0000,
> Kumaravel.Thiagarajan@microchip.com wrote:
> > Dear Greg KH,
> >
> > I am Kumaravel Thiagarajan from Microchip India.
> >
> > We are working on a PCIe based multi-instance UART device.
> > Based on the Linux community feedback few months back, we had written
> it as a custom driver inside drivers/tty/serial/8250.
> > Now this custom driver is requiring a DWORD FIFO access for both Tx and
> Rx, and I am in the process of changing my driver code.
>=20
> Why does the hardware not follow the normal standard here?
We are building a PCIe 8250 based UART.  We can absolutely support the norm=
al 8250 framework and standard drivers.=20
However, the challenges we see are the round-trip delays introduced by PCIe=
 reads and writes having an impact on throughput, particularly if you are d=
ownstream of a PCIe tree with multiple hops.
The sizes of the payloads are limited to 32-bit by the processor PIO, howev=
er, even going from 8-bit payloads to 32-bit payloads improves throughput d=
ramatically.

>=20
> And are you sure it will still not fit into the 8250 format?
As mentioned our hardware can support this, however, we see that it is less=
 efficient due to the requirement for single byte reads and writes.

>=20
> > Can I model my custom driver on serial drivers present in drivers/tty/s=
erial/
> directory?
>=20
> You could, but it would be much smaller and easier to use the 8250
> framework given that you probably do have an 8250-like device, right?
Adding DWORD reads/writes to the hardware is a necessary enhancement for im=
proved performance over PCIe.
But 8250 framework looks very closely tied with reading character by charac=
ter from the FIFO and I was not able to find a place in that framework wher=
e I could hook my own DWORD based Rx and Tx logic.
Is there any DWORD based UART FIFO driver example with 8250 framework avail=
able?

>=20
> > I am implementing my functions for uart_ops structure and the necessary
> ISR in a separate file mchp_pci1xxxx_uart.c inside the drivers/tty/serial=
/
> directory.
> >
> > I wish this custom UART driver to get through Linux community submissio=
n.
> > Do you see any risk in this approach? Do you have any suggestions?
>=20
> Let's see the code before we can give you any firm answers.
>=20
> good luck!
>=20
> greg k-h
