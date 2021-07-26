Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A764BC25AEA
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 07:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8519460F92
	for <linux-serial@archiver.kernel.org>; Mon, 26 Jul 2021 07:18:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhGZGhg (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Mon, 26 Jul 2021 02:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232392AbhGZGhb (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 26 Jul 2021 02:37:31 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E64C0613C1;
        Mon, 26 Jul 2021 00:17:59 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso18437589pjb.1;
        Mon, 26 Jul 2021 00:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language;
        bh=DYhPjWSfnsCFKVMPCiDzfO/J8kaPHhbJ20/uAXM3x9Y=;
        b=lnSPO3Ra1R85cieRWUn++r8vAJm7LyMfuNaSfoX7qzERNDDWcnlBcQA5qRSLgAtXki
         dZs8e4Jb3Er0CHnF00CyeHS4NKBQX7NaQn5uySA1eSf5/TiXdj8fHfDTdV/q289V3KJz
         KrT2QDbvqeVweZaJCjLu2RDaYzb9F61lfOy0SFtQG9QN74bltwbLgpJQHJnUrj+fpvdy
         oQCNVeQuRwsB9oDiy/R5JKmy8nSn2PSN0qGHmGDhiaL/Ulukvsdb6ycgaJAUwE7EPVW0
         zotTfZp8+Kph0fKi52uEDFvidK9evgXxC62mWPC6s5PIjMmdflQaaEdS4694AiCnOZ5u
         fK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language;
        bh=DYhPjWSfnsCFKVMPCiDzfO/J8kaPHhbJ20/uAXM3x9Y=;
        b=ui/L+A0HkZyQFw+g5u1ty5ivfSQlvcLG/en/qb9tfm9G69HgBYOFxgnY+2XSYUfXit
         8tgGLZRW4af5FLoScVYrtaTl2aleZkcqbrEXq7+GIyILwvNkCBSdOSoaAVa/rSfHmgAD
         +DpM+x+jGQatJPNbDb2BZ2LFPyiP52FflunNlV07HKtN3NFwnk7E50UAvirCI4T2ikZ1
         bfSWqNqyXlUcdZZCG7zCfFUjJnFJ6i/a7POf8N3hR57BbdY1PVv0B6usekzHKZH9kFLB
         GJL1U0OYn3K1igC7H7RGTduaaQQI+iLuUW0QyyhmvS2lLJxyJq8iIEYi/T7ebWHPmGGd
         V/1A==
X-Gm-Message-State: AOAM533n635ToP5ppja8XHqb3zqLXWI9rqBe+gT2ODnZg+14tz+LTxEe
        38olwDtsvAlt9xvf2jca1f0=
X-Google-Smtp-Source: ABdhPJzinV3DesfSwuppcXOJiaJhcnoi02/YBn65yfgkxFyDmZke+++YBhCiWa3/Mlf+Dbt14CHsNQ==
X-Received: by 2002:a63:ee11:: with SMTP id e17mr16996657pgi.323.1627283879435;
        Mon, 26 Jul 2021 00:17:59 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.111])
        by smtp.gmail.com with ESMTPSA id s19sm4248930pju.21.2021.07.26.00.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jul 2021 00:17:58 -0700 (PDT)
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Qian Cai <quic_qiancai@quicinc.com>, gregkh@linuxfoundation.org,
        Bing Fan <tombinfan@tencent.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
 <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
From:   Bing Fan <hptsfb@gmail.com>
Message-ID: <3b60d054-4e22-62fa-c31b-29b146495a65@gmail.com>
Date:   Mon, 26 Jul 2021 15:17:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
Content-Type: multipart/mixed;
 boundary="------------40C0C025EA6F0FE18B2C7943"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------40C0C025EA6F0FE18B2C7943
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

I tried to reproduce, but unfortunately, it didn't, and the dmesg log as 
attachment.

I had enabled CONFIG_KASAN and CONFIG_SLUB_DEBUG_ON configs.

Can you describe the flow of your operation?


Thanks.



