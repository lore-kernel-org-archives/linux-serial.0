Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D39E6C433ED
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 08:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AC2E61453
	for <linux-serial@archiver.kernel.org>; Fri, 14 May 2021 08:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233368AbhENICA (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 14 May 2021 04:02:00 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26608 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233325AbhENICA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 14 May 2021 04:02:00 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14E7u3DX010312;
        Fri, 14 May 2021 08:00:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=53N2v53Sh9Oe6tdlImw8UrznG4OK5VlPjccMeWHxRJs=;
 b=LagvfVfb+SyyKPeQwR2/roLIYS7SpKamRZt2aAA/HihLHrWZPqKpoGUbfUanOCP3brQ0
 RytRIIYnxuhqsOCNA/awbno+4xgrl1bNVEJMxQVEvRZRGGZxyXClo4/fKjtHb/yofZAK
 F5s0x5qExgSfuYNBfa6lRrjpWmWCBpPvpJTfaojsamXccPiVUcqyG8uwEjWhZMbCZrm+
 nDmHFvv7pSq5QIRLEa2U+O7LMg08nvMIs7xm90RLFZYsgEQtxBxMe1nYNbD7R1Qub9iA
 FNXkrJchB6ZRAnLIHOzT+kn4YGYaDAsEPTcwHv+4LO7aQyjqie2cxlzObJdc3zwa4a1i rg== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqsrkcw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 08:00:44 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14E7uuiN044370;
        Fri, 14 May 2021 08:00:42 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 38gpq2unxn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 08:00:42 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 14E80gGp054969;
        Fri, 14 May 2021 08:00:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 38gpq2unxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 May 2021 08:00:42 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 14E80erv009755;
        Fri, 14 May 2021 08:00:41 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 May 2021 01:00:40 -0700
Date:   Fri, 14 May 2021 11:00:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <20210514080033.GG1922@kadam>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
 <20210430114106.GF1981@kadam>
 <YIv92DBnaVotWd9Y@smile.fi.intel.com>
 <20210430133329.GH1981@kadam>
 <YIwSZGE76f2ZJyyf@smile.fi.intel.com>
 <20210503065439.GI1981@kadam>
 <YI/HqpJN+OvYduMn@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YI/HqpJN+OvYduMn@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: rShEuDp_JvfcWmt47591UNL49s6oUw36
X-Proofpoint-ORIG-GUID: rShEuDp_JvfcWmt47591UNL49s6oUw36
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, May 03, 2021 at 12:51:38PM +0300, Andy Shevchenko wrote:
> > Signed ints
> > are safer.
> 
> Any research article about it? What about wrong integral promotions which
> I consider is a root cause of many bugs? People should learn that, or the
> C (standard) should be fixed to make it easier to get.
> 
> > Unsigned ints are a *leading* cause of bugs in the kernel.
> 
> Again, where this statistics comes from? Maybe it's a simple answer to the
> question that review in kernel is not good enough?
> 

When I say that unsigned ints are a leading cause of bug I'm talking
about things like commit 95b079d8215b ("swiotlb: Fix the type of index")
which does this:

-       unsigned int index, i;
+       unsigned int i;
+       int index;

This is perhaps a poor example, because the patch doesn't really fix a
bug.  I don't think that the author thought about how type promotion
works or else the commit would have said "this commit does not change
runtime behavior".

The other reason it's a bad example, is that although a "int i;" would
work here in real life, the correct type is unsigned long i.  The size
of the allocation is specified by the user and allocated at boot with
memblock_alloc() so it might actually be possible to allocate gigabytes
of memory.  I said that earlier, that if you really need an unsigned
list counter then it's pretty likely it should be "unsigned long"
instead of "unsigned int".

But what I get from this example is that people are just declaring
things "unsigned int" for no reason.  I expect that unsigned comparisons
with zero will drop off now that GCC has a compile time warning for
that.  I've been developing the kernel for a decade now and I've
probably had to deal with one of these bugs every ten days on average
over that period.

Meanwhile GCC urges people to declare the list counter as
"unsigned int i;" but I have never seen that fix even a single real
life kernel bug.  I'm not an academic but I have looked for these kinds
of bugs.  GCC warns about it even when it can see at compile time that
the type makes no difference.

There are performance reasons for unsigned types.  Also inside structs
then unsigned ints can make sense.  Also it's nice to declare array
indexes as unsigned because it means that every time you check against
the max, there is a hidden check against negatives because of type
promotion.  But for list counters which start at zero and increment up
then none of that applies.

High level languages like Python don't have signed types.  Pascal had
unsigned types but Niklaus Wirth got rid of them in later programming
languages like Oberon.  Unsigned types and type promotion can help with
performance but they make things more complicated.

regards,
dan carpenter
