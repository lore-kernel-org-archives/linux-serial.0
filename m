Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816363;
	b=rGypdovNTNzDoyQRCV+l7pxlc9co+YTVaDB10w4zA5d2Io/hOcRZY8mJMNybqpqF15gs
	 JPNzgUWKaV+BUrLCDbxDRGytuEbkdWGFnr/22xyCoiStlYo9X39u7L2wN98UbVDMQ04s0
	 lZ9WJjZ7HK4fTuCIkwd0jSIc3js2vjH+Kqq0TCj10cFnwx0keetK17xk+8HUE6GgkuHiR
	 7tC639k9SVqa9t+P8qZT4fo3El7OUfSa+UeZEZ5sFDo4FN8KRd8ILqaYu75T77GU+CAmY
	 qu0Tc6n6AAlX/aCNDndOFQ11kHDlvjG0ok/ctuCJgxYSKOH1DCoffo7H5SohvMDMVzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816363;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kXrmKNMgfkv9/NfRL9xaYF35OpQhtVcHmEfKjoHqu60=;
	b=CEAhAf0lqRFJhj6PJcyXY9yLJVQj2nU0Jac6+JqTbRR5i359KTBVJqCLsyVjbxefBQLQ
	 NdLOr4t0AchhWe14M+jkPJzsBr4isTG7IK4ZgbJNiKYeC3vmRDOv3y8gPBPDrKi1EFa3n
	 fUNApkXhQ97dp1qr9LLTTUI5uJb/7/aIVyJBP3qEh9WAZyP4SU0cBNlATEdTB7RDhjnPx
	 7sqHdpz2c+IBA976eqRZCgJVehcBUAf0z1NARzTd/FLWz2LLPuYukKgMFAlXsl8dRb/GY
	 bDf2DZmNAEJCIW66r/hdhpFSJAaSMlPlZ2rT7EF/dlKEVw9b3dwfjIY6O/ykEnsuieg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HEZzY2AA;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0F9606A31B;
	Wed,  4 Nov 2026 18:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F0F9606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HEZzY2AA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=kXrmKNMgfkv9/NfRL9xaYF35OpQhtVcHmEfKjoHqu60=; b=HEZzY2AAmeUhwQY6vCxrT/Q6G3
	koXAoUDJ645pdApxz+Ysy0R4ZPw1yDog/wRl+IiEnUuyb0tD/WCM6EKk5MxK+R4hJSKWVteLMCs+w
	AKBim6ilQCi1jKzdECK9MQdj9Q0WwiMmX0tvX+Xs8fzp2Z4grSbRJtZGE5bhfdEOHORJ9+hQzVrPE
	e0nlZRhB8EalPNf6ush2I7uIWEtj2h+Kxj7uyr7uqWcyl9h/lByVcMx+4wftJfdtl4PbnIQqZJ5Ss
	2T0sfu2O8MnwflRyW6iWvmwAyKVsNewuZySOT7hH4/xROFs4uObAifGglOq7Nbj27pIqZJfW4zFYS
	TsITpLiA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOfZw-00000006NT3-3Hnn;
	Wed, 04 Nov 2026 18:19:20 +0000
Message-ID: <ac076eaf-3221-4eae-93c4-9a4abe8743e1@infradead.org>
Date: Wed, 4 Nov 2026 10:19:20 -0800
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
Subject: Re: [PATCH] vt: modify a constant prefix that looks like a ReST
 target
To: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-serial@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Helge Deller <deller@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, linux-doc@vger.kernel.org
References: <20261103203929.2916563-1-rdunlap@infradead.org>
 <c8648fe5-7eda-4e20-80cf-7ec2e510e677@kernel.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <c8648fe5-7eda-4e20-80cf-7ec2e510e677@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/3/26 11:17 PM, Jiri Slaby wrote:
> On 03. 11. 26, 21:39, Randy Dunlap wrote:
>> Use CUR_* (could also be something like CUR_x) instead of just "CUR_"
>> because the ending '_' indicates a documentation target name, so
>> unconfuse the name.
>>
>> Prevents these warnings:
>>
>> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:275: ERROR: Unknown target name: "cur". [docutils]
>> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:317: ERROR: Unknown target name: "cur". [docutils]
>> Documentation/driver-api/tty/console:36: drivers/tty/vt/vt.c:353: ERROR: Unknown target name: "cur". [docutils]
>>
>> Fixes: 1438d00569c4 ("vt: Add cursor-size helpers")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jiri Slaby <jirislaby@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Cc: linux-serial@vger.kernel.org
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-doc@vger.kernel.org
>>
>>   drivers/tty/vt/vt.c |    6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> --- linux-next-20261102.orig/drivers/tty/vt/vt.c
>> +++ linux-next-20261102/drivers/tty/vt/vt.c
>> @@ -273,7 +273,7 @@ EXPORT_SYMBOL_GPL(vc_font_size);
>>    * vc_cursor_valid_size - Computes a valid cursor size from the given value
>>    * @cursor_size: The size constant of cursor pattern
>>    *
>> - * The argument given in @cursor_size is one of the CUR_ constants, as stored
>> + * The argument given in @cursor_size is one of the CUR_* constants, as stored
> 
> Should it be also prefixed by %?
Sure, that makes the generated output look better IMO.
I'll send v2.
Thanks.
-- 
~Randy

