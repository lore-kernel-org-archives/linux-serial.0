Return-Path: <linux-serial-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E422CDB465
	for <linux-serial@archiver.kernel.org>; Sat, 14 Oct 2023 09:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232842AbjJNJl0 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Sat, 14 Oct 2023 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjJNJlZ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Sat, 14 Oct 2023 05:41:25 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D70B7
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 02:41:23 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507975d34e8so2358007e87.1
        for <linux-serial@vger.kernel.org>; Sat, 14 Oct 2023 02:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697276482; x=1697881282; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sD19XeF5BvtsgMzfqAV9FVlhJA/PmZrwqnEN9hkKm1E=;
        b=KFj3bcOLVbwgXPKtEfUkIhdP3eaUYih3QMgKvbtA/NWfGaPlfHWuR7B/1i1hF8rTN7
         m8H7PX34pZVxjeqJn1C3uOrB9Z56ZYJ0ZS1xq/nckc7NavrR/cor0vFD0dk6/mGLg4KH
         bsaVCQ/jb0/YFMnAEADTBxF1ZpRP4llYwDpjw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697276482; x=1697881282;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD19XeF5BvtsgMzfqAV9FVlhJA/PmZrwqnEN9hkKm1E=;
        b=gtGffvfXgUsLBNP86zj6lP2oCT0MIAiWCjGa9Rd666Xd6e1c3748RbedqyOq4SabTM
         Su95wCVAyJN5IVGFutqf++lJQ4D50uDZoxKisbn6OKk93xg0RRxzLzvGWsD56gtQZELq
         F7QzngQk5WmreSreMW25IUkNrY/3nJ9nGXX2BcP9fxePxfXC0sV1wzESa5B++2ELPh6s
         dhY8I2GQB0HD19wi6GhGJFVwpoZ1oSmdAaq8ICQwYaq3MBBsM7UNiZp2vn2TrsZiUBLB
         vZJSHdLWp4kD/A5QdXX/CorwGHZgofDVHs2RWDYNwuBbEIYiAwaqjSjJaFKRn4q2FUIk
         ZCXQ==
X-Gm-Message-State: AOJu0YzWGrJ9E/JJ7UbDucR9tJkp58Ng1mOr6g+767LscnwyYCLnxWz7
        TYZazxpn55J+LA4H5GlS4Rw9r650jjoZRzx6hcc=
X-Google-Smtp-Source: AGHT+IHf4yEoLvUzSS9JlYUYYI3TLU7hufbRT9Jpss3XHdqTHJ+J8BA0S7UuNRsbzdpAdIrthKZ8Vw==
X-Received: by 2002:a05:6512:1154:b0:506:93a0:777a with SMTP id m20-20020a056512115400b0050693a0777amr18375821lfg.2.1697276481957;
        Sat, 14 Oct 2023 02:41:21 -0700 (PDT)
