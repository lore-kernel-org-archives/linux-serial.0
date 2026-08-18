Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01754370AC2
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787036340; cv=none; b=EbLZpOhAKEkgfk3N+V+cHDkoU/OnNZO3z+HIe2tjAjVMTRGYt61acoMK6jgrqXo5JJ4wkxzKzI9WhzAGoVjGf3tuig+0M9ldGM1kDGn2i81CUb9DbbxZwVBMrpRESh7ic2qcXs2aSNQz89XP3ERXYY/uyKZvIjC9yKptFjRkPP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787036340; c=relaxed/simple;
	bh=sCppY9oplS9I77Rlb4PwXNSC0fTQ9KiH7dzOsgxLOPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mvOUxOkyqoeJ088NiclyLTOQOoaFd+i1nhCcyDnq8HnWO8vzYHL92OtCox5KCaiWpBkvcASw015j5zWITqooFPl8jrG+Vq+nwqDywV3kbRsgMQOHk6xQZdInz3zkmcROUuYkcLtSQ3lIW5QzyZoEYU35b3oIAi9xgpLHwJOwMhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PB8GkTnk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SjDJkm+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PB8GkTnk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SjDJkm+I"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67I2YP3Q3761843
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sCppY9oplS9I77Rlb4PwXNSC0fTQ9KiH7dzOsgxLOPM=; b=PB8GkTnkBCB6yCrt
	RC7YyWQhkE0lgkdWvNodkm3CkK1wgAmW1ZbNrZg4ffu7O1/rJLj3ljfKfv+8ZirO
	WAEl5zokfsxcpwxslafE44CQdToTlcVGBhhANiC2JbFs+liE82GgTcxMixAp44gE
	1Ux5O4to8TSszY6DtBpDjeSSkI2nh/ssp2iX2uLOOdZ21dHMVwFD4Te/xkzvLSyX
	1xC/iL2y8rohgTqFAX3jjByFsZVWBC09Ea15F0DLkvfhGw2tFcxx9OCYAdA1aZVD
	TcsLs2vfgmyjivkkkDIFL4hYQJ7Mc1tjeXTbSiP6yWK2KTGFSiIjmFnUwPuoAEhs
	G/LJVg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4eqts17t-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-serial@vger.kernel.org>; Tue, 18 Aug 2026 06:58:47 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e6d253330so808550a91.1
        for <linux-serial@vger.kernel.org>; Mon, 17 Aug 2026 23:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787036326; x=1787641126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=sCppY9oplS9I77Rlb4PwXNSC0fTQ9KiH7dzOsgxLOPM=;
        b=SjDJkm+IMM0JgI8LrdKh3kB7Fbdx7aXPFCBNItrx5/UtOeIfNKN790jZB2WKA+hQoz
         8ntAEOHK5QPSSt2fyYrsuO+v3xVLWnKpYR/XHyQjlBGT6KaM/47FbiQw0+hrsDO3qyFa
         cGxUrJGycUfpRjTCq2fab9BOOKe1U0vs1wRlE2rvq8b+kJtNuw+Ib7NEJR4jwzAHVr2y
         snm77sPZOII/PrTPn6LwOMWZJVQa6NSbLZuSOFSfsikMN6q7QoqDSTHdu9eZEcNV9h0Q
         BG4W+MUq4PcvHFE/Ggjz4TWjbao0SkhDdX/2dHCxozjGviHPlCZCqqT3q24K2yFfqVxm
         /xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787036326; x=1787641126;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCppY9oplS9I77Rlb4PwXNSC0fTQ9KiH7dzOsgxLOPM=;
        b=jUP77OeOHYa0RK4t+CELZjCVj6WRe58nJ5Ay8S0WuDfQosi1wvx3Pmg8/uV51Pip/3
         CuHz7o6rLA11fKHwLkaWpFEs1DpmRs0wkKoRr5PHEB13T7r2YidAE2KnMOqt3qz2DPWJ
         ObBTezas6sgXU0qXvu28t+S39+LsFWNqd0myJCgQPBNj8/YprO/itX59vGqDpVGq8XSG
         6buOxUpCeSI6rGwtJtiVSuGivnwugamTJ2byTwy6BrI2WuDNKrwiUHPhV6nSwibqj0Gd
         LPQZgQVKz8suQU5iECdsuOE0D9FlNDzO1k0hpwlkzI+3xp9u5NjYkxIJHL1+S+CTLS3b
         EVIg==
