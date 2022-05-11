Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82E0C433F5
	for <linux-serial@archiver.kernel.org>; Wed, 11 May 2022 22:22:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiEKWWR (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 11 May 2022 18:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiEKWWQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 11 May 2022 18:22:16 -0400
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 490FAC5D9C
        for <linux-serial@vger.kernel.org>; Wed, 11 May 2022 15:22:14 -0700 (PDT)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BLm1Z5003751;
        Wed, 11 May 2022 22:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=PPS06212021;
 bh=wr7ZG2+5/bpDCr2+ahVM6I3Unezs3Dl+CE5tCCm8tsw=;
 b=DISeu/I5V70lfJYO1+N2P1ALhfh7aVpAU1qIuRQSGD+NXrpcULVt0xg3jWrWaJ4ktR51
 KidENg5zER3MYEcSGpmCcOc7E+GT+2dQbgbO5HwSj21TBpDySu9Itz1Q/uOhCd5vTRoF
 3DKdJ3K75jsRdlOKHU0CiL72uPVz78/jRiXvGY4kjR7RkEJ5FCJMon2rk4nQZp+J0hag
 lBVnOBO/WeFJJoN+MyvoobJit64PILgGikD5CXjxn8QSkBhhHboK+uvZqnSqn7Zu+DCC
 ZuZzpvO8NUHBOCbLPeMjNrF4r2bvCuqDjNq+J2D1BfN3iBI8i9/JU4H0/bpqwqcdBEXe zA== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3fwfr8bf94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 22:21:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRyO1pSr+YRsLGu2KaPSwNYAPE4OpNmB2fUNTQssd0A44mYLdOxySUggWkuYFuwd648EUyYjW6fA+1vx+U1smhUVSu8CIuY5zWLgwkQmI2ehtRQalVsr9dT2TP2piEXRsfSojmeqg194YUFPgDOWd5Mw+cBWIaSLBIxQymkHZkZx0xGTlAWan0UPiLk18wJ1jvwd9LfuTlgNl90cpG01ICyWOFfePzPUm6z4aqVxvDCHIm1swDav5KT3qoMLFrUqtpH01gTtXZKWMFFgrR1IbYrVa8Y1u5Ri7ipFkucovYi5wlRjUDorea22Njlopnq0GJyLY5aUw+dGiT6swV/lpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSeOEl7WoH+Tk+uN6HVx5y31TaPZTOhJ6Zu6GIm1cHM=;
 b=LXTuwODXIfNYXfiWXtPYV+MkGniZQbzETOakXU4pAm+2ODFlc/5zHUFRo1H+N32TtvS+u+neZ6CZrKJi1lD3iFVfvPOj1PwUYF4tFQOWPOXCkb+nVC3o85bS4iSNw4B0blmO0c2oBM1Tf8+UAkJKzgIF5lRwQ3acRVN8vznowhXJpdIt5MK9AvCjYqZEThThki7UQqboAwucv9R81JPEfLOf15h06+0nOeESSI/kGYdponid8X77zuyZAVDskU//SS3HR0azPH6twwTGijiLD8fQOjBpL9HEy4nmzgFuAfLulEvYGH67zGTKvrJZImLaaaoD/WL2eQeQwnaudImn3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by BYAPR11MB3670.namprd11.prod.outlook.com (2603:10b6:a03:f8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 22:21:53 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::89e0:ae63:8b71:4a0f%6]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 22:21:52 +0000
Date:   Wed, 11 May 2022 18:21:48 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Alan Cox <alan@linux.intel.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, kernel@pengutronix.de
Subject: Re: broken FSL erratum handling for 8250 on MPC8xxx
Message-ID: <20220511222148.GA37988@windriver.com>
References: <20220511090641.gj66ewjpcx2ra4xo@pengutronix.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511090641.gj66ewjpcx2ra4xo@pengutronix.de>
X-ClientProxiedBy: YQXPR0101CA0054.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::31) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2efee03b-6e19-4b53-3a49-08da339ca652
X-MS-TrafficTypeDiagnostic: BYAPR11MB3670:EE_
X-Microsoft-Antispam-PRVS: <BYAPR11MB3670BD2C1CC98AE046A1D1E283C89@BYAPR11MB3670.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gevh5E9FMJQG1uFf4wFACV99etCebkmQxlAGyKL3+XzU2VgbamebPbhT9aljsaNNrH1fijnMrZMFG3B94wGoNKMyev0/juxceCuK6tpx1Az6remN+ry0GUYdWQyrqGhoCJlVJGcYP9OMs6cbCePMdP4kpaZuie5VOq+JE1jtzB9kJi8Fkt1sHsBBCxSiSS0rYicJLVoY4LEgfEmSSZq0KrFMDNNSdpAyiGgrS8Ha9lXm70mw8URDO3Mrz+ZE3so+BehSTg7c/V6oOo7rlxPb1fhWcu85rVk8C99zAuUpXtmQxXkH2NQ0di/HyHtd8jnTepTWJSll/Fj7IXqTMvKoDofX/o2CzZXCq/Ry9zXXOZs84nVXtpvAlqtkTR71dOao4FGzIJh6Vg7fsZ8tlK8u2XFcDTjQ3UQ6Wver8FN2Esiwc266kt19ZjmVN8eHfYd+xJ2YgVEUuVx7N6ny4mCq6s8goXMfb+DH2mR5jbVLmYknxtRwP3icWiupeRB0WctbatMVAzEvzvZwu/quF5D5+5q3vaH07/0dAcRvHiUD2DrXnL7HfAcHnRESqU9HEE+N8OGrtlpw8ERcuxGwdr/A4oPeQwU7GDPx4SW08Pxek+YcSEmRkLBHI3fjY3nz9k/WGOtoPo/ce6Z2MWLt5/TBtVRHl1qWCQU/xGX94v29kWY8JC5fGOnCPejaw0Qtp39kaBzH4/dAW8FrZ9LQCa9cDYPYmFM/dGvOpejvEtW+BWlyYUfEen+Pkd2K1DiyIc0IhiepgI2OuLzhUmmHNO6JT6/cZ9l0XHkfMvTxSCnS4pdkgiEXGWk6BfDqRHwSLd+a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(54906003)(8676002)(4326008)(316002)(66556008)(966005)(508600001)(86362001)(66946007)(66476007)(6916009)(38100700002)(83380400001)(1076003)(186003)(6666004)(66574015)(52116002)(38350700002)(6512007)(2616005)(6506007)(26005)(33656002)(36756003)(44832011)(5660300002)(2906002)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?8XouVWJtDzyzAvqszpQj65bmIBtaRNMVm5m7+MZ8imkamISlecZtmTXPgK?=
 =?iso-8859-1?Q?JaoU8jQIm66HCiYYbxyNomfZWmbRriRK84Tu/XoPvD45UAzEkSvhUM75PE?=
 =?iso-8859-1?Q?IJxjLnx2xZDHjINrEqgdczPsaRQBCoUn7OZA/BMlg2Naakg9F0gv86SUnd?=
 =?iso-8859-1?Q?beZi6YHOpk8Rq4Usss+jCg+0yZK50wvcbqp99Ws6wvRPySmJhpYyDoRJFM?=
 =?iso-8859-1?Q?lU56evAdtT0r7w5C971162BVdvetyCm8aX2hfjkrjtVLDLgcU2a9pYOk45?=
 =?iso-8859-1?Q?4xWTCViXOfETEkrzbCsXLnTIDGzNYvhu/1nBXkgHqFwNFHh0M3OcjCRhn4?=
 =?iso-8859-1?Q?xBgyUXA8ik/l7ug4aqPelWTNphnYVYofONguOKqsSun04Tm/PpuE19hf+F?=
 =?iso-8859-1?Q?hKRvRxW79dcOjRI3AEHbVxMBDiyqxyvlvVSMFYmu+OiZQ/p3fxw2lgKwv4?=
 =?iso-8859-1?Q?HCn1W4jSm/dXQzDm9kbZS1NB3n8B2wx3/sOnSYZeJRlTT7JVVBVOxF4RxW?=
 =?iso-8859-1?Q?gar88Mgf7UBPAMGnapWM50PteZI7l9A+7Sy4A62ETboaTrwn6ZQZsb+LCb?=
 =?iso-8859-1?Q?ujirEVghxAdVO9c0+qrI5vv3MHfoq4I6GHTmF5Ly7a5KGhi2/4WNMwwk5t?=
 =?iso-8859-1?Q?VOpcWw1bxkx4vvDCf4qdSYSmpQeqgI1DxcQYVvrwVmLYkRBqOkVrB5P75D?=
 =?iso-8859-1?Q?GN3+74zVGkpz0ylHHHZE2tBAys4yORJGcgFz97LQUwm5GsCY4UG0wBViRU?=
 =?iso-8859-1?Q?71mNhQ889OD4I7TCTguiP/lAWTUsDKxZj3XEUKsVea0LPkxXRL0UNs4+La?=
 =?iso-8859-1?Q?6VAQUgR9iwW5k7tNc8QX1bOKF6BJmo1MvO219AlFQVwxDT//r53cwvsNfb?=
 =?iso-8859-1?Q?42NYxKA9jamBmS33DlEj+1dF6b2EAcrfLAyN4cpgbNL5acOGbXBrfoj2kS?=
 =?iso-8859-1?Q?rE2MVn8CdPCDpDm65sJkvYc+ijRDbHqr1s7yE1AET3UDlfBoimCncbQZ4b?=
 =?iso-8859-1?Q?U3uNs3EblzIXli6kf3DQPIp0zKljaOBsEPI9pJW3QK7l4/ngxTqFfDvirf?=
 =?iso-8859-1?Q?u0mRin9sXy4cojLteL0kG246VOUdUL58SrQIFwgocZ7PPoN7D3JYG6XprM?=
 =?iso-8859-1?Q?R/YkK419bFPdWYZveJpuuXknVbZJuMMXY7pJcTeKCjvLBYQfRjhPoKqYot?=
 =?iso-8859-1?Q?imS/Bs5psSIYsIfCfQgLJFZ0+Rgg37+bsAOlQiEePAzLI8PFh+5+ibzQRx?=
 =?iso-8859-1?Q?S6I3SeY2Dpwdmn3l1K94nSHAkja4jpXfGzoijY5PEDaVu6vrosrnVMJqyS?=
 =?iso-8859-1?Q?aCVaTjVZtiLP4XNqu4IVIvOXoWg4UfMxvTaeLa2BtEtKfrPKe+ZUkeA1G6?=
 =?iso-8859-1?Q?6FKzxYCHScTyVB6E6q1YDSUxDK6bKvZ4RCrQXGeCyxs2nJMJDv7KeDCWuk?=
 =?iso-8859-1?Q?laLZr5rh+/OfO7Luij6FmqhmXVLJ4Ynuk323R47ooqr2HSvfYrj/DiIAE2?=
 =?iso-8859-1?Q?3RWTtLplxGgj35ASfYSEO66Hd2Fi/vwQz0zIR4aUvuPkb5e7OSxPei7rGo?=
 =?iso-8859-1?Q?hKtdaRQL4soWGAeR1bJhQZKyKAVSn2QghjN19+RWrquKUuAMYBJ3JRdlVw?=
 =?iso-8859-1?Q?6PMso/Cy398QIrImJBbhKkgl70t7bV7DJyfwS9569ANWKXojo+tHB6GLRH?=
 =?iso-8859-1?Q?efaWbLFRdoLo6nvWOuWPuYoW+rbRWezVbBkv/3jOg7cJqzCn4qkoGdrCFN?=
 =?iso-8859-1?Q?ESNW41za+aw5gLxKsfZ8pcf8MJat0QT07oHT+xtCSwzNza/b+SPy8aoFpA?=
 =?iso-8859-1?Q?fBDjgHmH0/AnuPqKV0uwx+VN6rBEm+E=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efee03b-6e19-4b53-3a49-08da339ca652
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 22:21:52.9042
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+OfC4XU3zYlboWL4qdcY1hbBpTBRZAbfIaUf6zxTjVRszaD6j5luZlzlwZEQ4Cba9lHKMTL20mKnbPT8GAmP/Dj04NgJmLFRd+hshqhsig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3670
X-Proofpoint-ORIG-GUID: is8Vs_SMJjtVwZdkiM31V42l-2p1Q5Yq
X-Proofpoint-GUID: is8Vs_SMJjtVwZdkiM31V42l-2p1Q5Yq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_07,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 phishscore=0 clxscore=1011 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205110099
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

