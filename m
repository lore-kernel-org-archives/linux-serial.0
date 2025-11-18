Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C97730FF26;
	Tue, 18 Nov 2025 09:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457404; cv=none; b=LxFroPqh4L9h5MZyLYBTq5Hn4fYs7b4oHd3Ht8ujXvNQB43nO1+H5YsxlgKkRQQRg/UZy6F9seDs2iQScyDtLR2HfyzLeZuu1UBcvQRoDGLqO1wZrLJ4BDP4ZtBidH1BjyJ5c5I0n1TWqzr/WZKDo2BhUIPLoeKrl1D+QaHFQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457404; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pXgYkTf+v3cQO8pEN6NG2w99sG6FtJOUWMUGl1HTDJcRkeXXLqmx+Uaw2XXyHBsu0cPXLUsIt4V5xOM4C24BuDbvV//EP4WedjpRFdXwn1w6hKgaThx+AFlXQuGYl43L9tM/Kcvm0CgRtl4MlxYv55LYSTqkC6CU0Hg3oevOoJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RVFxL0wQ; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RVFxL0wQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=47
	DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=RVFxL0wQ4UVf6v5Xhe
	An74MVs06OfKWVlWXz3ih8NqPnDjb7kPrmu7ZAFKCuEQUlte+hFc/GRDKl2iZJsn
	C94CMCyle1XpOVrhOvCV+SoHCqLG1p+swhV+1bZgpc9QCiK04tJ7z5Z68vKEMcre
	hGB8cXi6s0818+0HUnf5rTc3s=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAnK0dXORxpJj0LBA--.1501S2;
	Tue, 18 Nov 2025 17:16:08 +0800 (CST)
From: "jempty.liang" <imntjempty@163.com>
To: gregkh@linuxfoundation.org
Cc: imntjempty@163.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH] ALSA: core: Fix style issues in sound/core/device.c
Date: Tue, 18 Nov 2025 09:16:06 +0000
Message-Id: <20251118091606.55919-1-imntjempty@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2025111724-equinox-bondless-c407@gregkh>
References: <2025111724-equinox-bondless-c407@gregkh>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAnK0dXORxpJj0LBA--.1501S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4Rk5r2UUUUU
X-CM-SenderInfo: hlpq3yxhps35i6rwjhhfrp/xtbBgAUKAWkcOQkJIAAAsi


