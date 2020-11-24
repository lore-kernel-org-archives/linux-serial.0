Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB5AC63798
	for <linux-serial@archiver.kernel.org>; Tue, 24 Nov 2020 12:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7402083E
	for <linux-serial@archiver.kernel.org>; Tue, 24 Nov 2020 12:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NIYejds6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbgKXMAD (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 24 Nov 2020 07:00:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35915 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732317AbgKXMAC (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 24 Nov 2020 07:00:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606219199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HqLKkdSNa/eGdRcb+JU0V3lhIwGJU8Y7t6iuocEiAMc=;
        b=NIYejds6pD0smBkCZyI0zR+LVfZSJKFK4Oae7GswVhqXDpxbcXG4SGFNmeVtZ7Naxb7iMk
        paWLt2oV+Z7XtyCb4/8K+GSuDEEH1y8eUi+yXi/YNGptGg++q0dD8WcoVI6Blkp4q6M0Zo
        B3SbagQqeIlRRcMdIifwc+I5RQOjppQ=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-4sWAxXY7PDWogWgPBjUTFg-1; Tue, 24 Nov 2020 06:59:56 -0500
X-MC-Unique: 4sWAxXY7PDWogWgPBjUTFg-1
Received: by mail-ed1-f69.google.com with SMTP id x15so7824602edr.10
        for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2020 03:59:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HqLKkdSNa/eGdRcb+JU0V3lhIwGJU8Y7t6iuocEiAMc=;
        b=DZrxpuspxXcqZ3zJGLB1IshIl7qhO4YIRGV2Qh/uNdDmXXfs3B2aRsIoGPJX+Lc2mA
         6+Vu067a0N5dQ5bk2XW9NNuXmqvAUQHGn4ahNLLu9puhNhHgCSX7h8x2HNHxTlS3pHuX
         dK+lRf7QJxWBnBo0rNvclnzknrDnQldqWqOm/QM3J4rhCD0gY/aXsdH/0cpo7a5WDrNh
         018/EYykx5iHZqOC0xb8OYQmtsFnpv6N7I3lqECQ1fk6KNGVYE803US2+frVfK/+Ub4s
         O0QOUf7GNIfw6DopNW2/cSYB0QavNw3ZG1AnI1juq2GJ5wgfbgQ/40nEXa4wO2aEdzYj
         I32g==
X-Gm-Message-State: AOAM533J8DvDnRpL/XRU/XWIqKFh8STl8QLh1zJYr4JCGA5z/AFnS3nX
        0kK7FMJSmIc6F4JpiIwbAiHtnWtaFv4ci8WKfIwQh0FyCWKhhvuLih1TCw3kvLYHvOsSDq4pe08
        FzHEU7xDQXeZ/oBNGzFmLEtv7
X-Received: by 2002:a17:907:aaf:: with SMTP id bz15mr621833ejc.199.1606219195457;
        Tue, 24 Nov 2020 03:59:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwnCij/SJ7Wd3Me+rHMeQtaycgwouAEEHLWJ7dLsFw1WPkEy5X9jhJ819Edn92e3ucjlyGs6Q==
X-Received: by 2002:a17:907:aaf:: with SMTP id bz15mr621817ejc.199.1606219195126;
        Tue, 24 Nov 2020 03:59:55 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id c8sm6843427edr.29.2020.11.24.03.59.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 03:59:54 -0800 (PST)
Subject: Re: [PATCH 0/9] Add support for Microsoft Surface System Aggregator
 Module
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Mark Gross <mgross@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Bla=c5=be_Hrastnik?= <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>,
        platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20201115192143.21571-1-luzmaximilian@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <059069df-c972-5060-1b26-2ddcc842810d@redhat.com>
Date:   Tue, 24 Nov 2020 12:59:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201115192143.21571-1-luzmaximilian@gmail.com>
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

On 11/15/20 8:21 PM, Maximilian Luz wrote:
> Hello,
> 
>   N.B.: the following text is mostly a repeat of cover letter from the
>   previous RFC for the uninitiated, which can be found at
> 
>   https://lore.kernel.org/linux-serial/20200923151511.3842150-1-luzmaximilian@gmail.com/
> 
>   See "Changes" below for an overview of differences between the RFC and
>   this patchset. I hope I have addressed all comments from that in this
>   version, thank you again for those.
> 
> The Surface System Aggregator Module (we'll refer to it as Surface
> Aggregator or SAM below) is an embedded controller (EC) found on various
> Microsoft Surface devices. Specifically, all 4th and later generation
> Surface devices, i.e. Surface Pro 4, Surface Book 1 and later, with the
> exception of the Surface Go series and the Surface Duo. Notably, it
> seems like this EC can also be found on the ARM-based Surface Pro X [1].

<snip>

> This patch-set can also be found at the following repository and
> reference, if you prefer to look at a kernel tree instead of these
> emails:
> 
>   https://github.com/linux-surface/kernel tags/s/surface-aggregator/v1
> 
> Thanks,
> Max

Thank you for your work on this. It would be great if we can get better
support for the Surface line in the mainline kernel.

Since a lot of people have already commented on this series I think that
you have enough feedback to do a v2 addressing that feedback right? 

For now I'm going to assume that you will do a v2 addressing the
initial round of comments and not review this myself (IOW I'll review
this when v2 is posted).

Let me know if you see things differently.

Regards,

Hans





> [1]: The Surface Pro X is, however, currently considered unsupported due
>      to a lack of test candidates and, as it seems, general lack of
>      Linux support on other parts. AFAIK there is an issue preventing
>      serial devices from being registered, on which the core driver in
>      this series is build on, thus there is no way to even test that at
>      this point. I'd be happy to work out any issues regarding SAM on
>      the Pro X at some point in the future, provided someone can/wants
>      to actually test it.
> 
> [2]: https://github.com/linux-surface/surface-aggregator-module
> [3]: https://github.com/linux-surface/linux-surface
> 
> 
> Note: This patch depends on
> 
>   [PATCH v4] platform/surface: Create a platform subdirectory for
>              Microsoft Surface devices
> 
> which can be found at
> 
>   https://lore.kernel.org/platform-driver-x86/20201009141128.683254-1-luzmaximilian@gmail.com/
> 
> and is currently in platform-drivers-x86/for-next.
> 
> 
> Changes from the previous RFC (overview):
>  - move to platform/surface
>  - add copyright lines
>  - change SPDX identifier to GPL-2.0+ (was GPL-2.0-or-later)
>  - change user-space interface from debugfs to misc-device
>  - address issues in user-space interface
>  - fix typos in commit messages and documentation
>  - fix some bugs, address other issues
> 
> Changes regarding specific patches (and more details) can be found on
> the individual patch.
> 
> 
> Maximilian Luz (9):
>   platform/surface: Add Surface Aggregator subsystem
>   platform/surface: aggregator: Add control packet allocation caching
>   platform/surface: aggregator: Add event item allocation caching
>   platform/surface: aggregator: Add trace points
>   platform/surface: aggregator: Add error injection capabilities
>   platform/surface: aggregator: Add dedicated bus and device type
>   docs: driver-api: Add Surface Aggregator subsystem documentation
>   platform/surface: Add Surface Aggregator user-space interface
>   platform/surface: Add Surface ACPI Notify driver
> 
>  Documentation/driver-api/index.rst            |    1 +
>  .../surface_aggregator/client-api.rst         |   38 +
>  .../driver-api/surface_aggregator/client.rst  |  394 +++
>  .../surface_aggregator/clients/cdev.rst       |   85 +
>  .../surface_aggregator/clients/index.rst      |   21 +
>  .../surface_aggregator/clients/san.rst        |   44 +
>  .../driver-api/surface_aggregator/index.rst   |   21 +
>  .../surface_aggregator/internal-api.rst       |   67 +
>  .../surface_aggregator/internal.rst           |   50 +
>  .../surface_aggregator/overview.rst           |   76 +
>  .../driver-api/surface_aggregator/ssh.rst     |  343 +++
>  MAINTAINERS                                   |   13 +
>  drivers/platform/surface/Kconfig              |   39 +
>  drivers/platform/surface/Makefile             |    3 +
>  drivers/platform/surface/aggregator/Kconfig   |   65 +
>  drivers/platform/surface/aggregator/Makefile  |   17 +
>  drivers/platform/surface/aggregator/bus.c     |  424 +++
>  drivers/platform/surface/aggregator/bus.h     |   27 +
>  .../platform/surface/aggregator/controller.c  | 2557 +++++++++++++++++
>  .../platform/surface/aggregator/controller.h  |  288 ++
>  drivers/platform/surface/aggregator/core.c    |  831 ++++++
>  .../platform/surface/aggregator/ssh_msgb.h    |  201 ++
>  .../surface/aggregator/ssh_packet_layer.c     | 2009 +++++++++++++
>  .../surface/aggregator/ssh_packet_layer.h     |  175 ++
>  .../platform/surface/aggregator/ssh_parser.c  |  229 ++
>  .../platform/surface/aggregator/ssh_parser.h  |  157 +
>  .../surface/aggregator/ssh_request_layer.c    | 1254 ++++++++
>  .../surface/aggregator/ssh_request_layer.h    |  142 +
>  drivers/platform/surface/aggregator/trace.h   |  625 ++++
>  .../platform/surface/surface_acpi_notify.c    |  884 ++++++
>  .../surface/surface_aggregator_cdev.c         |  299 ++
>  include/linux/mod_devicetable.h               |   18 +
>  include/linux/surface_acpi_notify.h           |   39 +
>  include/linux/surface_aggregator/controller.h |  832 ++++++
>  include/linux/surface_aggregator/device.h     |  430 +++
>  include/linux/surface_aggregator/serial_hub.h |  659 +++++
>  include/uapi/linux/surface_aggregator/cdev.h  |   58 +
>  scripts/mod/devicetable-offsets.c             |    8 +
>  scripts/mod/file2alias.c                      |   23 +
>  39 files changed, 13446 insertions(+)
>  create mode 100644 Documentation/driver-api/surface_aggregator/client-api.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/client.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/cdev.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/index.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/clients/san.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/index.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/internal-api.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/internal.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/overview.rst
>  create mode 100644 Documentation/driver-api/surface_aggregator/ssh.rst
>  create mode 100644 drivers/platform/surface/aggregator/Kconfig
>  create mode 100644 drivers/platform/surface/aggregator/Makefile
>  create mode 100644 drivers/platform/surface/aggregator/bus.c
>  create mode 100644 drivers/platform/surface/aggregator/bus.h
>  create mode 100644 drivers/platform/surface/aggregator/controller.c
>  create mode 100644 drivers/platform/surface/aggregator/controller.h
>  create mode 100644 drivers/platform/surface/aggregator/core.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_msgb.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_packet_layer.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_parser.h
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.c
>  create mode 100644 drivers/platform/surface/aggregator/ssh_request_layer.h
>  create mode 100644 drivers/platform/surface/aggregator/trace.h
>  create mode 100644 drivers/platform/surface/surface_acpi_notify.c
>  create mode 100644 drivers/platform/surface/surface_aggregator_cdev.c
>  create mode 100644 include/linux/surface_acpi_notify.h
>  create mode 100644 include/linux/surface_aggregator/controller.h
>  create mode 100644 include/linux/surface_aggregator/device.h
>  create mode 100644 include/linux/surface_aggregator/serial_hub.h
>  create mode 100644 include/uapi/linux/surface_aggregator/cdev.h
> 

