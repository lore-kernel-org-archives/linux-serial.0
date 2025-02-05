Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77D2215077
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 08:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738743957; cv=none; b=XJxytkBnsDAGLPaiUZQMYZAHNCdLdzyyZNZ6Kii2w4pPaGWTNUGI3R/MKGdPCUkFok5RBI8vqY7GTHPW1ks8aDuuo9fAnB8kP6VcuBZPrGf98/0CZBHkn+yyQyM8U9dyIE3OC2/uZxLnYFZI6KhKDEJPKuM3f3Kznrx1O8zAa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738743957; c=relaxed/simple;
	bh=Mi/NLwIbGokVF9aspvwcN5BXu3vQjugkjy50y6UHsiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dPV0dSH9l8pqyv2Qs99SwuQ4j5hiN2wDZ83idPyQSfLIDEZpVGM4cnEgRSLiTi5T1Qa130R+l4uhsZmZI4t2e18AUJEPPs6g8w2jYia5WsVT0erCnfaAWEA4TLU25YzsVjlyloraVXoPX23AXhKvWRk395OuRX1BoZI27/U4Z68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=hERL5eAS; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="hERL5eAS"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id fO02tOfxwWuHKfajFtVjLw; Wed, 05 Feb 2025 08:25:49 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fajDtAb4WWkhGfajEtMLRz; Wed, 05 Feb 2025 08:25:48 +0000
X-Authority-Analysis: v=2.4 cv=WL15XGsR c=1 sm=1 tr=0 ts=67a3208c
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=ejmc5w4W0Lhx8iFsI5oA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ovkOZ8H+TdRMiuF7Wh/b9sjkTUEJ07ASv4wZ1VaaiRI=; b=hERL5eASI4HChR6B+Q0EzO30f+
	wGhhOM+Kz3x2IKMhgVoJcq3tLB0vrYgpdMtMZkDtxBpA4afwMpxHhV04sa8PQqpHRYnd9NgwhuJxe
	Ds9FxU0u/vYnYDW/4sowzYHXq+fOKyQ6Z2e29iz/SULQZmIsejBQnxpWJS1fkREzFkiTXxcpveD5C
	s3pTnBreaGvGlzcube2u5Q5pSO2w9pLcLjB4rKvbftmlxIQK1jmyY1yS/+1oQzt3taZqE2B7apUjs
	hKW0Dk08rww1XH86IHlQZGJZVXgCsW59Os0ImKeOyo46PQ5Ikjd4gcCSk4XB3yomddcF9v/5M7ZaL
	IC0l5Aiw==;
Received: from [45.124.203.140] (port=54647 helo=[192.168.0.157])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tfajC-003dlk-38;
	Wed, 05 Feb 2025 02:25:47 -0600
Message-ID: <ec807b7f-70af-4f27-8c88-6844020bd850@embeddedor.com>
Date: Wed, 5 Feb 2025 18:55:35 +1030
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6L1XwE-WEzcGFwv@kspp>
 <2025020503-unnamable-canopener-ac71@gregkh>
 <3befc536-3bf8-4a79-9815-3386912069b2@embeddedor.com>
 <44d7feed-173e-4e46-994b-e3136161efc9@kernel.org>
 <8fa0b596-c812-4bc5-bdc1-beb75d7928d3@embeddedor.com>
 <2025020513-arena-tackling-1741@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2025020513-arena-tackling-1741@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tfajC-003dlk-38
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.157]) [45.124.203.140]:54647
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 8
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfHCYjcELJFpl8WrBeFPcc5Ziv3DeARBhNpLHMIENXcqB0zDNLK6zxxP3bKZNLK9MfgelO2uLiNA5stH6f2ybWo7HspzzKXkkLwyxnxkaIvarytcQTHLb
 BEjMvxUReeh7FyTl4gzrzmhcyZb/3qvkrnvUIxjEBApPpa3lTEaK+Q8VJUK9ByfrQ/AmyRmPEex/Z9KWxpAtCZfHkxB4HPLwGMyylSioDZyUtYBNAnjT69l9


> 
>> The problem with this is that then we have to modify a lot of
>> lines from, let's say, instance->used, instance->size, etc...
>> to instance->hdr.used, instance->hdr.size, and so on...
> 
> Great, let's do that and get it right please.

Deal!

> 
>> This code churn is avoided if we use the struct_group() helper.
> 
> It's not "churn" if it is "fix the code to be correct" :)

As long as those warnings are fixed and we harden the kernel, I'm
really okay with whatever maintainers prefer. :)

Thanks!
-Gustavo
