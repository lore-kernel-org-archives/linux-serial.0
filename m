Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D2CC4338F
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38A4060EB0
	for <linux-serial@archiver.kernel.org>; Thu, 22 Jul 2021 21:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbhGVUYl (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:24:41 -0400
Received: from mail-sn1anam02on2044.outbound.protection.outlook.com ([40.107.96.44]:35265
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230455AbhGVUYl (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Jul 2021 16:24:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bwa9pgjFNwbzBz70wfenYRaFZVfcHkQ39XKoC6GvO8Fk4/01MtHK2HiENfsQWSNR3ujTSz/1wStosjNf47mmaBtJrB5XbH/3kGDOj0Jg9WompYZO78W4VC3QsJ+f4SZ8kJbMD/jxAamTBa1mSzAXQrUPgktBl10cMmLy8ubDBGkptvovPyyBv/cOA3B3xGFr7BeSEakkowdsEtkDGrD0r2xN5ni1HU/5OuM066qf5mrYbXn5ODQ2PXJJQkcT4ySrWZREzicbdQD1QFLOGQEkXhq4Rjawsynv3YorQ/y+nwdxWhZxsnOpKeXXj+X4rzMG50o0oNVq3ATUjBaUu5+haw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc4I56GjseyYmc0BQMaadb1Nw2lCOitHITq99siZWfw=;
 b=dJN0H90Iwa+4JfTkgh8IaBGrBwGj/jxh1bYel3zmUrbr1SvmGdsYKcJVwKtVBpr7adLqbu5ToebYMFeotqHMsoTE5k7TRT7wyhueve4KLsBNEBE7R4/e2idB9NgA51nmklD+At8EeOL896CL/5KeyZtvmiQ1Rg6gs9zIguBB5GbodOlf7JXRxIq6coR8J5ZMz8AWU/NLm8CyLi15LfyQ0G1bxqFFoPxp/cowOUlk8ROId2C/ljxTMHaNlLDiAmzA1OTfE8RkE/Od0WZSbsYC12+K+77m2emafS9r71czv7bDOGbsh0vbpbj5KORhX3gtBvBdCE+VjLkQeDRrnsckhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whoi.edu; dmarc=pass action=none header.from=whoi.edu;
 dkim=pass header.d=whoi.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whoi.onmicrosoft.com;
 s=selector2-whoi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc4I56GjseyYmc0BQMaadb1Nw2lCOitHITq99siZWfw=;
 b=hpV3tSAlJHWx/jjX8yvT3hiqEoTLh1buGyNgyQdZep1I9cO7hUNaHl63+MVqYMihWkDWyv/nW76/hOILMxG5RIyfCwO7P4+4qdmftip2sJGe/z9TSPLUMc2kSVG6gFgBjOWRJAdF+iYta2u17GgmXzx6el6m4JAqi8AKrW2hTZE=
Received: from BLAPR16MB3891.namprd16.prod.outlook.com (2603:10b6:208:275::16)
 by BL0PR16MB2611.namprd16.prod.outlook.com (2603:10b6:208:72::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.30; Thu, 22 Jul
 2021 21:05:13 +0000
Received: from BLAPR16MB3891.namprd16.prod.outlook.com
 ([fe80::2428:abb8:fc63:b2d9]) by BLAPR16MB3891.namprd16.prod.outlook.com
 ([fe80::2428:abb8:fc63:b2d9%5]) with mapi id 15.20.4352.026; Thu, 22 Jul 2021
 21:05:13 +0000
From:   Dennis Giaya <dgiaya@whoi.edu>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: max310x: Use clock-names property matching
 to recognize XTAL
Thread-Topic: [PATCH v1 1/1] serial: max310x: Use clock-names property
 matching to recognize XTAL
Thread-Index: AQHXfwqRtGB4G29600yTmAOeOlhK06tPIykAgABZRwA=
Date:   Thu, 22 Jul 2021 21:05:13 +0000
Message-ID: <0acef8aa86d69cac0ea1a3dbdafc41625580e0eb.camel@whoi.edu>
References: <20210722150233.30897-1-andriy.shevchenko@linux.intel.com>
         <YPmSpNZr/yQiPqsO@smile.fi.intel.com>
In-Reply-To: <YPmSpNZr/yQiPqsO@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=whoi.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea8b3519-b9ea-428f-66dc-08d94d5465fd
x-ms-traffictypediagnostic: BL0PR16MB2611:
x-microsoft-antispam-prvs: <BL0PR16MB26116A7D2F572641B8C69660AAE49@BL0PR16MB2611.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gygtD9AABuaRtzlL2ljLYjDB/nFJnMzEC+i/yYW1BAJmhCXsMrz3yCUj7qZjybpBVCHXdnoMeM0uqEbC/SF5Vw+kr7oSZ/C2s8F5Hl0lhVOTEY4B9mOfxwB+UvEqNzMR0gxqwx1BPSnzacVLhWhXh6HlgmEuAg8KStU7ynxvG1XX8WF8i/K2mTHwXcr4BqcGUK3FPks//0eZYpdVeyufrCZXfe2KsBkf/4pXZX7ybMbGzX++OYlPVQtjCZeBfZzT5liP2TLxIuwwAa1PUQgdWGsA9Z+h3OeWpRgyTAcT3iA0K+KYFSPMKRY/GxEiTueOkvzgn0ZeUmIv0KHLpgSau51mm8KJrSiUQ/oMww6XbpjeOmyFfr4uH0wjXSHX6nfY2Bz2eWio1yGb6eqkTRM2NF9ctP+GUryZPR8HLlQtSs9QizpEe/+EgH1hz3NFSfCdRTt4zUFoWUNFe5WERw6kbskTU1CMZGW7uEYi70xVvIaYxUsZr/rZivSlZ5ou4RoTI5byDyF/xeSfRemUq3rkkzj4FBqu4EKafAXDzyXBWR1u+F8vDLBmP3mtIdf28sOL7qIYuPjH/CqUzWzizc07FQVpTNJ/DU45NqIsUioFxlW9Mkd4/XqwxwbsjUnk3WdB9Et/92cfhUoAXWdvJzX22fDsnKquJsIn7OXMNiHQx5m/rRL1RK7rfAY8fee8O7eGka51Ntp/8N+dt7yhAENv7Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR16MB3891.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(366004)(396003)(376002)(36756003)(83380400001)(26005)(122000001)(786003)(99936003)(186003)(2906002)(110136005)(2616005)(316002)(4326008)(86362001)(75432002)(8676002)(71200400001)(6506007)(6512007)(5660300002)(66446008)(64756008)(38100700002)(6486002)(66476007)(66616009)(76116006)(66946007)(66556008)(8936002)(478600001)(38070700004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cVlraExTWWRXNFRXR29tKzVEaC9aMjBaWWVzckNQdGMyQWx0dlVlNWRsSFAw?=
 =?utf-8?B?aEw4YWVnbUt2NFhBcnBmVXhPa2NpSC91Zm84T29TVGtNRmVINHY4V1ZOWHJD?=
 =?utf-8?B?UjNlTUpIRzZpWTcxZTVoKzdTOWJQdm1aSU0wWTVzdmpENDFYdGlYd2l6Tmxl?=
 =?utf-8?B?OUlja1JnUk5OVUV0RzE2Yi9YSnZmbXordCtwWmFqUXphRHRWUTVjQUJUS21V?=
 =?utf-8?B?NnhLWGtxRXU3OVlPUjhjR2xOeUxnNkhRbDRPWXQvdEtkTEp5cTNRcE5LRE00?=
 =?utf-8?B?WkdHdW0raXNCVDJYNHpOUnN2eUlIY0JhUVB1dXFKanBKUW5PMFNhVFp6VVlF?=
 =?utf-8?B?cDBZOUp5bW5sU2RUaTF3dERyei85Q2ZGMm91eU5HRnZ1QlRweHBRd3VJTjlW?=
 =?utf-8?B?WWNteFh6YnhLQUNiUEYxV3lqUk9ob0Vhb1NxaDNOSC9uRWpwUzlvMkVCbVFE?=
 =?utf-8?B?Zzg4bmFtZDBrUHZadVdqUVQxT0J6NWFVK1BpYStsL0tWeVVBNWxnbVlLTTQw?=
 =?utf-8?B?Q2FtNzArblBVQ3c4WHk5a2JKQ1pBUHRmaEtkeSt5Y1U5U1ZZUFR4M201UVpC?=
 =?utf-8?B?VUtib1laUzJaRkVHaDRrTDFmMXNrSmVkUGxMNnlnKzNwT3NUYUJWcFBZdDE4?=
 =?utf-8?B?QlN1QjBCN0xOREsxYWVtaER3SUdGTk9DcWozeWlzTTlDUGp6UWg0NjBlRmtQ?=
 =?utf-8?B?c2FHYldENlpjeGdDb1lScmYwWUJERmU5UXFrWkpxZ1VEdHF6T1M3WEZGcG1p?=
 =?utf-8?B?VmVZME9vMDlwOGRPQzc2VERJQnlOQkw4LzllZkgvZDBhc1lIY0pmQW1xZ1p2?=
 =?utf-8?B?UEtvZVh6QWxqWXdUaVlnMnNuMk9ML0xuRll3aDVnOWZIZitvRHd2R0Vub2hE?=
 =?utf-8?B?R01PSFhFa1UyVzlzTlZVLzVrZDViK0hUWEZJVUNIcWZWRW5qdkJlakFuTy9C?=
 =?utf-8?B?QWw0T08yU2ZwRVk3aGxPMDYyWmRESXRzdDlZdlIzc1gvVlQrYzd4TE1Ddm4w?=
 =?utf-8?B?U0hJaWFVcmFOOWNGeFZ6NzNkWmV6Y3ZEejJqV3h3N2UydkMrL1NMemdIY0ds?=
 =?utf-8?B?by9hUnd1eFcvSDRLNCt1Rit3SGs3cDlPRVBLWDB6VGhQOVp4Yi9Celp6czZN?=
 =?utf-8?B?a2EyUDVZRVdBM2NvNFNMV1ZGRTZVdmVYNTBmV2plb2FJL2U2SmcwejZyQU11?=
 =?utf-8?B?UGVTM2JzSGs2dUh6UlRsdHVMQjZIZlNiUFVOcnVLeUs2cU5kQTlUVWRwTURZ?=
 =?utf-8?B?VDBRTHlRL2hTWjVFbXVxZklFbVg0WjFwWmFBU3lHSDdSTmhkUEQrNitFTmVE?=
 =?utf-8?B?YXhZcDdBOGh0UmY3cWRVTkUrc1FnSllsUlBzakNlK1BxWFA2R0NuTXpaZWdT?=
 =?utf-8?B?c1kvZW00U2RBNTJWdlorb2hNZ01EU3Q4amxLeGUyMHVNcmFoQWFCSlNJZ2FG?=
 =?utf-8?B?aE5RRlAwWUpWRWF2TiszS2JDT09EUHZaUmhNVEx0NGJ3SWtsb2Fzd3VERkUz?=
 =?utf-8?B?OU9QVk9xZExadExiTGxOdzBaSWVON2xwVmNicm13WHl6c1laamo4N3cyZGJT?=
 =?utf-8?B?U00rN0RqZ3B0ZDFQOGMzRDZlMXFvSWVVeTYzZEw5cURNcHBIM2hNVmd6VGl3?=
 =?utf-8?B?SU5PenRRUm5zbkZMVXB2aHlRd0FoN01PM1h1ZnZqM3FJck9SSFkybm01V1ZR?=
 =?utf-8?B?aTJ3LzBlSjZRWmtpZlQ2REF4cDBScGlsVVFuei9LdkdEdGUwWU55OXRlaith?=
 =?utf-8?Q?H7rsWuL+1ajkvKHooIPMRATMZT1tFwpyq0qmIGm?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-9x8NAwI62G+es/5QNXGS"
MIME-Version: 1.0
X-OriginatorOrg: whoi.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR16MB3891.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8b3519-b9ea-428f-66dc-08d94d5465fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2021 21:05:13.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d44c5cc6-d18c-46cc-8abd-4fdf5b6e5944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bvBXQxkL5U3VcTd9WfPKnCvj67N5tG2lq4hccExUFziCoN9GQgenSC8aeslCcrhO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR16MB2611
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=-9x8NAwI62G+es/5QNXGS
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Andy,

I've tested this out on my hardware that uses an external oscillator
'osc' (as opposed to external crystal 'xtal').

With the relevant asl
	Package () {"compatible", "maxim,max14830"},
	Package ()
{"clock-frequency", 19200000},
	Package () {"clock-names", "osc"},

Previously, the driver logic would default to 'xtal' and then compare
against the narrower frequency range and throw an error because 19.2MHz
was not allowed. With your patch, it proceeds as 'osc' and appears to
work as intended.

Thanks!
Dennis


On Thu, 2021-07-22 at 18:45 +0300, Andy Shevchenko wrote:
> On Thu, Jul 22, 2021 at 06:02:33PM +0300, Andy Shevchenko wrote:
> > Dennis reported that on ACPI-based systems the clock frequency
> > isn't enough to configure device properly. We have to respect
> > the clock source as well. To achieve this match the clock-names
> > property against "xtal" to recognize crystal connection.
>=20
> Dennis, please test this.
>=20
> ...
>=20
> > -	s->clk =3D devm_clk_get_optional(dev, "osc");
> > +	xtal =3D device_property_match_string(dev, "clock-names", "xtal")
> > >=3D 0;
>=20
> Meanwhile I will change this (not affects the testing in your case)
> to actually
> negative one as:
>=20
> 	..., "osc") < 0;
>=20
> to be compatible with the original flow (in case there are two clock
> names, the
> "osc" has a priority).
>=20
>=20

--=-9x8NAwI62G+es/5QNXGS
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEhkw
ggYDMIID66ADAgECAhA/vTTyulL8DtMKV6OB4b5kMA0GCSqGSIb3DQEBDQUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xNDA5MTkwMDAwMDBaFw0yNDA5MTgyMzU5NTlaMIGJMQswCQYDVQQG
EwJVUzELMAkGA1UECBMCTUkxEjAQBgNVBAcTCUFubiBBcmJvcjESMBAGA1UEChMJSW50ZXJuZXQy
MREwDwYDVQQLEwhJbkNvbW1vbjEyMDAGA1UEAxMpSW5Db21tb24gUlNBIFN0YW5kYXJkIEFzc3Vy
YW5jZSBDbGllbnQgQ0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCA/spbd3fGH+yC
++dZilWtwOqesQfoJis2CaLxL0w6WUCcq5zyQClAJZJyKXiPmwZqEHy3ZAf/GPxQ26gYIMbnERnG
AWhHP9mS7N00krhknxv10ibZc9RMpuAjCW4+nfz6gtXk/qSlRnkAZeU9bui2Tn6L4ev0Zqp10duH
buEVqh2L8kychl76E+UMaeyF1mD4qG2IcwOVp8J70vGSjvt6Y6mRqGa6tf2zLdJ//MuDm4uJNL1X
XQp1l2aAlbyX0boaGMFsuH3rRox1aP2wmvi+s+1ZPzK3cQZAVXdypS83SQGAK6uL3uzZTYq9Xl+u
DzMFlb80JdFirDXxloOLw9unAgMBAAGjggFkMIIBYDAfBgNVHSMEGDAWgBRTeb9aqitKz1SA4dib
wJ3ysgNmyzAdBgNVHQ4EFgQUfe5x0B/rqWFtj2aErQ8rB+Ix27wwDgYDVR0PAQH/BAQDAgGGMBIG
A1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBEGA1UdIAQK
MAgwBgYEVR0gADBQBgNVHR8ESTBHMEWgQ6BBhj9odHRwOi8vY3JsLnVzZXJ0cnVzdC5jb20vVVNF
UlRydXN0UlNBQ2VydGlmaWNhdGlvbkF1dGhvcml0eS5jcmwwdgYIKwYBBQUHAQEEajBoMD8GCCsG
AQUFBzAChjNodHRwOi8vY3J0LnVzZXJ0cnVzdC5jb20vVVNFUlRydXN0UlNBQWRkVHJ1c3RDQS5j
cnQwJQYIKwYBBQUHMAGGGWh0dHA6Ly9vY3NwLnVzZXJ0cnVzdC5jb20wDQYJKoZIhvcNAQENBQAD
ggIBAHbTp8SSteS9tZZdrZm31UrUmf+ORN9FUk5De4p9aTzTPIymIel90YVktrIFuOf9OZmEq4Jr
xXvclK1U8Gaj6YYyz3EZsalCwRYtbSY+SsqOUmMF9Qt9cnyDIqyddHkJ8INCWIoyDFjeMT0cbJdU
03IJaMrujWxAC1QwBW9vNWQ+8ctpfAJ7c+VUmu49r+m7e+y0glBCSuAu2JunokrpVwIN85Njf5OI
dheROK8tywt39BTzk21h8t2ELUjwGAyfRHxkyWaJ3miqaOlAFipEyzGciKpqT9jSnKtvNBiIxirf
3tSmEGpXl+FOkaQJDk1hscYgd9DUkV5yA5i3IQlRQ2QgVVHzyR/fCflMMF/csyMN5zgpo1elm/hU
gpgVZ0Bu4MC14+hrgO4bJ8zLaiz91sPGe3csqhdxLlKo+kO7rVubrX3KLcmaYcqU/uT/qYRQoBDF
ta4Y4US4ygMZLOerFhlXMOVYbvXYlk/iBjPqItRUELJMjZgbo6hfHFDDgEvGYymjswKMyIfdckvU
7oTlWnEmiUreuLg1pUHu4fhgpo183v31vIXlyaNLab/wSnZmo4m5g4lpXdmxn6LZgiD5kevZsy7H
lXD2n5LsSJC7rBkTLgoyRc1gqo1m7CMW5JdRxT6zdN3UuDeIYdmO11ugli15TnkEfWZZ9KeQ3grj
kh5zMIIGBTCCBO2gAwIBAgIQUbIrNHACzMQSzMFfwsrggjANBgkqhkiG9w0BAQsFADCBiTELMAkG
A1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoTCUludGVy
bmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFuZGFyZCBB
c3N1cmFuY2UgQ2xpZW50IENBMB4XDTE2MDkxOTAwMDAwMFoXDTIxMDkxOTIzNTk1OVowggEAMQ4w
DAYDVQQREwUwMjU0MzENMAsGA1UECxMEV0hPSTEtMCsGA1UEChMkV29vZHMgSG9sZSBPY2Vhbm9n
cmFwaGljIEluc3RpdHV0aW9uMRswGQYDVQQJExIyNjYgV29vZHMgSG9sZSBSZC4xLTArBgNVBAkT
JFdvb2RzIEhvbGUgT2NlYW5vZ3JhcGhpYyBJbnN0aXR1dGlvbjELMAkGA1UECBMCTUExEzARBgNV
BAcTCldvb2RzIEhvbGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQDEwxEZW5uaXMgR2lheWExHjAcBgkq
hkiG9w0BCQEWD2RnaWF5YUB3aG9pLmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AIrqeYF42Ft7MOV3Jf9MHJNQVzHBmUHAF6w4i0Mi4qQbch6GzFvMZgP3ei9sIAABiTr/HdkKNZnJ
iyb9DGr4jCZc/i5wmv0DbK+5JNa0xjkDTfqyrtjrgJ219IJLofgBVkc7LjLp92oDE9hoHzIQ2PN1
hMtN4aFiC74rTbTDq7bFYNy39fD+6pP61f9c8wG5fkPn1zJp/LL3+2i6voR9bWrbNLYStkRQ4ll+
Re3KrNLrkuFYODWHqRvsOBmjTwMVDPPNxG4VlSJN5K/hYCG4uUup0mw8n4YaY+CbqK87MXVtBpHn
WUg6K8aAnkb6BU8DNtRW2FDytwJ1dmGvRiJX5FECAwEAAaOCAe0wggHpMB8GA1UdIwQYMBaAFH3u
cdAf66lhbY9mhK0PKwfiMdu8MB0GA1UdDgQWBBREcIKLbkaQF26pdlnj4SsJSppIQjAOBgNVHQ8B
Af8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUHAwQwagYD
VR0gBGMwYTBfBg0rBgEEAa4jAQQDAwABME4wTAYIKwYBBQUHAgEWQGh0dHBzOi8vd3d3LmluY29t
bW9uLm9yZy9jZXJ0L3JlcG9zaXRvcnkvY3BzX3N0YW5kYXJkX2NsaWVudC5wZGYwVQYDVR0fBE4w
TDBKoEigRoZEaHR0cDovL2NybC5pbmNvbW1vbi1yc2Eub3JnL0luQ29tbW9uUlNBU3RhbmRhcmRB
c3N1cmFuY2VDbGllbnRDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBQBggrBgEFBQcwAoZEaHR0cDov
L2NydC5pbmNvbW1vbi1yc2Eub3JnL0luQ29tbW9uUlNBU3RhbmRhcmRBc3N1cmFuY2VDbGllbnRD
QS5jcnQwKAYIKwYBBQUHMAGGHGh0dHA6Ly9vY3NwLmluY29tbW9uLXJzYS5vcmcwGgYDVR0RBBMw
EYEPZGdpYXlhQHdob2kuZWR1MA0GCSqGSIb3DQEBCwUAA4IBAQA9MrEwcslZHYmZArzKPRCIbrm5
57FNWZQ02vqXbFA+SDEhYoM2edc5SiX6WM4TerTajS/5Cv4gJrKnGzCYCRee9dMvPHOYZ5xbAL94
7c0ucpO4hbrhwe0w+2hFCboEbgT9FvnXHA1suy9+K236ba8ZL/1XxcAQgiY3E0p2Kq9pkVBAZKhP
D3QavnQvUso/DT9m5Z3WmIOFvZuW7kZ+IdCSGxBBx2KRTb1mNSyRkNHa92yaPgF+KZILT/hdDdkO
Gp3mBUt0ZA7o/orgO5MMDxJnyoTdYLZl5reMuuHXZ/udusj3JKklEKvRCFXYXEhudTCNaTaBv2fz
LfCTEEGDvxcOMIIGBTCCBO2gAwIBAgIQUbIrNHACzMQSzMFfwsrggjANBgkqhkiG9w0BAQsFADCB
iTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoT
CUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFu
ZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBMB4XDTE2MDkxOTAwMDAwMFoXDTIxMDkxOTIzNTk1OVow
ggEAMQ4wDAYDVQQREwUwMjU0MzENMAsGA1UECxMEV0hPSTEtMCsGA1UEChMkV29vZHMgSG9sZSBP
Y2Vhbm9ncmFwaGljIEluc3RpdHV0aW9uMRswGQYDVQQJExIyNjYgV29vZHMgSG9sZSBSZC4xLTAr
BgNVBAkTJFdvb2RzIEhvbGUgT2NlYW5vZ3JhcGhpYyBJbnN0aXR1dGlvbjELMAkGA1UECBMCTUEx
EzARBgNVBAcTCldvb2RzIEhvbGUxCzAJBgNVBAYTAlVTMRUwEwYDVQQDEwxEZW5uaXMgR2lheWEx
HjAcBgkqhkiG9w0BCQEWD2RnaWF5YUB3aG9pLmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAIrqeYF42Ft7MOV3Jf9MHJNQVzHBmUHAF6w4i0Mi4qQbch6GzFvMZgP3ei9sIAABiTr/
HdkKNZnJiyb9DGr4jCZc/i5wmv0DbK+5JNa0xjkDTfqyrtjrgJ219IJLofgBVkc7LjLp92oDE9ho
HzIQ2PN1hMtN4aFiC74rTbTDq7bFYNy39fD+6pP61f9c8wG5fkPn1zJp/LL3+2i6voR9bWrbNLYS
tkRQ4ll+Re3KrNLrkuFYODWHqRvsOBmjTwMVDPPNxG4VlSJN5K/hYCG4uUup0mw8n4YaY+CbqK87
MXVtBpHnWUg6K8aAnkb6BU8DNtRW2FDytwJ1dmGvRiJX5FECAwEAAaOCAe0wggHpMB8GA1UdIwQY
MBaAFH3ucdAf66lhbY9mhK0PKwfiMdu8MB0GA1UdDgQWBBREcIKLbkaQF26pdlnj4SsJSppIQjAO
BgNVHQ8BAf8EBAMCBaAwDAYDVR0TAQH/BAIwADAdBgNVHSUEFjAUBggrBgEFBQcDAgYIKwYBBQUH
AwQwagYDVR0gBGMwYTBfBg0rBgEEAa4jAQQDAwABME4wTAYIKwYBBQUHAgEWQGh0dHBzOi8vd3d3
LmluY29tbW9uLm9yZy9jZXJ0L3JlcG9zaXRvcnkvY3BzX3N0YW5kYXJkX2NsaWVudC5wZGYwVQYD
VR0fBE4wTDBKoEigRoZEaHR0cDovL2NybC5pbmNvbW1vbi1yc2Eub3JnL0luQ29tbW9uUlNBU3Rh
bmRhcmRBc3N1cmFuY2VDbGllbnRDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBQBggrBgEFBQcwAoZE
aHR0cDovL2NydC5pbmNvbW1vbi1yc2Eub3JnL0luQ29tbW9uUlNBU3RhbmRhcmRBc3N1cmFuY2VD
bGllbnRDQS5jcnQwKAYIKwYBBQUHMAGGHGh0dHA6Ly9vY3NwLmluY29tbW9uLXJzYS5vcmcwGgYD
VR0RBBMwEYEPZGdpYXlhQHdob2kuZWR1MA0GCSqGSIb3DQEBCwUAA4IBAQA9MrEwcslZHYmZArzK
PRCIbrm557FNWZQ02vqXbFA+SDEhYoM2edc5SiX6WM4TerTajS/5Cv4gJrKnGzCYCRee9dMvPHOY
Z5xbAL947c0ucpO4hbrhwe0w+2hFCboEbgT9FvnXHA1suy9+K236ba8ZL/1XxcAQgiY3E0p2Kq9p
kVBAZKhPD3QavnQvUso/DT9m5Z3WmIOFvZuW7kZ+IdCSGxBBx2KRTb1mNSyRkNHa92yaPgF+KZIL
T/hdDdkOGp3mBUt0ZA7o/orgO5MMDxJnyoTdYLZl5reMuuHXZ/udusj3JKklEKvRCFXYXEhudTCN
aTaBv2fzLfCTEEGDvxcOMYIDnTCCA5kCAQEwgZ4wgYkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJN
STESMBAGA1UEBxMJQW5uIEFyYm9yMRIwEAYDVQQKEwlJbnRlcm5ldDIxETAPBgNVBAsTCEluQ29t
bW9uMTIwMAYDVQQDEylJbkNvbW1vbiBSU0EgU3RhbmRhcmQgQXNzdXJhbmNlIENsaWVudCBDQQIQ
UbIrNHACzMQSzMFfwsrggjANBglghkgBZQMEAgEFAKCCAc8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwNzIyMjEwNTEyWjAvBgkqhkiG9w0BCQQxIgQgiX1cHzDt
eAe2UhghsMpsjMsdt+phU2r6eAIJpznJZTwwga8GCSsGAQQBgjcQBDGBoTCBnjCBiTELMAkGA1UE
BhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoTCUludGVybmV0
MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFuZGFyZCBBc3N1
cmFuY2UgQ2xpZW50IENBAhBRsis0cALMxBLMwV/CyuCCMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCB
iTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoT
CUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFu
ZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhBRsis0cALMxBLMwV/CyuCCMA0GCSqGSIb3DQEBAQUA
BIIBAF0w/9Hd3Chj8jjgjoTIzajreeuM0YQFcaaja1TJXhUdikpr+t1TYRxRtA2G7odLJlo/ZuHT
9wZgI2gjFhYZ4QADUt2V/6s9LFBihcrILYGfWhQm7Mq9CY+0mFX2NMLzfQrDj07FtHCFayiOyS3D
vSfe5AhMCHAan0emMQTYb6A4iMPabvNVNbjes0MGiTO2QLnzcYBdWNnphE9I10vN81B8zkJvvN/y
kFzo4XkqFnraS/wWiYhke5KQgGHKiJgUvI2CzPXbCBkQjm0TTrMLXrhvrSzgfOO11aNClG2JIqT3
hqrEQxRxyDIQGoQ2dZ6Kz4iln5m1Dig5oCNe2fd+23YAAAAAAAA=


--=-9x8NAwI62G+es/5QNXGS--
