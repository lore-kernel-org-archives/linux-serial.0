Return-Path: <SRS0=xb/S=EF=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08AEC4363A
	for <linux-serial@archiver.kernel.org>; Fri, 30 Oct 2020 10:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAE620825
	for <linux-serial@archiver.kernel.org>; Fri, 30 Oct 2020 10:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l2ifPTg/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgJ3KZj (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 30 Oct 2020 06:25:39 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7532 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725948AbgJ3KZj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 30 Oct 2020 06:25:39 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09UA9m60136302;
        Fri, 30 Oct 2020 06:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=BAtE6Ob70yoHPBs9fGXumLJu/pahuZYKYKpQlaPGQ64=;
 b=l2ifPTg/kS+mEKGybalkN/9dmaPNBtWpmrJrXOvBn6pDa5l9Cp1U09OTlT8Ov4AI3W6w
 7ybEaSjyIWQUyQT28jtCrcHNUF356IF6RfECkRDuuWwZnkWFAY9qP2BcPvU0sa/OV00w
 I5dY3+6EjaZQy22M5PufDk8mQ2lrYAxJNLbq42sudy7pwuCMDooADXzpi0dH06P0N9At
 N9XbtN0Jam7maRsbLnVdBQVRe5zHUM70XN2dnmgGzxZL3I0tIdr9TEyKyAEt78G5vC/l
 n95AyuCe06B+7pRotF2SkOMfZj89ZDKhUOO9Mny+ETGA25FUap/Yof+lnCJq6j8paRZQ Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34fww7xdbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 06:25:29 -0400
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09UAEu7o159555;
        Fri, 30 Oct 2020 06:25:29 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34fww7xdb2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 06:25:29 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09UAMet4024766;
        Fri, 30 Oct 2020 10:25:26 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06ams.nl.ibm.com with ESMTP id 34g41xrmm1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Oct 2020 10:25:26 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09UAPOqT28901670
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Oct 2020 10:25:24 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B4304204F;
        Fri, 30 Oct 2020 10:25:24 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0922F4205F;
        Fri, 30 Oct 2020 10:25:24 +0000 (GMT)
Received: from [9.145.145.233] (unknown [9.145.145.233])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 30 Oct 2020 10:25:23 +0000 (GMT)
Subject: Re: [PATCH V8] GCOV: Add config to check the preqequisites situation
To:     gengcixi@gmail.com, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20201028131505.482037-1-gengcixi@gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <fb2bbd79-e17a-775e-6f2b-d97acd69b50f@linux.ibm.com>
Date:   Fri, 30 Oct 2020 11:25:24 +0100
MIME-Version: 1.0
In-Reply-To: <20201028131505.482037-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-10-30_01:2020-10-30,2020-10-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 spamscore=0
 clxscore=1011 mlxscore=0 priorityscore=1501 phishscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010300075
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 28.10.2020 14:15, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Introduce new configuration option GCOV_PROFILE_PREREQS that can be
> used to check whether the prerequisites for enabling gcov profiling
> for specific files and directories are met.
> 
> Only add SERIAL_GCOV for an example.

[...]

> +config GCOV_PROFILE_PREREQS
> +	bool "Profile Kernel for prereqs"
> +	def_bool y if GCOV_KERNEL && !COMPILE_TEST
> +	help
> +	  This options activates profiling for the specified kernel modules.
> +	  When some modules need Gcov data, enable this config, then configure
> +	  with gcov on the corresponding modules,The directories or files of
> +	  these modules will be added profiling flags after kernel compile.
> +
>  endmenu

This version still produces a prompt during make oldconfig. You need to
remove the "bool" line and the "help" lines.

Before sending another version please test it to make sure that it does
not produce a prompt.


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
