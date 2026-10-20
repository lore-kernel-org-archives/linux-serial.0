Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792488178;
	b=xg0YBlSII6e5m17ai16D6nw5gbLRYwlAYJLusUwFFt3L1gHda1fZYNALy9D/L1ZckcPj
	 yojcLjqIyCI08mafSsQIhZSwSxRS6No71jobTwwM6J4sGm027Bm/PtB/qiEJR0/R8i1d8
	 uJkSO91oOMfuigrVb0d9GpAUhBR+KSenJxPmxK4EHQJnnDeeCI3ze8WCy36Yv3fnfxTUZ
	 NihmxxZl5/ZsI4XUjW/R7Y9BaxKzUrQIMfncNruEtSJfM2AJMiEEtTkXWzB8i6EuHR0r0
	 8eELqXP5e8OJ/r7JtSmZxTvgkp0YX78kD0XopCfTghMWBjRNUI82vXquEN1xCu1h3Wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792488178;
	h=DMARC-Filter:X-UUID:X-CID-CACHE:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:
	 X-CID-BVR:X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dfleKrC9cIgnLU1uT+jP6C3/Ahfxyhp5j56NZoD4Xn4=;
	b=Co4KqD50gZM2oiPT9+paUTMLOF1paZeLE5Gbw+/176dDlOFTaLpRzGKD1+o4NGLf9LY3
	 kzp9XP+MG0DD6q+ekswV+Qh1eK5Ocg484OcJ9PKTxG9wbbP8bTlXGS3AYMCraN3jEtNAq
	 5qimHw7tMgY6nQIbyUA/k4dPo7mlTB6C/FZbvpj2aODbofWg4U4R4erVSxPHq/7cgjkHb
	 Gve2RiLXJuV0ZWOw62m8h51M4Pumdeeh5GKym/XhVDB9isg6U3Dd4I7pg1n9+M89R57IK
	 EV5YpiYtF41D+7oxgTy6Ob+fiQoFDwNt9skfuv74cTU2lthvJk1hT8KfDyruaGH9TEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3ED606A31B
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 09:22:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3ED606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d0f4edaccc6711f19a56ed5b684f684d-20261020
X-CID-CACHE: Type:Local,Time:202610201634+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:b2c6e069-d36b-4f53-a54e-cab618495a6c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:7db8b62,CLOUDID:f53b124157d185954d1e71a5178509f1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|865|898,TC:nil,Content:0|15|50|99,EDM
	:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
	,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d0f4edaccc6711f19a56ed5b684f684d-20261020
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 1235309580; Tue, 20 Oct 2026 17:22:48 +0800
Message-ID: <822549a4-2834-4322-b7f1-cf8dae01a672@kylinos.cn>
Date: Tue, 20 Oct 2026 17:22:46 +0800
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: atmel: Replace SIMPLE_DEV_PM_OPS with
 DEFINE_SIMPLE_DEV_PM_OPS
Content-Language: en-US
To: Richard GENOUD <richard.genoud@bootlin.com>
References: <20261020084113.853878-1-lijun01@kylinos.cn>
 <745706ca-58cc-48cb-8ef1-69a69aa34ac2@bootlin.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <745706ca-58cc-48cb-8ef1-69a69aa34ac2@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you for your  suggestion, next time, i will  add [PATCH RESEND] in 
the subject.

  2026/10/20 16:47, Richard GENOUD :
> add [PATCH RESEND] in the subject
