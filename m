Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501588;
	b=23HRfCNm4R8qwFpq3Bi4TWVelW87vBl9HAPA/LyTTN3Nf51L8jevYpWe7bSGw/BD3c23
	 iR422rPVAFSXjGvZ8YP/3vvj9kw32RqDHXXfJ38ptQoriaQ+cQ274vfUhH67GxNYZOGcC
	 f6yAr7GbQMWxlXg0cM/piFUN6mqYAtkIVi5zybJrVuYVTUZzmUgdwZnGNobSDENtdn6UX
	 02rbHQOgofOhBS2mQxVE7fZcLRSY58oQmGxLIcByTOALVx8chzzXYEloPKc5GjtS3fDBC
	 z7f4rDxbEB2ms7y/HLBM8S+d93KSAZkqfpibeUUibtmkUMzkGP4ZBs1jsn+BcJnCpEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501588;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
	b=rbN3ncAzifRyQYhD79N5G4ezzZA7G1QsnWjoiojog6oojjtEOm2nTwplqfuWnkFBWh+2
	 ppvowOvzgfJTRh7nNNfHjUSKSKducTEnTR/t+Gn4nNUd3TfmNRtssSoMJa+VY1Ao/eoh2
	 edw5dW4PfJ0h1f0gXOTAUvQcgi6EGA+EiVpud+Yfu1CYwHz6L5VUIACnxFAhNx3dcp8yU
	 xxw5s2VnaTnv+jk5C+aTatEDjRBGo7MTaqZajhnmqG6GgWG4DT0YJ4tF3njBJfrLCwmEv
	 Ciu/aiduTKWCpRYNyGIMiSc8mvcuIOnUQJSoZb5mqoS+8CXtxGBEs+aKTuFtzGeiG4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aw2NmU5m;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876C1606A322
	for <linux-serial@vger.kernel.org>; Tue, 24 Nov 2026 06:26:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 876C1606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aw2NmU5m
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-386c336eab8so282883eec.0
        for <linux-serial@vger.kernel.org>; Mon, 23 Nov 2026 22:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501587; x=1796106387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
        b=aw2NmU5mXIfml8zWv2yXkgGBsdqu0t1jHUU7WofPUO5XM93i9Id2hMdudHcF3xP4Bt
         gndhdLLj6iSmZdDlUp8knzGn+AjdVC04G8TCXIkouk7gAtkgCiqZjbo9rb7A+4YpLG9i
         DTFhf1W20CWS11DtXdXNq2spKqNYuLnRGnvSO8k3QBpTskFPW+4BL4gYYq/jVZut+zKY
         cabPckCi3C55CjRPgcVnzV+du220fYI7mjU3ydGU0p741gRVqGFIapvLGQURFOOfv3o2
         4906pe2WYq0QGwkqb83H1VMVThVX/wRgSWBrTpCk8CI/c7B1BGVD2WNXvBPsmK2Kc3jr
         bIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501587; x=1796106387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k13cl8AnOgXOYxh9rMCZd+VqMKK57TsIjB6ASgYtOw4=;
        b=08/fSZMJW4aIzNJ93BqNPZp2l4NxDmR558kOnfLowTD26nBlbV83hLusPKIMRSAQfd
         cQvKMcdDYUmbJFD0gLBthngZ3imKsrkUOsM4MQXdgSoptVNteQYwXXFWrXSKyrflYRBR
         EQlb7fUGDmqIFhNAzCwoN7dXKAj+dJOetF7ij3WinEy/n2SwJYojbIROv+DHb4DDiIy9
         HYBJ6beYZryVSq/eEUWNFwzVPH6vwxps7b4bcoWah5E3ifhvRYnnLcU/L+bxYHk4O4pw
         3VXbw0ShbNqcQl/jvZ+zcYeMLqCr7OOs08Gowg0+f+pSPJatkBWHQ4WRbYu1OXB1oOnP
         moNA==
X-Forwarded-Encrypted: i=1; AL+hErHDj+fTeNG8pkO9HhorMXTQWuTsuv42h4KtuVaXg5vv1B3p8BqvY3fblMSWjj1Nfud7ShZU9va1a/wfngo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+oC0PljeJh52KLvKLCRzHNdeLkH8VrGoV6yhHDId1ClFz/v4UZ
	th0IVWpXvmwtnqeGDNFuZDJSAVy42VGrtschujwaks1n1MUyWAmiU9M2
X-Gm-Gg: AZFdTZdcy2K2QxJwITS2fxIUH72d5INwCRxW2Ag4KKDbJbUJYiSEdjybsfHx7xwWy97
	ViDebf/kMZdsZwTOIAb31EOVGgOWIfYsd+KXh0zbAGecOQKXvdHZJCPvMiKxMJq0Q4ux7sVCmRr
	Qh5S/4qlQ+dXfV3gJ/qz+r89XZMFoiE3eWVBeTUH5riBv8Fd0oAEhPutThPmY0vnu61lBtazFN3
	vxKcJpk703cXdT4voZG1ratj/8N3iQJqCUBzR1giw/9tObUYnpDbnka3QjwYJ0d3O8qlzvdbU3Y
	mvo4CUcUAYI0BBi5Mcmooq11B0fBgMzdME5p1U4xUK0g34AqrLqm6jDonkqD5TfzjbPpXR8FG75
	knhwBwdk5vPRECxV7ANNq95YCVcNouLwtN1/LRK1n0XAUVUSpBF02TQILitylBSMJ5TjBnvZoVO
	/Dd399K3w1aoKQkGWFOIHvhkhrGWF2MUM5UZv9JdoAPwHPEqmi2NZ9HjgWa2D9NJ8+Vf8NhKfNp
	5dAHLizehYdMCwG88C/JIPj4FZ1LAtKKTA//M81EcnrI65wwY9dGOxOGDJMlGFEPSfaL098HULr
	HbbY1INY16npKR+YC4/6c14KlZxhekp37SHIeiay4IrxMupsV6An6ueVjg3FydcyakTrdCuJ
X-Received: by 2002:a05:693c:880c:20b0:386:ab85:a011 with SMTP id 5a478bee46e88-386ab85a718mr6427409eec.27.1795501586545;
        Mon, 23 Nov 2026 22:26:26 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:ee3b:b892:771b:3bc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm72739389eec.3.2026.11.23.22.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 22:26:25 -0800 (PST)
Date: Mon, 23 Nov 2026 22:26:22 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Alexander Letuchiy <asalde.le1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Sean Wang <sean.wang@mediatek.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mattijs Korpershoek <mkorpershoek@kernel.org>, Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-serial@vger.kernel.org, 
	linux-input@vger.kernel.org, phone-devel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: input: mediatek,mt6779-keypad: Add
 compatible for MT6895
Message-ID: <awUuAzGu3ZoADKyB@google.com>
References: <20261123-initial-mt6895-v3-0-95c46597e63d@gmail.com>
 <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123-initial-mt6895-v3-4-95c46597e63d@gmail.com>

On Mon, Nov 23, 2026 at 02:18:37PM +0300, Alexander Letuchiy wrote:
> Add a compatible string for the keypad of the MediaTek MT6895 (Dimensity
> 8000/8100) SoC. Its registers are the same as on MT6779, so it works
> with the existing driver through the mediatek,mt6779-keypad fallback.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Alexander Letuchiy <asalde.le1@gmail.com>

Applied, thank you.

-- 
Dmitry
