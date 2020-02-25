Return-Path: <SRS0=8zSm=4N=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD83C4BA01
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 22:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D820732
	for <linux-serial@archiver.kernel.org>; Tue, 25 Feb 2020 22:50:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O02PY5AG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgBYWuK (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 25 Feb 2020 17:50:10 -0500
Received: from mail-pg1-f172.google.com ([209.85.215.172]:33097 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgBYWuK (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 25 Feb 2020 17:50:10 -0500
Received: by mail-pg1-f172.google.com with SMTP id 6so293812pgk.0
        for <linux-serial@vger.kernel.org>; Tue, 25 Feb 2020 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:reply-to:to:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=83bHg/YT0hEy5GxurFwfNFcbGuT1Njz+oDa7dWuT9LI=;
        b=O02PY5AGiUHahmchS+DozM91V1uC9EUmmwlZgMOKhkhIIFnF2/uC+H5jNX1o/Kx5T3
         wADKZYg2fFBtMtlEqaynlZzBCxeV3xAmejzIussFQSiVmCV3w711ZWAptcTTcfPxpJbB
         7wiek5kWEUgdB3xnG57KYNeJwjoUb4Zax4VsKmmuDrSX5LE09/alJW2cruKubdeM4EIo
         WeRjaTpKYGG9skdbc3OPxPXK1Xt+ZRWKCRSJp1P6hO+bAkCW11p6BAdRUH+yVw3P8Le6
         eE1CdNVThTkIeESThrGiNkjI/wz4d1KHRJJWVkVCZRdgCTNpK0mGjrRE6NzMtMJKMNgc
         Ix3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:reply-to:to:message-id:date
         :user-agent:mime-version:content-language:content-transfer-encoding;
        bh=83bHg/YT0hEy5GxurFwfNFcbGuT1Njz+oDa7dWuT9LI=;
        b=O4G+Iafjkezi/hs9pVVGP95m86Sd21Xjr3eIEM784E35t+ZxNnzMHn3hcweKXZeafS
         N/5wOc9ExxNehZARKdIZu6CMIRCk85Z7NINTRj0cP2fEBiAMfbzVOxL9kwn1i/5NIzSE
         aEB0auhxloCUw7o+vHHBDpOVn7y1tjoiRu41RjLkiCI3VGviCR+qfndOB6O9VqUwvxlY
         M4S+oKQJMC+oyWg5LOjr0ilKeFyrgbfPE0qSWGPbFiafsHpHpjmdGzQpxVsbIt8RiFcK
         BqVejUeXdexQ9exaBRxcHl6F4xAw5YgAdtqd80H8Qp1ZbifuOC1mIvoyMbZZQu6W5Nkq
         AVYw==
X-Gm-Message-State: APjAAAVNomnLvEIvkAXxeu9OeF0cRN6ZTMTlvYVm35HVLMjXAYdKhi0O
        1lGgG8b0+qJ4MYYZ6luiYN+PHUXV
X-Google-Smtp-Source: APXvYqwpgHCymjQwpWD+0tlCb87KqO9PzXbRgLRKMbRQ74h7hZ2oOd8GBTlLAbk3YxFjj7Ask+esZA==
X-Received: by 2002:aa7:8096:: with SMTP id v22mr1017854pff.240.1582671008974;
        Tue, 25 Feb 2020 14:50:08 -0800 (PST)
Received: from mua.localhost (99-7-172-215.lightspeed.snmtca.sbcglobal.net. [99.7.172.215])
        by smtp.gmail.com with ESMTPSA id h22sm52219pgn.57.2020.02.25.14.50.08
        for <linux-serial@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 14:50:08 -0800 (PST)
From:   PGNet Dev <pgnet.dev@gmail.com>
Subject: serial console output on UEFI hardware ... inconsistent CR/LF
 behavior; starts & finishes OK, broken in the middle ... ?
Reply-To: pgnet.dev@gmail.com
To:     linux-serial@vger.kernel.org
Message-ID: <f543c472-8574-f167-eb43-6cc74b8bd6ef@gmail.com>
Date:   Tue, 25 Feb 2020 14:50:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I'm switching a server to UEFI boot -- and bumping into issues with serial console config

running on

	uname -rm

		5.5.6-24.g4a830b1-default x86_64


with

	grub2-install --version
		grub2-install (GRUB2) 2.04

my grub config currently includes,

	GRUB_TERMINAL_OUTPUT="gfxterm serial"
	GRUB_SERIAL_COMMAND="serial --unit=0 --speed=115200 --parity=n --word=8 --stop=1"
	GRUB_CMDLINE_LINUX=" ... \
	 console=tty0 console=ttyS0,115200n81 \
	 earlyprintk=serial,ttyS0,115200,keep"

i.e.,

	cat /proc/cmdline
		BOOT_IMAGE=/vmlinuz-5.5.6-24.g4a830b1-default i915.modeset=1 acpi_osi=Linux  systemd.log_level=info systemd.log_target=kmsg log_buf_len=1M printk.devkmsg=on console=tty0 console=ttyS0,115200n81 earlyprintk=serial,ttyS0,115200,keep ...

Connected to the serial console from a local desktop running 'minicom', output _does_ appear as expected.

However, formatting -- specifically carriage returns / line feeds -- _starts_ out OK, and _finishes_ OK once reaching the login prompt, and after.

But, in the 'middle', CRs/LFs go cause loss of display on serial console.
Here's what I see in desktop's 'minicom' connected to server's serial port:

	https://pastebin.com/raw/KNB2JDHM

What needs to be configured to get the serial console to output consistently 'well behaved' formatting from start of output to login prompt, and onward?




