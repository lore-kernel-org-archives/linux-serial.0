Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817B94EBAFA
	for <linux-serial@vger.kernel.org>; Thu,  1 Oct 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853927; cv=none; b=AnSpTFDrR3BC1WFzexkMqFihh5t8UW2TtyUCEsbHIBeAKl2prVLCNAQWwH0ER3Fpx+4t+MDzCelW1Yhq0coiDNhFPGOVneR9tRrmfpHIVCpLLnxWKfaDMPpl8GR7y/Hno0rTa5l+ZW621bgeqpK5ndzT5PSwoFPWb8eNOrt4xTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853927; c=relaxed/simple;
	bh=NVPVnzit2/uGIGdxSpxQwWe1ivfTnMdq3apCPukstrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kMX7jgKpqurq2PckJ9xHB6oUai1M3scaU1+uBlIcadYoebbCgd/c+UNQoJNbALK0tqhM9AjujNRlcxG8P+TOn93jFGnjlf0JCj4jEqmKJs8MI+wm1nn3SR9G99eelMZU0HkPGYYcJdx5Tv2+wBg0gnMTpqn8uMhDJzBTw8l7oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX6rLOsa; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX6rLOsa"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so3338988a91.3
        for <linux-serial@vger.kernel.org>; Thu, 01 Oct 2026 04:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790853926; x=1791458726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//gf7bI0yTCYHEFPmzcRJoGvW3+pX9ivwTK6Ov0SZY8=;
        b=SX6rLOsaFSk8F1KPSUBvgfhGozgfAKOehEzBLcaThUGLW+YlZveswcrnyD4tzHlaA7
         LqEjMY9WqiyjyzfFSNIE70h6xATKhclVRWvb7bbxhgvrAGVKZmIoG0TiygMET/T1dl8D
         XNzwenCFP+ZUvclIE/H6PH702lSAVd9ALAMCcV1N66WPb84mmS7kQm0gZpyIyhXD9ZRT
         KA1bX/aO7JAikiw98yxQFuwy6IpxprT7Ou7w4TKfRF5e2XHr+FcBVyyW7d0qqsQ0K9U2
         ItV8ziAb5QjqVqjwhcExaZX4MuvTKdTjbxPlTSLUdJ21Gz+J3uDnehjDZZTp6+4s04G5
         9EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790853926; x=1791458726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=//gf7bI0yTCYHEFPmzcRJoGvW3+pX9ivwTK6Ov0SZY8=;
        b=ULi+Dyb9v4/MdXIfbGX3q1vISI0JjHPnCFLpSRpjFPml23gQhcFTYAr9D698IXeIYf
         bFuTLgDCGRLvlTo3rr7LUnnseqKY5Td2lOvWcOMjngfmkkIwW/TItj2yG5M6WP/hFB/u
         n0fm7M7VMfGy5H+Fea4gVoT2wcLaXwV3E/Q6WtkkiWOwTmK7IyG2Vi8b604boQfc+t4w
         HsnFEb0RofDuvzZvr+pAJIFQvBf1GpvS4sdHrgT0UPIfr8etmiX8QWJ1AptJcH+qWY+W
         CWcDuvS0SgUrEo2afRYP9jrsij7y1L5BmXh4OU1qno0tvEdj0JDHJaepoyUTgAOvJvd4
         tv9Q==
X-Forwarded-Encrypted: i=1; AKwUvBzsEWHqbKQILKB+sXjQ8904votPe836jSPZDHn6HyORVJwjYPXUKH9iT0rSidEJSnsZQ9TNM7+8ivJsN44=@vger.kernel.org
X-Gm-Message-State: AFq9FYI0b0OSmoOxFc6niOULQdiVmhJQNSXaziaV9R6d2+6qTLAuPJKb
	DBfAZqzqgXXVxwr+o0o/Kbi/EcvB+sCbkOKKsz8lKi3smyo42+Sbmrix
X-Gm-Gg: AYBFou0BiTPNSV0J/rHU/AfwiXksOaJO9DU9DBR/yaX5L7KzeLF3qKfKsUjr9DECSPJ
	uDO+z9I9Uh9E8dH9vw1wgBsxg8xuUxkXY0b/mNF5WupA30NwTth3gOAica3pG4qKsC+oT5WCUh3
	Iz0xTex0pYthcHAYA0u2gn5LQFbD1mOKJ9QV0i5zrQh64LkNrFi7b2KR5XNOI+8jhWuOSfg+aQZ
	UKHAu1FyNZfdHZvi15/tFg8QW3LFM856WKWqID4xv6ExKlnU80sXjyN8zAj/+DFvEhppYh1Ts4Z
	N3vyUUc0cKiPgcjbHhsZ57xWLcDNU0ShKiqsAUkoLHxrAKJLcFd2VvWMhEwH2KDQFiuSU723MJz
	Dc+8/hDanT3Qmb/j3I3G/OMIJFUnzyjji4WWaFgEg2ALSxezTAS+TZEp1ve/K3WIvYlPlr9kvOg
	3hSfvJajBtG9gIBGX1TJ8jDhUUClRERjC/jDJ1EI6y2hfmA2She6290FLUQO2PB/vlLb9HJZ05G
	AkBh6rVcuTgXCNgxUcKbL5nIn7+BGWMofg5FzV3o8gsim4q57uTA4yMFefVxrD84tdVTs5MW/kG
	gY+jQdULjtiAPFdLd2y3ca3dDJz9NEhCfpYp56F6q7ZwFT7jVyulaKzoSEE=
X-Received: by 2002:a17:90a:c10f:b0:3a5:a5:8509 with SMTP id 98e67ed59e1d1-3a500a5875fmr1338694a91.24.1790853925603;
        Thu, 01 Oct 2026 04:25:25 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4f44018c1sm4092571a91.8.2026.10.01.04.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 04:25:25 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: name the gregkh/tty tty-next branch
Date: Thu,  1 Oct 2026 19:25:22 +0800
Message-ID: <20261001112522.3822619-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <2026092800-clustered-unlighted-a54a@gregkh>
References: <20260928105940.2186243-1-matthias.goergens@gmail.com> <2026092800-clustered-unlighted-a54a@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg,

> Hint, -linus is for bugfixes "now" and -next is for the next release.
> So why pick just one for this entry?  50% of the chance of getting it
> right?

Fair point: one branch cannot describe a tree with both, so please drop
this one, and sorry for the noise.

The motivation was Sashiko, which used to review against the default
branch of the tree in T:.  Since 28 September it skips a default branch
that mainline already contains and uses linux-next instead, which has
both tty-linus and tty-next.  That makes the patch unnecessary.

Thanks,
Matthias
