Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1941BD02C;
	Wed, 18 Sep 2024 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671992; cv=none; b=axaJNQG2X1ABqjqlCWmaLwn4GkHuFJtVwgX3l+FjbtHVjlF+G8s9uM65ZIqDkEz5S9VK3v4TfFZo4htyKe1BXbtzlr/UQNmlI/tLzSKxcQrkT5lKle4jtLsPX+dBZw6iziLAB3PSstrg7A2AFVPykbkbBxTr9iu5zpLl5KIWlc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671992; c=relaxed/simple;
	bh=pR/ziYqo2OWSzFGu33248YUgttPGF4Xwh9xEkBoN1ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjHS8Emghzc6kIVd1TpS93qXsoACUt636yCDTDUl95bzadBLItaHJmXxpQuLw+cbJdiHxlXj9MBAwgS9AJLBEkDNI3gFMrAmxeUxnErEsS0TeZG0Er3vG1MWxLjdfoYvTMJkfSWNY9KDf/XVB+b9HWMid7NJMJl4kb77hl6RsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=NJCajW1v; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="NJCajW1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1726671988;
	bh=pR/ziYqo2OWSzFGu33248YUgttPGF4Xwh9xEkBoN1ro=;
	h=From:To:Cc:Subject:Date:From;
	b=NJCajW1vVct7Htjmf8yzFslmMHaTQtzRvtAffbf2AKWnXwMakZJNgx108JPG5PGSE
	 gzYs1H5k1wXSH4C/1RzOB466fD4Iq4tkJSlrjwLrlhN5aLuGg0S5MHQLcXY87ePCk6
	 gl5l0x1R6hpf2BQ+FvUJIrmRthLifEvDyLKorxm/GXNQk63Ppy9yr7xfDnYVNboWnZ
	 BNj0iSKtM/rxCUo2WXZzNzOnysteDAztWbaQ1KDQaGNX/vIiRO8RR2H5dep+dkw4BY
	 QKA/czAMUe+yFJtt95FBRi8FI46kCuQXWpk8hQfs0ZsPASdoef3yLSL5foxjjHoGvr
	 oc0Wic7qJSQ+Q==
Received: from trenzalore.hitronhub.home (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AB5617E35DB;
	Wed, 18 Sep 2024 17:06:27 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	kernel@collabora.com,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 0/1] dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576
Date: Wed, 18 Sep 2024 11:05:06 -0400
Message-ID: <20240918150704.1163581-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg !

I extracted this patch from the patchset in [0] as it is blocking the
following device tree patches and might have been lost in your CCs.

This is v5 of the patch and it has no changelog as it didn't change since
v1, except for the Acked-by: tags.

Regards,
Detlev.

[0]: https://lore.kernel.org/all/20240903152308.13565-1-detlev.casanova@collabora.com/

Detlev Casanova (1):
  dt-bindings: serial: snps-dw-apb-uart: Add Rockchip RK3576

 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml | 1 +
 1 file changed, 1 insertion(+)

-- 
2.46.1

