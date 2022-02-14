Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F336CC433F5
	for <linux-serial@archiver.kernel.org>; Mon, 14 Feb 2022 12:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244507AbiBNMvv (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 14 Feb 2022 07:51:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240784AbiBNMvu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 Feb 2022 07:51:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FED0282
        for <linux-serial@vger.kernel.org>; Mon, 14 Feb 2022 04:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1644843099; x=1676379099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vDvazN3u9xQw+ojeB6/ObwtcSPDlpvbzPfOHV5zczsE=;
  b=YFn4y5CcPhCnHJ/5ziKNT9TqKVftMWFb8JDXqWuzkDtilNtjSiYMldai
   yVKr/kHWwxTq5qZzWmcmYON3l8NK7xd7P0s/ahecvYI64rMDhP9kKeO28
   kEwhzr6B8ZQdnQD+/GpOUTnwEAQLYNCbf/3dfcSVaFs2HvBN7AS1JbRJv
   aQCchtlwQjLFywFzAcRWmgFoYSRviV4cBoWebuyz3sEr3GQmjxhud8OGj
   bWEMDhC6kZtwB4wsqNpr0PdSrod6TtqVKWyxaNOwiftOxatLcXMvSkKSH
   u+T2140dS0qqzWjIeaBZV5MDfNWPFXEel6mVJcrYe84g9BOi/h8TOvDMB
   g==;
IronPort-SDR: ExGJaBu9z4jiPzb9pZE+a0OBNsFdQCKWz4mE18mqsVvHZ+zLKggbKAs14pN4zsQGnWZ1I2E4NQ
 TEFXXtZoPLrOCiBEDFrPNNgKvhnH5vlSp9VT8AOHHbYed1YP4zMWzFNAJl9v5iCsRaFdcVdRZh
 yJv35uuP1V0yDtEJSFC+tuIN40Se0uRBeRHfgGCzFeZ/ImedGi+K6jsOkpElWvl+8NTeToTrlW
 VaL5PK/UfoHgp/w9Gn4DzVZWEa/5QwnSEGlCFMjOZrMXZnixUCCVQYJqCH73iCN05/h/izyHGc
 jrxdqGtHy2W962nopRMg0L2L
X-IronPort-AV: E=Sophos;i="5.88,367,1635231600"; 
   d="scan'208";a="145872937"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2022 05:51:39 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 14 Feb 2022 05:51:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 14 Feb 2022 05:51:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmK1+GABSee/TkTKYpYc5Og5Ux+XBtGJeBJevYSekyTKrtcSQwgpf3aHXXvsOk3GJorxLOozhHZip9LT/fA0FJmn3tmxUy+Wopmw1C3lFqL43hgDiYV1f3295ZjTjBanxCDKjQnfYvFPU/oEDEiwgaQXWyq/r8hU/Ubsxa9gWz+T+2rUPIZsvlFwHlNbdW7XuOlsJJCYQmxaB5w3f37/zb4bT/7UoHb5zyVAw6aPEiJakwyjovxhY849WWkgzBs/LlgusImILgaUyzaYMPdZ7tUaa8lBtVhC8mGf+bnYnJYh5R8yKyfLDp75oo7HVrcrxb0fe4jFwW/uesYKhHOnaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NYZlBJJQ0wf3M5DdCED+fOlqz/WJRoCp50Ih6RAjtIM=;
 b=JbwkwOKNxZjd96Txia4ozCDW6fpwx52LPieOmIp8V+UWkLmH7JOb11vgAxFvva4awvlglQWAlIO7PYC9Wbxtf+NVjAgPhtXfYGZw01UFl6khopxd5Zixtb/BIGUyM1VWq6Ul5h7Q3W/ry6ljSbd4rDY7HW9yF8yQWlwynZfRgd848vtd1VnJq94gAa16rBKAsrjxgWZYCmHEZkC5T7mG53TCmQs7SgvuZIRBCECsVjZy60Lxa5JqO88YzwHtUfR/gF+FyY0OihaIzXXm7iaQ4Qarg8aQwnoeTr27cVYdTfL7mlP4WmdIi+Duf/2bO1eAg+j1P1NU+i40WjT+iBy9LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NYZlBJJQ0wf3M5DdCED+fOlqz/WJRoCp50Ih6RAjtIM=;
 b=WSMG3ycxAPCWetCC+jDlyCfyQUWTnbBskJ+WoX4ejBqFjD//eKYEoiq5UjvekJ8B9gUFyStLZUb8VBvDgXdjP8YBicbsDn5cS9BAlwpww+9qn5PXDWgMI9z9xzHQmNXFBR90Uf64090IgpMvNIRtrRN5MyCBf/o8xrMnKFCujTE=
Received: from CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5)
 by MWHPR11MB0045.namprd11.prod.outlook.com (2603:10b6:301:61::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Mon, 14 Feb
 2022 12:51:32 +0000
Received: from CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b]) by CH0PR11MB5380.namprd11.prod.outlook.com
 ([fe80::81a1:6e6c:a1d:878b%8]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 12:51:32 +0000
From:   <Kumaravel.Thiagarajan@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <Richard.Petrie@microchip.com>, <linux-serial@vger.kernel.org>,
        <Sundararaman.H@microchip.com>, <Ronnie.Kunin@microchip.com>,
        <Tharunkumar.Pasumarthi@microchip.com>, <Annirudh.D@microchip.com>,
        <Pragash.Mangalapandian@microchip.com>,
        <Ian.Saturley@microchip.com>
Subject: RE: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Topic: Reg: Serial port driver for microchip's new PCIe UART device
Thread-Index: AdgdoSwgtfXI08/UQwiITF2vlWhSpwAB1B+AAC6iIhAANw1OgACVt/mA
Date:   Mon, 14 Feb 2022 12:51:32 +0000
Message-ID: <CH0PR11MB53808F1BA521EA922F0A18B8E9339@CH0PR11MB5380.namprd11.prod.outlook.com>
References: <CH0PR11MB538034CCE6C1868DB7BD8127E92E9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YgOl6SFsKnZxkbFy@kroah.com>
 <CH0PR11MB5380EE38DD9B8BF9EE5F1796E92F9@CH0PR11MB5380.namprd11.prod.outlook.com>
 <YgZQT9SFWQcXm9C7@kroah.com>
In-Reply-To: <YgZQT9SFWQcXm9C7@kroah.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04d06db4-6730-44e1-646b-08d9efb8ba25
x-ms-traffictypediagnostic: MWHPR11MB0045:EE_
x-microsoft-antispam-prvs: <MWHPR11MB00450EACEAB8B746AB38ED8FE9339@MWHPR11MB0045.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G0+QdW463MwlNTiBd88puyJongqJweVUZOsHCJvEAsCeF70ed25vvFHOS1m0RqdBeQVlW/jb+Wfto142RhfFoXgj0d7320fv4mCZHZQYLt2T9rMDdOP3BHywIv+yny7ya3tuuL1Oc7buJtOK7MvKGBVBnZ5fbWsA2EEiNT8YQYKhhjc5hhdaJu5EG48XsLDbTcRs1WX0eB3cVbP06rGUTLImTX1ZdJxrOhb5DTG+sAk0OpS02z2T6tRw3WdbIcGBdL2Hi0KjcDkwZ+kUVbO1SCP9vWfohqnMIq2sHMMnmqam/rLhWM58+F6ke/aCdYrjg2zo6Gq3NYYeoWQiiGLnFDIhNwBtlvXobdeaSKPezTGLBvHuhivEoAzH5c813jKWPmnewThffXZIn6+IMlP9iePydoGa8hlOuamYN7eUBbirbFdrcRqsbZ+2Od4NILQlgseUj+xRsiEvF5j6EUEI8ol1BOe4MBQSIOVWaGrcepooKPH4qbU2BP5lxkLR2yxhdIXL3DRfyYeRGRmNPFSsulnd6WNp/ec0rc11p7fa4AteqwJmdgvbxwDzX2yePXVjn1Y4DHVer051D4OrDWNADbgtOJsLTYLbOqIWBhr5LucDnQlSrPh0XrFwbNThHkn5uNL8s9ymgbJWTq5gtS6gmMYj5cQKPqBto3Un09L1sNzRXiqhlz1GUbDudHqV3jWTenBiDz9vjI3GBnYb+w17fw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5380.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(107886003)(6506007)(76116006)(86362001)(33656002)(186003)(26005)(9686003)(316002)(71200400001)(2906002)(7696005)(55016003)(508600001)(38100700002)(66476007)(66946007)(5660300002)(83380400001)(4326008)(54906003)(8936002)(66556008)(6916009)(8676002)(122000001)(53546011)(64756008)(66446008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r9v6fZ6ArC36t6nzN9/0MZtq+9ilbUkqwn3OSPqaVCtxJ3h5UZm8IMAIOzv/?=
 =?us-ascii?Q?W1pl04h181OXfIfH7qZ96ht0yX93SKeFwdNdHA2oWbOwuJgjZnPO54K3Rskq?=
 =?us-ascii?Q?zr1Hfecg784V+nL9J6WqpSBcoBcBQ+ovLYw+cI4PbOf2SU5Yb3ddggrYjh04?=
 =?us-ascii?Q?8HaqwCTck63AWzPxYQQNSM69zfnEwiWxg80CCLcHo60XtCiaOXA+wo22ZybM?=
 =?us-ascii?Q?lqaV4V74i8vs+geqFT4inF8fwA9jIZCZXgJvq05ot3rE0/tciqfkgxf6wmLH?=
 =?us-ascii?Q?FvcF4kE1kk05rQidZFmDGFC/F8TDV3KkkrlsKmmw3atXaBACJ6f6+7O/GBGt?=
 =?us-ascii?Q?F6UVjD3wEkX+2yU3TXUBH4UnwxSp7Wgl1dFiZHcrJgHx2yUwO7qZTDmbtEd8?=
 =?us-ascii?Q?DaXOdNK5ITkFJiKVcuOl76nMqMGM1Fqq/8f/oEeWaG81GUTqld5e40I49EA4?=
 =?us-ascii?Q?+BgsbjdJMa4llF2XdsWf8uVq27ENI9MLMSTzCLlXoT+fR4AjeRWwWyzOUqqW?=
 =?us-ascii?Q?x/fpHjcJqsBPhbQ+padwjb6EJSXsWYRnH9EwEcBhp52s4hV4QR+jRF81dQjP?=
 =?us-ascii?Q?aroDMiOmxndNlWpo0IPqydHL0QUWJMyM/s8VC0ctOTR5KhSFMeeOarowb/IS?=
 =?us-ascii?Q?wgzPfLJSo/jManqJw1L7mL3tByuA9WRpcvpUMnI7KifQWz4lYQCeDGRjiX0O?=
 =?us-ascii?Q?pPP5RDty8f/JmlAEs1yPSFREFYH8A0kMqj9QvgMAtgRH5OvYnhPDTV0bRtjZ?=
 =?us-ascii?Q?l7L+CPIan5pmnuR8oEzxwp34qGA6vIEdrEnt8LStPCUwpmbgiOvOxcQbMekA?=
 =?us-ascii?Q?Z6IcsxbjsJ//HtoIWwG5UMAgycw9LCm0HoNTAzmbqGbBLaE9PaJwyr8IrOAL?=
 =?us-ascii?Q?gWeMK2YO6OFqWc486LcCATcir0rRLd7+3MpvXPlrUDi5RzT8bk7zyrhcVuJB?=
 =?us-ascii?Q?H57oh9rkc9sZ5HBzC+Sp5lQiT+7drt9cZWyoLpITdYSCeUqUv3hU4dLoInXM?=
 =?us-ascii?Q?IAZWLt1dpO1iDAPuq7au6LfGgSAy9enFk2OlTQv7Gi0H9qFm/5A6gNuYKv9H?=
 =?us-ascii?Q?TQ8Xr69Sh2Wlxg098SxB+Hu0ms649Sm5wDguA+RAHWPepZD7+mgJBtyutOeY?=
 =?us-ascii?Q?XYAIP2CrGM6rob3wX3L4tCI693/DhXwN6KTRSbMkZOcFU8YgDK1siDm82AAn?=
 =?us-ascii?Q?NEpNEWM+CXm1mBRqiWgctC4jBEsrlsqTJus3AzLlXkWWfXup6jR0SbrTypGr?=
 =?us-ascii?Q?322EzVJ/AaJgXMrhz6WFsPJK979f+Nz0PRA+dLK2d4e1/l78RKqVhsRNGDDf?=
 =?us-ascii?Q?Wx3w6xHDnikHzcH9SafxR0bNwATmkeQ0MGn0llkg2KXHQIEv9yal2CJ7LTDf?=
 =?us-ascii?Q?4fEB8tFkmaJJoXMKvRAUeVBw0TGNsGqdxDCHcdaizCO0kA2T5aNo0lksvYZ3?=
 =?us-ascii?Q?WbGkGLsuqOnaAuLCbZMmK2vCgEEkte1kdgOKwVXRUAh21n5HH5sQT3sfFw87?=
 =?us-ascii?Q?f/oawFZltcZffsZxEhEibQqAVpaOdpjCUHK/5BxNIAlzw0YQDeSedE4JSr0O?=
 =?us-ascii?Q?sbO0WgLC/iAafha3C3IQQ+gxGtI8tQfey6T40PWWX/ueAZnmvUqDkwSTA65S?=
 =?us-ascii?Q?fPb1BG0Rzr7enKVsnR9s17Gh8ggKd2befBZGnZjzu7YCvN4MmL2i0EMp+y31?=
 =?us-ascii?Q?VVPDtdhv5TXz9I+izW1Y3rYRtCC3+qCxEoucaq2YuRR9DhrIYDd4lHC0vQSy?=
 =?us-ascii?Q?f+6SSs83bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5380.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04d06db4-6730-44e1-646b-08d9efb8ba25
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2022 12:51:32.4419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s/gMp2LSFuClnU24z6ePcKmpMtaUYEPg71ZAGeCycbVKFGBSRP/0IKiGDp72acDNaIsWxJ1OqSjgz0hSLlXvwIVd3ETnsrN37bzr2kTTuUfKrn+Z7VBjSSrryj3oEBf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0045
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Dear Greg KH,

Please find my answers inline below.
Also, I am looking at the 8250 framework again whether I can drive the DWOR=
D FIFOs by providing my own implementation for the handle_irq function poin=
ter in uart_port structure which I am not sure at this point.
If I can do this, this will allow my driver to fit within the 8250 framewor=
k itself and simplify the entire work as mentioned by you previously.

Thank You.

Regards,
Kumar

> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Friday, February 11, 2022 5:32 PM
> To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> Cc: Richard Petrie - M18281 <Richard.Petrie@microchip.com>; linux-
> serial@vger.kernel.org; Sundararaman Hariharaputran - I21286
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
> On Thu, Feb 10, 2022 at 10:38:39AM +0000,
> Kumaravel.Thiagarajan@microchip.com wrote:
> > > > We are working on a PCIe based multi-instance UART device.
> > > > Based on the Linux community feedback few months back, we had
> > > > written
> > > it as a custom driver inside drivers/tty/serial/8250.
> > > > Now this custom driver is requiring a DWORD FIFO access for both
> > > > Tx and
> > > Rx, and I am in the process of changing my driver code.
> > >
> > > Why does the hardware not follow the normal standard here?
> > We are building a PCIe 8250 based UART.  We can absolutely support the
> normal 8250 framework and standard drivers.
> > However, the challenges we see are the round-trip delays introduced by
> PCIe reads and writes having an impact on throughput, particularly if you=
 are
> downstream of a PCIe tree with multiple hops.
> > The sizes of the payloads are limited to 32-bit by the processor PIO,
> however, even going from 8-bit payloads to 32-bit payloads improves
> throughput dramatically.
>=20
> What specific reads are you having problems with?
Function serial8250_read_char reads character by character from the Rx FIFO=
 (byte FIFO) based on the data ready bit in the LSR register.
Instead of byte FIFO, I am trying to use the DWORD interface, and a live by=
te count register available in our UART IP to increase the performance.
>=20
> Why not just use DMA like other PCIe serial port cards do, which we have
> supported for decades now.
Our legacy hardware IP does not support DMA.
>=20
> > > And are you sure it will still not fit into the 8250 format?
> > As mentioned our hardware can support this, however, we see that it is
> less efficient due to the requirement for single byte reads and writes.
>=20
> Again, which reads/writes are taking a long time?  And again, why not use
> DMA for the data instead?
Our legacy hardware IP does not support DMA.
>=20
> > > > Can I model my custom driver on serial drivers present in
> > > > drivers/tty/serial/
> > > directory?
> > >
> > > You could, but it would be much smaller and easier to use the 8250
> > > framework given that you probably do have an 8250-like device, right?
> > Adding DWORD reads/writes to the hardware is a necessary enhancement
> for improved performance over PCIe.
> > But 8250 framework looks very closely tied with reading character by
> character from the FIFO and I was not able to find a place in that framew=
ork
> where I could hook my own DWORD based Rx and Tx logic.
> > Is there any DWORD based UART FIFO driver example with 8250 framework
> available?
>=20
> All of the code is there for you to read :)
Yes. I found two drivers inside 8250 framework supplying their own implemen=
tation for handle_irq which I will try to imitate.
>=20
> thanks,
>=20
> greg k-h