Received: from ?IPv6:2001:8b0:aba:5f3c:66ae:9f57:4dbd:827d? ([2001:8b0:aba:5f3c:66ae:9f57:4dbd:827d])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b004053a6b8c41sm1485427wmq.12.2023.10.14.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Oct 2023 02:41:21 -0700 (PDT)
Message-ID: <1520ecb5f4b6959af835a7781b94694913f76912.camel@linuxfoundation.org>
Subject: Re: Kernel 6.5 ttyS1 hang with qemu (was Re: [OE-core] Summary of
 the remaining 6.5 kernel serial issue (and 6.5 summary)
From:   Richard Purdie <richard.purdie@linuxfoundation.org>
To:     Mikko Rapeli <mikko.rapeli@linaro.org>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     openembedded-core <openembedded-core@lists.openembedded.org>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Randy MacLeod <randy.macleod@windriver.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Date:   Sat, 14 Oct 2023 10:41:20 +0100
In-Reply-To: <ZSPQY6UYg21Z0PnN@nuoska>
References: <178BF2895FF685E6.5378@lists.openembedded.org>
         <a2ad67a0575548b6d5d8d187e597dcd72ae07f64.camel@linuxfoundation.org>
         <ZSPQY6UYg21Z0PnN@nuoska>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Mon, 2023-10-09 at 13:05 +0300, Mikko Rapeli wrote:
> Yocto Linux distro maintainer Richard Purdie is seeing a regression or be=
havior
> change after updating kernel from 6.4 to 6.5. Yocto runs a lot of automat=
ed tests with qemu
> where a python test framework configures and spawns qemu (version 8.1) wi=
th two
> serial ports and boots a newly built kernel and rootfs there. The python =
test framework
> tries to detect getty login prompt from ttyS1 while boot time logging
> from qemu, kernel, userspace etc happens on serial console ttyS0. This ha=
s worked
> reliably for years and across multiple kernel versions. Now with 6.5 kern=
el there are
> suddenly frequent failures where ttyS1 doesn't show the login prompt in t=
he python code
> which listens on the qemu socket from target system ttyS1. The target sys=
tem ttyS0 is working
> and boot time logs and getty prompt are visible there. The ttyS1 logs fro=
m test framework show
> that only two characters CR and LF make it through. This same happens on =
x86_64 host
> running qemu machine for x86_64 and arm64 targets.
>=20
> The kernel boot logs from target system with 6.5.5 don't show any errors =
and getty
> processes are started correctly and they don't see any errors either. Dat=
a from
> target system userspace is being written, but seems to sometimes hang ins=
ide kernel
> or qemu serial port buffers, and only on the ttyS1 while ttyS0 works reli=
ably all
> the time.
>=20
> Example target logs with 6.5.5 via ttyS0:
>=20
> https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_b=
oot_log.20231007084853
> or https://pastebin.com/raw/jRRa2CwW
>=20
> ttyS1 logs from the same run:
> https://autobuilder.yocto.io/pub/failed-builds-data/6.5%20kernel/j/qemu_b=
oot_log.20231007084853.2
>=20
> Kernel config:
> https://pastebin.com/raw/Lv9Hfeuh
>=20
> Do you have any ideas or hints how to debug or possibly fix this?
>=20
> tty layer has seen quite a few major changes between 6.4.14 and 6.5.5 and=
 we're not able
> to pinpoint or bisect the issue, since it so annoyingly rare.
>=20
> Some more details from Richard below.

Brief summary:

We're seeing an issue on x86_64 with 6.5.X where data appears to be
left in the transmission buffer and not sent to the port on the second
serial port (ttyS1) until we trigger it with intervention.

Paul Gortmaker did some painful bisection over a few days down to:

serial: core: Start managing serial controllers to enable runtime PM
https://lore.kernel.org/linux-serial/1431f5b4-fb39-483b-9314-ed2b7c118c11@g=
mail.com/T/#t

More details:

We run very simple plain images under qemu with two serial ports
configured. These are x86_64 images with two 16550A ports with the
standard x86 port addresses which appear as ttyS0 and ttyS1, nothing
special. We run a console and getty on ttyS0 and a getty on ttyS1.
After boot, we wait for a getty to appear on ttyS1, login to it and run
commands.

With 6.5.5 (and latest 6.5.X head as of yesterday), we see an issue say
1% of the time where the getty never appears on ttyS1 even after our
timeout of 1000s.

When this happens we've added code to login to the ttyS0 getty and run
debug commands. We've been able to confirm the getty is running and the
init system doesn't matter (happens with sysvinit and systemd). The
most interesting debug I've seen is this:

root@qemux86-64:~# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:418 rx:43 RTS|CTS|DTR|DSR|CD
1: uart:16550A port:000002F8 irq:3 tx:249 rx:0 RTS|CTS|DTR|DSR|CD
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3
root@qemux86-64:~# echo helloA > /dev/ttyS1
root@qemux86-64:~# echo helloB > /dev/ttyS0
helloB
root@qemux86-64:~# cat /proc/tty/driver/serial
serinfo:1.0 driver revision:
0: uart:16550A port:000003F8 irq:4 tx:803 rx:121 RTS|CTS|DTR|DSR|CD
1: uart:16550A port:000002F8 irq:3 tx:281 rx:0 RTS|CTS|DTR|DSR|CD
2: uart:unknown port:000003E8 irq:4
3: uart:unknown port:000002E8 irq:3

This is being run after the getty didn't appear for 60s on ttyS1 so
we've logged into ttyS0 and run these commands. We've seen that if it
doesn't appear after 60s, it won't appear after 1000s either.

The tx:249 is interesting as it should be tx:273, 273 being the number
of bytes our successful serial getty prompt has. Once we echo something
to the port (8 bytes), tx: jumps to 281, so it suddenly found our
missing login prompt. This is confirmed with the data appearing on the
port after the echo.

I did try disabling the autosuspend code in the commit above but it
made no difference.

Reproducing this is a pain. I thought I had a local setup doing it
fairly frequently, then spent an hour this morning without it happening
once.

I'm hoping someone might recognise what is going on here? I'm happy to
try and add debug or find further information if that would help narrow
it down.

Cheers,

Richard

