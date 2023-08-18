Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A569C001DE
	for <linux-serial@archiver.kernel.org>; Fri, 18 Aug 2023 05:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347580AbjHRF3R (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 18 Aug 2023 01:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358006AbjHRF23 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 18 Aug 2023 01:28:29 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2043.outbound.protection.outlook.com [40.107.249.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 873933C24
        for <linux-serial@vger.kernel.org>; Thu, 17 Aug 2023 22:20:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I0LWcfo5n5Y5ygtgjuEA5PZW6+PChMQgHKvQoMmppaWDQiU+AHWQ5hF03fz4Jj/xCQijapZvKkiyCGDl7fgReP9p6HDBnDN2T2PofA80zdl/9QNI6US3az7+mIEotJWC22/nmKFL4rY0UtN2rLemXLd5BGPrl32jRHmVGtIdYh//cc2XTwe4eQCW78fY55OJWDKYL/3GcD6vL0ujSgKim+3RPZF1kkxlbAV2CrwH3bKAXbPVP91rzTJtQtN0KiPIiKIu9x3qSAep0lgCvWQk6POlLwWqC/YPnoj65+QqzYHJjU2SuOTOk/WXFlLDIIdAX2ND8toJg5gA/yv+VonDhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NL5yaw7njfIY3i4gZ+DiEH3gVZamaxaNM7GM/kAsPh8=;
 b=B1RJkbfzcyKbYMK7/8En5auUPR/BMocHsjLmnlUICst3BJJIdaQD8aAPfnCCHsiuCpf6q4TuPg9MYIBTKUkRxTvZbMAdd7+TUq1qHbga7PfWCGo8OEMlraBVOLcZ2vGlN4GQg/+/ey1oRUTfUF9019160AwtlGFDcP0YlSgO15t5gPYqB0dy+6dU2NEmKN2nuNwmPmTvJhVn11ijA4Wn50uFe4Bq7JuuoVGGYZSgDCClxPKizPWNpn6aLSmhKlI7O/FRweYS/IkOs2KtxIFixpawscU1rmK1JJBZfyd0NcZPSVa9FBAv17inwkayiUFERjXeoAg63iohGPH2N8BAZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NL5yaw7njfIY3i4gZ+DiEH3gVZamaxaNM7GM/kAsPh8=;
 b=okXktTfyVTFEjl2n1slMxdO+ZyybWdhiblcWGLlT+b069OCdZwXnMh+OoHYw8B3kthGocz268fAP8B/vJpNMFIn/fDQkaYbYwy3bEe+jOUOyTSXfTBVu4niHCE7AVzL+ojhRyHazNGzlwSdAuO4YwLH8I4eQulLMpwoNK9tbANQEY1rcUYJoB9RAWR92o8rYyI7v62rr/FrIK2WPK7Ev6epfGwK2hWcoEGnIG0NxsYs0mrRWVDIpV550zND1RAAdApCa5lXi8JvfYAI8DjA28NOFFnynAhfMkJPjD7VIqBgPgaPV/8Kka0/gYrHWtkqLiti27NH6uexbCvRsO0RwaQ==
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21)
 by AM9PR10MB4007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:19:10 +0000
Received: from DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eee:6a15:6c5a:af9c]) by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::eee:6a15:6c5a:af9c%6]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 05:19:10 +0000
From:   "Starke, Daniel" <daniel.starke@siemens.com>
To:     Yi Yang <yiyang13@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "hedonistsmith@gmail.com" <hedonistsmith@gmail.com>
CC:     "zhangqiumiao1@huawei.com" <zhangqiumiao1@huawei.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Subject: RE: [PATCH] tty: n_gsm: fix the UAF caused by race condition in
 gsm_cleanup_mux
Thread-Topic: [PATCH] tty: n_gsm: fix the UAF caused by race condition in
 gsm_cleanup_mux
