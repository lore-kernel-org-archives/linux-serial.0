Return-Path: <SRS0=t8aj=AV=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA17C433E8
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04C5A2077D
	for <linux-serial@archiver.kernel.org>; Fri, 10 Jul 2020 13:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=SealevelSystems.onmicrosoft.com header.i=@SealevelSystems.onmicrosoft.com header.b="ngHl4caL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgGJNN3 (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:13:29 -0400
Received: from mail-bn8nam12on2077.outbound.protection.outlook.com ([40.107.237.77]:48193
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726896AbgGJNNZ (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 10 Jul 2020 09:13:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtbCNPQc9kCbt/RfGWwIITycWBPXN0hFVYwJx5/KDK/7p1DGhnggRs0FUXZar7hGStH0hV7bl+la8qNaiQlaELeOJZffo04Oh3vOw+ni/DZ6lhp8VqulmVLqBzTFAsmPiLuFrTwwyydSBKaUQpOAVBsrZurB72FQDU1Py37EllN0ovUHXjtTKWZtM43mYgBOnS94ltytMuypKLyAL1nzQOwuWoVSPB6VHwIZqB+14LPtyDvQsbJbVDMFGh0QSe6Yvx3G5fhgpbZCcUYjlzbaC9HrW829f4JXdqOyybgIGXfZoGfKMIgSV7aCNXZf9smL5X2g7u4sH2edo6l+b/0rnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u6X+wSkU+ThauP++6Zha3c0N4nUfhCt8MY903o9T1A=;
 b=RDW8Tvh5KRG9tqqKtu0kS0sfQ1UCCgV3rVnCfIZin2XsVFkkf8/46yYWA27Gug7P+a/usRvtydqAWDmNLz5kl68vjDYnHgPd12WY6X59WibPinTAISZChI2h6QcpcQIwV1AWjZRGqbJZTNqTvfEWcI5pcsOUQJe6cLyAN0N5Tlm3Kt0CJ7tu7wHnrr1Jr8dskqa26vgpggnlyAaxggJl25GLaDVCOUU2RhzV8qlgG2chupaBe7M4/o4dbFfXgWky5OgTaCMwvpjniiNnOkx5LivnG58LAaDw1s21C1uAf2iseTQvf/XGnrtuBHbGiDN30orgtssp2vK0VcDOcdpOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sealevel.com; dmarc=pass action=none header.from=sealevel.com;
 dkim=pass header.d=sealevel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SealevelSystems.onmicrosoft.com;
 s=selector2-SealevelSystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7u6X+wSkU+ThauP++6Zha3c0N4nUfhCt8MY903o9T1A=;
 b=ngHl4caLmbePRPu+t3psd+ZiDt3D8F7JgwshSVH719KFNw7VazqA6n6Bv7wCuDdOOosou9GQipfKbhIB/0vfTRaJRpaznbzendN48IAm79ED+5pJOiUMoYvVotwp3gChLK04fjEx/159uJkPYxJjDKOB05p9IanGiHeFW+08Xj8=
Authentication-Results: sealevel.com; dkim=none (message not signed)
 header.d=none;sealevel.com; dmarc=none action=none header.from=sealevel.com;
Received: from SN4PR0501MB3757.namprd05.prod.outlook.com
 (2603:10b6:803:4e::26) by SA0PR05MB7434.namprd05.prod.outlook.com
 (2603:10b6:806:c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.9; Fri, 10 Jul
 2020 13:13:21 +0000
Received: from SN4PR0501MB3757.namprd05.prod.outlook.com
 ([fe80::6175:9bc7:2811:cccf]) by SN4PR0501MB3757.namprd05.prod.outlook.com
 ([fe80::6175:9bc7:2811:cccf%5]) with mapi id 15.20.3195.009; Fri, 10 Jul 2020
 13:13:21 +0000
Subject: Re: [PATCH] serial: exar: Fix GPIO configuration for Sealevel cards
 based on XR17V35X
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-serial@vger.kernel.org, jeff.baldwin@sealevel.com,
        ryan.wenglarz@sealevel.com
References: <473cc7ae-c870-ff0f-0c68-bdcfed19efde@sealevel.com>
 <20200710124103.GB1567243@kroah.com>
From:   Matthew Howell <matthew.howell@sealevel.com>
Message-ID: <568e88c6-6f66-c9d0-b692-f15698a13577@sealevel.com>
Date:   Fri, 10 Jul 2020 09:13:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200710124103.GB1567243@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-ClientProxiedBy: BN8PR12CA0023.namprd12.prod.outlook.com
 (2603:10b6:408:60::36) To SN4PR0501MB3757.namprd05.prod.outlook.com
 (2603:10b6:803:4e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.0.2.15] (12.18.222.50) by BN8PR12CA0023.namprd12.prod.outlook.com (2603:10b6:408:60::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22 via Frontend Transport; Fri, 10 Jul 2020 13:13:20 +0000
X-Originating-IP: [12.18.222.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7b5a98-9948-40c9-3e75-08d824d304f6
X-MS-TrafficTypeDiagnostic: SA0PR05MB7434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR05MB743438EBC0CACAC4A8CAAD09F9650@SA0PR05MB7434.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XizfHXMSn384S2JpVOILYmpGnW57QwTugb6ZY7P6yaN46JPN9TIoHSmq1utFfreh2vFsSBwlw0bQy44L64p9+oDhm3HPDQ2ZEge3Ablgbd+UBVgQy9M1ZjDD+7Yh5TXrriIBpidM+iyHa6pj+n7NNQoofiUWI6sG/6tMVl/OYI+XqEMv/9e1ytVVuJtXFPUha618bxfut3GqY0qQ+V/EbBO9r29+N1ca82Qf3UqpLhVNo3UJU4ivfz0xWMlzdeqnfwlXoFdfOb/wvjjPQGi84yK9UYhg+mBadqC56GbFBx6kyislEer/LrjGSWBsWGiJjXRNjutG8YAg+VD9OkgR8DEZtYUcIlCZrbljrtO/E+do1FM54XixV2IzDIHUjg91
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0501MB3757.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39840400004)(396003)(346002)(366004)(376002)(31686004)(186003)(36756003)(66476007)(31696002)(83380400001)(66556008)(8936002)(26005)(8676002)(478600001)(956004)(6486002)(2906002)(4326008)(107886003)(16576012)(86362001)(52116002)(316002)(5660300002)(66946007)(2616005)(16526019)(53546011)(6916009)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ie+7NG9TmG3u+WmNqeWu0VRmk960b3mab0VCuxeydGXCqVz2HJYmWVfVd6ZsaVno6OvN2Lg0gyArdLdeowSB7aq4NKvIlyoo0YN/xaRELCr4ntEpPrzgm5EGT/euQdQUXsUKTafhdsaEvfwMuYj0j+kTBATfARf6iuEv0/kqB0uPVFPZbxaiAMDrDWbbTxy8+UiQslcp7uEkpCiTjhEf29v80DxUzvNoCt41+UAYbmbZnTaMyYL2bP3Cw8fsr+YfK39ttrOOTmdoe8hPMYdk74Vpzg4f0B4g9tNAOKvbMd/HufP+WLePpomrQ56mDYMxVfK6LugNHXdbZ1WC+qwUkalUSkL8231fjZYQpxZYWpBSPu6WGcf9mIo0i/TAdqZpMWLGGXI6rgxjG2nR3IdkJkY3RHF89MttENHeB49+smG5oIMTFqy9te9jYbwGJ5r3p2B065yMtA5SISi/2oh47An+JQ/uihT0iE7Be+5QeT4=
X-OriginatorOrg: sealevel.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7b5a98-9948-40c9-3e75-08d824d304f6
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0501MB3757.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:13:21.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e34c5615-b4e3-481c-abc8-602581f2e735
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqjmmXXZgzQluGlCT4uTBNXmfvLmn/Ttk3OUDNakB2loLAqMogPrOSugCQIIGZPuUL3OJSQ8IugPWGAVKVA/HdCIxv1wJZxxzuwxtLnFoVg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR05MB7434
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


Could you clarify what info was not acceptable? And was the whole patch del=
eted/rejected, or just the
info removed?

Thanks,
Matthew Howell

On 7/10/20 8:41 AM, Greg KH wrote:
> On Thu, Jul 09, 2020 at 03:23:37PM -0400, Matthew Howell wrote:
>>
>> From: Matthew Howell <matthew.howell@sealevel.com>
>>
>> FIXES: 7dea8165f1d("serial: exar: Preconfigure xr17v35x MPIOs as output"=
)
>>
>> Sealevel XR17V35X based devices became inoperable on kernel versions abo=
ve
>> 4.11 due to the GPIO preconfiguration change introduced in commit
>> 7dea8165f1d. This patch fixes this by preconfiguring the GPIO on Sealeve=
l
>> cards to the value (0x00) used prior to commit 7dea8165f1d
>>
>> Signed-off-by: Matthew Howell <matthew.howell@sealevel.com>
>> ---
>>
>> With GPIOs preconfigured as per commit 7dea8165f1d all ports on Sealevel
>> XR17V35X based devices become stuck in high impedance mode, regardless o=
f
>> dip-switch or software configuration. This causes the device to become
>> effectively unusable. This patch (in various forms) has been distributed
>> to our customers and no issues related to it have been reported.
>>
>> This is the first patch I have submitted so please let me know if anythi=
ng
>> is incorrect, unclear, or if any changes to the patch are needed and I w=
ill
>> be happy to fix it.
>>
>> --- linux/drivers/tty/serial/8250/8250_exar.c.orig    2020-07-09 11:05:0=
3.920060577 -0400
>> +++ linux/drivers/tty/serial/8250/8250_exar.c    2020-07-09 11:05:25.275=
891627 -0400
>> @@ -326,7 +326,7 @@ static void setup_gpio(struct pci_dev *p
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * devices will export them as GPIOs,=
 so we pre-configure them safely
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * as inputs.
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -    u8 dir =3D pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR ? 0xff : 0x00;
>> +    u8 dir =3D (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR && pcidev->sub=
system_vendor !=3D PCI_VENDOR_ID_SEALEVEL) ? 0xff : 0x00;
>>
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writeb(0x00, p + UART_EXAR_MPIOINT_7_0);
>>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 writeb(0x00, p + UART_EXAR_MPIOLVL_7_0);
>
>
> Oops, nope, can't take patches with that info in it, sorry, now
> deleted...

Confidentiality Notice This message is intended exclusively for the individ=
ual or entity to which it is addressed. This communication may contain info=
rmation that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or othe=
rwise legally exempt from disclosure. If you are not the named addressee, y=
ou are not authorized to read, print, retain, copy or disseminate this mess=
age or any part of it. If you have received this message in error, please n=
otify the sender immediately either by phone (864.843.4343) or reply to thi=
s e-mail and delete all copies of this message.
