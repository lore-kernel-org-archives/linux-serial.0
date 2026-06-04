Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599613DC4A0;
	Thu,  4 Jun 2026 06:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556074; cv=none; b=P0NzEk95Pamd9KbFdpkihi9bpwpX95SDPNDVb+iBoCt104KYwygySB9qhgPlmfovtQs8AlAhDRg0niaiUQ7hUAsxBpYHlQT5AhbAAn/DB8JHqNIGJfd9a2FKPAkmoBfDpTu8Arq5LGkftOoyvUahkpWGYWDy1OtV3XIUuCVGtzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556074; c=relaxed/simple;
	bh=t7wzq6SwHHzn7m7pUKVKyD/LXQvtEiqNndJ8YuiXegs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cZcO3Bf77uDs0dv8mqJYpNgvDdsSHDW6l+MEgkWMKhvLZB9M35a81X/ZQyAEkRu4MVPlc9OnOnMk61oS4eS0B/0/Lv2Y65TMUuEC05lhjAYpuEwgw9L5E9NY5I+4wOMt07F+E4dMCi/vVs4+99rjDkeqLlbUaY2iUUPORH1ZBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaI/RHek; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaI/RHek"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945381F00893;
	Thu,  4 Jun 2026 06:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780556072;
	bh=GgVMlH4NEsyzxnB1xdRNm+DEWtAAcP1PE8YdWu5s0L0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jaI/RHekNfMp678FolEbAeKuPGG9bvWE1aLf9jyVzJAb+vHTVNc2wy/uytdho3b10
	 h0nbr2VQgaxzOIoVGLVwB5j/zlNjK/YmT++RmSNMzGOP3eAywYc6W/N47/zrqBlAPR
	 ddivwAbP88M04e2UI2HTjjU+2xiCQJxyBGxuGQH1PR2s5bMY1QQFOc02lxcbS2WOHn
	 pK7aVU3u8qBDCBDerB/79tm4d0sbrKgLgzJiqPlkKVKnTErFmOlW1ErYS7vSi4L7vz
	 9AdS3l7u+vy9Bfdz2P2WmpSHW1Xfpb5tWX3zLgaTNip8RpaDY3ItMNG41CSgrFAjYV
	 qANuoLd5BGGrg==
Message-ID: <f84f410c-c506-4245-a760-ec48f4c06c5b@kernel.org>
Date: Thu, 4 Jun 2026 08:54:29 +0200
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vc_screen: fix null-ptr-deref in vcs_notifier() during
 concurrent vcs_write
To: Yi Yang <yiyang13@huawei.com>, gregkh@linuxfoundation.org,
 kees@kernel.org, linux@weissschuh.net, george.kennedy@oracle.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 lujialin4@huawei.com
References: <20260604060734.2914976-1-yiyang13@huawei.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <20260604060734.2914976-1-yiyang13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04. 06. 26, 8:07, Yi Yang wrote:
> A KASAN null-ptr-deref was observed in vcs_notifier():
> 
> BUG: KASAN: null-ptr-deref in vcs_notifier+0x98/0x130
> Read of size 2 at addr qmp_cmd_name: qmp_capabilities, arguments: {}
> 
> The issue is a race condition in vcs_write(). When the console_lock is
> temporarily dropped (to copy data from userspace), the vc_data pointer
> obtained from vcs_vc() may become stale. After re-acquiring the lock,
> vcs_vc() is called again to re-validate the pointer. If the vc has been
> deallocated in the meantime, vcs_vc() returns NULL, and the while loop
> breaks (with written > 0). However, after the loop, vcs_scr_updated(vc)
> is still called with the now-NULL vc pointer, leading to a null pointer
> dereference in the notifier chain (vcs_notifier dereferences param->vc).
> 
> Fix this by adding a NULL check for vc before calling vcs_scr_updated().

And vc is still protected by console_lock at that point.

> Fixes: 8fb9ea65c9d1 ("vc_screen: reload load of struct vc_data pointer in vcs_write() to avoid UAF")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yi Yang <yiyang13@huawei.com>

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

> ---
>   drivers/tty/vt/vc_screen.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/tty/vt/vc_screen.c b/drivers/tty/vt/vc_screen.c
> index 4d2d46c95fef..7d40eacc21b3 100644
> --- a/drivers/tty/vt/vc_screen.c
> +++ b/drivers/tty/vt/vc_screen.c
> @@ -686,7 +686,7 @@ vcs_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
>   	}
>   	*ppos += written;
>   	ret = written;
> -	if (written)
> +	if (written && vc)
>   		vcs_scr_updated(vc);
>   
>   	return ret;


-- 
js
suse labs
