Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90424C2D0EF
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 05:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFD920857
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 05:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JajKd4JF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407080AbgDPF7D (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 01:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407021AbgDPF7B (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 01:59:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99FCC061A0C;
        Wed, 15 Apr 2020 22:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=y8YseLI+ypx/GuXd2xC6IFiQ9Bn9G3aicBxjrVrERP8=; b=JajKd4JFYkO+jrP5Rl+SiLHFti
        S4z+Gt4T7j5kRceZDxvypJYQYiqYDfpPN86Bmp6fiSP4zMsDZ0GBz68yaubrZRA+2h841auyAKIOx
        0dNRu0n5uGDONEOv9Z3Nk5XJp6EsRKFXvDoqF28mYopKGz1WG4VFZrl7WIuzQcH7wZriu+KpkKwcX
        j3RrpeoCjL+A17AGGhbLMFB29tzya0xAs+osTVAbnNkJ+L3BfkGLdjAn471lsTzHXUXC2Gly0t9Wr
        8qzHAGF1ivnZcA7olZ2G9dUVaCHsHXtvOTsj8nnQMCTs2IkwvpHFJLQLoMhLMEdB4WlaiIfs7XNVq
        wvDUjW9A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOxYC-0002Yu-9w; Thu, 16 Apr 2020 05:59:00 +0000
Subject: Re: [PATCH v3 4/4] tty: documentation: document how to use ttyvs
 driver
To:     Rishi Gupta <gupt21@gmail.com>, gregkh@linuxfoundation.org,
        jslaby@suse.com, robh+dt@kernel.org, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com
Cc:     devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
 <1587012974-21219-4-git-send-email-gupt21@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <cccf1f76-b16a-600d-0a23-f10d77c524cb@infradead.org>
Date:   Wed, 15 Apr 2020 22:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587012974-21219-4-git-send-email-gupt21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,
A few changes for you to consider:


On 4/15/20 9:56 PM, Rishi Gupta wrote:
> The commit documents how to use ttyvs driver to create/delete
> virtual tty devices, how to emulate various serial port events
> through this driver etc.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v3:
> - Rebased on top of v5.7-rc1
> - Moved virtual-tty-ttyvs.rst from Documentation/virtual to Documentation/admin-guide
> 
> Changes in v2:
> - Added this file from v2 only
> 
>  Documentation/admin-guide/index.rst             |   1 +
>  Documentation/admin-guide/virtual-tty-ttyvs.rst | 142 ++++++++++++++++++++++++
>  2 files changed, 143 insertions(+)
>  create mode 100644 Documentation/admin-guide/virtual-tty-ttyvs.rst


> diff --git a/Documentation/admin-guide/virtual-tty-ttyvs.rst b/Documentation/admin-guide/virtual-tty-ttyvs.rst
> new file mode 100644
> index 0000000..c30b768
> --- /dev/null
> +++ b/Documentation/admin-guide/virtual-tty-ttyvs.rst
> @@ -0,0 +1,142 @@
> +================================================
> +Kernel driver for virtual tty null modem devices
> +================================================
> +
> +Author: Rishi Gupta <gupt21@gmail.com>
> +
> +The ttyvs driver (drivers/tty/ttyvs.c) creates virtual tty devices
> +that can be used with standard POSIX APIs for terminal devices.
> +
> +Applications can write to the sysfs file provided by this driver to
> +emulate various serial port communication events and error conditions.
> +
> +This driver creates a virtual card which can have 0 to 65535 virtual
> +tty devices.
> +
> +Use cases
> +=========
> +- Automated performance and scalability testing
> +- Serial port redirector to any other subsystem like TCP/IP
> +- Feeding data to GPS simulator
> +- Segregating hardware issues from software bugs quickly
> +- Serial port communication sniffer or test sniffer application itself
> +- Application development when hardware is still not available
> +- Testing user space drivers & corner case by injecting handcrafted data
> +- Migrate binary only or legacy applications to new communication medium
> +- Analyze and reverse-engineer serial protocols
> +- Cases where socat utility does not meet requirements for unix-like OS
> +- Cases where available physical serial ports don't meet requirements
> +- Product demo where data from hardware needs to be sent to the GUI app
> +- Stress and corner case testing of user space application
> +
> +How to create devices
> +=====================
> +There are two ways to create devices:
> +
> +1. Using device tree:
> +The card is modelled as a node with zero or more child nodes each
> +representing a virtual tty device. To create a device simply define
> +a child node with the required device parameters. This is explained
> +in detail in DT binding file:
> +Documentation/devicetree/bindings/serial/ttyvs.yaml
> +
> +2. Using configfs:
> +When ttyvs driver is loaded, it will create ttyvs directory inside
> +configfs mount point. For ex; if configfs is mounted at /config, then

                 either  For example,
                 or      E.g.,

> +/config/ttyvs directory will be created. To create a device, simply
> +create directory inside this, write values to be used as device
> +parameters and finally write 1 to create attribute. Defining ownidx
> +and devtype is mandatory.
> +
> +Pin mappings are bit maps; set bit 0 to connect a pin to CTS pin,
> +set bit 1 to connect to DCD pin, set bit 2 to connect to DSR and
> +set bit 3 to connect to RI. Pin naming conventions are follows
> +standard RS232 DB9 connector naming conventions.

A table would be better here IMO.

> +
> +An example to create a loop-back device with device number as 0

                          loopback

> +(/dev/ttyvs0), RTS and DTR pins unconnected, no need to assert DTR
> +when device is opened would be something like this:
> +
> +.. code-block:: sh
> +
> + mkdir /config/ttyvs/devlb-0
> + echo 0 > /config/ttyvs/devlb-0/ownidx
> + echo lb > /config/ttyvs/devlb-0/devtype
> + echo 0 > /config/ttyvs/devlb-0/ortsmap
> + echo 0 > /config/ttyvs/devlb-0/odtrmap
> + echo 0 > /config/ttyvs/devlb-0/odtratopn
> + echo 1 > /config/ttyvs/devlb-0/create
> +
> +An example to create a standard null modem pair with device numbers
> +0 and 1 with pin numbers as per RS232 standards will be something
> +like this:
> +
> +.. code-block:: sh
> +
> + /dev/ttyvs0        /dev/ttyvs1
> +   TX  (3)   ---->    (2) RX
> +   RX  (2)   <----    (3) TX
> +   RTS (7)   ---->    (8) CTS
> +   DTR (4)   --+->    (1) DCD
> +               +->    (6) DSR
> +   CTS (8)   <----    (7) RTS
> +   DCD (1)   <-+--    (4) DTR
> +   DSR (6)   <-+
> +
> + mkdir /config/ttyvs/devnm-0-1
> + echo nm > /config/ttyvs/devnm-0-1/devtype
> + echo 0 > /config/ttyvs/devnm-0-1/ownidx
> + echo 1 > /config/ttyvs/devnm-0-1/ortsmap
> + echo 6 > /config/ttyvs/devnm-0-1/odtrmap
> + echo 0 > /config/ttyvs/devnm-0-1/odtratopn
> + echo 1 > /config/ttyvs/devnm-0-1/peeridx
> + echo 1 > /config/ttyvs/devnm-0-1/prtsmap
> + echo 6 > /config/ttyvs/devnm-0-1/pdtrmap
> + echo 0 > /config/ttyvs/devnm-0-1/pdtratopn
> + echo 1 > /config/ttyvs/devnm-0-1/create
> +
> +Directory name devnm-0-1 can be user defined. We used this simple style
> +as it is intuitive to understand that the device is null modem with
> +numbers 0 and 1. Further, to use configfs based approach, kernel must
> +be compiled with CONFIG_CONFIGFS_FS=y option.
> +
> +How to delete devices
> +=====================
> +To delete a device created by configfs simply delete the directory
> +created in /config/ttyvs directory. If the device is part of a null
> +modem pair, peer device will also be deleted automatically.
> +
> +How to emulate events
> +=====================
> +When a virtual tty device is created, an event sysfs file will also
> +be created by the driver (/sys/class/tty/ttyvsN/event N is device
> +number).
> +
> +1. Emulating framing error: the driver inserts -7 in data buffer as
> +the byte that got corrupted due to framing error while receiving data.
> +To emulate this write 1 to /sys/class/tty/ttyvsN/event file.
> +
> +2. Emulating parity error: the driver inserts -8 in data buffer as
> +the byte that got corrupted due to parity error while receiving data.
> +To emulate this write 2 to /sys/class/tty/ttyvsN/event file.
> +
> +3. Emulating overrun error: the driver reports to tty layer that an
> +overrun has happened.To emulate this write 3 to /sys/class/tty/ttyvsN/event

               happened. To

> +file.
> +
> +4. Emulating ring indication: to emulate as if ring indication has been
> +observed write 4 to the event file. To emulate as if ring indication has
> +been removed write 5 to the event file.
> +
> +5. Emulate break received: to emulate as if break condition has been received
> +write 6 to the /sys/class/tty/ttyvsN/event file.
> +
> +6. Emulate faulty cable: to emulate as if the cable is faulty write 7
> +to the event file. In this case data sent from sender will not be received
> +by the receiver end. To remove this condition write 8 to the event file.
> +
> +How to support more devices
> +===========================
> +By default ttyvs driver supports upto 64 devices. This can be

                                    up to

> +changed by passing module parameter max_num_vs_devs or by defining
> +max-num-vs-devs device tree property.
> 


thanks.
-- 
~Randy

