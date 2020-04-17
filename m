Return-Path: <SRS0=oPkf=6B=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D7C6C2D0EF
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 05:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F3C22202
	for <linux-serial@archiver.kernel.org>; Fri, 17 Apr 2020 05:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2ds6Lak"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgDQFQy (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgDQFQy (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 17 Apr 2020 01:16:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD31C061A0C;
        Thu, 16 Apr 2020 22:16:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id t3so1295150qkg.1;
        Thu, 16 Apr 2020 22:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=d1sMz1oQ52xTtVQOtWIJSv7nbsOj7EudipRbCVl0FMw=;
        b=G2ds6LakI+lfvs0y8SaI6mgvEdOoYzuw1gLfaQ0a/uyCfIfnMeikm2RCMo+M3XjT69
         OEw2w4QhFPxdw0QhUePeIiDq/NnTjJTjpV5Zo4N3WT0Ygb+7Rz5hxmB/34miPtJgp8pC
         gPN2t7ajbCm5EyX4pR65uzN5xqeYrRflc0TCpV/lM95OQRwEAGgXdYZos374YIAsopFc
         d3ZzAFbICIfNZ+C+L+bC4I6EXZWARGkRoxzpd/TEi4gFu1Aocx1Nx24y+vtZfPG79j81
         QyOeGV6tNtIGAElImZKQZ/NjISvmdFhGUpkpVZ7RAIrLEzvBMQnYcqANHtUul18I2sa4
         JEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=d1sMz1oQ52xTtVQOtWIJSv7nbsOj7EudipRbCVl0FMw=;
        b=ZbZleNdcTHInedg9EfX+lJYLOdw0kyVPY34J0q/8jkHWObDOAhJSUMMmXlsp+G52/W
         0ZYJHE9ZCMq5n/i4llthCsU6PyqpBwHOuaBPaffMLtCUNVW46FLJ/Gn0xQJ7IN/g88uw
         EiO6ooABB74py9JO/+4CTWWFIt99MXPBcmaWkzE4h5E8+3ucqapxWYlU4001dq9XdSe6
         WsH2LuDsNSlbFYBEqJuFo1AN23h+ivaeOQ3qA4CKcfhbsM04YK8Bo/oFRguNNh8GlQbq
         ykfwf3dGVuBDDsLFGxaZaqMFNwab1WwsMIthJ0zYxmGh8SupAHeI0O0Kdok9mYRP/wRy
         xxyQ==
X-Gm-Message-State: AGi0PuaZxb+QIeoVM2c7kI6zf+QAmxp6dFEXxkKKaUryRyMd+ljdJ+Az
        Qz3AqCNOWscgdyTfdltgXISyqsVuiSknkvFlRk0=
X-Google-Smtp-Source: APiQypLGtBcaM8BVQkBAdvSf3ndxo8AmIl0M8o4lQ97luDOK5blXT3VgDNnkIMcpd+yg1iASFoH9GlXKVzecF/kyvdc=
X-Received: by 2002:a37:8002:: with SMTP id b2mr1504480qkd.339.1587100612755;
 Thu, 16 Apr 2020 22:16:52 -0700 (PDT)
MIME-Version: 1.0
References: <1587012974-21219-1-git-send-email-gupt21@gmail.com>
 <1587012974-21219-4-git-send-email-gupt21@gmail.com> <20200416092441.4216ffe3@coco.lan>
In-Reply-To: <20200416092441.4216ffe3@coco.lan>
From:   rishi gupta <gupt21@gmail.com>
Date:   Fri, 17 Apr 2020 10:46:40 +0530
Message-ID: <CALUj-gtwKiV_CQYLkncX0v2fNNAyfTfzut+BgXmgzKLW7tMLOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] tty: documentation: document how to use ttyvs driver
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.com,
        robh+dt@kernel.org, corbet@lwn.net,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Thanks Mauro and Randy, I will spin v4 with above suggestions soon.

