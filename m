Return-Path: <SRS0=TTKI=74=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD70C433E0
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 09:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5E2065F
	for <linux-serial@archiver.kernel.org>; Mon, 15 Jun 2020 09:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgFOJpp (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:45:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17632 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728626AbgFOJpp (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 15 Jun 2020 05:45:45 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05F82gxE172958;
        Mon, 15 Jun 2020 05:45:36 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31nrequ2ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 05:45:36 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05F9E7dc028852;
        Mon, 15 Jun 2020 05:45:35 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31nrequ2bt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 05:45:35 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05F9fhkD016949;
        Mon, 15 Jun 2020 09:45:33 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 31mpe7haxd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 09:45:33 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05F9jU2V57213136
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 09:45:30 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 80ACAA4057;
        Mon, 15 Jun 2020 09:45:30 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F1CC9A4055;
        Mon, 15 Jun 2020 09:45:27 +0000 (GMT)
Received: from [9.211.71.177] (unknown [9.211.71.177])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jun 2020 09:45:27 +0000 (GMT)
Subject: Re: [RFC PATCH V5] GCOV: Add config to check the preqequisites
 situation
To:     gengcixi@gmail.com, gregkh@linuxfoundation.org, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com,
        Cixi Geng <cixi.geng1@unisoc.com>
References: <20200610021150.19233-1-gengcixi@gmail.com>
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
Message-ID: <77484d44-966a-c3a8-cb81-a2c5776dcc23@linux.ibm.com>
Date:   Mon, 15 Jun 2020 11:45:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200610021150.19233-1-gengcixi@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_01:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=1 phishscore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 cotscore=-2147483648
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006150066
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On 10.06.2020 04:11, gengcixi@gmail.com wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Introduce new configuration option GCOV_PROFILE_PREREQS that can be
> used to check whether the prerequisites for enabling gcov profiling
> for specific files and directories are met.
> 
> Only add SERIAL_GCOV for an example.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/tty/serial/Kconfig  |  8 ++++++++
>  drivers/tty/serial/Makefile |  1 +
>  kernel/gcov/Kconfig         | 15 +++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index adf9e80e7dc9..3d7e811d90dc 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1566,3 +1566,11 @@ endmenu
>  
>  config SERIAL_MCTRL_GPIO
>  	tristate
> +
> +config SERIAL_GCOV
> +	bool "Enable profile gcov for serial directory"
> +	depends on GCOV_PROFILE_PREREQS
> +	default y if GCOV_PROFILE_PREREQS

I think the choice to enable each specific profiling symbol should not
be automated based on the PREREQS symbol. This should be a purely manual
setting with a depends relation on the PREREQS.

The logic should be:
- if the requirements are met
- then provide a way for users to manually enable each specific gcov
  profiling site

Otherwise you would be duplicating the meaning of CONFIG_GCOV_PROFILE_ALL.

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
> index 3941a9c48f83..35b839879553 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -51,6 +51,21 @@ config GCOV_PROFILE_ALL
>  	larger and run slower. Also be sure to exclude files from profiling
>  	which are not linked to the kernel image to prevent linker errors.
>  
> +config GCOV_PROFILE_PREREQS
> +	bool "Profile Kernel for prereqs"
> +	depends on !COMPILE_TEST
> +	depends on GCOV_KERNEL
> +	depends on !COMPILE_PROFILE_ALL
> +	default y if GCOV_KERNEL && !COMPILE_TEST

This mix of depends and "default if" is confusing. As I mentioned in my
previous e-mail, the "default if" should be sufficient for an automatic
symbol, so the "depends" statements can be removed.

> +	help
> +	  This options activates profiling for the specified kernel modules.
> +
> +	  When some modules need Gcov data, enable this config, then configure
> +	  with gcov on the corresponding modules,The directories or files of
> +	  these modules will be added profiling flags after kernel compile.
> +
> +	  If unsure, say N.

What reason is there for a user to manually set this to N? In my opinion
the only use case where this symbol makes sense is as an automatic
config symbol that can be used by other symbols that enable specific
GCOV profiling sites via a "depends" relation. The PREREQ symbol
indicates that is is ok to provide the manual choice of enabling such
profiling.

> +
>  choice
>  	prompt "Specify GCOV format"
>  	depends on GCOV_KERNEL
> 


-- 
Peter Oberparleiter
Linux on Z Development - IBM Germany
