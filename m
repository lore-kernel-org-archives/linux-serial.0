Received: from harvie.cz (harvie.cz [77.87.242.242])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A27C328605
	for <linux-serial@vger.kernel.org>; Thu, 16 Oct 2025 10:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.87.242.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760609911; cv=none; b=GvqOjHvx4qeotnnduHrC6rXGSUcLUmSHVRlMtViNESlF5mJnoKpB2moLsCZIRwZKv+plXDj70k8BB2db6EgbIaZJdwr75fbQ/eDGvVx3GsRFsh95p8KW0vpog6IcRwWimT4VztW2PUEL/1k2Y6KzaqFdPsBlHUIOqMRFIMHblHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760609911; c=relaxed/simple;
	bh=agXcdvupcHtoYe4OlnCWGTdViIU+m3roIcFK4YETR7w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Snj73Rxk+jn3fNVDLKR1TI4G/8EUQRHlxMSbsDV5B+j9YZrYpb6jiYxKV8WIezHBCXVX9g44zCfmmYIwMOUGJIeOxEm+bXwJ8O0EPMXkGN3Jt1XdRZ5bPICRr7Q96Zh1m/qj4xHiYmBrRNBTXr33EzQoFa+e8adMTErDxCNQax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=77.87.242.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from anemophobia.amit.cz (unknown [31.30.84.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by harvie.cz (Postfix) with ESMTPSA id CBBAA18000D;
	Thu, 16 Oct 2025 12:18:16 +0200 (CEST)
From: Tomas Mudrunka <tomas.mudrunka@gmail.com>
To: corbet@lwn.net
Cc: bagasdotme@gmail.com,
	cengiz@kernel.wtf,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	mail@anselmschueler.com,
	tomas.mudrunka@gmail.com
Subject: Re: [PATCH] Documentation: sysrq: Remove contradicting sentence on extra /proc/sysrq-trigger characters
Date: Thu, 16 Oct 2025 12:17:58 +0200
Message-ID: <20251016101758.1441349-1-tomas.mudrunka@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <87wm4xbkim.fsf@trenco.lwn.net>
References: <87wm4xbkim.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi. I am author of that sentence and this is NACK from me.

> I'm not sure this is right - there is a warning here that additional
> characters may acquire a meaning in the future, so one should not
> develop the habit of writing them now.

As you've said... I don't see anything confusing about that.
The warning was added for a reason, because there was discussion
about some people writing extra characters in there, which might
cause issues down the line if we refactor the code in future.

> After all these years, I think
> the chances of fundamental sysrq changes are pretty small,

Actualy it is not that long since the underscore mode was added...

> but I still don't see why we would take the warning out?

Exactly. Thank you.
