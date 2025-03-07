Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0D863CF;
	Fri,  7 Mar 2025 02:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741313614; cv=none; b=J6OenDC7r2/9DcMO+yDcl24cgHbKXjvWzQrsytEIfqUMD6A4YIWSM8q+9SizkYaCy8by6pzGaq9vwGAGWBES1r+7zdMnsOoOOq1YqRq8nBkbcJcnC8EutbwOpP7C4aD1Ko7ElbKYzfaXf23toful679ZT/do0Zkxx5PFjpCNBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741313614; c=relaxed/simple;
	bh=b2cWtXC1jbgi5umlBm9Vcc830Fi6Sru0+8pFSBC4eZQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=dlUqAslMhD3SIdlbYdHjGL3/L8upTj55w069xVyIObm1xUelz2U/wJn1c1dyEZTjpvxBp7n9KksHaxu+dZ6nSvytwFeS7Mp86MEYARUZAMJ3ujpqMZPxtvqgekQXDUb/Ri5Kb2wuAzcq2llTnNGILeZm6BdwpLDQiOEr4gUZD30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: be2f5798faf911efa216b1d71e6e1362-20250307
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:1cdbb6de-9e0c-48c9-9976-b814b3f5bb00,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:6493067,CLOUDID:6a3db4192fcd060ef7b18f8cde81c044,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:nil,Content:0|52,EDM:
	-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,
	AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: be2f5798faf911efa216b1d71e6e1362-20250307
Received: from node4.com.cn [(10.44.16.170)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1104782365; Fri, 07 Mar 2025 10:13:21 +0800
Received: from node4.com.cn (localhost [127.0.0.1])
	by node4.com.cn (NSMail) with SMTP id 6CA4316001CC7;
	Fri,  7 Mar 2025 10:13:21 +0800 (CST)
X-ns-mid: postfix-67CA5641-354583794
Received: from [10.42.13.56] (unknown [10.42.13.56])
	by node4.com.cn (NSMail) with ESMTPA id 052F516001CC7;
	Fri,  7 Mar 2025 02:13:20 +0000 (UTC)
Message-ID: <8c9ab398-4074-48b8-9606-21c50f057516@kylinos.cn>
Date: Fri, 7 Mar 2025 10:12:53 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pei Xiao <xiaopei01@kylinos.cn>
Subject: Re: [PATCH] serial: 8250: Optimize port function assignment with
 generic macro
To: Greg KH <gregkh@linuxfoundation.org>, xiaopeitux@foxmail.com
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
References: <tencent_50535E8627177335AEA311C5DC0A54609008@qq.com>
 <2025030602-frays-profusely-0656@gregkh>
In-Reply-To: <2025030602-frays-profusely-0656@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


=E5=9C=A8 2025/3/6 15:05, Greg KH =E5=86=99=E9=81=93:
> On Thu, Mar 06, 2025 at 11:00:32AM +0800, xiaopeitux@foxmail.com wrote:
>> From: xiaopei01 <xiaopei01@kylinos.cn>
> Sorry, as per the documentation we need a name, not just an email alias=
.

ok=EF=BC=8Cperhaps I changed a new computer to send patch caused it.=C2=A0

I will modify in next time!

>> Refactor repetitive conditional function pointer assignments using a
>> generic macro ASSIGN_IF_EXIST. This consolidates 15+ conditional
>> checks into a consistent pattern while maintaining type safety.
> But why?  Macros are a pain and hide what is happening here.  Do you
> think this makes the code more maintainable over time?  Does it fix any
> existing bugs?

sorry for make some noise=EF=BC=8CI know you're a very busy person.=C2=A0

Sorry for disturbing you=EF=BC=81

No,it don't fix any bugs.Indeed, it's less readable than the previous cod=
e.=C2=A0

Initially, I thought there were too many repetitive lines,=C2=A0

and the code length could be reduced.


thanks=EF=BC=81

Pei Xiao

> thanks,
>
> greg k-h
