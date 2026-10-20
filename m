Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.126.103.232
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792485272;
	b=C5MbjFmoFMh9R+iYsoqiTK+Tz0uokGPDo/G5G6/EjP0GDDEBLIdmlRjGCYUYtc7rIkYB
	 dVf77MyNIxcqjhaQAF7SDAnWUcbY0ffzcCjMKeYoRozJRv7633bLLP2NvOI81gZpjVaUO
	 x++MITLUbZMmpidmrgbImA37UUTUVURDfQvhelsZpmDwziEh5y79N+RcpIoWCH9KPkuV1
	 l8/2O/LTsxX9fi0Nm9VhR5AhH8YGlBoScmOhTeaPqN7UkNccRlttQ4AFs4fuJou/RB/1y
	 QPprZHQa7qpazJi514MWWQfK7AiW3VTWXRWUEgAOhh3zqM/+VVIrn0SI/2jHj39ipag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792485272;
	h=DMARC-Filter:X-UUID:X-CID-P-RULE:X-CID-O-INFO:X-CID-META:X-CID-BVR:
	 X-CID-BAS:X-CID-FACTOR:X-CID-RHF:X-UUID:X-User:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0B1IpDpXJHXCACBF1P0js5Bgliqg8eiw7sQ698GSb2Q=;
	b=I7bHuRnXsD9tk28RC7cZwm7Qi1/LpCSEw0eLmXQClwCINLnZ1JqZ/BiSoO2G4CiBxOrB
	 XV2wH9t5qKu44c9DWWeAKS/24VN2aJUNHLZ6I8XhSQG9xNNfEOsxTBSpBNd8UhC4Ubjj5
	 neYEN2Mp/8CM1WRVS61fKnkZmAeBA/961j5SdQiLtiU+vUATr1YO6miL+FARrW+632SIj
	 qSgDcRDZsox9YfZuZLk+Mcbt9vXH01CtxnECytaswK46lJ+Th+7YJ5JywsZGz1l9hTv9D
	 7lht5d33HTmnaq5tvVzczDyYzwwLPSyP/pykjgsJs4ajwO1SUTPAJicp1Lzqi1sdcmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=kylinos.cn;
	arc=none smtp.remote-ip=124.126.103.232
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CCF606A31F
	for <linux-serial@vger.kernel.org>; Tue, 20 Oct 2026 08:34:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0CCF606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0dab567acc6111f19a56ed5b684f684d-20261020
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a9e2f858-7652-407d-af76-9a9b6a7eec5f,IP:0,U
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
X-UUID: 0dab567acc6111f19a56ed5b684f684d-20261020
X-User: lijun01@kylinos.cn
Received: from [172.30.70.202] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <lijun01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 746982650; Tue, 20 Oct 2026 16:34:23 +0800
Message-ID: <6b27d63b-78ce-4b1f-a965-0b879bc3c497@kylinos.cn>
Date: Tue, 20 Oct 2026 16:34:21 +0800
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
To: Richard GENOUD <richard.genoud@bootlin.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 claudiu.beznea@tuxon.dev, linux-serial@vger.kernel.org
References: <20260908113719.4078979-1-lijun01@kylinos.cn>
 <908e8237-f17a-46b1-be55-41a3c9146750@bootlin.com>
 <fa5e93b6-d98d-440e-aa2a-727c91a5ffc1@bootlin.com>
Content-Language: en-US
From: lijun <lijun01@kylinos.cn>
In-Reply-To: <fa5e93b6-d98d-440e-aa2a-727c91a5ffc1@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

ok ,i will re-send it.

  2026/10/20 16:29, Richard GENOUD :
> re-send it
