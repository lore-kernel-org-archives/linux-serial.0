Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.136
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793128692;
	b=h3m3huA6eNRY1zxFT+7ovfvsilkm9c6XBasjYpZyWkMYF8DUM/p8FDTMNFkf+in6mSg9
	 qJXgNbTnMHyz0wIvkKAlJVk2gbHXlRcLagGSpC996eN1m2vidl5RX2sZgBRitl+ujvQtv
	 3swad2UqDywBm7hbT48loIj93HU2iftgf6fPZTFGKgmT6JZYM3x39A4gCT7WwsyqHRRDK
	 gfD4Nd7YG7T5V1wYUImcm0xEdldedrkRmKsX79MTVO5vONMfXy0wBQ4x6hAdWWHt28LZf
	 nYJpWeA8Qxn1ZVKsJB2MuAMqnzQbK9GixObTfCYGkl6fpe1fK0uLJsk8Evxbovx5g/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793128692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=w6DfYLs1UPv+m99YHcAmjcczztFRxn51JTNHeUhcQnI=;
	b=gHQY3LCCn0LI+Fu8/0RNg5C7ZJ6TX2rD8ODOFHXh+8g5cLQiibCT8itC8+L3DK79rZAK
	 YLSPUcOU6KqLHINqv08T/SMRUQv+Ck4Mse82SHlm0Yq9q+c8ONkP7IAk34YOmWc79J0lU
	 QOjiGI3FQWHTt4glYGKeUvNfzB8RROEbfuparZcc3WvHXnmUYXr+lcV1d46g/7pBBMBRQ
	 hHF8WIApUvlJjs28i8gnHnlO0EaxOqn/nPtUR1w3IkjRp1a0BEqm7kHzHaZrdkZ1cnQUZ
	 YUxBv3PD+yujTPrpC9rpEPudDDgzZOlT3TfC6pxylUz9eunNbz2Fb55DG/JZ+K3jBMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=baLZvn2f;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C540606A31A
	for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 19:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C540606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=baLZvn2f
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-843c8bbfbc4so57886a34.1
        for <linux-serial@vger.kernel.org>; Tue, 27 Oct 2026 12:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793128691; cv=none;
        d=google.com; s=arc-20260327;
        b=kFh2AdjjNvMbTrDX1BNFbGNOnLGDI+JbDa+2yXouRVMox6A5mLopVig9d3LcAbn6qS
         R9iZvT+hdxsfCBJQfBFdGQEUmnQ64yrLSo1CBKA53xUK/zmgxYHY27HNkDs7TWPQ/nsb
         gV7HN+niQX0/ly9lEiXlkd7MTeU8EYLiM+9XxW2r66h7G8KZEDemnl/PJ6mI+8Ij4S8A
         iLcvkdjkXJ01l1Ycgdqo1tWWndMZVJJ3jJrqoCavAFfN3sZ2LUYiFbZwhkpdSvwfb/Of
         9QSQ+2r1UiWw4KhqRqqHWPbKRi6iY/nD7LKOEh5ynNM8M750naEIZ/Zbcmj/ttjI2gz+
         pl1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=w6DfYLs1UPv+m99YHcAmjcczztFRxn51JTNHeUhcQnI=;
        fh=tb4RWebslkagBd/oPyQT0jpei7N+v3V9o84BFm6nUaY=;
        b=J6X9ULYAEO4ZtSlv3UlvFjE2AwaAVv8mNlZS3IGetvyC4zycpzX1Ev0L0BD5GipMic
         BVDZOVN6cAXfHk+Vp5p79ZZ+z/pBPHFzek7w24ETAUT7r3ztx9uI0dWMR8KHQhPGwcvS
         gAMF53X1UAMiuxqKnYn2tijrA/J2lnpIdvixeU5GQG4yzQjmM75wdV8k6UAR27oyPg50
         Gt5v30dyc19bZLWufv34UA+iwaeGcKrrYPM9m7HlA4H2LOyQEBUhdOFGH5wwg8DV6N+a
         LRdgAkRA0oLyAXxNf17FH8ub5jBbFkiLm5gzKDs9EXV0soIsvN/3P9Nq078eKIlMK6Ad
         ijTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793128691; x=1793733491; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w6DfYLs1UPv+m99YHcAmjcczztFRxn51JTNHeUhcQnI=;
        b=baLZvn2fpvO3qD3gDdl72ehJsNqPbkEh4qsrJhy4LfxIWvzPobzyQIq0z9hdZiVfkF
         4WlZnT3NFrz3P3SQucv+hiLyjndF9TZHjJwNN0TYcDoDjvrxb2DZ9yz5W3EouncJGRit
         kIf18mBMkKlaiwM9CfI0+2xMAfOv3mq7oZwOJebua9lL3JgOQ2t+iH7AOSrAemwTavQ1
         VSkaDvByApNQ0gcC5pLMzZ6rhs+0LeVln0l3LTwbq2Fo8LObI9FVyh9YwcCbLANAum+8
         1mzUZBFUJ774JewRyHDsWOiKQomHi/KREbtqSZy3sGVISfX8mxre8Budizbflh0PP8KT
         mS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793128691; x=1793733491;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=w6DfYLs1UPv+m99YHcAmjcczztFRxn51JTNHeUhcQnI=;
        b=tEkekqOMAzpTi6ihoJG6y6A+JabZw5/hxfkrS8Vlr6AQbuGmolcUbsaxXkGJ+FU6On
         4bkHUsZxusQ5bituif1V85ezhezFvo581o4DcK2RZrvFtNThovycMjKNZAMwUHYF34wK
         dJqLlqzhOP8wy1W01ywE2wFb+vV/HKhycyOy9KBro/c6hsBnvlsLFLao76ZbiywHwBVh
         NTzHVC3ojZEwAz4dvDv62e3t3ltts2gr5CctcnVjQMD+XeLG+LHuc1C4uON+9Eo6Ub9a
         8LbQhP5GLc7+zIUTSZQ7+oG9bl3N6a0G5yKZToI4tc7g0q7onFdQYcNJTHEcCl18OPCp
         2DIw==
X-Gm-Message-State: AFq9FYI7HxwOjRrtsL7oXBkfmKYIwEoOWmH7FbUxSmG8mqg9K+HbmJmS
	pbpqEGgisF3ylcjRNKY1ZUyL1l5BvKwmFkeRs7TnKVtbfU2dWy3KmJWUg9hYiBza1xk4yckXScS
	HkIZa6Z3SmIJe6+F6AMNYllQOju/IMPc=
X-Gm-Gg: AYBFou1g4f0qLKbjt3JX2+dPrQO8Vn1UisMLpf0M8943FVZjMk9+USAZ2VN/eRCFBuy
	nQrRnlV0cnAxoN0mMlqd/a6zzFvsVp4QFfro9/aKWE16J0IsSYeL3vwQK6tcquzyZHqGYJDAp+x
	c11vZcgGiGSXoMzfdSpyFqVuHlgwNc9T90CXN0NFXFXdrBSIcDjFyXXpkS5QVUZhmHfMwMcx99/
	l9j6DEyBu4eEYMQvVNp3WDJTkFToe80gd4iihgvn5KOpcF6x6UE+XrY5ZpRwTbtFFgElLsZ/JQj
	FMTj9FVcKUtixUbUsG/8aMm0x1QFUscG9Z4y4cjbx57//B7E63dJotnjRH0Mqt+apdKQJIZgVLA
	y4XofxzHSwUpR+g0bft1tTLrDzqr5B3n6y+J8ATiV2kRCW1vSp/bAX36X1Vhxdi4n3Qy/Ynpz
X-Received: by 2002:a05:6808:151e:b0:508:c44a:63f4 with SMTP id
 5614622812f47-56382684c39mr91413b6e.35.1793128690829; Tue, 27 Oct 2026
 12:18:10 -0700 (PDT)
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082236.56724-1-dennylin0707@gmail.com>
In-Reply-To: <20261027082236.56724-1-dennylin0707@gmail.com>
From: Hungyu Lin <dennylin0707@gmail.com>
Date: Tue, 27 Oct 2026 12:17:59 -0700
X-Gm-Features: AclHuK972QVjxsr7ZPA1BMTiS7Y8E-jpvVDMCciChlRAHi-jepLN9cibkbn5rwA
Message-ID: <CAGEkeHfWcuoCk3zvnpaSXKDduVB1UWAJtRGV-KjJmt7ws2gbBw@mail.gmail.com>
Subject: Re: [PATCH v2] tty: discard flip-buffer input for TCSAFLUSH
To: gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

> I'm still investigating and don't have a replacement ready.

Fixing this properly involves more changes than I expected, so I won't
be pursuing it further. Please disregard both v1 and v2.

Thanks,
Hungyu
