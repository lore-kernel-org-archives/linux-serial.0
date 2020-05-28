Return-Path: <SRS0=aTVb=7K=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED70BC433DF
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEBF0207D3
	for <linux-serial@archiver.kernel.org>; Thu, 28 May 2020 14:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rveLcDkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728568AbgE1OsJ (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 May 2020 10:48:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40778 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728539AbgE1OsF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 May 2020 10:48:05 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SEbbVa101207;
        Thu, 28 May 2020 10:47:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UkbfAtvEfXUxa95+1LdoiI+mLq8Rx3rpSz0ltaUwu8I=;
 b=rveLcDkQKVDI8mst8gdty89143smgC7dB/bM4EBmyiicnMgvOG2fCJdEkVp6nZMDT6FT
 1WC80pBGqzyfVDCHeMuHh08lAlvYIT5PAiXNRGnkajSuZ43+asrFX3ewsU6ABn2AIrX1
 6uVZrwTw+itBQp/F2/JhXiKA4FwGol/Txc5bk4uBADTnPXkK9pi0aEIcwTDghir2juwk
 kaOveRRPleyER/dZEkzkReWsKTL+x250H4W7a5cpuRFgJQM1ymjKYlhcdUWKv4UdpNhp
 R+5KCuS9d85JFXILuXgM04MBSr/6Mu22/Mh8Rn3XGNWfVOLuL5TWgDfzf4wtpO1vBmNq hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31a9nbcbjr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:47:46 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 04SEbgLj101542;
        Thu, 28 May 2020 10:47:46 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 31a9nbcbj2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 10:47:46 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SEjMIb030278;
        Thu, 28 May 2020 14:47:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 316uf8a43u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 14:47:44 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SElguG40632372
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 14:47:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 49A9F4203F;
        Thu, 28 May 2020 14:47:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AD6B042042;
        Thu, 28 May 2020 14:47:39 +0000 (GMT)
Received: from [9.163.54.87] (unknown [9.163.54.87])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 May 2020 14:47:39 +0000 (GMT)
Subject: Re: [RFC PATCH v4] GCOV: profile by modules
To:     gengcixi@gmail.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20200525100054.17700-1-gengcixi@gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <917da283-5f1e-3fdb-13bb-4251312dc77a@linux.ibm.com>
Date:   Thu, 28 May 2020 16:47:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200525100054.17700-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 cotscore=-2147483648 suspectscore=1 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005280097
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 25.05.2020 12:00, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The CONFIG_GCOV_PROFILE_ALL will compile kernel by profiling entire
> kernel which will lead to kernel run slower.Use GCOV_PROFILE_PREREQS
> to control part of the kernel modules to open gcov.

Maybe rephrase the commit message to make the intention more obvious:

Introduce new configuration option GCOV_PROFILE_PREREQS that can be used
to check whether the prerequisites for enabling gcov profiling for
specific files and directories are met.

> 
> Only add SERIAL_GCOV for an example.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig  |  7 +++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 14 ++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..6df002370f18 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,10 @@ endmenu
>  
>  config SERIAL_MCTRL_GPIO
>  	tristate
> +
> +config SERIAL_GCOV
> +	bool "Enable profile gcov for serial directory"
> +	depends on GCOV_PROFILE_PREREQS
> +	help
> +	  The SERIAL_GCOV will add Gcov profiling flags when kernel compiles.
> +	  Say 'Y' here if you want the gcov data for the serial directory,
> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> index d056ee6cca33..17272733db95 100644
> --- a/drivers/tty/serial/Makefile
> +++ b/drivers/tty/serial/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for the kernel serial device drivers.
>  #
>  
> +GCOV_PROFILE := $(CONFIG_SERIAL_GCOV)
>  obj-$(CONFIG_SERIAL_CORE) += serial_core.o
>  
>  obj-$(CONFIG_SERIAL_EARLYCON) += earlycon.o
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3941a9c48f83..ea8b514f5676 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,20 @@ config GCOV_PROFILE_ALL
>  	larger and run slower. Also be sure to exclude files from profiling
>  	which are not linked to the kernel image to prevent linker errors.
>  
> +config GCOV_PROFILE_PREREQS
> +	bool "Profile Kernel subsytem"
> +	depends on !COMPILE_TEST
> +	depends on GCOV_KERNEL
> +	depends on !GCOV_PROFILE_ALL
> +	help
> +	  This options activates profiling for the specified kernel modules.
> +
> +	  When some modules need Gcov data, enable this config, then configure
> +	  with gcov on the corresponding modules,The directories or files of
> +	  these modules will be added profiling flags after kernel compile.
> +
> +	  If unsure, say N.

This is not quite what I had in mind. A user still needs to manually
select GCOV_PROFILE, then GCOV_PROFILE_PREREQS, then SERIAL_GCOV.

My though was that you could provide an automatic config option that is
invisible in the configuration dialog, and that is automatically
selected when all prereqs for enabling GCOV in a module directory are met.

Something like the following:

config GCOV_PROFILE_PREREQS
        bool
        default y if GCOV_KERNEL && !COMPILE_TEST
        default n

There's no need to add GCOV_KERNEL_ALL here since that is about a user
choice ("I want all code compiled with profiling") vs. this new symbol
which is about an ability ("all prereqs for enabling profiling in
specific directories are met).


> +
>  choice
>  	prompt "Specify GCOV format"
>  	depends on GCOV_KERNEL
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