On Thu, Apr 16, 2020 at 12:54 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Thu, 16 Apr 2020 10:26:14 +0530
> Rishi Gupta <gupt21@gmail.com> escreveu:
>
> > The commit documents how to use ttyvs driver to create/delete
> > virtual tty devices, how to emulate various serial port events
> > through this driver etc.
> >
> > Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> > ---
> > Changes in v3:
> > - Rebased on top of v5.7-rc1
> > - Moved virtual-tty-ttyvs.rst from Documentation/virtual to Documentati=
on/admin-guide
> >
> > Changes in v2:
> > - Added this file from v2 only
> >
> >  Documentation/admin-guide/index.rst             |   1 +
> >  Documentation/admin-guide/virtual-tty-ttyvs.rst | 142 ++++++++++++++++=
++++++++
> >  2 files changed, 143 insertions(+)
> >  create mode 100644 Documentation/admin-guide/virtual-tty-ttyvs.rst
> >
> > diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-=
guide/index.rst
> > index 5a6269f..9a72fb8 100644
> > --- a/Documentation/admin-guide/index.rst
> > +++ b/Documentation/admin-guide/index.rst
> > @@ -50,6 +50,7 @@ ABI will be found here.
> >     :maxdepth: 1
> >
> >     sysfs-rules
> > +   virtual-tty-ttyvs
> >
> >  The rest of this manual consists of various unordered guides on how to
> >  configure specific aspects of kernel behavior to your liking.
> > diff --git a/Documentation/admin-guide/virtual-tty-ttyvs.rst b/Document=
ation/admin-guide/virtual-tty-ttyvs.rst
> > new file mode 100644
> > index 0000000..c30b768
> > --- /dev/null
> > +++ b/Documentation/admin-guide/virtual-tty-ttyvs.rst
> > @@ -0,0 +1,142 @@
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Kernel driver for virtual tty null modem devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Author: Rishi Gupta <gupt21@gmail.com>
> > +
> > +The ttyvs driver (drivers/tty/ttyvs.c) creates virtual tty devices
> > +that can be used with standard POSIX APIs for terminal devices.
> > +
> > +Applications can write to the sysfs file provided by this driver to
> > +emulate various serial port communication events and error conditions.
> > +
> > +This driver creates a virtual card which can have 0 to 65535 virtual
> > +tty devices.
> > +
> > +Use cases
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +- Automated performance and scalability testing
> > +- Serial port redirector to any other subsystem like TCP/IP
> > +- Feeding data to GPS simulator
> > +- Segregating hardware issues from software bugs quickly
> > +- Serial port communication sniffer or test sniffer application itself
> > +- Application development when hardware is still not available
> > +- Testing user space drivers & corner case by injecting handcrafted da=
ta
> > +- Migrate binary only or legacy applications to new communication medi=
um
> > +- Analyze and reverse-engineer serial protocols
> > +- Cases where socat utility does not meet requirements for unix-like O=
S
> > +- Cases where available physical serial ports don't meet requirements
> > +- Product demo where data from hardware needs to be sent to the GUI ap=
p
> > +- Stress and corner case testing of user space application
> > +
> > +How to create devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +There are two ways to create devices:
> > +
> > +1. Using device tree:
> > +The card is modelled as a node with zero or more child nodes each
> > +representing a virtual tty device. To create a device simply define
> > +a child node with the required device parameters. This is explained
> > +in detail in DT binding file:
> > +Documentation/devicetree/bindings/serial/ttyvs.yaml
>
> There's a typo there: "modelled" -> "modeled"
>
> -
>
> I suspect you didn't try to build it with Sphinx [1]. The html output of =
the
> above would be:
>
>         "1. Using device tree: The card is modelled as a node with zero o=
r more child nodes each representing a virtual tty device. To create a devi=
ce simply define a child node with the required device parameters. This is =
explained in detail in DT binding file: Documentation/devicetree/bindings/s=
erial/ttyvs.yaml"
>
> (E.g. everything on a single line).
>
>
> [1] To build, just use:
>                 make htmldocs
>
>     it will likely point you some packages to install, in order to be
>     able to generate both html and pdf outputs. After installing them,
>     run "make htmldocs" again. The output should be under:
>
>         Documentation/output/admin-guide/virtual-tty-ttyvs.html
>
>
> For Sphinx, a paragraph requires an extra blank line. So, the
> above should be written, instead, as:
>
>         1. Using device tree:
>
>         The card is modeled as a node with zero or more child nodes each
>         representing a virtual tty device. To create a device simply defi=
ne
>         a child node with the required device parameters. This is explain=
ed
>         in detail in DT binding file:
>
>         Documentation/devicetree/bindings/serial/ttyvs.yaml
>
> Personally, I would make it look a little nicer writing it instead as:
>
>         1. Using device tree
>         --------------------
>
>         The card is modeled as a node with zero or more child nodes each
>         representing a virtual tty device. To create a device simply defi=
ne
>         a child node with the required device parameters. This is explain=
ed
>         in detail in DT binding file:
>
>         - Documentation/devicetree/bindings/serial/ttyvs.yaml
>
> > +
> > +2. Using configfs:
> > +When ttyvs driver is loaded, it will create ttyvs directory inside
> > +configfs mount point. For ex; if configfs is mounted at /config, then
> > +/config/ttyvs directory will be created. To create a device, simply
> > +create directory inside this, write values to be used as device
> > +parameters and finally write 1 to create attribute. Defining ownidx
> > +and devtype is mandatory.
>
> Same as above.
>
> > +
> > +Pin mappings are bit maps; set bit 0 to connect a pin to CTS pin,
> > +set bit 1 to connect to DCD pin, set bit 2 to connect to DSR and
> > +set bit 3 to connect to RI. Pin naming conventions are follows
> > +standard RS232 DB9 connector naming conventions.
>
> As Randy suggested, use a table here, like:
>
> Pin mappings are bit maps:
>
>         =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         bit  meaning
>         =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>         0    connect a pin to CTS pin
> ...
>         3    connect to RI
>         =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> > +
> > +An example to create a loop-back device with device number as 0
> > +(/dev/ttyvs0), RTS and DTR pins unconnected, no need to assert DTR
> > +when device is opened would be something like this:
> > +
> > +.. code-block:: sh
> > +
> > + mkdir /config/ttyvs/devlb-0
> > + echo 0 > /config/ttyvs/devlb-0/ownidx
> > + echo lb > /config/ttyvs/devlb-0/devtype
> > + echo 0 > /config/ttyvs/devlb-0/ortsmap
> > + echo 0 > /config/ttyvs/devlb-0/odtrmap
> > + echo 0 > /config/ttyvs/devlb-0/odtratopn
> > + echo 1 > /config/ttyvs/devlb-0/create
>
> You need to add spaces (or tabs) at the lines under the code-block,
> as otherwise Sphinx will ignore it (and place everything on a single
> line).
>
> > +
> > +An example to create a standard null modem pair with device numbers
> > +0 and 1 with pin numbers as per RS232 standards will be something
> > +like this:
> > +
> > +.. code-block:: sh
>
> Hmm... the code below is not shell script. Btw, I would use, instead, "::=
"
> notation:
>
>         An example to create a standard null modem pair with device numbe=
rs
>         0 and 1 with pin numbers as per RS232 standards will be something
>         like this::
>
>                 /dev/ttyvs0        /dev/ttyvs1
> ...
>
>
> > +
> > + /dev/ttyvs0        /dev/ttyvs1
> > +   TX  (3)   ---->    (2) RX
> > +   RX  (2)   <----    (3) TX
> > +   RTS (7)   ---->    (8) CTS
> > +   DTR (4)   --+->    (1) DCD
> > +               +->    (6) DSR
> > +   CTS (8)   <----    (7) RTS
> > +   DCD (1)   <-+--    (4) DTR
> > +   DSR (6)   <-+
>
>
> > +
> > + mkdir /config/ttyvs/devnm-0-1
> > + echo nm > /config/ttyvs/devnm-0-1/devtype
> > + echo 0 > /config/ttyvs/devnm-0-1/ownidx
> > + echo 1 > /config/ttyvs/devnm-0-1/ortsmap
> > + echo 6 > /config/ttyvs/devnm-0-1/odtrmap
> > + echo 0 > /config/ttyvs/devnm-0-1/odtratopn
> > + echo 1 > /config/ttyvs/devnm-0-1/peeridx
> > + echo 1 > /config/ttyvs/devnm-0-1/prtsmap
> > + echo 6 > /config/ttyvs/devnm-0-1/pdtrmap
> > + echo 0 > /config/ttyvs/devnm-0-1/pdtratopn
> > + echo 1 > /config/ttyvs/devnm-0-1/create
>
> Ok, the above is a shell code block, but it is not part of the
> ASCII artwork. So, it deserves its own code block.
>
> > +
> > +Directory name devnm-0-1 can be user defined. We used this simple styl=
e
> > +as it is intuitive to understand that the device is null modem with
> > +numbers 0 and 1. Further, to use configfs based approach, kernel must
> > +be compiled with CONFIG_CONFIGFS_FS=3Dy option.
>
> While not mandatory, I would use this for constants:
>
>         ``CONFIG_CONFIGFS_FS=3Dy``
>
> (this changes the font to monotonic).
>
> On the documents I write myself, I use this for variables, paths, modprob=
e
> parameters, config options, inlined code snippets, etc.
>
> A side effect is that several text editors (emacs, pico, vim, kate, ...) =
that
> will highlight those in-lined code blocks with a different color, with he=
lps
> a lot, even when looking on them as plain texts.
>
> > +
> > +How to delete devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +To delete a device created by configfs simply delete the directory
> > +created in /config/ttyvs directory. If the device is part of a null
> > +modem pair, peer device will also be deleted automatically.
> > +
> > +How to emulate events
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +When a virtual tty device is created, an event sysfs file will also
> > +be created by the driver (/sys/class/tty/ttyvsN/event N is device
> > +number).
> > +
> > +1. Emulating framing error: the driver inserts -7 in data buffer as
> > +the byte that got corrupted due to framing error while receiving data.
> > +To emulate this write 1 to /sys/class/tty/ttyvsN/event file.
>
> You need to properly indent lists:
>
>         1. Emulating framing error: the driver inserts -7 in data buffer =
as
>            the byte that got corrupted due to framing error while receivi=
ng data.
>            To emulate this write 1 to /sys/class/tty/ttyvsN/event file.
>
>
> > +
> > +2. Emulating parity error: the driver inserts -8 in data buffer as
> > +the byte that got corrupted due to parity error while receiving data.
> > +To emulate this write 2 to /sys/class/tty/ttyvsN/event file.
> > +
> > +3. Emulating overrun error: the driver reports to tty layer that an
> > +overrun has happened.To emulate this write 3 to /sys/class/tty/ttyvsN/=
event
> > +file.
> > +
> > +4. Emulating ring indication: to emulate as if ring indication has bee=
n
> > +observed write 4 to the event file. To emulate as if ring indication h=
as
> > +been removed write 5 to the event file.
> > +
> > +5. Emulate break received: to emulate as if break condition has been r=
eceived
> > +write 6 to the /sys/class/tty/ttyvsN/event file.
> > +
> > +6. Emulate faulty cable: to emulate as if the cable is faulty write 7
> > +to the event file. In this case data sent from sender will not be rece=
ived
> > +by the receiver end. To remove this condition write 8 to the event fil=
e.
> > +
> > +How to support more devices
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > +By default ttyvs driver supports upto 64 devices. This can be
>
>         upto -> up to
>
> (ok, "upto" is a sort of slang, but I would prefer to avoid slangs on
>  documents).
>
> > +changed by passing module parameter max_num_vs_devs or by defining
> > +max-num-vs-devs device tree property.
>
> Thanks,
> Mauro