X-Forwarded-Encrypted: i=1; AHgh+Rq54xJtM7QjgLmgHwTv17zSjRJ9LW2X19pESF3QCgTNt5wJp7ovLuK5kR2lIz8EVFlwqTQpAaWe1u3TNQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExjs/dNyDsBG3NfhNNoU30lYpiM0jXvMTCjlDY2A7V18YY5pG
	b6x5Wk/hh97EudexcfKGSFC5cNbUL5TpjzJq+pv7utlXx6R68o4JZXZ/ZeJBzMlCcHsiwLrkZ2R
	KXHevl6soghOXyZPlQcCkOJ8Vi3OxpM3IHH1BgPgDcst9WJvxCtmK0qfSPD29Ev5Vtis=
X-Gm-Gg: AR+sD117CzVL8acLqHcmxmzCKxGfWGgqbdN5D5gakTJp7jp2wDSdX7Q3cl7ScQNZsPH
	en+Ii5dG/YU+Mj0pZilniufpL3RG/l63S4UbmlvVImMD1Asge7L2v9auPlkz8UDcJkcLIU1Q+DQ
	X7TvKE8iuN0VDp9MTqqEo5WVrTi43MLhePl2ICfP8Jx6Hr4+8IoRFvSMLYLAPmjNkxW08NtV4vB
	q5pR0rWFDyW4u9+Ny+XEM8Tas54pYkrwugY2hsFyyrMt5yKgslY2YqLXCjIs+V76xwBKdwIHJMw
	DDOfH4aChk7tsZQnXy0P6vLq9z3kgVB502swwEGWfe8jjY4276J0g5gdoEErpVY4JUB35ILH6xT
	bU3G0ZQFkCytfDu2EUv+Hn3Y=
X-Received: by 2002:a17:90a:c88c:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-39563856439mr2906840a91.2.1787036326269;
        Mon, 17 Aug 2026 23:58:46 -0700 (PDT)
X-Received: by 2002:a17:90a:c88c:b0:38e:c232:9d2c with SMTP id 98e67ed59e1d1-39563856439mr2906803a91.2.1787036325718;
        Mon, 17 Aug 2026 23:58:45 -0700 (PDT)
Received: from [10.239.97.207] ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-394f818030asm5591927a91.3.2026.08.17.23.58.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2026 23:58:45 -0700 (PDT)
Message-ID: <5c0fdf81-950c-427f-8327-a8b4b1ad922f@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 14:58:41 +0800
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] tty: n_tty: use kvzalloc/kvfree for line discipline
 data
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, liulzhao@qti.qualcomm.com,
        cheng.jiang@oss.qualcomm.com, cxin@qti.qualcomm.com
References: <20260817135526.386863-1-xin.chen2@oss.qualcomm.com>
 <2026081706-tricky-slicing-166f@gregkh>
 <2026081747-secret-partly-158a@gregkh>
 <066081a1-e644-4b01-86c5-e5ab908a7754@oss.qualcomm.com>
 <2026081814-sash-sandbag-6e11@gregkh>
From: Xin Chen <xin.chen2@oss.qualcomm.com>
In-Reply-To: <2026081814-sash-sandbag-6e11@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA1MCBTYWx0ZWRfXyxbM737EEFrT
 5ra3kByM961u+7E2BZwqUG0fUM7ZQvsHbnTS89DRpP/kH99PYx820hmLsAo37N3chCTwZUKgEgk
 250SOPQPW8F6GS3Y7NshbD9HDs+rz0o=
