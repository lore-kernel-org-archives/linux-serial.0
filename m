Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66CC433B4
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 13:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7D1561412
	for <linux-serial@archiver.kernel.org>; Thu, 29 Apr 2021 13:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhD2NDW (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 29 Apr 2021 09:03:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32812 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhD2NDV (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 29 Apr 2021 09:03:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TCrsPb035744;
        Thu, 29 Apr 2021 13:02:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=PUbBZFANnYgrmsWuJ7c5DcJF0vbBKduw7Jos4IZXzNo=;
 b=m3zZlOynBIWN0xAPpNRKhZjpWbbX3rC0DUJGa0pIVd3//sxGUFK57i8g9bOaJ8ZlQ94N
 0vImIg+8IRlBM8303aLm4irJx7z6XwJP3YwkVo/eVrV8TdD5p2SP6/9VD8BA8g1mXP5Y
 2JqwEYXFaWh6fpdBMBZmvOHWiCSapc0aVK5zGLftSfAPqAvMm3aKYDkXmn8nrCV6S3GA
 4INhYptuIVew9kDD8EFa/NLasv6rhIOzzMPe2oD31yFOUY7h9VQb6Nz/q92oBBlxeGd2
 cX3WqyJbkZuBtHHCbKlOOX+5mq4mQWLLIaOEYp4AIOdv8hfErO/tJTdqYdKr/AWNuEru XQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 385aeq49xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:02:27 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13TD0gAb075552;
        Thu, 29 Apr 2021 13:02:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 384w3w7qbf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:02:27 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 13TD1agY083310;
        Thu, 29 Apr 2021 13:02:26 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 384w3w7qaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 13:02:26 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 13TD2OcK026096;
        Thu, 29 Apr 2021 13:02:24 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 29 Apr 2021 06:02:23 -0700
Date:   Thu, 29 Apr 2021 16:02:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <20210429130215.GE21598@kadam>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: DEp-argMsqBGSET_3R9q8vaAqWFTFDD7
X-Proofpoint-GUID: DEp-argMsqBGSET_3R9q8vaAqWFTFDD7
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9969 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290088
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Thu, Apr 29, 2021 at 02:08:45PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 29, 2021 at 10:19:22AM +0300, Dan Carpenter wrote:
> > This loop ends on -1 so the error message will never be printed.
> > 
> > Fixes: 4bcf59a5dea0 ("serial: 8250: 8250_omap: Account for data in flight during DMA teardown")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> ...
> 
> >  			       poll_count--)
> >  				cpu_relax();
> >  
> > -			if (!poll_count)
> > +			if (poll_count == -1)
> 
> Why not to change poll_count-- to --poll_count?
>

Either one is fine.  I considered several different ways and wrote the
patch twice.  The downside of --poll_count is that it's an off by one
in that the author clearly intended to loop 25 times.  It doesn't really
matter if we only loop 24 but off by ones are aesthetically unpleasant.

regards,
dan carpenter

