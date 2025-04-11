Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C43290083;
	Fri, 11 Apr 2025 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363135; cv=none; b=sEq5KBg77RYxwTC5YRI0vkxgLFD2KJ8eNMEFUS8+Ok5FuncBUVvbU4TwOZ5G6kMFhKR5jl9w+sVR/ypp3KnFlx/i/bYjYXjStT2BD58qXiYIPnV1vwaveQLEIUNE69oEj/xdHaCPYAYMwm3thD5Hy52MiTmUXkRdtg65HCLL8Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363135; c=relaxed/simple;
	bh=7yUILR2HHoVy6WM/2coCWGrDjXlSF1kGC0dNtca/tpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pucuv6xe3B22cGgHWRx6BFIxCxSSPijnaE4l8opjd2ck3O2pRW2/xUaGPvuDQX4xV5pu7tNueMm5AzD8U5RagGeWIPBMdNRf8sF964ZiDSqT074LYgIEKxmtgKda8g4zOdAL0e8/xOYBJotK4W2hv8B6uZRDN9cgzR5/jHQtXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: f74939c216b511f0a216b1d71e6e1362-20250411
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:97bd0d2f-92db-49d9-89fb-6bbdd8a2c89e,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6493067,CLOUDID:0cef45754f47842cd311d779ca37ae05,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f74939c216b511f0a216b1d71e6e1362-20250411
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1327214905; Fri, 11 Apr 2025 17:18:44 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id EE66F160038D0;
	Fri, 11 Apr 2025 17:18:43 +0800 (CST)
X-ns-mid: postfix-67F8DE73-8881991508
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id 2D1CC16003810;
	Fri, 11 Apr 2025 09:18:42 +0000 (UTC)
Message-ID: <ae40b4bc-4635-4b5d-bc2a-4c304605e3a1@kylinos.cn>
Date: Fri, 11 Apr 2025 17:18:22 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty/sysrq: make sysrq_replay_logs_op const
To: xiaopeitux@foxmail.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <tencent_E7CD9DB87A448073E350F9400678ED9F9C0A@qq.com>
From: Pei Xiao <xiaopei01@kylinos.cn>
In-Reply-To: <tencent_E7CD9DB87A448073E350F9400678ED9F9C0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2025/4/3 16:38, xiaopeitux@foxmail.com =E5=86=99=E9=81=93:

> From: Pei Xiao <xiaopei01@kylinos.cn>
>
> Mark sysrq_replay_logs_op as const, preventing accidental modification.
>
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> ---
>  drivers/tty/sysrq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/sysrq.c b/drivers/tty/sysrq.c
> index f85ce02e4725..e9ada1c14e26 100644
> --- a/drivers/tty/sysrq.c
> +++ b/drivers/tty/sysrq.c
> @@ -454,7 +454,7 @@ static void sysrq_handle_replay_logs(u8 key)
>  {
>  	console_try_replay_all();
>  }
> -static struct sysrq_key_op sysrq_replay_logs_op =3D {
> +static const struct sysrq_key_op sysrq_replay_logs_op =3D {
>  	.handler        =3D sysrq_handle_replay_logs,
>  	.help_msg       =3D "replay-kernel-logs(R)",
>  	.action_msg     =3D "Replay kernel logs on consoles",

now, split into a single patch.

Thanks!

Pei.

