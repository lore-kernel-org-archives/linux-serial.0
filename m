Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76874C4320A
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 14:27:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B73610FC
	for <linux-serial@archiver.kernel.org>; Fri, 13 Aug 2021 14:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235743AbhHMO2W (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 13 Aug 2021 10:28:22 -0400
Received: from mail-eopbgr00079.outbound.protection.outlook.com ([40.107.0.79]:8823
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231683AbhHMO2V (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 13 Aug 2021 10:28:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj5VY9+tSGXPwaI2yCpqLtJIMPnaKZoftFCFOtU7+Sepj/V22vZfR1ThwZPUYpgBGxj5DG4g2XEPwDNe+d01wi7ygjDM8UDCRxXZQmBbhYVRND04GAZhulpSnL34uXNsMJ3kdMG3Gz7H1PDKUwz3+UI9FLcHoWbu4yHFh8BSP3ur7dkx4m1KXH3ZRzY6GvbBRZ5tCbER7wn6c/AWhDsrlLcD5QrJBC+R+qBYVtrsaGKmoXUnEjKsc46hvXyFE6kvyDelpZkFW2MLosNpOtCpGYswnUFCOI/IpqGo9ZV+wkee+jjJoPWMRoRWK8VG9+Q1JShIzjAh2jGOFsrxvAlypw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR8ezOtMZMQ3L2VsIz2rNCjitma0TbFG7sftBxA+FWc=;
 b=A32s4Pis+zazc+7RV70isuGdAKtK3LtXJ0v5ZMwx8+gz0yWY3ZtvoadEId1vYmnT1D1GMn5XOcPPUxUBcCTTFXq47KZN42Oiu7ZLf0wL04s2/m6dHoh81AaRr5Xu4ybhrXj6oeW2eJamY6WIKymj06V0eVmWvYIoq1rLRANgFb0rzvnmMZArPgZVuHaRQmI0bNHoeZ7jAueRb+IVoYctTMnUkhBDBbDR2OFXC38qc26h6dyVDGNvcVNQtCA4K8eTszwWkZLRtRwQEs+jvdne4jSirrCCNFpe06a8wvtR1Rwl/7CxAdDuBPs3m4cj9k8grHXTvGmZbWxqHnwwhzSpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR8ezOtMZMQ3L2VsIz2rNCjitma0TbFG7sftBxA+FWc=;
 b=eS8yl2NzXcHQj+HhiyfuKUbzj/R66N0V6fW8dyjed9xzylGKilUOx4caPkxcA/1o6V33NiBjd3qEfZo2XGSE8RFI53TjhHSzH6UlMeDNHHLgmNSB/GuxdibNbJLFqXjAGIyMHc3T4d7Bm6lghcrHvInN0AwCcNvzED42PIgGePQ=
Authentication-Results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com (2603:10a6:803:5f::31)
 by VI1PR0401MB2591.eurprd04.prod.outlook.com (2603:10a6:800:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.15; Fri, 13 Aug
 2021 14:27:50 +0000
Received: from VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::ddcf:cac8:c7df:47d7]) by VI1PR04MB5101.eurprd04.prod.outlook.com
 ([fe80::ddcf:cac8:c7df:47d7%7]) with mapi id 15.20.4415.019; Fri, 13 Aug 2021
 14:27:50 +0000
Message-ID: <a0b5810b958eda8149ad498b76b7b05f758b8928.camel@oss.nxp.com>
Subject: Re: [PATCH 3/8] dt-bindings: serial: fsl-linflexuart: Add
 compatible for S32G2
From:   "Radu Nicolae Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Chester Lin <clin@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, s32@nxp.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Stefan Riedmueller <s.riedmueller@phytec.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        catalin-dan.udma@nxp.com, bogdan.hamciuc@nxp.com,
        bogdan.folea@nxp.com, ciprianmarian.costea@nxp.com,
        ghennadi.procopciuc@nxp.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Ivan T . Ivanov" <iivanov@suse.de>, "Lee, Chun-Yi" <jlee@suse.com>
Date:   Fri, 13 Aug 2021 17:27:42 +0300
In-Reply-To: <96c02ee6-cd3a-59df-0b3b-1632bb355019@suse.de>
References: <20210805065429.27485-1-clin@suse.com>
         <20210805065429.27485-4-clin@suse.com>
         <96c02ee6-cd3a-59df-0b3b-1632bb355019@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To VI1PR04MB5101.eurprd04.prod.outlook.com
 (2603:10a6:803:5f::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.141] (89.45.21.213) by AM4PR0302CA0004.eurprd03.prod.outlook.com (2603:10a6:205:2::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.14 via Frontend Transport; Fri, 13 Aug 2021 14:27:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79985f71-f804-48e7-6ffe-08d95e66875f
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2591:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2591623FBA527AC63A7C6D4E9FFA9@VI1PR0401MB2591.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RPhF2a4Sg+21FXMzMC1hW7gH7pn1T7yc2q8+8MNL86e1D+wkzqFfMndCGMC3h9rOeVVwyzgGgC04bpuUDXJPaFU7GSDjZqueHnIS0o+LZFCgDMH/5Jy9mWs8MWpJqfCstLlzupEXYABh6iAw2D105/ZDMgiyMoTEPXoUqFj9MHtwqNBcZsR/1QxOfqgQN7nDnmQaCXS0F10z6iGz/XbHg2hw9joWqGD6LDYn9iyDKCrwxkj0NHpj/o0ihZK28uxER/XfWZCW3LGY6D8jc5clBIQ4v++akK0XTEL+SKdkITXEeAnDu0/19LIF+a3OrqIyQpSLmNrNpLdWhGajg8xLc4L52Yq7esc+B10es9rPfWVzQO5jQZ2S/PvAhOp1YFrlZyioFIx1rvrnl6hjUnefuK1mnkNkRx4v3PBhUplOEHtCWJ0D/R2/ACtNnSbSdR8JbFclAnJWIyD7KsJFZlhxnMMJ8ab+NU+JZu/+88t9Oth9CY9KkaoEc8TcU02EBffaUA8jP/APUxYwf6WzNJCmXQM8/Ekaeqg28QS7k0JEK6vHXas7lD0zwwpRuXmsXApmBfFfTSF5sk15HozdaYfGAzfPLWWSb7gCqNTXXBLkzuDV2BwrJGMGueSB2ny1z7Qr57KbhJ1KGJWT5a44roUNJuPfYfrIeByC0KvKPFg1uW9vOioQfVC4BbsOq+t+2s3k1upgYCTJi3hue7E7FBDsF2TfXv1QLE1QZkvttpsYdOM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5101.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(66556008)(6486002)(5660300002)(38100700002)(8676002)(38350700002)(478600001)(186003)(66476007)(8936002)(2906002)(53546011)(66574015)(86362001)(6666004)(26005)(83380400001)(16576012)(316002)(4326008)(7416002)(110136005)(54906003)(52116002)(956004)(2616005)(66946007)(41350200001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXYrdEpGMFp5amVpb2w1L0Z6VkdhdGFDcExQa0Q3KzNuRlVUK0NxUFVCeTFK?=
 =?utf-8?B?SEwzZndIaHltM0hzcGJuYzBYQ1NXbVQzZVJiYlV4WHcvSVZ3WWRpOHg1akk3?=
 =?utf-8?B?aXlCZFpDNDNxVG8zNkFhVDVielV6Y0RCTHF6QWFpY25FZitlTUJ6c0JETVRw?=
 =?utf-8?B?bjA4aWZGcUdPZFV4OG9hOTJXUlE1RmdBcm5zOEs5THI5MWQxeWVxMjE0NjhW?=
 =?utf-8?B?ZjVsRGZUMStEN3FrNzFMWkVKN010bWZiT0IxaVMxTEEyS2QzSjdobGp3L0VH?=
 =?utf-8?B?MEh1eEtVWHNhdkNkdUhIVDBudVBHdUdpWWoxTTRubTRHZFdzYTJtZ1dEVndl?=
 =?utf-8?B?eHRYOWgxZUxuYmFWMEhEK0pkVE1VOVhKSUJxZkFQemFPWkVzTzEwNzBZOTg1?=
 =?utf-8?B?S0E3VWV0YUNuNFdQNDB6UFJJOStiNks2MzViaFh1WWhlcndNcjhGa1UveEFx?=
 =?utf-8?B?OVoxYzMxVjNETzJDU1d1ZGdsOUtSZDlWSkhxSlphaysyTGRuZHJhMmllWFMz?=
 =?utf-8?B?aW1BSExzM1liWGMrcDR2VW5lN0JqMWRkVzZLL0NkWU1pTzBmRU8vU0YxSmpE?=
 =?utf-8?B?Nmt6QWtKSWtjNk1CK3VYSDdickp4dWRpV0NzRDcvbXg1NVhDMStkTFRIQ0pw?=
 =?utf-8?B?NTE2K3ZVTzlIdExmRFRWUnFaR1V0dXRZK0VaUTlqOWlxc1lJd3o0RnJQRytV?=
 =?utf-8?B?MGZFVkRwL3JrWXVidXlld0RGNmZ1ei9MQ210MW51WlpkSUVLNmJWVEY1V0s1?=
 =?utf-8?B?cUtvbXVrTlpTY09hNFduK0lEa0oySVI0a0R5WFZ5V3piT0kveGxXM3lFNm8r?=
 =?utf-8?B?Y2ZlcE0zakEyK3dWYkFjRTFqY1BKcUdpKzNCTmMwRU9lOWp0TkhtQW5EekNz?=
 =?utf-8?B?MTFJVGpmK0FLZk95eHE0Y1huUDRTczErL3ZVS2kxc0llTzFtbkxhKzBNWGVO?=
 =?utf-8?B?dTR5RUYvdndmTklyQStJZWIzam04dFJVL2RjbUx0VE5iekRoMlYvU2dQVlVF?=
 =?utf-8?B?eEtWczI3T2U1Y2VsTGI5S3lkaHd3Q01IV0M3ZERTZXN6emFuOFpSSzNCUTVH?=
 =?utf-8?B?WkhVQ0kvTDd2ekhTMm85ZVcxdDBQd0VmWllMUnBEcUhZNkd3ZlJ3ZkpETkZP?=
 =?utf-8?B?NnI4ZmJrbHhrcFpxNThYc0NIa0V1TlFaWkE3Q3ZGZkEraGFiV2czTHlIbmI2?=
 =?utf-8?B?R0E0VldzTzg4THNVNFVqMnRzaERSTE1nK09lOTYrN015SmorTzJPeFJNbjgr?=
 =?utf-8?B?bkpZUzdvWXY2UVdTOEljQ05zVHdqcVVJVnJPTEh6WG1ST0VHZ2xCemF0ZzhL?=
 =?utf-8?B?bVZ3UHpCT1YxM25iZTFJdmFVVGIvL1k2RGxncys1YXVWY2JwaVlWYmNNbFc5?=
 =?utf-8?B?K04zS0ZnSVhSMFd1bU80d0wxWGpJYm5OYytSWE9VaWxyeGcvcFJKbFdPRHJu?=
 =?utf-8?B?dVFOY1llSWhNektXT0paOTd2UDBOVU4vcG5oemd5QjBLL1lkNTFNUGdvNTNs?=
 =?utf-8?B?S1JrMkIxYnk3WGt2UVlpY1NDYmFteGs1NWNVMVVnTGkxa29CS3VqdWYzN2M5?=
 =?utf-8?B?WjJtWFQwNHgzKys0YWNuZ0dPV2dkNFdaK0NSZUNzbHFmOFQvMTNFRldCOW1h?=
 =?utf-8?B?REdJWUp4NTZXem9xVjZqNTR0ZWJGeEFpOXh5ekNUWTkrdlg2NXZsVUhqcXRx?=
 =?utf-8?B?dnQrL25RVTlaVFp3LytnWG41eVlrZDRORHJoa0hra2c1Z1RmMVdVSzlHVjdu?=
 =?utf-8?Q?0BdFt/isnrRiTY3muyqWAKd1Oy6NkLEgGTR8lej?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79985f71-f804-48e7-6ffe-08d95e66875f
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5101.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2021 14:27:50.3717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd6h9RW1+xkGP2SDrwmped1q9tLc69VPTjiYI1tR0y+xgtzv1DVwhqx7YjJun3exQHVVJ4WSaH7gTUzKtTO019NNufxYQNW9/9bhbUS1voQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2591
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, 2021-08-12 at 18:27 +0200, Andreas Färber wrote:
> On 05.08.21 08:54, Chester Lin wrote:
> > Add a compatible string for the uart binding of NXP S32G2
> > platforms. Here
> > we use "s32v234-linflexuart" as fallback since the current
> > linflexuart
> > driver still works on S32G2.
> > 
> > Signed-off-by: Chester Lin <clin@suse.com>
> > ---
> >  .../bindings/serial/fsl,s32-linflexuart.yaml  | 26
> > ++++++++++++++++---
> >  1 file changed, 22 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/serial/fsl,s32-
> > linflexuart.yaml
> > b/Documentation/devicetree/bindings/serial/fsl,s32-linflexuart.yaml
> > index acfe34706ccb..e731f3f6cea4 100644
> > --- a/Documentation/devicetree/bindings/serial/fsl,s32-
> > linflexuart.yaml
> > +++ b/Documentation/devicetree/bindings/serial/fsl,s32-
> > linflexuart.yaml
> > @@ -21,10 +21,20 @@ allOf:
> >  
> >  properties:
> >    compatible:
> > -    description: The LINFlexD controller on S32V234 SoC, which can
> > be
> > -      configured in UART mode.
> > -    items:
> > -      - const: fsl,s32v234-linflexuart
> > +    minItems: 1
> > +    maxItems: 2
> 
> Are these necessary for oneOf?
> 
> > +    oneOf:
> > +      - description: The LINFlexD controller on S32G2 SoC, which
> > can be
> > +          configured in UART mode.
> > +        items:
> > +          - enum:
> > +              - fsl,s32g2-linflexuart
> > +          - const: fsl,s32v234-linflexuart
> 
> This reads inconsistent to me: Either this oneOf is for S32G2 only,
> then
> please turn the enum into a const. Or change the description to "on
> SoCs
> compatible with S32V234" if we expect the enum list to grow.
> 
> I believe the idea here was to avoid unnecessary driver compatible
> and
> earlycon compatible additions, while preparing for eventual quirks
> specific to S32G2.
> 
> @NXP: Should this be s32g2- like above or s32g274a- specifically? Do
> you
> agree this is a useful thing to prepare here, as opposed to using
> only
> s32v234- in the s32g2* DT?

s32g2- is fine, but the vendor should be nxp, not fsl.
nxp,s32g2-linflexuart

> 
> I assume the ordering is done alphabetically as S32G < S32V;
> alternatively we might order S32V234 first and then the compatible
> ones.
> 
> > +
> > +      - description: The LINFlexD controller on S32V234 SoC, which
> > can be
> > +          configured in UART mode.
> > +        items:
> > +          - const: fsl,s32v234-linflexuart
> 
> To minimize this S32G2 patch, would it be valid to do oneOf for the
> single S32V in the preceding patch already? Then we would avoid the
> text
> movement and re-indentation above and more easily see the lines newly
> getting added for S32G2.
> 
> >  
> >    reg:
> >      maxItems: 1
> > @@ -41,8 +51,16 @@ unevaluatedProperties: false
> >  
> >  examples:
> >    - |
> > +    /* S32V234 */
> 
> Could this be:
>   - description: S32V234
>     |
> ?
> 
> >      serial@40053000 {
> >          compatible = "fsl,s32v234-linflexuart";
> >          reg = <0x40053000 0x1000>;
> >          interrupts = <0 59 4>;
> >      };
> > +
> > +    /* S32G2 */
> 
> This should not be part of the S32V example, but a new one:
> 
>   - |
> 
> (or with description, as discussed above)
> 
> > +    serial@401c8000 {
> > +        compatible = "fsl,s32g2-linflexuart", "fsl,s32v234-
> > linflexuart";
> 
> Potentially affected by naming discussions above.
> 
> > +        reg = <0x401c8000 0x3000>;
> > +        interrupts = <0 82 1>;
> > +    };
> 
> Regards,
> Andreas
> 


