Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1205636F90C
	for <linux-serial@vger.kernel.org>; Fri,  7 Aug 2026 08:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786091836; cv=none; b=GQmbhlmatJBOSsy3G4F8QRF4zv8y1YuILrdwad+9cy8x2eRp+XxAX4VE0syOut54aQlIFumvJENSb3P3ROboBfcc2TQnR9hCbqCJvNw26pny+oWu+Wv4Vlv682p7MKsnWZOBuR+XHOwfd+mkFLqAKN1yDjdWdJXNAouz0GEYqu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786091836; c=relaxed/simple;
	bh=GGZJlZzLfev4HdzTInv04JY3/Vaa6A3FvI60xmArBaQ=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=mISRRrzfNVe8/zMI1LggFMJKxJO5I2l2qcZQtZcRAENF6/cUnIpuF+xLnhXm2hxjMZifMZdlLDLT1g2++XeIDL9En8bqVH/GNon+2Q5OK8T7dfNXAMsoshSp5qYda3dN/0CtqoDRTDNJP+q18fjgCaLWii0yalKPK7vlSx0AhBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=Q89dvWmz; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="Q89dvWmz"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4980dc26022so30272495e9.1
        for <linux-serial@vger.kernel.org>; Fri, 07 Aug 2026 01:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1786091833; x=1786696633; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0Aa0XOZmSfIfd7MTfSKuapoTZ1eZa+JY5dctKtdAPzg=;
        b=Q89dvWmz3akmtDZLnPlqowGtANi6W7q87E24PVIO0bJjkxo/i/G7oGWs1twf8apMZc
         A2yMuxgDSFSm4OGhj2Rz5EWmtCt0DxsUDf5PGrhRlwjD6a+oyFM6BwTTx+lkjWk6Hdhu
         W2NV9icGts+YXuNTf8TMbJ2Pif/EhUu6eikphdUyvkLaytjHGTTuTXGb0EUWiKvfCBch
         Xjw8wq66FPLFfixf9EtbQY4X5cyPPPXeQH8S0t/XqxKVjMsoOsR62o0J0HR0nDGCJVMQ
         5kjG1mBaJBeYKqh+axE4/ESUQ0Yx3tgqkPt8R8tdIYPWJusPTsaewpIzFb/TLlWd0i5P
         +G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786091833; x=1786696633;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Aa0XOZmSfIfd7MTfSKuapoTZ1eZa+JY5dctKtdAPzg=;
        b=MTYknU2Vv1VKQ13ILR0o2BmwhOnvTB/91X7tbqnMp8ZLANWYc+qByHCkLfT4xEv+Ub
         lpWsHtOHvTr+28BudsVZNjXQGCWkrFOA6zkm7WQnzPso4tTVtIvfu/boHeuQXtGgV4lw
         zeuQGA/GJaxm7U0HEYfSq5AnNZP71mGiDKIBzzNWd+e/rdiqRXDeWInYFGgUlLhI9XEl
         suq1U7oFW7W/adT42npuG4s4MesDSFFL144HRtTp5VHs5u+J1BGn0EcNw/7FukBartZu
         vhXER5PXsPjFKsoa2eSmPS1iyLhb4JiVMhuRHkZczbUB1cmHhn6oavou3u8lQNfwioVC
         68UA==
X-Forwarded-Encrypted: i=1; AHgh+RoSaHaLyT5TPZPc47woyNdJ1vRSkFq32h0cwWyBf46GD0hp5hvPRtzGHakz0oRZWAb0N8Mx0FyKicmMJAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEQSCvIOE9ur1uUHb4nNkwaImbB0KoaRdgY40X93PFZkQGAlh
	bcrxMghXiwWeZ944lV2RZ567wzQbKnW2kTWbI9Bm4csv1bacjoIihVT/tAR3YBAYc7Y=
X-Gm-Gg: AR+sD13XW/xE76YJWx8uW70kcnR0I5s3/X7zVz69TAprom3zluNRtt7ifxbqZ8ziZAJ
	FTmCTXfBdpVxMk6UBHS9LDDlvzUZ3HZxDdVWdOIaYTHBkqWYdD8BZZ2XHwZs7CQO1Jz1A6iy6Ab
	aN8AfyVH+l8SPQ1GGYiTk8nLwb89dVISdt2Kktzx2z/7WGTSlHU1yKa3pecNZMpFzdEZ4nHXCqA
	5sVogAzShai6CsQ0fSPWjBlYZp/iezHoFBDqkR7V3D+JRVIKRqLOXVk1PlQRyy43wb8dvUGSEuk
	dIly1lzIJfivN2BsqLoUoSTYm9rahCybdXNrpuQTavCFc8P30LQRYbmZxC8M1keFeH4ekKUywOT
	ejphgyoEpjrsFmKkcD1rTl0A4Lg/oZvRBvC3VfwQusuRRwnC4HLWrsefHkjpux0UpFR7m6/XyWb
	abYiWeTzGOLWdTKM1YKHhl/P/bMU8tLM3BqGg3vkbHer/w2CHcCGGdsK+2aUOEP26qOKeeZ5U=
X-Received: by 2002:a05:600c:19cd:b0:498:28b:1045 with SMTP id 5b1f17b1804b1-4994e793f63mr257933615e9.3.1786091833285;
        Fri, 07 Aug 2026 01:37:13 -0700 (PDT)
Received: from [172.20.10.3] ([2a01:599:843:2744:7f5d:3df0:76c1:3705])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9e7171sm17795195e9.1.2026.08.07.01.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 01:37:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 2/6] serial: 8250_aspeed_vuart: add
 aspeed,ast2600-vuart compatible string
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
In-Reply-To: <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
References: <cover.1785932211.git.gregoire.layet@9elements.com>
 <56aa0a5e26ea76e4f9a27ed059d2b05bec9cffa5.1785932211.git.gregoire.layet@9elements.com>
Date: Fri, 07 Aug 2026 10:37:09 +0200
Message-Id: <178609182922.193353.8621406142541186098.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786091831; l=299;
 i=tan.siewert@9elements.com; s=20260527; h=from:subject:message-id;
 bh=GGZJlZzLfev4HdzTInv04JY3/Vaa6A3FvI60xmArBaQ=;
 b=HyICfGSOOmuh66kJTlxZqHYzoimh8x1WZTAAHnZ2sbtvqD6Bz0e7JwNlt5sEHOPp9XSolfUBZ
 4LtUL1zC+S6AO+F0anHYOAXIWc3YKWwmxlWPBV3bzebGcSeZmzvR0I6
X-Developer-Key: i=tan.siewert@9elements.com; a=ed25519;
 pk=ORQd/zQf+LsAvJGXP1CjQwVO6t6iEOGq/eGUsmRVTG4=

On Wed, 05 Aug 2026 14:19:49 +0200, Grégoire Layet <gregoire.layet@9elements.com> wrote:
> Make the driver compatible with the ast2600-vuart.
> Enable specific configuration for the AST2600.

Reviewed-by: Tan Siewert <tan.siewert@9elements.com>

-- 
Tan Siewert <tan.siewert@9elements.com>
