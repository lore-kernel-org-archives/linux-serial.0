Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C41AC433DF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 19:11:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43A5C206E9
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595358663;
	bh=OlmCX2de/3OxbnjjVkYRe3fW0bGYvRFlFzYJVgpLwhc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kvokrrK0xvILwVLmHlODZpjvsbBDi67bvyYIgznyk+8UE64UUBYWp9azitQsOyJsI
	 fTZJGfopixzXGl8bcBRYG/TtuvvioC5WH8c9nol/r66ZPHmcpQYSYruNLyG/tI90Td
	 XYFwuZ8U4JCgddUF6/2mrZ55pTzFk+wH5Ui8PT5s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgGUTLC (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:11:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726960AbgGUTLB (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 15:11:01 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5521420672;
        Tue, 21 Jul 2020 19:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595358660;
        bh=OlmCX2de/3OxbnjjVkYRe3fW0bGYvRFlFzYJVgpLwhc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oebsANsy49BHYSke+RFZfL+t8n9fPF3BLcmXjooGoTG0jsIdJOoR64J+ZLLy47IIw
         LskPo93YTdGVsT4EvxwxMZTczZHKZjohsi+wTP4kSvZ55I+8g/Au8NzcHJ7t8ACfSd
         7aUmnDA1it6zGeMJ/xCs3E48NCyZiutWg0gOrZGs=
Date:   Tue, 21 Jul 2020 21:11:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, Hanjun Guo <guohanjun@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>
Subject: Re: [PATCH] serial: 8250: fix null-ptr-deref in serial8250_start_tx()
Message-ID: <20200721191108.GB2605882@kroah.com>
References: <20200721143852.4058352-1-yangyingliang@huawei.com>
 <20200721104819.GA1678476@kroah.com>
 <b0cbee3f-05cd-b15c-06db-68c223c9944c@huawei.com>
 <571a38df-37a3-3680-bea0-b4698d4b417a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <571a38df-37a3-3680-bea0-b4698d4b417a@huawei.com>
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

On Tue, Jul 21, 2020 at 08:18:11PM +0800, Yang Yingliang wrote:
> 
> On 2020/7/21 19:54, Yang Yingliang wrote:
> > 
> > On 2020/7/21 18:48, Greg KH wrote:
> > > On Tue, Jul 21, 2020 at 02:38:52PM +0000, Yang Yingliang wrote:
> > > > I got null-ptr-deref in serial8250_start_tx():
> > > > 
> > > > [   78.114630] Unable to handle kernel NULL pointer dereference
> > > > at virtual address 0000000000000000
> > > > [   78.123778] Mem abort info:
> > > > [   78.126560]   ESR = 0x86000007
> > > > [   78.129603]   EC = 0x21: IABT (current EL), IL = 32 bits
> > > > [   78.134891]   SET = 0, FnV = 0
> > > > [   78.137933]   EA = 0, S1PTW = 0
> > > > [   78.141064] user pgtable: 64k pages, 48-bit VAs,
> > > > pgdp=00000027d41a8600
> > > > [   78.147562] [0000000000000000] pgd=00000027893f0003,
> > > > p4d=00000027893f0003, pud=00000027893f0003,
> > > > pmd=00000027c9a20003, pte=0000000000000000
> > > > [   78.160029] Internal error: Oops: 86000007 [#1] SMP
> > > > [   78.164886] Modules linked in: sunrpc vfat fat aes_ce_blk
> > > > crypto_simd cryptd aes_ce_cipher crct10dif_ce ghash_ce sha2_ce
> > > > sha256_arm64 sha1_ce ses enclosure sg sbsa_gwdt ipmi_ssif
> > > > spi_dw_mmio sch_fq_codel vhost_net tun vhost vhost_iotlb tap
> > > > ip_tables ext4 mbcache jbd2 ahci hisi_sas_v3_hw libahci
> > > > hisi_sas_main libsas hns3 scsi_transport_sas hclge libata
> > > > megaraid_sas ipmi_si hnae3 ipmi_devintf ipmi_msghandler
> > > > br_netfilter bridge stp llc nvme nvme_core xt_sctp sctp
> > > > libcrc32c dm_mod nbd
> > > > [   78.207383] CPU: 11 PID: 23258 Comm: null-ptr Not tainted
> > > > 5.8.0-rc6+ #48
> > > > [   78.214056] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC,
> > > > BIOS 2280-V2 CS V3.B210.01 03/12/2020
> > > > [   78.222888] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
> > > > [   78.228435] pc : 0x0
> > > > [   78.230618] lr : serial8250_start_tx+0x160/0x260
> > > > [   78.235215] sp : ffff800062eefb80
> > > > [   78.238517] x29: ffff800062eefb80 x28: 0000000000000fff
> > > > [   78.243807] x27: ffff800062eefd80 x26: ffff202fd83b3000
> > > > [   78.249098] x25: ffff800062eefd80 x24: ffff202fd83b3000
> > > > [   78.254388] x23: ffff002fc5e50be8 x22: 0000000000000002
> > > > [   78.259679] x21: 0000000000000001 x20: 0000000000000000
> > > > [   78.264969] x19: ffffa688827eecc8 x18: 0000000000000000
> > > > [   78.270259] x17: 0000000000000000 x16: 0000000000000000
> > > > [   78.275550] x15: ffffa68881bc67a8 x14: 00000000000002e6
> > > > [   78.280841] x13: ffffa68881bc67a8 x12: 000000000000c539
> > > > [   78.286131] x11: d37a6f4de9bd37a7 x10: ffffa68881cccff0
> > > > [   78.291421] x9 : ffffa68881bc6000 x8 : ffffa688819daa88
> > > > [   78.296711] x7 : ffffa688822a0f20 x6 : ffffa688819e0000
> > > > [   78.302002] x5 : ffff800062eef9d0 x4 : ffffa68881e707a8
> > > > [   78.307292] x3 : 0000000000000000 x2 : 0000000000000002
> > > > [   78.312582] x1 : 0000000000000001 x0 : ffffa688827eecc8
> > > > [   78.317873] Call trace:
> > > > [   78.320312]  0x0
> > > > [   78.322147]  __uart_start.isra.9+0x64/0x78
> > > > [   78.326229]  uart_start+0xb8/0x1c8
> > > > [   78.329620]  uart_flush_chars+0x24/0x30
> > > > [   78.333442]  n_tty_receive_buf_common+0x7b0/0xc30
> > > > [   78.338128]  n_tty_receive_buf+0x44/0x2c8
> > > > [   78.342122]  tty_ioctl+0x348/0x11f8
> > > > [   78.345599]  ksys_ioctl+0xd8/0xf8
> > > > [   78.348903]  __arm64_sys_ioctl+0x2c/0xc8
> > > > [   78.352812]  el0_svc_common.constprop.2+0x88/0x1b0
> > > > [   78.357583]  do_el0_svc+0x44/0xd0
> > > > [   78.360887]  el0_sync_handler+0x14c/0x1d0
> > > > [   78.364880]  el0_sync+0x140/0x180
> > > > [   78.368185] Code: bad PC value
> > > > 
> > > > SERIAL_PORT_DFNS is not defined on each arch, if it's not defined,
> > > > serial8250_set_defaults() won't be called in
> > > > serial8250_isa_init_ports(),
> > > > so the p->serial_in pointer won't be initialized, and it leads a
> > > > null-ptr-deref.
> > > > Fix this problem by calling serial8250_set_defaults() after init
> > > > uart port.
> > > > 
> > > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > > > ---
> > > >   drivers/tty/serial/8250/8250_core.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > Does this fix a specific commit, or has this issue always been present?
> > > What has caused it to happen now that no one else has seen this?
> > 
> > I think it's always been present on the arch that not defined
> > SERIAL_PORT_DFNS.
> > 
> > I got this on arm64 and here is the C reproducer:
> > 
> > // autogenerated by syzkaller (https://github.com/google/syzkaller)
> > 
> > #define _GNU_SOURCE
> > 
> > #include <endian.h>
> > #include <stdint.h>
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <string.h>
> > #include <sys/syscall.h>
> > #include <sys/types.h>
> > #include <unistd.h>
> > 
> > #ifndef __NR_ioctl
> > #define __NR_ioctl 29
> > #endif
> > #ifndef __NR_mmap
> > #define __NR_mmap 222
> > #endif
> > #ifndef __NR_openat
> > #define __NR_openat 56
> > #endif
> > 
> > uint64_t r[1] = {0xffffffffffffffff};
> > 
> > int main(void)
> > {
> >     syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
> >     intptr_t res = 0;
> >     memcpy((void*)0x20000040, "/dev/ttyS3\000", 11);
> >     res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20000040ul,
> > 0x401ul, 0ul);
> >     if (res != -1)
> >         r[0] = res;
> >     syscall(__NR_ioctl, r[0], 0x5412ul, 0x20000080ul);
> >     return 0;
> > }
> > 
> It's can be reproduced with CONFIG_SERIAL_8250_RUNTIME_UARTS=8 and
> 
> by opening ttyS4 on x86_64. Because the size of SERIAL_PORT_DFNS is 4 and
> 
> the pointers of ttyS4 ~ ttyS7 won't be initialized.

Ah, good catch, yeah, that's not nice.  I'll go queue this up now,
thanks for the fix!

greg k-h