在 7/24/2021 0:47, Qian Cai 写道:
>
> On 6/30/2021 9:38 PM, Bing Fan wrote:
>> From: Bing Fan <tombinfan@tencent.com>
>>
>> In order to make pl011 work better, multiple interrupts are
>> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
>> at the same time, pl011 to GIC does not merge the interrupt
>> lines(each serial-interrupt corresponding to different GIC hardware
>> interrupt), so need to enable and request multiple gic interrupt
>> numbers in the driver.
>>
>> Signed-off-by: Bing Fan <tombinfan@tencent.com>
>> ---
>>   drivers/tty/serial/amba-pl011.c | 34 ++++++++++++++++++++++++++++++---
>>   1 file changed, 31 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
>> index 78682c12156a..7bfe8efcc787 100644
>> --- a/drivers/tty/serial/amba-pl011.c
>> +++ b/drivers/tty/serial/amba-pl011.c
>> @@ -1701,11 +1701,39 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>>   	}
>>   }
>>   
>> +static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
>> +{
>> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
>> +	int i;
>> +
>> +	for (i = 0; i < max_cnt; i++)
>> +		if (amba_dev->irq[i])
>> +			free_irq(amba_dev->irq[i], uap);
>> +}
>> +
>>   static int pl011_allocate_irq(struct uart_amba_port *uap)
>>   {
>> +	int ret = 0;
>> +	int i;
>> +	unsigned int virq;
>> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
>> +
>>   	pl011_write(uap->im, uap, REG_IMSC);
>>   
>> -	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
>> +	for (i = 0; i < AMBA_NR_IRQS; i++) {
>> +		virq = amba_dev->irq[i];
> This could trigger a slab-out-of-bounds during booting.
>
> [   18.716444] BUG: KASAN: slab-out-of-bounds in pl011_allocate_irq+0x1f8/0x2f8
> [   18.724191] Read of size 4 at addr ffff00001a3a0508 by task swapper/0/1
>
> [   18.733680] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc2-next-20210723 #69
> [   18.741941] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
> [   18.750461] Call trace:
> [   18.753597]  dump_backtrace+0x0/0x3b8
> [   18.757956]  show_stack+0x20/0x30
> [   18.761964]  dump_stack_lvl+0x8c/0xb8
> [   18.766319]  print_address_description.constprop.0+0x74/0x3c8
> [   18.772759]  kasan_report+0x1f0/0x208
> [   18.777113]  __asan_report_load4_noabort+0x34/0x60
> [   18.782596]  pl011_allocate_irq+0x1f8/0x2f8
> [   18.787471]  sbsa_uart_startup+0x44/0x98
> [   18.792086]  uart_startup.part.0+0x28c/0x618
> [   18.797048]  uart_port_activate+0xf0/0x178
> [   18.801836]  tty_port_open+0x118/0x1c8
> [   18.806278]  uart_open+0x44/0x70
> [   18.810199]  tty_open+0x248/0x960
> [   18.814207]  chrdev_open+0x19c/0x440
> [   18.818476]  do_dentry_open+0x3ac/0xdb0
> [   18.823005]  vfs_open+0x98/0xd0
> [   18.826838]  do_open.isra.0+0x4a8/0x8c0
> [   18.831366]  path_openat+0x3ac/0xe28
> [   18.835633]  do_filp_open+0x150/0x220
> [   18.839987]  file_open_name+0x120/0x200
> [   18.844515]  filp_open+0x40/0x80
> [   18.848436]  console_on_rootfs+0x30/0x7c
> [   18.853052]  kernel_init_freeable+0x74c/0x7d0
> [   18.858100]  kernel_init+0x2c/0x140
> [   18.862282]  ret_from_fork+0x10/0x18
>
> [   18.868732] Allocated by task 1:
> [   18.872651]  kasan_save_stack+0x28/0x58
> [   18.877181]  __kasan_kmalloc+0x8c/0xb0
> [   18.881622]  __kmalloc+0x260/0x3d0
> [   18.885716]  platform_device_alloc+0x34/0x1b8
> [   18.890766]  platform_device_register_full+0x68/0x418
> [   18.896509]  acpi_create_platform_device.part.0+0x170/0x538
> [   18.902776]  acpi_create_platform_device+0x8c/0xa8
> [   18.908259]  acpi_default_enumeration+0x54/0xd0
> [   18.913482]  acpi_bus_attach+0x664/0x7d0
> [   18.918096]  acpi_bus_attach+0x178/0x7d0
> [   18.922709]  acpi_bus_attach+0x178/0x7d0
> [   18.927324]  acpi_bus_attach+0x178/0x7d0
> [   18.931937]  acpi_bus_scan+0xa8/0x170
> [   18.936291]  acpi_scan_init+0x220/0x554
> [   18.940819]  acpi_init+0x1fc/0x27c
> [   18.944912]  do_one_initcall+0x170/0xb98
> [   18.949527]  kernel_init_freeable+0x718/0x7d0
> [   18.954575]  kernel_init+0x2c/0x140
> [   18.958759]  ret_from_fork+0x10/0x18
>
> [   18.965214] The buggy address belongs to the object at ffff00001a3a0000
>                  which belongs to the cache kmalloc-2k of size 2048
> [   18.979117] The buggy address is located 1288 bytes inside of
>                  2048-byte region [ffff00001a3a0000, ffff00001a3a0800)
> [   18.992412] The buggy address belongs to the page:
> [   18.997894] page:ffffffc000068e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9a38
> [   19.007805] head:ffffffc000068e00 order:2 compound_mapcount:0 compound_pincount:0
> [   19.015977] flags: 0x7ffff800010200(slab|head|node=0|zone=0|lastcpupid=0xfffff)
> [   19.023982] raw: 007ffff800010200 ffffffc000067508 ffffffc000069f08 ffff000012911280
> [   19.032416] raw: 0000000000000000 00000000002a002a 00000001ffffffff 0000000000000000
> [   19.040848] page dumped because: kasan: bad access detected
>
> [   19.049291] Memory state around the buggy address:
> [   19.054772]  ffff00001a3a0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> [   19.062684]  ffff00001a3a0480: 00 00 00 00 00 00 00 00 00 00 00 04 fc fc fc fc
> [   19.070595] >ffff00001a3a0500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   19.078506]                       ^
> [   19.082686]  ffff00001a3a0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> [   19.090597]  ffff00001a3a0600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
>
>> +		if (virq == 0)
>> +			break;
>> +
>> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
>> +		if (ret) {
>> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
>> +			pl011_release_irq(uap, i - 1);
>> +			break;
>> +		}
>> +	}
>> +
>> +	return ret;
>>   }
>>   
>>   /*
>> @@ -1864,7 +1892,7 @@ static void pl011_shutdown(struct uart_port *port)
>>   
>>   	pl011_dma_shutdown(uap);
>>   
>> -	free_irq(uap->port.irq, uap);
>> +	pl011_release_irq(uap, AMBA_NR_IRQS);
>>   
>>   	pl011_disable_uart(uap);
>>   
>> @@ -1894,7 +1922,7 @@ static void sbsa_uart_shutdown(struct uart_port *port)
>>   
>>   	pl011_disable_interrupts(uap);
>>   
>> -	free_irq(uap->port.irq, uap);
>> +	pl011_release_irq(uap, AMBA_NR_IRQS);
>>   
>>   	if (uap->port.ops->flush_buffer)
>>   		uap->port.ops->flush_buffer(port);
>>

--------------40C0C025EA6F0FE18B2C7943
Content-Type: text/plain; charset=UTF-8;
 name="dmesg_log-20210726.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="dmesg_log-20210726.txt"

WyAgICAwLjAwMDAwMF0gQm9vdGluZyBMaW51eCBvbiBwaHlzaWNhbCBDUFUgMHgwMDAwMDAw
MDAwIFsweDQxMGZkMDM0XQpbICAgIDAuMDAwMDAwXSBMaW51eCB2ZXJzaW9uIDUuMTQuMC1y
YzItMDAyNjUtZ2YwZmRkY2VjNmI2Mi1kaXJ0eSAodWJ1bnR1QFZNLTcxLTk1LXVidW50dSkg
KGFhcmNoNjQtbGludXgtZ251LWdjYyAoR05VIFRvb2xjaGFpbiBmb3IgdGhlIEEtcHJvZmls
ZSBBcmNoaXRlY3R1cmUgOC4zLTIwMTkuMDMgKGFybS1yZWwtOC4zNikpIDguMy4wLCBHTlUg
bGQgKEdOVSBUb29sY2hhaW4gZm9yIHRoZSBBLXByb2ZpbGUgQXJjaGl0ZWN0dXJlIDguMy0y
MDE5LjAzIChhcm0tcmVsLTguMzYpKSAyLjMyLjAuMjAxOTAzMjEpICMxIFNNUCBQUkVFTVBU
IE1vbiBKdWwgMjYgMTE6NTA6MjkgQ1NUIDIwMjEKWyAgICAwLjAwMDAwMF0gTWFjaGluZSBt
b2RlbDogbGludXgsZHVtbXktdmlydApbICAgIDAuMDAwMDAwXSBlZmk6IFVFRkkgbm90IGZv
dW5kLgpbICAgIDAuMDAwMDAwXSBOVU1BOiBObyBOVU1BIGNvbmZpZ3VyYXRpb24gZm91bmQK
WyAgICAwLjAwMDAwMF0gTlVNQTogRmFraW5nIGEgbm9kZSBhdCBbbWVtIDB4MDAwMDAwMDA0
MDAwMDAwMC0weDAwMDAwMDAxM2ZmZmZmZmZdClsgICAgMC4wMDAwMDBdIE5VTUE6IE5PREVf
REFUQSBbbWVtIDB4MTNmN2Y3YzAwLTB4MTNmN2Y5ZmZmXQpbICAgIDAuMDAwMDAwXSBab25l
IHJhbmdlczoKWyAgICAwLjAwMDAwMF0gICBETUEgICAgICBbbWVtIDB4MDAwMDAwMDA0MDAw
MDAwMC0weDAwMDAwMDAwZmZmZmZmZmZdClsgICAgMC4wMDAwMDBdICAgRE1BMzIgICAgZW1w
dHkKWyAgICAwLjAwMDAwMF0gICBOb3JtYWwgICBbbWVtIDB4MDAwMDAwMDEwMDAwMDAwMC0w
eDAwMDAwMDAxM2ZmZmZmZmZdClsgICAgMC4wMDAwMDBdIE1vdmFibGUgem9uZSBzdGFydCBm
b3IgZWFjaCBub2RlClsgICAgMC4wMDAwMDBdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwpb
ICAgIDAuMDAwMDAwXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDA0MDAwMDAwMC0weDAw
MDAwMDAxM2ZmZmZmZmZdClsgICAgMC4wMDAwMDBdIEluaXRtZW0gc2V0dXAgbm9kZSAwIFtt
ZW0gMHgwMDAwMDAwMDQwMDAwMDAwLTB4MDAwMDAwMDEzZmZmZmZmZl0KWyAgICAwLjAwMDAw
MF0gY21hOiBSZXNlcnZlZCAzMiBNaUIgYXQgMHgwMDAwMDAwMGZlMDAwMDAwClsgICAgMC4w
MDAwMDBdIGthc2FuOiBLZXJuZWxBZGRyZXNzU2FuaXRpemVyIGluaXRpYWxpemVkClsgICAg
MC4wMDAwMDBdIHBzY2k6IHByb2JpbmcgZm9yIGNvbmR1aXQgbWV0aG9kIGZyb20gRFQuClsg
ICAgMC4wMDAwMDBdIHBzY2k6IFBTQ0l2MC4yIGRldGVjdGVkIGluIGZpcm13YXJlLgpbICAg
IDAuMDAwMDAwXSBwc2NpOiBVc2luZyBzdGFuZGFyZCBQU0NJIHYwLjIgZnVuY3Rpb24gSURz
ClsgICAgMC4wMDAwMDBdIHBzY2k6IFRydXN0ZWQgT1MgbWlncmF0aW9uIG5vdCByZXF1aXJl
ZApbICAgIDAuMDAwMDAwXSBwZXJjcHU6IEVtYmVkZGVkIDI0IHBhZ2VzL2NwdSBzNTc5NDQg
cjgxOTIgZDMyMTY4IHU5ODMwNApbICAgIDAuMDAwMDAwXSBEZXRlY3RlZCBWSVBUIEktY2Fj
aGUgb24gQ1BVMApbICAgIDAuMDAwMDAwXSBDUFUgZmVhdHVyZXM6IGRldGVjdGVkOiBHSUMg
c3lzdGVtIHJlZ2lzdGVyIENQVSBpbnRlcmZhY2UKWyAgICAwLjAwMDAwMF0gQ1BVIGZlYXR1
cmVzOiBrZXJuZWwgcGFnZSB0YWJsZSBpc29sYXRpb24gZm9yY2VkIE9OIGJ5IEtBU0xSClsg
ICAgMC4wMDAwMDBdIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IEtlcm5lbCBwYWdlIHRhYmxl
IGlzb2xhdGlvbiAoS1BUSSkKWyAgICAwLjAwMDAwMF0gQ1BVIGZlYXR1cmVzOiBkZXRlY3Rl
ZDogQVJNIGVycmF0dW0gODQzNDE5ClsgICAgMC4wMDAwMDBdIENQVSBmZWF0dXJlczogZGV0
ZWN0ZWQ6IEFSTSBlcnJhdHVtIDg0NTcxOQpbICAgIDAuMDAwMDAwXSBCdWlsdCAxIHpvbmVs
aXN0cywgbW9iaWxpdHkgZ3JvdXBpbmcgb24uICBUb3RhbCBwYWdlczogMTAzMjE5MgpbICAg
IDAuMDAwMDAwXSBQb2xpY3kgem9uZTogTm9ybWFsClsgICAgMC4wMDAwMDBdIEtlcm5lbCBj
b21tYW5kIGxpbmU6IGNvbnNvbGU9dHR5QU1BMCBteW1vZHVsZS5keW5kYmc9K3AKWyAgICAw
LjAwMDAwMF0gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNTI0Mjg4IChvcmRl
cjogMTAsIDQxOTQzMDQgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjAwMDAwMF0gSW5vZGUtY2Fj
aGUgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNjIxNDQgKG9yZGVyOiA5LCAyMDk3MTUyIGJ5dGVz
LCBsaW5lYXIpClsgICAgMC4wMDAwMDBdIG1lbSBhdXRvLWluaXQ6IHN0YWNrOm9mZiwgaGVh
cCBhbGxvYzpvZmYsIGhlYXAgZnJlZTpvZmYKWyAgICAwLjAwMDAwMF0gc29mdHdhcmUgSU8g
VExCOiBtYXBwZWQgW21lbSAweDAwMDAwMDAwZmEwMDAwMDAtMHgwMDAwMDAwMGZlMDAwMDAw
XSAoNjRNQikKWyAgICAwLjAwMDAwMF0gTWVtb3J5OiAzMzQwOTEySy80MTk0MzA0SyBhdmFp
bGFibGUgKDIxNzYwSyBrZXJuZWwgY29kZSwgMTQ0NThLIHJ3ZGF0YSwgMTUwNDBLIHJvZGF0
YSwgMTk3MTJLIGluaXQsIDc4MUsgYnNzLCA4MjA2MjRLIHJlc2VydmVkLCAzMjc2OEsgY21h
LXJlc2VydmVkKQpbICAgIDAuMDAwMDAwXSAqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqClsgICAgMC4wMDAwMDBdICoqICAgTk9U
SUNFIE5PVElDRSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgTk9USUNFICAgKioKWyAg
ICAwLjAwMDAwMF0gKiogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAqKgpbICAgIDAuMDAwMDAwXSAqKiBUaGlzIHN5c3RlbSBzaG93cyB1
bmhhc2hlZCBrZXJuZWwgbWVtb3J5IGFkZHJlc3NlcyAgICoqClsgICAgMC4wMDAwMDBdICoq
IHZpYSB0aGUgY29uc29sZSwgbG9ncywgYW5kIG90aGVyIGludGVyZmFjZXMuIFRoaXMgICAg
KioKWyAgICAwLjAwMDAwMF0gKiogbWlnaHQgcmVkdWNlIHRoZSBzZWN1cml0eSBvZiB5b3Vy
IHN5c3RlbS4gICAgICAgICAgICAqKgpbICAgIDAuMDAwMDAwXSAqKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoqClsgICAgMC4wMDAw
MDBdICoqIElmIHlvdSBzZWUgdGhpcyBtZXNzYWdlIGFuZCB5b3UgYXJlIG5vdCBkZWJ1Z2dp
bmcgICAgKioKWyAgICAwLjAwMDAwMF0gKiogdGhlIGtlcm5lbCwgcmVwb3J0IHRoaXMgaW1t
ZWRpYXRlbHkgdG8geW91ciBzeXN0ZW0gICAqKgpbICAgIDAuMDAwMDAwXSAqKiBhZG1pbmlz
dHJhdG9yISAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICoqClsgICAg
MC4wMDAwMDBdICoqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKioKWyAgICAwLjAwMDAwMF0gKiogICBOT1RJQ0UgTk9USUNFIE5PVElD
RSBOT1RJQ0UgTk9USUNFIE5PVElDRSBOT1RJQ0UgICAqKgpbICAgIDAuMDAwMDAwXSAqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
ClsgICAgMC4wMDAwMDBdIFNMVUI6IEhXYWxpZ249NjQsIE9yZGVyPTAtMywgTWluT2JqZWN0
cz0wLCBDUFVzPTIsIE5vZGVzPTEKWyAgICAwLjAwMDAwMF0gcmN1OiBQcmVlbXB0aWJsZSBo
aWVyYXJjaGljYWwgUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAuMDAwMDAwXSByY3U6ICAg
ICBSQ1UgZXZlbnQgdHJhY2luZyBpcyBlbmFibGVkLgpbICAgIDAuMDAwMDAwXSByY3U6ICAg
ICBSQ1UgcmVzdHJpY3RpbmcgQ1BVcyBmcm9tIE5SX0NQVVM9MjU2IHRvIG5yX2NwdV9pZHM9
Mi4KWyAgICAwLjAwMDAwMF0gIFRyYW1wb2xpbmUgdmFyaWFudCBvZiBUYXNrcyBSQ1UgZW5h
YmxlZC4KWyAgICAwLjAwMDAwMF0gcmN1OiBSQ1UgY2FsY3VsYXRlZCB2YWx1ZSBvZiBzY2hl
ZHVsZXItZW5saXN0bWVudCBkZWxheSBpcyAyNSBqaWZmaWVzLgpbICAgIDAuMDAwMDAwXSBy
Y3U6IEFkanVzdGluZyBnZW9tZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2LCBucl9jcHVf
aWRzPTIKWyAgICAwLjAwMDAwMF0gTlJfSVJRUzogNjQsIG5yX2lycXM6IDY0LCBwcmVhbGxv
Y2F0ZWQgaXJxczogMApbICAgIDAuMDAwMDAwXSBHSUN2MzogMjI0IFNQSXMgaW1wbGVtZW50
ZWQKWyAgICAwLjAwMDAwMF0gR0lDdjM6IDAgRXh0ZW5kZWQgU1BJcyBpbXBsZW1lbnRlZApb
ICAgIDAuMDAwMDAwXSBHSUN2MzogRGlzdHJpYnV0b3IgaGFzIG5vIFJhbmdlIFNlbGVjdG9y
IHN1cHBvcnQKWyAgICAwLjAwMDAwMF0gUm9vdCBJUlEgaGFuZGxlcjogZ2ljX2hhbmRsZV9p
cnEKWyAgICAwLjAwMDAwMF0gR0lDdjM6IDE2IFBQSXMgaW1wbGVtZW50ZWQKWyAgICAwLjAw
MDAwMF0gR0lDdjM6IENQVTA6IGZvdW5kIHJlZGlzdHJpYnV0b3IgMCByZWdpb24gMDoweDAw
MDAwMDAwMDgwYTAwMDAKWyAgICAwLjAwMDAwMF0gcmFuZG9tOiBnZXRfcmFuZG9tX2J5dGVz
IGNhbGxlZCBmcm9tIHN0YXJ0X2tlcm5lbCsweDFlMC8weDNiMCB3aXRoIGNybmdfaW5pdD0w
ClsgICAgMC4wMDAwMDBdIGFyY2hfdGltZXI6IGNwMTUgdGltZXIocykgcnVubmluZyBhdCA2
Mi41ME1IeiAodmlydCkuClsgICAgMC4wMDAwMDBdIGNsb2Nrc291cmNlOiBhcmNoX3N5c19j
b3VudGVyOiBtYXNrOiAweGZmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MWNkNDJlMjA4
YywgbWF4X2lkbGVfbnM6IDg4MTU5MDQwNTMxNCBucwpbICAgIDAuMDAwMTcwXSBzY2hlZF9j
bG9jazogNTYgYml0cyBhdCA2Mk1IeiwgcmVzb2x1dGlvbiAxNm5zLCB3cmFwcyBldmVyeSA0
Mzk4MDQ2NTExMDk2bnMKWyAgICAwLjAxOTQ1OF0gQ29uc29sZTogY29sb3VyIGR1bW15IGRl
dmljZSA4MHgyNQpbICAgIDAuMDM2MjE2XSBDYWxpYnJhdGluZyBkZWxheSBsb29wIChza2lw
cGVkKSwgdmFsdWUgY2FsY3VsYXRlZCB1c2luZyB0aW1lciBmcmVxdWVuY3kuLiAxMjUuMDAg
Qm9nb01JUFMgKGxwaj0yNTAwMDApClsgICAgMC4wMzY2NjddIHBpZF9tYXg6IGRlZmF1bHQ6
IDMyNzY4IG1pbmltdW06IDMwMQpbICAgIDAuMDQxNzI0XSBMU006IFNlY3VyaXR5IEZyYW1l
d29yayBpbml0aWFsaXppbmcKWyAgICAwLjA0NjExNV0gTW91bnQtY2FjaGUgaGFzaCB0YWJs
ZSBlbnRyaWVzOiA4MTkyIChvcmRlcjogNCwgNjU1MzYgYnl0ZXMsIGxpbmVhcikKWyAgICAw
LjA0NjU0Nl0gTW91bnRwb2ludC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDgxOTIgKG9y
ZGVyOiA0LCA2NTUzNiBieXRlcywgbGluZWFyKQpbICAgIDAuMTk5ODI3XSByY3U6IEhpZXJh
cmNoaWNhbCBTUkNVIGltcGxlbWVudGF0aW9uLgpbICAgIDAuMjI4NTAxXSBFRkkgc2Vydmlj
ZXMgd2lsbCBub3QgYmUgYXZhaWxhYmxlLgpbICAgIDAuMjM0NzQxXSBzbXA6IEJyaW5naW5n
IHVwIHNlY29uZGFyeSBDUFVzIC4uLgpbICAgIDAuMzQyNzYzXSBEZXRlY3RlZCBWSVBUIEkt
Y2FjaGUgb24gQ1BVMQpbICAgIDAuMzQ0NjE3XSBHSUN2MzogQ1BVMTogZm91bmQgcmVkaXN0
cmlidXRvciAxIHJlZ2lvbiAwOjB4MDAwMDAwMDAwODBjMDAwMApbICAgIDAuMzQ1MzEzXSBD
UFUxOiBCb290ZWQgc2Vjb25kYXJ5IHByb2Nlc3NvciAweDAwMDAwMDAwMDEgWzB4NDEwZmQw
MzRdClsgICAgMC4zNTQ5NTVdIHNtcDogQnJvdWdodCB1cCAxIG5vZGUsIDIgQ1BVcwpbICAg
IDAuMzU1MjU4XSBTTVA6IFRvdGFsIG9mIDIgcHJvY2Vzc29ycyBhY3RpdmF0ZWQuClsgICAg
MC4zNTU0NzZdIENQVSBmZWF0dXJlczogZGV0ZWN0ZWQ6IDMyLWJpdCBFTDAgU3VwcG9ydApb
ICAgIDAuMzU1NTgyXSBDUFUgZmVhdHVyZXM6IGRldGVjdGVkOiAzMi1iaXQgRUwxIFN1cHBv
cnQKWyAgICAwLjM1NTc5NV0gQ1BVIGZlYXR1cmVzOiBkZXRlY3RlZDogQ1JDMzIgaW5zdHJ1
Y3Rpb25zClsgICAgMC40NjA4MThdIENQVTogQWxsIENQVShzKSBzdGFydGVkIGF0IEVMMQpb
ICAgIDAuNDYyMDYzXSBhbHRlcm5hdGl2ZXM6IHBhdGNoaW5nIGtlcm5lbCBjb2RlClsgICAg
MC41MzAxNTNdIGRldnRtcGZzOiBpbml0aWFsaXplZApbICAgIDAuNzkyMTE3XSBLQVNMUiBl
bmFibGVkClsgICAgMC44MDEyMzJdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNrOiAweGZm
ZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiA3NjQ1MDQxNzg1
MTAwMDAwIG5zClsgICAgMC44MDE3NTNdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczogNTEy
IChvcmRlcjogMywgMzI3NjggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjgyODUwMF0gcGluY3Ry
bCBjb3JlOiBpbml0aWFsaXplZCBwaW5jdHJsIHN1YnN5c3RlbQpbICAgIDAuOTE0MzA1XSBE
TUkgbm90IHByZXNlbnQgb3IgaW52YWxpZC4KWyAgICAwLjk1ODQ1Ml0gTkVUOiBSZWdpc3Rl
cmVkIFBGX05FVExJTksvUEZfUk9VVEUgcHJvdG9jb2wgZmFtaWx5ClsgICAgMS4wMTMwODVd
IERNQTogcHJlYWxsb2NhdGVkIDUxMiBLaUIgR0ZQX0tFUk5FTCBwb29sIGZvciBhdG9taWMg
YWxsb2NhdGlvbnMKWyAgICAxLjAxNjI3MF0gRE1BOiBwcmVhbGxvY2F0ZWQgNTEyIEtpQiBH
RlBfS0VSTkVMfEdGUF9ETUEgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMS4w
MTk4NzVdIERNQTogcHJlYWxsb2NhdGVkIDUxMiBLaUIgR0ZQX0tFUk5FTHxHRlBfRE1BMzIg
cG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMS4wMjE5ODFdIGF1ZGl0OiBpbml0
aWFsaXppbmcgbmV0bGluayBzdWJzeXMgKGRpc2FibGVkKQpbICAgIDEuMDMwMDgyXSBhdWRp
dDogdHlwZT0yMDAwIGF1ZGl0KDAuODMyOjEpOiBzdGF0ZT1pbml0aWFsaXplZCBhdWRpdF9l
bmFibGVkPTAgcmVzPTEKWyAgICAxLjA5NTA1MV0gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQg
dGhlcm1hbCBnb3Zlcm5vciAnc3RlcF93aXNlJwpbICAgIDEuMDk1MjU2XSB0aGVybWFsX3N5
czogUmVnaXN0ZXJlZCB0aGVybWFsIGdvdmVybm9yICdwb3dlcl9hbGxvY2F0b3InClsgICAg
MS4wOTkxMTFdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9yIG1lbnUKWyAgICAxLjEwNzk5NV0g
aHctYnJlYWtwb2ludDogZm91bmQgNiBicmVha3BvaW50IGFuZCA0IHdhdGNocG9pbnQgcmVn
aXN0ZXJzLgpbICAgIDEuMTA5NTcyXSBBU0lEIGFsbG9jYXRvciBpbml0aWFsaXNlZCB3aXRo
IDMyNzY4IGVudHJpZXMKWyAgICAxLjE3ODExMl0gU2VyaWFsOiBBTUJBIFBMMDExIFVBUlQg
ZHJpdmVyClsgICAgMS41MDgxODhdIDkwMDAwMDAucGwwMTE6IHR0eUFNQTAgYXQgTU1JTyAw
eDkwMDAwMDAgKGlycSA9IDQ3LCBiYXNlX2JhdWQgPSAwKSBpcyBhIFBMMDExIHJldjEKWyAg
ICAxLjU0ODkxMl0gcHJpbnRrOiBjb25zb2xlIFt0dHlBTUEwXSBlbmFibGVkClsgICAgMi4x
NzU1MTNdIEh1Z2VUTEIgcmVnaXN0ZXJlZCAxLjAwIEdpQiBwYWdlIHNpemUsIHByZS1hbGxv
Y2F0ZWQgMCBwYWdlcwpbICAgIDIuMTc2MDg0XSBIdWdlVExCIHJlZ2lzdGVyZWQgMzIuMCBN
aUIgcGFnZSBzaXplLCBwcmUtYWxsb2NhdGVkIDAgcGFnZXMKWyAgICAyLjE3NjQ5N10gSHVn
ZVRMQiByZWdpc3RlcmVkIDIuMDAgTWlCIHBhZ2Ugc2l6ZSwgcHJlLWFsbG9jYXRlZCAwIHBh
Z2VzClsgICAgMi4xNzcxOTBdIEh1Z2VUTEIgcmVnaXN0ZXJlZCA2NC4wIEtpQiBwYWdlIHNp
emUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpbICAgIDIuMjQ3MTk3XSBjcnlwdGQ6IG1heF9j
cHVfcWxlbiBzZXQgdG8gMTAwMApbICAgIDIuMzM0NDYxXSBBQ1BJOiBJbnRlcnByZXRlciBk
aXNhYmxlZC4KWyAgICAyLjQxMTMxMV0gaW9tbXU6IERlZmF1bHQgZG9tYWluIHR5cGU6IFRy
YW5zbGF0ZWQgClsgICAgMi40MTk1NTddIHZnYWFyYjogbG9hZGVkClsgICAgMi40NDAxODJd
IFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAgMi40NjQ5NThdIHVzYmNvcmU6IHJl
Z2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiZnMKWyAgICAyLjQ2ODM5OV0gdXNi
Y29yZTogcmVnaXN0ZXJlZCBuZXcgaW50ZXJmYWNlIGRyaXZlciBodWIKWyAgICAyLjQ3MDUz
OF0gdXNiY29yZTogcmVnaXN0ZXJlZCBuZXcgZGV2aWNlIGRyaXZlciB1c2IKWyAgICAyLjQ5
NTYwOF0gcHBzX2NvcmU6IExpbnV4UFBTIEFQSSB2ZXIuIDEgcmVnaXN0ZXJlZApbICAgIDIu
NDk2MTYyXSBwcHNfY29yZTogU29mdHdhcmUgdmVyLiA1LjMuNiAtIENvcHlyaWdodCAyMDA1
LTIwMDcgUm9kb2xmbyBHaW9tZXR0aSA8Z2lvbWV0dGlAbGludXguaXQ+ClsgICAgMi40OTgx
ODFdIFBUUCBjbG9jayBzdXBwb3J0IHJlZ2lzdGVyZWQKWyAgICAyLjUwNDE4NF0gRURBQyBN
QzogVmVyOiAzLjAuMApbICAgIDIuNTY1MjA4XSBGUEdBIG1hbmFnZXIgZnJhbWV3b3JrClsg
ICAgMi41NzM3NjBdIEFkdmFuY2VkIExpbnV4IFNvdW5kIEFyY2hpdGVjdHVyZSBEcml2ZXIg
SW5pdGlhbGl6ZWQuClsgICAgMi42NDgxNjJdIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBj
bG9ja3NvdXJjZSBhcmNoX3N5c19jb3VudGVyClsgICAgMi42NjYzNjBdIFZGUzogRGlzayBx
dW90YXMgZHF1b3RfNi42LjAKWyAgICAyLjY2ODMzNV0gVkZTOiBEcXVvdC1jYWNoZSBoYXNo
IHRhYmxlIGVudHJpZXM6IDUxMiAob3JkZXIgMCwgNDA5NiBieXRlcykKWyAgICAyLjY4MDE1
Nl0gcG5wOiBQblAgQUNQSTogZGlzYWJsZWQKWyAgICAzLjAwNjg0NF0gTkVUOiBSZWdpc3Rl
cmVkIFBGX0lORVQgcHJvdG9jb2wgZmFtaWx5ClsgICAgMy4wMjI1OTddIElQIGlkZW50cyBo
YXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5l
YXIpClsgICAgMy4wNzM5NjldIHRjcF9saXN0ZW5fcG9ydGFkZHJfaGFzaCBoYXNoIHRhYmxl
IGVudHJpZXM6IDIwNDggKG9yZGVyOiAzLCAzMjc2OCBieXRlcywgbGluZWFyKQpbICAgIDMu
MDc2MzA0XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAzMjc2OCAob3Jk
ZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFyKQpbICAgIDMuMDgxODMwXSBUQ1AgYmluZCBo
YXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5l
YXIpClsgICAgMy4wODcyMjJdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJs
aXNoZWQgMzI3NjggYmluZCAzMjc2OCkKWyAgICAzLjA5Mjk0MV0gVURQIGhhc2ggdGFibGUg
ZW50cmllczogMjA0OCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzLCBsaW5lYXIpClsgICAgMy4w
OTQ4NzZdIFVEUC1MaXRlIGhhc2ggdGFibGUgZW50cmllczogMjA0OCAob3JkZXI6IDQsIDY1
NTM2IGJ5dGVzLCBsaW5lYXIpClsgICAgMy4xMTM1NDJdIE5FVDogUmVnaXN0ZXJlZCBQRl9V
TklYL1BGX0xPQ0FMIHByb3RvY29sIGZhbWlseQpbICAgIDMuMTQ5ODQ5XSBSUEM6IFJlZ2lz
dGVyZWQgbmFtZWQgVU5JWCBzb2NrZXQgdHJhbnNwb3J0IG1vZHVsZS4KWyAgICAzLjE1MDU0
MV0gUlBDOiBSZWdpc3RlcmVkIHVkcCB0cmFuc3BvcnQgbW9kdWxlLgpbICAgIDMuMTUwOTAz
XSBSUEM6IFJlZ2lzdGVyZWQgdGNwIHRyYW5zcG9ydCBtb2R1bGUuClsgICAgMy4xNTEyNzld
IFJQQzogUmVnaXN0ZXJlZCB0Y3AgTkZTdjQuMSBiYWNrY2hhbm5lbCB0cmFuc3BvcnQgbW9k
dWxlLgpbICAgIDMuMTUyNDEyXSBQQ0k6IENMUyAwIGJ5dGVzLCBkZWZhdWx0IDY0ClsgICAg
My4xNzI0NDJdIGh3IHBlcmZldmVudHM6IGVuYWJsZWQgd2l0aCBhcm12OF9wbXV2MyBQTVUg
ZHJpdmVyLCA1IGNvdW50ZXJzIGF2YWlsYWJsZQpbICAgIDMuMTc0NDIxXSBVbnBhY2tpbmcg
aW5pdHJhbWZzLi4uClsgICAgMy4xNzUyODVdIGt2bSBbMV06IEhZUCBtb2RlIG5vdCBhdmFp
bGFibGUKWyAgICAzLjMwNjQ0OF0gSW5pdGlhbGlzZSBzeXN0ZW0gdHJ1c3RlZCBrZXlyaW5n
cwpbICAgIDMuMzE0MTMxXSB3b3JraW5nc2V0OiB0aW1lc3RhbXBfYml0cz00MiBtYXhfb3Jk
ZXI9MjAgYnVja2V0X29yZGVyPTAKWyAgICAzLjkxNTgzNF0gc3F1YXNoZnM6IHZlcnNpb24g
NC4wICgyMDA5LzAxLzMxKSBQaGlsbGlwIExvdWdoZXIKWyAgICAzLjk2MjcwOF0gTkZTOiBS
ZWdpc3RlcmluZyB0aGUgaWRfcmVzb2x2ZXIga2V5IHR5cGUKWyAgICAzLjk2NDcxOF0gS2V5
IHR5cGUgaWRfcmVzb2x2ZXIgcmVnaXN0ZXJlZApbICAgIDMuOTY1MjY3XSBLZXkgdHlwZSBp
ZF9sZWdhY3kgcmVnaXN0ZXJlZApbICAgIDMuOTcxODQ4XSBuZnM0ZmlsZWxheW91dF9pbml0
OiBORlN2NCBGaWxlIExheW91dCBEcml2ZXIgUmVnaXN0ZXJpbmcuLi4KWyAgICAzLjk3Mjk0
MF0gbmZzNGZsZXhmaWxlbGF5b3V0X2luaXQ6IE5GU3Y0IEZsZXhmaWxlIExheW91dCBEcml2
ZXIgUmVnaXN0ZXJpbmcuLi4KWyAgICAzLjk3ODk3MF0gOXA6IEluc3RhbGxpbmcgdjlmcyA5
cDIwMDAgZmlsZSBzeXN0ZW0gc3VwcG9ydApbICAgIDQuMDUwODc5XSBLZXkgdHlwZSBhc3lt
bWV0cmljIHJlZ2lzdGVyZWQKWyAgICA0LjA1MjEwMl0gQXN5bW1ldHJpYyBrZXkgcGFyc2Vy
ICd4NTA5JyByZWdpc3RlcmVkClsgICAgNC4wNTUxMzFdIEJsb2NrIGxheWVyIFNDU0kgZ2Vu
ZXJpYyAoYnNnKSBkcml2ZXIgdmVyc2lvbiAwLjQgbG9hZGVkIChtYWpvciAyNDUpClsgICAg
NC4wNTY2MDddIGlvIHNjaGVkdWxlciBtcS1kZWFkbGluZSByZWdpc3RlcmVkClsgICAgNC4x
MzI1NzldIGlvIHNjaGVkdWxlciBreWJlciByZWdpc3RlcmVkClsgICAgNC40MDUzMzNdIHBs
MDYxX2dwaW8gOTAzMDAwMC5wbDA2MTogUEwwNjEgR1BJTyBjaGlwIHJlZ2lzdGVyZWQKWyAg
ICA0LjQ1Njg3OF0gcGNpLWhvc3QtZ2VuZXJpYyA0MDEwMDAwMDAwLnBjaWU6IGhvc3QgYnJp
ZGdlIC9wY2llQDEwMDAwMDAwIHJhbmdlczoKWyAgICA0LjQ1OTM5MV0gcGNpLWhvc3QtZ2Vu
ZXJpYyA0MDEwMDAwMDAwLnBjaWU6ICAgICAgIElPIDB4MDAzZWZmMDAwMC4uMHgwMDNlZmZm
ZmZmIC0+IDB4MDAwMDAwMDAwMApbICAgIDQuNDYyMDkzXSBwY2ktaG9zdC1nZW5lcmljIDQw
MTAwMDAwMDAucGNpZTogICAgICBNRU0gMHgwMDEwMDAwMDAwLi4weDAwM2VmZWZmZmYgLT4g
MHgwMDEwMDAwMDAwClsgICAgNC40NjI4OTRdIHBjaS1ob3N0LWdlbmVyaWMgNDAxMDAwMDAw
MC5wY2llOiAgICAgIE1FTSAweDgwMDAwMDAwMDAuLjB4ZmZmZmZmZmZmZiAtPiAweDgwMDAw
MDAwMDAKWyAgICA0LjQ2NTE3Ml0gcGNpLWhvc3QtZ2VuZXJpYyA0MDEwMDAwMDAwLnBjaWU6
IE1lbW9yeSByZXNvdXJjZSBzaXplIGV4Y2VlZHMgbWF4IGZvciAzMiBiaXRzClsgICAgNC44
MjMyNzVdIHBjaS1ob3N0LWdlbmVyaWMgNDAxMDAwMDAwMC5wY2llOiBFQ0FNIGF0IFttZW0g
MHg0MDEwMDAwMDAwLTB4NDAxZmZmZmZmZl0gZm9yIFtidXMgMDAtZmZdClsgICAgNC44MzQx
MTVdIHBjaS1ob3N0LWdlbmVyaWMgNDAxMDAwMDAwMC5wY2llOiBQQ0kgaG9zdCBicmlkZ2Ug
dG8gYnVzIDAwMDA6MDAKWyAgICA0LjgzNTQ2Nl0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1
cyByZXNvdXJjZSBbYnVzIDAwLWZmXQpbICAgIDQuODM2NjI3XSBwY2lfYnVzIDAwMDA6MDA6
IHJvb3QgYnVzIHJlc291cmNlIFtpbyAgMHgwMDAwLTB4ZmZmZl0KWyAgICA0LjgzNzM1OF0g
cGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4MTAwMDAwMDAtMHgz
ZWZlZmZmZl0KWyAgICA0LjgzODA1OV0gcGNpX2J1cyAwMDAwOjAwOiByb290IGJ1cyByZXNv
dXJjZSBbbWVtIDB4ODAwMDAwMDAwMC0weGZmZmZmZmZmZmZdClsgICAgNC44NDMyOTVdIHBj
aSAwMDAwOjAwOjAwLjA6IFsxYjM2OjAwMDhdIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAKWyAg
ICA0Ljg2MTE2N10gcGNpIDAwMDA6MDA6MDEuMDogWzFhZjQ6MTAwMF0gdHlwZSAwMCBjbGFz
cyAweDAyMDAwMApbICAgIDQuODYyNTE1XSBwY2kgMDAwMDowMDowMS4wOiByZWcgMHgxMDog
W2lvICAweDAwMDAtMHgwMDFmXQpbICAgIDQuODYzMjQxXSBwY2kgMDAwMDowMDowMS4wOiBy
ZWcgMHgyMDogW21lbSAweDAwMDAwMDAwLTB4MDAwMDNmZmYgNjRiaXQgcHJlZl0KWyAgICA0
Ljg2NDY3Nl0gcGNpIDAwMDA6MDA6MDEuMDogcmVnIDB4MzA6IFttZW0gMHgwMDAwMDAwMC0w
eDAwMDNmZmZmIHByZWZdClsgICAgNC44ODg2NjhdIHBjaSAwMDAwOjAwOjAxLjA6IEJBUiA2
OiBhc3NpZ25lZCBbbWVtIDB4MTAwMDAwMDAtMHgxMDAzZmZmZiBwcmVmXQpbICAgIDQuODg5
OTQ3XSBwY2kgMDAwMDowMDowMS4wOiBCQVIgNDogYXNzaWduZWQgW21lbSAweDgwMDAwMDAw
MDAtMHg4MDAwMDAzZmZmIDY0Yml0IHByZWZdClsgICAgNC44OTA4ODNdIHBjaSAwMDAwOjAw
OjAxLjA6IEJBUiAwOiBhc3NpZ25lZCBbaW8gIDB4MTAwMC0weDEwMWZdClsgICAgNC45MzU5
MThdIEVJTko6IEFDUEkgZGlzYWJsZWQuClsgICAgNS40NDU3MzFdIHZpcnRpby1wY2kgMDAw
MDowMDowMS4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDAgLT4gMDAwMykKWyAgICA1LjY3MjU0
Nl0gU2VyaWFsOiA4MjUwLzE2NTUwIGRyaXZlciwgNCBwb3J0cywgSVJRIHNoYXJpbmcgZW5h
YmxlZApbICAgIDUuNzUwMjYwXSBTdXBlckggKEgpU0NJKEYpIGRyaXZlciBpbml0aWFsaXpl
ZApbICAgIDUuNzY1MjgzXSBtc21fc2VyaWFsOiBkcml2ZXIgaW5pdGlhbGl6ZWQKWyAgICA1
LjgxODk4Ml0gY2FjaGVpbmZvOiBVbmFibGUgdG8gZGV0ZWN0IGNhY2hlIGhpZXJhcmNoeSBm
b3IgQ1BVIDAKWyAgICA2LjE4MTQwOF0gbG9vcDogbW9kdWxlIGxvYWRlZApbICAgIDYuMjMz
MzE4XSBtZWdhc2FzOiAwNy43MTcuMDIuMDAtcmMxClsgICAgNi4zOTAwMThdIHBoeXNtYXAt
Zmxhc2ggMC5mbGFzaDogcGh5c21hcCBwbGF0Zm9ybSBmbGFzaCBkZXZpY2U6IFttZW0gMHgw
MDAwMDAwMC0weDAzZmZmZmZmXQpbICAgIDYuMzk0MjA5XSAwLmZsYXNoOiBGb3VuZCAyIHgx
NiBkZXZpY2VzIGF0IDB4MCBpbiAzMi1iaXQgYmFuay4gTWFudWZhY3R1cmVyIElEIDB4MDAw
MDAwIENoaXAgSUQgMHgwMDAwMDAKWyAgICA2LjM5NzIwOF0gSW50ZWwvU2hhcnAgRXh0ZW5k
ZWQgUXVlcnkgVGFibGUgYXQgMHgwMDMxClsgICAgNi4zOTkyMjNdIFVzaW5nIGJ1ZmZlciB3
cml0ZSBtZXRob2QKWyAgICA2LjU5MDc4Nl0gcGh5c21hcC1mbGFzaCAwLmZsYXNoOiBwaHlz
bWFwIHBsYXRmb3JtIGZsYXNoIGRldmljZTogW21lbSAweDA0MDAwMDAwLTB4MDdmZmZmZmZd
ClsgICAgNi41OTM0MDddIDAuZmxhc2g6IEZvdW5kIDIgeDE2IGRldmljZXMgYXQgMHgwIGlu
IDMyLWJpdCBiYW5rLiBNYW51ZmFjdHVyZXIgSUQgMHgwMDAwMDAgQ2hpcCBJRCAweDAwMDAw
MApbICAgIDYuNTk0ODYzXSBJbnRlbC9TaGFycCBFeHRlbmRlZCBRdWVyeSBUYWJsZSBhdCAw
eDAwMzEKWyAgICA2LjU5OTQyM10gVXNpbmcgYnVmZmVyIHdyaXRlIG1ldGhvZApbICAgIDYu
NjAxMTkyXSBDb25jYXRlbmF0aW5nIE1URCBkZXZpY2VzOgpbICAgIDYuNjAxNjk3XSAoMCk6
ICIwLmZsYXNoIgpbICAgIDYuNjAyMDE4XSAoMSk6ICIwLmZsYXNoIgpbICAgIDYuNjAyMzYx
XSBpbnRvIGRldmljZSAiMC5mbGFzaCIKWyAgICA3LjA5MDg2OF0gRnJlZWluZyBpbml0cmQg
bWVtb3J5OiA1ODcxMksKWyAgICA3LjU5ODMxMl0gbGlicGh5OiBGaXhlZCBNRElPIEJ1czog
cHJvYmVkClsgICAgNy42OTQ2NTldIHR1bjogVW5pdmVyc2FsIFRVTi9UQVAgZGV2aWNlIGRy
aXZlciwgMS42ClsgICAgNy43NjgzMjZdIHRodW5kZXJfeGN2LCB2ZXIgMS4wClsgICAgNy43
NzA3NTVdIHRodW5kZXJfYmd4LCB2ZXIgMS4wClsgICAgNy43NzMyMzhdIG5pY3BmLCB2ZXIg
MS4wClsgICAgNy44MTI5MjhdIGhjbGdlIGlzIGluaXRpYWxpemluZwpbICAgIDcuODEzNzg4
XSBobnMzOiBIaXNpbGljb24gRXRoZXJuZXQgTmV0d29yayBEcml2ZXIgZm9yIEhpcDA4IEZh
bWlseSAtIHZlcnNpb24KWyAgICA3LjgxNDMzN10gaG5zMzogQ29weXJpZ2h0IChjKSAyMDE3
IEh1YXdlaSBDb3Jwb3JhdGlvbi4KWyAgICA3LjgxNzgyOV0gZTEwMDA6IEludGVsKFIpIFBS
Ty8xMDAwIE5ldHdvcmsgRHJpdmVyClsgICAgNy44MTgyOTddIGUxMDAwOiBDb3B5cmlnaHQg
KGMpIDE5OTktMjAwNiBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICA3LjgyMTE3NV0gZTEwMDBl
OiBJbnRlbChSKSBQUk8vMTAwMCBOZXR3b3JrIERyaXZlcgpbICAgIDcuODIxNTQyXSBlMTAw
MGU6IENvcHlyaWdodChjKSAxOTk5IC0gMjAxNSBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICA3
LjgyNDU2MV0gaWdiOiBJbnRlbChSKSBHaWdhYml0IEV0aGVybmV0IE5ldHdvcmsgRHJpdmVy
ClsgICAgNy44MjQ5NjVdIGlnYjogQ29weXJpZ2h0IChjKSAyMDA3LTIwMTQgSW50ZWwgQ29y
cG9yYXRpb24uClsgICAgNy44MjY4NzNdIGlnYnZmOiBJbnRlbChSKSBHaWdhYml0IFZpcnR1
YWwgRnVuY3Rpb24gTmV0d29yayBEcml2ZXIKWyAgICA3LjgyNzI4MF0gaWdidmY6IENvcHly
aWdodCAoYykgMjAwOSAtIDIwMTIgSW50ZWwgQ29ycG9yYXRpb24uClsgICAgNy44MzY5NzFd
IHNreTI6IGRyaXZlciB2ZXJzaW9uIDEuMzAKWyAgICA3Ljg2OTEzOF0gVkZJTyAtIFVzZXIg
TGV2ZWwgbWV0YS1kcml2ZXIgdmVyc2lvbjogMC4zClsgICAgNy45NDYyMTFdIGVoY2lfaGNk
OiBVU0IgMi4wICdFbmhhbmNlZCcgSG9zdCBDb250cm9sbGVyIChFSENJKSBEcml2ZXIKWyAg
ICA3Ljk0NzExMl0gZWhjaS1wY2k6IEVIQ0kgUENJIHBsYXRmb3JtIGRyaXZlcgpbICAgIDcu
OTQ5NzQ3XSBlaGNpLXBsYXRmb3JtOiBFSENJIGdlbmVyaWMgcGxhdGZvcm0gZHJpdmVyClsg
ICAgNy45NTMzMjRdIGVoY2ktb3Jpb246IEVIQ0kgb3Jpb24gZHJpdmVyClsgICAgNy45NTYz
MjddIGVoY2ktZXh5bm9zOiBFSENJIEV4eW5vcyBkcml2ZXIKWyAgICA3Ljk1ODkxN10gb2hj
aV9oY2Q6IFVTQiAxLjEgJ09wZW4nIEhvc3QgQ29udHJvbGxlciAoT0hDSSkgRHJpdmVyClsg
ICAgNy45NjA0NDldIG9oY2ktcGNpOiBPSENJIFBDSSBwbGF0Zm9ybSBkcml2ZXIKWyAgICA3
Ljk2MzAxMF0gb2hjaS1wbGF0Zm9ybTogT0hDSSBnZW5lcmljIHBsYXRmb3JtIGRyaXZlcgpb
ICAgIDcuOTY2MzY3XSBvaGNpLWV4eW5vczogT0hDSSBFeHlub3MgZHJpdmVyClsgICAgNy45
ODMxNjBdIHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3IGludGVyZmFjZSBkcml2ZXIgdXNiLXN0
b3JhZ2UKWyAgICA4LjA3OTk1Nl0gcnRjLXBsMDMxIDkwMTAwMDAucGwwMzE6IHJlZ2lzdGVy
ZWQgYXMgcnRjMApbICAgIDguMDgxNjA4XSBydGMtcGwwMzEgOTAxMDAwMC5wbDAzMTogc2V0
dGluZyBzeXN0ZW0gY2xvY2sgdG8gMjAyMS0wNy0yNlQwNjozNzozMyBVVEMgKDE2MjcyODE0
NTMpClsgICAgOC4xMDE2MDFdIGkyYyAvZGV2IGVudHJpZXMgZHJpdmVyClsgICAgOC4yNzQ0
NjBdIHNkaGNpOiBTZWN1cmUgRGlnaXRhbCBIb3N0IENvbnRyb2xsZXIgSW50ZXJmYWNlIGRy
aXZlcgpbICAgIDguMjc1MDUzXSBzZGhjaTogQ29weXJpZ2h0KGMpIFBpZXJyZSBPc3NtYW4K
WyAgICA4LjI5MzY0N10gU3lub3BzeXMgRGVzaWdud2FyZSBNdWx0aW1lZGlhIENhcmQgSW50
ZXJmYWNlIERyaXZlcgpbICAgIDguMzE5ODE2XSBzZGhjaS1wbHRmbTogU0RIQ0kgcGxhdGZv
cm0gYW5kIE9GIGRyaXZlciBoZWxwZXIKWyAgICA4LjM1OTQ4Nl0gbGVkdHJpZy1jcHU6IHJl
Z2lzdGVyZWQgdG8gaW5kaWNhdGUgYWN0aXZpdHkgb24gQ1BVcwpbICAgIDguNDEzNzU0XSB1
c2Jjb3JlOiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIHVzYmhpZApbICAgIDgu
NDE0Mzk0XSB1c2JoaWQ6IFVTQiBISUQgY29yZSBkcml2ZXIKWyAgICA4LjU2NTgxOF0gTkVU
OiBSZWdpc3RlcmVkIFBGX1BBQ0tFVCBwcm90b2NvbCBmYW1pbHkKWyAgICA4LjU3NTUzMF0g
OXBuZXQ6IEluc3RhbGxpbmcgOVAyMDAwIHN1cHBvcnQKWyAgICA4LjU3ODA0Ml0gS2V5IHR5
cGUgZG5zX3Jlc29sdmVyIHJlZ2lzdGVyZWQKWyAgICA4LjU4NjY3N10gTG9hZGluZyBjb21w
aWxlZC1pbiBYLjUwOSBjZXJ0aWZpY2F0ZXMKWyAgICA4LjY0MTYwOV0gaW5wdXQ6IGdwaW8t
a2V5cyBhcyAvZGV2aWNlcy9wbGF0Zm9ybS9ncGlvLWtleXMvaW5wdXQvaW5wdXQwClsgICAg
OC43NzI3MzddIEFMU0EgZGV2aWNlIGxpc3Q6ClsgICAgOC43NzMyNDBdICAgTm8gc291bmRj
YXJkcyBmb3VuZC4KWyAgICA4Ljc4NTU0NV0gdWFydC1wbDAxMSA5MDAwMDAwLnBsMDExOiBu
byBETUEgcGxhdGZvcm0gZGF0YQpbICAgIDguOTI0NjMzXSBGcmVlaW5nIHVudXNlZCBrZXJu
ZWwgbWVtb3J5OiAxOTcxMksKWyAgICA4LjkyNzEwOV0gUnVuIC9pbml0IGFzIGluaXQgcHJv
Y2Vzcw==
--------------40C0C025EA6F0FE18B2C7943--
