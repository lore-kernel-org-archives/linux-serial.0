Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50585C433B4
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 06:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29CCB61353
	for <linux-serial@archiver.kernel.org>; Mon,  3 May 2021 06:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhECGzu (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 3 May 2021 02:55:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:56732 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbhECGzu (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 3 May 2021 02:55:50 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1436irlv065460;
        Mon, 3 May 2021 06:54:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JlhEy6BLamQT34tv7RSaESpgJj8TtY85j9ouuExvNfI=;
 b=MKEAW5xr92ZaQuDMQpzorC6mjOqDRdhMW3SlxU/3JnHP5hyH13DGqZUezrjapPuJRoS/
 kmk0w3ycfRuh24b1EypeErkIuGsBPzUGUwpnsovjCaXH1XrX6SZwhvTQace79QoAXWcL
 C8sW/5+SONI97NteTEEsJzcAYdkw2ON1loiUTCuPsW23CWjghkPPdlI40EHLlOBctuoo
 9b/iotfp/8xX3ZKvNKRCJBohAvxiUZgKJR4q5YEoXyEalGzWXk5w4cYwZTnbHUMpb/0a
 1HiDD3Tuln9R9vUmrw9lAH8tLkduhYTcFC13R6Om7USh1xEmOp2xwaMPV5JVQayrBID+ 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 389h13sj4n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 06:54:50 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1436jDoo072715;
        Mon, 3 May 2021 06:54:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 389grqacmv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 06:54:50 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1436snth111915;
        Mon, 3 May 2021 06:54:49 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 389grqacm5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 May 2021 06:54:49 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 1436sljv005239;
        Mon, 3 May 2021 06:54:48 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 02 May 2021 23:54:47 -0700
Date:   Mon, 3 May 2021 09:54:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_omap: fix a timeout loop condition
Message-ID: <20210503065439.GI1981@kadam>
References: <YIpd+kOpXKMpEXPf@mwanda>
 <YIqTvcZ6ZrAEL7WE@smile.fi.intel.com>
 <20210429130215.GE21598@kadam>
 <YIvDz7hEhwm66R8G@smile.fi.intel.com>
 <20210430114106.GF1981@kadam>
 <YIv92DBnaVotWd9Y@smile.fi.intel.com>
 <20210430133329.GH1981@kadam>
 <YIwSZGE76f2ZJyyf@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIwSZGE76f2ZJyyf@smile.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: XpUtu-1uT8FT1W1OotD-YguKsTcZ5TPY
X-Proofpoint-GUID: XpUtu-1uT8FT1W1OotD-YguKsTcZ5TPY
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9972 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 spamscore=0 mlxscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2105030046
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 30, 2021 at 05:21:24PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 30, 2021 at 04:33:29PM +0300, Dan Carpenter wrote:
> > On Fri, Apr 30, 2021 at 03:53:44PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 30, 2021 at 02:41:06PM +0300, Dan Carpenter wrote:
> > > > On Fri, Apr 30, 2021 at 11:46:07AM +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > > Why would I make it unsigned?  As a static analysis developer,
> > > > pointlessly unsigned variables are one of the leading causes for the
> > > > bugs I see.
> > > > 
> > > > There are times where a iterator counter needs to be unsigned long, or
> > > > u64 but I have never seen a case where changing an iterator from
> > > > "int i;" to "unsigned int i;" solves a real life kernel bug.  It only
> > > > introduces bugs.
> > > 
> > > See my followup to that, I meant
> > > 
> > > unsigned int count;
> > > 
> > > do {
> > > 	...
> > > } while (--count);
> > > 
> > > It doesn't solve bug, but prevents the code be read incorrectly like what you
> > > are fixing can be avoided with do {} while (); along with unsigned type.
> > 
> > Why would you use an unsigned int for this???
> 
> Why it should be signed? You clearly show the amount of iterations. Check for
> null I guess even compact in the assembly in comparison to -1.
> 
> I do not see any point why it should be signed. For what purpose?
> 
> It's a *down* counter.

Yeah.  And people regularly test down counters for >= 0.  Signed ints
are safer.  Unsigned ints are a *leading* cause of bugs in the kernel.
I don't know if they're in the top five but they're definitely in the
top ten.

Also if you need a larger type you should switch to a 64 bit type.  The
2-4 million range is very narrow.

I have never seen a single kernel bug where the for loop counter was
"int i;" and making it "unsigned int i;" fixed a real life kernel bug.
Of course, there are times when unsigned int is appropriate, like for
sizes or because it's in the spec.

It's frustrating to me because GCC encourages people to make loop
counters unsigned and it introduces bugs.

I'm looking at the git log right now and I see that someone changed:

 void dt_to_asm(FILE *f, struct dt_info *dti, int version)
 {
        struct version_info *vi = NULL;
-       int i;
+       unsigned int i;
        struct data strbuf = empty_data;
        struct reserve_info *re;
        const char *symprefix = "dt";

There are two loops in that function:

	for (i = 0; i < ARRAY_SIZE(version_table); i++) {

This the one that generates the warning.  GCC knows at compile time that
ARRAY_SIZE() is 5.  ARGH!!!  GCC is so lazy and horrible.  If I did this
in Smatch people would never accept it.  Even if ARRAY_SIZE() were
higher than INT_MAX the loop would behave the same regardless of whether
it was signed or not because of type promotion.

The other loop is:

	for (i = 0; i < reservenum; i++) {

In this case "reservenum" comes from the command line.  In the original
code if it were negative that would be a harmless no-op but now because
i is unsigned it's a crashing bug.  Why did GCC not generate a warning
for this?  The code was obviously bad before, that's true, but now in a
very measurable way it has become worse.

This example is not really important.  I only brought it up because it
is most recent example of people changing "int i;" to "unsigned int i;".
But there have been other cases like this which have had a security
impact.

regards,
dan carpenter
