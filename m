Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1866A1E7660;
	Mon, 28 Sep 2026 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599870; cv=none; b=DizLo8RMLWESgSCwdnLcnXr9DkIxSC5IK/LG/s3d3vXiiXv5NZJhg1ffdMXJGFNQBIahbshTvZ8+HU6ijZ/ID1WPfGTAtcgmzL3R5Sly/J1yig41kHNYd6/8Tmd0RUyVWXYHqbqIY7bTjYX9Gclwn6oAVsy/g0Al/QAIml+igKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599870; c=relaxed/simple;
	bh=jqBOi8RadvRg8zGzldieQe2C78fCScYRODmweJs9DpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wf1ATlvKlv5tY+dwCnxal8RWOC7+KNOYbJ+vU2j/D9UFdVRreDGGc8QgYg0eTWPGyTukDKfMcbLK15QZ8PITgdJr5mvmlz9ZReIM9UZH+jWHTixt9Bf40lvADXyzLUVceUfsbineSv2P8GzAEPGT/hcdq6SeV/2ZgMYmW29oewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4hth4D3fkYzYQtqf;
	Mon, 28 Sep 2026 20:50:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0CAAA408D5;
	Mon, 28 Sep 2026 20:51:02 +0800 (CST)
Received: from [10.174.176.179] (unknown [10.174.176.179])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgCHVimzYrpqZYAACA--.5312S3;
	Mon, 28 Sep 2026 20:51:01 +0800 (CST)
Message-ID: <6bff4ccc-1a0c-402e-af98-4f6fef94b0a9@huaweicloud.com>
Date: Mon, 28 Sep 2026 20:50:59 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vt: skip screen update for DEC alignment test on
 backgroup consoles
To: Zizhi Wo <wozizhi@huaweicloud.com>, gregkh@linuxfoundation.org,
 jirislaby@kernel.org, npitre@baylibre.com, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com
References: <20260905064337.3083103-1-wozizhi@huaweicloud.com>
From: Zizhi Wo <wozizhi@huaweicloud.com>
In-Reply-To: <20260905064337.3083103-1-wozizhi@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHVimzYrpqZYAACA--.5312S3
X-Coremail-Antispam: 1UD129KBjvJXoWxZw4DZr18tr1fAF15uryDKFg_yoW5AF1rpa
	yFk3Wvvw1vgr4kZa1qya13XFy8CwsFqr1UurZ3AF17ZF1UZr1kuasrJa4DGrZ7X392kryf
	A3W5Xr9Y9F1093DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkm14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

friendly ping...

在 2026/9/5 14:43, Zizhi Wo 写道:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> [BUG]
> Recently, we encountered a KASAN warning as follows:
> 
> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0x11f/0x140
> Read of size 1 at addr ff1100015fd9f6a4 by task tty_fbcon_oob/1239
> CPU: 7 UID: 0 PID: 1239 Comm: tty_fbcon_oob Not tainted 7.3.0-rc1 #100 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-4.fc41 04/01/2014
> Call Trace:
>   <TASK>
>   ...
>   kasan_report+0xf0/0x120
>   fb_pad_aligned_buffer+0x11f/0x140
>   ccw_putcs+0x86c/0xa80
>   fbcon_putcs+0x338/0x410
>   do_update_region+0x21d/0x450
>   do_con_write+0x1e0e/0x4880
>   con_write+0x13/0x80
>   n_tty_write+0x374/0x1010
>   file_tty_write.isra.0+0x404/0x7a0
>   ...
> 
> reproduce:
> 1) open /dev/tty0, set a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
> op.width = 8 and op.height = 16 (visible VC1)
> 2) open /dev/tty1, set a KDFONTOP ioctl with op.op = KD_FONT_OP_SET,
> op.width = 28 and op.height = 24 (invisible VC2)
> 3) echo 3 > /sys/devices/virtual/graphics/fbcon/rotate_all
> 4) write EShash8(esc hash8) to tty1
> 
> [CAUSE]
> All VCs render to the framebuffer. setfont only modifies the target VC's
> font without resizing the framebuffer backing buffer (par->rotated.buf);
> the buffer is only resized for the visible VC
> (fbcon_do_set_font -> ... -> vc_do_resize -> update_screen). This relies on
> the con_should_update() check performed before every update_region().
> 
> However, the ESC # 8 path (do_con_trol -> do_update_region) omits the
> con_should_update() check. After changing the font size of an invisible VC,
> do_update_region() fills using the new font size against a buffer that was
> never resized, causing an out-of-bounds access.
> 
> [FIX]
> Only push the update when the console is visible and not blanked, add
> the con_should_update() check in the do_con_trol() like every other call
> site of do_update_region() (update_region(), invert_screen(), ...).
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
> ---
>   drivers/tty/vt/vt.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 8f467b22b799..901bb2ce01dc 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -2858,11 +2858,12 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
>   			vc->vc_video_erase_char =
>   				(vc->vc_video_erase_char & 0xff00) | 'E';
>   			csi_J(vc, CSI_J_VISIBLE);
>   			vc->vc_video_erase_char =
>   				(vc->vc_video_erase_char & 0xff00) | ' ';
> -			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
> +			if (con_should_update(vc))
> +				do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
>   		}
>   		return;
>   	case ESsetG0:	/* ESC ( */
>   		vc_setGx(vc, 0, c);
>   		vc->vc_state = ESnormal;

