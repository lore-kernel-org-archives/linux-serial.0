Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566281;
	b=rHAMEbVQwk5k+38OcEG9McBK9pqhL1d8qZlRxOiJKddbvEsPLnzEyco50y8AilHASMsC
	 EZUYMSP3XmoI47AfUIpVId4SfNkFl9c62B/r09W5POLyDt2cfnUABB3hItAuaPoto2SyL
	 ylj4YSF7uYc2SHDQXywC/2kjawHhlcOS0TXXvEiyiOPfEMJRWAc5LQ/iTeL/0legUe+FV
	 S90MI0LtAQWSJvAFqOtg8pCKDoYzTkIVsi1i1/G6PU/yNUxklBoGt+BWhNoWUVIEWSRL7
	 4JA8HnN37utC4doICu7wmtUKNvhEJtwFoFqBeVRE6VZlHZL8QspbjDqUbT742xHjNkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566281;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=fhZ0AjN4LLnxjR2ysNPhKH+snOYNUTJM4w/Im8m81Pg=;
	b=QvlB4IO3ke5ID6BHmXH3ITkzJV3rWjnnQaCMQK2g/dKxuKyI7kvc2vJMh6t2qGANqWag
	 zU+Qdi9FzxMiNWMJTZwEI0v27ma0WuYMydQJNQcfdF0NkFkgmDrDDqi/Q6ind+P9a04bL
	 dae16uIaL7+1iPtcM4qIsThAX1ucutDvy1s8eOBv4P5Y66jDtJ2T1+C20XvgBesYNF7c4
	 e5Siavrr4Nx/cxGHSYGzKdaCFumC44BywZ1az4d+GRC1llqP9Y9BtU44a/xD1eMrFzT5E
	 3M4lvhSiX48eaRFRlj9fxmuuLxi7bLfqIAfyLAW0gs8aSLGPql+IsstoHuTbDX1Ih1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=aIfW2oKm;
	arc=none smtp.remote-ip=111.22.67.151
Received: from cmccmta8.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2B606A882;
	Fri, 13 Nov 2026 10:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71A2B606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=aIfW2oKm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=aIfW2oKm7KSso4an/zDgwxk3sz50y8JadrlG4QrySFAvp1wkpzZp8++jVtoKX7Ga+R73m0uaIuPY/
	 KC0ko5L4+IW2xaFe13S/tKafGdHuQ51N1CcuVeWxlobbGvKbmRH3rqVg1LgBzWOV5iy0J/i/VFzPl6
	 73pY999FJVGaR8CI=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee26af6e884e15-27def;
	Fri, 13 Nov 2026 18:37:57 +0800 (CST)
X-RM-TRANSID:2ee26af6e884e15-27def
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from DESKTOP-3K8GUTQ (unknown[223.108.79.98])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26af6e8830b2-22ad4;
	Fri, 13 Nov 2026 18:37:57 +0800 (CST)
X-RM-TRANSID:2ee26af6e8830b2-22ad4
From: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Xiangwu Lai <laixiangwu@cmss.chinamobile.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: sc16is7xx: Fix clock leak on invalid clock frequency
Date: Fri, 13 Nov 2026 18:37:54 +0800
Message-ID: <20261113103755.2126-1-laixiangwu@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <20261112163916.00d07adafb3caad1d83a2d1c@hugovil.com>
References: <20261112163916.00d07adafb3caad1d83a2d1c@hugovil.com>
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Post: <mailto:linux-serial@vger.kernel.org>
List-Help: <mailto:linux-serial+help@vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-serial+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hugo,

thanks for the review!

Agreed, devm_clk_get_optional_enabled() is the cleaner way: the clock
reference is dropped and the clock disabled automatically on probe
failure and on remove, so the manual management, the out_clk label
and the clk_disable_unprepare() in sc16is7xx_remove() all go away,
and the -EINVAL path keeps its original plain return.

I've reworked the patch accordingly; v2 follows shortly.

Best regards,
Xiangwu Lai


