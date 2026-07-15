Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFFB37CD52;
	Wed, 15 Jul 2026 07:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784099610; cv=none; b=hsDppjoQSRo2HzgBSRpwB1ZGkeR9PxY/Cc0kmYsMqduB8tJgQd6mptGL7xn5QEtUCHtfbnScTrrum9Io4r06MYkyrzRj33XiIBBQD8zN2NVTxyjbDVrb6/s3TsMlrzdBp9m7nT6vfoRntYkb4JY4pyPjKkvCpKH4lnVEExbK8NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784099610; c=relaxed/simple;
	bh=BEVfj6pXgmWNnWUwuosLwNFNES+D2pYbMFJ5jYFlSmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=URQ8XFiTAa5560SVi/doPZS9tIEDWseHNxymRYRySgNtAsGzf07fZO+N+hzTdG/gQDtYIlvERIVZ+ga6wEUOFfSNAB1L4Xo/0aNlUWLa2WH3z3xYZxnSyChZkYo1oA0egj0O0PeRyX9Uj3VGI4U5UF0XT/PRvVEo6KbrewqhQSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: a69b5240801c11f1aa26b74ffac11d73-20260715
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:cc6f40cd-8dc4-4e5a-88a0-1462d746d1f0,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:957810819eae9689ba38ab5f83e28693,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|83|102|850|865|898,TC:nil,Content:
	0|15|50,EDM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,O
	SI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: a69b5240801c11f1aa26b74ffac11d73-20260715
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 716814898; Wed, 15 Jul 2026 15:13:16 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: andriy.shevchenko@linux.intel.com
Cc: 13667453960@163.com,
	andy@kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	stable@kernel.org,
	yijiangshan@kylinos.cn
Subject: Re: Re: [PATCH] serial: 8250_mid: Fix NULL function pointer dereference on DNV/ICX-D/SNR platforms                                                                                                                                   
Date: Wed, 15 Jul 2026 15:13:13 +0800
Message-Id: <20260715071313.1845772-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alckT06ko8sfvfMV@ashevche-desk.local>
References: <alckT06ko8sfvfMV@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Jul 15, 2026 at 11:03:36AM +0800, Andy Shevchenko wrote:                                                                                                                                                                          
> Oh, thanks!                                                                                                                                                                                                                             
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>                                                                                                                                                                        
> but I have a nit-pick below.                                                                                                                                                                                                            

Hi Andy Shevchenko,
                                                                                                                                           
Thank you for the review and the suggestions!                                                                                                                                                                                             
                                                                                                                                                                                                                                              
You're right.I have updated the patch accordingly:                                                                                                                                                                                                     
1. Changed the setup call from a ternary expression to an if-block                                                                                                                                                                        
   as suggested.                                                                                                                                                                                                                          
2. Removed the redundant Cc lines from the commit message body.                                                                                                                                                                           
                                                                                                                                                                                                                                              
I will send the v2 version shortly.                                                                                                                                                                                                       
                                                                                                                                                                                                                                              
Best regards,                                                                                                                                                                                                                             
Jiangshan Yi 
