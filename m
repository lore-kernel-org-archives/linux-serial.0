Return-Path: <SRS0=OWvP=D5=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22B2C4363A
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 10:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AEF92245F
	for <linux-serial@archiver.kernel.org>; Thu, 22 Oct 2020 10:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G4b3Yu3t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896275AbgJVKEA (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 22 Oct 2020 06:04:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2896273AbgJVKD7 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Oct 2020 06:03:59 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09M9XrWe156161;
        Thu, 22 Oct 2020 06:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=EQmL9vEU86N9RH351Iqo1iK8M30WIr3+tjXBP01jbjY=;
 b=G4b3Yu3tCjw7IdHWzBN6mGT5s+/LcO7BYJ6TGHaIXWLMO3mOLfgWh1/0u8VdeMcNPbKY
 7r0GVZhvyA/h2otWfwbFgnUuqFk4tolEWVmE2CLfiBWumLnhmlhIgfAliYCePf6eiEAn
 ELk3lRWoE+qmkTxhswkMRvrzbMvoV4OFZ2T1LF8+GOC32oypNjrRF4zP/P77sEMLbmjs
 7xe7D4S7c/Sshwc4Xu2sMJCQTyix+PKZD1Lyv1BG+4nbpZNQVR/WyUf5xWWPsN0Z6eSj
 LE57BwhZXAuSyI3DiXQ8jmlCzYN79ijvm/VSvQPr8rNZrbHnddizNdxK/wGUeg+tqiLn aw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b00jvs63-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 06:03:51 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 09M9uhBL025085;
        Thu, 22 Oct 2020 06:03:50 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 34b00jvs3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 06:03:50 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 09MA2SVu019467;
        Thu, 22 Oct 2020 10:03:46 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma05fra.de.ibm.com with ESMTP id 347r882rbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Oct 2020 10:03:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 09MA3hos23003642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Oct 2020 10:03:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1CC69A4054;
        Thu, 22 Oct 2020 10:03:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B92E1A405F;
        Thu, 22 Oct 2020 10:03:42 +0000 (GMT)
Received: from [9.145.63.24] (unknown [9.145.63.24])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 22 Oct 2020 10:03:42 +0000 (GMT)
Subject: Re: [PATCH V7] GCOV: Add config to check the preqequisites situation
To:     Cixi Geng <gengcixi@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        linux-serial@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20200727085132.29754-1-gengcixi@gmail.com>
 <CAF12kFuss4AQZSBX+A2G_fWjka3C4kpf4iDWU9QJY=AWigoxqg@mail.gmail.com>
 <CAF12kFtPQ0bUKrr4X8MjLCTfFYkRVk6BRaLb30W59GwtWQd6xA@mail.gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <46289a56-3f85-fedb-53f2-6328c342f6ce@linux.ibm.com>
Date:   Thu, 22 Oct 2020 12:03:42 +0200
MIME-Version: 1.0
In-Reply-To: <CAF12kFtPQ0bUKrr4X8MjLCTfFYkRVk6BRaLb30W59GwtWQd6xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.737
 definitions=2020-10-22_03:2020-10-20,2020-10-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 spamscore=0
 mlxscore=0 suspectscore=1 bulkscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1011 malwarescore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010220063
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 16.09.2020 14:55, Cixi Geng wrote:
> Hi ALL：
> Not recieve more advise for a long time ,
> Can this submission be merged recently?

First off, sorry for not replying earlier.

I tried out your latest version of this patch and I don't see that my
previous comments have been addressed.

To re-iterate my point: I only see value in introducing a new
GCOV-related config symbol that is automatically selected, depending on
whether (as the name implies) all prerequisites for enabling GCOV-based
kernel profiling have been met. Such a symbol can take away the burden
of duplicating the prerequisite check as has been implemented for
GCOV_PROFILE_ALL.

I see no value in introducing a new config symbol that prompts the user
for a choice.

As it is, your patch introduces a new config symbol that prompts the
user for a choice:

$ make oldconfig
scripts/kconfig/conf  --oldconfig Kconfig
*
* Restart config...
*
*
* GCOV-based kernel profiling
*
Enable gcov-based kernel profiling (GCOV_KERNEL) [Y/n/?] y
Profile entire Kernel (GCOV_PROFILE_ALL) [N/y/?] n
Profile Kernel for prereqs (GCOV_PROFILE_PREREQS) [Y/n/?] (NEW)

We do not need this prompt. Users specify that they want GCOV-profiling
by selecting GCOV_KERNEL. They specify that they want area-specific
profiling in symbols like your proposed SERIAL_GCOV. There is no need
for a user to manually confirm that the prerequisites for enabling
are-specific profiling are met.

I have detailed the required changes that would remove the prompt in my
previous reply. I'll add it here again for your convenience:

>>> +++ b/kernel/gcov/Kconfig
>>> @@ -51,6 +51,16 @@ config GCOV_PROFILE_ALL
>>>         larger and run slower. Also be sure to exclude files from profiling
>>>         which are not linked to the kernel image to prevent linker errors.
>>>
>>> +config GCOV_PROFILE_PREREQS
>>> +       bool "Profile Kernel for prereqs"
>>> +       default y if GCOV_KERNEL && !COMPILE_TEST
>>> +       help
>>> +         This options activates profiling for the specified kernel modules.
>>> +
>>> +         When some modules need Gcov data, enable this config, then configure
>>> +         with gcov on the corresponding modules,The directories or files of
>>> +         these modules will be added profiling flags after kernel compile.
>>> +
> 
> Replace the portion above with these lines:
> 
> config GCOV_PROFILE_PREREQS
>         def_bool y if GCOV_KERNEL && !COMPILE_TEST

And to clarify: by "the portion above" I was referring to all quoted
lines prefixed with a '+' sign.


> 
> Cixi Geng <gengcixi@gmail.com> 于2020年8月20日周四 下午8:40写道：
>>
>> Hi All:
>>
>> Does this patch need more modification?
>>
>> <gengcixi@gmail.com> 于2020年7月27日周一 下午4:51写道：
>>>
>>> From: Cixi Geng <cixi.geng1@unisoc.com>
>>>
>>> Introduce new configuration option GCOV_PROFILE_PREREQS that can be
>>> used to check whether the prerequisites for enabling gcov profiling
>>> for specific files and directories are met.
>>>
>>> Only add SERIAL_GCOV for an example.
>>>
>>> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
>>> ---
>>>  drivers/tty/serial/Kconfig  |  7 +++++++
>>>  drivers/tty/serial/Makefile |  1 +
>>>  kernel/gcov/Kconfig         | 12 ++++++++++++
>>>  3 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>>> index 780908d43557..55b128b6b31d 100644
>>> --- a/drivers/tty/serial/Kconfig
>>> +++ b/drivers/tty/serial/Kconfig
>>> @@ -1576,3 +1576,10 @@ endmenu
>>>
>>>  config SERIAL_MCTRL_GPIO
>>>         tristate
>>> +
>>> +config SERIAL_GCOV
>>> +       bool "Enable profile gcov for serial directory"
>>> +       depends on GCOV_PROFILE_PREREQS
>>> +       help
>>> +         The SERIAL_GCOV will add Gcov profiling flags when kernel compiles.
>>> +         Say 'Y' here if you want the gcov data for the serial directory,
>>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>>> index d056ee6cca33..17272733db95 100644
>>> --- a/drivers/tty/serial/Makefile
>>> +++ b/drivers/tty/serial/Makefile
>>> @@ -3,6 +3,7 @@
>>>  # Makefile for the kernel serial device drivers.
>>>  #
>>>
>>> +GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
>>>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>>>
>>>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
>>> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
>>> index 3110c77230c7..bb2e1fb85743 100644
>>> --- a/kernel/gcov/Kconfig
>>> +++ b/kernel/gcov/Kconfig
>>> @@ -51,4 +51,16 @@ config GCOV_PROFILE_ALL
>>>         larger and run slower. Also be sure to exclude files from profiling
>>>         which are not linked to the kernel image to prevent linker errors.
>>>
>>> +config GCOV_PROFILE_PREREQS
>>> +       bool "Profile Kernel for prereqs"
>>> +       depends on GCOV_KERNEL
>>> +       depends on  !COMPILE_TEST
>>> +       def_bool y if GCOV_KERNEL && !COMPILE_TEST
>>> +       help
>>> +         This options activates profiling for the specified kernel modules.
>>> +
>>> +         When some modules need Gcov data, enable this config, then configure
>>> +         with gcov on the corresponding modules,The directories or files of
>>> +         these modules will be added profiling flags after kernel compile.
>>> +
>>>  endmenu
>>> --
>>> 2.17.1
>>>


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
