Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355AD2147E6
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 08:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738742616; cv=none; b=PmShbjZ9pDI+QeB1Oomin7r79Z5r33eTRc4Tyb4D3pibJT0D85CbzfPJSVjU2GkMFQkPX6Kk/5Dxtagxk1nlGoJNJ7i8MbzvoBlIlHK3gXsw8+bglPazz1mlh9AiqrKlFul9ZxbgnhZs0HxUlZujWjhDwCK6LpcdIUwAfwXx1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738742616; c=relaxed/simple;
	bh=bM1AMGFgSxnSUkURdR4Bphlft7QT4szOtlLsaC89ENc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrppS90PpIIBd4m/dFmZzIw5cBJok/UiuO0VAaT9KEWOdtehPv3RHe3YxNdegGRHecZWTQJXF1d0ip2tgQDgl/xyT86JpfWmsB6t9/kEmuujAiGGi0epixAQmKPImg7IZ033tATUsziHWpPCY48mfSoyINrVU7yeTQuP7rZ0TLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=U3LVtWPw; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="U3LVtWPw"
Received: from eig-obgw-6001a.ext.cloudfilter.net ([10.0.30.140])
	by cmsmtp with ESMTPS
	id fZzTtx2YAMETlfaNctLz33; Wed, 05 Feb 2025 08:03:28 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id faNatn6Kl2Zy0faNatuKyU; Wed, 05 Feb 2025 08:03:26 +0000
X-Authority-Analysis: v=2.4 cv=Q4EZ4J2a c=1 sm=1 tr=0 ts=67a31b4e
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=zz_zJ6RWCxbdX4ffNioA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lsRr4UdRKrRNvI6GSPNKhFnKrwVsAtCdmVyB+38feJ0=; b=U3LVtWPwFCjayfb2LlNK6YK5K0
	ComdfgQ6RZJrz0+lMpzWnl8jeuXv+QcF9N8FMnViDUXBqdAz5zwXWjSqmbLQ+lI40+8IEgcB1OgZf
	T1tc+xuhLmROV+43nC8vynqcVvxu0k4ImypuBvjnEZCfFBpRPxHgaCUHSkJZyaAYccHW9gV0c5q07
	GntWedyLF+qFZwjXQbM7nCJfIhiG5pkGs9s5wCvOUpsPPFc7DNr4z7S9a2VeFLH1AUoqXazUa2OwC
	/ivaCdkuXVMgUpF5AVVWovZF+Pq26F6aYE6nKadgUG6aMGxFLikyP/+/00PqCs3I2D/I2tAImHDAi
	6TycVqIw==;
Received: from [45.124.203.140] (port=54831 helo=[192.168.0.157])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tfaNZ-0036yF-2N;
	Wed, 05 Feb 2025 02:03:26 -0600
Message-ID: <8fa0b596-c812-4bc5-bdc1-beb75d7928d3@embeddedor.com>
Date: Wed, 5 Feb 2025 18:33:13 +1030
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z6L1XwE-WEzcGFwv@kspp>
 <2025020503-unnamable-canopener-ac71@gregkh>
 <3befc536-3bf8-4a79-9815-3386912069b2@embeddedor.com>
 <44d7feed-173e-4e46-994b-e3136161efc9@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <44d7feed-173e-4e46-994b-e3136161efc9@kernel.org>
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
X-Exim-ID: 1tfaNZ-0036yF-2N
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.157]) [45.124.203.140]:54831
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfC/9gTPcCZ6ixkWFO3JYqXSis81Gq+eotYCV6PwnTaNCAGa8dVHEZiSXH943lFKuitvRvUvoDzl4VhRp3ldasJbpAZOhIND6dRRteCCNu+X0QtIyV1qU
 bRahQF2tsm1WYkOqmgwqyVLyFSbduJNbxO7PWqrD/ckHyyVvxnPvEniouaK+t7yWk96D4EhqD8TqVTqTUETLX6f/pobVqaFx1XtEcjwjYn/0rqnpDZLLtSCN



On 05/02/25 17:29, Jiri Slaby wrote:
> On 05. 02. 25, 7:49, Gustavo A. R. Silva wrote:
>> If the above changes are better for you then I'll send a new patch. :)
> 
> No, you are supposed to switch tty_buffer to tty_buffer_hdr too.

Do you mean something like the following:

  struct tty_buffer {
-       union {
-               struct tty_buffer *next;
-               struct llist_node free;
-       };
-       unsigned int used;
-       unsigned int size;
-       unsigned int commit;
-       unsigned int lookahead;         /* Lazy update on recv, can become less than "read" */
-       unsigned int read;
-       bool flags;
+       struct tty_buffer_hdr hdr;
         /* Data points here */
         u8 data[] __aligned(sizeof(unsigned long));
  };

+struct tty_buffer_hdr {
+        union {
+                struct tty_buffer *next;
+                struct llist_node free;
+        };
+        unsigned int used;
+        unsigned int size;
+        unsigned int commit;
+        unsigned int lookahead; /* Lazy update on recv, can become less than "read" */
+        unsigned int read;
+        bool flags;
+};
+


The problem with this is that then we have to modify a lot of
lines from, let's say, instance->used, instance->size, etc...
to instance->hdr.used, instance->hdr.size, and so on...

This code churn is avoided if we use the struct_group() helper.

However, I'm okay with whatever you guys prefer, just let me
know.

Thanks
-Gustavo
