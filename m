Return-Path: <SRS0=j4md=4Q=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8785C3F2CD
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 23:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33FA246AE
	for <linux-serial@archiver.kernel.org>; Fri, 28 Feb 2020 23:01:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FS0eEq//"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgB1XBe (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 28 Feb 2020 18:01:34 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32973 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbgB1XBe (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 28 Feb 2020 18:01:34 -0500
Received: by mail-pf1-f193.google.com with SMTP id n7so2464951pfn.0
        for <linux-serial@vger.kernel.org>; Fri, 28 Feb 2020 15:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=dZaVgKnipnPl2uHYrizFjHisTcXxwvovLwjp+MQT1Jc=;
        b=FS0eEq//+B2bAcN1ys9FeTBGx8KrK13+/GUy6uM8wAJ9jXqH+ni2kJSZyr0VFNTMJV
         dRAo3asYgZKUPhnrecLy+ovofLUxFdLBpNriTnFdpR3rlA3kgUVWJZ7DULHJhHo2IGHW
         ZICAdbAHT7Tzs3edt0nyVjeVk1RaSSN34mIAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=dZaVgKnipnPl2uHYrizFjHisTcXxwvovLwjp+MQT1Jc=;
        b=jXTDJSiRLIoXLdd/n93otChpmTGvX63PYd4Ao2ZVQVkkKw2XJfi4VNHnTNXJ+J7rBj
         iSDVNTrodweXf0TvBv0DL5dgggnTew6cGmPA5Nb0nKh3QoeXYsk+wO/4zxlVSlUXiW0Y
         4d+IVjxC13YJFwuYYfDGmoT+Wrm7Zqtzj7P6c6Dfo48vBaZA3xYRS+UkHgUzG0JRlW2i
         pEIxCLrG9UjNHrBZBore/0NDLHQeJr9uI5JEt4AmXPm9cfwoCw04UXrYBIYvG5NwPMmN
         dBYXcAtTuYFS9CRy2gBx3TiliXMBm4S1/puAVEAdgWY92yNSvrAL2Y3vqs3WbLwJLxZD
         /kgg==
X-Gm-Message-State: APjAAAVEliX03ewENGxFkljOUeO0uDRg5G2wbkxBTaPrg4AvhSH1mWOF
        9EBVmJYPAfwVYb7miO+ZC+AOIg==
X-Google-Smtp-Source: APXvYqwY4NjtVC70+7DJSvyYBQrQ2fqD3HjwbZd1bG+cCDPeeOCTVVRExMGiinPAhoiL0l3OaHSVaA==
X-Received: by 2002:a63:be09:: with SMTP id l9mr6731956pgf.439.1582930891378;
        Fri, 28 Feb 2020 15:01:31 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 1sm8399252pff.11.2020.02.28.15.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 15:01:30 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1582638862-9344-2-git-send-email-skakit@codeaurora.org>
References: <1582638862-9344-1-git-send-email-skakit@codeaurora.org> <1582638862-9344-2-git-send-email-skakit@codeaurora.org>
Subject: Re: [PATCH V2 1/2] tty: serial: qcom_geni_serial: Allocate port->rx_fifo buffer in probe
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mgautam@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, akashast@codeaurora.org,
        rojay@codeaurora.org, msavaliy@qti.qualcomm.com,
        satya priya <skakit@codeaurora.org>
To:     gregkh@linuxfoundation.org, satya priya <skakit@codeaurora.org>
Date:   Fri, 28 Feb 2020 15:01:29 -0800
Message-ID: <158293088963.112031.11417422453396901116@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Quoting satya priya (2020-02-25 05:54:21)
> To fix the RX cancel command failure, rx_fifo buffer needs to be
> flushed in stop_rx() by calling handle_rx().
>=20
> If set_termios is called before startup, by this time memory is not
> allocated to port->rx_fifo buffer, which leads to a NULL pointer
> dereference.

