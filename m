Return-Path: <SRS0=kmSd=7A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F18C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 10:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DF552081A
	for <linux-serial@archiver.kernel.org>; Mon, 18 May 2020 10:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgERKBB (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 18 May 2020 06:01:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:16908 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726040AbgERKBA (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 18 May 2020 06:01:00 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04I9XRJD057725;
        Mon, 18 May 2020 06:00:52 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cqktmem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 06:00:52 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04I9XcMT058693;
        Mon, 18 May 2020 06:00:52 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 312cqktmd6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 06:00:52 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04I9tRH7001090;
        Mon, 18 May 2020 10:00:49 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3127t5hj8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 May 2020 10:00:49 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04IA0kRR64028906
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 May 2020 10:00:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B7C0F4203F;
        Mon, 18 May 2020 10:00:45 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1BCAF42063;
        Mon, 18 May 2020 10:00:43 +0000 (GMT)
Received: from [9.163.36.73] (unknown [9.163.36.73])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 18 May 2020 10:00:42 +0000 (GMT)
Subject: Re: [RFC][PATCH] GCOV: profile by modules
To:     gengcixi@gmail.com, orsonzhai@gmail.com, zhang.lyra@gmail.com,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Cixi Geng <cixi.geng1@unisoc.com>
References: <20200518080703.22431-1-gengcixi@gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <017a2780-91ea-6d34-4007-959e3014eb6d@linux.ibm.com>
Date:   Mon, 18 May 2020 12:00:41 +0200
MIME-Version: 1.0
In-Reply-To: <20200518080703.22431-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-18_03:2020-05-15,2020-05-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=1 lowpriorityscore=0 clxscore=1011 cotscore=-2147483648
 spamscore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005180086
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 18.05.2020 10:07, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> kernel which will lead to kernel run slower.Use GCOV_PROFILE_MODULES
> to control part of the kernel modules to open gcov.
> 
> Only add SERIAL_GCOV for an example.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>

I'm not convinced that the introduction of a GCOV_PROFILE_MODULES config
symbol in this way is a good idea. The name of the symbol suggests that
this would enabled GCOV profiling for all kernel modules, which is not
the case. In the end it is only an abbreviation for adding the
dependencies required for enabling GCOV profiling for specific modules.

I'd instead suggest the introduction of an automatic symbol
GCOV_PROFILE_PREREQS (or similar) that is enabled when both GCOV_KERNEL
is set, and COMPILE_TEST is not set. There is no need to depend on
ARCH_HAS_GCOV_PROFILE_ALL. The SERIAL_GCOV symbol and other related
symbols of modules that want to introduce similar config options can
then depend on this symbol.

As a reminder, here are the involved symbols and their meaning in the
context of GCOV.

GCOV_KERNEL: You need this to get gcov data out of the kernel
!COMPILE_TESTS: You don't want to enable any GCOV profile during compile
tests due to unwanted side-effects
ARCH_HAS_GCOV_PROFILE_ALL: An architecture has ensured that enabling
full-kernel profiling does not cause any unwanted side-effects. As this
relates to kernel base code only it is not required in the context of
modules.


> ---
>  drivers/tty/serial/Kconfig  |  6 ++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 15 +++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..0b4c070f6c74 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,9 @@ endmenu
>  
>  config SERIAL_MCTRL_GPIO
>  	tristate
> +
> +config SERIAL_GCOV
> +       bool "open gcov for serial"
> +       depends on GCOV_PROFILE_MODULES
> +       help
> +         Say Y here to enable gcov in serial.
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..7be1202286d2 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Makefile for the kernel serial device drivers.
>  #
> +GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
>  
>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3941a9c48f83..7f9c1d2476c9 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,21 @@ config GCOV_PROFILE_ALL
>  	larger and run slower. Also be sure to exclude files from profiling
>  	which are not linked to the kernel image to prevent linker errors.
>  
> +config GCOV_PROFILE_MODULES
> +	bool "Profile Kernel subsytem"
> +	depends on !COMPILE_TEST
> +	depends on GCOV_KERNEL
> +	depends on ARCH_HAS_GCOV_PROFILE_ALL
> +	default n
> +	help
> +	This options activates profiling for the specified kernel modules.
> +
> +	If unsure, say N.
> +
> +	When some modules need Gcov data, enable this config, then configure
> +	with gcov on the corresponding modules configs.The directories or files
> +	of these modules will be added profiling flags after kernel compile.
> +
>  choice
>  	prompt "Specify GCOV format"
>  	depends on GCOV_KERNEL
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
