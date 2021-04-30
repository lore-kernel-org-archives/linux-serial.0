Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F06FC433ED
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53909613E7
	for <linux-serial@archiver.kernel.org>; Fri, 30 Apr 2021 11:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhD3LmO (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Apr 2021 07:42:14 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52748 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbhD3LmN (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Apr 2021 07:42:13 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UBf04p157245;
        Fri, 30 Apr 2021 11:41:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=vX7MB4vHpiHW2VmKV1bmxIW4ZneYW0EzTAYlwl34xH8=;
 b=qOy0CLeIPMiCQTKGyW4k85unLvV8QZ0k7JAVGfBSkQ4uOdgMvPZJONdf8Wx5KGEo2fWJ
 HWW+Je5nCAuGYSOQU3ox9/5kVLtp9z5iSoh+DJ4G6iA+7XhnrRPKoe0Hw1AlxNgsnnMr
 H7qdBxp/6C909ga3J1D4DHNASDlEAOXTVJ/4QpS5LcncknxRWTrvtCMDRFZ78mK7mlme
 e6ZQ4ZUt2Iqv7KLJlHTp8dkydt9Q4JRHAEGHXFMq4kS3bAf7NnXbkZm8GdLGB8f4CP3s
 4oYTWF5+TINolcnmi5iy8ARq3dzv+GQXas2ub3VhGXFty8NIJuWGXPbZUkekcexn/mi7 Ug== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 385aeq7e88-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:41:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13UBf1kJ101159;
        Fri, 30 Apr 2021 11:41:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 3848f2dut0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:41:16 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13UBfGoD101705;
        Fri, 30 Apr 2021 11:41:16 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 3848f2dusf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Apr 2021 11:41:16 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13UBfEtN028047;
        Fri, 30 Apr 2021 11:41:14 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Apr 2021 04:41:13 -0700
Date:   Fri, 30 Apr 2021 14:41:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <20210430114106.GF1981@kadam>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIvDz7hEhwm66R8G@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: APEHEUW3MzMICozZKzitGgljfX3OoiN_
X-Proofpoint-GUID: APEHEUW3MzMICozZKzitGgljfX3OoiN_
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104300085
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:
> On Thu, Apr 29, 2021 at 04:02:15PM +0300, Dan Carpenter wrote:
> > On Thu, Apr 29, 2021 at 02:08:45PM +0300, Andy Shevchenko wrote:
> > > On Thu, Apr 29, 2021 at 10:19:22AM +0300, Dan Carpenter wrote:
> > > > This loop ends on -1 so the error message will never be printed.
> > > > 
> > > > Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > 
> > > ...
> > > 
> > > >  			       poll_count--)
> > > >  				cpu_relax();
> > > >  
> > > > -			if (!poll_count)
> > > > +			if (poll_count == -1)
> > > 
> > > Why not to change poll_count-- to --poll_count?
> > >
> > 
> > Either one is fine.  I considered several different ways and wrote the
> > patch twice.  The downside of --poll_count is that it's an off by one
> > in that the author clearly intended to loop 25 times.  It doesn't really
> > matter if we only loop 24 but off by ones are aesthetically unpleasant.
> 
> I didn't get. If you use --poll_count you get exactly 25 times and moreover,
> you may convert variable to unsigned type.
> 

Here is a small test to show that it loops 24 times.

#include <stdio.h>

int main(void)
{
        int i = 25;

        while (--i)
                printf("%d\n", i);

        return 0;
}

gcc test.c
./a.out | tac

Why would I make it unsigned?  As a static analysis developer,
pointlessly unsigned variables are one of the leading causes for the
bugs I see.

There are times where a iterator counter needs to be unsigned long, or
u64 but I have never seen a case where changing an iterator from
"int i;" to "unsigned int i;" solves a real life kernel bug.  It only
introduces bugs.

regards,
dan carpenter

