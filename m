Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914F938F62E
	for <linux-serial@vger.kernel.org>; Fri,  3 Apr 2026 13:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775222414; cv=none; b=tAc3CIt29RHF26sg21X4HGWJ/2uzJGfjPALs5usPoPbT3rnTFXb5Oep017jstHpdEOrf0TqaXV0OjUVms6o3pxUouwgDNfDeQaQPPLPt2/CIoImlzh64GYVcWoJ1iJ1qwOGx9VoF37ybPqrXMCzrheCYDToWY3j/UHiAWa7jO2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775222414; c=relaxed/simple;
	bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ksIWNtZSt92sACKcF37zaux66vSFnsC5suWrX4e3ON5dX3XU2v4oGNYT2GC9Q6Oa/AZBgP/Ktyr/YIpxScSTxQCnxzBrSYlE5CCcwXnbgBmeh/XPpWXVuUKFnrRDScDeZjfjTjxUbLtTvuZP5c61ACYVllwzeTML5WjPIQSO06k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40efa542b8aso3581749fac.2
        for <linux-serial@vger.kernel.org>; Fri, 03 Apr 2026 06:20:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775222412; x=1775827212;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fHKEKHdPjoZhYVJRZoCAKKckDq3mCm+7VXF61UEPMbE=;
        b=LQpmZ/o6ZJ5mkUKoVHNWpxB36M2NbmXgdzR9EyxBgW+6pMCc7UbFs57d8oifwr54/9
         BZRgGP6xTbX3s5dGRjJOjLw2v8eknVPnLTB+VOaER/dP2dBDFI/RS6yH/3mW2AbmPBrC
         JPpzHcCG6PH7staFJAVn3/7MR4HES6Uam+ci6x+qaIRPuJG6D/SEeFbB5hHkWovEBgIB
         tO8qTpt1JXdjHdvYwH+WhKeyVwCBSYl7bXRQweDiyWRnrlmnxqhb2YrZb+zUbm4UFRhD
         Ae7SgfBQFztqVe5vhDZhwVFhlJP3WYMj5YNAQml1TBBHtLRmV1mBLt7zNu2QX/RwMyeI
         IeEg==
X-Forwarded-Encrypted: i=1; AJvYcCVVvEwEB9cjLwzEz+SyD90KW/zNca/3si9uKAho/ipKsLBgSqq02WSMubEMu/8Y8Uhz7gTLkdIM+Nfl4ig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL0RNOzv5NDLWwOraWfnwMZuIL4emYdsnw6ltA4BQu3c1nfZUA
	qgKYCLyqNfyNSLkGZ7YnwZqlciyl0sW0ihTFyrE4MXEDIIfoUIxaMXRFHwQ3zSJQGvGvNIonv5p
	MqjaC4H5duRgn7YYI7fnvppXzhuy8L8WWAasXdW3N1NJuT+/OBvezBaGahGM=
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ee87:0:b0:67f:aafb:ca86 with SMTP id
 006d021491bc7-6822024dee3mr1409608eaf.49.1775222412566; Fri, 03 Apr 2026
 06:20:12 -0700 (PDT)
Date: Fri, 03 Apr 2026 06:20:12 -0700
In-Reply-To: <6985ea97.050a0220.3b3015.003e.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cfbe8c.050a0220.182279.0011.GAE@google.com>
Subject: Re: [moderation] KCSAN: data-race in n_tty_flush_buffer /
 n_tty_lookahead_flow_ctrl (9)
From: syzbot <syzbot+80806cf7508e92c7cc86@syzkaller.appspotmail.com>
To: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org, 
	ilpo.jarvinen@linux.intel.com, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	osama.abdelkader@gmail.com, syzkaller-upstream-moderation@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Auto-closing this bug as obsolete.
Crashes did not happen for a while, no reproducer and no activity.
