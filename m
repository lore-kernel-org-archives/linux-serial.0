Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54273B4E8F
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 08:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091838; cv=none; b=jYLzQSp2xzpeyAmubaXSRoYmi+5myT2CjqyhTAwg8w7uvuiIB1iLFIMOf72UFpGH+01xMqShgtbyTjNLZIlsAJqIImeE5BfRO+lJ8TGyzyWSLMHTbzGMOmeSR63kSB+08uPzTz//XmnJ9tGS5YuENkcLJORfU5R758wdpffPtRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091838; c=relaxed/simple;
	bh=P/41CvtTcGae/equIvztsQBGuXVGaJoauUSj4lEXoMo=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QnIlnLYlMGuVj3JHLSpTmwXVsBxm8mioS/VxbnI3tq2hZ9UIdp2DBplOJNl0E33nN5yPX9Kz+iXugikULNnuyDxHLZaG4KFYizP/NmR2cz3NYwJUN2XDZAy0tHuEZ/8tw0Ypq/Twlh01OUWu+ElLoD55/Fn4aQmgZiVZUMqh2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Q+D0k7jQ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Q+D0k7jQ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49553515a8bso46194335e9.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 01:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091835; x=1786696635; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jEYndMHB+hzzoGm3/jN5rHUQhOLtVYWufPY6GQuzOfA=;
        b=Q+D0k7jQHcEeeIp+sWm9MsSfOccnLMzkyZKamOcrWj69yNNxV3T9DpIySVVDXjkXud
         IF6zG58bJnLuUsto/EETBz7StJz661s2IGN43p+bj8L5mp4ZE1pbQzNWlqOGxNHHpcmO
         FORz9BnuiZU1yLqjE/TDkJsUBrcE8EiWWl3S3iLM0CbJ4qxgZ1pbCfHWnyYr2tnDi+JL
         2fEW5yNzgENhBRcndN1HhrgkTRiOzKxfBHNvB+OTrIm6My4ZbTaKhdkI5gbwW6Uu7fOr
         vNzCol2QA+ERuxrHssZOswg5fSHb9DB3VXbF2cg9E2w40EfArVOEwn9birXPCiSNAv6U
         uKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091835; x=1786696635;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jEYndMHB+hzzoGm3/jN5rHUQhOLtVYWufPY6GQuzOfA=;
        b=X2ArKHLp0cr+8EDr3FIBfDndC1wGaWhAiFmyGe0VYz1bvN3xVEQ9NQD46PqE7T3PM1
         iIb6T3ZUh7aAz1aBSilkNz80gPX6q2wnENwVlzGWkLjJZ8NMU4e0HV1kyn3furLIDHGb
         KBFmoe/u/31d0SwSqsr7tG2Bhq03V5i+TG3du1eKa57VG0GjBJmyMve59JGlHQypoAHC
         n0rlo+KhS0D5P8VNl5H3MjtPeQ068nYAXCv5ckRdG9AmY5rz3usAq5uHF4tuDWRPlW7D
         vmjUoUlNzPjusa0ARsYhOEK92zgYDmMc1BfabI1ZnmM97HoQy5ORtsJimCzsuEOWJDVU
         XicA==
X-Forwarded-Encrypted: i=1; AHgh+RqhHi+223lmlFiFdvlBKgEFc+Oh6RIls3japJrAZqeO5rWPovxxDHETvzswdRkjp2Yynb4CdBQyXCCRGOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU5HCTa1dCIBO7KWRTTXDxhktyLDlTUvMpu1tpLiKZghn0wcDN
	cviG4NmObvWqnK7dT8flcJkezOEumfrE46qk+aYl19HSCfa8bcVOwPNZgzfwmWHebTk=
X-Gm-Gg: AR+sD10fWit/NmrF5lal3wH0xZvoTFkyp+n+6KVXDYZztRK+UDXGBl7wQXl4zLFzwo5
	BiQvs+JhT3tE+RBmDkqYhKYFv8iz22aoDtIPdiW1ZN2qVLBRS0YER8zL5/6zllTZ4SgpUaLTaYf
	yAmW1fhWWlWe0Ig0270856Vcb2EpqIX5w9F5H/X9YdZOVfM+cB+Pdg7/9fNRgmOOQ+9h0yeUSze
	1QkX9ZpH5D3J+HjI786YwrQAq1KxAuwK0LPaRG3Ux7y+WVUKuV5hD25ySnN93AF45I/to43ZF8d
	w6bh5Lk7DAo+FU7+vHGOKP6gIHVo4nP07mOoHwsea1Hdg4wcQYyG/JCxhUQcSCmeD6zzscBYZiw
	oN4faYr8RUyBBnpngAXIX6AXb481J2pc5Z3fUHkN3IDeA2J16QVhFV+bWcf2KYgKhtYGD9F61nv
	NXhokYr2sfVkBDsvkg49Y3moPoyIyuRXm6i8QKNZccuO7PmhngUuddvXna4K4CK6em/Jry6io=
X-Received: by 2002:a05:600c:a47:b0:499:484a:7644 with SMTP id 5b1f17b1804b1-49959e2eb00mr92663195e9.9.1786091835248;
        Fri, 07 Aug 2026 01:37:15 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 3/6] serial: 8250_aspeed_vuart: add VUART over PCI
From: Tan Siewert <tan.siewert@9elements.com>
To: =?utf-8?q?Gr=C3=A9goire_Layet?= <gregoire.layet@9elements.com>
Cc: joel@jms.id.au, andrew@codeconstruct.com.au, lkundrak@v3.sk, 
 devicetree@vger.kernel.org, gregkh@linuxfoundation.org, 
 jirislaby@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, lee@kernel.org, andrew@lunn.ch, 
 jacky_chou@aspeedtech.com, yh_chung@aspeedtech.com, ninad@linux.ibm.com, 
 anirudhsriniv@gmail.com, tan.siewert@9elements.com, 
 linux-serial@vger.kernel.org, mfd@lists.linux.dev, 
 linux-aspeed@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <84efc6b23b79e901245e9ed7f58546bef6089530.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182923.193353.14922851647951168548.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=504;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=P/41CvtTcGae/equIvztsQBGuXVGaJoauUSj4lEXoMo=;
 b=w8BqgggHC8+rKIIYkDpF4V+LQxQsLNTjAkqs8Mvxlj5omkapBkoZ7qOK3HWj+EyFPq5fEadKj
 1czd/NMPD8ADtaa6dibTAstN19JKAfgQvZMVKV0WiyJ9NIMbbW8jdIf
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:50 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Enable the VUART over PCI for the AST2600. Activate it only if the
> 'aspeed,vuart-over-pci' property flag is set on an
> 'ast2600-vuart' compatible node.
> 
> The AST2600 has 2 VUART that are usable over PCI. These are already
> defined as the VUART3 and VUART4 in the 'aspeed-g6.dtsi'.
> 
> [...]

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>
