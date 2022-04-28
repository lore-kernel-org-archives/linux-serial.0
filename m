Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD7EC433F5
	for <linux-serial@archiver.kernel.org>; Thu, 28 Apr 2022 09:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbiD1Jt2 (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Thu, 28 Apr 2022 05:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346449AbiD1JZG (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 28 Apr 2022 05:25:06 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301527B13F
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 02:21:52 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 4so5848416ljw.11
        for <linux-serial@vger.kernel.org>; Thu, 28 Apr 2022 02:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3JA4lxLSqbPf6ggQe5haf9L9x4OQzh2NwHfmUTJTt5w=;
        b=NqAdiTDn8QFa+uC/p72qty9Ebyw+hctcwtTeKfxMmi5snpAiTHAUcYCgoBgXTsjcuu
         9RqZQPYeiixZxrkCdK1PvbKOI0q0pCtdIfO+g4RQ8G+T5bOXWMaagbMtTunegiGIxfRq
         OLT+wzLKOXqXzdDYV94ESF/Q/0YIZ0kDyXAwUIGUE8VV+hnXP9io7tHUUM6ez7TX4RdL
         nsQSILML2sD7tI1Td5V5q7sQNOv4mhOKKCRJhVSNKltEqaVaEoeW+K4ryqEfyJj++vdf
         EF+FnbzBF8KEHdOoq5rOMkWJ+SuIpJ8GpW+sG9yuJiUQ40v3u5q6FTqePCT2UtG+IlC8
         XPnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3JA4lxLSqbPf6ggQe5haf9L9x4OQzh2NwHfmUTJTt5w=;
        b=eI24BMvq28YSkeZRqqlLUgsHLeSW7SPR8Z1vMQHYeiz5KO2Ygeytr4PjzGGQe+56xc
         XVHw6ZnKodNDZxZR//xm8G/bHezGPNxiaU9cknTRN4CVI60R9/sCfnvDslsND72ag1TY
         G3Ul19f5qVZSYvjInDZ7elmosLkxAZvW5gkxDqwR/7BPHClw1+wVi9tALLLrZS4xkt3F
         Ffm55ENJWPnZnkCctkVPFBaQrDfU68E9P+x2pRUtq8Jj2U3uksskHYVGmxJjK2CtrxPO
         rym32olEVQ3o7+W9tWe9Z5oKQ7XRvw6YWLaUnQqY9dovxNJqp7+uTYNSzowFekKzzM9G
         Y5lw==
X-Gm-Message-State: AOAM532NjxFkaYFlOrJDEs2dOWo9jPB4UqUzCLAoQTiVuRVKwonOvhwJ
        ZrNei20z1AD4XrQZDrnW3Ch8UGGQAxm5x6qnlO8vLeG67QnEf+e6
X-Google-Smtp-Source: ABdhPJxFOIOUJ6WITFfRI/UNjVyNoQofaCsSAaNh1ZfyRKvaeASPOCUjKM+M8FeYfELBCsyYW1z4WOwxnbEd7kBr61U=
X-Received: by 2002:a2e:bf1d:0:b0:247:dea7:f657 with SMTP id
 c29-20020a2ebf1d000000b00247dea7f657mr20890776ljr.454.1651137710034; Thu, 28
 Apr 2022 02:21:50 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Thu, 28 Apr 2022 11:21:39 +0200
Message-ID: <CAEXMXLR_4=UcGCHJPbFj_U1kbshFj=p00TOHNHcBv8bCCcis=Q@mail.gmail.com>
Subject: pl011 (Raspberry Pi) crash
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

I started to use the mainline recently for the Raspberry Pi and get
often this crash. I get it rarely and also don't have a history with
previous versions, so it's hard to bisect this.

Got this with 5.18.0-rc4 also.

Port is pl011, with hardware flow control and baud at 2Mbps.

# [ 2742.199002] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[ 2742.207997] Mem abort info:
[ 2742.210880] ESR = 0x86000005
[ 2742.214024] EC = 0x21: IABT (current EL), IL = 32 bits
[ 2742.219456] SET = 0, FnV = 0
[ 2742.222583] EA = 0, S1PTW = 0
[ 2742.225802] FSC = 0x05: level 1 translation fault
[ 2742.230803] user pgtable: 4k pages, 39-bit VAs, pgdp=00000000045d0000
[ 2742.237429] [0000000000000000] pgd=0000000000000000,
p4d=0000000000000000, pud=0000000000000000
[ 2742.246339] Internal error: Oops: 86000005 [#1] PREEMPT SMP
[ 2742.252016] CPU: 3 PID: 192 Comm: kworker/u8:3 Not tainted 5.18.0-rc3 #1
[ 2742.258828] Hardware name: Raspberry Pi Compute Module 3 IO board V3.0 (DT)
[ 2742.265896] Workqueue: events_unbound flush_to_ldisc
[ 2742.270959] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[ 2742.278032] pc : 0x0
[ 2742.280253] lr : uart_throttle+0x94/0x160
[ 2742.284331] sp : ffffffc0095abbd0
[ 2742.287692] x29: ffffffc0095abbd0 x28: 0000000000000000 x27: 0000000000000077
[ 2742.294953] x26: ffffff800261d400 x25: ffffffc009241000 x24: 0000000000000000
[ 2742.302214] x23: 0000000000000008 x22: ffffff8002635610 x21: ffffff8001fb9080
[ 2742.309476] x20: ffffff800261d400 x19: 0000000000000024 x18: 000000457a869a76
[ 2742.316736] x17: 0000000000000001 x16: 0000000000000001 x15: 0014070c74d6ecfa
[ 2742.323994] x14: 00140abfb6d3354a x13: ffffffc00892c468 x12: 00000000fa83b2da
[ 2742.331256] x11: 00000000000002b6 x10: 0000000000001a40 x9 : ffffffc00854b374
[ 2742.338517] x8 : fefefefefefefeff x7 : 0000000000000000 x6 : 0000000000000000
[ 2742.345775] x5 : 0000000000000001 x4 : ffffff80025b0000 x3 : 000000000000000d
[ 2742.353034] x2 : 0000000000000004 x1 : 0000000000000000 x0 : ffffff8001fb9080
[ 2742.360294] Call trace:
[ 2742.362773] 0x0
[ 2742.364642] tty_throttle_safe+0xb4/0xe0
[ 2742.368636] n_tty_receive_buf_common+0x760/0x1350
[ 2742.373509] n_tty_receive_buf2+0x20/0x30
[ 2742.377582] tty_ldisc_receive_buf+0x2c/0x80
[ 2742.381921] tty_port_default_receive_buf+0x50/0x90
[ 2742.386879] flush_to_ldisc+0xfc/0x140
[ 2742.390689] process_one_work+0x1dc/0x450
[ 2742.394768] worker_thread+0x154/0x450
[ 2742.398579] kthread+0x100/0x110
[ 2742.401859] ret_from_fork+0x10/0x20
[ 2742.405504] Code: bad PC value
[ 2742.408607] ---[ end trace 0000000000000000 ]---

Thanks,
Nuno
