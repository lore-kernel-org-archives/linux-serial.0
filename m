Return-Path: <SRS0=EuFA=BA=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DD4C433DF
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F7FA21702
	for <linux-serial@archiver.kernel.org>; Tue, 21 Jul 2020 12:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgGUMSa (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Tue, 21 Jul 2020 08:18:30 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8345 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726715AbgGUMSa (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Tue, 21 Jul 2020 08:18:30 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C43DCBD069A4045BE7D7;
        Tue, 21 Jul 2020 20:18:22 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.211) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Tue, 21 Jul 2020
 20:18:11 +0800
Subject: Re: [PATCH] serial: 8250: fix null-ptr-deref in serial8250_start_tx()
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <jslaby@suse.com>, Hanjun Guo <guohanjun@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>
References: <20200721143852.4058352-1-yangyingliang@huawei.com>
 <20200721104819.GA1678476@kroah.com>
 <b0cbee3f-05cd-b15c-06db-68c223c9944c@huawei.com>
Message-ID: <571a38df-37a3-3680-bea0-b4698d4b417a@huawei.com>
Date:   Tue, 21 Jul 2020 20:18:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <b0cbee3f-05cd-b15c-06db-68c223c9944c@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.176.211]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org


On 2020/7/21 19:54, Yang Yingliang wrote:
>
> On 2020/7/21 18:48, Greg KH wrote:
>> On Tue, Jul 21, 2020 at 02:38:52PM +0000, Yang Yingliang wrote:
>>> I got null-ptr-deref in serial8250_start_tx():
>>>
>>> [   78.114630] Unable to handle kernel NULL pointer dereference at 
>>> virtual address 0000000000000000
>>> [   78.123778] Mem abort info:
>>> [   78.126560]   ESR = 0x86000007
>>> [   78.129603]   EC = 0x21: IABT (current EL), IL = 32 bits
>>> [   78.134891]   SET = 0, FnV = 0
>>> [   78.137933]   EA = 0, S1PTW = 0
>>> [   78.141064] user pgtable: 64k pages, 48-bit VAs, 
>>> pgdp=00000027d41a8600
>>> [   78.147562] [0000000000000000] pgd=00000027893f0003, 
>>> p4d=00000027893f0003, pud=00000027893f0003, pmd=00000027c9a20003, 
>>> pte=0000000000000000
>>> [   78.160029] Internal error: Oops: 86000007 [#1] SMP
>>> [   78.164886] Modules linked in: sunrpc vfat fat aes_ce_blk 
>>> crypto_simd cryptd aes_ce_cipher crct10dif_ce ghash_ce sha2_ce 
>>> sha256_arm64 sha1_ce ses enclosure sg sbsa_gwdt ipmi_ssif 
>>> spi_dw_mmio sch_fq_codel vhost_net tun vhost vhost_iotlb tap 
>>> ip_tables ext4 mbcache jbd2 ahci hisi_sas_v3_hw libahci 
>>> hisi_sas_main libsas hns3 scsi_transport_sas hclge libata 
>>> megaraid_sas ipmi_si hnae3 ipmi_devintf ipmi_msghandler br_netfilter 
>>> bridge stp llc nvme nvme_core xt_sctp sctp libcrc32c dm_mod nbd
>>> [   78.207383] CPU: 11 PID: 23258 Comm: null-ptr Not tainted 
>>> 5.8.0-rc6+ #48
>>> [   78.214056] Hardware name: Huawei TaiShan 2280 V2/BC82AMDC, BIOS 
>>> 2280-V2 CS V3.B210.01 03/12/2020
>>> [   78.222888] pstate: 80400089 (Nzcv daIf +PAN -UAO BTYPE=--)
>>> [   78.228435] pc : 0x0
>>> [   78.230618] lr : serial8250_start_tx+0x160/0x260
>>> [   78.235215] sp : ffff800062eefb80
>>> [   78.238517] x29: ffff800062eefb80 x28: 0000000000000fff
>>> [   78.243807] x27: ffff800062eefd80 x26: ffff202fd83b3000
>>> [   78.249098] x25: ffff800062eefd80 x24: ffff202fd83b3000
>>> [   78.254388] x23: ffff002fc5e50be8 x22: 0000000000000002
>>> [   78.259679] x21: 0000000000000001 x20: 0000000000000000
>>> [   78.264969] x19: ffffa688827eecc8 x18: 0000000000000000
>>> [   78.270259] x17: 0000000000000000 x16: 0000000000000000
>>> [   78.275550] x15: ffffa68881bc67a8 x14: 00000000000002e6
>>> [   78.280841] x13: ffffa68881bc67a8 x12: 000000000000c539
>>> [   78.286131] x11: d37a6f4de9bd37a7 x10: ffffa68881cccff0
>>> [   78.291421] x9 : ffffa68881bc6000 x8 : ffffa688819daa88
>>> [   78.296711] x7 : ffffa688822a0f20 x6 : ffffa688819e0000
>>> [   78.302002] x5 : ffff800062eef9d0 x4 : ffffa68881e707a8
>>> [   78.307292] x3 : 0000000000000000 x2 : 0000000000000002
>>> [   78.312582] x1 : 0000000000000001 x0 : ffffa688827eecc8
>>> [   78.317873] Call trace:
>>> [   78.320312]  0x0
>>> [   78.322147]  __uart_start.isra.9+0x64/0x78
>>> [   78.326229]  uart_start+0xb8/0x1c8
>>> [   78.329620]  uart_flush_chars+0x24/0x30
>>> [   78.333442]  n_tty_receive_buf_common+0x7b0/0xc30
>>> [   78.338128]  n_tty_receive_buf+0x44/0x2c8
>>> [   78.342122]  tty_ioctl+0x348/0x11f8
>>> [   78.345599]  ksys_ioctl+0xd8/0xf8
>>> [   78.348903]  __arm64_sys_ioctl+0x2c/0xc8
>>> [   78.352812]  el0_svc_common.constprop.2+0x88/0x1b0
>>> [   78.357583]  do_el0_svc+0x44/0xd0
>>> [   78.360887]  el0_sync_handler+0x14c/0x1d0
>>> [   78.364880]  el0_sync+0x140/0x180
>>> [   78.368185] Code: bad PC value
>>>
>>> SERIAL_PORT_DFNS is not defined on each arch, if it's not defined,
>>> serial8250_set_defaults() won't be called in 
>>> serial8250_isa_init_ports(),
>>> so the p->serial_in pointer won't be initialized, and it leads a 
>>> null-ptr-deref.
>>> Fix this problem by calling serial8250_set_defaults() after init 
>>> uart port.
>>>
>>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
>>> ---
>>>   drivers/tty/serial/8250/8250_core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> Does this fix a specific commit, or has this issue always been present?
>> What has caused it to happen now that no one else has seen this?
>
> I think it's always been present on the arch that not defined 
> SERIAL_PORT_DFNS.
>
> I got this on arm64 and here is the C reproducer:
>
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
>
> #define _GNU_SOURCE
>
> #include <endian.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <unistd.h>
>
> #ifndef __NR_ioctl
> #define __NR_ioctl 29
> #endif
> #ifndef __NR_mmap
> #define __NR_mmap 222
> #endif
> #ifndef __NR_openat
> #define __NR_openat 56
> #endif
>
> uint64_t r[1] = {0xffffffffffffffff};
>
> int main(void)
> {
>     syscall(__NR_mmap, 0x20000000ul, 0x1000000ul, 3ul, 0x32ul, -1, 0);
>     intptr_t res = 0;
>     memcpy((void*)0x20000040, "/dev/ttyS3\000", 11);
>     res = syscall(__NR_openat, 0xffffffffffffff9cul, 0x20000040ul, 
> 0x401ul, 0ul);
>     if (res != -1)
>         r[0] = res;
>     syscall(__NR_ioctl, r[0], 0x5412ul, 0x20000080ul);
>     return 0;
> }
>
It's can be reproduced with CONFIG_SERIAL_8250_RUNTIME_UARTS=8 and

by opening ttyS4 on x86_64. Because the size of SERIAL_PORT_DFNS is 4 and

the pointers of ttyS4 ~ ttyS7 won't be initialized.


[   49.427884] BUG: unable to handle kernel NULL pointer dereference at 
0000000000000000
[   49.432786] PGD 80000003d7573067 P4D 80000003d7573067 PUD 3d7526067 PMD 0
[   49.436944] Oops: 0010 [#1] SMP KASAN PTI
[   49.439490] CPU: 1 PID: 2491 Comm: test Not tainted 4.19.90+ #1083
[   49.443437] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), 
BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[   49.450233] RIP: 0010:          (null)
[   49.452279] Code: Bad RIP value.
[   49.454066] RSP: 0018:ffff8883d73a7880 EFLAGS: 00010093
[   49.457082] RAX: ffff8883d72d6000 RBX: ffffffff85e243a0 RCX: 
ffffffff820a062b
[   49.460916] RDX: 0000000000000002 RSI: 0000000000000001 RDI: 
ffffffff85e243a0
[   49.464490] RBP: 0000000000000002 R08: fffffbfff0bc4875 R09: 
fffffbfff0bc4874
[   49.467993] R10: fffffbfff0bc4874 R11: ffffffff85e243a3 R12: 
ffffffff85e245f6
[   49.471526] R13: ffffffff85e243f0 R14: 0000000000000000 R15: 
0000000000000000
[   49.475192] FS:  0000000002064880(0000) GS:ffff8883eb240000(0000) 
knlGS:0000000000000000
[   49.479019] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   49.481852] CR2: ffffffffffffffd6 CR3: 00000003d77a2006 CR4: 
0000000000020ee0
[   49.485131] Call Trace:
[   49.486278]  serial8250_start_tx+0x56c/0x9b0
[   49.488167]  __uart_start.isra.1+0x16a/0x1b0
[   49.490082]  uart_start+0x1a7/0x340
[   49.491650]  ? __uart_start.isra.1+0x1b0/0x1b0
[   49.493670]  ? __process_echoes+0x636/0x860
[   49.495540]  ? uart_start+0x340/0x340
[   49.497442]  n_tty_receive_buf_common+0x10ff/0x2460
[   49.499897]  ? n_tty_receive_buf2+0x40/0x40
[   49.501915]  tty_ioctl+0x6e1/0x1400
[   49.503629]  ? quarantine_put+0xb7/0x150
[   49.505474]  ? tty_vhangup+0x30/0x30
[   49.507237]  ? lockdep_hardirqs_on+0x290/0x560
[   49.509419]  ? __kasan_slab_free+0x1ce/0x230
[   49.511490]  ? kmem_cache_free+0xa6/0x2a0
[   49.513454]  ? putname+0xd4/0x110
[   49.515059]  ? do_sys_open+0x291/0x3f0
[   49.516888]  ? do_syscall_64+0x11c/0xe08
[   49.518795]  ? entry_SYSCALL_64_after_hwframe+0x49/0xbe
[   49.521359]  ? __lock_acquire+0x5eb/0x2e50
[   49.523278]  ? restore_nameidata+0x108/0x180
[   49.525242]  ? tty_vhangup+0x30/0x30
[   49.526895]  do_vfs_ioctl+0x1a5/0x1100
[   49.528608]  ? may_open_dev+0xd0/0xd0
[   49.530414]  ? ioctl_preallocate+0x1d0/0x1d0
[   49.532607]  ? putname+0xd4/0x110
[   49.534097]  ? rcu_read_lock_sched_held+0x114/0x130
[   49.536342]  ? kmem_cache_free+0x263/0x2a0
[   49.538450]  ? putname+0xd4/0x110
[   49.540036]  ? do_sys_open+0x1ec/0x3f0
[   49.541909]  ksys_ioctl+0x7c/0xa0
[   49.543458]  __x64_sys_ioctl+0x74/0xb0
[   49.545433]  ? lockdep_hardirqs_on+0x37c/0x560
[   49.547642]  do_syscall_64+0x11c/0xe08
[   49.549447]  ? syscall_return_slowpath+0x3a0/0x3a0
[   49.551741]  ? trace_hardirqs_on_thunk+0x1a/0x1c
[   49.553810]  ? trace_hardirqs_off_caller+0x54/0x190
[   49.556125]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   49.558453]  entry_SYSCALL_64_after_hwframe+0x49/0xbe

>
> Thanks,
>
> Yang
>
>>
>> thanks,
>>
>> greg k-h
>> .
>
> .

