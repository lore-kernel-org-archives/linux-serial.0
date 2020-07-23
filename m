Return-Path: <SRS0=2ftc=BC=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6437DC433E0
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 09:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 478D420825
	for <linux-serial@archiver.kernel.org>; Thu, 23 Jul 2020 09:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGWJsL (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:48:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11995 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgGWJsL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 23 Jul 2020 05:48:11 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06N9XWE8045943;
        Thu, 23 Jul 2020 05:47:55 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yc0v15-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:47:55 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06N9XwQK047495;
        Thu, 23 Jul 2020 05:47:55 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1yc0v0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 05:47:55 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06N9fL8G013581;
        Thu, 23 Jul 2020 09:47:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgu5q0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Jul 2020 09:47:52 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06N9loTk29360560
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 09:47:50 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8FF52052;
        Thu, 23 Jul 2020 09:47:50 +0000 (GMT)
Received: from [9.145.184.33] (unknown [9.145.184.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id A543052057;
        Thu, 23 Jul 2020 09:47:49 +0000 (GMT)
Subject: Re: [PATCH V6] GCOV: Add config to check the preqequisites situation
To:     Cixi Geng <gengcixi@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Cixi Geng1 <cixi.geng1@unisoc.com>,
        Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com
References: <20200618100852.13715-1-gengcixi@gmail.com>
 <2fae67c7637f4e978cb54c3b96090788@BJMBX01.spreadtrum.com>
 <CAF12kFseC4MMbEUk6CgW=Hpz_Hg-+fjwbLZKFdPu0K_EGtcPDw@mail.gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <a5c4018c-a0fd-7855-1ee9-dc0c4e7251e7@linux.ibm.com>
Date:   Thu, 23 Jul 2020 11:47:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAF12kFseC4MMbEUk6CgW=Hpz_Hg-+fjwbLZKFdPu0K_EGtcPDw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-23_03:2020-07-22,2020-07-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=1 bulkscore=0 adultscore=0 clxscore=1011
 priorityscore=1501 mlxscore=0 mlxlogscore=999 phishscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007230072
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16.07.2020 14:38, Cixi Geng wrote:
> Hi All:
> Does this patch need more modification?

Yes. As it is now there's still a prompt for the prereq symbol. There
should be no prompt for this symbol in the config dialog.

[...]


>> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
>> index 3941a9c48f83..f415c4aaf0ab 100644
>> --- a/kernel/gcov/Kconfig
>> +++ b/kernel/gcov/Kconfig
>> @@ -51,6 +51,16 @@ config GCOV_PROFILE_ALL
>>         larger and run slower. Also be sure to exclude files from profiling
>>         which are not linked to the kernel image to prevent linker errors.
>>
>> +config GCOV_PROFILE_PREREQS
>> +       bool "Profile Kernel for prereqs"
>> +       default y if GCOV_KERNEL && !COMPILE_TEST
>> +       help
>> +         This options activates profiling for the specified kernel modules.
>> +
>> +         When some modules need Gcov data, enable this config, then configure
>> +         with gcov on the corresponding modules,The directories or files of
>> +         these modules will be added profiling flags after kernel compile.
>> +

Replace the portion above with these lines:

config GCOV_PROFILE_PREREQS
        def_bool y if GCOV_KERNEL && !COMPILE_TEST



-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
