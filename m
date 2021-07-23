Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC45C4338F
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 16:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9C4C60E78
	for <linux-serial@archiver.kernel.org>; Fri, 23 Jul 2021 16:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhGWQHQ (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Fri, 23 Jul 2021 12:07:16 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:2792 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229847AbhGWQHQ (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Jul 2021 12:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1627058869; x=1658594869;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=2JKy2ljYCiKdg4+77F6qV26c1zbXUcznA/csadAmEGk=;
  b=TSgs6qbRx7rRw7XLTjnhI1PzllsN6iOVJwntN0zL/Uo9p4Et/xNWol23
   5mlqWDL1ngDo06tnoA3oxviMYJ8RMVBwYpaUH7gH0h2aIiAgekgabf/TW
   GIGHYjGUeVKsU/iq1MuV8kIvOjwr+onLhVr+rsTwBHBmfB1VEtWxm4TFH
   o=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jul 2021 09:47:49 -0700
X-QCInternal: smtphost
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA; 23 Jul 2021 09:47:49 -0700
Received: from [10.111.172.214] (10.80.80.8) by nasanexm03e.na.qualcomm.com
 (10.85.0.48) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Fri, 23 Jul
 2021 09:47:48 -0700
Subject: Re: [PATCH v5] arm pl011 serial: support multi-irq request
To:     Bing Fan <hptsfb@gmail.com>, <gregkh@linuxfoundation.org>,
        Bing Fan <tombinfan@tencent.com>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
From:   Qian Cai <quic_qiancai@quicinc.com>
Message-ID: <60f007b3-bb01-dd0a-b1a2-a6da62a486e5@quicinc.com>
Date:   Fri, 23 Jul 2021 12:47:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1625103512-30182-1-git-send-email-hptsfb@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanexm03f.na.qualcomm.com (10.85.0.47) To
 nasanexm03e.na.qualcomm.com (10.85.0.48)
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org



On 6/30/2021 9:38 PM, Bing Fan wrote:
> From: Bing Fan <tombinfan@tencent.com>
> 
> In order to make pl011 work better, multiple interrupts are
> required, such as TXIM, RXIM, RTIM, error interrupt(FE/PE/BE/OE);
> at the same time, pl011 to GIC does not merge the interrupt
> lines(each serial-interrupt corresponding to different GIC hardware
> interrupt), so need to enable and request multiple gic interrupt
> numbers in the driver.
> 
> Signed-off-by: Bing Fan <tombinfan@tencent.com>
> ---
>  drivers/tty/serial/amba-pl011.c | 34 ++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
> index 78682c12156a..7bfe8efcc787 100644
> --- a/drivers/tty/serial/amba-pl011.c
> +++ b/drivers/tty/serial/amba-pl011.c
> @@ -1701,11 +1701,39 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
>  	}
>  }
>  
> +static void pl011_release_irq(struct uart_amba_port *uap, unsigned int max_cnt)
> +{
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +	int i;
> +
> +	for (i = 0; i < max_cnt; i++)
> +		if (amba_dev->irq[i])
> +			free_irq(amba_dev->irq[i], uap);
> +}
> +
>  static int pl011_allocate_irq(struct uart_amba_port *uap)
>  {
> +	int ret = 0;
> +	int i;
> +	unsigned int virq;
> +	struct amba_device *amba_dev = container_of(uap->port.dev, struct amba_device, dev);
> +
>  	pl011_write(uap->im, uap, REG_IMSC);
>  
> -	return request_irq(uap->port.irq, pl011_int, IRQF_SHARED, "uart-pl011", uap);
> +	for (i = 0; i < AMBA_NR_IRQS; i++) {
> +		virq = amba_dev->irq[i];

This could trigger a slab-out-of-bounds during booting.

[   18.716444] BUG: KASAN: slab-out-of-bounds in pl011_allocate_irq+0x1f8/0x2f8
[   18.724191] Read of size 4 at addr ffff00001a3a0508 by task swapper/0/1

[   18.733680] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.14.0-rc2-next-20210723 #69
[   18.741941] Hardware name: MiTAC RAPTOR EV-883832-X3-0001/RAPTOR, BIOS 1.6 06/28/2020
[   18.750461] Call trace:
[   18.753597]  dump_backtrace+0x0/0x3b8
[   18.757956]  show_stack+0x20/0x30
[   18.761964]  dump_stack_lvl+0x8c/0xb8
[   18.766319]  print_address_description.constprop.0+0x74/0x3c8
[   18.772759]  kasan_report+0x1f0/0x208
[   18.777113]  __asan_report_load4_noabort+0x34/0x60
[   18.782596]  pl011_allocate_irq+0x1f8/0x2f8
[   18.787471]  sbsa_uart_startup+0x44/0x98
[   18.792086]  uart_startup.part.0+0x28c/0x618
[   18.797048]  uart_port_activate+0xf0/0x178
[   18.801836]  tty_port_open+0x118/0x1c8
[   18.806278]  uart_open+0x44/0x70
[   18.810199]  tty_open+0x248/0x960
[   18.814207]  chrdev_open+0x19c/0x440
[   18.818476]  do_dentry_open+0x3ac/0xdb0
[   18.823005]  vfs_open+0x98/0xd0
[   18.826838]  do_open.isra.0+0x4a8/0x8c0
[   18.831366]  path_openat+0x3ac/0xe28
[   18.835633]  do_filp_open+0x150/0x220
[   18.839987]  file_open_name+0x120/0x200
[   18.844515]  filp_open+0x40/0x80
[   18.848436]  console_on_rootfs+0x30/0x7c
[   18.853052]  kernel_init_freeable+0x74c/0x7d0
[   18.858100]  kernel_init+0x2c/0x140
[   18.862282]  ret_from_fork+0x10/0x18

[   18.868732] Allocated by task 1:
[   18.872651]  kasan_save_stack+0x28/0x58
[   18.877181]  __kasan_kmalloc+0x8c/0xb0
[   18.881622]  __kmalloc+0x260/0x3d0
[   18.885716]  platform_device_alloc+0x34/0x1b8
[   18.890766]  platform_device_register_full+0x68/0x418
[   18.896509]  acpi_create_platform_device.part.0+0x170/0x538
[   18.902776]  acpi_create_platform_device+0x8c/0xa8
[   18.908259]  acpi_default_enumeration+0x54/0xd0
[   18.913482]  acpi_bus_attach+0x664/0x7d0
[   18.918096]  acpi_bus_attach+0x178/0x7d0
[   18.922709]  acpi_bus_attach+0x178/0x7d0
[   18.927324]  acpi_bus_attach+0x178/0x7d0
[   18.931937]  acpi_bus_scan+0xa8/0x170
[   18.936291]  acpi_scan_init+0x220/0x554
[   18.940819]  acpi_init+0x1fc/0x27c
[   18.944912]  do_one_initcall+0x170/0xb98
[   18.949527]  kernel_init_freeable+0x718/0x7d0
[   18.954575]  kernel_init+0x2c/0x140
[   18.958759]  ret_from_fork+0x10/0x18

[   18.965214] The buggy address belongs to the object at ffff00001a3a0000
                which belongs to the cache kmalloc-2k of size 2048
[   18.979117] The buggy address is located 1288 bytes inside of
                2048-byte region [ffff00001a3a0000, ffff00001a3a0800)
[   18.992412] The buggy address belongs to the page:
[   18.997894] page:ffffffc000068e00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x9a38
[   19.007805] head:ffffffc000068e00 order:2 compound_mapcount:0 compound_pincount:0
[   19.015977] flags: 0x7ffff800010200(slab|head|node=0|zone=0|lastcpupid=0xfffff)
[   19.023982] raw: 007ffff800010200 ffffffc000067508 ffffffc000069f08 ffff000012911280
[   19.032416] raw: 0000000000000000 00000000002a002a 00000001ffffffff 0000000000000000
[   19.040848] page dumped because: kasan: bad access detected

[   19.049291] Memory state around the buggy address:
[   19.054772]  ffff00001a3a0400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[   19.062684]  ffff00001a3a0480: 00 00 00 00 00 00 00 00 00 00 00 04 fc fc fc fc
[   19.070595] >ffff00001a3a0500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   19.078506]                       ^
[   19.082686]  ffff00001a3a0580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
[   19.090597]  ffff00001a3a0600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc


> +		if (virq == 0)
> +			break;
> +
> +		ret = request_irq(virq, pl011_int, IRQF_SHARED, dev_name(&amba_dev->dev), uap);
> +		if (ret) {
> +			dev_err(uap->port.dev, "request %u interrupt failed\n", virq);
> +			pl011_release_irq(uap, i - 1);
> +			break;
> +		}
> +	}
> +
> +	return ret;
>  }
>  
>  /*
> @@ -1864,7 +1892,7 @@ static void pl011_shutdown(struct uart_port *port)
>  
>  	pl011_dma_shutdown(uap);
>  
> -	free_irq(uap->port.irq, uap);
> +	pl011_release_irq(uap, AMBA_NR_IRQS);
>  
>  	pl011_disable_uart(uap);
>  
> @@ -1894,7 +1922,7 @@ static void sbsa_uart_shutdown(struct uart_port *port)
>  
>  	pl011_disable_interrupts(uap);
>  
> -	free_irq(uap->port.irq, uap);
> +	pl011_release_irq(uap, AMBA_NR_IRQS);
>  
>  	if (uap->port.ops->flush_buffer)
>  		uap->port.ops->flush_buffer(port);
> 
