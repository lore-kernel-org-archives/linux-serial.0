Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153FC433EF
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FF56610C8
	for <linux-serial@archiver.kernel.org>; Thu, 21 Oct 2021 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhJUOMx (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 21 Oct 2021 10:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhJUOMx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 21 Oct 2021 10:12:53 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEF5C0613B9
        for <linux-serial@vger.kernel.org>; Thu, 21 Oct 2021 07:10:37 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id bl14so1604334qkb.4
        for <linux-serial@vger.kernel.org>; Thu, 21 Oct 2021 07:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-clemson-edu.20210112.gappssmtp.com; s=20210112;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rJ+iKrfJ1JfZEZlWe09r6mEOzr6mgv4XOLfyKp7fhK8=;
        b=pt5YkZU+TKH4tub6mfBn5glZlVj5MsO9YD2dn4ZSx5IpcAepv7l6EixrSW8NHNMFyw
         vJtQTfGpBMQaUZiGnhE2QHOJP351PqCbrfQG4UeCn50aqstuzDy5njTx/WrZ0W3Ic5hc
         G2z1MrRsdeNIs5dnCmLAEMwgBUKNv3glc1WZvWGyUu4azNtNvw/uO1wJmxdO/T2cHmqX
         20z3Dk+j+Ol4F+OYFelY5yqNt7TowoJ2AdIirFlGxpt92MvkhKb6rvNUaYIGziK5SFlu
         G47FI/s7Eb4m9vV4hY3NjcU6TM2nabCBbtuUXrFGla8n/IESR+k59emeGYp8RYji+GXq
         x+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rJ+iKrfJ1JfZEZlWe09r6mEOzr6mgv4XOLfyKp7fhK8=;
        b=HFNndVw8P4tcTdE8Re3tlW1+KLMuSvsG6geVCcPsGtmTQsvZQGJwAapsncjmoYpXaB
         IJKj8a0M6FcABTYvZcDT3l0IXzEt7XYqdcEFbaJNbLBQPvvSJ3ukAyHAHtHxqjFZYkUP
         eJGUjo/NhKVpDjSsyG5SUYx8LzB0xZLwYQknqyXZ+tHdIF5Ut5DuwOTWrrgPQt1X6Rlt
         PElTvMDuUqMAsij4Wz4pmWOsywHwUifVYpXl2GdBI+B4b38P9ZlswGU5qIrtRwb9Gntq
         vQZE3JQSjPgABBZwQlnb0fQb7o3accOqsLXL8dbGC3SC9eOC/L13W1wiWfSJ9vkWfeEA
         jLYQ==
X-Gm-Message-State: AOAM5330vDeD4jwERjernxC6Pv+iKTc+PcNElrbB1kXW8/3LPZkfK6uw
        x2fbuEnecWZt+CejvHOow2gI7PdiQ9Z8x44w
X-Google-Smtp-Source: ABdhPJz2JCtybAaIA99P0bQ9c5jOwZrOEld9buNIhbxaSJpUO0ZXNE2mvzNgMtIkkA+CD/gKN+JpxA==
X-Received: by 2002:a37:42c2:: with SMTP id p185mr4563255qka.318.1634825436414;
        Thu, 21 Oct 2021 07:10:36 -0700 (PDT)
Received: from SLTS-20200428.int.sealevel.com ([12.18.222.51])
        by smtp.gmail.com with ESMTPSA id g1sm2492880qkd.89.2021.10.21.07.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 07:10:36 -0700 (PDT)
From:   mrhowel@g.clemson.edu
X-Google-Original-From: matthew.howell@sealevel.com
Date:   Thu, 21 Oct 2021 10:10:30 -0400 (EDT)
X-X-Sender: ts-test@SLTS-20200428.int.sealevel.com
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
cc:     Matthew Howell <matthew.howell@sealevel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Ryan Wenglarz <ryan.wenglarz@sealevel.com>
Subject: Re: Possible issue with RS485 IOCTLs on 16C950 UARTs?
In-Reply-To: <YXEdFPyvpnBCeoxt@kroah.com>
Message-ID: <alpine.DEB.2.22.394.2110211004030.10664@SLTS-20200428.int.sealevel.com>
References: <BY5PR05MB7092A78C7C3441240685522DF9BE9@BY5PR05MB7092.namprd05.prod.outlook.com> <YXEdFPyvpnBCeoxt@kroah.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


That noticed is enforced by our exchange server. I have removed it by 
using an external email address instead.

Original message is copied below.

Hi,

I'm not sure if this is the right place for this, but hopefully someone 
can help me figure out what else I can do to troubleshoot this problem, or 
point me to the right place to ask questions about this.

A recent investigation led us to discover issues related to the RS485 
IOCTLs on our serial cards utilizing the 16C950 UART. More specifically, 
the TIOCSRS485 IOCTL to set the serial_rs485 flags as documented at 
https://www.kernel.org/doc/html/latest/driver-api/serial/serial-rs485.html 
.

When attempting to set the SER_RS485_ENABLED flag using TIOCSRS485 as per 
below I receive an error code 25, "Inappropriate IOCTL for device"

	/* -----RS485----- */
	struct serial_rs485 rs485conf = {0};
	rs485conf.flags |= SER_RS485_ENABLED;
	rc = ioctl(fd, TIOCSRS485, &rs485conf);
	if (rc < 0) {
        	printf("error=%d %s\n", errno, strerror(errno));
		return rc;
	}

From what I've read this typically indicates an unsupported serial device, 
but the documentation mentions the 16C950 UART as a specific example, so I 
would think the kernel is intended to support this functionality on the 
16C950. 
 
I have tried this across several kernel versions: 3.10 (Centos 7) , 4.18 
(Centos 8), and 5.11 (Ubuntu 21.04) with no change in the behavior. 
The issue was originally discovered on a PLX OXPCIe952 UART, but has been 
replicated on 'standard' OX16C950 UARTs as well. setserial -ag correctly 
identifies all cards as 16950's (Specifically "16950/954").

Has anyone else had or seen this IOCTL issue on the 16C950? Are there any 
'known good' 16C950 based cards people can confirm that this works with?

Let me know if you need any more details/testing. I also tried to 
configure my email client to behave nicely with the mailing list. Does it 
seem ok?

P.S, I also tried using 3rd party libraries that support the RS485 flags, 
such as 
https://pyserial.readthedocs.io/en/latest/pyserial_api.html#rs485-support, 
in case there was something broken in my C application, but I get the same 
error.

Thanks,
Matthew Howell
Applications Engineer
Sealevel Systems, Inc



On Thu, 21 Oct 2021, gregkh@linuxfoundation.org wrote:

> On Wed, Oct 20, 2021 at 08:44:54PM +0000, Matthew Howell wrote:
> > Confidentiality Notice This message is intended exclusively for the individual or entity to which it is addressed. This communication may contain information that is PROPRIETARY, TRADE SECRET, PRIVILEGED, CONFIDENTIAL or otherwise legally exempt from disclosure. If you are not the named addressee, you are not authorized to read, print, retain, copy or disseminate this message or any part of it. If you have received this message in error, please notify the sender immediately either by phone (864.843.4343) or reply to this e-mail and delete all copies of this message.
> 
> Now deleted.
> 
