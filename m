Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B11C433EF
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jun 2022 08:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiFHI7Y (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jun 2022 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiFHI6M (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jun 2022 04:58:12 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C4D3E48CC
        for <linux-serial@vger.kernel.org>; Wed,  8 Jun 2022 01:19:07 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w27so25979102edl.7
        for <linux-serial@vger.kernel.org>; Wed, 08 Jun 2022 01:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/9gTq8k/C1m1nvZDMiEqrbnsQxKqOeb6pbbmmwGiibQ=;
        b=ax3teiv/J/SXrUeQ6uB7rXgl+HmE/NaTilzoraYBU6qFYVNtgyxHi8lS0jABRzrdMw
         lajagWp8F/Kk4rkgdt4+sMt+PVIcM4qrJVHCoS3sB+DujHEztrlqSS4zYmrcgazd/cOi
         9gd5pfgOK460F2jwcPoTT5J0AmAxWQZO6VJkpidH9svnBn3h5DB8RyzKm5Ye4vylmWn/
         DF9oNzReGIN0E/aOgdnC4ZI6uhjopA8O6YV1NI9QaaeDHRhWHLyCjFmSWvFMusi5Ah1n
         /At/3Mbi5eK1BbNm0X3V9GQDonDMcSWCNT9nchtqpQzaMMcctEKlk+PXlongSwIz31bP
         I32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/9gTq8k/C1m1nvZDMiEqrbnsQxKqOeb6pbbmmwGiibQ=;
        b=EK+z9sPKv4AWKoore5HmR9KubSiE9a79hlbwj4OmPItaMV3sZXYJUTgCuRuTIklEjP
         J/12tDyD0Aml15Ou49B8cZGz3HMN/DFccGnXpcEBAEgmnhEvaU7e7aROUb60Z8sS0mAg
         RjmTD4XOh6cV0xHgraCxdMobI6g2PQ+4mL9wLUWQ2NJPQwsQQbuPIrxijN2SAVEvzj8e
         S2xgFqBgoV8vXz6pMPX1U2/tCQSjf63/ZQ5mZmU7L9VlY8ZfzF3hW5nKJvgwcSDjCSCB
         CTI5OTMW2a4Rue/bpf/kACDePg/8hjqN3EvCCIcfzElJF6d8cGJ6gZex+AZbJc9lb+0s
         lxpQ==
X-Gm-Message-State: AOAM533p9PxvUcw9KIN8pW8cUyfKoRy4vpG9g+oPPv4e4xNR/1YyNtkU
        Fgu+8BX1KIKwJXZICleegg+N5IlQLKiBJxG/4nTcEIGbaXZ7mw==
X-Google-Smtp-Source: ABdhPJyBATBnb0JMaUykG02ApUpptOf84RF8efKnsvSkIWFtaN7xBBqVU6ty9MykEpt85Ep3Ztcz1aMKad41uSg3Je0=
X-Received: by 2002:a05:6402:26c5:b0:42e:1708:c09a with SMTP id
 x5-20020a05640226c500b0042e1708c09amr34720544edd.133.1654676344017; Wed, 08
 Jun 2022 01:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com>
In-Reply-To: <45e1eac1-1818-1f8c-6168-cff6be6427af@linux.intel.com>
From:   =?UTF-8?Q?Nuno_Gon=C3=A7alves?= <nunojpg@gmail.com>
Date:   Wed, 8 Jun 2022 09:18:52 +0100
Message-ID: <CAEXMXLRrysT_+RUZ4sg6DGT8Hzdv2jrzX2eZ2Z0mPu39y3-m7g@mail.gmail.com>
Subject: Re: [PATCH] serial: pl011: UPSTAT_AUTORTS requires .throttle/unthrottle
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Tomasz Mon <tomasz.mon@camlingroup.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-serial <linux-serial@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Fri, Apr 29, 2022 at 12:24 PM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> The driver must provide throttle and unthrottle in uart_ops when it
> sets UPSTAT_AUTORTS. Add them using existing stop_rx &
> enable_interrupts functions.
>
> Compile tested (w/o linking).
>
> Reported-by: Nuno Gon=C3=A7alves <nunojpg@gmail.com>
> Fixes: 2a76fa283098 (serial: pl011: Adopt generic flag to store auto
>                      RTS status)
> Cc: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>
> ---
>
> Maybe this one is the correct solution (I'm not able to test on the real
> hw though)?

I still get a crash with your patch:

[  827.145500] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[  827.154515] Mem abort info:
[  827.157394]   ESR =3D 0x86000005
[  827.160538]   EC =3D 0x21: IABT (current EL), IL =3D 32 bits
[  827.165979]   SET =3D 0, FnV =3D 0
[  827.169115]   EA =3D 0, S1PTW =3D 0
[  827.172332]   FSC =3D 0x05: level 1 translation fault
[  827.177320] user pgtable: 4k pages, 39-bit VAs, pgdp=3D00000000043f2000
[  827.183900] [0000000000000000] pgd=3D0000000000000000,
p4d=3D0000000000000000, pud=3D0000000000000000
[  827.192815] Internal error: Oops: 86000005 [#1] PREEMPT SMP
[  827.198488] CPU: 2 PID: 372 Comm: kworker/u8:0 Tainted: G        W
       5.18.2 #1
[  827.206356] Hardware name: Raspberry Pi Compute Module 3 Plus Rev 1.0 (D=
T)
[  827.213339] Workqueue: events_unbound flush_to_ldisc
[  827.218407] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[  827.225481] pc : 0x0
[  827.227701] lr : uart_throttle+0x94/0x160
[  827.231777] sp : ffffffc00804bbd0
[  827.235137] x29: ffffffc00804bbd0 x28: 0000000000000000 x27: 00000000000=
00077
[  827.242398] x26: ffffff8001d74c00 x25: ffffffc0082a1000 x24: 00000000000=
00000
[  827.249658] x23: 0000000000000008 x22: ffffff8002a5c058 x21: ffffff80024=
95080
[  827.256918] x20: ffffff8001d74c00 x19: 0000000000000024 x18: 00000000000=
00000
[  827.264178] x17: 0000000000000000 x16: 0000000000000000 x15: 00000000000=
00000
[  827.271439] x14: 0000000000000000 x13: 0000000000000000 x12: 00000000000=
00000
[  827.278696] x11: 000000000000015a x10: 0000000000001a60 x9 : ffffffe59a7=
4aed4
[  827.285957] x8 : fefefefefefefeff x7 : 0000000000000000 x6 : 00000000000=
00000
[  827.293216] x5 : 0000000000000001 x4 : ffffff8002618000 x3 : 00000000000=
0000d
[  827.300474] x2 : 0000000000000004 x1 : 0000000000000000 x0 : ffffff80024=
95080
[  827.307732] Call trace:
[  827.310212]  0x0
[  827.312077]  tty_throttle_safe+0xb4/0xe0
[  827.316067]  n_tty_receive_buf_common+0x760/0x1350
[  827.320937]  n_tty_receive_buf2+0x20/0x30
[  827.325013]  tty_ldisc_receive_buf+0x2c/0x80
[  827.329353]  tty_port_default_receive_buf+0x50/0x90
[  827.334311]  flush_to_ldisc+0xfc/0x140
[  827.338122]  process_one_work+0x1dc/0x450
[  827.342201]  worker_thread+0x154/0x450
[  827.346012]  kthread+0x100/0x110
[  827.349292]  ret_from_fork+0x10/0x20
[  827.352934] Code: bad PC value
[  827.356036] ---[ end trace 0000000000000000 ]---

Thanks,
Nuno
