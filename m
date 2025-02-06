Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375C1FCCE4
	for <linux-serial@vger.kernel.org>; Thu,  6 Feb 2025 09:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833812; cv=none; b=ssVo+z1y0qSUdLI5Tq6Ra6w9bYZXf2sISFmRURuCmuEcJuEKRrfnjODK9cDO/+OH6r76Cw9zH6yC0CvwJZVBjZZZL3aw6oQNvai2kyxBaOw9XFAmjzLnT/VU10n2tAYzpNt7CeES1KPgaFYwilw0j+eGFarTLoCmMYX1JFQ0rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833812; c=relaxed/simple;
	bh=Eb2tRU6/YVjaUsYLNRs1tRCxlDHWdhAUNvBHCA2Bqew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXwKSj6xjU+bzK8KC8qUG2k5mcCje3hZaEPoMRKLz9BA60YyKxMlkfxnUT/A0jMJEmRHQcFu6RUKNolG5AGX7m4lyn3kXOKpxgzKdbPLS3yowhjMp1xnd48NVn4CH96/Q1gcazO0d0U/Ghv0RJ70n4WfW0xl17HKsUsxnpt9U18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=fMOAm8hb; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="fMOAm8hb"
Received: from eig-obgw-5007a.ext.cloudfilter.net ([10.0.29.141])
	by cmsmtp with ESMTPS
	id fr1mtFrnB1T3hfy6btNhVv; Thu, 06 Feb 2025 09:23:29 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id fy6atz0WyWkhGfy6at9Pwz; Thu, 06 Feb 2025 09:23:28 +0000
X-Authority-Analysis: v=2.4 cv=WL15XGsR c=1 sm=1 tr=0 ts=67a47f90
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=6Vi/Wpy7sgpXGMLew8oZcg==:17
 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=7T7KSl7uo7wA:10
 a=PX_z9cZZlryqIJpxFbEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PbrGCb5a5pQD3TxB7+lFg4Sxj2+E+oZPhiQNGM0TNkQ=; b=fMOAm8hb8idy4TF6zXMXwn0L+G
	tZRKMARV6rG6Fpau2CG0FQGrNTdzygIgchyof9+g4JAIkzkkKPBxQHLdZoD6JTPNU2WsSdcCFFhig
	eGdp5faY8vo8rMnf5DrQVNgwTIsUM3yz/fCFJ2X4g+W+LiNHYf6laKCANxAhY/HFVq8+x6HApgxNE
	mNhgRHoe9Xu38SjPtXW12tdKvjq+q6m+DS9MQUO6ZdfMTcGbZpK+qeaxX1Gn9m55dgBvbObgJJkv7
	mqxwm6YP5ZC0w1FPtnbkZoOFYKNNf95ei5HLXpWuz730wxJTvtACKjZcN4U6Sz46r/I8efUN/O/mF
	nR8qDtfg==;
Received: from [45.124.203.140] (port=54891 helo=[192.168.0.152])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tfy6Z-000xca-0C;
	Thu, 06 Feb 2025 03:23:28 -0600
Message-ID: <37d755b9-5d08-4b8f-a178-312d22651803@embeddedor.com>
Date: Thu, 6 Feb 2025 19:53:12 +1030
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] tty: tty_buffer: Avoid hundreds of
 -Wflex-array-member-not-at-end warnings
To: Jiri Slaby <jirislaby@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z6QvAZxiQusdaDkH@kspp>
 <daea13b0-137c-4ab5-8388-1d46919b8609@kernel.org>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <daea13b0-137c-4ab5-8388-1d46919b8609@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 45.124.203.140
X-Source-L: No
X-Exim-ID: 1tfy6Z-000xca-0C
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.152]) [45.124.203.140]:54891
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfP0E5aZ19UCRbKBpvOljc/Q2O0AtvqxpII5ILoV/Ku71YXK467CufOikjVmS+YF+I6n7bHZVQyYLqqWlc5LhUCjXOz2cd0IZTP+biSUu5mFsqkyTsxTS
 +o5P4AfFtZbldKTR48nWDvz3lulCHcrqLA8iFVC02isxILONaEWWRx8S5OLUstMBLRwWrrpqqFBZi7B6/YYzF91HHfpMYUTJDDjTIDt1eZvJakbbzUhn+HyG


> 
>> @@ -576,11 +579,14 @@ int tty_insert_flip_string_and_push_buffer(struct tty_port *port,
>>   void tty_buffer_init(struct tty_port *port)
>>   {
>>       struct tty_bufhead *buf = &port->buf;
>> +    struct tty_buffer *buf_sentinel;
>> +
>> +    buf_sentinel = container_of(&buf->sentinel, struct tty_buffer, hdr);
> 
> Bah, so this is ugly and even dangerous if someone adds a member to tty_buffer outside _hdr.

Precisely. :) This is one (more) of the reasons why of the struct_group()/static_assert()
proposed changes.

-Gustavo
