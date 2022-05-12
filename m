Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF70DC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 12 May 2022 01:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiELB3j (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 21:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiELB3j (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 21:29:39 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7829154B3F
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 18:29:36 -0700 (PDT)
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24C1Gwtw023489;
        Thu, 12 May 2022 01:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=PPS06212021;
 bh=7pha2d6BoQfKizlA4xiob5mBwoDWYPvkztRhMTK1E6Y=;
 b=cb3iSbVLPMkbvGfRozxbMJGGckAJvFwB1piRoZ3tcd/2IBWrcrtNqjWs2teFaNrvtzG8
 dlzu+PWpgUvGuYPxNcH2hwxrosxZAHc9Heo/Zc0yIZ6dkuNzjhcd+sc/VR9zWS+bAQK7
 LR2RlJyvCD38otGsN1hh1277S3whxoQ+EBtKDnd2aPljxKtqFwQP8q4PDtFWjNAsouiJ
 OYUAK6qcLArVL5ta6rQMILvNx07rlztNoiGWHpBvMDYXVTQPMB1fNpzXT5y0nXaGNSv2
 /3tQUVpp+dS3lvu8QGqkP4/4rYvTrkejSt9/6OJo/375clHGXanqY8oyo4FXMJT6/64z /A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fwdyyukxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 May 2022 01:29:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OSAQ0SQ6ocjCj0heFDDFziMd6hDomz4uOQu2++GkbGmMYbMbeSyDoJ3Lui+YYwBOixXjeO3pmrJVA1hG8zCoaQysrVdPYboQ71pxJb2aRd3myCuDR6sStJOsyHQhR/YHhFh54poWraMM1BTwOfcjk9DqOqx26LyUyMEq3kOxAbWKsSzjnlIif56vj7q1l+NbtCDc9zKvPPU9Il86L1sjmpGunDktQel7z4WvJjy2BjXgHeGrjX7J4sQGpd0MyMJexTuFHDiWLwg4h+Fx8YfA+lIFvzsOQOhovVSPHxBT067fD85kqGXIBY5gEyI++GC5CgCqjxfzfLu8z3R831RfEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0jOijV+qfxvFXjtCYg7TPqHlnZoyKnfiX13nyoycsk=;
 b=QJXTaxaSVf8lpLHBXDcSd1CHr+pUZxxglJXCfrTPqW8DcCMPwu1ZJbD0KTHxia7FjYe2IWG5YcUziYITkKf0ZNGQU8QFPUcY6tu3pJRW669WU7OZ1eJ1RRvsXdyCKBMcPSGmy4/nbYqSookfr0js+F1iFF/xJSvkY3pGCuJvuSzsyhEPMSkBAYKH+QKDxHu7sLem/rUrILG2IiE43ZFwOX+G666XNyWBAV+JESi2JTiuBvNR7TYVLXaWyyMk5XgtIPIPVnk2RiY2+D36Xgt/8tuFe4jvrsY5aPNsn8nAHfRVEsLtRP/qmaZdJ7GLF5g9sIU3oTdT5pS/OTYO2/YhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by PH0PR11MB4933.namprd11.prod.outlook.com (2603:10b6:510:33::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Thu, 12 May
 2022 01:29:14 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5250.013; Thu, 12 May 2022
 01:29:14 +0000
Date:   Wed, 11 May 2022 21:29:10 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Alan Cox <alan@linux.intel.com>, linux-serial@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice
Message-ID: <20220512012910.GB37988@windriver.com>
References: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511093247.91788-1-u.kleine-koenig@pengutronix.de>
X-ClientProxiedBy: YQBPR0101CA0314.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::27) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72d896e6-d2b7-470d-8db4-08da33b6d2b1
X-MS-TrafficTypeDiagnostic: PH0PR11MB4933:EE_
X-Microsoft-Antispam-PRVS: <PH0PR11MB49335AE36CF4F13B8DA1070483CB9@PH0PR11MB4933.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3QgBs5nPURZPtA2HY6WPDzoc/dXKaMPB0vu9oL7csmQ9WsTmmX4FfHd2vsscN/BuM+O66giEVVwJufVEO6oTwYEwpdEtbqNjg7xDfuKzLr1y7Dm1++UXv08sRS7XlK+kwyYqt/hNpSNPvfNUX7nL6uYWZrtKWqNKEtQufAe6LDeT+fAZWbguvYFlyTV7l0+fFvtvRa+IGx/YUztP9xPo1qq3h+7hcKfQWzEjk6uvazVX4SLWiu/UX7jq248z9KZkOEne5lS2flmnSYRdOLuCl7nYeXAuUDD5t6/MWiDY89MdNGhFRC8XM3xhGD1tI9yskgOdbHiWjZRzwV2c/4SlfYoi7EeGukYIaUSzc2HUgDc0XArps4pcb5D2TGk/RLriZKxqX8fOL+a3XXZ8zonUF1KUFJ3aod5hE8ydQeW4YgILkUi/QYigrzgaxvr08/n7m97aPy1Fom5SdTud3kMXbX1cPbMnQLNOJyfTgOsUcmWe7/Me3+0MOPXP4Yt+sB/zEa6t/7LsisOpJvyD5mGBXMS6kkZKNJIuTNkTjt9kmpInT6YeQkoCZp+8gT8JNVMQ7J1dF5m2vfhRWKIcfZnI5+yEm3JjaqSI9bueojQwRj4hJIM/9YOv1IqgCE33q1rrjTYymL2ods5nXAfxYbYWVfa8tivHpmgONfbBrLwry8hrrIONjGqDODgVkLG8c7SVLs5ebQKwBrOOKz7VLHrkmmXMT/d5tXK2ub4SwKRP2Uw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(66556008)(26005)(66476007)(44832011)(316002)(508600001)(66574015)(6512007)(6666004)(186003)(52116002)(6486002)(2906002)(54906003)(8676002)(4326008)(6916009)(38350700002)(33656002)(86362001)(38100700002)(2616005)(8936002)(83380400001)(6506007)(1076003)(5660300002)(36756003)(326664003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?WLVyEoHJOF6gLf5qKpAaVWoVzuP3Q4TsyLHD0jzyjH12zRDARk3ZHYieDT?=
 =?iso-8859-1?Q?gzh199nu2khftXlf34NheWVESGhPiBzXahOYH5/+TPI4jWwdNwcgHpBTAW?=
 =?iso-8859-1?Q?jSPz1cMRBjboOUAcWM/uRDINNdeXkJYrxTPguBYzlRQnf9c/2uSXpg3yv5?=
 =?iso-8859-1?Q?fmx4EZKKJug+L3lFFD0tJoegESxLkWPMBvnOj3AL4X9gtUUVi6yldGm3vQ?=
 =?iso-8859-1?Q?NyWm0H8KylWxDWFUqwE9V9tuaLCw1VNfjeumrYQnBLWPlK3RuNFfGhs6II?=
 =?iso-8859-1?Q?4EQiPvUfpCwUeJaHFYciBEi0jqJUvgW9X+FK83wo7JljhX4vo1i8zx66Mp?=
 =?iso-8859-1?Q?NVFG/DmbOQFDFFR5ZLRuLZe9HQWXc35gHbJZO/9h95UroozTYjz7cu2yrE?=
 =?iso-8859-1?Q?kkPdkymlz8cLB/KX+l7OiSozVCBsw/r+S/GHZfwVLBX2A2I1JRsL+Grnu1?=
 =?iso-8859-1?Q?veQDhRximKUJpnkH8ilEZzRX9FnfjTn4unwNgz90zlTDSmTn6RDiUpMBIh?=
 =?iso-8859-1?Q?VS2R8a025pQE1HxTfrXvZfssUxZczrwhCfVJm/MwlU7pr4GDT+qQgyGQR1?=
 =?iso-8859-1?Q?qNRoFHjlHTFwLNqZIB7XMggpsr1m1nyAvIGg+buSOcB/rlKqA8zOM989jX?=
 =?iso-8859-1?Q?vWXG3lgmqscviDoQMpajmJVgN14tmqzMOpI3zwECg8Zu84ocj6GkeelojF?=
 =?iso-8859-1?Q?2kP1EnP0CMZyy8y+SU4nRYxyocyrFaGMdgc8+hRFsvD1wY8l2ycwNjNKlr?=
 =?iso-8859-1?Q?+aT0rbFtnoampKJdrY2gCWsbecv3ofsLzRKZFJ0jUTVr+bXK4aE4OdjR3k?=
 =?iso-8859-1?Q?Jt8kzPVedtHrvRap1xnQxjm7UPmzBolovMhdmS8ymgHtfqt4MUGnRJa/rd?=
 =?iso-8859-1?Q?u+vdZuSygDJQinHYVMpAGCHVADyTwcCAYeF43/DwU3pQXK7HKbvYW04p9p?=
 =?iso-8859-1?Q?5FauraweLY1bEAfi3Q9DBzejcCse1fhmX0u7uOjAtWgMYWzef71yN10X9l?=
 =?iso-8859-1?Q?TIeqwiBiv4kNqOwEAj6t5YH8uGvw/IV2tsEhJOkECKsyFMr6MOo7YgwuyN?=
 =?iso-8859-1?Q?vOScz5/8yZN7eVgtD8oxxZZ3XNjJhFfeebbCIkFYtrSakkq97rVQiSJMKn?=
 =?iso-8859-1?Q?obYCuvxwJ2GISQR0CQwd3j8/3dr7Z7mToGonz/w9fDK5QJ/pdjcF1IPClW?=
 =?iso-8859-1?Q?mJ9QGS4xikYiz47L4NCTSMzjBOvitmvJtFYXKjOobXG8Ab8TMZHUpM/ZSx?=
 =?iso-8859-1?Q?H4enB/wO0w4tlgY0lBTR+uIz0cwrBESUBImkpybOHIgBoZzxLYZbcb2N+A?=
 =?iso-8859-1?Q?tWFM3jkKSYv/wA7cRl8I4kzNolurn0jsmdHzHO1/tOlPnQYrx3S1c2Csml?=
 =?iso-8859-1?Q?y7HUVjDbb23a0uantRyg/jdeULCCVe0ViLK3WMkt6CD6khSwLsRy3s2hU/?=
 =?iso-8859-1?Q?HXUOhCiatzz+sXkNlVUAegu/a+1PCaVEgKww2WmLjw94kUnM1Ge/zxdqg+?=
 =?iso-8859-1?Q?zXRKvAEjOTVEMXL/HfxT/qERLjvRSRBn3ROFI43x2PZG47fQUTt8ZdzOhU?=
 =?iso-8859-1?Q?S9UCoH8zgCwdN2gA4ByU44bb+MBsTwYHclBW5MECRHfvOOf1ZYW2ZQ7EVz?=
 =?iso-8859-1?Q?KbDQGr16OkGu5oJHMJnFrYlC/ft/mkmpp90uqlcIxFlDjSDmdZMCZqVGAb?=
 =?iso-8859-1?Q?0W2GHX/vVW2mFuZ2UwaAw7BT00PZjRTt+xehjE5O3+kFoEzyQ13tHfHDvE?=
 =?iso-8859-1?Q?ZTHsddXXzyJ+14KB1GN5BSA+7l5wOGGL17OYxfhe+4TVVDPD/k9c3mivAL?=
 =?iso-8859-1?Q?j8/3r8QIZhG7TvjiSKD/khmaHaS9BZo=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72d896e6-d2b7-470d-8db4-08da33b6d2b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 01:29:14.3417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTvOZiBQBRJvb4+JJhOKYfKgM+jNpwXkmMQvH0D4Y5VUdLZ4LZe+l9ZpPBhLbVMLJLeeU22OjGAayucWnX2GogQ82rdj1rDknZNpub/oMPs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4933
X-Proofpoint-GUID: YjnuXc_HuJbWKobbvEAnElmMpfzF8Skr
X-Proofpoint-ORIG-GUID: YjnuXc_HuJbWKobbvEAnElmMpfzF8Skr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 phishscore=0 mlxscore=0 spamscore=0 impostorscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205120006
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[[PATCH] serial: 8250_fsl: Don't report FE, PE and OE twice] On 11/05/2022 (Wed 11:32) Uwe Kleine-König wrote:

> Some Freescale 8250 implementations have the problem that a single long
> break results in one irq per character frame time. The code in
> fsl8250_handle_irq() that is supposed to handle that uses the BI bit in
> lsr_saved_flags to detect such a situation and then skip the second
> received character. However it also stores other error bits and so after
> a single frame error the character received in the next irq handling is
> passed to the upper layer with a frame error, too.
> 
> To weaken this problem restrict saving LSR to only the BI bit.

But what is missing is just what "this problem" is - what applications
are broken and how?  What are the symptoms?  This is a 15+ year old
platform and so one has to ask why this is just being seen now.

> Note however that the handling is still broken:
> 
>  - lsr_saved_flags is updated using orig_lsr which is the LSR content
>    for the first received char, but there might be more in the FIFO, so
>    a character is thrown away that is received later and not necessarily
>    the one following the break.
>  - The doubled break might be the 2nd and 3rd char in the FIFO, so the
>    workaround doesn't catch these, because serial8250_rx_chars() doesn't
>    handle the workaround.
>  - lsr_saved_flags might have set UART_LSR_BI at the entry of
>    fsl8250_handle_irq() which doesn't originate from
>    fsl8250_handle_irq()'s "up->lsr_saved_flags |= orig_lsr &
>    UART_LSR_BI;" but from e.g. from serial8250_tx_empty().
>  - For a long or a short break this isn't about two characters, but more
>    or only a single one.

I've long since flushed the context required to parse the above, sorry.
But the part where it says "is still broken" stands out to me.

> Fixes: 9deaa53ac7fa ("serial: add irq handler for Freescale 16550 errata.")
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> note this patch is more or less untested because I have an MPC8313 that
> doesn't show the behaviour described in the erratum. However the patch
> fixes handling of frame errors, partity errors and overflow errors if
> for that SoC the fsl8250_handle_irq is still used (which is a different
> bug).

The commit log probably should indicate how these three types of errors
show up and how current mis-handling them is manifested in user visible
symptoms -- such as what you are seeing today.

The "untested" part is concerning, since this 2006 hardware is on the wrong
side of the bathtub curve and if you can't actually confirm that you've
not broken the original errata fix, well that isn't good.

I've done my best to recall what I can about this very old change in the
other parallel thread, so hopefully you can then reproduce it and then
reconcile what issues you are having without breaking the original fix.

Paul.
--

> 
>  drivers/tty/serial/8250/8250_fsl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
> index 9c01c531349d..71ce43685797 100644
> --- a/drivers/tty/serial/8250/8250_fsl.c
> +++ b/drivers/tty/serial/8250/8250_fsl.c
> @@ -77,7 +77,7 @@ int fsl8250_handle_irq(struct uart_port *port)
>  	if ((lsr & UART_LSR_THRE) && (up->ier & UART_IER_THRI))
>  		serial8250_tx_chars(up);
>  
> -	up->lsr_saved_flags = orig_lsr;
> +	up->lsr_saved_flags |= orig_lsr & UART_LSR_BI;
>  
>  	uart_unlock_and_check_sysrq_irqrestore(&up->port, flags);
>  
> 
> base-commit: 3123109284176b1532874591f7c81f3837bbdc17
> -- 
> 2.35.1
> 
