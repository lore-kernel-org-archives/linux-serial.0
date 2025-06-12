Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E19D1442F4
	for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728932; cv=none; b=bZQItOl5546p00b/WoXwoojdpo81OPlc05qWyjGoQA6RAMC9QdVyF2+lgokB1Bjjy2jcMT4Xh9WjTiPPcy3Ixz4d2OIWbUkygs8LcsPezkATqlrFVCtCZPEzUEho51p4rs+HEEDuAzaSr3TEYMcCESGavLe5JWsCvykdp8lBeMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728932; c=relaxed/simple;
	bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHfCJ95+55r3I3cWBfPefSkJXIIqlEVCqTbH7eP53vum1gZbtIBgsxZODGKhsd8aRJpuKE9wATGj8Jm6f43CN7ythnjcL/YaajLicjdv99bRxw/3Ji23npiczesAPH15UFziLURX5zIiJGwPgb3rHOPXo2xPoEY016vLgvgKyaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TOxQm9B4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TOxQm9B4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a54700a46eso732610f8f.1
        for <linux-serial@vger.kernel.org>; Thu, 12 Jun 2025 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1749728929; x=1750333729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=;
        b=TOxQm9B4TvIaCkuyDRJtrFswIlylNX6aAEzW+gdJ5QWBlZR0GsbaawblYyjFKk2ilC
         93ncN2iwue0L9jyKxvQ80ipIgprkPh2FV/3XgUoYuD25ed/oMM+xUHtnjboYmIFO0DDS
         AHrpBBnumfyhHvm2Vm6h+iod29zndm6k8Wm7TaO3fqEZngVoRkOiOASlvtcPKt9EGba0
         +2baGt9IK4z5dvpybhAHnka3NP6AiEorfbP9C+/tV5yXYwtxjtSZaqR1BVdQvDlTeyjF
         P1Mqk6lebVIvLo5Ju7qGtgdKf2RMdU3K4v2DVyYwLUVpHJJipu/CK4e2Xz4/C1lHpKx8
         40wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749728929; x=1750333729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5m7niiETefPh3jsyRBPpvjabz9C/Ks+ZOhKIPRZzytc=;
        b=nlLNZ+oc98UWGFkunUeAzrJN+VI7XezTTcWaw+ho+zR2W7MXxGBxZKKS8pX0Cq2Zuh
         dfy/3rcviqBmw+o2biC7C+SIssYDA6KVTaOvCvne9z0U8CjOXOK7txa6W4fG1EIv+m/M
         fA4d2cFSW6k7bP9IzfgE6opjpa0/uTL73SwBrH1g6W7iIG/BClWp48VzJLRu3CKE6/Q6
         H+76VpPgPw1hHa6ZBJ432HoKHZA2RwC5/O0VLRitz99fr4pIR1KFctdQpqIA0pw5PBHu
         Ih47TNyRN11R8n+jMwR9qZU6QJJtSCPa8x1Oq2G7EJko4txJNBkzNMBLHyQbzYTRv/PZ
         2gjg==
X-Forwarded-Encrypted: i=1; AJvYcCUhgBh1bvf8U3WMgD34GbqIp00u0Jrq9+h7y8vzqjpEWKnX/y71K3uQmRes4kZwpIo2Eq4FT4s2+a9+YB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw545jKC6fJphpNXBGUwxJaZs2/gQdVXhxW+pg2GrDSWEkAYx8x
	eMdEeE3q3gn1mRzVpNj8dXph8JkHqh+66NRsX+NMOI5BlRVXxvQOJk2Lb6b2LhFUqFE=
X-Gm-Gg: ASbGncukDC5hlwhWnQ/2F3oprQc53w7fJhoUhYwROMLHgb0Y+Deo3fuPjug0tc/84pV
	n0Sgnj+g6w1tMwIEgusyZQRV30Oic8YQd2Q5S+puDqb1mTg1vFoPjH3i78n6zMeDjt1hwMsvdp9
	IBZPWyv/7bvQrhwYIXqhaPHdiz8a+Au4vr3GDypqjQFun4O9WVoCGUD1dq4SlpXtDZtcA/+bdi4
	HcoXNzFGCrctCzX3D8QEOXOkpgxnEMsRuB2XCvXcy9e7y6pqywelw0GpLgSs6tbhsCqdj/NkImV
	Thw1pSUz/y0r8T0A9zt3gH5OnwLQ0C/alyUDVYlpzAedtMZpLVrkI/Ts8xaeUdJW
X-Google-Smtp-Source: AGHT+IF8zRqV5wheeGN/Jp/GL6rwWbAWoucvbBo3Q9yO7s/hldTXZgL3tDSMI9f+6V734a8pX4n7YQ==
X-Received: by 2002:a05:6000:288a:b0:3a4:f7f3:2d02 with SMTP id ffacd0b85a97d-3a558695742mr5484054f8f.17.1749728928892;
        Thu, 12 Jun 2025 04:48:48 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809d2b63sm1220811b3a.83.2025.06.12.04.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 04:48:48 -0700 (PDT)
Date: Thu, 12 Jun 2025 13:48:29 +0200
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-um@lists.infradead.org
Subject: Re: [PATCH 3/7] drivers: tty: Check CON_SUSPENDED instead of
 CON_ENABLED
Message-ID: <aEq-jS3u90XCHCSS@pathway.suse.cz>
References: <20250606-printk-cleanup-part2-v1-0-f427c743dda0@suse.com>
 <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606-printk-cleanup-part2-v1-3-f427c743dda0@suse.com>

On Fri 2025-06-06 23:53:45, Marcos Paulo de Souza wrote:
> All consoles found on for_each_console are registered, meaning that all of
> them are CON_ENABLED. The code tries to find an active console, so check if the
> console is not suspended instead.

This patch "fixes" a behavior change caused by the 1st patch. Please,
merge it into the 1st patch to avoid regressions when bisecting.

Best Regards,
Petr