X-Proofpoint-ORIG-GUID: KW0BYvzG7NIMOtunNdN8gFiPbvhJLM6r
X-Authority-Analysis: v=2.4 cv=UfFhjqSN c=1 sm=1 tr=0 ts=6a8402a7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=ji0Z8l6HprpF4QN2JWYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: KW0BYvzG7NIMOtunNdN8gFiPbvhJLM6r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA1MCBTYWx0ZWRfX+OlxRhWEYg/V
 1ajH58OMK8aIAgdUaA2T0oqjRZNkC182tKAW5OvK0lsQc0CgSphnAL3Fs3TwAcwlTgmVi4eBb24
 8Iq114PzFx5L3xcK2/VfDbGt03VN4xPXfYzHn02o78rozHTv97Vqk7CvqzOaYmNQabwRJraaMzB
 Kir2+Qb79OuACm0MyN4QD2JMrzo0qqDBQ2YVGBDpfotZ65vKxf+0UMdRABBUSuHt3CFXpE4oF9G
 YQw/g+PzeOiXnT6vNNWjRl8G88nlYuQvFvFHpBd/ZOrI/svAumg8ICuu2NyDvvG+qELPYTckVuf
 PeoPN57DjNPKKDJQs49pANy0wN3qsaYs9Xah/tRiusrQuqGllXqZ5ATTTew+1msF3L4vO0Bv+HL
 DBPPbOSX3owCdGPejnEHcn1F0T3a0r/hOiLbF0ELFTV36qLKr1M0xdu1txA8bFlRtPXm2Kmkc8j
 n0RU4yh0WHh6xUQOL0Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180050

On Tue, Aug 18, 2026, Greg KH wrote:
 > But that's not a problem with the tty layer, if something else happens
 > to "drain" the pool again you can not create a skb.  You are not
 > solving the root problem here.

You are right that this does not prevent every possible order-0
exhaustion. However, the specific and reproducible trigger is
n_tty_open() consuming order-0 pages via vzalloc() immediately before
skb_clone() runs. Eliminating that unnecessary pressure removes the
failure in practice, even if it does not make skb_clone() immune to
all possible memory pressure.

 > But that's not really a change, when was vmalloc() first used?
 > As nothing has changed here, then why is this suddenly showing up now?

ldata was originally allocated with kzalloc() (introduced in commit
70ece7a73159, "TTY: n_tty, add ldisc data to n_tty", 2012).  Commit
ebec3f8f5271 switched it to vmalloc()/vzalloc() in 2018 as a side
effect of fixing an echo buffer race — the allocation change was
incidental, not intentional.  The issue surfaces now because the BT
enable-disable sanity test exercises a back-to-back open pattern that
was not common before serdev-based UART transports became widespread.

 > Again, that sounds like a bluetooth issue, and why can't you just
 > properly handle the skb out of memory issue?

The skb_clone() failure is silent — it returns NULL and the code
continues without error, leaving hdev->req_skb NULL.  By the time
the BT layer observes the problem (a -ETIMEDOUT 10 seconds later),
it is several layers removed from the skb_clone() failure: the
firmware has already replied successfully, hci_req_cmd_complete()
has already run and found req_skb NULL, and the completion callback
was never invoked.  At that point the BT layer has no way to
distinguish a memory failure from a genuine firmware timeout, let
alone recover from it.  And even if the NULL req_skb were detected
and surfaced as an error immediately, there is nothing the BT layer
could do to recover — it cannot reclaim memory or retry the
allocation itself.  The only option would be to wait for the memory
to be reclaimed and retry the entire BT enable sequence from
userspace, which is exactly the kind of fragile error handling we
want to avoid.  The tty change is simpler and correct: ldata was
originally a kzalloc() allocation and there is no reason for it to
use vmalloc-backed pages that interfere with unrelated allocations.

 > No, that did not change the behavior of the tty call here to use a
 > different pool, all it did was change the zeroing out of the buffer
 > allocated.

You are correct, I apologize for the wrong Fixes: tag.  The switch
from kzalloc() to vmalloc() was introduced by commit 20bafb3d23d1
("n_tty: Move buffers into n_tty_data", 2013), which merged the
read_buf and echo_buf (each 4 KB) into n_tty_data, making the
structure too large for kmalloc() at the time.  That is the correct
Fixes: tag.  I will update it in v2:

   Fixes: 20bafb3d23d1 ("n_tty: Move buffers into n_tty_data")

Thanks,
Xin
