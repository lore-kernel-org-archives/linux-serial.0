Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B517AC4338F
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890FE60232
	for <linux-serial@archiver.kernel.org>; Wed, 28 Jul 2021 14:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhG1OwW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 28 Jul 2021 10:52:22 -0400
Received: from mail-mw2nam08on2084.outbound.protection.outlook.com ([40.107.101.84]:40769
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235345AbhG1OwW (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Jul 2021 10:52:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edqCKjVQrV3kh2ncZzmRhZk9S4o2FEW+GDBek70blsDfibo4hqGVm2kFLg/CNhjAvUTLhwzrhrmUiq22FWaS/NlS9lHp0Gnwx9SXdU24AnL8YTmfaRYH8NtKoUEKDTcTV7AmrnzpEBZw+dIJs6wSjBFcXq1EkLE/SBzgSi6vQkNHLkJUwYqa9mE+WRtMUh+enpx2TJhrqiY4fb9z2bxoUo+pwPtNHagynwwQH/Awwx5wyRLLAFTHrjPM5okwSFnIeC4jirILOqx6jjvQQCg+qQVGonPVSTJhzN14j3hm8jDXmmgkaswFE0XkzOyyMH9qFmKLKAtgreW6mctmcV99Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+DxZgPvnbwoRnSwcGjiWM+HGEHL2OKPQwJwYaRpqjU=;
 b=Oz35g1p9ASyIPxAjvJrsC1EI1x8sWqwX5WULWHTDHwS1ykNFkLNw7f6RPWsffhmM+yUwmpmAg/wl9We1//lP/OlBSSW+XKFYeEiTxVd4qq4/xxAhL22IaP3WL3z+pD0Y09W41QSUN0m7wEIoclrXqpa3+uedBNH4LRmRLmPKKyou524TmOs8JLJClCjvGJZAtNie3kKK0pkLwDi+MLCDM3uXOUrcYR8IXgI9hG1C65jpANawrV9cGNHVQ1n1IZFOhjbUGPeu66cGxkmRDRJ30IqDIE320ryhzUcGswvDqAlmLAwdBMCtlF2h1eRq8fb0J/6MEbO9q7fkkINCWUYsFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whoi.edu; dmarc=pass action=none header.from=whoi.edu;
 dkim=pass header.d=whoi.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whoi.onmicrosoft.com;
 s=selector2-whoi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+DxZgPvnbwoRnSwcGjiWM+HGEHL2OKPQwJwYaRpqjU=;
 b=mvbWM7KPFM3GHSvOUr1JvJFYALWgd6kf3KvBGpeFm671WuCgLsHtILv6nR2PU9rsVpIlMx64l849FHfjJCvsevWSap9aOzlm3x9bm2ugVPEU7+TUICa32iZ3jkYcpQDkS37wz/yTSaUeGZae6VhRlrp0j9pQkp4dVYnzJAthZWE=
Received: from BLAPR16MB3891.namprd16.prod.outlook.com (2603:10b6:208:275::16)
 by BLAPR16MB3905.namprd16.prod.outlook.com (2603:10b6:208:276::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Wed, 28 Jul
 2021 14:52:18 +0000
Received: from BLAPR16MB3891.namprd16.prod.outlook.com
 ([fe80::2428:abb8:fc63:b2d9]) by BLAPR16MB3891.namprd16.prod.outlook.com
 ([fe80::2428:abb8:fc63:b2d9%5]) with mapi id 15.20.4373.019; Wed, 28 Jul 2021
 14:52:17 +0000
From:   Dennis Giaya <dgiaya@whoi.edu>
To:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "jirislaby@kernel.org" <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: max310x: Use clock-names property matching
 to recognize EXTCLK
Thread-Topic: [PATCH v2 1/1] serial: max310x: Use clock-names property
 matching to recognize EXTCLK
Thread-Index: AQHXf8KX2Kdg/fu3HEuuRr5uVYgv16tYgMyA
Date:   Wed, 28 Jul 2021 14:52:17 +0000
Message-ID: <19b100cfa0c1eb8b5d321ff852f18f7ce5768149.camel@whoi.edu>
References: <20210723125943.22039-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20210723125943.22039-1-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.4-0ubuntu1 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=whoi.edu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdecf6ef-5599-47f1-66b6-08d951d74baf
x-ms-traffictypediagnostic: BLAPR16MB3905:
x-microsoft-antispam-prvs: <BLAPR16MB390585378FF08A8765AA46D3AAEA9@BLAPR16MB3905.namprd16.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WqainUNKJ6pPIqKJl1+8uNuN5htm2PbK99SXb4/RU2rhQNYUR6D0quvANQteYzW9QDLMJAah76FYNP3ujxhYkYRaEWGWC+W0qXp915mzXYuLNFLyoJggUkTS2ntXpvOYDy4Dmzx5tOR99P6PQtHt/fnLDK0ohQ+P6NEiQ5CtD4Ha6bgFQXPk8D5OBYDV+5mh+lSigIzcL35HPNS6M+MvAEMPTO4GqEqehczXT8rAmfYsPAAsFOpYsEAi0Pdmc8Ut5jmhiEjFhzDQKh/ti/9R9NN0oehJTUPuNeNC3kGClZWLuBEZaPzRGYpIHF4TnJ2jit1mykpHyEgbtXjL1hfVyJ4ELlGiwznDkLQiOFNl/z4wCoGKIQDH9mqqlyxuhdYlIn+Pt20jnKVvm/3bwAepn4T2f8/sGebEDKx7USuxms279sFia4DeL8PKrCpjKlrid4F0QTbez5oK5v+I4IS3MlHrICxwCxORbwaUA4gse0qlyWS1ioHrulzcuDDe9cXZ9aydMrCD/FfIRuPu2R4IqbKuL+5OraeTweqWTHTE2cw7Ym+QRdF41iep3QP+Sf7vKAgUxtyh92M2c0fwQDNMokews/1V06dfhYOOTclXwHVH+tMkhL1IlIdXp3dh1YyqVFpSOvdxcOK+jQju1CtmVaELzXQYbSxNKNReLMbYIAXGU+677dwFrWtLWDCo11zCy2KfuZKtCQMDo0BDlQ9sMw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR16MB3891.namprd16.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39850400004)(136003)(86362001)(6506007)(786003)(558084003)(4326008)(66446008)(64756008)(66616009)(66946007)(66476007)(66556008)(316002)(8676002)(5660300002)(38070700005)(110136005)(76116006)(8936002)(36756003)(2616005)(478600001)(2906002)(6486002)(99936003)(122000001)(6512007)(186003)(75432002)(26005)(38100700002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTh0ektPazhFZVhlSXNweTdmdDJIaFdLSWpXMlNWSlRYMEI2cEt5b2Jiemlq?=
 =?utf-8?B?RktVZWowRE9odGhTbGR6Q2JmQlU1YUFBTjBEVzYydDBWVGd3cEtVQzUrcVl0?=
 =?utf-8?B?NlVrS3dLR2xRQ0xMYkphejlEUmpDbGFJTm5rcGhlM3NHSXJzeUpjbFpCZnNX?=
 =?utf-8?B?RjVGTTFDams2bC9PSUVaWTA1ZnBKV0k1Wk1sMXBkZFBaaDhQWk9JenhFaE1h?=
 =?utf-8?B?aS9GZ1Nsb0lUWERkdmdzLzY3NjdCL0FRRzFEMlh1Y0tHaWo0LzgrNEFIcEZk?=
 =?utf-8?B?OVRERVR3WU01ZDVQQkZRWkFVazByMERoeWg1cVZGU0ZXaWU2Q3FWSTBVdWxU?=
 =?utf-8?B?MDR5Qm1FYmtnL3BURlJGUEx4ZVJpL3ZKeGh0d0hKeURKajRBQ0RqdkNhYTQ1?=
 =?utf-8?B?RWlaSWFkU0lwUnRXTW5VNzBYc0JwaGtiVWs1TkpPLzE1QS9kbFRuWFBDVTVq?=
 =?utf-8?B?OEpBcExxbUNNTytZRTNuV3JyZ3JyQm9qcW5ZbXpjTWlOQlAwSjhvdmlnOStK?=
 =?utf-8?B?eEdqOWxtRUFmUWlvWnVSekU2SDhpWEdoSjNVL081VkpiNzhiM2N1cnVUMCtQ?=
 =?utf-8?B?TFdnT1JIa2JKVzRubWZxSm9wOUlvMjNCS0l5TlhnUzBWOWFrM0x6U1V3dXFY?=
 =?utf-8?B?Zm9uUmhianp3bTd4Y1ppN0pBcmE0akdCT0tzVW5GVkl2NUl6RmF5OEZtWWZQ?=
 =?utf-8?B?dS8xMS9RUmlLL1k3amNEQ25RRm85Umc1czc2N2pRblgxdno1cHpTT0tKTFVB?=
 =?utf-8?B?QVFPMnlMWk9vcldmN0dOays4bERjeTVOWE9UZDhsOUxnYTBtOGQ5bXZZK3Fz?=
 =?utf-8?B?RURqWVo3WVZteFVqOG9jWTQxZW9rS21SY1BwK053Y2VYQ3BDSWdYSVFqSkFj?=
 =?utf-8?B?NzM0QXZiNld4eEZhKzQ2bzYvUEd2cGZONEI2aWNJZkZnYlgyb2thWDh2WlE2?=
 =?utf-8?B?b3NLS1l5dmFqaWhKcVh2OW5XMnpwbjNnR1RNYlRra205SGtpUnFFWjdVUEN5?=
 =?utf-8?B?VWdtWnNTaWFucjJoZ3JIeXB3UmlKTEZnMEtFdklkL2R6U0JOcWhsOFE3cWRa?=
 =?utf-8?B?dWhJa2QzQ3BtNXE2Zi9veUErL1VjZTY2K3BSYnNoZ1VGdkpoWi9DQzBLanc3?=
 =?utf-8?B?dStPYVJoaGlnYytXcWlETTZVN0J1eGUzTjIwclVKNFBwOFkwdDZBWmdBbjd4?=
 =?utf-8?B?c283Ym5qK2R2K0gvUTNDYXdwWlNRZGMyNThPeGpsaTZ1bVNlY0d3NHBUVkov?=
 =?utf-8?B?RGREams4SnJmUXdsL1NXakEwRHVhMkNDbWNscnhCR3FVMEZ2ZGFsRzNpQUQ2?=
 =?utf-8?B?bDh5djhWQ2RtMVN5VEJsY3NaUHJhd1loOWlNSUloSzlLakx4Uk5zOHhScWgy?=
 =?utf-8?B?eVVMaytkTGsxNUV6SDNyQVdFd0YvdjlNM1JzM2ZYK1VXbVRuMkhhUGFZNXhz?=
 =?utf-8?B?MTc0KzJod29sRkR6b1UrcTk3dHFlWkZGY21GNXVxNjM1TmZEKzFNbW1MZkZ0?=
 =?utf-8?B?YU5YaTFjYzdMUlcxRFlwQzZ6ZzVldDlpZnlTeTdlOWV1eDlMZldUdlZBY2xF?=
 =?utf-8?B?ZkpNenVPd0pWUVp2NlUzUjdTeFVqajJ3Y1dIcDhkRlFlZWFJazJKN1ZHUUV5?=
 =?utf-8?B?VERId3hVanIxb25SbGppQmc1YkJsalFSa01GWFUxdktxMG8yaFNMenFLbzY3?=
 =?utf-8?B?Qnh6dGQrL0hjVDExOVAvNXF4aU40WXFwZ3B0Nzd5VVB5QWtsTHZsS1NGWWZU?=
 =?utf-8?B?SzJwVjFyUW5tUktpVGdSNi9OeW5Fb05QQ1dnUDZ4QVRUcE1RaEtYazFZTVJD?=
 =?utf-8?B?ZEYvamhRU0R6VnRQK3JCZz09?=
x-ms-exchange-transport-forked: True
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/pkcs7-signature";
        boundary="=-EZeydL8pGn7gHA/tU3Hz"
MIME-Version: 1.0
X-OriginatorOrg: whoi.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BLAPR16MB3891.namprd16.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdecf6ef-5599-47f1-66b6-08d951d74baf
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 14:52:17.8673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d44c5cc6-d18c-46cc-8abd-4fdf5b6e5944
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AyhZHLNw6QTilH6jmumK0d3VY+UavYK0jwfa0OjD5T9b6RFlDtgtn0ZJY5u9K8rK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR16MB3905
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

--=-EZeydL8pGn7gHA/tU3Hz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> v2: added Tested-by tag (Dennis), inverted comparison to leave
> original flow

I've tested v2 with the inverted comparison and it works under the same
test conditions as v1.

Best,Dennis

--=-EZeydL8pGn7gHA/tU3Hz
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwNzI4MTQ1MjE3WjAvBgkqhkiG9w0BCQQxIgQgiyw2330X
q9cC+Ogq5z+Jjv6frUeDYGCWNHNM1gWj7R8wga8GCSsGAQQBgjcQBDGBoTCBnjCBiTELMAkGA1UE
BhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoTCUludGVybmV0
MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFuZGFyZCBBc3N1
cmFuY2UgQ2xpZW50IENBAhBRsis0cALMxBLMwV/CyuCCMIGxBgsqhkiG9w0BCRACCzGBoaCBnjCB
iTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAk1JMRIwEAYDVQQHEwlBbm4gQXJib3IxEjAQBgNVBAoT
CUludGVybmV0MjERMA8GA1UECxMISW5Db21tb24xMjAwBgNVBAMTKUluQ29tbW9uIFJTQSBTdGFu
ZGFyZCBBc3N1cmFuY2UgQ2xpZW50IENBAhBRsis0cALMxBLMwV/CyuCCMA0GCSqGSIb3DQEBAQUA
BIIBAARY5oxF1UKQrCDTn4fBgDehJ++8rgK2wK5Ux4PLuEINVL6SAOopAWHhW50kWIVp1iLww8I3
62tjb7S05olB7BTEEoWEZ/djifHBI21vFFpiCVIfl1eEoGgOMp3EuIls4A7QnaiKYZzeSREAGuRD
WRWJ5k9hFyzTKo8o6N+EmMCS/55dI+krWAdHNz/ja6NGAi0pncAZD+qPjjoVSMnhPqSf24Hk8HOt
u6XYroX1kBCcg8asH6SR304/uweZ1cqBCRckl73X9z1usOzBP/PV98xro2rFx/+SpaMhAZKJrAnK
qd2Gi31bDM2wz+jjL4QSQCOsjcasL/2hvt6PVYwd/WkAAAAAAAA=


--=-EZeydL8pGn7gHA/tU3Hz--
