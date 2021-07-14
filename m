Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F6BC11F67
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 16:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2E061154
	for <linux-serial@archiver.kernel.org>; Wed, 14 Jul 2021 16:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbhGNRAF (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 14 Jul 2021 13:00:05 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:33562 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229610AbhGNRAF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 14 Jul 2021 13:00:05 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16EGsC9Y005357;
        Wed, 14 Jul 2021 16:56:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pps0720; bh=OU0xvqHLVbrZtJdx8y7PIoaz65fuHGWMPFnWOows+Vs=;
 b=L/EmNUuiln+yfyYY++YgTlHBRRTBQA5wdBJfMxetyDQvX2EfMxodkVRL1sgJwtpezQ4y
 6md+E6DdesZ8t6o55uP8mHfbuo3HvflONP9bsVWTsEQvMfimBZIy+LF+4R6xOZG8OWgz
 XJ8Iy9WFfPjZ4GoGZG2jWvvWkfBwwe0W29ZuihyDeJfylm2FzHVtsVUe5FWPbfjkFGkW
 fDiLU00g4aJyTIfPTMLLJbQxa4+GYigBiHVaj0DjOd1BR8LvquWiLWPzqGqbRPpIkEjK
 +H4PlYv15tOs0aJ80PbinwyIDXne7LYbqJ+kS4Semw3AvCrHuwaNmt8XivSMuv6r9r0n Rg== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0a-002e3701.pphosted.com with ESMTP id 39t1x719se-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Jul 2021 16:56:27 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 113A94F;
        Wed, 14 Jul 2021 16:56:27 +0000 (UTC)
Received: from rfwz62 (rfwz62.americas.hpqcorp.net [10.33.237.8])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 4BB9F4F;
        Wed, 14 Jul 2021 16:56:26 +0000 (UTC)
Date:   Wed, 14 Jul 2021 10:56:26 -0600
From:   rwright@hpe.com
To:     Andy Shevchenko <andy.shevchenko@gmail.com>, jirislaby@kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>
Subject: Re: [PATCH v1 3/4] serial: 8250_pci: Always try MSI/MSI-X
Message-ID: <20210714165626.GA23625@rfwz62>
Reply-To: rwright@hpe.com
References: <20210713104026.58560-1-andriy.shevchenko@linux.intel.com>
 <20210713104026.58560-3-andriy.shevchenko@linux.intel.com>
 <9af24b96-8119-7ccf-f0d0-d725af80aa0b@kernel.org>
 <CAHp75VeuG08M9nURpEmW79euKSJkYvLnFiUe+6cGpRHL4zUOfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeuG08M9nURpEmW79euKSJkYvLnFiUe+6cGpRHL4zUOfw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: KJRQEOQPyum_FWZ5pgKIWxwzVYLJC7iw
X-Proofpoint-ORIG-GUID: KJRQEOQPyum_FWZ5pgKIWxwzVYLJC7iw
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_10:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 clxscore=1011 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107140101
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Wed, Jul 14, 2021 at 12:15:25PM +0300, Andy Shevchenko wrote:
> On Wed, Jul 14, 2021 at 9:55 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> ...
> Thanks, but I still think that blacklisting is better. All drivers I
> have split (or participated in splitting) from 8250_pci have enabled
> MSI for the entire subset they serve for.
> ...
> Thanks. I also added Randy, who extended the list.

My own opinion is that a whitelist to enroll devices as they are tested
is the safer approach, for the reason that getting test coverage on many
of the older devices would be difficult.  For example, I see id's of HP
devices in the code that are probably 20 years old, and I doubt whether
there are operational examples inside HPE today.

That said, I can offer to test that a new patch to 8250_pci.c works on
the device I recently added.  Please cc me directly if that is helpful,
as I don't always read the mailing lists such as linux-serial promptly.

-- 
Randy Wright - Hewlett Packard Enterprise - rwright@hpe.com