Thread-Index: AQHZzAGgXXbuwx08tE+7Lpx92Yigya/vjwYw
Date:   Fri, 18 Aug 2023 05:19:10 +0000
Message-ID: <DB9PR10MB58811F2D087B85CC426F4FBEE01BA@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
References: <20230811031121.153237-1-yiyang13@huawei.com>
In-Reply-To: <20230811031121.153237-1-yiyang13@huawei.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=34f2c056-8a7c-474e-a510-e606bbb9640a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2023-08-18T05:16:14Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5881:EE_|AM9PR10MB4007:EE_
x-ms-office365-filtering-correlation-id: ad28a0b8-9c95-4423-ea37-08db9faaa767
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a4imfKLrj5v0DwZScEEHNeUHJ3cluTCKuthwbd7fD/4wWRulYZlgcHJ7dEyCNnGLh7MCJ8xPvh8RvRfvyYPl+jzeT9gKCDSLo3ZbCVlnlo2wxSw6Y+ZtEOL/vrZrAtYher9lGYjRvYX/eAEOvEzLQzWp+pa5uVlWwzIC0Iu8vXOpg57GlTWU+yR/QPJjd0m23nT5Rglmc5Y6OlHQlcgjPZMOtTjdzksOwGoZnwTaet07RglPBQ3HOaxR2w42GqTTrHiiPy82SLYeMBIFkeK7nZUXftUl200ftI5/S1GPkJCwBCX1E6tLsLjXpBjvvFqlapBu/n78V905kmH7KSe18wMqubljy6XAX+KTG6jLEhiQ+SlbFhhyPqFge6xw4ySXgrNIA6XHwCiqhdhTaupbLfcS1wAA7lBI/iE+AaPdTOI6vjC+qb5hlATch/j24F+lJeprDltjVkM1zkJkG8LF7OA88MuOPZDYfYdEpn/vSU6hvPEf9Vq6d4X7LJCwpe/7vEvZJByzXFLIPexnOz2syHE+ursH/Q1puhR753/J4GhmeQkeGja2e1LOmT5fXHk21P+lv7UH90oyzsX9NGOVaAJKqPNOE1g7XcxpiNh+JMMaqCtwNkbpt2khDaByWzTf
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199024)(1800799009)(186009)(558084003)(86362001)(33656002)(82960400001)(122000001)(38070700005)(38100700002)(55016003)(52536014)(76116006)(5660300002)(110136005)(66556008)(478600001)(6506007)(66946007)(66446008)(66476007)(7696005)(54906003)(71200400001)(64756008)(316002)(26005)(9686003)(4326008)(8676002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ynIWK73uDW9jz/IVM+40mJuinQc6RMeH3SLeMOf7vZ08uO3al7lr0E2RsxfC?=
 =?us-ascii?Q?L9U1RztUm2Rr7KLutCEilB7eFeYVUcNFMRkn5iGFN7I0kIIES+Ipm0u2/DuZ?=
 =?us-ascii?Q?XopNYZDHSZJhjjSYvSevHHeHcIpQ5dEYCa9a3mkmeP4KobY9kURddZ+ZDd+2?=
 =?us-ascii?Q?+GPSAxmsWMJoR3vDpzIGadQ/RyupvphW7AVD9moo42Rh1yVWJ3MORFJtgaLG?=
 =?us-ascii?Q?xm0lpaypOdqX/OzBgJU9sUs6aheTfiIzBmxY0FKVYH8Y9NxSnACHunxjoHiY?=
 =?us-ascii?Q?RapkVv7axXl6/qThPKMoUuE6Euja4MNcjgWUsm/3OzzH6UHhx6QzdJgyJuOK?=
 =?us-ascii?Q?2GdANMnMEAvQUbw4Fc/fR+MvSStZYdO1S8kMu14HL+L/auyFYpE8FuDGOsnq?=
 =?us-ascii?Q?vdjb9RaGc9Mc9Po3CyB7mezbVWdRLTLRO1QL1bLKyxblNQ6AHSELRaSVXpdj?=
 =?us-ascii?Q?kZO/RI8fH9boV/6OuofneKQvBvRKnPKM3d/vC10FedqrVl2XAgU+sLHapQ7z?=
 =?us-ascii?Q?BgwbySOT2QQMTxCpbh0ZpgHGSNL94V0bVAaPIwIhzuCykWj+N9d/xJ+POmL2?=
 =?us-ascii?Q?hKdbzJjS2qtrfMI/DYrPQxSaMLI1+TxK0j6CJivIo8cRUpWbUqsOv/50JEWt?=
 =?us-ascii?Q?yPwb+F8VjG7ejoTTyqT+WkuJnxxyOTpU8Z5DSfvYGPemG3AfOiRNl3Cxp6D5?=
 =?us-ascii?Q?mQpEMOHNpZy7dsx9klnbBwukqwlU2LmhD20MzFfa7dsWhWnKIjOVGvkhcjQ4?=
 =?us-ascii?Q?Ain1HzN8wHsZFHmQJKrKSR7CyAVti7Xv3zI+6tFJrSyUqnwQxFIRrhUo2lk2?=
 =?us-ascii?Q?5SSLNOFC+dlBDStRHukZCK3FJUfSZU+hWW+Ncam0rTUEsCwQC7LOZW4OnA4p?=
 =?us-ascii?Q?QHjoCVcStoGZppG2VxCLs7vUCZoqOwjabkKVCIWeloxhLqYlfzdKkPkYJbie?=
 =?us-ascii?Q?baimEKSsfEFj3ocX8aVqwkmt217iB9oZO6ViI2+u/OmtQ7ODw5PA51nucpK0?=
 =?us-ascii?Q?RXbUfCSJNvphIu4niJzqzwqPH3webHU8cvAWgfGRSIk+F5+P6zc2Trkb62JD?=
 =?us-ascii?Q?hJf/dzOjK5iXXE+4dNJWHNok9vgjZNYzzhD81Ki7RAu8GGwBxm9BhJIq/UOR?=
 =?us-ascii?Q?TUWPy3Fd51phsCUZvAw/2/+XVb2n1vQfY3mtlpI+dkJQopS/pr88Kvd2biT6?=
 =?us-ascii?Q?yeECJLuyrMBiX6ZUT5vWEs941CQ6lbadRvvk7HqwtmcfUn4iEkyI0oaubqmv?=
 =?us-ascii?Q?s2OUxT8shsy11LEXlQSQha5glKkNPekXVy2h35OIoPw2BiVBUqkCiwOggOu0?=
 =?us-ascii?Q?Wz1bcGCxzMtPgdjXtGgfeeH7Bvn+19r1W1CjCsHBjadNNQMo1KEB4fYJiDvx?=
 =?us-ascii?Q?A/Mil5tFM01+EiF0mzTJo70BVoylNwAjC/uzSQCogylVcluHr/RG0lZe9xtQ?=
 =?us-ascii?Q?D4PImFwjgUGyTD2gBgbqlv1K8xz/0LCiQbPLAX/MeSMF8+BkNDHHwSbNB3s2?=
 =?us-ascii?Q?gxat85eJ/RwkHcAwKIqziq1zvkicQk+YgALWxkUkEoWUUExapmu6WqiIsjFF?=
 =?us-ascii?Q?+rmGmd0pE6ujrNVgOUtGRSTZuYAKKAFoyXG1YLX2b5r1Z2pN6+9El1BUEB9N?=
 =?us-ascii?Q?CQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ad28a0b8-9c95-4423-ea37-08db9faaa767
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2023 05:19:10.4400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iH+JBfD/nA0AVBndHEB+LnP5PXfw+pXT0lrO37lK1yowoNt2VImwldJGPZlq72qam6KubEy62xHrKMBVkvGrq44pgcKpCJX7SP6JZXzwNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4007
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Looks logical and plausible to me.
Tests on our side did not show any side effect.

Reviewed-by: Daniel Starke <daniel.starke@siemens.com>

Best regards,
Daniel Starke