[broken FSL erratum handling for 8250 on MPC8xxx] On 11/05/2022 (Wed 11:06) Uwe Kleine-König wrote:

> Hello Paul, hello Alan, hello NXP,
> 
> I have an MPC8313 here and the problem that a change introduced in 2011
> (i.e. 9deaa53ac7fa ("serial: add irq handler for Freescale 16550
> errata.")) results in a bug. (Will send a fix for that in a separate
> thread.)

Wow - that is going way back in time.  I've since removed all the boards
from mainline that I had at the time -- git show v5.15-rc1~100^2~27

> The thing that bothers me is: The machine in question doesn't seem to
> have the behaviour described in the chip erratum document[1]. I'm using
> a MPC8313CVRAGDC, and even when I send a 10s long break, I only get a
> single interrupt and LSR doesn't get the BI bit set after the first
> event.

So, just to be clear - you've essentially "reverted" the 9deaa53ac7fa
workaround and are using the default 16550 code and things just work?
I've linked below a description of the original reproducer from 2008(!)
Without the workaround, you simply couldn't even use SysRQ over serial.

> (The erratum applies to MPC8313E, the MPC8313 doesn't have a dedicated
> errata document and reference manual. The latter states that it applies
> to MPC8313, too, the errata document doesn't. As the difference betweeen
> MPC8313 and MPC8313E is only an encryption engine I would expect that
> the UART of the MPC8313 shows the same behaviour as the MPC8313E?!)

From what I recall - your conclusion would be correct, but I think I
only had "E" series chips here in Canada?  There might be enough crumbs
in e-mail to confirm, but really I agree - it shouldn't matter.

> Do you have some information which CPUs are actually affected, or is
> there a problem with my diagnosis that MPC8313CVRAGDC isn't affected?

If I recall correctly, the folks at (then) Freescale were the ones that
guided me on setting the scope of where the erratum should be applied.
If lore.kernel.org or other archives don't have the discussion, then I
might be able to find it in local backups, perhaps?

> @Paul: Do you still remember which machine you saw the problem on and
> which version of the erratum you had at the time?

So while I did have access to the Freescale reference platforms, I did
typically do most of my work on the WindRiver variants listed in the
commit 627e66f29aa2 mentioned above - sbc8349, sbc8548 and sbc8641d.

But fortunately lore has a better memory than me, and it says I tested
on 5 different boards - so I must have tested the above three plus a
couple Fsl reference platforms as well - going back to 2008:

https://lore.kernel.org/all/7d1d9c250807311843j58246eeco4411ad9e5deda78a@mail.gmail.com/

I don't think I ever had an 8313.  The Yocto project chose mpc8315e-rdb
as one of their reference BSPs, so I had one of those available to me
back in the day but I don't recall explicitly testing SysRQ on it.

As for the errata "version" - there was none originally.  As far as I
know, I discovered it, or at least was the first to publicly describe it
and propose a workaround.  Then open discussions that lore should have
copies of -- shaped it into what finally went mainline years later.

Hope that helps.  I won't go digging into decades old backups for now,
since IIRC the whole discussion was public, but if you can't find
something - let me know and I'll do what I can to help.

Paul.
--

> 
> Best regards
> Uwe
> 
> [1] General17 in https://www.nxp.com/docs/en/errata/MPC8313ECE.pdf
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-König            |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ |


