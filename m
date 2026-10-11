Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC9A4582FC
	for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791730865; cv=none; b=JZzNd24qwGpbfkzDt8qqeEMZB3UgTmWW1qhGXqRdBI7ccBbeqKfn20Yviim1SFMj0tNTVS2pIxDDWdOIn4iYRlj2I16Zv+EqMkt4uMeZd6tJJF8lHD1FDJKK3Cf9QZaiyVPsvW1T7rCTZltlw0L+vLadd9gqUqMoEadFop+yX4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791730865; c=relaxed/simple;
	bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIiOWqN8JdOMvbI2PgTEzyTkyh17KHbVuMvvuzQ1to2PP5ZFnfemzuI5QpTJTFiyDEMNM3GsV0rWCqBLFZI5iw74v7ENCs5pNXpBt8xPAw08eSY7aHRpYTbHtQC94m89ePyD8VEKrcMlTkF85FfC5Qn+DTLpkKyVFaiVnQwaIT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=K3yaYUbH; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b="K3yaYUbH"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5352a876d5aso16315061cf.1
        for <linux-serial@vger.kernel.org>; Sun, 11 Oct 2026 08:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1791730863; x=1792335663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
        b=K3yaYUbHjm6lUfle8ozp5hAnh1D7J18WP2WSk+mR7VIzOdsCnJtUgSoUAk3uWPIQKQ
         Od+kDZolqAhfQGkJ7bdYEfFb0hiHfJNlGvzxL20Nck85LpccN1SMpMruwvYJKLIvGoqA
         wBYNBmKMdBk3JtOPosBPOI5ys2SFecTlmIbYie9DTr4cx1tx23K0wYgOARb+xDcbR2cX
         8donjyZJ6bwzX8djYva2lRAyuQ3O/yoJaRWe7O3999BDnzyhGroL8fgUb3yCR7pOuj16
         Ev7LWvx9nBoanYH7IMqw2Ht8syzkfjPxKwH6JBDpcnGjj0f33dRbSafla62iBLfbxjgg
         fI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791730863; x=1792335663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OCSru/Lbt4T5vhKJNlhummD6FRhpLVQSxbJ9kBbnCc=;
        b=b+PRDZqlKQYy8dqxlEuHmHqh33IW0QPBb6agqX6BW18vuGgPF705k9Q5Xbxv0JUlf4
         dZgo6d85qRb5p3tFr5BmbOptpfZaKANmY9z2PcPurYHvLpKHzQV0siV+J605PQa97ir9
         pZT4emdtnrroJgsFSQWOEsjdBmzvgmJdv/dkfCDh4lRehYb4qnSJ2enovxqOjZIzyVbK
         weSTve6+1wNK0HKhWdRh2pUaBN1DbuchI7AL+ScBFYCPAwbxtz4lGapyTZTXt5GgCLGf
         zbFmxZgC1loi6giA2Yy1ky63+knvIc9wBQHu9CbFrHtN9blsOFha977Qah/acgeRVxGF
         QBfg==
X-Forwarded-Encrypted: i=1; AKwUvBykYEIzTNi8bOM84eo4VVzN25X3U7HeJ0w4XJu2Wuhfomgp1C1jrlI2QEbe7tDq/4fLNRPu6gmGoJggLL8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJt+oktsOleRzV3iBVVivAyfkj7Xtcz+MibF/D8BxvPBhWLRciM
	vPKQla7y+F1gfDy4AR7hNtbZxq5OEhviTFcru3eX2FTWcdnX/cGDMGTr8eepzsK5hQ==
X-Gm-Gg: AYBFou1Yyq+xpdTlFKbHBonfxOGwFl7MkILCfGiZ+29263w2acmhNFsqSQs9GyzF/W9
	JrXFWraLBvhupMlVcs977S8OZ/2aIUUBC2WN+Z/HrR4EJnldUHAD0n2kTUSHyVfNNjb3NA40iax
	pHSusLh3JrBJXherKiVu7Zg+IFnDHcNIN8HnRSID1EfE0JVX09lOTsUKMTbMblXPgwO+4tJQY5J
	u2QQXm7MhdSUVvffMYsSdnMk45NjFMsslYDqyGitaW8ltqyeXoOsJdaz0GV5+3SBk8KCl5e64mi
	aW1ILcdVGPa0IfBk81Mtks/IZ89y6HyEaTATwQOq4CtmdyhRE2XbDeTnd58CMmBbPhYwE8rsAV0
	I2MG8GmTLmMAaTHnSqG6XSXBG+waV0z2BK2h+vGNKEfbnIHVxU7c8naOaqNRNVHUWR1NQucgRNp
	FSMPvwgI1j7Lvq5DVrGOuoQ/t4v1no/m2/KOtgSxPSPSXTmYXEswUyRhEm+tuUSXsg5UBgwRkr7
	jJC3MZNglPvDW3+ogPaew==
X-Received: by 2002:a05:622a:1909:b0:535:2db3:c05f with SMTP id d75a77b69052e-5359fdeb97dmr128255601cf.61.1791730862788;
        Sun, 11 Oct 2026 08:01:02 -0700 (PDT)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b76eea2sm60407431cf.18.2026.10.11.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 08:01:01 -0700 (PDT)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] serial: core: fix TIOCSSERIAL and TIOCSERCONFIG on uninitialised ports
Date: Sun, 11 Oct 2026 11:00:38 -0400
Message-ID: <20261011150038.1466236-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ast-JWIDzyly6WuI@hovoldconsulting.com>
References: <ast-JWIDzyly6WuI@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Johan,

Thanks for testing and reviewing the patch.

> How did you find it by the way? I assume you are not using an ISA serial
> card?

I found it by comparing kernel behavior across different versions. I was
testing in QEMU with the 8250 driver, without a physical ISA serial card.

Hengyu
