Return-Path: <SRS0=qFi8=25=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E757AC33C9E
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jan 2020 11:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C3720643
	for <linux-serial@archiver.kernel.org>; Wed,  8 Jan 2020 11:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIj0wELM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgAHLuF (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 8 Jan 2020 06:50:05 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34291 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgAHLuF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 8 Jan 2020 06:50:05 -0500
Received: by mail-ed1-f65.google.com with SMTP id l8so2338566edw.1
        for <linux-serial@vger.kernel.org>; Wed, 08 Jan 2020 03:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=hExIJD+zHWNB554cHv33qamU3DimKYovvQetdiySV84=;
        b=OIj0wELM6N2nXezQXM+2puIif58xZYE2q36F406yCQMSS7ThhrObB9hDvbXPODrzIO
         OwJiTCJ+laRH6QcOc7TpadRY5HVPBHbAS7qwU41ml4C9pNbvz4F39I8C/NtDuGGZ8fLB
         pm57rL8UpJ5I9xyJ3ZsZ6sTbvb821oRyUL+/b/s5q0WepOFokTGPbnv5Vb9xxIoLqc50
         7NG37oL0DBWztJVxCGWwt7UFxbWUKKqojOdNIAiwrQNkxtklFSMWiBn3n02BmILZbR7r
         W3e9M/wwweN0XBMENZHNlvSlMzu+ur0UEaVE7f94JC4qCHiTydEzxqVAdAQjfIdHXTEv
         wBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=hExIJD+zHWNB554cHv33qamU3DimKYovvQetdiySV84=;
        b=Qc5RqIeNLWeF/j5FSfvcGMgW94z0gh2SnW/Kq5Um+HXAb23BkORM98WsXralhFzTgA
         CpIr/qm8oO8DqWollHUTPKclSE0rxtv0h4rcCoSaJwV6qxZMNdcqZ0nljojHbej6OBUy
         9aCLpdwUrAnp3ni0UyhAcBlz/TzGcAbjiDdeJRgFRHJDrAs8lkiPZ4kEN3QIDItU3xE0
         /1cqe0ktxJCqVFtrFRmCdxjfwRxGlVWG59V93DK5EehMmC/j/93vxRokcwuSpkCNKal8
         4eq46Oll8y/KMbOiTcpLuWagW2Mg0M4CUpLBdVKP5gXrfBQm7pG3JirIZVXdrXQnkMD3
         5CoQ==
X-Gm-Message-State: APjAAAX3etABVsboQVWLEv9J2IrPgAVLI1o/gQJNROUrjsIQZTqXR8xO
        U7V+86s9AnEyMtxuC8uU84+INVOGRfktyKy8/gRSKQfqnDI=
X-Google-Smtp-Source: APXvYqysxhABTm6gQnAkJTstciw1dKLwOMNjQDz2O0vpXlvNJvo/99iDacL2dmwFGhLp71/6GmRzcMEOOeApumlv5zY=
X-Received: by 2002:a05:6402:2037:: with SMTP id ay23mr5128138edb.146.1578484203219;
 Wed, 08 Jan 2020 03:50:03 -0800 (PST)
MIME-Version: 1.0
From:   Belisko Marek <marek.belisko@gmail.com>
Date:   Wed, 8 Jan 2020 12:49:52 +0100
Message-ID: <CAAfyv37N4OSLtcLRGRRPUg2av6AAqCSu5snR1qv9e=wA74vX1w@mail.gmail.com>
Subject: 4.12 mainline crash in n_tty_receive_buf_common when using g_serial
To:     linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

Hi,

we're using mainline 4.12 kernel (bit too old I know) on am335x board.
We have case where we receive files over g_serial using zmodem
protocol. We send small files every second and after ~20 minutes or so
we hit this issue:

Workqueue: events_unbound flush_to_ldisc
task: ee32d100 task.stack: ef132000
PC is at n_tty_receive_buf_common+0x50/0x8d4
LR is at n_tty_receive_buf_common+0x40/0x8d4
pc : [<c0551e54>]    lr : [<c0551e44>]    psr: 200e0013
sp : ef133e38  ip : ef133e38  fp : ef133e94
r10: c0fc4378  r9 : 00000000  r8 : c05553fc
r7 : 00000014  r6 : 00000000  r5 : c05526d8  r4 : ee066200
r3 : 00002000  r2 : 00000001  r1 : 00000000  r0 : ee066258
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c53c7d  Table: ae728059  DAC: 00000051
Process kworker/u2:0 (pid: 7235, stack limit = 0xef132210)
Stack: (0xef133e38 to 0xef134000)
3e20:                                                       ef133e6c ef133e48
3e40: 00002cc3 ee066258 ee32d130 00000000 ee32d130 00000014 00000000 ee08d4a8
3e60: 00000000 ef133e70 c01519a8 00000014 c05526d8 00000000 00000014 c05553fc
3e80: 00000000 c0fc4378 ef133eac ef133e98 c05526fc c0551e10 00000001 ef133ea8
3ea0: ef133ec4 ef133eb0 c0554a1c c05526e4 ee08d4a8 ee0da040 ef133ee4 ef133ec8
3ec0: c0555450 c05549f8 ee08d400 ee6cfc04 ee6cfc14 ee6cfc00 ef133f0c ef133ee8
3ee0: c0554c2c c0555408 ee540980 ee6cfc04 ef002400 00000000 ef02d100 00000000
3f00: ef133f44 ef133f10 c014a1a8 c0554ba4 c0f28d80 ef002414 ee540998 ee540980
3f20: ef002400 ef002400 c0f28d80 ef002414 ee540998 00000088 ef133f74 ef133f48
3f40: c014b000 c0149f44 00000000 ee302340 ee302ac0 ef132000 00000000 ee540980
3f60: c014acf4 ee4d7eac ef133fac ef133f78 c014ff90 c014ad00 ee302358 ee302358
3f80: ef133fac ee302ac0 c014fe44 00000000 00000000 00000000 00000000 00000000
3fa0: 00000000 ef133fb0 c0107b08 c014fe50 00000000 00000000 00000000 00000000
3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 2ecc2ecc 2ecc2ecc
[<c0551e54>] (n_tty_receive_buf_common) from [<c05526fc>]
(n_tty_receive_buf2+0x24/0x2c)
[<c05526fc>] (n_tty_receive_buf2) from [<c0554a1c>]
(tty_ldisc_receive_buf+0x30/0x68)
[<c0554a1c>] (tty_ldisc_receive_buf) from [<c0555450>]
(tty_port_default_receive_buf+0x54/0x64)
[<c0555450>] (tty_port_default_receive_buf) from [<c0554c2c>]
(flush_to_ldisc+0x94/0xb4)
[<c0554c2c>] (flush_to_ldisc) from [<c014a1a8>] (process_one_work+0x270/0x440)
[<c014a1a8>] (process_one_work) from [<c014b000>] (worker_thread+0x30c/0x498)
[<c014b000>] (worker_thread) from [<c014ff90>] (kthread+0x14c/0x164)
[<c014ff90>] (kthread) from [<c0107b08>] (ret_from_fork+0x14/0x2c)
Code: e3a03000 e50b3048 e51b303c e2833a02 (e5930244)

I disassemble function call and area is:

(gdb) l * n_tty_receive_buf_common+0x50
0xc054d064 is in n_tty_receive_buf_common (drivers/tty/n_tty.c:1692).
1687 * the consumer has loaded the data in read_buf up to the new
1688 * read_tail (so this producer will not overwrite unread data)
1689 */
1690 size_t tail = smp_load_acquire(&ldata->read_tail);
1691
1692 room = N_TTY_BUF_SIZE - (ldata->read_head - tail);
1693 if (I_PARMRK(tty))
1694 room = (room + 2) / 3;
1695 room--;
1696 if (room <= 0) {

so maybe ldata is not initialized and thus we got crash? Any ideas?
Thanks a lot for any pointers.

BR,

marek

-- 
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