Also, clearly set_termios() isn't being called in the warning stack that
I sent last round:

     pc : handle_rx_uart+0x64/0x278                                        =
                                                                           =
                             =20
     lr : qcom_geni_serial_handle_rx+0x84/0x90                             =
                                                                           =
                             =20
     sp : ffffff814348f960                                                 =
                                                                           =
                             =20
     x29: ffffff814348f960 x28: ffffffd01ac24288                           =
                                                                           =
                             =20
     x27: 0000000000000018 x26: 0000000000000002                           =
                                                                           =
                             =20
     x25: 0000000000000001 x24: ffffff8146341348                           =
                                                                           =
                             =20
     x23: ffffff8146341000 x22: ffffffd01accc978                           =
                                                                           =
                             =20
     x21: ffffff8146341000 x20: 0000000000000001                           =
                                                                           =
                             =20
     x19: 0000000000000001 x18: ffffffd01b22d000                           =
                                                                           =
                             =20
     x17: 0000000000008000 x16: 00000000000000b0                           =
                                                                           =
                             =20
     x15: ffffffd01afdbdd0 x14: ffffffd01b3edde0                           =
                                                                           =
                             =20
     x13: ffffffd01b7fb000 x12: 0000000000000001                           =
                                                                           =
                             =20
     x11: 0000000000000000 x10: 0000000000000000                           =
                                                                           =
                             =20
     x9 : ffffffd010344780 x8 : 0000000000000000                           =
                                                                           =
                             =20
     x7 : ffffffd019d8e768 x6 : 0000000000000000                           =
                                                                           =
                             =20
     x5 : ffffffd01adbb000 x4 : 0000000000008004                           =
                                                                           =
                             =20
     x3 : 0000000000000001 x2 : 0000000000000001                           =
                                                                           =
                             =20
     x1 : 0000000000000001 x0 : ffffffd01accc978                           =
                                                                           =
                             =20
     Call trace:                                                           =
                                                                           =
                             =20
      handle_rx_uart+0x64/0x278                                            =
                                                                           =
                             =20
      qcom_geni_serial_handle_rx+0x84/0x90                                 =
                                                                           =
                             =20
      qcom_geni_serial_stop_rx+0x110/0x180                                 =
                                                                           =
                             =20
      qcom_geni_serial_port_setup+0x68/0x1b0                               =
                                                                           =
                             =20
      qcom_geni_serial_startup+0x24/0x70                                   =
                                                                           =
                             =20
      uart_startup+0x164/0x28c                                             =
                                                                           =
                             =20
      uart_port_activate+0x6c/0xbc                                         =
                                                                           =
                             =20
      tty_port_open+0xa8/0x114                                             =
                                                                           =
                             =20
      uart_open+0x28/0x38                                                  =
                                                                           =
                             =20
      ttyport_open+0x7c/0x164                                              =
                                                                           =
                             =20
      serdev_device_open+0x38/0xe4                                         =
                                                                           =
                             =20
      hci_uart_register_device+0x54/0x2e8 [hci_uart]                       =
                                                                           =
                             =20
      qca_serdev_probe+0x1c4/0x374 [hci_uart]                              =
                                                                           =
                             =20
      serdev_drv_probe+0x3c/0x64                                           =
                                                                           =
                             =20
      really_probe+0x144/0x3f8                                             =
                                                                           =
                             =20
      driver_probe_device+0x70/0x140                                       =
                                                                           =
                             =20
      __driver_attach_async_helper+0x7c/0xa8                               =
                                                                           =
                             =20
      async_run_entry_fn+0x60/0x178                                        =
                                                                           =
                             =20
      process_one_work+0x33c/0x640                                         =
                                                                           =
                             =20
      worker_thread+0x2a0/0x470                                            =
                                                                           =
                             =20
      kthread+0x128/0x138                                                  =
                                                                           =
                             =20
      ret_from_fork+0x10/0x18                                              =
                                                                           =
                             =20
     Code: 1aca096a 911e0129 b940012b 7100054a (b800450b)                  =
      =20

This shows that uart_startup() is the one that is calling
qcom_geni_serial_startup() and that's running the newly added cancel
path. So even if we allocate the buffer in probe vs. in startup we're
going to flip a buffer full of junk that we're trying to cancel out of
the fifo into the tty layer. That seems wrong. We should have a
different qcom_geni_serial_stop_rx() function that knows we're starting
up vs. handling a normal rx event and call something besides handle_rx()
because that pushes bytes up into the tty layer.

>=20
> To avoid this NULL pointer dereference allocate memory to port->rx_fifo
> in probe itself.
>
