Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909E1C433FE
	for <linux-serial@archiver.kernel.org>; Thu, 12 May 2022 15:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356074AbiELPqz (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 12 May 2022 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355527AbiELPqy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 May 2022 11:46:54 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1196449FB9
        for <linux-serial@vger.kernel.org>; Thu, 12 May 2022 08:46:50 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CFj2Do003089;
        Thu, 12 May 2022 15:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=PPS06212021;
 bh=BvgrUeXG6MZbY6CrXJRb7r4eAcs4pfBrXcguDjO7Q7M=;
 b=oqaznRr5NI6m3y/kwKps98fIkjXzBKzk+YF4CwLTPlmwkrhFYtz8Kecc5ZyfoINXT9fg
 yXIA67h+VOe1+CJNxqzIrfUbswapdkMR0RU+qCjk5W3X6CLrD5RK+A+1+nm3iu02uDiV
 Vpa9+me9eVG76RJ0yzirJIlFzL/Vo1wnADWFFCZruYvpFEshvdMs3XPfg8521XulM+cW
 OXaPs+XtwC32WFg8l1fZBVlpXr8poriBbq6dgMTnlvNaBsFHwdS+38zhtX0VX0ox+MYu
 TTfxqFCro9/E4rv+U0w/wLnOCsw7ZB0wqUPyuOLph7C2BzkoeZNkBZ6SQTpMYwy5Ga5e cA== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fwfr8c298-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 15:46:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBiBwxjxwPlOs0ZT9/6KZwnu4XGpWv/X6wkGyNxDAsjepELK290/Ibdg/vgwrAWI3LJB1c8HxDEHnONv7Qp4kG6eIQWbJFI1whNK3jacXU7syAijBtXgBY21LyQQG2ThKFAMt7a+ndzWkH13IO+lB3oH4h59utVDfElQf2cUraKUK9twWAQHr2PMP1CD7V7akSZnZQjxozymxvgZH9rMTZGQKrqx8vCTMuwkDgF3ZOGngbgoeQubQ8MBdEhUro3sDgy/mNP0W3PtoeHJawgKC9FyTm2zDPZhC137KZ3wwGA5pOaKYVl2LaqcgcClTHikD74I6Q+G32qIwl1Gbmcvpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BvgrUeXG6MZbY6CrXJRb7r4eAcs4pfBrXcguDjO7Q7M=;
 b=BWf84UZfeVvGtdudCSW8IbpIw5SZiqGCHZ/nhLp7Y3p3c6gnqpEqnnD7OPTK1r0MYBCGtv0Nt94Ux8nTOiyYjM3L3OqxhfJjj13bgc186HC24+Jie3ph7bnC9ZatV8Pp1cKvIAcVYv9u848O0z2eAHAHPoDU5Pnny7oSwljt0QsR50NZbnJwe6HATNrgCewMk38WktbZmFjM92bPimBin86O7iGhl8NP3si8vktwmT3B9MKkB0plTBKOR6EkcsJInmnT+1lRY5ivRYZLxhahu11ydCrHFi1g2gPiR4EQEHPkJev/kU8gY7+F1ICsBtVe3rSAvDTuWvHqbZe/jFDElg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BN6PR11MB3860.namprd11.prod.outlook.com (2603:10b6:405:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 15:46:24 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5250.014; Thu, 12 May 2022
 15:46:24 +0000
Date:   Thu, 12 May 2022 11:46:21 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, kernel@pengutronix.de,
        linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
        linux-imx@nxp.com
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Message-ID: <20220512154621.GC37988@windriver.com>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
 <20220512012910.GB37988@windriver.com>
 <20220512061724.4guiyqa6vcdru4iw@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220512061724.4guiyqa6vcdru4iw@pengutronix.de>
X-ClientProxiedBy: YT3PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::32) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 031d3630-dfe6-4bd4-af8c-08da342e91b2
X-MS-TrafficTypeDiagnostic: BN6PR11MB3860:EE_
X-Microsoft-Antispam-PRVS: <BN6PR11MB386023DE84A7354562C0D75883CB9@BN6PR11MB3860.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KO+TdxAItptltyAgXYeQt8O5hiK2y85mZNjXMwLhGu7eos5NU1/Ekm6Y3FIE8M7RWoFyRG7KZQQm1c+xnHqPCD4gahsAUY3qt4Jvuh+r1ZWE9aQ6MtGRMTFczP7CzVgkCfSLGb1TXlGzVu1yJebpVw9DuutjA085e7Z8BwyypBWlMSLWDlAhP6mmyBpwILKJhsDJbgN9g4Ad53M2KwD+kZC/FxTfmPTY2h6I8bz2y5byYFrGixZ5FdDsO/b1Fhn5G38XVJVi41K3iM4BIeNNMzCJkN7S/arjVIYXZo9BLne6PYtZuulttoiU+RqGtjy6H1GkggD8ps+Ixbaqrv9TMD7tiq+s4f3cjFiB4DhLe1LPTT7qBcdHiLaOdsQ9J/zfszZGZNWmpvo3JUTKiREIp/6L40nZwQH9OikmERib0r3561rls5AB7M7OA6zv8EqxaUgmzVciWOg7pXfc6yg0kzklliADh/lIpwETKRYhn7C45JT9CXnzNv4zF8hicrCcuTFUj4fdGbo+2kMdj/qG6cI5gxdNiTI6GwkOV5AJXMcjKoPGfsIWxk5iHctfp4/FkdGC0YVDJ3kvKLpLGAUKvmR0YVdtBU/9CjueVqPx8yWz0Z/QCnpewhS7ttoX/TQDNSESOtQTo7djf9tnOtoBgRLswTxStrvcmVnv85Vk7SnZQ9DeRrcZDYd6JSxG3Pn5jK7nIjcWbmY+gOz29QQX7YYN9OvO0jZAJA6cI/bR8gfx+G5o8rSiSeFQglgyUzRpIjuwPVPXyx+fHMdH+qMVRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(26005)(86362001)(66574015)(8676002)(83380400001)(66476007)(66556008)(66946007)(8936002)(508600001)(38350700002)(186003)(6506007)(5660300002)(2616005)(33656002)(44832011)(2906002)(6512007)(6666004)(966005)(6486002)(54906003)(6916009)(316002)(36756003)(38100700002)(1076003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?TmVyzedoHelBxb+4xMDqv4IGLCZw6oJt8EqDilglyu1WFMe0i4VmLEsXcR?=
 =?iso-8859-1?Q?I2MYvRTr9OGQhXBJkaEaPt1G/YXJ5O3vbT7L3tTfOLoVS/s868c9JGfhTj?=
 =?iso-8859-1?Q?7ZfZaMsjJfwu14/p3p+PsVvrWKkvAzg4i3q/DcfInHLJB4aMVMVFhQnP54?=
 =?iso-8859-1?Q?bqfnFQhukwrlH+68p2M5rlogNQu+NB3LZ6Y97JiFgDTvGmcF87ERbmst8S?=
 =?iso-8859-1?Q?XZoniaoZVvGamBYe00PDg8+Z0lAjtpMcXRAr+2oNXoS3TlacJLYMCv1Swz?=
 =?iso-8859-1?Q?CAoWeukaI2PWH+4T/ILFcsl12S6mhgk+YPistLN5r9174T86wvnqiOcTiD?=
 =?iso-8859-1?Q?es/Iy9cQJqpGdrVdfStxTAYrIt6WWNAlSZoBUehlQL5IyuggNOnBh4pR+9?=
 =?iso-8859-1?Q?J0CCV04R+VdbRIwQAMoul7xgBM9cDuReNSBx81137DEA30Ao7PeM/suKJO?=
 =?iso-8859-1?Q?P28z/BJFEL8dYqDsu6JE1+ARtwEyVuQn7Ioxmqc5JR1/9U/DGpWuTOVdNX?=
 =?iso-8859-1?Q?fHjuI3YJ3dkkxHNEIv3jrBNMfO4ZHDAfbVKLYoYsHqTCfUNqDQ9716DwvC?=
 =?iso-8859-1?Q?liJ8zdKqiPLAJgzuK0hGMVKO2ewWuDOBtVz6fHPBMk+0yl8KQV/4k+GiS3?=
 =?iso-8859-1?Q?hebopJaiu6Ztz5bjkwzfBTDES8XPl5CSNGf/NFCFqx+5Cy6eaP4zP9o+Pa?=
 =?iso-8859-1?Q?BMmR75doP3Oz7iVQ44G8Wiir6HwaCZy77yzwFUm49OeRASPODo4Zve9SuD?=
 =?iso-8859-1?Q?qILQfB7BUjHnrgakE19VD0Egl/ue6pFjgonNhLdxd3B7FYgAW1tdibkuS+?=
 =?iso-8859-1?Q?LmF1eg5MysoLq9hW8MEay6hOAS8bLw4QXhrQq0tmh2jPq1lhJ4X4BLOrsl?=
 =?iso-8859-1?Q?G//9UM+16OuDn36++IeYeydX/ITvHSXKtXgNI65nP9WCYbkWiNJunGxXs9?=
 =?iso-8859-1?Q?Vtt08lyJ9xme6c06GNBkIxUtXCroIBy8mILO+CAp+GFgWom0nz+G9zRf8M?=
 =?iso-8859-1?Q?p46T0BkCxBIIVi7dpygX9BKWLW8Z+ApmLN2VQqOEqhHpP71PYUaA+stqdK?=
 =?iso-8859-1?Q?HKX6doLNHq1aOr52DtA3En0SJjVuYdMxsj03S3a9yUhEo8GOBxv686OFNT?=
 =?iso-8859-1?Q?I6S71JHyw3wrxokuZrBEX5gXrchcFb6AfckKzGW5hjW/vKsdP8xlIV4Jy8?=
 =?iso-8859-1?Q?eZq2cLcnZyST65UjeAR+NBdQaktXgiTqxrtgVHRWpCilyI38G8uRuLX0D0?=
 =?iso-8859-1?Q?4JzxibzYfWYpsIelLSZNGunfqDhS5CeIw5aW4ZSa6wq3O/Aur0JnCftDKq?=
 =?iso-8859-1?Q?o1g4layh99bjmcJ31n04R4HIPToupzmxCI9qr3wjBudcn3dFEY3IKmUj3N?=
 =?iso-8859-1?Q?wuMSmv1DE5ani4Gsd1v2PIJc8cEpWp5ffHQtOn1AWguAoXEe5I4E0eqIyC?=
 =?iso-8859-1?Q?SXBN/LCixqnLcwfAfpikobccTw5STUSOO2WPXaC4om9jRtFZa4+nHzURKA?=
 =?iso-8859-1?Q?f3jochUUCabAuU4hwhf+hrSmwYpIq+YlO/mJZ8idc3RJet2npAIUTu9uZL?=
 =?iso-8859-1?Q?K9reZZqWxO42kDcTuD1/qMT9aEKaBnkqkor8vRSuq4qU+1dcUxdfX7WOLH?=
 =?iso-8859-1?Q?n76m4JReYVqWgJT5c5TLMWuUfgp05sDB1VCWeUvL5c7NSQtJxkjPMAFrMr?=
 =?iso-8859-1?Q?qO7lt4ztiHXtP69Qw+f08qtZrAs+QuWxVVDs+Aa2Hez1DwG7WWVIuP4is4?=
 =?iso-8859-1?Q?MxWJ+GPuj9NiMYZOobvg/lR9x1gvzmH1/YKW0JYXs3aCigF5/4wbX9Q7hG?=
 =?iso-8859-1?Q?b2xsewqk/Nk3Q+Ue/oRlMMY6DTPBv1U=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031d3630-dfe6-4bd4-af8c-08da342e91b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 15:46:24.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6gFepjZL0OjNEVFFI/IzA9IShDqadJ2qpsdviu56VZcuFtGK7h5LfNbyoTBCEqeYyloq1BamtmR3z+uQPExtcw3CMXrrukyvzW/w+OgtTG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3860
X-Proofpoint-ORIG-GUID: GUGBX2ckpId3rvBlhpJuHgSEgfR3rvaM
X-Proofpoint-GUID: GUGBX2ckpId3rvBlhpJuHgSEgfR3rvaM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_12,2022-05-12_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1015 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120075
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 12/05/2=
022 (Thu 08:17) Uwe Kleine-K=F6nig wrote:

> Hello Paul,
>=20
> first of all thanks for your cooperation on this ancient topic. It's
> very appreciated.

It was quite the flashback - stuff I'd thought was long forgotten!

> And oh, I failed to Cc the NXP people. I added them to Cc:, maybe one of
> them can add something valuable to the discussion.
>=20
> On Wed, May 11, 2022 at 09:29:10PM -0400, Paul Gortmaker wrote:
> > [[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 11/05/2=
022 (Wed 11:32) Uwe Kleine-K=F6nig wrote:
> >=20
> > > Some Freescale 8250 implementations have the problem that a single lo=
ng
> > > break results in one irq per character frame time. The code in
> > > fsl8250_handle_irq() that is supposed to handle that uses the BI bit =
in
> > > lsr_saved_flags to detect such a situation and then skip the second
> > > received character. However it also stores other error bits and so af=
ter
> > > a single frame error the character received in the next irq handling =
is
> > > passed to the upper layer with a frame error, too.
> > >=20
> > > To weaken this problem restrict saving LSR to only the BI bit.
> >=20
> > But what is missing is just what "this problem" is - what applications
> > are broken and how?  What are the symptoms?  This is a 15+ year old
> > platform and so one has to ask why this is just being seen now.
>=20
> The problem is "However it also stores other error bits and so after a
> single frame error the character received in the next irq handling is
> passed to the upper layer with a frame error, too." which is just the
> sentence before. I hoped this would be understandable :-\

I was trying to get you to describe symptoms at a higher level - as I
said above, at the application level - what were you using that wasn't
working that led you down the path to investigate this?   Transfering
data wasn't reaching the expected max for baud rate, or serial console
was showing lags and dropped characters, or ...?

The false positive error bits description is fine, but it isn't
something that a person in the future could read and then say "Oh I'm
having the same problem - I should backport that!"

> > > Note however that the handling is still broken:
> > >=20
> > >  - lsr_saved_flags is updated using orig_lsr which is the LSR content
> > >    for the first received char, but there might be more in the FIFO, =
so
> > >    a character is thrown away that is received later and not necessar=
ily
> > >    the one following the break.
> > >  - The doubled break might be the 2nd and 3rd char in the FIFO, so th=
e
> > >    workaround doesn't catch these, because serial8250_rx_chars() does=
n't
> > >    handle the workaround.
> > >  - lsr_saved_flags might have set UART_LSR_BI at the entry of
> > >    fsl8250_handle_irq() which doesn't originate from
> > >    fsl8250_handle_irq()'s "up->lsr_saved_flags |=3D orig_lsr &
> > >    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
> > >  - For a long or a short break this isn't about two characters, but m=
ore
> > >    or only a single one.
> >=20
> > I've long since flushed the context required to parse the above, sorry.
> > But the part where it says "is still broken" stands out to me.
>=20
> The current state is (assuming the errata is accurate and I understood
> it correctly):=20
>  - You get a problem for sure if there is a frame error (because the
>    next good char is thrown away).
>  - You get a problem for sure if there is a parity error (because the
>    next good char is thrown away).
>  - You get a problem for sure if there was an overflow (because the
>    first good char after the overflow is thrown away).
>  - The code is racy for break handling. In some unlikely cases the break
>    workaround is applied wrongly.
>=20
> (Where "thrown away" is really: passed to the tty layer with an error
> indication, which depending on tty settings results in dropping the
> character or passing it on to userspace.)
>=20
> My patch only fixes the first three issues. A part of the reason for the
> uncomplete fix is that I don't have a platform that requires the workarou=
nd.
> (I thought I had, but it doesn't show the described behaviour and
> instead behaves nicely, i.e. one irq per break and no stray bits are
> set.)

I was hoping that with the full description of the issue from 12+ years
ago that you'd be able to reproduce it on your platform with the WAR disabl=
ed.
I take it that you tried and SysRQ still worked fine?

I also found a copy of an earlier proposed fix from 2010 on patchworks:
http://patchwork.ozlabs.org/project/linuxppc-dev/patch/20100301212324.GA173=
8@windriver.com/

Maybe there are some additional details in there of interest?

I wonder if some other intervening change in that wide time span happens
to mask the issue?  Who knows.  I'm not sure if you are that interested;
enough to go try an old kernel to find out...

> That the patch I did is correct is quite obvious for me. Currently the
> fsl8250_handle_irq() function sets the bits BI, OE, FE and PE in

If I recall correctly, it just clears BI - are you sure it sets bits?

> lsr_saved_flags, but only evaluates BI for the workaround. The commit
> that introduced that only talks about BI, the mentioned erratum also
> only mentions BI.
>=20
> I can try to make the commit log more convincing. Or if the ability to
> test this code on an affected platform is declared a requirement, I will

I'm not in any position to declare any requirements - just that when you
are bit-bashing to work around some "black box" silicon errata, any
changes might impact whether the WAR is still working or not.

Your change alters lsr_saved_flags for *every* event, even when no breaks
or workarounds have been in play.  I'm not sure what that might trigger.

> drop the topic, just stop using fsl8250_handle_irq() without feeling sad.

That might be the best option in the end but I did notice something else
you might want to consider.  I believe the fsl8250_handle_irq() was just
a copy of the generic serial8250_handle_irq() as it was in 2011, with
the single block of code inserted for the WAR:

+       /* This is the WAR; if last event was BRK, then read and return */
+       if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
+               up->lsr_saved_flags &=3D ~UART_LSR_BI;
+               port->serial_in(port, UART_RX);
+               spin_unlock_irqrestore(&up->port.lock, flags);
+               return 1;
+       }

Of course as we all know - when you copy something, you risk being left
behind when the original gets updated.  I just took a look at today's
generic 8250 one -- "git blame drivers/tty/serial/8250/8250_port.c" and
there are changes that probably have left fsl8250_handle_irq() being
left behind.  A bit more detective work would be required to see
changes prior to the refactoring in the 2015 commit of b6830f6df891.

It probably would be worthwhile to return fsl8250_handle_irq() to be the
"equivalent" of serial8250_handle_irq() + WAR as it was originally.  It
would be hard to argue against mainlining such changes - they are table
stakes.  And who knows, with a bit of luck it might solve your issue too?

Of couse that is more effort than to just stop using the workaround, so I
wouldn't blame you at all if you decided to go that route.

Paul.
--

>=20
> Best regards Uwe
>=20
> -- Pengutronix e.K.                           | Uwe Kleine-K=F6nig
> | Industrial Linux Solutions                 |
> https://www.pengutronix.de/ |


