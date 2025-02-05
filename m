Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6A2135A9
	for <linux-serial@vger.kernel.org>; Wed,  5 Feb 2025 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738738201; cv=none; b=Iz8nb22gl9YZY2GrAPev34woFPJTDdfvt5H0SGlRs846K72tsdX+nVrCzHlm4sncL6hVWr7OU4U6aF5PxvEYJdkJWTDxU4vTWdR5Ttpd4EVPQ2Z/67n3SbZJlUIOnotsTvOhhZ86W8X62i1gCQMGDEu4FCEn/XxLCo3seNUseOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738738201; c=relaxed/simple;
	bh=67B6hUVPBinQpmk08ICFMsGn9WJVZDS8otyBuiKV2zY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O9ys/AR4jQpUSVMDGAlzWHiZZi2suZwABNd5mM0J0pVCv89yDvLngNxGPmR7Z6+KF+cC/ZekT73T1FssWatXriUpxDhIqseZK/jZewn9z2lcO9MJTZCRQMqugGBW6GF70FtCx+BRj2s3J8GLcRd7+UvHCuj4IPDAM/KS2DPu3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=pbuzsQjU; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="pbuzsQjU"
Received: from eig-obgw-6002a.ext.cloudfilter.net ([10.0.30.222])
	by cmsmtp with ESMTPS
	id fUhytlkkgf1UXfZEPtkhcM; Wed, 05 Feb 2025 06:49:53 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fZENtoPpzPWBNfZENtOFw8; Wed, 05 Feb 2025 06:49:51 +0000
X-Authority-Analysis: v=2.4 cv=A/+nPLWG c=1 sm=1 tr=0 ts=67a30a0f
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=VVuO3mv09ikYbiyoNyIA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NztLlA3ZKfM2+rrwiVjTKlOzZwixvtKQZXFnqSNM7j8=; b=pbuzsQjUorXX446SHUDu80/qFT
	rRM7awTS7Ynzh1gwe+UVba+UQIzUffzgd7wUw4vAxrRsYeLrEwou2atagsz4Zz2bVwWeBaxOT7pJt
	eGVY668FFkkYoIDpyE7orkLGDQ+kRAVE2TJVKapWSH6aQrGunZ+2ZTR2Zt1rU9N2rzyH0BJrzRMOj
	xnFt1kYTdNzxRuj5+wXyW/pyPrDGxTCBlI4zwjzL0rLAAPG/2H7w0B9kOqgVRU2n0/I0TgVTfMWtf
	K2EbZh4T2HbANCuzD7JyPmYeD0YnfqDJg+i6DDf86GDwk3maFq4jB7JuBYwvMnNxNynLnymKAPllV
	euAS+oYg==;
Received: from [45.124.203.140] (port=54695 helo=[192.168.0.157])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tfZEM-001jSC-2u;
	Wed, 05 Feb 2025 00:49:51 -0600
Message-ID: <3befc536-3bf8-4a79-9815-3386912069b2@embeddedor.com>
Date: Wed, 5 Feb 2025 17:19:35 +1030
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-hardening@vger.kernel.org
References: <Z6L1XwE-WEzcGFwv@kspp>
 <2025020503-unnamable-canopener-ac71@gregkh>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <2025020503-unnamable-canopener-ac71@gregkh>
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
X-Exim-ID: 1tfZEM-001jSC-2u
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.157]) [45.124.203.140]:54695
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFst617yp/XyBhmjrb2B1pISGKxKDs/781vX9bAHjcyp+CUOxNizv6XPILeVD7P70nI7Ok6azXfuhue/TGoxt9zE7YbnT4e42wNqy4G1lr0zdIWr/Hpm
 ZCh0YJr6YMW+Vyb/JicHYFKv2DUBxfqQI30CWg1ZWIGhLXQFeFqdeUiDe0pxEi0wu65fqoug2HRIRrHYJAGro1OIjZN12WzIGC98J8Iol+1ZfPAuUrQdhP3D



On 05/02/25 16:06, Greg Kroah-Hartman wrote:
> On Wed, Feb 05, 2025 at 03:51:35PM +1030, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of other structs, we use the `struct_group_tagged()` helper
>> to create a new tagged `struct tty_buffer_hdr`. This structure
>> groups together all the members of the flexible `struct tty_buffer`
>> except the flexible array.
>>
>> As a result, the array is effectively separated from the rest of the
>> members without modifying the memory layout of the flexible structure.
>> We then change the type of the middle struct member currently causing
>> trouble from `struct tty_buffer` to `struct tty_buffer_hdr`.
>>
>> We also want to ensure that when new members need to be added to the
>> flexible structure, they are always included within the newly created
>> tagged struct. For this, we use `static_assert()`. This ensures that the
>> memory layout for both the flexible structure and the new tagged struct
>> is the same after any changes.
>>
>> This approach avoids having to implement `struct tty_buffer_hdr` as a
>> completely separate structure, thus preventing having to maintain two
>> independent but basically identical structures, closing the door to
>> potential bugs in the future.
> 
> Why not just have a separate structure and embed that in the places it
> is used?  No duplication should be needed or am I missing something?

The duplication of members in struct tty_buffer (all of them except the
flexible array) and the new separate struct looks like this:

diff --git a/include/linux/tty_buffer.h b/include/linux/tty_buffer.h
index 31125e3be3c5..6f47a6ea5a05 100644
--- a/include/linux/tty_buffer.h
+++ b/include/linux/tty_buffer.h
@@ -22,6 +22,19 @@ struct tty_buffer {
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
+        unsigned int lookahead;         /* Lazy update on recv, can become less than "read" */
+        unsigned int read;
+        bool flags;
+};
+
  static inline u8 *char_buf_ptr(struct tty_buffer *b, unsigned int ofs)
  {
         return b->data + ofs;
@@ -37,7 +50,7 @@ struct tty_bufhead {
         struct work_struct work;
         struct mutex       lock;
         atomic_t           priority;
-       struct tty_buffer sentinel;
+       struct tty_buffer_hdr sentinel;
         struct llist_head free;         /* Free queue head */
         atomic_t           mem_used;    /* In-use buffers excluding free list */
         int                mem_limit;

 > Did you change anything in this structure?  By reformatting it, it's
 > hard to tell what happened, so please don't do that :(

Yes - the above change is the reason why I reformatted the whole thing.

> 
> I don't mind that, it would make this all much simpler and more obvious
> over time, and the tty layer needs all the "simplification" it can get
> :)

If the above changes are better for you then I'll send a new patch. :)

Thanks
-Gustavo
