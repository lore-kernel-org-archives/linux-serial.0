Return-Path: <SRS0=wizI=6A=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E874C352BE
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 07:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED5E6214D8
	for <linux-serial@archiver.kernel.org>; Thu, 16 Apr 2020 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587021892;
	bh=x6NCyy3rYXB3kwgxR8qraQyKLgISx/cBtU574sdfPv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=M2X4h8koshIf/2A9ep2sTqdAre6rPRKtbzp96XrMYD/DGxQltfOarRNz98oFNiMhV
	 S6pnGpXWtcEJJ73Y9ADqyVUHoAr2b6rzfKio0ViUXzWYoNPW8ZnlFDBLtrkzVr5JSq
	 kIBQ6JX2xbjNXt1tUAYVx+7sbzhJGVu0MnH887nE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438868AbgDPHYu (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 16 Apr 2020 03:24:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:50494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438815AbgDPHYs (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 16 Apr 2020 03:24:48 -0400
Received: from coco.lan (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DACEF206D5;
        Thu, 16 Apr 2020 07:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587021887;
        bh=x6NCyy3rYXB3kwgxR8qraQyKLgISx/cBtU574sdfPv0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JMkIDt6bYkpCDwdlTR1HBWiwaWcjcn9/eWNDsBzjqC0pufHD1MyeXCjp6lsk2X38E
         VgV9qyz00frxrRdijzMewVdthAB1z5zeRmhrbsxX31SeymqATa6mNF8RbvDQJGQHI8
         sIlN1CRQxMgIl2OZntsdwXGF3RX32bIKvWmKbqhg=
Date:   Thu, 16 Apr 2020 09:24:41 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     gregkh@linuxfoundation.org, jslaby@suse.com, robh+dt@kernel.org,
        corbet@lwn.net, andriy.shevchenko@linux.intel.com,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/4] tty: documentation: document how to use ttyvs
 driver
Message-ID: <20200416092441.4216ffe3@coco.lan>
In-Reply-To: <1587012974-21219-4-git-send-email-gupt21@gmail.com>
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
        <1587012974-21219-4-git-send-email-gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Em Thu, 16 Apr 2020 10:26:14 +0530
Rishi Gupta <gupt21@gmail.com> escreveu:

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
> 
> diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
> index 5a6269f..9a72fb8 100644
> --- a/Documentation/admin-guide/index.rst
> +++ b/Documentation/admin-guide/index.rst
> @@ -50,6 +50,7 @@ ABI will be found here.
>     :maxdepth: 1
>  
>     sysfs-rules
> +   virtual-tty-ttyvs
>  
>  The rest of this manual consists of various unordered guides on how to
>  configure specific aspects of kernel behavior to your liking.
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

There's a typo there: "modelled" -> "modeled"

-

I suspect you didn't try to build it with Sphinx [1]. The html output of the
above would be:

	"1. Using device tree: The card is modelled as a node with zero or more child nodes each representing a virtual tty device. To create a device simply define a child node with the required device parameters. This is explained in detail in DT binding file: Documentation/devicetree/bindings/serial/ttyvs.yaml"

(E.g. everything on a single line).


[1] To build, just use:
		make htmldocs

    it will likely point you some packages to install, in order to be
    able to generate both html and pdf outputs. After installing them,
    run "make htmldocs" again. The output should be under:

	Documentation/output/admin-guide/virtual-tty-ttyvs.html


For Sphinx, a paragraph requires an extra blank line. So, the
above should be written, instead, as:

	1. Using device tree:

	The card is modeled as a node with zero or more child nodes each
	representing a virtual tty device. To create a device simply define
	a child node with the required device parameters. This is explained
	in detail in DT binding file:

	Documentation/devicetree/bindings/serial/ttyvs.yaml

Personally, I would make it look a little nicer writing it instead as:

	1. Using device tree
	--------------------

	The card is modeled as a node with zero or more child nodes each
	representing a virtual tty device. To create a device simply define
	a child node with the required device parameters. This is explained
	in detail in DT binding file:

	- Documentation/devicetree/bindings/serial/ttyvs.yaml

> +
> +2. Using configfs:
> +When ttyvs driver is loaded, it will create ttyvs directory inside
> +configfs mount point. For ex; if configfs is mounted at /config, then
> +/config/ttyvs directory will be created. To create a device, simply
> +create directory inside this, write values to be used as device
> +parameters and finally write 1 to create attribute. Defining ownidx
> +and devtype is mandatory.

Same as above.

> +
> +Pin mappings are bit maps; set bit 0 to connect a pin to CTS pin,
> +set bit 1 to connect to DCD pin, set bit 2 to connect to DSR and
> +set bit 3 to connect to RI. Pin naming conventions are follows
> +standard RS232 DB9 connector naming conventions.

As Randy suggested, use a table here, like:

Pin mappings are bit maps:

	===  =========================================
	bit  meaning
	===  =========================================
	0    connect a pin to CTS pin
...
	3    connect to RI
	===  =========================================

> +
> +An example to create a loop-back device with device number as 0
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

You need to add spaces (or tabs) at the lines under the code-block,
as otherwise Sphinx will ignore it (and place everything on a single
line).

> +
> +An example to create a standard null modem pair with device numbers
> +0 and 1 with pin numbers as per RS232 standards will be something
> +like this:
> +
> +.. code-block:: sh

Hmm... the code below is not shell script. Btw, I would use, instead, "::"
notation:

	An example to create a standard null modem pair with device numbers
	0 and 1 with pin numbers as per RS232 standards will be something
	like this::

		/dev/ttyvs0        /dev/ttyvs1
...


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

Ok, the above is a shell code block, but it is not part of the 
ASCII artwork. So, it deserves its own code block.

> +
> +Directory name devnm-0-1 can be user defined. We used this simple style
> +as it is intuitive to understand that the device is null modem with
> +numbers 0 and 1. Further, to use configfs based approach, kernel must
> +be compiled with CONFIG_CONFIGFS_FS=y option.

While not mandatory, I would use this for constants:

	``CONFIG_CONFIGFS_FS=y``

(this changes the font to monotonic).

On the documents I write myself, I use this for variables, paths, modprobe
parameters, config options, inlined code snippets, etc.

A side effect is that several text editors (emacs, pico, vim, kate, ...) that
will highlight those in-lined code blocks with a different color, with helps 
a lot, even when looking on them as plain texts.

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

You need to properly indent lists:

	1. Emulating framing error: the driver inserts -7 in data buffer as
	   the byte that got corrupted due to framing error while receiving data.
	   To emulate this write 1 to /sys/class/tty/ttyvsN/event file.


> +
> +2. Emulating parity error: the driver inserts -8 in data buffer as
> +the byte that got corrupted due to parity error while receiving data.
> +To emulate this write 2 to /sys/class/tty/ttyvsN/event file.
> +
> +3. Emulating overrun error: the driver reports to tty layer that an
> +overrun has happened.To emulate this write 3 to /sys/class/tty/ttyvsN/event
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

	upto -> up to

(ok, "upto" is a sort of slang, but I would prefer to avoid slangs on
 documents).

> +changed by passing module parameter max_num_vs_devs or by defining
> +max-num-vs-devs device tree property.

Thanks,
Mauro
